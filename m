Return-Path: <linux-kernel+bounces-439609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443469EB1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF7E166826
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2E1A9B2F;
	Tue, 10 Dec 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR8Gxcze"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240B78F44
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836117; cv=none; b=Agvo6qPc1ID2klKSO0gZF58hkiyvbv8V4elYrxQXhwJ6DXsigVT8dGp2D71vzmyoMqBl63Vl6x5hq4tvl5LC2B1dFp7AxLdZcH0VsVaOyynuJPz5RiVi5gHMkRQt/0aB2J7yMGBzkldarsSlgN94tTVR0A3ly6EpIp9+Rj2sTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836117; c=relaxed/simple;
	bh=Vgw3pRE6k8IRL1iE+VuQQRFu84FdmP9ajGorNOWkAcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hM3DHWy4yo7NDzdu7Zl2yLE1vtW06vFDZlVJW1oErxQlPUAqlN0mqp3NBG+avFIbKnbU+gqoGveX0cvl4rFJFybFfe4nfrRqj0bLNsxXuefbIMI/tgD8w+JCYYEBIRpUN0gxNJD17DJInPaayXUC8q9pJpaTmR/Oz8QqtBPyAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR8Gxcze; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166651f752so15545985ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733836115; x=1734440915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqhJ6nHHR9Y30E9gGwdpdayiTmOUSH+PiMjlvTCElLA=;
        b=nR8GxczeQw66Pz5rg5ky2tMHhmHWLLDSsRIOL5W2L2VnUnEOWu5f8PUUIh4K3HhrKC
         Xi0TcoAD/Ff+1W3aUvArCPRiiGOS2oM0/hJTclHFV21I/WcVvFxVUz1ZjI//XigZPcKi
         BOUCdG6/yHgqbPYICTB5Y8K8P9xHXJeX1Ko/9pZn73pCov5izaWqOfAWGUbwsGGBnezL
         C/CTjQ+LvEnPz3JooSEhta730k3j9igLQxci+ZUCyoXy7zVmP2jIl5Tsl0uHGEnHBGGw
         Zih/DmdNXi+I/lxDUMoDdTRS3LQcWmh5XpQMG/ICT737p+z6jWcbmDNp3DohqPbYl1q/
         QoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733836115; x=1734440915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqhJ6nHHR9Y30E9gGwdpdayiTmOUSH+PiMjlvTCElLA=;
        b=urc2NYgWlOfAVYZ8x5PMP1LNToeDAuDrGjpAB3UFwm/CDnY4j4Q/0o9Lyy+B2nyG9M
         A9XKLqRWFWhBiigMEeXFh2og5HMg/AvWg+OfTvu2mArPmog9HC6aZIZEE6+xq3Vf5jEQ
         fpzGrGenK+PU++picvbhEZxEDpzJlyBS9/CxFlVnN575O2oURu9XkqnzGDYB6H2lMHAX
         TlDKNbiWQxoUoOmekYNZe3Y5X9MXROv3XpgPTl6qRTJ5bny4fDZA9rKWYlNWjuSLMnnB
         fR/J5dVBFfGpf5CXtztW8+FmCT0lV+OX3dZviJi2VFPzvP1r8RKm+CG2KNr5zoZPntDP
         pMmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEy0TOKIHDg8+oJOAtcd53FfnhvUyr6WtY1jnnzJzZ8sNNI5w5tbNxnSKYi8X6NuHcUjtCWZrLD9GpCik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIfjSdN+gERO53fBFMpgERowr4EUuwc0kIHdGF6XxKeUspd2t
	y6P84Nd9xZaQR4ewAfeIK1yAn9F/BVmu+DalHIqIs5SycsaITfMo
X-Gm-Gg: ASbGnct3a6QQXuyuPE8YX9x5jKpFiUwA0tCh44AxoqWvi/3gWA64FT3WsPzLp6R0aJi
	MY9NBHJ+Rp+GZFZPDM1k8WaqE0HSoWzWk7SgjrDL9/IfbPhg6WSLdXB+F43F+Y1M387iQ/t6Jct
	oO7QDr+3W7NpoicgnRjgvANs0bH+U4hVdArMQpCWop0aMXJOw0JM8+USyAnfBUv1Tv41yXGtBYH
	fIq86VqJwrF/W3AcUKmE5lJmBY4W9b9uXXWAsRzZhxI2mdnltZt1MbCjIG5VHr3CTFu9gxhW8om
	HX7rTCVeR5k=
X-Google-Smtp-Source: AGHT+IGvhPSCRmaZ/2TQ5ydynFDibMaG6/MjGDL6VZJedVuhKIAl+7JtX0S+vkSF4uTM4lg+IgKlKg==
X-Received: by 2002:a17:903:184:b0:216:3e87:c9fc with SMTP id d9443c01a7336-2163e87cbfamr151457515ad.5.1733836114444;
        Tue, 10 Dec 2024 05:08:34 -0800 (PST)
Received: from localhost ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21615b1e6d6sm73132955ad.104.2024.12.10.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:08:34 -0800 (PST)
From: sunjunchao <sunjunchao2870@gmail.com>
X-Google-Original-From: sunjunchao <sunjunchao@zspace.cn>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	sunjunchao <sunjunchao@zspace.cn>,
	syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: Add a sanity check for corrupted file system.
Date: Tue, 10 Dec 2024 21:08:27 +0800
Message-Id: <20241210130827.121584-1-sunjunchao@zspace.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Recently syzbot reported a use-after-free issue[1].

The root cause of the problem is that the journal
inode recorded in this file system image is corrupted.
The value of "di->id2.i_list.l_next_free_rec" is 8193,
which is greater than the value of "di->id2.i_list.l_count" (19).

To solve this problem, an additional check should be added
during the validity check. If the check fails, an error will
be returned and the file system will be set to read-only.
Also correct the l_next_free_rec value if online check is triggered,
same as what fsck.ocfs2 does.

[1]: https://lore.kernel.org/all/67577778.050a0220.a30f1.01bc.GAE@google.com/T/

Reported-and-tested-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2313dda4dc4885c93578
Signed-off-by: sunjunchao <sunjunchao@zspace.cn>
---
 fs/ocfs2/inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 2cc5c99fe941..d3df54467d73 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1358,6 +1358,21 @@ void ocfs2_refresh_inode(struct inode *inode,
 	spin_unlock(&OCFS2_I(inode)->ip_lock);
 }
 
+static int has_extents(struct ocfs2_dinode *di)
+{
+	/* inodes flagged with other stuff in id2 */
+	if (di->i_flags & (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL |
+			   OCFS2_CHAIN_FL | OCFS2_DEALLOC_FL))
+		return 0;
+	/* i_flags doesn't indicate when id2 is a fast symlink */
+	if (S_ISLNK(di->i_mode) && di->i_size && di->i_clusters == 0)
+		return 0;
+	if (di->i_dyn_features & OCFS2_INLINE_DATA_FL)
+		return 0;
+
+	return 1;
+}
+
 int ocfs2_validate_inode_block(struct super_block *sb,
 			       struct buffer_head *bh)
 {
@@ -1386,6 +1401,15 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 
 	rc = -EINVAL;
 
+	if (has_extents(di) && le16_to_cpu(di->id2.i_list.l_next_free_rec) >
+	    le16_to_cpu(di->id2.i_list.l_count)) {
+		rc = ocfs2_error(sb, "corrupted dinode #%llu: next_free_rec is %u, count is %u\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le16_to_cpu(di->id2.i_list.l_next_free_rec),
+				 le16_to_cpu(di->id2.i_list.l_count));
+		goto bail;
+	}
+
 	if (!OCFS2_IS_VALID_DINODE(di)) {
 		rc = ocfs2_error(sb, "Invalid dinode #%llu: signature = %.*s\n",
 				 (unsigned long long)bh->b_blocknr, 7,
@@ -1483,6 +1507,16 @@ static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 		rc = -OCFS2_FILECHECK_ERR_GENERATION;
 	}
 
+	if (has_extents(di) && le16_to_cpu(di->id2.i_list.l_next_free_rec) >
+	    le16_to_cpu(di->id2.i_list.l_count)) {
+		mlog(ML_ERROR,
+		     "Filecheck: invalid dinode #%llu: l_next_free_rec is %u, l_count is %u\n",
+		     (unsigned long long)bh->b_blocknr,
+		     le16_to_cpu(di->id2.i_list.l_next_free_rec),
+		     le16_to_cpu(di->id2.i_list.l_count));
+		rc = -OCFS2_FILECHECK_ERR_FAILED;
+	}
+
 bail:
 	return rc;
 }
@@ -1547,6 +1581,16 @@ static int ocfs2_filecheck_repair_inode_block(struct super_block *sb,
 		     le32_to_cpu(di->i_fs_generation));
 	}
 
+	if (has_extents(di) && le16_to_cpu(di->id2.i_list.l_next_free_rec) >
+	    le16_to_cpu(di->id2.i_list.l_count)) {
+		di->id2.i_list.l_next_free_rec = di->id2.i_list.l_count;
+		changed = 1;
+		mlog(ML_ERROR,
+		     "Filecheck: reset dinode #%llu: l_next_free_rec to %u\n",
+		     (unsigned long long)bh->b_blocknr,
+		     le16_to_cpu(di->id2.i_list.l_next_free_rec));
+	}
+
 	if (changed || ocfs2_validate_meta_ecc(sb, bh->b_data, &di->i_check)) {
 		ocfs2_compute_meta_ecc(sb, bh->b_data, &di->i_check);
 		mark_buffer_dirty(bh);
-- 
2.39.5


