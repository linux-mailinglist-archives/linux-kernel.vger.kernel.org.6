Return-Path: <linux-kernel+bounces-427726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2D9E08A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673D8B68296
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9A20C484;
	Mon,  2 Dec 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="iL9hfwJ7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0320C00D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149942; cv=none; b=lsH92rjuEZFoQ3N/I+Jw33yMfxeZED9BBIyRsYzMeTAlo2UPAwNwWpHKFRrkLxYuQMPljhj90GHdvyQ0Q6iwNdIjxayorvVW8i1TzusnGR6f2scA8bgMT2IMSbqPFsJvDdoS5BxW+yvgpV0Z16cEpSr8Yq2AG+kISkMK51uzcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149942; c=relaxed/simple;
	bh=o+XWrIWz9NMGyzj7C0rloJz0rrUxtTpuh520hN9VdLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKBvg5BHr4SDtmpUUSrOJ/H4HSEqWfCsr59R9/Q3fhtjOryXpBDAMeck11Oypwt8kraK0kozyrfFmwkTkNkU22GOvk6Bjtp85X/XagbX4wupWBRNpcc40wl9dv40pVjY++ROknQG9k9dSsvyRcUq/B5vyfah8LCSx15aMDqqTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=iL9hfwJ7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349fb56260so37462675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149938; x=1733754738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezuuCfz4dXYu4hmKXltppQihukLHouMCBa2+WZneZxU=;
        b=iL9hfwJ7oYOeQ0hyc3UkH++I8Tn74OEvyvNbHOCTQ73+qE2ILjTfGJ0KAhIYGBxLYr
         EzZr8TBPh3of+Np59n7sH0wR9PDqIThD+HZd9DBXkpmsHR8hOT06gnG4tMck45M5fUhj
         v6Zo10tg6+AtR91VjKMmDzpfSzn3DaeLjB1FVS/OaOedX/ozqz+mMED1ZXGdmyrlPoir
         2QgFTnt3b5FT5AZxQBgY7PtcmF7H9OZp/W6QUrbl+pAciwO0y6iJw7QiKBRBDuWSyUe5
         fLd370F9fTUeZN4DeDI/lbkFtHiWtH6FhDPX+F6aoeMD1nUf5IzZbF17+hRbKt4Zc920
         e2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149938; x=1733754738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezuuCfz4dXYu4hmKXltppQihukLHouMCBa2+WZneZxU=;
        b=iaYjdv/JCid9o/lFOTus+VZh3c5evjzeKz/ghZRlTaOgCfLD+2Ws5drskqo5o2nvaI
         +mG+oXXfz+/SV4fB4RVPqI/pBlv81m1DHLFd/m9cXZJ1rPGdy5rmW9bH3Ny/epTwsVn+
         CN6HBDqfMkcHKs3G2/Fx7DiXvDBkWbbhvZ55rKQORBlWrNhI1G0eVTrsKgRnYd4rac/r
         n1o3ioy4oJ0NjYKu/cgwAGFEdgvDIXEWF+HwN2QuA1i5Lq6woHfABVPEGVaMNsi2Hbjv
         ETKWrkn/SjAbr8G44hSA9XqOrFns3JBf7af5giEXGRnF9tC4vTFbX0wncxXKmyCVe/Oj
         YtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ePgNMquG3xDo86M+4tZwhkkb+rUawJKGzW/LSfrkm0oHJrxVzD/V1taFGD5Ahso5BvwNL21+MO/a8Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlSq+OVl6uXQJeAjyu6qvbEr9ZWoCf+hxz7N6Uk3aJs/TDxkbc
	LaqBYGNuK5mgYX6in/A+x5a66q6X0lreDLk6dEKPSa+q3R3pQDPsczIegz5PIuo=
X-Gm-Gg: ASbGncsCuXW4+VfKKVtV7OgxYoY/su8CMyrTn9TEfDWV3C4FuHxuN4y2l1AEj6Y90j3
	uSxtlIrzn+Erp9pU51OvKhV9LrZkP9gOi91q29eCe59BR0R0ykAi0FmOEJjqSYW2C4x1u4cyGNX
	7Hb9j7c3Q3HSd0pQSMfbpG+Hhprg3xSYKU8MWTuhQkIpr13Nivx/9AjFR8bVesUz/XAGLtQk6nm
	GX3BTIuJy6nY6OETRVCEXAFW8Q0WeX2fxN3q0NbYg==
X-Google-Smtp-Source: AGHT+IFOZoOXIOMn7ZNkA2Tq2IsupVCxJJKuWUAQoyj7TMD84BgwJO2qsC/1IZqo9dXxiJ/IAPakGA==
X-Received: by 2002:a05:600c:474c:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-434a9dc824dmr223443175e9.16.1733149938198;
        Mon, 02 Dec 2024 06:32:18 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:17 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:31:56 +0000
Subject: [PATCH 3/7] dt-bindings: gpio: brcmstb: add gpio-line-name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-3-fac67cc2f98a@raspberrypi.com>
References: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
In-Reply-To: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Support comes from gpiolib, so permit it through the binding.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
index f096f286da19..086d016df6ef 100644
--- a/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -64,6 +64,8 @@ properties:
 
   gpio-ranges: true
 
+  gpio-line-names: true
+
   wakeup-source:
     type: boolean
     description: >

-- 
2.34.1


