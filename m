Return-Path: <linux-kernel+bounces-427729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64259E0536
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3A284F96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5C20CCD7;
	Mon,  2 Dec 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="knUY+1F2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7820C02D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149944; cv=none; b=tASgWkg5i0TcUSfibB2yx/6uFrqQz579PuvZ5cDoS20//Myeqo7hrJa+olaJny/lCgnIh94gBr8ywOS3k5rroqXeabUEgK7vyiBQ3cMfiuRbvVSaPnqyzeS1vl/Un6cIAUr1F30n0RtImQ0huwamOeqCCnISdOiT9fJ7W3DbThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149944; c=relaxed/simple;
	bh=qsen7kpH4VQmiESFj7V0wT47esSpDLB8//iY+z6pNNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMk8/soCyiHVZDx1WZidBWdktziDH7V8Nak5eovT4b3syVd1rbbVenvIk1L8JYNYq7JzOF7JXLiAprHbKfHhRYwxsSur773O08s9HNflkF7SrIMSfU1pf+jT2TH0yUAEkDT/zFO613p7klKG06Kf2caDDPPgw8pvcO1oWKZVC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=knUY+1F2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349f160d62so36587455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149940; x=1733754740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SWv286JLLtaOue4mQfrx4lljgfdeCl/Poe2xcsSj1A=;
        b=knUY+1F2e7K/fwawvYzH/1/EM+1DSin4RiN2Ki2sDeDLKyV8J0fQA+Zf+1BFeHTi6s
         SVbJ1Jn9YmzpQodv8TCGiHMLAwzR89d3vICtHYwmhC+DzUto7ySOgIJ9HPXe9mZEiBFv
         fDYUQRnnlPxuUv70HP6hUY7MWxpFsokegHVh7tPKQM4BSR+KAc4RBu8zPZt2voP3nhdK
         DUUasswnxDVFB1uZbKsZn2tZQNDoaZrgvhRYcx6vjIZGOJ2onZzIlaaQ/MhzB4wrRvky
         b7QDsI1kSOrvI6P2DyKrPoEx1O2Et21LMuFPesVyiS17IkYjVHrR6LpbI72+ItzOzJMj
         i8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149940; x=1733754740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SWv286JLLtaOue4mQfrx4lljgfdeCl/Poe2xcsSj1A=;
        b=UuWJPKmDS0ssvsYAkHVIJjZpmyjBlX5C8unIrZ17e/jYvbl5wY7SxH67oERNSeMLoP
         Ehw9opXnY3l3l0B2nAumjICvCKjwvKspfGVyO7e89jBmiYhVm3oMoUa8ktURVo2iNbA8
         IBzoB07vwpAO5wPquMQd0rtEyCyTGvBDzZDlswjGcH+GnCcSnOOca5TDDk3155q5okP5
         QUzuCRm727m3NzG/KzHOQPye4/iU0g4TrhJwA1o4U1lh/aWD+1V3BXuancnZJAUn7qtK
         OcLrTGjmir7sPYJjNZSm0AS2jIED2Vdg2XGp3OZ6VJ0gec9Y+zp0Kho1EBH5++Fd6ygK
         3Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXshUBhZuqM13+x1WFbmdQAZLzz4NvdU+xpkQ1u4I1IyZ+sTG44NB+4gqBrnMR2SoWuWAzzBPxeX7HHK50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTh0P/LekOve2kbcLhLPJmjKU/MvZ+KpoM8nccHN8HM3ueN7Ki
	bfVOaYpFsS8k5nGmxSiqqSRaZxkntHcs0XGlpmJhBWalRti3+FqaCaCZ12EKSLg=
X-Gm-Gg: ASbGncubknguetCtuEebATrN44Tblu6U0yOwNbVIGQ9Ve+heo2ksywhQpkRIL0MxPNy
	cmx6wp6ddPw70SkDAjL9N8JGYgEqSMdw/RCsZQJSy8AVPG8+bm2fjpciZAbH4OVb8d9ue5UEJqW
	J7q/RHckAT/9BtpZ4adXqCco/xstmccvffATCVwxUwjNfqY1Myea0GXhsIDhEkLhZu+bNeOFcdk
	C193h1WWarc6h06XCloEQkYi0QWYg32E4TTS9/uOQ==
X-Google-Smtp-Source: AGHT+IGdEnNzVlMLwDBvV0S4CV4yuBsyp8Dkp7xJueCrLVsr6eLGBmMPHRLxa0QvyyA/TmmOBjlOGA==
X-Received: by 2002:a05:600c:45c9:b0:434:a196:6377 with SMTP id 5b1f17b1804b1-434a9dbed9bmr221354295e9.14.1733149940210;
        Mon, 02 Dec 2024 06:32:20 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:19 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:31:58 +0000
Subject: [PATCH 5/7] arm64: dts: broadcom: Add interrupt-controller flag
 for intc on BCM2712
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-5-fac67cc2f98a@raspberrypi.com>
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

BCM2712 DT was producing dtbinding validation errors of

interrupt-controller@7cd00000: 'interrupt-controller' is a required
property
interrupt-controller@7cd00000: '#interrupt-cells' is a required property

Fix them by adding the required flags.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index f42fad2d8b37..0ba076ab9caf 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -224,6 +224,8 @@ mailbox: mailbox@7c013880 {
 		local_intc: interrupt-controller@7cd00000 {
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x7cd00000 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		uart10: serial@7d001000 {

-- 
2.34.1


