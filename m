Return-Path: <linux-kernel+bounces-443458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C620B9EF0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8178829AFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33402358B1;
	Thu, 12 Dec 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rOIteCG1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419D2358AA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020355; cv=none; b=oHffEsPXq/1WWZqRwRhPL9B4V4n65419z4F51/8sMEynjATt7bGjycG5rfE08pH6d+iKWvLF/x+FoH+fnXov3y4KCiPoq6lPy+hOIFQBpU955V3p+4kuLHGclqmiuChsiCQLRFW8wLp0l6sCfce2ON0wufQTaIdtXeb9ZZ/ZHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020355; c=relaxed/simple;
	bh=p0I2HVUBbWRZhBgsdTrryTL6GkY8GKKUGtVy3VSjrfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+XXLvLSfPExc4lcAW0O81nTM3SWnhmZsjI74buegURe6BWSEPWnMabJYDnZn/w5MOwuzUpIjQl0lTV4odHjnIwGo94CLwdSFlltjA6gooxc5ixzkaemYkj1C3jpkpQx8CxpdHTNAT7YxA+2JclBRxKtJw8empC80GdL1zAuQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=rOIteCG1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385dece873cso419848f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734020351; x=1734625151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDsnxHgs8pPYbt5Sxgc7PD1JuNe9FEImA9X5O9hYyxM=;
        b=rOIteCG1k0+2j8jPBiVEFFnF4pxeeEmvolnkKm/pEuLT9RMYvdxPFqGQ4YMvTKRGKu
         YCdJh+Cq0r4PLkv4b1HJqI3fCg4pu0420Ws1tjXzFcAu2Y356hZZSzNdKa264WLK9LHb
         zvDt1FcpNAjnCfcdi//2tF30rOrweyp0qThW/WAPAFOUFYx+E14R1jvklK6TQN0xK9iN
         +Sf3mznxzwYA4UF2+wFN3+tPlFSz7G3sOKDfozcAJud2yArZLh2zdOBjnRTqAiK0uxSD
         5WjQAXAr/A3u6/OGD8EHaM1WYOQi5fU3GAAa6RArRWYNKeaUl2YgBu1N9OIAQ/Z7CUNw
         I/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020351; x=1734625151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDsnxHgs8pPYbt5Sxgc7PD1JuNe9FEImA9X5O9hYyxM=;
        b=Bh/Xq3ErBQuiOcK6Li5iCOlaikV+zc2xIOKyh0uaOWpfXG8/qw4pihY0uXgkKVFRGV
         oy5ManzRge+NwFQr4vQ6iwk5XwG/nwDW83mSaJNo6yhTfZ4cvP4b9flqdhWYkLM8ZJ95
         X7NHiRpL/HTYj5oYUmVSqTDxvr88T0m1y3fpi5B+nGmqItrkqa96QSYKuL0bD9toIFnd
         86l36DVut7BwWIeKcRH4v25nTt4Es57F2dtTYPrWKB/sz7aKbhxCTmX9DAU9NoGygEI0
         SzFaX2rPNVJK9SauYPU2loQnteWaJ94gxM4wIJeGGL5/a7y+sEMXY/NeKw+88AGJIxn+
         ibmA==
X-Forwarded-Encrypted: i=1; AJvYcCUkTbsuEWsSl1ujDg+fiQesgtg0OVQC3DaBtuWYjRE8oBNcBlyRkuFo9H5/z9EI6v2M9a813NWmHHuUDAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8d3TNWnWfhnF6B0qeshoisKQkDjRGrCDELN5QcpeeeXMNsPrv
	hT40w7NQLGQ0TP8oKAUX8vB5LIs87kxwTOYeiyvyOfFwtMehbsNES3EvyNV2ddA=
X-Gm-Gg: ASbGncuGuwzXh4fAukiV9UEiVpSvupYhsQHlgbKZ2HUmS1VZ5kkHaGrztS2rBRmpIhJ
	doJUQLe/jzM7sHpmyzK9wH++sq0CZqvzfSBAAeySPsPFXmrb3lZJ8FNLbsQzPm3Xq7buWZPPa85
	bb/U7DPgSFsKCU+R1PGwAt3OlMQXCDUDv0nRn/m3w8cshf0tr0kg8bPGYr7Hk8rlwMYWg6cIQLQ
	64YR9TohfODenMOgxzceKVrocXXwkvgOIp4VIYyG+4lED/p
X-Google-Smtp-Source: AGHT+IHSgOEfwH+piApFqEC2IhYZWJ+1L5bPpX/eXc0mgxxp6hdmD6CIHtNXbZfUGagQsK5T5vfHeQ==
X-Received: by 2002:a05:6000:4026:b0:385:ef39:6cd5 with SMTP id ffacd0b85a97d-3864ce89425mr6133942f8f.1.1734020350544;
        Thu, 12 Dec 2024 08:19:10 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361e322328sm44336105e9.0.2024.12.12.08.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:19:09 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 16:18:56 +0000
Subject: [PATCH v2 6/7] arm64: dts: broadcom: Correct hdmi device node
 names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v2-6-35986e04d0f4@raspberrypi.com>
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

The names of the hdmi0 and hdmi1 nodes had addresses that
didn't match the reg properties for the nodes.

Fixes: f66b382affd8 ("arm64: dts: broadcom: Add display pipeline support to BCM2712")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index bd78af0211b6..f42fad2d8b37 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -352,7 +352,7 @@ main_irq: interrupt-controller@7d508400 {
 			#interrupt-cells = <1>;
 		};
 
-		hdmi0: hdmi@7ef00700 {
+		hdmi0: hdmi@7c701400 {
 			compatible = "brcm,bcm2712-hdmi0";
 			reg = <0x7c701400 0x300>,
 			      <0x7c701000 0x200>,
@@ -381,7 +381,7 @@ hdmi0: hdmi@7ef00700 {
 			ddc = <&ddc0>;
 		};
 
-		hdmi1: hdmi@7ef05700 {
+		hdmi1: hdmi@7c706400 {
 			compatible = "brcm,bcm2712-hdmi1";
 			reg = <0x7c706400 0x300>,
 			      <0x7c706000 0x200>,

-- 
2.34.1


