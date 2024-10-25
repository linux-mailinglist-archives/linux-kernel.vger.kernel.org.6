Return-Path: <linux-kernel+bounces-382220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93449B0B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB36F1C25B34
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933C214420;
	Fri, 25 Oct 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="V+xcY9lY"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F6231CB6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876567; cv=none; b=kwfhCT52EJjgavZ2/d8sMLh3EQL5/po+m1wqUqs+iE7Y3zXxHdfCLk9wzqcUk4nuSSrhFwZVOL36XtsBCqyV3Yn4/NqizgstIaqDiVFM8uyvflfMaPyF50FPxDZIf4wRpXchityFk6JFlSW1tfTGjg1QZvWliUpWuSbfGJMAAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876567; c=relaxed/simple;
	bh=FQ5F+QORxSN0hqjJB03JSaZBLHg3MohVrt+mbUZveP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqmP8boTcZgMbWXwxZvvYfHjhNiFgjtd2Y94QvoHj6m5iYUTD3D8irA+Ct0ZO3NXvBaORhN3FylAyu96q1Vn+X7Zq0hasRlz9AVCehFSp++l/CIK14F0x/aB8d3mO15+bfcPS/tUviFIg7MzR04MrR+cyCd1uEX/MPZcFeK0dDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=V+xcY9lY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d495d217bso1930600f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876564; x=1730481364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvdhnqZWhjJaVRixzXDF8i8NipPmGHymdrTVaS8WSIY=;
        b=V+xcY9lY8+VhefPvWzvQLqs6bq0IAfYlzx1Qac5aIVuRmlDHdaUyzI0yM3j98TAlW7
         msIv9Rj9FxN7fUfMilC5Bd8V+6S1VIIBfTlJfwvEsEH9rWMSs1hgRTTZgqXsZ1M6g71X
         toGhaowAE5/RXAVcJw4kuyeLnwyhla015DwIqXqJtrMHO8kTvN8aJlfEJELY4y47GNQy
         9cB8MMLitLuRHd4G5ug3nnR8bdEuvsica6nqnmwcD5r8eTVQuBw2Pn0Fgn6ct4Cf5agz
         aZ4Mfty0uRIl5z0nv5dmgoMh0D0poAtOyOKVRz01XpYFrzoM7iCrm7msOqWYE0SxCySs
         E6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876564; x=1730481364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvdhnqZWhjJaVRixzXDF8i8NipPmGHymdrTVaS8WSIY=;
        b=VdvWHVBBiPXO2kHqxrVNYmUFAvs/QfHZlS6UCOc37ZXRbq9Q0AFxee6oWfE7yhz+hg
         FdnZ/EqzdBPOmgfZ+iMao2+Dvan5m/ECNqvaP/6w4rvp3RZn94LjVUXPnNIFtwhuaeIV
         X/uGXdc9vKbQu5PAphzIub0oJscbh9YRUM43FxUL+JSJvhojsQBlKGzPo3s5e9TDUv2A
         Bp1/0z0aU12Z/VR/xdXYmQYPSZZP8aOq+MpBv6hUkwGjhDBy1ImX+nKy/KECDYWxSF8P
         vWLOC9fM0kyp6EBIK6wetHMElUKF/CTsBi05ZkMyJHf/I/0DMQdJQVEule19E1f14eJA
         HGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMkZu+urDTAG92r9tVkm/5OndEjanHE6Yxc7tvr0c2IvF0Qr9hoIRZQ9ji6Y4KSfpQbfuFFSoI1Plwr1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXaZby2O5gPmGSyiNyAQIecBE1+PNIGU8IlsGk+gbOg3ebCHG
	LFs5x/0aPoY1SikZgDGXaoeEWXZMevgzlp8WcYX10UW25lBBQ19uUe900Kw/DY8=
X-Google-Smtp-Source: AGHT+IGJw1+OsEH13czUNrPVKJZqUz4zqCjXXtEZzfN0U7VM1+Tkm4ryrjbOYe8QkQQMzLnZPTtsFg==
X-Received: by 2002:a5d:6a07:0:b0:37d:4619:f975 with SMTP id ffacd0b85a97d-380611727b1mr120000f8f.19.1729876563675;
        Fri, 25 Oct 2024 10:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:03 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:34 +0100
Subject: [PATCH v2 03/36] dt-bindings: display: Add BCM2712 HDMI bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-3-35efa83c8fc0@raspberrypi.com>
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

The BCM2712 HDMI controller uses a slightly different HDMI controller
than the BCM2711, and a completely different PHY.

Let's introduce a new compatible for it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
index 5b35adf34c7b..6d11f5955b51 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
@@ -14,6 +14,8 @@ properties:
     enum:
       - brcm,bcm2711-hdmi0
       - brcm,bcm2711-hdmi1
+      - brcm,bcm2712-hdmi0
+      - brcm,bcm2712-hdmi1
 
   reg:
     items:

-- 
2.34.1


