Return-Path: <linux-kernel+bounces-311235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94978968668
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54311C21F00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB01D6184;
	Mon,  2 Sep 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUYbqN7C"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C521D67B9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277259; cv=none; b=dYpcgMXhqkAI0jZnw0apStPqPJhbYTdb0LhvqdA0SaEdma5cd9srXbWQ9bGPOs1/p82bljFccgS5s4ivShr1zxHsITzox3RTU9sS2xcRDPr30oMLdgz9YplglN8V0O5cZG9Hy0NDE9s06llv1ovVbhdVqm9EjO52amNrbpXJ6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277259; c=relaxed/simple;
	bh=J138BfmIUP+DsGFhuQ6tmQ+KFExTDC0caq5a6QTQpR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5H3k0H0Q012bqUSLNgANG8C/o0x0NigTtQUlAsmK60QBuHs1dNF+sMescK+rGe5YTIwe/w5vafIF3CoRv6LDKEfD62RPI2eSyTQBPXd+cnrKcXg/Axq2SeFn5FFkUN484P1UeLWkGyXz8F5oK7l4Fy+OilQOFkMPoXH61dyeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JUYbqN7C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bb9a23ea7so5106375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725277255; x=1725882055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stq3m356GXIwneY5TQElVnJK65z1Q8tunPXavfni1Po=;
        b=JUYbqN7C/3rob8Uby4vYQt4yNVlISbmJZMtYm27nptDR0DiuV8s0nQuudjVRVCBpk2
         V8LFf4qnDYC/KZSsU6P6EwG5uw5QrsNExB6/TQ76EiQHSw0jq7rxIYTCKsdI3VZk/pGE
         /Ocl+n0sZL9DicR0rKBK0dT1THxlxD/rJW+NGz5im40/13zBxQneXiEwoaap4HzVlDzB
         R9zVFzaZzqumncZLpe4KBmGZVO+McY66vcDF2QzZAFYSxMQdRNSOyAgQsramDiIiYWw6
         FUn8IF9oCMz4DaHMilDNRnwY76mOY8NxB3x9QTvwPutZKc3/9UC9dlfqjgZDUWjyf8PM
         JBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277255; x=1725882055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stq3m356GXIwneY5TQElVnJK65z1Q8tunPXavfni1Po=;
        b=lKX69UAovSUkxnFHejvv+ziI1IyCyFmxYjEWyoQxNT50tn95VWNyt/QgfPEio4QwZe
         2pJG10e95bB2QTNGjqn9HjCC2Oyhof97BkGxcQ9i5s4+N1pMNnJFEWuocwPJc7bDfAcP
         +/CHYPmBgSLT0MDP/Ms4/EysDVclRUrccwH9x/FSZCbiGABRAH1A0XCTZ90I/ZxE3ZMb
         T2iUlN7mM/1F+gQgWcJtlDHp8j+uf1v4OuXRk08hDYy26pvtHFmGn0OgX5v61NwR18Oz
         ZiqdugpMD8z2Cs+5VmkjCmwWX4cP5w9SyQvA+Iw0aRCMW8zBHwPn1wqbq7vKYu29fh3U
         7Cig==
X-Forwarded-Encrypted: i=1; AJvYcCU6y+HTJjmgGwm0zu2gKpzSbVvljrEiQKotXnFZQorSH/WyZzcvXocU28vQl5U78dLjG0UUBfpZGdniciY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHOsPvpkfrqgKmMM35c659EYQuZGv5t4d8/nKXVNZoQtfUbv2
	9vDjvRaP2ehbhgsHR6fmuzgR7cJxgN48Fb3F+tozvUrkFYL5m/PiwYds35jdOoU=
X-Google-Smtp-Source: AGHT+IFhutwBdu7DG5yHj/lPmaMVpJV3yHqZN+By2ShndFLRElgTROe/iXqSPia5mIOemiWhGr5eaA==
X-Received: by 2002:a05:600c:1554:b0:42b:ac7f:4bd5 with SMTP id 5b1f17b1804b1-42bbb4461efmr40674775e9.5.1725277255348;
        Mon, 02 Sep 2024 04:40:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm171515245e9.47.2024.09.02.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:40:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 02 Sep 2024 13:40:40 +0200
Subject: [PATCH v2 4/4] ARM: dts: imx6qdl: align pin config nodes with
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-dts-nxp-imx6-pinctrl-v2-4-ab8196baa07a@linaro.org>
References: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
In-Reply-To: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14512;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=J138BfmIUP+DsGFhuQ6tmQ+KFExTDC0caq5a6QTQpR0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm1aQ+fymCywwFL3wN/cf70wfLbB0eadcwSbeDF
 Lr4h2ovNQuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZtWkPgAKCRDBN2bmhouD
 109kD/9rN2yGkjvzwmHjIv75/RpNrtrn0zgGkKBHK87+DMWHWlZHVgsP9fuMqblZ3MhNYq2x2Tb
 V+Ue1Dg4O2pJPt+RyChRSmHuxlXwkQEZwwwxjfAgdLjiVnLJbRgTWMDhKrgUYRPYfIngUAN+qNA
 jAPdPhwUOgU0Mc7I7++mEc8kN47bO2tIYldzwAoq0o+zYoN9wKfUdzORZsokbDY31TOxBzv5pHq
 qTqoeNlFtNk7bxD3g23A1NI+wDuEEDoxp6utS5RkPNNdCCOWRlfPNBPnGc2a4KIWhS8DB7ho1YM
 VMI2gy4oaIU1HFohvm60H/cKxLUhYAETR35L18d5B35W+eMZsCa//UayBjV2lmqCeCEkMIAUNGn
 1H8fPyQCvV0M3gVxxi3IKXzydYJD2p/J7bNUWVd580efzjvZkekIr0CHTHB14F6G+Bx63H8C+F2
 QTljRn/SQZSOdpcpV6nXqjofomkudkhxn3Jk4PmKU7/zwB+vqh6zVoFPRBnR9LfJMVubBsoOsdp
 WfHhECruhkFsdJZBAL4CWySFhYR8+3PpB6vWDnTIvU6F5BvHDBWHW991S9k8vvwXEzrZ9jxI1ay
 3Ip6P/leqxp/13t1ulTOzSExgRN6c7F9Umq7C8S48PMmhJ3VZG2Xe93P3/Yn2jEKMZBAdlBt4or
 lBJYNm/jipYDBSQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings for other NXP pin controllers expect pin configuration nodes in
pinctrl to match certain naming, so adjust these as well, even though
their bindings are not yet in dtschema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix "grpgrp" -> "grp"
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi        | 10 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi     |  8 ++++----
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi     |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi           |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi      |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi       |  4 ++--
 15 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index 758eaf9d93d2..f7fac86f0a6b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -506,7 +506,7 @@ MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x1b0b0 /* PCIe reset */
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
 			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index 082a2e3a391f..b57f4073f881 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -761,7 +761,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x170b9
@@ -774,7 +774,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
index 8ec442038ea0..090c0057d117 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
@@ -750,7 +750,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -763,7 +763,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
index 9df9f79affae..0ed6d25024a2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
@@ -833,7 +833,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -846,7 +846,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
index 7f16c602cc07..c6e231de674a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi
@@ -704,7 +704,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -717,7 +717,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index 7693f92195d5..d0f648938cae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -896,7 +896,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -909,7 +909,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index 9d0836df0fed..71911df881cc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -680,7 +680,7 @@ MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b0b0 /* OC */
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x4001b0b0 /* EMMY_EN */
 			MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x4001b0b0 /* EMMY_CFG1# */
@@ -710,7 +710,7 @@ MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
 			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
@@ -723,7 +723,7 @@ MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170f9
 			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100f9
@@ -752,7 +752,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -768,7 +768,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index f4cb9e1d34a9..716c324a7458 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -817,7 +817,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -833,7 +833,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
index 424dc7fcd533..453dee4d9227 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi
@@ -629,7 +629,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x170b9
@@ -642,7 +642,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
index 49ea25c71967..add700bc11cc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi
@@ -569,7 +569,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -582,7 +582,7 @@ MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi
index d339957cc097..dff184a119f3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-icore-rqs.dtsi
@@ -397,7 +397,7 @@ MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x1f059	/* PWR */
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170B1
 			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100B1
@@ -408,7 +408,7 @@ MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B1
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170F9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100F9
@@ -434,7 +434,7 @@ MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17070
 		>;
 	};
 
-	pinctrl_usdhc4_100mhz: usdhc4grp_100mhz {
+	pinctrl_usdhc4_100mhz: usdhc4-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170B1
 			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100B1
@@ -449,7 +449,7 @@ MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170B1
 		>;
 	};
 
-	pinctrl_usdhc4_200mhz: usdhc4grp_200mhz {
+	pinctrl_usdhc4_200mhz: usdhc4-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170F9
 			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100F9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
index 0a3deaf92eea..99386421a48d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
@@ -690,7 +690,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 			>;
 		};
 
-		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
 				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
@@ -705,7 +705,7 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x170b9
 			>;
 		};
 
-		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
 				MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
index e2fe337f7d9e..5a194f4c0cb9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi
@@ -373,7 +373,7 @@ MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0 /* SSI1_FS */
 		>;
 	};
 
-	pinctrl_disp0_1: disp0grp-1 {
+	pinctrl_disp0_1: disp0-1-grp {
 		fsl,pins = <
 			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
 			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
@@ -406,7 +406,7 @@ MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
 		>;
 	};
 
-	pinctrl_disp0_2: disp0grp-2 {
+	pinctrl_disp0_2: disp0-2-grp {
 		fsl,pins = <
 			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
 			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi
index 200559d7158d..d8283eade43e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-dart.dtsi
@@ -346,7 +346,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x17071
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x170B9
 			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x100B9
@@ -357,7 +357,7 @@ MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x170B9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x170F9
 			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x100F9
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
index a1ea33c4eeb7..59833e8d11d8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
@@ -436,7 +436,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x13059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhzgrp {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
@@ -451,7 +451,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x130B9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhzgrp {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170F9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100F9

-- 
2.43.0


