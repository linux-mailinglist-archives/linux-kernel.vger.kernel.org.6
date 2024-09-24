Return-Path: <linux-kernel+bounces-337701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A935984DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95B81F216D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98913212A;
	Tue, 24 Sep 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WbAkfxK3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E6146A6C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217107; cv=none; b=gxyuCe5QgW4h6W2qv3Bm1sTe6aPR/twWFMpRlsyiMp8UGjiMhlBs1hDgBdnOaNQscti8PKoe4x8IMqmRTsQq1F0qMZVEmsUvfghDrYpzHuP7d+TSlXTtLyQtXXwrzVrgBUXjXWA3F3MxXglxVCTX1DJ85oJ07Iv4s4KqKO1tQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217107; c=relaxed/simple;
	bh=Rdr8TSS4Iwh4qeHM/cdtAjEt19818xzhxC0cUa9WajM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuILp44QP40Zt1gYzBom11MWf5hR+niFrZuQpdIxVjABO3YjYbGmABqo5m9sGHaBErVvnsU209+/GSb9BBp+ZKS++SYHfqA+jl61+je64y/hXfx/w1/Yo8O5cxtshuH/+ZfsW4u3y5Jy8c2Tin2JOibeqB0+xWdK4e5XCQqOt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WbAkfxK3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2068a7c9286so60710755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727217105; x=1727821905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/a9bPAvhWH1p+W4Rny/nJHlIlCLE5pbW2+6lAK0+Ac=;
        b=WbAkfxK3M/2mL9ZytmTGAA+ENxqwl12Qx+BU5mhqM3q1SZGziguhngR7mxrhMRHWIy
         TNPFg4G4xW25bfz/d/5ojt9WbcnBHnUMQSc5CgvhrWz7f8e7swPC63d7gob90oDsUGVs
         hCNCZ1YxHqvgcqS+7yQ4YE028JY5JZvzev/js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727217105; x=1727821905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/a9bPAvhWH1p+W4Rny/nJHlIlCLE5pbW2+6lAK0+Ac=;
        b=BgZDU/HjpMsaaCdUpCkzIaSy2GNlx84g/m7V/Kib9cutNkHqZyvT0pCDYuRQAhyJbs
         kNx/gyP4vMp2NS2q7U6h01ysGm2FmnpX+7oYu3t0RHAnJLuwbLWspHOonTQW09y25+Cr
         xsP7JnNG4xXVf0k5z1BKfb3E6tsOhspvFQMqKaD9G7ccp/w4gp3GLw7qAVufY5bzaY/G
         R7h3xizP0vENKEQcYJsqc7d9A1lLfeLUk4WbsOYWvn6CnF9Vysj1xarb68anbUNaMZK8
         wVNuXeckxODti47bECg0aZguftUkREDqebDxZTEnQ5v+Lpl0dbpDXJPiAszzMr3w6/qr
         XqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX5x/orLEHgVJQLaHRkUZspqcfrfcE6NDNbEpSWfi0IFnNo/OfKa0v3KlC1dQNxVpmsqdKlykZhMmV+CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG35m5IPEIVS/7vAO+TFYF5JzOXSzrx1u9RIOcuQ2AthjTUMDd
	yHutyPaTE/JlDkEQ+PNPLcV7dNW4x51pPNn35UYMaoCRWt1eaOTyQpxuNbOeGQ==
X-Google-Smtp-Source: AGHT+IF8SSjtBFQlNG11G5nx50eg/UleICLsgfYflGSN4VqeE89GIoYrg1vgyL58OHXGaWKQPdpT+Q==
X-Received: by 2002:a17:903:124e:b0:207:3a4a:de43 with SMTP id d9443c01a7336-20afc48668dmr9687965ad.34.1727217104795;
        Tue, 24 Sep 2024 15:31:44 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af185471asm14234215ad.257.2024.09.24.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:31:43 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: leah.rumancik@gmail.com,
	jwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	lei lu <llfamsec@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH] xfs: don't walk off the end of a directory data block
Date: Tue, 24 Sep 2024 15:29:55 -0700
Message-Id: <20240924222955.346976-3-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924222955.346976-1-kuntal.nayak@broadcom.com>
References: <20240924222955.346976-1-kuntal.nayak@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lei lu <llfamsec@gmail.com>

[ Upstream commit 0c7fcdb6d06cdf8b19b57c17605215b06afa864a ]

This adds sanity checks for xfs_dir2_data_unused and xfs_dir2_data_entry
to make sure don't stray beyond valid memory region. Before patching, the
loop simply checks that the start offset of the dup and dep is within the
range. So in a crafted image, if last entry is xfs_dir2_data_unused, we
can change dup->length to dup->length-1 and leave 1 byte of space. In the
next traversal, this space will be considered as dup or dep. We may
encounter an out of bound read when accessing the fixed members.

In the patch, we make sure that the remaining bytes large enough to hold
an unused entry before accessing xfs_dir2_data_unused and
xfs_dir2_data_unused is XFS_DIR2_DATA_ALIGN byte aligned. We also make
sure that the remaining bytes large enough to hold a dirent with a
single-byte name before accessing xfs_dir2_data_entry.

Signed-off-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 fs/xfs/libxfs/xfs_dir2_data.c | 31 ++++++++++++++++++++++++++-----
 fs/xfs/libxfs/xfs_dir2_priv.h |  7 +++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_dir2_data.c b/fs/xfs/libxfs/xfs_dir2_data.c
index e67fa086f..72e4c3678 100644
--- a/fs/xfs/libxfs/xfs_dir2_data.c
+++ b/fs/xfs/libxfs/xfs_dir2_data.c
@@ -177,6 +177,14 @@ __xfs_dir3_data_check(
 	while (offset < end) {
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + offset;
 		struct xfs_dir2_data_entry	*dep = bp->b_addr + offset;
+		unsigned int	reclen;
+
+		/*
+		 * Are the remaining bytes large enough to hold an
+		 * unused entry?
+		 */
+		if (offset > end - xfs_dir2_data_unusedsize(1))
+			return __this_address;
 
 		/*
 		 * If it's unused, look for the space in the bestfree table.
@@ -186,9 +194,13 @@ __xfs_dir3_data_check(
 		if (be16_to_cpu(dup->freetag) == XFS_DIR2_DATA_FREE_TAG) {
 			xfs_failaddr_t	fa;
 
+			reclen = xfs_dir2_data_unusedsize(
+					be16_to_cpu(dup->length));
 			if (lastfree != 0)
 				return __this_address;
-			if (offset + be16_to_cpu(dup->length) > end)
+			if (be16_to_cpu(dup->length) != reclen)
+				return __this_address;
+			if (offset + reclen > end)
 				return __this_address;
 			if (be16_to_cpu(*xfs_dir2_data_unused_tag_p(dup)) !=
 			    offset)
@@ -206,10 +218,18 @@ __xfs_dir3_data_check(
 				    be16_to_cpu(bf[2].length))
 					return __this_address;
 			}
-			offset += be16_to_cpu(dup->length);
+			offset += reclen;
 			lastfree = 1;
 			continue;
 		}
+
+		/*
+		 * This is not an unused entry. Are the remaining bytes
+		 * large enough for a dirent with a single-byte name?
+		 */
+		if (offset > end - xfs_dir2_data_entsize(mp, 1))
+			return __this_address;
+
 		/*
 		 * It's a real entry.  Validate the fields.
 		 * If this is a block directory then make sure it's
@@ -218,9 +238,10 @@ __xfs_dir3_data_check(
 		 */
 		if (dep->namelen == 0)
 			return __this_address;
-		if (!xfs_verify_dir_ino(mp, be64_to_cpu(dep->inumber)))
+		reclen = xfs_dir2_data_entsize(mp, dep->namelen);
+		if (offset + reclen > end)
 			return __this_address;
-		if (offset + xfs_dir2_data_entsize(mp, dep->namelen) > end)
+		if (!xfs_verify_dir_ino(mp, be64_to_cpu(dep->inumber)))
 			return __this_address;
 		if (be16_to_cpu(*xfs_dir2_data_entry_tag_p(mp, dep)) != offset)
 			return __this_address;
@@ -244,7 +265,7 @@ __xfs_dir3_data_check(
 			if (i >= be32_to_cpu(btp->count))
 				return __this_address;
 		}
-		offset += xfs_dir2_data_entsize(mp, dep->namelen);
+		offset += reclen;
 	}
 	/*
 	 * Need to have seen all the entries and all the bestfree slots.
diff --git a/fs/xfs/libxfs/xfs_dir2_priv.h b/fs/xfs/libxfs/xfs_dir2_priv.h
index 44c6a77cb..e46063cde 100644
--- a/fs/xfs/libxfs/xfs_dir2_priv.h
+++ b/fs/xfs/libxfs/xfs_dir2_priv.h
@@ -186,6 +186,13 @@ void xfs_dir2_sf_put_ftype(struct xfs_mount *mp,
 extern int xfs_readdir(struct xfs_trans *tp, struct xfs_inode *dp,
 		       struct dir_context *ctx, size_t bufsize);
 
+static inline unsigned int
+xfs_dir2_data_unusedsize(
+	unsigned int	len)
+{
+	return round_up(len, XFS_DIR2_DATA_ALIGN);
+}
+
 static inline unsigned int
 xfs_dir2_data_entsize(
 	struct xfs_mount	*mp,
-- 
2.39.3


