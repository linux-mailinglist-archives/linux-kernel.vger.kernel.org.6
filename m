Return-Path: <linux-kernel+bounces-382221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E139B0B20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9ED1C25B68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A88F21F4BD;
	Fri, 25 Oct 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="HJjVLcs+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B11FB8AE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876568; cv=none; b=f+2wpsHy80EcktdLLcHKvJ6iznHUrhS36bZCfHl6iS/xDZGgtqEXccX+PGSGa6SijaE8nbIjKDY5T67Iqwm6DfS4pH4LwZOC8bLnkpwdXIsoiYEDvAlpLMQV+5ZLdGqrzlVDyDa71jawkmm8bUSghvApbKQwLES/hOEqJzlCeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876568; c=relaxed/simple;
	bh=dv8rXfxqR9AoaKXMEWoKx/PzHL9rfreE/NSbe58pUjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9uRMY1DeeXUVeL0jpe/CiIDvMV+eOMIgx2LAoXhuf8BlzmVufBinDGF0TTSReGSLiQJQrGtCDdlah7KEL9x4s9l5D/ujHeeT5oXljNdeHN6tOhw9M1PiHWnRehPzb6SVwBk9TNZa0WCezIs4fJcawd7YOIXbMWeDL/IV79Y0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=HJjVLcs+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d58377339so1728572f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876565; x=1730481365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7a7/HziehwTjKT233D/IuQwrsCio9lv2e2bEhcrly0=;
        b=HJjVLcs+IYrKCIAFPllcMjTqWsTYUGTjnYy8bsc11ErFpesqL0/OfFmeURCOlAFw6N
         cA0VjAtf1XA1GuvY5lXk/fVmvP/u7Aq+cxbHNhfXQpTBRKWL0Oi/wyR9G377wnJX9Y7W
         Vc2+5ZUaSNkPnewVwHMN1iiRa7mZsOfH8AzWdM2nni4G7y4b7ZYD0XCxa8dSdV34sTWP
         b3PRvEsh719ni0A6bOp5+UXVAEYns3UzmHzwLixQAWoaTnjck0c+taIXv6rnyR0au+36
         5KaT5YltUO8riZGBSh7PoWJtUeN8nynuPauzN+31PIQ1j1gZZZX9cXzSQn02dIMfLVgq
         W9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876565; x=1730481365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7a7/HziehwTjKT233D/IuQwrsCio9lv2e2bEhcrly0=;
        b=nfXKnpHgvjs4/GGf/7s5fqbp1ChRq4NWPhs6ONYXaLrB5SDjUbTqMpmj1u0jEmqsVB
         p9GdWU0B3V/qXc44X0ZVWlM4TLHs9p8br0R3o5q8rir3dHzBrD+GyugZOgsFezGkxfY/
         C99tVegcZuT+Rnju95Vz3A4DXCsI0gFlRf4EO0yCBU4TtNhsT5CGw/bYS3AmnITDEgoK
         QAjK5+v/Nx5KXYcw4hMhscQ1SfXbUV9vYCCdtQZiGDB4Dwllp5gsvQy+G7FSikV1XOgu
         H5KzgBpVAfRsDm9a8QIU6H+0JqmYf2b1c7+aFCCs17kIEpVJHEetIYD1Qge5zf+NE0Ao
         uglw==
X-Forwarded-Encrypted: i=1; AJvYcCXA3wYyTmeeplQT++80UM1ausoCWnSU2XacAA/8caxHLkGe3ETdLHNXGt+Kot+Nx9DmnIF1VWSzxY8ycc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQxochcARNC5Z4mmjDRQOIBCMEZAj3uqSSVHmD/S3jVS2lt1+
	nUKuRUlX7e1YiOq1lvt0//AZO+rUY4FTbMpS8eUk72opwFZQGRM3kr4QHYLm/nY=
X-Google-Smtp-Source: AGHT+IEFF/mt9prwLkoO/wBDShJYk4RCDN1nX+/N8QkdDrkFHXlIdTeqdVrZSLG6RmWbSoiHWDwtlg==
X-Received: by 2002:a5d:4106:0:b0:37d:612c:5e43 with SMTP id ffacd0b85a97d-3806101335amr193017f8f.0.1729876564669;
        Fri, 25 Oct 2024 10:16:04 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:04 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:35 +0100
Subject: [PATCH v2 04/36] dt-bindings: display: Add BCM2712 HVS bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-4-35efa83c8fc0@raspberrypi.com>
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

The BCM2712 has a completely different HVS than the previous
generations, so let's add a new compatible for it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index 2e8566f47e63..f91c9dce2a44 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - brcm,bcm2711-hvs
+      - brcm,bcm2712-hvs
       - brcm,bcm2835-hvs
 
   reg:
@@ -36,7 +37,9 @@ if:
   properties:
     compatible:
       contains:
-        const: brcm,bcm2711-hvs
+        enum:
+          - brcm,bcm2711-hvs
+          - brcm,bcm2712-hvs
 
 then:
   required:

-- 
2.34.1


