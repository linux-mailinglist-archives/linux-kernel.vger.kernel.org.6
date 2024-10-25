Return-Path: <linux-kernel+bounces-382231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF429B0B43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF19928A135
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA15224D9F;
	Fri, 25 Oct 2024 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="flgudHfK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90049224DBA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876581; cv=none; b=Mtdhk2M+7eSxsfFZ1m4HPLg+V6R/9DmBO8eaNyoM50Em372gLii2IC/SpJ/4hA9Wduc9V+bNNFkKNZonh2CEdci98rHTTL77D7FEgyGRAyIwm9F6gxldNZ1DtAitwMZNzztbhfQAq1HC+i+2LEAiC151gJF9TIvmNIoIeCPBC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876581; c=relaxed/simple;
	bh=1hF1PhNYP2/A1x5AcjvXgQw18E7kHCNzlJ5ort+1kbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ik7h9zlmMWtVRsEvRVGDdW+r7OX101Jt1MNWNMhS9dq5WS/ijBzfzrnxsbbKzUFJW3ZCFTPgQP5XUNTQSD8u8d8U54PPriMdyyJxtElGf0PUyhF9TkBwx1xvGh1KAG9rcUrcODIdFexeLXkurWw886W9hQByIrEEzEtvwfpHGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=flgudHfK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1934805f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876577; x=1730481377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjLOa+CYvpz+BpNsMyaYFjyUkwYrQkclw8bv+vdgZA4=;
        b=flgudHfKR+/M1jPSRe9pxlsWsmYIHK9Qf352b48S9UIHZ67usBxD52NYz0YAU1Apaz
         wlOuaz3yKQoxgD1pO8zMGMJX4gy+2OxYQR4WgEQ3vQ/EUnlfdZAxduoAaH+kZfSQRHMs
         Kk+7rJ9UyFaQi1aM3MDL7t2SC+JMCYikqKtrjgddNAsQCbdPBvKYMfZwvdLSly0PQ/6o
         GdtpdloyLwiMpT1ek33V1fE293BYgAuvMp+Dxfcb/BAGIVqZzO5Q14aci+vMQe8UaJeF
         +ifHvfK/aJppPM+JULtjRxSlExUvZ5rwqLP1qtDveEyZXfECl5S5BWiyNmHr19vNlypp
         jkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876577; x=1730481377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjLOa+CYvpz+BpNsMyaYFjyUkwYrQkclw8bv+vdgZA4=;
        b=eK5Zz4oRfqsbxl0mYp7GIQorgq/L0lWPEopnyXSI/yA3nGmRM2QYw6A57JF1Drq+++
         pSoSg/Js+qAuNlq8zbAN5U1RsKdlfkBPFoU72ZCgqPUe9NX6c5tBs3vLhbqehKfpahPv
         VaQef1l5+7cwamMczDOIK8TjQVTsmbxsnN6EQQpqtdRcIDwiRK8YQZP3HDthSWLKfXcT
         pdnzgKhsrh6vxUHWos1fBSRFggIaOOk1UbGyZSQ6vcrI7uD2jvlW7zxppDKR8lJJZlrg
         E8IBx3btXJvgFspUThhZ7c5RAZdz8+uHQAirPyMsSHZp9lMNnOH9jpF76SwbIBPKqfIr
         3xeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUchxJnF2dNryUaij3lGcy7NQn9jmAKL7VLNJwc4WfxBtjBrS09zc2b238Bc7Pzp+hWUAqYWF+MdnFWhzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHUCVB4Ee5FMfs/p2Z2SqLPaqfwubGq0CHSXB+isOn1z4XpA2
	0v4nWw4GyLPId/u5564wMnxuRqUstYSgtdfC9Trzqt8SNvaRBrqsAmH1pQ1/u0c=
X-Google-Smtp-Source: AGHT+IGP9nRcQ2kzvdL+ddPuHATxPAjofcN1yD5KA+iaTZo+WrIoFCmEwqLiAauQ9eDZll9Qzpuj9A==
X-Received: by 2002:a5d:444f:0:b0:37c:c832:cf95 with SMTP id ffacd0b85a97d-3806123eecfmr110629f8f.50.1729876576741;
        Fri, 25 Oct 2024 10:16:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:16 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:47 +0100
Subject: [PATCH v2 16/36] drm/vc4: txp: Add horizontal and vertical size
 offset toggle bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-16-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

The new writeback controllers that can be found on the BCM2712 require
to have their horizontal and vertical size reduced by one.

Let's tie that behaviour to the compatible so we can support both the
new and old controllers.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  1 +
 drivers/gpu/drm/vc4/vc4_txp.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 27deb4cde02d..984fddae0048 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -539,6 +539,7 @@ struct vc4_crtc_data {
 struct vc4_txp_data {
 	struct vc4_crtc_data	base;
 	unsigned int has_byte_enable:1;
+	unsigned int size_minus_one:1;
 };
 
 extern const struct vc4_txp_data bcm2835_txp_data;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index eaf30b2cfb5b..d2ee872e9c0b 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -291,6 +291,8 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 	struct drm_gem_dma_object *gem;
 	struct drm_display_mode *mode;
 	struct drm_framebuffer *fb;
+	unsigned int hdisplay;
+	unsigned int vdisplay;
 	u32 ctrl;
 	int idx;
 	int i;
@@ -330,9 +332,17 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
 	TXP_WRITE(TXP_DST_PTR, gem->dma_addr + fb->offsets[0]);
 	TXP_WRITE(TXP_DST_PITCH, fb->pitches[0]);
+
+	hdisplay = mode->hdisplay ?: 1;
+	vdisplay = mode->vdisplay ?: 1;
+	if (txp_data->size_minus_one) {
+		hdisplay -= 1;
+		vdisplay -= 1;
+	}
+
 	TXP_WRITE(TXP_DIM,
-		  VC4_SET_FIELD(mode->hdisplay, TXP_WIDTH) |
-		  VC4_SET_FIELD(mode->vdisplay, TXP_HEIGHT));
+		  VC4_SET_FIELD(hdisplay, TXP_WIDTH) |
+		  VC4_SET_FIELD(vdisplay, TXP_HEIGHT));
 
 	TXP_WRITE(TXP_DST_CTRL, ctrl);
 

-- 
2.34.1


