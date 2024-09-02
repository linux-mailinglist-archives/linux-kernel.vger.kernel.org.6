Return-Path: <linux-kernel+bounces-310939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4C968315
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A611F22494
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44DD1C3F13;
	Mon,  2 Sep 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJPwqr3P"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554461C32EB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268948; cv=none; b=jaiJO9yUd7CC6w3qrB7xvD4dYWR3cBuv1LjdH5Z4byj8iF4y+Msu3a1F1csFMH1TfGMToemtoph7htmmIPCLfEUX/CCVFzPWXOuRT6empjM/DVikdXoKWANfXTDlqOZLjmnucNCR6gIX3s2CP89kpWQ4Bcd1+7DO6ETXc8Ma/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268948; c=relaxed/simple;
	bh=2o0ULimK06zWkew5dzj7e6hQxDRTLukcoM9dm+eYN1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3xslnYaGEFnIJY+pRBAsziL3JEg+y9qcgGgccF6XhtHj3084MdNhjFUtH4lJ5nz24FF5hrr8nvRDFSizDPMVhj5A30fcGzmW163/m3f2jLjQji76u4rANnitlzkXXnnT5ArdbtBshohFcvbsItY3s9tWhtoHrIkDFz5e2tcu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YJPwqr3P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2053f6b8201so16775305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725268944; x=1725873744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGC2/wr/WrQEE/BTETF77jc4B4si+qDhZdrDFSYRq0o=;
        b=YJPwqr3PBGfJwDs3VV+XnqBHTJuSFrEarjZoA+q5ZhRNdvho9rfjXcMd2eNVVCarof
         9lnIOad0PnV4xnrD/TXeKjtTBh0SROhe18uOfJMJRpdiJSFfz4seshCctz45rD3nCAgX
         1pE8GMNR/bOWUYPiQafs2HktX8NoIb/gGiVpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268944; x=1725873744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGC2/wr/WrQEE/BTETF77jc4B4si+qDhZdrDFSYRq0o=;
        b=mceZTTo3yg5I2roaj2mswKmx/9PRlZzdbvTMk/qXsuVEIookxuq+TSv73Gv8+A8Wt9
         dugz/Piy/sbjmM5dZeiVWD9M5ie0/RoDaR4G/2T6B0AZKS9Cb91fWIANiGCWUmLkNl0U
         uVnxP8qPPagSw0hxQM6hH1hRGjy4dNJrEvaPgPy64oo8uGSY1Vbv3dP/dp+0kEDui8bN
         KoQnIMA1UQHpp6KQOIoBTVRgSD2uXRh1BFpyLCvzhrPv0EHCYcmb1EIih9+QRqJqFadj
         vi5fiVHYRZhhE+d+IPmBsS/u+7iNY4BOBkrB12rPp4nBYDvWw8qicOwKbdtDvf6z+BAU
         o6VA==
X-Forwarded-Encrypted: i=1; AJvYcCV2C+ZkHYrXOLUO3fkqun//0Q3mZdUD+M+mLfvRR35TuSgXLda8CjeTt+9FoCeeX1EFxqeZMSZlly4CbGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpCPRmbQc7WysPE4g9tx6FnFw999zxi6OBBcHkR3RvuRqQNvo
	Pd8O+OTxkJcKEc+DtbQevpQFbjHcJBp230rFaEfmXGBX8iTjp+Y6flDRNu9CSuxtYy5O2qLu9iC
	nmI9B
X-Google-Smtp-Source: AGHT+IHvDWC+orccoTAH9Nz3IAZQPy84jFzwKssu8xWtUujKJAW/7Ch2F+6bGNdqKjZicYipFJdvnQ==
X-Received: by 2002:a17:903:22ce:b0:202:3a75:ec89 with SMTP id d9443c01a7336-205466f906dmr67691635ad.31.1725268943866;
        Mon, 02 Sep 2024 02:22:23 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd65esm62705985ad.77.2024.09.02.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:22:23 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	chenyuwen <yuwen.chen@xjmz.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1] f2fs: fix to truncate preallocated blocks in f2fs_file_open()
Date: Mon,  2 Sep 2024 02:22:13 -0700
Message-Id: <20240902092213.4982-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 298b1e4182d657c3e388adcc29477904e9600ed5 ]

chenyuwen reports a f2fs bug as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000011
 fscrypt_set_bio_crypt_ctx+0x78/0x1e8
 f2fs_grab_read_bio+0x78/0x208
 f2fs_submit_page_read+0x44/0x154
 f2fs_get_read_data_page+0x288/0x5f4
 f2fs_get_lock_data_page+0x60/0x190
 truncate_partial_data_page+0x108/0x4fc
 f2fs_do_truncate_blocks+0x344/0x5f0
 f2fs_truncate_blocks+0x6c/0x134
 f2fs_truncate+0xd8/0x200
 f2fs_iget+0x20c/0x5ac
 do_garbage_collect+0x5d0/0xf6c
 f2fs_gc+0x22c/0x6a4
 f2fs_disable_checkpoint+0xc8/0x310
 f2fs_fill_super+0x14bc/0x1764
 mount_bdev+0x1b4/0x21c
 f2fs_mount+0x20/0x30
 legacy_get_tree+0x50/0xbc
 vfs_get_tree+0x5c/0x1b0
 do_new_mount+0x298/0x4cc
 path_mount+0x33c/0x5fc
 __arm64_sys_mount+0xcc/0x15c
 invoke_syscall+0x60/0x150
 el0_svc_common+0xb8/0xf8
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x84
 el0t_64_sync_handler+0x88/0xec

It is because inode.i_crypt_info is not initialized during below path:
- mount
 - f2fs_fill_super
  - f2fs_disable_checkpoint
   - f2fs_gc
    - f2fs_iget
     - f2fs_truncate

So, let's relocate truncation of preallocated blocks to f2fs_file_open(),
after fscrypt_file_open().

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Reported-by: chenyuwen <yuwen.chen@xjmz.com>
Closes: https://lore.kernel.org/linux-kernel/20240517085327.1188515-1-yuwen.chen@xjmz.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/file.c  | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  8 --------
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a02c74875..2b540d878 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -788,6 +788,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_OPENED_FILE,         /* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c6fb179f9..62f2521cd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -538,6 +538,42 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	inode_lock(inode);
+	if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	if (!file_should_truncate(inode)) {
+		set_inode_flag(inode, FI_OPENED_FILE);
+		inode_unlock(inode);
+		return 0;
+	}
+
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
+
+	truncate_setsize(inode, i_size_read(inode));
+	ret = f2fs_truncate(inode);
+
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+
+	if (!ret)
+		set_inode_flag(inode, FI_OPENED_FILE);
+
+	inode_unlock(inode);
+	if (ret)
+		return ret;
+
+	file_dont_truncate(inode);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
@@ -554,7 +590,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 
 	filp->f_mode |= FMODE_NOWAIT;
 
-	return dquot_file_open(inode, filp);
+	err = dquot_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return finish_preallocate_blocks(inode);
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff4a4e92a..5b672df19 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -549,14 +549,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode) &&
-			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
-		ret = f2fs_truncate(inode);
-		if (ret)
-			goto bad_inode;
-		file_dont_truncate(inode);
-	}
-
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- 
2.39.4


