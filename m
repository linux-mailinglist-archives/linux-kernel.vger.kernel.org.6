Return-Path: <linux-kernel+bounces-265746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336493F57F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200BB282E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173D14900B;
	Mon, 29 Jul 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACX4TDOy"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1E1465A9;
	Mon, 29 Jul 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256470; cv=none; b=RkQUpfhPI9ly6lBd6GLkpZeARA92U2f109qrdKtEvEUjC6mawrMNddVpa7mjkXZF8knvVVe4ehrBLgJlLpJCx6+J60qYr2jr06aTICqJu0WsCM2kenZJNaQeVfmgoZ0O5a38bScdrSo/o3Y67AliZkwhf71aKOZzqDYd0vvVxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256470; c=relaxed/simple;
	bh=4FcpG6IbFADmvtblRtk9vXV8oEzE06lVCRQDHzV+qJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgMULAC4KndiQ4lf673hxFypwb47wrqHttB0LYPSTGo9ZI4YHdoQ5LVvbplSobvIPBY4qaX0SI8N14sZdN/Nql/UdgXq/1969UrQj/52BSNnDkgvU0R3IkbueJ44QYwGWXtd5zK4xcK6Vdszax/iy9VRSL5m5v/NNs3JlwXQzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACX4TDOy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so677358766b.0;
        Mon, 29 Jul 2024 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256467; x=1722861267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWBxa0wp95pNfqw8iTBuh7KIx2bGeIDEbf28wFPwYBY=;
        b=ACX4TDOyPQ0IlWeE0jxUuFjYnHsM9uerjSjft5Vl6GwjKGtOEDW6S7p2hWMB+D7P8j
         3sWst7meUQZh+7ukXfBpjRYZ9OdI2qP8LRp4cJoDo7Pc9Ahz1XWD67nZm501nSDAk5ff
         LYJx0gFkccW1tv8tpO+8XInRgOg4ML5k+sNUBGGizm0l/cnBoeDECjBg8jcNb0rE1dLQ
         /mSWJP1X7FIndzrdf4k4Qi/KHiBpedD29/ALEDcSUxM0t9h1ntkH4rrAT6UEnMvtrSb0
         ibMaWZE567KunzpYWsXncVvUh04no5iiT/nn7LldNqoa/BcL+/s44fZEEgOp+vTaSY+t
         S+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256467; x=1722861267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWBxa0wp95pNfqw8iTBuh7KIx2bGeIDEbf28wFPwYBY=;
        b=NhW9o6jMTFLDk7uqiLCkgwvWuRnotpHq70WjZGmp6PhJUlDvIsHdgFJ3xWxf/SrQY8
         N8jwcC5DTQc1GTx27kKBvMpjDGiK+SsH0irfg8+4HbxWQX/YKZ+OAdDB3b6f3zCqPnKH
         l3sUgfWUvKi8sHv9S+MkGQUOABMyYYIPym+EovLm+5W/iLMKJ3Bvs9VxKDWISQe/YV9f
         MoblOH1hCYcfWH81AkW9i5I/+gDfY/exq+WyxFteXSnr2bbtbNBgdHkSaHEmdcnEs9EP
         3uARBpgNwcMfVfVxPpji/6aXTk+f53yvo82OyAfNzp3Z9pHz9c1pHYbNiZttgnGtRTIq
         8TDg==
X-Forwarded-Encrypted: i=1; AJvYcCXPJt0tNC4kqR+AWGikZzxG/KZ0eZsLfx+KVEgP6F90kGQdsh6NBnTHp8Y8Jl2eiNdMKW9XXLzqHHUrTGj3PJvFzZlNcOPqsPom3lyHMCWPg0yQnbhOdWRUm3O/LMeNqLoftwdCBBnXMw==
X-Gm-Message-State: AOJu0YyuwFE+A6GUueY1Qy2OAQAnJT8zP2M25XUef9eFQrC70XphhivN
	XtVYToqwtzgchvQNF1DekS+8Y18jPbQIt79Hx5GhRHk42084v04Ljs2L4w==
X-Google-Smtp-Source: AGHT+IE4jzg7Snimtrm+b02UgrmQkb5m+QHoU9OiNUCh8BJ1KaQhLCbkN+PXZvHKBqfym3G3559o9Q==
X-Received: by 2002:a17:907:944b:b0:a7a:a2e3:3739 with SMTP id a640c23a62f3a-a7d3f89acd6mr697017766b.20.1722256466753;
        Mon, 29 Jul 2024 05:34:26 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-159-154.multi.internet.cyfrowypolsat.pl. [37.248.159.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadbb910sm505313366b.225.2024.07.29.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:34:26 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 14:34:20 +0200
Subject: [PATCH RESEND v2 1/2] ARM: dts: broadcom: bcm21664: Move chosen
 node into Garnet DTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-bcm21664-common-v2-1-ebc21a89bf63@gmail.com>
References: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
In-Reply-To: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=4FcpG6IbFADmvtblRtk9vXV8oEzE06lVCRQDHzV+qJw=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp4xOM8Y7azBImnUxluo643zT/ayrg4e0iilfn
 Xf/YctvWvKJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqeMTgAKCRCzu/ihE6BR
 aD2bD/43rgfsYhvud16+2a1Q+bGvMFQqCWJsLMR6tNERXDkEjGbNgFftWlk4DW+u3FK9EYcRvKf
 dkYmsIsrmbT+4zkD/CSHpiTfVztGpwbl1gWABAHhl4z+bU5Y+Nq/B/+2NWWCIy9sBL2hg/e7U5y
 V9SpGnhoS2I2typoFRx/BkJkdOTlN1BwI/bz/yVkOmS/U/hqQHuTqmoqz0EMH5AA+rOJ1ZnaUqv
 IrjU3kO20vGn91cykWhApMQGHpgiDF47qclDk24l0DlokatShHPeosB7qHjNRQ3R2y2FNVi6pH/
 /HknS4G00x0NHCz0BSJf9Z65NYf8Dq749NMm5jnEBIJYAvgOPJLfbjKy50y7bl8Korwb+0KR8Hl
 69ZoD/OVthfv39uwcFdaVTWp1s3C45ljC7Qo7gAN2OkCVUu+minpzLyvWiQ9Th+5akWbdt97dsG
 /0SxtyHnRbmFTEc3f18/A9LbLOf+N7O3wo3I/wpLU/fkbpdHJKRafH6JdEU4XsaKq4DBapNx5s8
 XHlwgJWk0JGUikKXwseG6VzrPKRv+v4XCih6HBewQR2oVHnAV4pBhAtqzTZlZcHjMxrNt9UbUbC
 HRcGMwos/sXIq/zomeiaP2oqDIQdSj2Tr70hy43dZ0yP/o8AbknqelnDZe5bH23nBliUhbHKWdU
 LQuD2Z1rq9M3k0g==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The serial console settings in the chosen node are device-specific,
not SoC-specific. Move the chosen node out of bcm21664.dtsi and into
the only DTS that uses it, bcm21664-garnet.dts.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm21664-garnet.dts | 4 ++++
 arch/arm/boot/dts/broadcom/bcm21664.dtsi       | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
index 8789fae178bf..4f8ddc1b3ab7 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/broadcom/bcm21664-garnet.dts
@@ -11,6 +11,10 @@ / {
 	model = "BCM21664 Garnet board";
 	compatible = "brcm,bcm21664-garnet", "brcm,bcm21664";
 
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
index fa73600e883e..c1ad5123bad4 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -12,10 +12,6 @@ / {
 	compatible = "brcm,bcm21664";
 	interrupt-parent = <&gic>;
 
-	chosen {
-		bootargs = "console=ttyS0,115200n8";
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.45.2


