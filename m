Return-Path: <linux-kernel+bounces-309834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D99670E0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC41C2156A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8517F397;
	Sat, 31 Aug 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apOXRYVj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA617DFEA
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725100121; cv=none; b=UWg8Gah1sFASOEVGoBmCDuN5LA+LWruV1Crvp7gntUIVCitTZFrI0YROS2uq1TsW/PI0LIqYap7zsiqEXVbn0k05KuIcfLiAOH26DRO8ayLtm4XkWOcXf7AAu4KGk2YvpcgbxKHocuvU8ZA1vlik5rhvp6YBbvY2NRTKMRRlteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725100121; c=relaxed/simple;
	bh=+XgOIAGc54NmeGJRFJTeDnLlTkRP9TEIQ/DEMZFkmh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIigeywXDWYzQpra/z1b7U/HOq2y+FanyiK822KgAsT/QBA2higYLHD9JOybq5ieBudGJbYGHd//3wPsyPJBN1d4O14C27XhWtBcR7hW1PdNnVYJvbz4tMSRepwgZLRmGbSghGqlsZvULX05xmkYcDV4NR+daa4EG0eOmmwtCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apOXRYVj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb8ba2814so3242885e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725100116; x=1725704916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PQ7TU+TRCd05plV/lsYBMtHZnloycwGHJL8+Z4Y7Do=;
        b=apOXRYVjydLEAjw8YQ0roNNKTGbn7u70sQqiXV7vo67ZwGLJvLjZ9UkG0ePDWwjnxD
         FyRA5xp/miYUF3BsyRIazSmscxDelmGaB+RAbaC/v0KTU/TOK4p5sQUtui5TU5aK8Q2B
         4uPkoYqPX0GF/PdYoQBdwAJEjCDV2tMK87hytY4TaPwIOeS7fEhlZjDpFNfZvSOkEtie
         p7wiVZYYo+ab9f7oXPS5NTSpitNV1Z50sI/esbmdKqEgZdaw0SW6o6x6I8ZSJKreVj0n
         Mu/jN5ionxFAXAR83qmw80Wm14xcpDATobCii87pFKnPofSWVyl3olTDMwboOL4pntpf
         ehYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725100116; x=1725704916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PQ7TU+TRCd05plV/lsYBMtHZnloycwGHJL8+Z4Y7Do=;
        b=ni6lgI2+VOvuq4OnUO3Nr3A/LglILLlX+nHtEjg/0zC5ZhYzj2mcry8UU63CoqAS58
         pEjLMSKiL72bjtS3t2SDvdtKrFOS+TTHfbevbk++GQegGBGUUWNZOtwTim94TC0qTHKA
         ywXsTkv7lXH8sHvJOCK/f9Gr59fgijTEXeJmT9+IG3ImsorlcLUppy/A5wsyb1oOD56Y
         Na/XrrRQsLNUEtyLyTTiTXBzHJgHNpacmXT+9akF2GlItwYfVbToceW/y4ZZZgGdt7Fi
         TFH0YI3vGJn0dT14hJgiaJUCmXIHRkHyiRJnU5w086ns473afi/bk/Y6cer+Xp5m1UOr
         he7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7/+u1oje27+O54kusn0zMxVIvb4mF2VfMBS/fUkW7X68V7OwvAc15Ik8QZlYDx9rmvC4aZGVbwC5qidk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4ibgUXGbMNg1q16LNgdq1G3s5F9Gpf0BCLOmwfhYFLXA2WKd
	hLfARppxGZbIS7UoYcJXbs22yyUDFLF8+GWXAzCa2f2dgRxpWpEqYVlBU2abEv0=
X-Google-Smtp-Source: AGHT+IFKG2NsgPvdlzeiPUcFqypd8reEl1V1Xgj5bvXeck4f8KJqk/iLdd6LnHVh5p4piLLapaNPdA==
X-Received: by 2002:a05:600c:4fd6:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42bbb204f9dmr20014055e9.2.1725100115992;
        Sat, 31 Aug 2024 03:28:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63aba23sm104502155e9.21.2024.08.31.03.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:28:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 31 Aug 2024 12:28:21 +0200
Subject: [PATCH 4/4] ARM: dts: imx6qdl: align pin config nodes with
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-dts-nxp-imx6-pinctrl-v1-4-f5811032bd40@linaro.org>
References: <20240831-dts-nxp-imx6-pinctrl-v1-0-f5811032bd40@linaro.org>
In-Reply-To: <20240831-dts-nxp-imx6-pinctrl-v1-0-f5811032bd40@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14467;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+XgOIAGc54NmeGJRFJTeDnLlTkRP9TEIQ/DEMZFkmh8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm0vBKr2xI/6eYbX0GjX2qHad67+HXJeKVsp37A
 LX0DcQ35A+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZtLwSgAKCRDBN2bmhouD
 12ARD/0bS69oz/IFaINlbW5zhDmDnaGGQ6qS91FIx4vBDu9+waApbVmykB0U0hJIEz0R2ct7KIL
 icGy2NOB8ksP3v1b3AqZ348odUPj2370kYy90f6kL2cckVdYM+u9rcmVMaauS9IXgqvmsZIsOeC
 I0ImqItYCD7A+PpXdOKjsW+ZhLzEAuxfQrGPd+21L3A/RfuTKePp0Ef//F7EKXSBWd+3bBD4k54
 pkiBSAsWLzqQgffVIM80wBZ+PkMjFDIP1YKRC7GIlI4oF3Za0j7yuX2aPrG0BmQbLdCkTaUz3i+
 e1+9B0JCRloDkQwarKhIzA/+BRU6bn3blA+QoQLo6MlDxRVx7S0z509vcN9ICxte4FuqUdCS1H4
 2Cla6OKtQCtjstDrRlN5WUPtoZew43VbBjW6nXVsp4yVe89CrY6Koi4LRa0LvwnK9JvHzH235EQ
 33uS06RkuN3pYUpJi2wv9BQtnH46SaqTgbJ329STi/Ij8RKZVWuuiQxD8bOquofLbZ46Cv4dkCh
 E/s3KLKSWf00Xkt7zjP45ExuV8NwSq2Fp1LpZjIEg8ESrnMoggiFP4NAzqQq/aH6wACXpQP46K7
 6XrRqhhgoYHVTUXKthjh9H6sXfby76L60lhX4vfAWO+owQQuSnkvDzEGwa9nrg9eI6S+FvOdsrt
 n4UMuEclc7au4Vw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings for other NXP pin controllers expect pin configuration nodes in
pinctrl to match certain naming, so adjust these as well, even though
their bindings are not yet in dtschema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
index a1ea33c4eeb7..79d80632ee45 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
@@ -436,7 +436,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x13059
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhzgrp {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grpgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
@@ -451,7 +451,7 @@ MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x130B9
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhzgrp {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grpgrp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170F9
 			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100F9

-- 
2.43.0


