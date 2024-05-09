Return-Path: <linux-kernel+bounces-174425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445D8C0E82
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6712B2367A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFB14B977;
	Thu,  9 May 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPr4wsQB"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC614C594
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251732; cv=none; b=BLQqDJmuTmUHW881xpKuPvA1eAZ+q5xoCbsLNd/eZslOAT+DwbeFv9Lwh06JENca9nPaigU3v//G2CUUAN5BuRzNHusH/T8swBsLH+vxWM/+NqqV1xKF/52Wnw5M1/wGYqYQKNdbVmInqDcsLZwghlW4jHhuv/qVlWut/OfmZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251732; c=relaxed/simple;
	bh=aPzqlco7XsixPyzCXTVco8ktdIB66kEc2nTRRwiR/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1RlEqm+TtHE/L5HglwupnO4Q6kj5IiMIGnBUqM9vMUhtNxwRnpwP7KOWNAC5UAAhILewvfaNIyu5K22OS3w0IOmJ3OaafWeKbah5/IcO4AYwU54JwNGF7/p/3KbV6MzPLObG09BJHoZosLeztPkhJRG8XXRVkzHo+f/ujIvyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPr4wsQB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso173809966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251728; x=1715856528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIdN4MR8ysP0CcOVaWDr/atwyhcItV6HcCM2wmXc11Y=;
        b=tPr4wsQBcT81EcrXaBXOhKKqo67opPo1RxZPOa3OrZ7/CgAxrY+RI0pvn2D60Isx/u
         NExw2AOojCBmQ5jCEOdTCKmil4vS+449YM/ouqIaYtoJlMO7dh1EoBCjUATvi8xad20d
         QALNs0hpmdoEw6KiBPpLtfkFnh7yphrMB9dj1RtJL/FgVVmt9bJlWgcKK+S8QqtDRqFa
         3QuaFxuwPvSOApADpU5Y7aHSZEDEq0S5Xyi5n5xX6BP7IpS5nuZ5KXDF7TlhaYijtm2I
         Z5ST5DmyqFD7GobXm4X0m2gixyOy4j7Ia1O7WkKuh4u4cuQNVgZ/oVMSCNt+Gy0Z2pzJ
         jUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251728; x=1715856528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIdN4MR8ysP0CcOVaWDr/atwyhcItV6HcCM2wmXc11Y=;
        b=elKGiDvTSsuOSpiu07XNwMHyA+Sq7L+zsge/H3pPnCjwm4+ytYRCtjACbs/Qg3Foam
         Qpf8XNBJJEYrmX+Z36kyETiVY7uE0e9mp/iE1H67N9W7YPTHFTDLTDeQC7tVTaJXP94x
         pq6DxDbBgDoDxmiIEX+SEEsa73yqp4c7eT18uoNK7bImXa4etL7PW+lDoAlO8Rhwrzqu
         RBLtWCtajGMRk0fjwfV/VmNVWIBi4k2FYHZbX0SP+YLcsHdN8qgVnBotuzGrPPBCJ5DB
         5vPEctVRKAUHtFtb/rRGwG0L8fQLSpvNy/X+TOqORwoBOXCPha/vXU1NA2QMv7sQrz1+
         FCow==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3xgxFICTcx8L6l8c0jfDOncrhrWEj6y313hAH3EcPlDAxuA/ymrSqlx090+hPEs/uk6liVUuwREC75n6okL2eyzbkhAo88sctseE
X-Gm-Message-State: AOJu0YwK0wFEIeo8Bmf2fMtmHZFW1kj0z6IiXTVAHFLdHU7QuZSM8AwJ
	2Yd0jhLe0jQFxH6DllkwU3JxVQzDr3TyLeMdR/sYidEqtPNbtvWHHXHZsllqOk4=
X-Google-Smtp-Source: AGHT+IHzxyO5fKOhzl1H1hoKpa6CXJoOBaKE4zW9xgfQNDPQNYWH/OVRT8MGIP39ltU081+X08S3Vg==
X-Received: by 2002:a17:906:1b08:b0:a59:c9b1:cb68 with SMTP id a640c23a62f3a-a59fb94a628mr352359966b.7.1715251728286;
        Thu, 09 May 2024 03:48:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d85sm60195966b.72.2024.05.09.03.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] ARM: dts: imx: drop redundant 'u-boot,panel-name' property
Date: Thu,  9 May 2024 12:48:37 +0200
Message-ID: <20240509104838.216773-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
References: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Panel timing bindings do not allow 'u-boot,panel-name' and there seems
to be no users of it: neither Linux kernel drivers, nor U-boot as of
v2024.07-rc2.  Reported by dtbs_check:

  imx6qp-tx6qp-8037.dtb: display-timings: timing-et0700: 'u-boot,panel-name' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi  | 5 -----
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
index 7ae495bdc48f..ded241a39906 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
@@ -127,7 +127,6 @@ timing-vga {
 			};
 
 			timing-etv570 {
-				u-boot,panel-name = "edt,et057090dhu";
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -144,7 +143,6 @@ timing-etv570 {
 			};
 
 			timing-et0350 {
-				u-boot,panel-name = "edt,et0350g0dh6";
 				clock-frequency = <6413760>;
 				hactive = <320>;
 				vactive = <240>;
@@ -161,7 +159,6 @@ timing-et0350 {
 			};
 
 			timing-et0430 {
-				u-boot,panel-name = "edt,et0430g0dh6";
 				clock-frequency = <9009000>;
 				hactive = <480>;
 				vactive = <272>;
@@ -194,7 +191,6 @@ timing-et0500 {
 			};
 
 			timing-et0700 { /* same as ET0500 */
-				u-boot,panel-name = "edt,etm0700g0dh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -227,7 +223,6 @@ timing-etq570 {
 			};
 
 			timing-comtft { /* same as ET0700 but with inverted pixel clock */
-				u-boot,panel-name = "edt,etm0700g0edh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
index dfbdbb87aec4..4eb53d5677a6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
@@ -128,7 +128,6 @@ lvds0_out: endpoint {
 
 		display-timings {
 			timing-hsd100pxn1 {
-				u-boot,panel-name = "hannstar,hsd100pxn1";
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -159,7 +158,6 @@ timing-vga {
 			};
 
 			timing-nl12880bc20 {
-				u-boot,panel-name = "nlt,nl12880bc20-spwg-24";
 				clock-frequency = <71000000>;
 				hactive = <1280>;
 				vactive = <800>;
@@ -176,7 +174,6 @@ timing-nl12880bc20 {
 			};
 
 			timing-et0700 {
-				u-boot,panel-name = "edt,etm0700g0dh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -193,7 +190,6 @@ timing-et0700 {
 			};
 
 			timing-etv570 {
-				u-boot,panel-name = "edt,et057090dhu";
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
-- 
2.43.0


