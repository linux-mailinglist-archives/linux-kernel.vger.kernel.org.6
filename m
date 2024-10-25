Return-Path: <linux-kernel+bounces-382223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0B9B0B27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796F41C230AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1B223A55;
	Fri, 25 Oct 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="hq77L8ag"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54D214426
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876571; cv=none; b=GKMA6f2NS4XbY6HizQ1pba2jwyvfi5XCcrajrY8/He7tfSwqwCmAxbLYb1u3tZVHUCWpnkw9D15V2/113T7wFYv1RSZz4ag7CX+GSDcHytqQ010OpBY3b7nhOu/N0xOD8c0tMrB9ocYV+2vtPsKq3RPSQHZYyFwQkwl5HV2o49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876571; c=relaxed/simple;
	bh=im8lPEqPibwrkF20d8j8rEeYbRDE7CTkHJHOC7HO310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MF7GcFTw9TPa9tJzNkNk/zSNzdTxqX1x/bBdK/tFCUh095cSEyEpMGlnC1x6w5Wm1ugA3opbiVGuN1z8rdO8kr8dJhA4+ZOWRyg0KbgnHsOmL1nj9BYmiBc9GsrP2a5ikGucRSwTjXSgVvqP+hTaJt4sT6oB76wXvXxITreEGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=hq77L8ag; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1770268f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876567; x=1730481367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3D0msUfHXMuv4C1SeqQ0nPQBde1GE17PCvfA0szIc8=;
        b=hq77L8agFTQHoKn/LUIhqFf6iqy6b+G1eAnm/qLM1cxLur0NTEegbLWzNJM8hEh+Of
         nFX00/o0m9xoZBJjhRlO3Zu4fpfcs550HPEkoBA9rmXVrrqrRFmcGwIeDVtCnwWzvXNC
         yBmyaru0/ptOat0zlO4NeedWxcMW4B1dDC/0c+RebeE4/FR9M3x+U4d2rAfwHV2tJSvz
         vHCL2C+pDBCfazM8zxwjJQjxwTl7j1XizllsDSA5NJfZzMu0MJNrqkjN3bEgdGkvZ5gk
         IwTeRGoqUbKPmHETc+4GemGhrhyjRGKKz5ktRwLyljo/m0C04TP7QO8btNpmjmH1wyb1
         GLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876567; x=1730481367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3D0msUfHXMuv4C1SeqQ0nPQBde1GE17PCvfA0szIc8=;
        b=BZ6rJKFihmBG1RnlS0pBX57f1To+hv8xuEHFxLvQP5/f+bxKTAjsYzu7AVDK6fHUSl
         pn3CfGpFMM2BkUn1u1oBIpCGE/sAn/VuEcpki5pMC+gbyMU2wgTDQtc5aNdTRdx+OyIn
         bOLM71wuaUfnpCE5QPfqZlgPSSV/fveipfg4vyTdp9Ck3+fc7Fm8iITtt6wgVVSz2OR/
         wNxSvKzFNtieDoo/A6nSQ1FLzFEaaDq/PdHzj7Obm/wi5ogD3BPZ0EFehQRE7sqg8Zav
         AGwv4ysDZsvzIO25YICTi4CiwbaAxs7rVJIqlbXJyqlf8xTa4nXfz2RkCKrToriE3T72
         OOpg==
X-Forwarded-Encrypted: i=1; AJvYcCVPB/IIBDd3w2rsV8J+bkoTnmSIuOxWM282DtgdA51fmcyhTLaQy9OjBKe5C8mCtxiuaQMPxBbZxfVfGbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqqZtfOiE/s9dYxJTTF83rI9eU6aqAZIJX+G2wwCrDqHOJB/N
	8cN9bzA/Iqo8/3frUfvoTIw4BaIHYAz6DTDavX7/i+XiFxCQxiM++DNWVx+L+Hc=
X-Google-Smtp-Source: AGHT+IG4wS89LpASUknXmvnY5DCWRnrRky+UYDTB7/8M+xpU5UpHS3oldLC31P65rzLuem6Jwptv4w==
X-Received: by 2002:a05:6000:c90:b0:37d:511b:aecc with SMTP id ffacd0b85a97d-380611ff90bmr97416f8f.54.1729876566840;
        Fri, 25 Oct 2024 10:16:06 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:06 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:37 +0100
Subject: [PATCH v2 06/36] dt-bindings: display: Add BCM2712 MOP bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-6-35efa83c8fc0@raspberrypi.com>
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

The BCM2712 has a MOP controller which is basically a new revision of
the TXP.

Express that by adding a new compatible for it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
index bb186197e471..c9c08042cffc 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: brcm,bcm2835-txp
+    enum:
+      - brcm,bcm2712-mop
+      - brcm,bcm2835-txp
 
   reg:
     maxItems: 1

-- 
2.34.1


