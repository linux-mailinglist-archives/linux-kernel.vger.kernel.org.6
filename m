Return-Path: <linux-kernel+bounces-378500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719909AD190
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4CD284F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1291D14E1;
	Wed, 23 Oct 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="j7qqNL/+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D91CFEB1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702218; cv=none; b=f0Ff//wRbmS4IIU7Ua4lW4sCG5xJvZf0KLz931L4PYXSpMN2gIBX/DpYOxKu9M4i0k8HY4cnoU/GW19nf/FwVHq/LPpZ9dd3VGP6qVk/+/RwYpSq/0QCn93Nljq4xvawx2i1tMVVo4MwkSiVDHHv1b8n3hGfk8Nu4xJlVs1HikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702218; c=relaxed/simple;
	bh=wluIXe1MEVk5FSOrqpni5YIVgNcieamBPIp5PPJnleI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wu9/28W2Gfw7TzFgl2j6sfFH6yT/Zz60v3YKMpvmE1dOUwn4YuJ7oC7cQEWwNupYfNt26n2BA1eY0ABK5cU+Oau9reyDHZef3yLHQcAcITL9gdUisR8RyWtgs1fJtMOvTtnRVisb2LdPkSwf8hU4pQ6G/gbgp6DI0uQ2gI5ZYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=j7qqNL/+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso4873746f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702214; x=1730307014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsBVoQZ8zap5DslrzzzsVJMIsK4Q16E87oM6AvNUOjA=;
        b=j7qqNL/+xrIYdn9KSKRvQMw83pePtN17jJbIwI091MkoiU/67TnyqcXlAas396Qb/7
         uvwCbe3ONyzWYMkGfDwUJK6hPURPphm3kmkDq50p1nEstc8eQwhdUKSG7hpx1NkbzHLf
         7Hag0IJJohewIfsD7KnB8gHvCkvjCGn+SLc72bMQZfiPa06MCFsKhXXR0oxBr86ThXWt
         L1UNsTpQHxWlnE+X6RfZmCmqDkwJOqBLUApPQ5Qzrrn+aJxE8Lj7Fey5N5HUqWynzrMu
         FQF7Y+QMnCxWVa/uZkTZYNozoA1grafJXUlKvmkYWm2NAcdp6B9bmmwxcDW8qtrBAjhA
         BWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702214; x=1730307014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsBVoQZ8zap5DslrzzzsVJMIsK4Q16E87oM6AvNUOjA=;
        b=OaRBk4XyFWZDqDpCkhH2v8H3UAbt1M8B4BykeVN8Ym91G4r4B+Nbl/IX5P3lb3POnE
         AVYX2ntuaK7Ezqxt5D49a0/CPweH8EF3UrYsmOL2jJc6h3bwZ0hFFadA2KPATm43SVk5
         hL5n+Z94D2rp74KlRxE7rapxzHuV3JXeTJX7/yyY08HHZ28I05Kz0saY8gi+pRkbapC7
         NBhOzlYR7VT/IYYwiciPRw4oPh6ZyLCCk24uejnrhJkUKEZwXTJn+eGUlY4GlJVmr4Kp
         RUK7XA26EbcayGtF2U749PoTEGIkCuWF8fJ1i1R+Sl7DZVq/+nCoO/I9xuRE2pwJbGTM
         BaJg==
X-Forwarded-Encrypted: i=1; AJvYcCVbUvKQqjhMRNn7WNWuOLq+lYwd1TBL2XZSG5eXc1M9DNtotCyDrvqpuQvmygBDAGGR4JxSE4E3msMaQ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfGt+UuabXubrAtu1d7mSzwh88ZvFTBdGKUlPqEBKzAgUQVHq7
	4TE/FA+jqGdPwtdpRTKK2TnHujCBD4gSSPb0HFbUs8q396abzrvRxyv78bxFSnk=
X-Google-Smtp-Source: AGHT+IEPMevLaP10jHP2kjP5QjuvQyoeAseVICs2i6vuIJvW5BstXAY25poTAtlyrCUn0K4+h2nj6Q==
X-Received: by 2002:adf:f6d1:0:b0:37c:cfba:d16b with SMTP id ffacd0b85a97d-37efcf84673mr2298249f8f.44.1729702214024;
        Wed, 23 Oct 2024 09:50:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:13 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:03 +0100
Subject: [PATCH 06/37] dt-bindings: display: Add BCM2712 PixelValve
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-6-1cc2d5594907@raspberrypi.com>
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

The BCM2712 has 3 different pixelvalves that are similar to the ones
found in the previous generations but with slightly different
capabilities.

Express that using a new set of compatibles.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 .../devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
index 4e1ba03f6477..6b5b1d3fbc0b 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
@@ -20,6 +20,9 @@ properties:
       - brcm,bcm2711-pixelvalve2
       - brcm,bcm2711-pixelvalve3
       - brcm,bcm2711-pixelvalve4
+      - brcm,bcm2712-pixelvalve0
+      - brcm,bcm2712-pixelvalve1
+      - brcm,bcm2712-pixelvalve2
 
   reg:
     maxItems: 1

-- 
2.34.1


