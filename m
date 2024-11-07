Return-Path: <linux-kernel+bounces-399615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69379C01A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B000283C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA891E47B6;
	Thu,  7 Nov 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlXOyZvr"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE6194A70;
	Thu,  7 Nov 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973480; cv=none; b=Ds+jLRp6tfgxQNNJ7P+K/TGtaY/TsizB2pcVu54bTcz6wk7VQo13iIqWHYfXEBd8eXGe7PFHdyAC1A/jd1QzpuNrmkBm6NqcZ23g3Fvza8dgM8w7dL+evJNA8GbXQ15bYjB7mMVvVFcbtyHKUXnbjGsycCP8IebLDgWgHD1T0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973480; c=relaxed/simple;
	bh=gHV9IguVe4/fNXzmzpXujryVT7rjBVHv1XiIwGs67K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UJHydKaCop7vkYYUsnJhQ4yKtLx0UFs4R151DvABVOHaEBPS9v81XnGRmsohGqFLnOerK3V1Qk8gRDth4+5FfH3zA7RDfCx5LP4d3PO8jVq264IJ1T1D8i6zww6NpqW1Z3o9BtOSR8kDCzhFI6tIjtQFUt+iqQgPxKknYNBX+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlXOyZvr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431ac30d379so6327625e9.1;
        Thu, 07 Nov 2024 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730973477; x=1731578277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpKqltND5M1sTSxc7zhIf0AXALdPonkygyogIkTEVY4=;
        b=PlXOyZvruKnQ98vOESG47QuMkzlJbRVK32g3BYMMZysGJFpTjFlJWlBqmYKlDkgqfk
         1JJSA0uhqoU5dqWO51//pf4heYJ7aK2ZqbvdP/lZi1Y/MVpAu2HZCoHKrLOOwi7MKSgL
         zSnGpcP5Oi57N9KTC+3121mJ+hpRE1R6PhvIHaWCxbkS1M7Q/7huL6T8ohxZKtmYPkF0
         Ac7wC1cww5VoaFsY6SAhvilcmd8Mur0YxnG57MmmWL9MdoNl/TOkZTHqNmzbR2MAmKUP
         vEHFyYErjYiAKWCsekrzcCLic+uBLiEfkg+OFlfq1bfyXaQR+Zs4IioajM9K9eNSeyBl
         LALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973477; x=1731578277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpKqltND5M1sTSxc7zhIf0AXALdPonkygyogIkTEVY4=;
        b=HO0JA8//qJ/V1PiDPndV0aAyEowSqIWW37Jn6XyWzTVO6TGoBqezB1nE38XZ5dC4D/
         6inX2ou+46g1UYSZEu/+upQIh/X0aNBXiT100i0f5xG380TpVPilYRUgn6c+QjPq2oJO
         rZ6Hu/yZq5FEw5p+VkU9C48VhZfSuxz0CaQgHKnG8jMqPaOH6n05koR6RHkliVYm5ed3
         AWo84XlvkifXPUY5rqDAZg+m1cPYYbR0KaRK4dZnyDgeQ9D5sXJg4+jpvWwBx/sCSDwR
         zCT85cqtiA9ag5cAuxTTa5WQx+PYCRjcAZI7Z1P5YODxxqsCZ3ao6phvS8HK/kwupTOF
         SGvw==
X-Forwarded-Encrypted: i=1; AJvYcCXw9x1XSsKvB73rjPvF90PSqTM8UCrJ9hIrrTOeJXQS4riVtOoqDTz2Bgy0ZUfgb7WG9F6nIVUwRy1xatw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1AUcbqgKCbB6+9JQ0suPDSaVbxu3NiFKphRlfnU04tVgK7jo
	FeSXEoo5fmS7A/ajlvW/50AKTxOx0C00rLb1LejtQA9WMPBy6vDK
X-Google-Smtp-Source: AGHT+IGzLToOEcix7DkuYcrqXxDDjq6bxBUxopWjxkVCGQdAefWYR0OGNd28kso8FNdruwrZQL4QuA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr374619435e9.17.1730973477180;
        Thu, 07 Nov 2024 01:57:57 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97ce0fsm1248509f8f.33.2024.11.07.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 01:57:56 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] fs/9p: replace functions v9fs_cache_{register|unregister} with direct calls
Date: Thu,  7 Nov 2024 09:57:56 +0000
Message-Id: <20241107095756.10261-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The helper functions v9fs_cache_register and v9fs_cache_unregister are
trivial helper functions that don't offer any extra functionality and
are unncessary. Replace them with direct calls to v9fs_init_inode_cache
and v9fs_destroy_inode_cache respectively to simplify the code.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V1: originally cleaned up v9fs_cache_register to just a direct call
    to v9fs_init_inode_cache.
V2: replace v9fs_cache_register and v9fs_cache_unregister with direct
    calls and change subject line

---
 fs/9p/v9fs.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 281a1ed03a04..77e9c4387c1d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -659,21 +659,6 @@ static void v9fs_destroy_inode_cache(void)
 	kmem_cache_destroy(v9fs_inode_cache);
 }
 
-static int v9fs_cache_register(void)
-{
-	int ret;
-
-	ret = v9fs_init_inode_cache();
-	if (ret < 0)
-		return ret;
-	return ret;
-}
-
-static void v9fs_cache_unregister(void)
-{
-	v9fs_destroy_inode_cache();
-}
-
 /**
  * init_v9fs - Initialize module
  *
@@ -686,7 +671,7 @@ static int __init init_v9fs(void)
 	pr_info("Installing v9fs 9p2000 file system support\n");
 	/* TODO: Setup list of registered trasnport modules */
 
-	err = v9fs_cache_register();
+	err = v9fs_init_inode_cache();
 	if (err < 0) {
 		pr_err("Failed to register v9fs for caching\n");
 		return err;
@@ -709,7 +694,7 @@ static int __init init_v9fs(void)
 	v9fs_sysfs_cleanup();
 
 out_cache:
-	v9fs_cache_unregister();
+	v9fs_destroy_inode_cache();
 
 	return err;
 }
@@ -722,7 +707,7 @@ static int __init init_v9fs(void)
 static void __exit exit_v9fs(void)
 {
 	v9fs_sysfs_cleanup();
-	v9fs_cache_unregister();
+	v9fs_destroy_inode_cache();
 	unregister_filesystem(&v9fs_fs_type);
 }
 
-- 
2.39.5


