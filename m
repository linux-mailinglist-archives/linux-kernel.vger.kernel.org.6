Return-Path: <linux-kernel+bounces-532145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAAA44950
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904D442019B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4119F116;
	Tue, 25 Feb 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WefaRd7P"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4319D898
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506386; cv=none; b=oXKQ/HpV6T6f5Xt7WiL/d9RFyfQ+oRSEX8cNXzonyK1uyCSygEmQX9kyFfvjaZVFnStrETlA2m6wjG1pNB7FYQiARa094YZp5P4Z2aRBeANCSmyoL1kw/CjIsYynEpEfj6tDUXSm1oCv/aR4uDIKRRiFrQIxaa3n1LySKsO/cB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506386; c=relaxed/simple;
	bh=x8q2LQoaUnOBaiP5jsGvS/C96mTK7nmUfaD9bWRUJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEopilnk5mRmvXaOxP1gsaN1kbgbmDK/wk0d0nzcDwPoCxmmDawVXJooOjTCGGWjGrvtT9yAvkzAPDNSUGgCPi4v2S84f6GjM1ZBUAaLgKtSR2xWjT1Cw+YKBR3dAHC+QwgDM4ET5p/QlUWQNTuGSyBAWF95uG+Yd+Icj5ec7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WefaRd7P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso37847605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740506382; x=1741111182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDEi+IB29m5kaXCQs1Xh/NAR1EeJ74QIHesF2OX+9WQ=;
        b=WefaRd7PVvn2lGzK2n9XrXjYSJE8s64MYkUe2XtfNRm8zfd+wEMDnqogIH5eotzy28
         9A9uzblydUlOOqGdC2OQR3B6r4Dq9l3znxHnAsiVSyRgpu/lKzuUpFuK8rWq2RajsfBI
         ZpxNMGXiugR99R3UWMfRr9hn4gDmG+pHOChGlX5ua0hGEKCtZy0287N16UWdW4Re9UO+
         AyxDRGjz95i38nyI3Fxsj2YXVUvABvVRDtPipY7IL2D3r0K9ukuhjOnzeFW3kcA3XWBQ
         Vo6lPMeVEfJhsicGYhxJKQzpwBuRQjFkRe53ocyFrBzqy2+sTENf2j41dI8I7mbNRkTz
         on3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506382; x=1741111182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDEi+IB29m5kaXCQs1Xh/NAR1EeJ74QIHesF2OX+9WQ=;
        b=OIkcwvAiG3A3F2KW5/SWo/vqyrI1pgnkf/1vCPpMZchZivuxt20i/I27kp8yoawKUp
         y4SFLqzZB1LC+qlDSXvaEDEiI/sQ+XTGprBF/oEcggCXFVXKUcCcKmzzfOJG9UEGgZYO
         JtB8coys5LtVDuaYEkDWDux61krXx/wQgLqXQytAhR1H/M2u9cafr5mYEqzF+YnBmHY4
         mVwbOqovuxR6w6n7Ca0e2IHYVwJWU40SW50FfHqN8L5P7q05Y3bcYj6pgkirkLMhSgMD
         QBelnLcvSRRMN5f4JhjhnInA4KjxIQH/6NMztI6i2yQw+WokqKvla6m+a7tUUk1+epCe
         0g5A==
X-Forwarded-Encrypted: i=1; AJvYcCVdQyHeXjaL2Ou4tlknScLiSUzhwMjT3uLEAyEH5LSR7F69IiYogsZ14jyWIntMcQFzDWDfhFIO7szbZvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxecfi2vbtFUJfhgl/mhSzWMofyWXU1c99P0kcmgg65xAS5cGxy
	4uFCGoNJhMzu8u70rByvwZ5X4xHVuKIIaWdPmcKwg+u6eYadYBDh
X-Gm-Gg: ASbGncueH7ZLgce0Rr+Ekie+WQCidotTYscwZ7Tts+kUXZZHK4EKf7h5jxT6+R2cdMX
	6k1uzyFWVDv47T0UeuJ0BhrIiIZFvO9TIAeY9N9WvceYDFLShHqJsGeWGpZWNNuqnBJh+DtWBzI
	jWiGQyexZcmDmWbCuPf2W2AmdAagfyx0iOQMyXSet5BqV+mulmkQXSYC3x3cvOIEapPMH1jxJL6
	zsa4bZVHmWkH1K8oUwpGgEd6quHUKYLK22EJtq4kfphZwI13jFu6LiKhET+oVai4uv0T/0x/9he
	stGK3ckktgMI/vGG1pDppmEbGS/l
X-Google-Smtp-Source: AGHT+IGLk9bjzumLU58MNpaygHhKj7RjQYegcaCcfgsinAKj5M6r6P6pmCzsRocIk9CriKFeU9tX1A==
X-Received: by 2002:a05:600c:4f0d:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ab90169d5mr4187105e9.19.1740506381786;
        Tue, 25 Feb 2025 09:59:41 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02f3e15sm149063655e9.22.2025.02.25.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:59:40 -0800 (PST)
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
Subject: [PATCH v2 01/16] drm/vkms: Expose device creation and destruction
Date: Tue, 25 Feb 2025 18:59:21 +0100
Message-ID: <20250225175936.7223-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225175936.7223-1-jose.exposito89@gmail.com>
References: <20250225175936.7223-1-jose.exposito89@gmail.com>
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

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c |  4 ++--
 drivers/gpu/drm/vkms/vkms_drv.h | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

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
index a74a7fc3a056..2ad8e3da3b7b 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -223,6 +223,26 @@ struct vkms_device {
 #define to_vkms_plane_state(target)\
 	container_of(target, struct vkms_plane_state, base.base)
 
+/**
+ * vkms_create() - Create a device from a configuration
+ * @config: Config used to configure the new device
+ *
+ * A pointer to the created vkms_device is stored in @config
+ *
+ * Returns:
+ * 0 on success or an error.
+ */
+int vkms_create(struct vkms_config *config);
+
+/**
+ * vkms_destroy() - Destroy a device
+ * @config: Config from which the device was created
+ *
+ * The device is completely removed, but the @config is not freed. It can be
+ * reused or destroyed with vkms_config_destroy().
+ */
+void vkms_destroy(struct vkms_config *config);
+
 /**
  * vkms_crtc_init() - Initialize a CRTC for VKMS
  * @dev: DRM device associated with the VKMS buffer
-- 
2.48.1


