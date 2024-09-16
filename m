Return-Path: <linux-kernel+bounces-330319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D3979C86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC798B24085
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D0149005;
	Mon, 16 Sep 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPcI6OeC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DD145FEB
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474134; cv=none; b=o8dNiRCHXoA2GmFN9oMA9yIAKgaCO05jdPVVgso1HWGn6fjYpom+twn7vKA2t6Hl5cqzl+1YrzcnLgYCW1WYDYvQBFf6a/sZ2IS0s3FTTaT8bMJ6iGYmc06p2b37ql+PjoviocAI3mLMkIOleDfWbRnlWefmoVFBUVzGIzzVpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474134; c=relaxed/simple;
	bh=Df6SGhQpFwibDBqHpjPsiq+Dko+XirYqFFKgtz4wtnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mt65nDOlePIfNQBy46vNQD3dECMRV+OeWpYd/HEWdBzDsS24yc6Q75xt4c2z8tjA3sTD1v2PGuDZwR20yc7Quic9hAaHqWH5tFOEf4NpK4lafovgFEqSNwH5VAUcqQuQaiVsn36+dt1kDdcazoBa6MPXUxv0DJvu02hvxfBRpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPcI6OeC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso26233145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474129; x=1727078929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuMyjcQm+2mDSwbBu68Cdtb09lvYh/quxjtuMaOLP9Y=;
        b=KPcI6OeCib7X7oXr7Atxf/5RfI6nZBBIuQlZlj0DNzrAfFdUDtNyLyw/og2TCt6JLv
         7vFGFQBDPeZhtcMgDCnj8wDAxR7BUYKu6cK34pPJ5WcsHnsacy/og+A62cvKyBlGZcGs
         ItaAMEYx1B4b3r02741ROiaPDFMvEPleswzSPcDoNFTNzbZ10uJ65oM/F+9m8S95O6JU
         bXv2CqJASWjW+bhgIGhgfPrZXYD4FTusjEVTO1osKWvkS+qTJYmL6Dl6X8kQ8/kUp3WQ
         UuHNKwJJhaGxbWRelI8sMgkWg3Fvfhyw5kqFIvjf43gJgxFV3glliPMl3H2Ne2KMng8Q
         ioMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474129; x=1727078929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuMyjcQm+2mDSwbBu68Cdtb09lvYh/quxjtuMaOLP9Y=;
        b=XHEpGsJS5fA5j8N3zmfMh0ON6YGTQL9JhvjpfkWoA0Bv4O0s1O2lJGZn7FZkiszU0i
         XCSC9bLN7nwV8MyIMhEhAZdGjqcr0geZoxd23xw0Kv9kWMFczBB1Ut0tB1JXw9gmv2Hp
         RQB2t5An4yxdO9RERjOxf8hxXSlserd9CwowYiUnEC2brIYV7cgWnWF079FDhQjcl477
         CrreYUdrrCilKiwzOcopvnBrmW/RR49YC7IOzz7V4tSxrIWdWW3cRndsZaPbrfypy8rf
         8PEL/AIM+af/wQwRWghgauCtsyV/JFRjCNnaM/gfJY+mzPOiZ4mwSsCPxQTG9mbn+muF
         /PbA==
X-Forwarded-Encrypted: i=1; AJvYcCWsNnXXtz+YXaZhKJw1P56tK9+a/ixiZjAddlLr8NW70O150kbVJvt/4oDZMaN0FpLksKe4/NCqLxBgKg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYWE9V26IY8Rb0YWXQBFQ7BD9Ze36b/hDq1oSadPeTSjxb/23
	nzcrSB+bDKFg2v7GQQrvx0X1IADqkOE6g/EqLOwYdAxDvaXcNjXgYKriQWXPgN8=
X-Google-Smtp-Source: AGHT+IHxCDX2wZDD6mVUdX4k15uaptnDK6FvyveAHybClETOfRQ850wki4B7ihrNJUPowV3Bfclrfw==
X-Received: by 2002:a05:600c:5128:b0:426:5c36:f57a with SMTP id 5b1f17b1804b1-42cdcabcf3fmr84801655e9.14.1726474128995;
        Mon, 16 Sep 2024 01:08:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:36 +0200
Subject: [PATCH v2 07/11] ARM: dts: amlogic: meson8: use correct pinctrl
 bank node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-7-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Df6SGhQpFwibDBqHpjPsiq+Dko+XirYqFFKgtz4wtnI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eHs7h/Zx45Fyf/Y7mpviRiuFBl0+4ARc//Tiln
 Cd190W2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhwAKCRB33NvayMhJ0dy7EA
 Cdy2NEiECo3yxkC2tjmTWOQr+c+6LA4Mrbj6PxbirQes/U5Fz9VEWCBxOm3RVH7hAWOl2Khe1Wv2nP
 Q8ZRUHftEiAAFrJIGY4gxhITv70hdXJ+p/k7870SyTQl3KrU58diA0Wb/Uj63zA/Kdc7V2s+T++75H
 LMe2ZCvB+w8+R9JUgcwM+z7O7CrBNoD2LMqi5zCcjukYLBSmfgAz90giarlXqMq7pR6hBVwv6QIM8i
 gLA7wrxPQBzJJQePd0+76+v3nn94cfrIpX3bEXFLS/GTpKcK+4Yd/FlmHxPPtl11SKEOTLkmUvjNJE
 NsSXltKi3vg4cR2QwjzoYGrvNAItGUi9hquLURs+nY6el5ht57EZrLK3IpALC+ddbzFE5krp94y41j
 x9y/dNcoRE3xDylvWLNr8u7OoZ5Sja36iIVXLFGym3VmOa67VOyQqGGg5DSPwkJWfy7NPw9uMKMgbq
 2WrawMBaHHD5ejolcHM3nbKAtLHfE+w4Ojd1GlMTuUmgU7DqQIwCEyX92H7TWY5JaFSU7fePpo3nT+
 sYUQx0GFG5b4raOsQO64PIv8ViMtrGPlJFrVFP+L/KfqWGdTyr5pU1BlDXMYEayfjDy79OWkUNYtuS
 LK5TBRTFfpq8QpOOpLyaCCDHtJ7lww5Xt/DP0saNbvDx69kdYFvjphnH3PRQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Use the proper name for the pinctrl bank subnode, fixing:
pinctrl@9880: Unevaluated properties are not allowed ('banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'reg', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,meson8-pinctrl-cbus.yaml#
pinctrl@84: Unevaluated properties are not allowed ('ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'reg', 'reg' were unexpected)

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 4 ++--
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 1023ff0a4f9f..6c7596c8b96b 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -353,7 +353,7 @@ pinctrl_aobus: pinctrl@84 {
 		#size-cells = <1>;
 		ranges;
 
-		gpio_ao: ao-bank@14 {
+		gpio_ao: bank@14 {
 			reg = <0x14 0x4>,
 			      <0x2c 0x4>,
 			      <0x24 0x8>;
@@ -468,7 +468,7 @@ pinctrl_cbus: pinctrl@9880 {
 		#size-cells = <1>;
 		ranges;
 
-		gpio: banks@80b0 {
+		gpio: bank@80b0 {
 			reg = <0x80b0 0x28>,
 			      <0x80e8 0x18>,
 			      <0x8120 0x18>,
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 641cd60781a3..c8fbeede7e38 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -315,7 +315,7 @@ pinctrl_aobus: pinctrl@84 {
 		#size-cells = <1>;
 		ranges;
 
-		gpio_ao: ao-bank@14 {
+		gpio_ao: bank@14 {
 			reg = <0x14 0x4>,
 				<0x2c 0x4>,
 				<0x24 0x8>;
@@ -422,7 +422,7 @@ pinctrl_cbus: pinctrl@9880 {
 		#size-cells = <1>;
 		ranges;
 
-		gpio: banks@80b0 {
+		gpio: bank@80b0 {
 			reg = <0x80b0 0x28>,
 				<0x80e8 0x18>,
 				<0x8120 0x18>,

-- 
2.34.1


