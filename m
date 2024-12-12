Return-Path: <linux-kernel+bounces-443457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A659EF140
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C5817AC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB9241F2E;
	Thu, 12 Dec 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="JzCLzrSQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B1235C22
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020355; cv=none; b=ByKwoQlHnmFmfLLVFI9XPQPD0MURRqJqPrIsZNlLzIIvcJU/Nu/qiUKGeShZGCeLO7vyRSKD6/+QibKpdU0n9qJ5UJToj4V/w5PqrDof3UC+Uzd5flb/UH4eRsLSblOldSsKKFocnyE4ejwISENTfSit44Y0znOmmPHBdHm5IQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020355; c=relaxed/simple;
	bh=Qqxoymj22X4R98zAPdTR2WxILJdbVSevs8eEpI4zaVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrXhT/w/HulEoCMl5uLwytYYQyryv0D5iiBKowqbJGwOT4Yo0lG40wlTLBqZJ3QfGUBm2rBTRj/GdZLWyi5n5Vs+ji0wxe59HrsrVEPjbJQRNhW0XlGsIpCZgfd/vZDiuQ24iWcICQ2+zRQNKpoYG0HteGRLOcCUHrZMpfjQqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=JzCLzrSQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434e69857d9so5318905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734020352; x=1734625152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNTGzlog7Q9IZQyQd4eTU3kXEBDBdmsulQeLjahgS6Q=;
        b=JzCLzrSQMYEq1VzojdJ/gHcREQUCkodfQu3W+Vs81MWbizeatahAr+LWIlcytp403q
         KuaKAPnhjxOOix39XGR2CPt92d6G1IVbLLZrzzDqpebpUnS72pBtdbUTNLMEl4uoNiC3
         OI8WDrj4ka5uyJbWGQATH2uabF5VgOqUcUqZw7snudGxBKr2MyShgtJYOBVWi+SpjBpz
         vcXEd1q7AfMBeLeqzmZS0Szb5BgIISH2wOEOuu+oYl5yx+L7rf5otCXCKSxauiVvLx7l
         UmKxzHAfebvxU3xT8z8/ZhCM5mLEyuk2IBbxLO826JbSfL6xIOop9ZfrzxN8+TUBCpYk
         4h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020352; x=1734625152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNTGzlog7Q9IZQyQd4eTU3kXEBDBdmsulQeLjahgS6Q=;
        b=vfiq8C/+YbR6pA/DsW/ELtm5k6IfkcX5IY5ZcQRfK2gvBhOS6p351p+ef21fQqVBrG
         als5WpWOFUhFbYov0Ub8h15kRG6dxllMVLJBGiDJFWgP2hOQhcnlvzIqd6WBFcQquZjU
         pFhE44IjdN5hY+ON0IbrRfAYpWFDdcFuSTcrKGMy8d4+XdzEBsqDVpe8S4QUqBvU3LY6
         a/KcSx7QxLilKRB6w+eJHbkwMSBcANHvl1clv7hvWj5Cbd3rp5YkFxkrXSyMP9Xqf5ZO
         UIpm62OLsv0AOPX367yvacCYw+iKG9nDH2oTjrwoOfmL0Zt/v/B6G3kQ5dsvllv+JBiU
         Y3dg==
X-Forwarded-Encrypted: i=1; AJvYcCV4yGGoJ2daFGzEyw+aGJrd1R1md15I+eD931VS9FgQ8ATraKchciFBQQm7GfbWF52tGFpNf6Tv3x++0yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61gAXEREpN3LncCxx8wv3UzsNcycvZmMS6hTBc21z8eA19XER
	EbYPGeVCWmJlME18a6ANZuIKsuJWDQWqIncwBgBVJ8xYf+vDnQOEzSl9am1FMSM=
X-Gm-Gg: ASbGncs9GFV3bHYvJAifTO78Q3+glCCc02+NNa8QGeDGpchQj27yg7fJwe59XRj3o6c
	/ri+5hgP3v6KFC7PbRW2/uMtoe7WkAp/fA94tA0orr86dY1Agpx5CZYjRSSUkugAkLZtTVqAuiR
	vmfd+fxyingmlNwaNrX3ATK9iq3F/dbMgcxpaQgYPYHwEGD2Y6eF5alkKyiuP3oUUKXsQzAZNa5
	theGCLN2niqHH1nGGB0zzDh59b/4FEnUqt6apBhrP2ko1vh
X-Google-Smtp-Source: AGHT+IH8oJmO1yg1ubSZ+z90KdtGpUstGhHd0JFOT72Tqf8VNjDPTT60N6GaHw5YeT5mJn8XmnjWIQ==
X-Received: by 2002:a05:600c:c8c:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-436230dfe7cmr29162515e9.7.1734020351732;
        Thu, 12 Dec 2024 08:19:11 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4361e322328sm44336105e9.0.2024.12.12.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:19:11 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 16:18:57 +0000
Subject: [PATCH v2 7/7] arm64: dts: broadcom: Remove intc controller on
 BCM2712.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v2-7-35986e04d0f4@raspberrypi.com>
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

The brcm,bcm2836-l1-intc controller isn't used on this platform.
It is used on 32-bit kernels for the smp_boot_secondary hook, but
BCM2712 can't run a 32-bit kernel.

Remove the node.

Fixes: e1417095a139 ("arm64: dts: broadcom: Add firmware clocks and power nodes to Pi5 DT")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index f42fad2d8b37..9a426aa27c74 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -221,11 +221,6 @@ mailbox: mailbox@7c013880 {
 			#mbox-cells = <0>;
 		};
 
-		local_intc: interrupt-controller@7cd00000 {
-			compatible = "brcm,bcm2836-l1-intc";
-			reg = <0x7cd00000 0x100>;
-		};
-
 		uart10: serial@7d001000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x7d001000 0x200>;

-- 
2.34.1


