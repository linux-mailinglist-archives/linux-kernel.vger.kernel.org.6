Return-Path: <linux-kernel+bounces-519920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F33A3A398
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA62A188C1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3526FA55;
	Tue, 18 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCCZ8f7e"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18426F457
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898498; cv=none; b=ueMcMRLRCMNzzWFAXpphfFZ/6zqzbv81xEZy+UOvMLGY/VQkw1Fnq+dKZFDH3PssBa7f8XXPQc9uo1UV0a3E1OqEGOUbJBOb/mTSxQg5XuRKV1VbyNVqMbD7zv285qdMyRRHBE3HepLSI2Ji0aXhBDs4M67xLWqw4rwTu2LZFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898498; c=relaxed/simple;
	bh=jOGVzx0B5armIJs+uY25Q2Q336m0m5Toe/PBYNpttxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5kpYF7LTyZkBvLUdSJVUL1uJn7z8L/EIGuOFQlodEYh73GqSvDdZ2s4gBbLld5LPnFBJ64HRd157A1V5hkFzO7tqvRIpGbcHm54hTWPnq/LMcVRuu+8544hYUkpyXKXd3AqekA/sgMSGQiFEv0eVsxzvXRm64oGkGHbUiHuxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCCZ8f7e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4396424d173so58936145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898495; x=1740503295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL6cYtME81OabMEvJHb4zln7D1CzFUsjB88Lba9wNjg=;
        b=OCCZ8f7e4QJjB3osF1Hmwxu6/PrEKWFERa0UskghSj4a4+s01Y4Y5GlRl0qGBTyP3Z
         YTxTQXz6S4gA+F6xX2QplhTcA4t0StDK82xZuuKIFl5kDn14U++jPkNgJxaIFdXnZunw
         iEbdCdvxtP3rZDwXHjbK7tLGOrdD4jDtU7o27NCwYXrSZPb/pHW07Yr6Qo6jvEwFt5yC
         5PW+TJhoFYhftRnuOw2YYYNwlbv8yQny0G7kmf0MTgJYamQ23d2Z4dzy+xHu1YTIOJEW
         x6SuW2MVuAismvUn8RAtthFfLjP0MY2xdwhWSeFTZLTopr15wKoFCqEVLxZcoPxgSocr
         eO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898495; x=1740503295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL6cYtME81OabMEvJHb4zln7D1CzFUsjB88Lba9wNjg=;
        b=bcFNVmRnVRUP49/fnYmN+RgUPhUkrT8wNZ/x4wPMEtCZq/Gd8HCl/ViHwnGotQJr7J
         QfBgxKdWwhWbFpVbLNdrgtSPK/BV1SzucKqE4pjFu9FYpqhDXiZKQ+Cw//u4P+BKIo7r
         SwMI3Ml459ilXPZcnGLC0ThVyFQ/6q+aEo57RpvOJ2wg3jnxn4EkuxfiFGD6KWz3FAZm
         96M6+Gk0I2U37jMuBRhe3p+BP5iKFwC4DqIOZtS1gC8Lr9Uql5sJghEfon3Y5vliykiM
         sKzpYkoP1VuajZ2QSJl80eza6mNjNWjnxumVxc40QEC+ex9o7DxT0QHwKx7lu7N0ldY8
         COXg==
X-Forwarded-Encrypted: i=1; AJvYcCUWKzj+4fSaMrEiFEL78w1eFBIzH5FHkLUUEG2DkXBPdO2TPl3ncS47js7gIHW4AQTPi7dMJjQ7ugjDdFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUnpoNNuDkdkADFTknVfMxbc9Rnf57jDbVsEb4LCmUKqR7t2F
	D1uMiOaa6u6bBVbjk60oVh2rDnZ4cXbx5iLpzSC/ffRG1MaJ9o+X
X-Gm-Gg: ASbGncuh+lkfOuYGENgx0bL1rPEdlshOeOljlvKynPnG3o0/3Z66oZ3hg03RhsaDX6e
	gbGreixyDKDiYnYY0TtK5P4zxKZ3WS6fCaaQrlNthb1rY3V+mLMJNBeVNAMjgDJ2jt6ZMbo5ewX
	0IIkRNujFb2L3QAksRDTAEViqHbwgRgjLeHYUhrk8S44Cx/NYPPY4m2/kufZw9OM2KIMm+cklvf
	ZNiR/Oi4nu4UK+4nx27xqzGmURA8RapCbeOukb73ZFmkzxJGPWlBcpK8d7mxqaRcggxkcID1MU8
	gRC4sEdSZwfO9kD5Lw==
X-Google-Smtp-Source: AGHT+IF44VIn/rxhr0e48RyjAhlq5WyDUp5UN4pEKUc0N1DwkqpoyhaBjR6V+hO1E+VpZZ3N93vboQ==
X-Received: by 2002:a05:600c:4fce:b0:439:3d5c:8c19 with SMTP id 5b1f17b1804b1-4396e717094mr127675585e9.24.1739898493749;
        Tue, 18 Feb 2025 09:08:13 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:13 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 01/16] drm/vkms: Expose device creation and destruction
Date: Tue, 18 Feb 2025 18:07:53 +0100
Message-ID: <20250218170808.9507-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for configfs support, expose vkms_create() and
vkms_destroy().

Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_drv.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index a24d1655f7b8..23817c7b997e 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -146,7 +146,7 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	return vkms_output_init(vkmsdev);
 }
 
-static int vkms_create(struct vkms_config *config)
+int vkms_create(struct vkms_config *config)
 {
 	int ret;
 	struct platform_device *pdev;
@@ -229,7 +229,7 @@ static int __init vkms_init(void)
 	return 0;
 }
 
-static void vkms_destroy(struct vkms_config *config)
+void vkms_destroy(struct vkms_config *config)
 {
 	struct platform_device *pdev;
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index a74a7fc3a056..0fe08cd0c461 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -223,6 +223,10 @@ struct vkms_device {
 #define to_vkms_plane_state(target)\
 	container_of(target, struct vkms_plane_state, base.base)
 
+/* VKMS device */
+int vkms_create(struct vkms_config *config);
+void vkms_destroy(struct vkms_config *config);
+
 /**
  * vkms_crtc_init() - Initialize a CRTC for VKMS
  * @dev: DRM device associated with the VKMS buffer
-- 
2.48.1


