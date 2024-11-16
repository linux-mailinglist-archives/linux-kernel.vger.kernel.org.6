Return-Path: <linux-kernel+bounces-411781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53D9CFF7B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C6928380B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F028689;
	Sat, 16 Nov 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZL00Xuz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D48FC12
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770785; cv=none; b=Sw1g0xdotzfp3gLVQRg0LDqGvhYLwcoGIMYJLdGtU6q3gi1zEdHUCEtIy6F4gL6x4F6asGLKsDEqqJtQPa63bTWolfzVBmbRVFHF5GEKj9H/N9R5ZcBX95ZOZXqTaEnIgjAngyWbaPmbSlqOnYrP9x9AY4FyOsXgkFm8xSYoLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770785; c=relaxed/simple;
	bh=JLhJC5UA4lVgwXGpCOzDlLepsnrDnqd5xqBtc0ls/no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qFQR96KnDQnv5fcWbrMeVXrFeyzJEY+blcoqVkdjwlHb+W/GOlidOsttk7uRo+Husk92lrhuWMKk7n+0tPXRwXLIjozT+X/CZ4DoGqwCWCkc/TV8zXmQOWws06dqRtnMHjp7j8JFpEC3g8LhxUWmjPagKlWX7lp7hI1qYitCiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZL00Xuz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-211fb27cc6bso2877265ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731770783; x=1732375583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPDsOHGCl/Zm3RB5zQO1pc1+MaPGaSdgrXo7H1Qoal0=;
        b=UZL00Xuz21goOokzQUIq/IsWIU5bUcqqvBxQu5kbvv67OI/2alOi3BvEoms5k5inVu
         6tfKemBztIhtwtXF99xBrtoslL7Eofcs8XJWNIlrM6xr+21vTDNU8I/OvMfKhl4EsqW9
         OBkxmmylAQM+1+UkXdm5ZsfaR9b/DavPtg6bodzSkuy42FytJBIHAs/cD0fVqR5huPtN
         Pzt52S7/lKTIog+4vkyXJ/k+A0KQ+UxChsE5Si5Zs7ogAizWj8uDFyJcA/TULxND+VTr
         kyrmCcFelBuplekdIYPAo6gaYqGx8cUK556tVFv5nA2sm+GcYfPPNgvLFapy6S+weZl6
         yDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731770783; x=1732375583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPDsOHGCl/Zm3RB5zQO1pc1+MaPGaSdgrXo7H1Qoal0=;
        b=Tqp5G7V1sq0QlFy6j2BxF4AqdoX+sz7wTPVmPHNVeeQwBlF1eLme5kau5evCFeNDH9
         K35J9MKAZYDT1AzBYlSEjEC7AoMjvYPy3kQ1Z1vQQ4btBg5EE2Up7I41s34171LCRSk8
         gcmL12cYCpQ1YXFuo+vDOniAd/S71EkgInDFWnMvO4QEVMGMaKz8Qn8ay9NdaDAyl7P4
         ifxFGMU8zo4f423Fa44WPOJWaeKX4NsiljAeWENxeUuPsctluYwqUsoOJ5kWq+Y5O6Ro
         HHWbSkHlKTv6LONzx6xqy98uRuaF92cqAd46vFj8oKgEyKyO7y8cBMZNWn3jAfS3ZxeN
         U71g==
X-Gm-Message-State: AOJu0YzbGKmofSS5XaSnG4P64qQ3k+/slsMDWQMtfcgyzHprvWf5J9Ih
	EdT9SGNFLBX0CDezcaWL4D/ey5ZUevyBLBww5QD4AhWO74rouQQB
X-Google-Smtp-Source: AGHT+IG5zJsZD+7IUF+Z0kXy6df1pX3+Q78HrdJeqNirbeYct9e7zu/8eZQpjVB3Ra8tYUVRIpQBPA==
X-Received: by 2002:a17:903:1c5:b0:20d:2e83:6995 with SMTP id d9443c01a7336-211d0eceaa1mr99420245ad.47.1731770783016;
        Sat, 16 Nov 2024 07:26:23 -0800 (PST)
Received: from YBNJ0150.jaguarmicro.local ([49.74.218.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc51a1sm29095695ad.57.2024.11.16.07.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 07:26:22 -0800 (PST)
From: Rex Nie <rexnie3@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com
Cc: linux-kernel@vger.kernel.org,
	Rex Nie <rexnie3@gmail.com>
Subject: [PATCH] 9p/fs: Different branch return the same value
Date: Sat, 16 Nov 2024 23:26:12 +0800
Message-Id: <20241116152612.2423-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same code is executed when the condition ret < 0 is true or false.
Remove the if branch and just return v9fs_init_inode_cache(). This
does not change the semantics of the original code.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 fs/9p/v9fs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 281a1ed03a04..ee0a374e0d9d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -661,12 +661,7 @@ static void v9fs_destroy_inode_cache(void)
 
 static int v9fs_cache_register(void)
 {
-	int ret;
-
-	ret = v9fs_init_inode_cache();
-	if (ret < 0)
-		return ret;
-	return ret;
+	return v9fs_init_inode_cache();
 }
 
 static void v9fs_cache_unregister(void)
-- 
2.17.1


