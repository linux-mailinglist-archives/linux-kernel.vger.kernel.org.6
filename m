Return-Path: <linux-kernel+bounces-410254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014049CD6EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C71F21577
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17EB188734;
	Fri, 15 Nov 2024 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACr0ydcQ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBF188722
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651004; cv=none; b=UVJeYbhV1tiiojhENVOa8Jg/JC9aZHJ2cCnGx//l/Aw3tLMEwGIn0OCnaKf5n8RNk8xPGYNPnFylYwK3qxJcXU3iWJzx5asTiPodru2INCptLofN5gMrhN/iyY/BEY/b6pRanvg9PSMC2T1XjKgNGei9/EiawGnnZSlmPSBENnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651004; c=relaxed/simple;
	bh=4Js0j3dEAXVPgmPNSWcoJsDJFN6YRI9vWNB59uQKGHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P35DprTVrvkO/YrOWh23Ql2oSh4meVhr3hRznX/Ikhy1TXguXddq/llq0zEhSEXJtu17Sa3TOwQcSWRVFgP71RceE8TdMDZ9J9gKPc8xej+OgipTtwCCtggSDmL6B9ZZvOHFCyJKfIIps2U+VLjmZVBr7YdyLlW2IEA8QEKUi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACr0ydcQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2113da91b53so10919515ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731651002; x=1732255802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfiS9F6Hcq/jOnOhJuAuLR9CMW5tSMbCI2yp2GqSd5k=;
        b=ACr0ydcQN2jH20BOhxmFV5E5w5m46tQ0R90RQB59oAwPFCk3LHcUe3JjKp4Yvp/lV/
         wHAC5CiBu2SoIT7BS7VQMHdr/5R8RJomdoQT8O62NWRNnFJ6afiBpq6qpL8Q+Cc46oxS
         PVQcX/29u3BR9UXUil9pJBuITPww6BksxP32w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651002; x=1732255802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfiS9F6Hcq/jOnOhJuAuLR9CMW5tSMbCI2yp2GqSd5k=;
        b=wi+Dg1F8DIRlqBFZQq8B3ji/jDZ4xs6UvDFtKoSE626pEMdWFXx1TIX+UmVb0BMFZb
         MB1fMPQCDF9WcbrqcOBCBPlxuTJN+TfuAomY1BD1eeXZ1YiXq7Q/T+2OLVOegb+wjeP6
         VWC5Cd5v5rgIJlTMF4LlwarNHTqM90sBjVQ1xTCdkBLaiU939rbqSVhnmsuaUx8HPNa0
         fXs7Ou10M1ouriPNJTag1JWB9IpFX2m0B41STFtniZ2Smbq9cKjY0vid5CrYwUcY8IAa
         hChbytAWn+Y4SfcLdOXvvR9ZjmhUZ48MeNsRp2MGBUjr/IGbdW+4va2GT+GtM5R2/X1m
         iIcA==
X-Forwarded-Encrypted: i=1; AJvYcCWz8lQh6Zn6PD8/3L5TyxnycMfEaP+cA7xc1SyXcogYJyZ4myCRsnBnJFoePcOHDSP/GsW4QKy/fHCXA5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsR5FOdFej8VrjR/J9vdCf3MwLF0Sqc1GcJ8LqT5r8E48tmxk
	w9mzF8hqR7j8Pyr3V6mmC2HPzvAfu27ZT3MFmEZ+ct3cZxSScZrx3CM4Ne1X5A==
X-Google-Smtp-Source: AGHT+IG3MgzXr+sGffv4+81XM+WNGMDpl8O4NITOvbxUBE45iPRqhS4W1V0XRk1A0H8HYEiWMnQR3w==
X-Received: by 2002:a17:902:e54b:b0:20c:d578:d72d with SMTP id d9443c01a7336-211d0d62b4amr19545335ad.7.1731651001787;
        Thu, 14 Nov 2024 22:10:01 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:142f:6cb4:e895:7127])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-211d0dc5c94sm5721815ad.17.2024.11.14.22.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 22:10:01 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCHv2 5.15] udf: Allocate name buffer in directory iterator on heap
Date: Fri, 15 Nov 2024 15:08:48 +0900
Message-ID: <20241115060859.2453211-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 0aba4860b0d0216a1a300484ff536171894d49d8 ]

Currently we allocate name buffer in directory iterators (struct
udf_fileident_iter) on stack. These structures are relatively large
(some 360 bytes on 64-bit architectures). For udf_rename() which needs
to keep three of these structures in parallel the stack usage becomes
rather heavy - 1536 bytes in total. Allocate the name buffer in the
iterator from heap to avoid excessive stack usage.

Link: https://lore.kernel.org/all/202212200558.lK9x1KW0-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[ senozhatsky: explicitly include slab.h to address build
  failure reported by sashal@ ]
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 fs/udf/directory.c | 24 ++++++++++++++++--------
 fs/udf/udfdecl.h   |  2 +-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index e97ffae07833..a30898debdd1 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/crc-itu-t.h>
 #include <linux/iversion.h>
+#include <linux/slab.h>
 
 static int udf_verify_fi(struct udf_fileident_iter *iter)
 {
@@ -248,9 +249,14 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 	iter->elen = 0;
 	iter->epos.bh = NULL;
 	iter->name = NULL;
+	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL);
+	if (!iter->namebuf)
+		return -ENOMEM;
 
-	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
-		return udf_copy_fi(iter);
+	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
+		err = udf_copy_fi(iter);
+		goto out;
+	}
 
 	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
 		       &iter->eloc, &iter->elen, &iter->loffset) !=
@@ -260,17 +266,17 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 		udf_err(dir->i_sb,
 			"position %llu not allocated in directory (ino %lu)\n",
 			(unsigned long long)pos, dir->i_ino);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto out;
 	}
 	err = udf_fiiter_load_bhs(iter);
 	if (err < 0)
-		return err;
+		goto out;
 	err = udf_copy_fi(iter);
-	if (err < 0) {
+out:
+	if (err < 0)
 		udf_fiiter_release(iter);
-		return err;
-	}
-	return 0;
+	return err;
 }
 
 int udf_fiiter_advance(struct udf_fileident_iter *iter)
@@ -307,6 +313,8 @@ void udf_fiiter_release(struct udf_fileident_iter *iter)
 	brelse(iter->bh[0]);
 	brelse(iter->bh[1]);
 	iter->bh[0] = iter->bh[1] = NULL;
+	kfree(iter->namebuf);
+	iter->namebuf = NULL;
 }
 
 static void udf_copy_to_bufs(void *buf1, int len1, void *buf2, int len2,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index f764b4d15094..d35aa42bb577 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -99,7 +99,7 @@ struct udf_fileident_iter {
 	struct extent_position epos;	/* Position after the above extent */
 	struct fileIdentDesc fi;	/* Copied directory entry */
 	uint8_t *name;			/* Pointer to entry name */
-	uint8_t namebuf[UDF_NAME_LEN_CS0]; /* Storage for entry name in case
+	uint8_t *namebuf;		/* Storage for entry name in case
 					 * the name is split between two blocks
 					 */
 };
-- 
2.47.0.338.g60cca15819-goog


