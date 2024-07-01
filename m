Return-Path: <linux-kernel+bounces-236510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64591E336
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E331C21917
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F716CD1C;
	Mon,  1 Jul 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnp1apOm"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352D16CD04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846228; cv=none; b=BeXrGOg55vH7I9KEx0ZKWiYjlILs3KXEdRjAWS0ttxsD251qncr1tSHlwC3rn3qsMNrR3/q11m5e60fg5s3bdqKYaa0LMos+yJUo+kT2kpOA/pjxTzmo6yij32IkJsttFqis4cEqctOfXq387JQKaL+CMJoWkgZxPnthBMvL0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846228; c=relaxed/simple;
	bh=Im0MnZ4JFjVrnRFmMEKhQVttdufi4KkY6RhJSFciG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3NjAvNrNS4CEudeYSBZr/cqPuF1Byk6nI2kEkwD1gGQzekmuDanSLV0UCHnSpWPUELcy2CJJMiO/ZHVKwOCq7hGwXPGYTwSFf0xjSHXmNS+e0gEhpuO12lzWS25MM3kGkuobXsPWNVzz5ykcg1p3PMP7XU0OqPJ6by/VEaciFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnp1apOm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso24527875e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719846225; x=1720451025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wDZmEYKELUi74jPnAuSpDQT9bMcj+67lUZhkc9HSzY=;
        b=jnp1apOmBQrZQRwdHSV7mHRYY0Jg1I3pR6vRrAsNAwkJJfIXDxi/BiK6UeEF7HQxMr
         Y5UL//Vnqch6cGz5CJ5tuhTF51VtucfR2PbM6yofu9onIGEbAmUi/rFRG9Og78jDlIf0
         P1MrKzPjDKv16p0rOtgx1CnLZAoFgQQK2aoMdwM9vNX7qMODki2J7bJT3QcSS+gkfwSK
         LWkZJGvJCJIeqPFopejPsw6dInp98MX66HqwFxCeLo5VsnmE0028LRlwJDuAF89DyZPY
         3aXi6R9jCMihJbV9s318sNxIXQQWcHB0NrHpr2YuAAjVCImipvm0jyzFLTiUBV0Bkrkj
         o+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719846225; x=1720451025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wDZmEYKELUi74jPnAuSpDQT9bMcj+67lUZhkc9HSzY=;
        b=UegcxpMX1W+j/4WhtJd3QXKJCHvWD18zQAUwOW3c/SCxW2E85UiuCoChBYGwl21E70
         cofjjEYzuRQfXrsv19bzL87FPc+S0T0yZ5ORmso7KRGdcdRCQ2iD69rd5k9JLzI2Nl4A
         pNxpG0RzLK8n+5GHWWu8UrbPvQEqKy37hupUSDLVNHWrvXpxTESQZZ0+XEa387GTClaj
         Eh+wzSHUo4n2J4RQw15FrgbbSul6I1DWvzqlgSxmPAQhKSq+UauuocVQs0n2XuCqusRb
         O4IPm+ygKf6h3O2evqHaaSDSc/9RxDMVfGv+ha/IdDJK2U4FhP4RltRwieqIFFbPGCH/
         ENqw==
X-Forwarded-Encrypted: i=1; AJvYcCWr15sNC9SX1Sz+tBv+GZHCn7zZPyO3LqXGW/YidbOuv4JbFT+X3aYTH+JDWqlDZ4L0rHzaZfF3YSVGE9bpMFn2UfQUGQMPKag1y5a+
X-Gm-Message-State: AOJu0YxVZQfKONX/UoRshuAe6XBZKpB5exfijI1/MyOqSf8H6Rb3kGqQ
	Ap46YlW5oBURcEVxUedP46+HStHFAUxr3sjFzfDp7Iy++m1xvoyBcAJr3LNRWlg=
X-Google-Smtp-Source: AGHT+IEMizyoQeCknv0BfDpDljAewhrRC1c22Js7WurHZ9I2MaP1PlDrMgksoK7fc5h3yNqVMXDWvw==
X-Received: by 2002:a05:600c:4814:b0:425:77d7:3d77 with SMTP id 5b1f17b1804b1-4257a02b88bmr45695515e9.15.1719846225055;
        Mon, 01 Jul 2024 08:03:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b91bsm158127635e9.20.2024.07.01.08.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:03:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: armada-3720: align LED node name with bindings
Date: Mon,  1 Jul 2024 17:03:40 +0200
Message-ID: <20240701150340.560243-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701150340.560243-1-krzysztof.kozlowski@linaro.org>
References: <20240701150340.560243-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect the LED node names to follow certain pattern, see
dtbs_check warnings:

  armada-3720-gl-mv1000.dtb: leds: 'power', 'vpn', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
index 07c14bf04b83..56930f2ce481 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
@@ -57,17 +57,17 @@ switch {
 	leds {
 		compatible = "gpio-leds";
 
-		vpn {
+		led-vpn {
 			label = "green:vpn";
 			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
 		};
 
-		wan {
+		led-wan {
 			label = "green:wan";
 			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
 		};
 
-		led_power: power {
+		led_power: led-power {
 			label = "green:power";
 			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
 			default-state = "on";
-- 
2.43.0


