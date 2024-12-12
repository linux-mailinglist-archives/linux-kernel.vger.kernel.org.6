Return-Path: <linux-kernel+bounces-443453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709529EF1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195E6189A0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92712343C6;
	Thu, 12 Dec 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="LN8c1uWk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E7223C72
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020350; cv=none; b=mQN85chrrLiVs8Q+Iaq6Z/D3QRUyom+SSAYl6MOepkeWD0wTOLejXzEmwkpvNhuRTc02se86dNPHK1IAILzzCA+25lCDpOyw/m0i/GYI3Xnkj0e7ov9y7c1D2WIjMZUd5tEfPeVCD79Yu+8JmfpNL2CDkeF11yFo00VWNcZEOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020350; c=relaxed/simple;
	bh=z49WJ/Ecx3cRmoavwvCyrBSrNBZWdJ5YBE+eW9OtjMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCPRK1mqwlbRouc/XQTxRGKdJMYW+mFgrsYM7KNu6f4lfTIzKKo2dRGbbU5FWpv4TrUvA5JfX/dF/7AIzzLBFrWjlS7B266fEVaLU98TDZpFzlRKeCZuXR3xEb1ARqer3jYUjxwpfC0nL4RAdKUps47YN9gOKl1inxV5Jef04EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=LN8c1uWk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a736518eso10288405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734020347; x=1734625147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fzut7xbqOYPi19sCzyZBocxByvsBqwohQ5FyR54rsTQ=;
        b=LN8c1uWky/LtsLuX3IMAYIO13wzKVv6rQ+KonJdKsm0AcTz6fEmhwIkf4nIYfEVwOF
         41MSaBvPoSGGJb5HxXKBaJuBm6FCcoaOHk1jeQ2aMZWjis5LDmnvnTbx3+hOd+XLu5By
         cpizOCm9Vf22CppP3GnY2xBv44Ulb+gtbFA8Bjjia+ke7BSNu1obegNEabbqYPco7jd7
         RGsEfvDdB5J3Mx47grWpo9q3GWTz+Du1qLRktQkvgk5Tv0h4O8QneiLJc5Tslo2wC83r
         Oehg61sxLO7eECzjKE/c2MHOJisWM4lEdfl1POlGB4XJYtklDn/JsUsJQomwZd4s5Q9D
         9F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020347; x=1734625147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzut7xbqOYPi19sCzyZBocxByvsBqwohQ5FyR54rsTQ=;
        b=PbMFh9t4/JcBqfVvIuwSt+JWeBBZyX+6uYSYrTuvPAVj4jOuOM/dcvfWI3sN26yKiO
         Xv8mp1y/+0jp/QQVQREYWiidjftOJL8MOdFhAeiqtUaSGeC+d9WCmhPnhJLrx5HQjQCj
         ryHs0SJYGMN8YjclFenXcEZChgznVUSuNc7HIPVDqnKzX+mSbW6MDZ0GIuhgS65n2FUx
         oykqaRUIPxgh11vxwLlNAnkfTIucE4C+QZNiyV17Erv8gR+L8b8NBvfDUrwOLBuV70zv
         J3wzX202AwBEAGJKEiW7vu/kXTCx2UFz153SZgv2hmRzESml5U7fpBE561rwX/RdLdMs
         34VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sLDG31HYzsbMalo8o21ACzeG2fI7iKmIyeTBV3qymkOKCFh4yVV1Uf581KoSCVkgJ4M/U5YbOC7l9OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurmqpahOZQ+7AGgfVt+PfvF5IlxdKI1PcyJ1waYPXAYyuPd/O
	JTquJF5O+Kh074K5cD1gdvRzRGnQmL2aysuFZEqvZrt3/6NgR/sfG4BNfkIMZL4=
X-Gm-Gg: ASbGnctqWgEIPHbQLYi6ey5Q3Gs+4NwhijZDLcCSkjef9O3Nib+VPRYsU3aFfFlMKbG
	kPdAPruBI3mRBfFf4/w/8aWEuA4wVlkVLu6pRyNSF5XGrQUXgSuZU6utftaGT1qhErBaSPx5wxE
	H8BaFTKG1mbkW887O2okMlhVsvSDSgW6cXo1aAGkaQpi2N1vjhC61yw6f5fnkCTjOrJ2/xu95XB
	0RkL6u31+KA5srh4HdhT5Ut6ZdL2JNHIzYkMirwlysyI1b6
X-Google-Smtp-Source: AGHT+IHoZqbjRY4dxkOhKOSnSfMy3sMqazkkzCHwzeDCSj2+qMUGuSSsMXf/szART5dZ1m3BKwwUjQ==
X-Received: by 2002:a05:600c:468c:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-4361c396ad1mr69550575e9.5.1734020346842;
        Thu, 12 Dec 2024 08:19:06 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361e322328sm44336105e9.0.2024.12.12.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:19:06 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 16:18:53 +0000
Subject: [PATCH v2 3/7] dt-bindings: gpio: brcmstb: permit gpio-line-names
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v2-3-35986e04d0f4@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v2-0-35986e04d0f4@raspberrypi.com>
In-Reply-To: <20241212-dt-bcm2712-fixes-v2-0-35986e04d0f4@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

gpio-line-names is a generic property that can be supported by any
GPIO controller, so permit it through the binding.

It is permitted to have a variable number of GPIOs per node based
on brcm,gpio-bank-widths, so define an arbitrary maximum number of
items based on current users.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
index f096f286da19..fbd69b4cecc7 100644
--- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -64,6 +64,10 @@ properties:
 
   gpio-ranges: true
 
+  gpio-line-names:
+    minItems: 1
+    maxItems: 128
+
   wakeup-source:
     type: boolean
     description: >

-- 
2.34.1


