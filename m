Return-Path: <linux-kernel+bounces-510746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2DA3216C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D901886FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D58204699;
	Wed, 12 Feb 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1u+Pxpp"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255951E492D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350161; cv=none; b=Eethg8b+gGngx9NlSwPzaxSH3+9fEMC1s/h0moNIm9I4dqL8nFrce4SiEKsigbaTK45oAwz0yVzFItnp9PNS9XjdW/oqK0SQWceBVHP40IEv3PmYpga7zzLey+A77qhiNeV+IaibHlHlkBH9OjcR1s0dYpAA7zhZm7rMNUufiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350161; c=relaxed/simple;
	bh=wfSWd7+rjeEbpIBLGRKWCodTxKEd6xdW/hr9jo+ucfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xc+Y03w8x9WLmELiw2glvDkWSEzcyMDLN0WSHLAvBB7jhLxWLy6VPMa4n/+PiEHG3bmvg9ZCwhF0mv0ptofzydtXmeajMbvyORFP0CCgO1CPbplDsfdZZnEVYTRNJBq460X1/Xa4O59BmFQx0tRWkOt3j1LaCSKIK81Tx0Y6G2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1u+Pxpp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd011ff8bso3815227f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739350158; x=1739954958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqPjNzN3hIOUqf1ihOkU/QGEBU1cO5gaJEuNeFStEvY=;
        b=J1u+PxppHZWgagwsO+LwTj99Oxmk3hKNCDF0SUE5crXdzL/okGfyPjoOvKoYz/dcag
         KYZBHpOkNlQyOIysQB0G7+Evz4G8AUblB5/HjfdbhkQ6MGgRyeyaVu9m7TXYV7vp1kd7
         LR2Awwk1VPVNorFSwmMFOVVOliqHGpQVPXSh4m/imISb4i2Sdx6diy2x+j/Gl+ABGGGL
         BTv+z1hA9kT7DMNvR8ixD5CCEuoL2Xk2GxzxbxTKCJPTj/i5wZQx2JrcPU9oSdnVITUr
         201KHRvp0hUl9kpW9bXwLBoQMDA+vOoTzBLNJN6vC1PlK8FTwjcO3FOEGEk6BDCi65dH
         yphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739350158; x=1739954958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqPjNzN3hIOUqf1ihOkU/QGEBU1cO5gaJEuNeFStEvY=;
        b=tGgHhYwzCo4dWveBZ28ouPHYXamcypLN9Bs0Cwol8h7z+h252KjCPbgdPTKOhsuXPG
         PE0uE8HzlQo9+pwVqpb0snT+Wy+diSpnIXSuLjw0DvTmPLZQiPW9mtKcJuU4RF4uYNXs
         6z51k5ISjcJOj80dLVlDEWeLWMRDP6CKzvof+F5L8bMQbKwFE09igzTGkbpCAFHKz0Fx
         ALM/VuuReEPDnFzzEOtcNXGKyIoqhLkqKXq/uvQX86MOoNA5Bn+iPv/1UPjv2xB0qbDT
         v0n8WLr/l5xUnNPRVbSn0i2TTkwPF9g7rUMhCo295IXVA+aK+7Np14sKie1VjgBGYy49
         aHyg==
X-Forwarded-Encrypted: i=1; AJvYcCXz5W7dyabfiMWD1fJLvTycp0bAPtMPhJ0/d6NeSdPQg33U5QuvcvyzCCK7MQIRIhDBBz1qwgk5D5nyBDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+8eirQ5vFv9Lkpyn6VUKuLsm1r6lNVriLl6M828i4A76+dVw
	IYFlZ0BqYilbs0RvqrBajXQB5cBlaiVTHlJ5XIoQ10/ROnnmdpqQ
X-Gm-Gg: ASbGnctx9eoZGlh/WDKGlG+r8hHg79wQIN3+zHxxjEkO2rUhaVq+tWxex0FBSaxse6L
	obYfaaQi2MDWbcdvi3LKG03A8eYwaauuEZt6fA5qQdoH3wcc+BvHS87/gEN0p+BJL+7QApawnmk
	08D1G2hLKfxJ9bxM3DHTIqE4pbBK7PBarNFXp8M+b8ZQ8mv5MA6KBi3kXPZXnbBhpYF1fyFTLIl
	D7VkYqanGyTrfKYSZwGTHWKroYJZ2mu34ItVjuraRuaQ4EmEKVb+JTmjOleRxGHBfaoywMnH3/M
	MmEBk0EHw0JS+C/5
X-Google-Smtp-Source: AGHT+IGCCRY7NE2FbXpz20DFZcUlyeCjQeTEvVxZfELxzuLtNHlgPa/u0fy/uhEp0tfuZ1QmZa76kQ==
X-Received: by 2002:a05:6000:144f:b0:38d:dfdc:52b6 with SMTP id ffacd0b85a97d-38dea2e963dmr1714220f8f.37.1739350158120;
        Wed, 12 Feb 2025 00:49:18 -0800 (PST)
Received: from fedora.. ([94.73.37.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd49d2cafsm11400302f8f.16.2025.02.12.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 00:49:17 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	danvet.vetter@ffwl.ch,
	sylphrenadin@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: Fix use after free and double free on init error
Date: Wed, 12 Feb 2025 09:49:12 +0100
Message-ID: <20250212084912.3196-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the driver initialization fails, the vkms_exit() function might
access an uninitialized or freed default_config pointer and it might
double free it.

Fix both possible errors by initializing default_config only when the
driver initialization succeeded.

Reported-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://lore.kernel.org/all/Z5uDHcCmAwiTsGte@louis-chauvet-laptop/
Fixes: 2df7af93fdad ("drm/vkms: Add vkms_config type")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 7c142bfc3bd9..b6de91134a22 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -235,17 +235,19 @@ static int __init vkms_init(void)
 	if (!config)
 		return -ENOMEM;
 
-	default_config = config;
-
 	config->cursor = enable_cursor;
 	config->writeback = enable_writeback;
 	config->overlay = enable_overlay;
 
 	ret = vkms_create(config);
-	if (ret)
+	if (ret) {
 		kfree(config);
+		return ret;
+	}
 
-	return ret;
+	default_config = config;
+
+	return 0;
 }
 
 static void vkms_destroy(struct vkms_config *config)
@@ -269,9 +271,10 @@ static void vkms_destroy(struct vkms_config *config)
 
 static void __exit vkms_exit(void)
 {
-	if (default_config->dev)
-		vkms_destroy(default_config);
+	if (!default_config)
+		return;
 
+	vkms_destroy(default_config);
 	kfree(default_config);
 }
 
-- 
2.48.1


