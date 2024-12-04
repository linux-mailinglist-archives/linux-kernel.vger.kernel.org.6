Return-Path: <linux-kernel+bounces-430528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FFA9E3224
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF01680C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746215F3F9;
	Wed,  4 Dec 2024 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wy5s5+5d"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6323158218
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283182; cv=none; b=oqQywm9LdNuvDIwIVxeCJNli/C47ld2/LFGeJDnzTUA97zbdD9Ei7wAbr7J0hWfiVsymowrkbV7I8io9TzGjGftEEHm/p9tv3/uU2tBygJM/2D0vHQkDj9WZzq1qc/LbzT5jOPDR6LdxBVOmJpNFlSdKZ68Bg1PN/rktbQqdxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283182; c=relaxed/simple;
	bh=V/GrvN8+N9+Lt1DYRfzrOPsts/7lPzckFMVjjKtG5Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY8F5wj0NvdveSW9dqvziF0p2ZxNKeOyl1tWa59JUo6ktnueldQ2Qt9AJTWgMUrmQ7O5Z1M5kNgdf+7yciqxvExXPv4+uZBqVJ3/U+5p4JKd0AlD21TvNyLLQD95QzSMo4R4DrqN2ThsIcPut2c4nIQZGfborBOEY2hc81I+FCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wy5s5+5d; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385df661e7fso431213f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 19:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733283179; x=1733887979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp1Qqcg1dvH5e9SyzHpweN5r/SUkOnitlXEeua4r1tk=;
        b=Wy5s5+5dNkhMO3DPHi83tZopdpvR3Y63Rnkfp9KBIGAskPJdr4dKGDlPzDkntyU5lc
         wr4urAIrKg2mdEcQt9+mtamExmdSxv1NgISBUKf43EUBsOV6vyAfqRPnw3my5aaIo7bM
         iiRuvq7ExPKZUGvtfE59MvFdiCOU319U1IBnGPwNYIvlLFU5dyjC5up7F+BtlTKOKi5L
         NFiNiROMy2wchKhR/uv2l2RDLORDwrAN9at5z/JaJGrooRGbCqvnH9dyp3YOrNiOfvF7
         irOgE/u2gLcm+ss1OwgKt55XeEqO+IB+ck3Aa3yKRykVp/ufbXNaT+WM953XeEWIuJg1
         tMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283179; x=1733887979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp1Qqcg1dvH5e9SyzHpweN5r/SUkOnitlXEeua4r1tk=;
        b=JjwMYjBa6da51zE3CwarnVgxJyNEUAhE4MuqcE9vqcP3BlF7ENUBEZiUhZCpXkn/Us
         xyoGuqS88PRFbqk4EsfVaL5/oynUIi8kXz6A/1ZFz+dHtmRsI+OsgyDGb3YSYXiWIpJL
         dDfBDO9wW/IG+qoH0D4dKoI2zQvjhKxKgOohTKiumj7XYFEHm+if0OE2l3izSjmI2u4E
         bGqeiGmK4YpHlXHEFd/8jpXAmckLen1U7A75djFDVj48NxOyZ+hCS/4PR3LZArynjSFB
         CN4OTzj/W8MoRxZHjO7MZWxxjYTaZcIrcpej1QphymlL+mt1OacCLddMgzA8y4r3IFGr
         28sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVda8Pwkjn5rT+pmHJThxX03Bc+uCl0BOfHXPHxXzezklVI5NlygCwWG3C5XkZcHcVtV25lsllk0eBCyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVOr+zBLJ9krPADmcOU9iKWPYtP/uJMwcYZMgDhpjhoJEqjku
	u1HIAdD/9jXXo2fBz0t4FZB8cK48nwIUwT408Jlvn+SqTCIOVNJZBoVIPn1g8D6r+Mc2wcAWHb5
	lT/q6+Q==
X-Gm-Gg: ASbGncv2XPC4WhqeB4wn7R6y1wKKcpnkG/DsiVdLdw6Uxwmsws2ds+/HRtuyqvqhwkF
	5DpL2FC6H8yvf0sLrp30TeCiw1S2CDyCZfC3FchoqqNrQU+aF8H+r83v/+vCKAgtPdZaU5jqrrJ
	Icm36oXLJX9D54/pyWwQaYWYWhINU2fvOCWyU7qRpmsW4CSQSpoqTLUwgPQ85ouacU3iUSFuSna
	q3f7Io0q7pqixSQZAitUJau0/YgKi9HhfWgM/9GDwpkMmt1kJY6U507+5HWeg==
X-Google-Smtp-Source: AGHT+IGrxSK7SMs30zEUVr384O062RDz8BWaLsZ1ohvJ+GDGEs2COmYERdYzpJ0KCyZv7A9tHSOkdA==
X-Received: by 2002:a5d:588f:0:b0:37d:54d0:1f18 with SMTP id ffacd0b85a97d-385fd3ea027mr1773079f8f.6.1733283179136;
        Tue, 03 Dec 2024 19:32:59 -0800 (PST)
Received: from localhost.localdomain ([114.254.72.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a04dc249sm37476025ad.203.2024.12.03.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:32:58 -0800 (PST)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev
Cc: Heming Zhao <heming.zhao@suse.com>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 2/2] ocfs2: fix the la space leak when unmounting an ocfs2 volume
Date: Wed,  4 Dec 2024 11:32:40 +0800
Message-ID: <20241204033243.8273-3-heming.zhao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204033243.8273-1-heming.zhao@suse.com>
References: <20241204033243.8273-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug has existed since the initial OCFS2 code.  The code logic in
ocfs2_sync_local_to_main() is wrong, as it ignores the last contiguous
free bits, which causes an OCFS2 volume to lose the last free clusters of
LA window on each umount command.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Fixes: 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
---
 fs/ocfs2/localalloc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 5df34561c551..8ac42ea81a17 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1002,6 +1002,25 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
+	/* clear the contiguous bits until the end boundary */
+	if (count) {
+		blkno = la_start_blk +
+			ocfs2_clusters_to_blocks(osb->sb,
+					start - count);
+
+		trace_ocfs2_sync_local_to_main_free(
+				count, start - count,
+				(unsigned long long)la_start_blk,
+				(unsigned long long)blkno);
+
+		status = ocfs2_release_clusters(handle,
+				main_bm_inode,
+				main_bm_bh, blkno,
+				count);
+		if (status < 0)
+			mlog_errno(status);
+	}
+
 bail:
 	if (status)
 		mlog_errno(status);
-- 
2.43.0


