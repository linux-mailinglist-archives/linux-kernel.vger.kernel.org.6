Return-Path: <linux-kernel+bounces-378512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8F9AD1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A23B236EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1701FDF98;
	Wed, 23 Oct 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VXForXIL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444591EF932
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702230; cv=none; b=qq0+Lf1GB1MGTOwEneuD68es2qtxAv15pzZk9c3L6/1zVLyqWiKZ3O8eKfaJ1zsENh8/nGUTEdt3pLqpRF/iX5OO3FCleFDcUA4WLlqFb/b4CDI778z7kqK1mqUkr3wVEA5paxUwucRDYXNMBYeeRXJWvtzLCfezdTe1AHadrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702230; c=relaxed/simple;
	bh=6/0MGSFMLpItvDKAiuH9HB3iIfeafKjYJItOtt2uxf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiVFbbtxfmbMwI5rSI76yb4qXjYOKeW6nTY5UdY0XH2FKGd7SpkDIYEAnPlQrh9qv/7cQhAHqceo+t1oMtvQMJAIBYhaKvLOEFbYpWI/PGpzWI6rEyjpM8K6jLeoMAPfVu+d2JB7L9fswQf+BM5XduQOWajOn9kGP/35zWqYqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=VXForXIL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43155afca99so7805855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702226; x=1730307026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAmGnbsXlsT4wTydGcek4ZEoMBRAPW62Dt7gooaokpo=;
        b=VXForXIL+L0Yxw5Xa3XkrHUozggT0qXgvseXOGWMxc9HrdbiQVio2LKXozBHMJUT9Y
         hKJVcRaCzSRX3Sku1tskS7gOb+hKRlT9IFKvVQkCBwz9OLIqOq1AG3Oq0Uy0C1ItT2Mf
         TBZ3Bd9zO1YO1qqI7ejyzM2Jnb8GsC3IX1PafLfWDDFxI4Fdrpx/KT55+NLmkRpo9n8M
         JOIzuEI4BcuSXn95suxgPVdbTVKux21VYDcziqsPT19vDinErCvLLmp9dPpRGhzkJo7y
         CqzedaFsakVqKsFzRXgEZ8+9FXCCLl4yzh6Z8Arr7MOGVDouwGN5Yq+IYygL+QpSnGh4
         HBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702226; x=1730307026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAmGnbsXlsT4wTydGcek4ZEoMBRAPW62Dt7gooaokpo=;
        b=DjRjcGqOlnJTUB8II37Kfc6qV92bA6ts3L5d2PE2dSDYX6+BqD3novC1IKHD2OY467
         7H5I+yZ/3CuFAdjHkkneTlxsf3BTE0QfGXmqMwoA/JFNwuB0L49d96YoFvKs/4wyw3Cm
         nH1VONqknuxEUCWUOK9OzO8/O5KhjZag7PCuiUP2ergyZC6EjooXdw8w9BLlGlvjYCF+
         4SgSTLsmk/ztX+yAfDnmb125/zoYqko5c3GgqszWHu7aAw8WxZoZpOHrL/QxlSpLWqMP
         zONIIeY05XwgLPtwLu/b+CgcxOhx4lVkgDQsEeIuihMCk+bQSUt92kYqUhg+ZlaFrugp
         eZjw==
X-Forwarded-Encrypted: i=1; AJvYcCUV7iO8ufu0/C03EY7RqlngHDWa7YLUWclA4685ts5vrlpNLL+WV870w9lDV9jRlXqKVska6+Zh/ez5edE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdw4Z3TpJmRBrqG7h9qo6pN/gYEEMEKaUBFdLHGsKrP+dLWO6+
	8U/G5uU8ugmyUv7z/shosLWvrqDbpF/DK6GpyD4u5jGb+5HClABxKujMJPASXKk=
X-Google-Smtp-Source: AGHT+IHL2wgt75iB2bh0ZhjUQkAbPcOQbonRHG1SD5jdc74+CwqD//SyS484BHiLP8yrR7PCt0OkEA==
X-Received: by 2002:a05:600c:354f:b0:431:57cf:f13d with SMTP id 5b1f17b1804b1-43184337402mr22456585e9.3.1729702226319;
        Wed, 23 Oct 2024 09:50:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:25 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:15 +0100
Subject: [PATCH 18/37] drm/vc4: txp: Handle 40-bits DMA Addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-18-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
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

The BCM2712 MOP and MOPLET can handle addresses larger than 32bits
through an extra register. We can easily support it and make it
conditional based on the compatible through a boolean in our variant
structure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_txp.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 984fddae0048..34e72e711a17 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -538,8 +538,10 @@ struct vc4_crtc_data {
 
 struct vc4_txp_data {
 	struct vc4_crtc_data	base;
+	unsigned int high_addr_ptr_reg;
 	unsigned int has_byte_enable:1;
 	unsigned int size_minus_one:1;
+	unsigned int supports_40bit_addresses:1;
 };
 
 extern const struct vc4_txp_data bcm2835_txp_data;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index d2ee872e9c0b..c2726ccde1cf 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -145,6 +145,9 @@
 /* Number of lines received and committed to memory. */
 #define TXP_PROGRESS		0x10
 
+#define TXP_DST_PTR_HIGH_MOPLET	0x1c
+#define TXP_DST_PTR_HIGH_MOP	0x24
+
 #define TXP_READ(offset)								\
 	({										\
 		kunit_fail_current_test("Accessing a register in a unit test!\n");	\
@@ -293,6 +296,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 	struct drm_framebuffer *fb;
 	unsigned int hdisplay;
 	unsigned int vdisplay;
+	dma_addr_t addr;
 	u32 ctrl;
 	int idx;
 	int i;
@@ -330,7 +334,13 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 		return;
 
 	gem = drm_fb_dma_get_gem_obj(fb, 0);
-	TXP_WRITE(TXP_DST_PTR, gem->dma_addr + fb->offsets[0]);
+	addr = gem->dma_addr + fb->offsets[0];
+
+	TXP_WRITE(TXP_DST_PTR, lower_32_bits(addr));
+
+	if (txp_data->supports_40bit_addresses)
+		TXP_WRITE(txp_data->high_addr_ptr_reg, upper_32_bits(addr) & 0xff);
+
 	TXP_WRITE(TXP_DST_PITCH, fb->pitches[0]);
 
 	hdisplay = mode->hdisplay ?: 1;

-- 
2.34.1


