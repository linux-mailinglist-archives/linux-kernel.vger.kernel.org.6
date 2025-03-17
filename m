Return-Path: <linux-kernel+bounces-564022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A20A64C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7CE3A53FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4D02356A8;
	Mon, 17 Mar 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZDcQ6aV"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4FE233702
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210340; cv=none; b=Ahh58hE65VfO7SvQ4G+6gDyNn525hBgV5ulbwhfEbIsmAyCiF9t5Vs/u3Xi6LZh8aHV/3ws6wjZk3JZH/gPh5VwXxC1AjYaIb9AjBMAXX0XNgm/xlI7lQj1pPnTnMSRIXF/oOY44Rm/HzD+odtjahutB9clSsTHXZU7JkexKFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210340; c=relaxed/simple;
	bh=BNlq7x+/ooXQ5PNMvqwHrshQHFzbSVEM5YZ1/1EZSOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPfpC9s2AOfsGW7H359ZFY2XWgtXMtekud/ELepHL+nA/czpYy57zy2+JwZHtna3E40N+vXgcVgLuai6vvW+45Z6MPWwXWa7XVQaqsxP7w+GMJNF+8QjTneeLy1z/SzsV96mEhN38vHGTzFcbl0v8HVoLlc+KsB/hy6Et54Yb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZDcQ6aV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so805352a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742210336; x=1742815136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb1bmwpZfvOX6yMK1i3HHBS8ZlfwQU6J5gT+QGlyLNY=;
        b=NZDcQ6aVwtqAC/383Z1kogpSWdyiBBOG18zDsMGIoWp9TxkRBwldqjopb/F56udVId
         qrbvyNfflcgp/fcxnm9IZ6lFwRhDpH+d8+LVQWlVfEYeeDJ6exHhSKviYfD1VRSTsfpY
         o479JgT6ZPPjw9JAnUbHfJkUhoT2YNnV6jz5eaSp/d+cUoVv5Np5n114ML7jWHydlMAf
         ZRQvop5rNQGjzMdlWWVRc2ht5MariQcbwf36GCEM7jTaDLtwGTm6G8Y9iWcXxbhcfyAy
         Zs33cbWziyCFY0SObXz41tfERcs67xqoDHKguXAVLkq9s1lv/joUGGEfgVxofNO128Vk
         GcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210336; x=1742815136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb1bmwpZfvOX6yMK1i3HHBS8ZlfwQU6J5gT+QGlyLNY=;
        b=e3u6SNAJ+cfHffIZI7N3e0vAAYji3mrGlvs52grJ2U69x7qPzu/hRFum1gn9SBu7nG
         wfulg5TLLSDTJafyrY+RXptPcX7+qxltsylXs9vGGxz+DHD8B4c7mgcWrCSRfXOy6K9Y
         0C9WSLqo2cuS9CW53BQdV5UgyBt/VquUcvaZnoQ7ms7SKsCkcIzDF3kTipP+FEU5IlJH
         b84Gc+WTfkzZ1edJ2oYlnXp3qyypV0WD6MhktHPIftXBgpzvcqHtwWN3E9ZCUVBqm+Cf
         J9YzQ9KAy+tG6DGI+2QQqTKaroxpHF8qY+Otf+7hur6DLpeguT94Jq3P80tnFV2ax02S
         u3cg==
X-Forwarded-Encrypted: i=1; AJvYcCU46Lc3J2/FoggBperCPi5AQ1S9hIkGaQhziKVw4REO9onWL9TySTolzQhRxtDvytPWjFrWjaCutG3bb44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUM91meT7iWr3HjYtHdX5NxENZMZLbPnCgcxrAUfP9sFia0CSd
	NnskYXjQccnit37Jo3mKNHACtmULFYGwxg+UxHKAMRIAmnX9x5B7i3idE/yA1qE=
X-Gm-Gg: ASbGncshi0eNIr6gkIHzElb4d/dFpgcZ/AfX7NLim3YdKKjwy50GmJSCKHt8dDydR0x
	SWvPFs66YE8JyFOcwXOb6yCcQozG3Zg/hi9wVHGmaHa/oZSe5kq/xwmggdBz+HOKMT43wqkwje7
	amHUw0X/ued2bh98F4dGVKKRpdoZcnb8F0B0F7mJesP2GYb+4in94da+mR0J+5JM3Sa3yX2va38
	pD4t2j6/2fDQsq1rIgvhDQMgHRot8v1xirJ0jFv+R9klKQ5z2apzj41DTpnvNa8qXkciECTp4SG
	MdeF/h6B26SOB9GeckkZMC9sXMtysBy5QE7gMEQlXzSeXaSskDskPas8tQ==
X-Google-Smtp-Source: AGHT+IGfG0kMUMy8OCD9zOa9XSNGd00YZZiW8tI8Vc7MTZK1U10MgZJVD9O1t41p31Vck9HevRFDYQ==
X-Received: by 2002:a05:6402:3592:b0:5e4:d192:86c5 with SMTP id 4fb4d7f45d1cf-5e8a10edf48mr4164494a12.9.1742210336553;
        Mon, 17 Mar 2025 04:18:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816973b87sm5851428a12.23.2025.03.17.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:18:56 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: nxp: Align NAND controller node name with bindings
Date: Mon, 17 Mar 2025 12:18:53 +0100
Message-ID: <20250317111853.43708-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect NAND controller device nodes to be named
"nand-controller".

Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx25.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx35.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx51.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
index 9cfff2151b7e..82601a4b7b4b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
@@ -611,7 +611,7 @@ bus@80000000 {
 			reg = <0x80000000 0x3b002000>;
 			ranges;
 
-			nfc: nand@bb000000 {
+			nfc: nand-controller@bb000000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx35.dtsi b/arch/arm/boot/dts/nxp/imx/imx35.dtsi
index 30beb39e0162..111d7c0331f5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx35.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx35.dtsi
@@ -363,7 +363,7 @@ emi@80000000 { /* External Memory Interface */
 			reg = <0x80000000 0x40000000>;
 			ranges;
 
-			nfc: nand@bb000000 {
+			nfc: nand-controller@bb000000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
diff --git a/arch/arm/boot/dts/nxp/imx/imx51.dtsi b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
index 8323e3a56a1f..f42903c9cf0d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx51.dtsi
@@ -595,7 +595,7 @@ weim: memory-controller@83fda000 {
 				status = "disabled";
 			};
 
-			nfc: nand@83fdb000 {
+			nfc: nand-controller@83fdb000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "fsl,imx51-nand";
diff --git a/arch/arm/boot/dts/nxp/imx/imx53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
index faac7cc249d0..0c38c37dd142 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53.dtsi
@@ -775,7 +775,7 @@ audmux: audmux@63fd0000 {
 				status = "disabled";
 			};
 
-			nfc: nand@63fdb000 {
+			nfc: nand-controller@63fdb000 {
 				compatible = "fsl,imx53-nand";
 				reg = <0x63fdb000 0x1000 0xf7ff0000 0x10000>;
 				interrupts = <8>;
-- 
2.43.0


