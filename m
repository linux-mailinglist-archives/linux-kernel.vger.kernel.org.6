Return-Path: <linux-kernel+bounces-378497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E939AD170
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8881C22195
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A051CF7D9;
	Wed, 23 Oct 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="GLtAHcO+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE61CDFB9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702214; cv=none; b=A/9y8wj1jj93Cnk51A2ebMd6oOhYPm8HG9Kqts9zQX16oEY4wj5n21qfUUPxWmtzaHkKBSUVvGiPQGp4Q83Y833suGPcjzRDnPvO+W+OKVomqksdNggv1MwIys1k6aNWNyI0FXKeuGrLiBm2cRunhAmMcU7Hrr1A81SuosejaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702214; c=relaxed/simple;
	bh=z2Q86fa2Du2WubOBnMYnrPBais8ImpM0cuAR16G5yvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcWg5l2jaTDtr87Xk6j9QlS9wXkWzdUXKZabw/G7Rh9mjtaAWWpL07XUrTdmmjBufsFgloWIzZ2HItcYCUSXvHbLnnrHyqz2vT7ch08Q5bv828S51kNPnAa3TkbdLtafpUg/KBc8SMdcpujJ2Gc8HC0fmlnB/sYNS5FmmZ081O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=GLtAHcO+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d518f9abcso4769533f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702210; x=1730307010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WK3Wcz0LjTp23A2ibh778TvWVk0jVp3LvtNmMQecJo=;
        b=GLtAHcO+e1HFV5Tnr97fdErOsmw5Ie8YWCkCRP2bblDohwQJ+JDTjMfqNrqjE3Qe8x
         OBu9G+1uPncPJgoku+rBh3cGnwhQLwkynsg2A6f+6eSIEXu6NINR+Un5ALxKGVmwbg81
         cPbF97IXEjJK6fNEDWGFx+oudqR2Qa4FK8jpsgk5qWISX+jkR3u359HmD7QYZyUfV1Ff
         yR1V8PYPexyrVNepFQ9qi5QAYF0KCuLSXIpapfmBXPl+vqVmcmUxHFJwdPSBFSeis8Ki
         itVyNo5517W2B56ORIU7q1troRRjOS8veUX4RbVsw0PJyTK1Fnsx3U0fjx35pjE7ZXsl
         XqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702210; x=1730307010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WK3Wcz0LjTp23A2ibh778TvWVk0jVp3LvtNmMQecJo=;
        b=b9BAOv0VLb6isyyujGQ+Tcvb23JolPkWwcsnwHEV43tST2p7+5+5gnXjlPkwASZ+iV
         O10EpeXZyo6xlVIe+fdZE1Na02GA4yJlEIJTRcqtqzwbAvWkXjUfBIq6aa/nXWH/L960
         zVUyO3KKm5SttbwkKoscBnM1Ai6/noVUHR+yhcG+0CE+QKKJJXA0WrST86/D2oOykGoI
         hu2wIMT+ipCaZH/jb6jQfm3bbBRi5TD7tkVo8j64HdFESkNMpqz3HVddSyowQt6dlD4f
         zDOKHY+95WF4J8YeBp33ixZC9lf6UqvDVpxoHV4tDGWHFLnPbMsc6AxGdqH+ziTPj5ht
         DDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgH5ilGpLp/YKZmuLBD7l6K8PWNd02M3S7sKdmFiOwFTLrWpn8FbqKgOJ6wD5wmPunQ1M/bhMDePpMvus=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo/KmN5JCKT/eJRiTwO/52NBgIGI8TQLbI3Y+awE4MkaouPaLz
	wF6hjzpSFYClKPELIhF8N2wD83QsDwvxZ1eza0NtBQwbxlcDU00RYP/+MLf/9ak=
X-Google-Smtp-Source: AGHT+IF8V/3kWZEsM033mvmCNVLqu8ni3b3xlel5RuPa1mpKVOt5Sj94RWpbn1HR47WB9YguGyyFfQ==
X-Received: by 2002:a5d:420f:0:b0:37d:47d8:5fff with SMTP id ffacd0b85a97d-37efcf7ecc8mr1949275f8f.37.1729702210382;
        Wed, 23 Oct 2024 09:50:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:09 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:49:59 +0100
Subject: [PATCH 02/37] drm/vc4: Use of_device_get_match_data to set
 generation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-2-1cc2d5594907@raspberrypi.com>
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

Use of_device_get_match_data to retrieve the generation value
as set in the struct of_device_id, rather than manually comparing
compatible strings.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d47e5967592f..3099292f22a5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -300,10 +300,7 @@ static int vc4_drm_bind(struct device *dev)
 
 	dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (of_device_is_compatible(dev->of_node, "brcm,bcm2711-vc5"))
-		gen = VC4_GEN_5;
-	else
-		gen = VC4_GEN_4;
+	gen = (enum vc4_gen)of_device_get_match_data(dev);
 
 	if (gen > VC4_GEN_4)
 		driver = &vc5_drm_driver;
@@ -462,9 +459,9 @@ static void vc4_platform_drm_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_of_match[] = {
-	{ .compatible = "brcm,bcm2711-vc5", },
-	{ .compatible = "brcm,bcm2835-vc4", },
-	{ .compatible = "brcm,cygnus-vc4", },
+	{ .compatible = "brcm,bcm2711-vc5", .data = (void *)VC4_GEN_5 },
+	{ .compatible = "brcm,bcm2835-vc4", .data = (void *)VC4_GEN_4 },
+	{ .compatible = "brcm,cygnus-vc4", .data = (void *)VC4_GEN_4 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vc4_of_match);

-- 
2.34.1


