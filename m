Return-Path: <linux-kernel+bounces-551537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E2A56DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6061899D41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CA23E227;
	Fri,  7 Mar 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdE193l+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175023BD12
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365243; cv=none; b=QJilf0eqkrbRRZYx9o9LxTyQx+DbxCHBuzbon8NAOv7Fxgz/ddQbtQXjwVeT5CXaUDIHNUwGDn57IFoRixgXPFq7zajnBuoHWG5iNix0xYZ0HhfVyHDVGhzG2E+jx1GnESXcTAiPSoidw5lRQeepnjbOrS4KRwW+IMDyB3l2dYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365243; c=relaxed/simple;
	bh=x8q2LQoaUnOBaiP5jsGvS/C96mTK7nmUfaD9bWRUJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKIjs+X+V0gW6t9CxPzRpK+KFWNC2LQtXp8ShmpfgpHNN7DrKIflzInpdXKBL0aMILAGMdw0WwsDsiW/UIP5pbT2sJczcCFCzHWnTCDdi0oqi/2tkD/BuWMqAU2DF1NdHNo4u2yNM0RLhuC0nYH42O0nIblEeRqFDoYx9Eizpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdE193l+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2f391864so1179451f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365239; x=1741970039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDEi+IB29m5kaXCQs1Xh/NAR1EeJ74QIHesF2OX+9WQ=;
        b=HdE193l+n5jlwS/HTyoU7BuGoMEZkKrlyjLl3HVEW8QJD2ZmCuqfG99fmM+l4rOwRB
         wyS9bNsZp61w89r9S/U3H5z8WpTRrcdbo3TfBcic1nnc7LnT1EdLS/0yLCusoxyZsbCO
         tdRExjvgyjwGRXP9GXwzZCNGR9ognNWPID0SqMhbkLAM5zKaILfzk46qKd0ieZiXwc1r
         3IwKRh6BDfJr+2xkBPwyHDKgClfiy3SieH58eFmnqafh/TF03OCunJnQUeYdBn40ccoI
         /D8/O5CMG08jmrwP1XcBOBOWVvfgtvCxbQmw6y7OOoewESrqshzg2ZBFkGOfMy6L3PUR
         FeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365239; x=1741970039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDEi+IB29m5kaXCQs1Xh/NAR1EeJ74QIHesF2OX+9WQ=;
        b=YwpF6ydCPhOFH5lsrxr4pzNkleqs1N/E45Kg+QeIG/PLcSCBo9BubRUVL7ySFbM2Mo
         x37CfTng3OxI3xK6UqXVOMm4l/70m9T5ksevF7VViZGWRvoWMv56L98dpNTln6nGXljb
         1H4w7pfaa1sGYTNQ9bLNqCXkNHO/DmVobpVYp/vlHPbBtDJ9Oa+OFg0rgvtOF10EKJYJ
         GLrHNLz+eS5wMwEETisKPZOuPhvF4sqrLulTx2duUkBrbiSnsFVdqfry2tG4N3JM1iVG
         vBohCTSB7oQm0/JDJ0PMCIOk5kldOY1quBhpmPdSb+HEAjfapHLFk081ikuE9ZcQNueD
         GIQw==
X-Forwarded-Encrypted: i=1; AJvYcCVUrgziGqygxuSd0Y/hhSxJqEPqrVY4qlG/MlpsesiHPZ/onyBlLbXpbR3m/4uM+FH+kx903epvKBzamf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kOQck3Nt5CgMWjIMwb/r1VI8oJ88DswoVf0U2fyeNLM/2RkA
	ZFb6D5YeQQA+xN4IZHYyWeCjor1H/RbnYe7iMXnxCjatQ+xKbNcu
X-Gm-Gg: ASbGncscrE+vIi4G0VQ33jFf8cMokJPiwC8p5JsNokcmBjdXnoPZmOYkKK08D5ClyUI
	+61+a3dUcbW6set6XpHlZ2KeHdhgD1wBsmN7EM8BgD44qSShH+U+PEomAmxHfLWuZdB4IiAl4Uk
	bOAU6tmODlPHy0U6TWEpJeVV8pBny0WmxwvHCpht8uL9MsNOV+G59megy0OWGH06ZMSdvEEe034
	Rwyqa4NtpjHzSULiO0r2OvHAqfkc3a0FI7jB7A6ge6imYsiUT2roAY5uc7HeUE2NwRDiMhpmW9v
	+yif8BYR1fjgAHuDYFSm3gqRGs7AnR93HACXvF0SO/YmR6g=
X-Google-Smtp-Source: AGHT+IHvEOquRlRDE6sNgZzthTbLfd1K6H7yZoCbaCvUV5F730ddnKBLTzQkXWvjxk1UN7ARIK+LDA==
X-Received: by 2002:a5d:5987:0:b0:391:78a:33de with SMTP id ffacd0b85a97d-39132d1ca75mr2576203f8f.12.1741365239196;
        Fri, 07 Mar 2025 08:33:59 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:33:58 -0800 (PST)
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
Subject: [PATCH v3 01/16] drm/vkms: Expose device creation and destruction
Date: Fri,  7 Mar 2025 17:33:38 +0100
Message-ID: <20250307163353.5896-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307163353.5896-1-jose.exposito89@gmail.com>
References: <20250307163353.5896-1-jose.exposito89@gmail.com>
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


