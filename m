Return-Path: <linux-kernel+bounces-339718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1F986972
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A467EB23FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97091A4E69;
	Wed, 25 Sep 2024 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJhi2n1Y"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDD1A4B7A;
	Wed, 25 Sep 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306477; cv=none; b=t1+OpvtroDy4MlPSPr0QwKa4EU11+sTfNYARG3a7iZUGUg0ctgRAS0PDF1vY7ynF9wjVdhSGl5WwgXRC5HwjlAWfMGjHqVvP1dS9MnZawHslpAdCeVj5GIKvTPXsDfoaBTi7D9rUtOUEm+ZgsXH/XUj4FBGn1X6HTGxrVUTazPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306477; c=relaxed/simple;
	bh=hNzNTRUO1xfArrtGz9hIBWhoLSA7T3wdnmriECFga0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCzQ+tkzRaRwxgcYuPlaUWpVeKX7mUFDh9AEKxDVUp9ET+XUP4axjZJoW1hPWFw3eVZ3EIsBe/uP2+6/Rg4wuQZjg4rDP2mrwFDwxSYezfW3w+5O+fHcPfrNLcSo+LyGhhlK2uC+Je/Vr9ScRuLLmXvEZfn7yRjc5pHhlSrCtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJhi2n1Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so297485a12.1;
        Wed, 25 Sep 2024 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306474; x=1727911274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BZ5x1JardeLzM/m5KAAa5mcr11Ogt+U3TCpeepywJI=;
        b=dJhi2n1YxTg4m4CWgE+jLNf1bL3/4js3yyt8I76Z1VZ0KyeOmgEm398Sb9/+fAoGm3
         1eSeKrgwxMGoY8uO4lpYU+zdnfm98fvPKxvsdUu/5ZmsHzo+gA4gvi7dID064oi9mhgH
         csMLxMm57KUaWz6oJunPddrkKHhRx+k0kW/EeSvD+SPCkmtO94atmC+lvFKBEDZ3sY5B
         XFoQYmfzv7N9DFJ7Wbxonz6TNjCmZ3+6QDx3brNMaoJw1PXyFfg6nUBh05emeCE9irgs
         cuy/LpkpIcJSoJFMmLFfIMT1AFCkLA+SEP1IJfC09BdZMFOq8fUs3Ors2aoOVcR6k9V7
         PhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306474; x=1727911274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BZ5x1JardeLzM/m5KAAa5mcr11Ogt+U3TCpeepywJI=;
        b=XTqu/Js3x4KiFrQyazfIPm9s/wHuYSSpfPMsea+94qersHrb95NT3ZT+0r/I1Swbt6
         owkIrwpONMWiwBhMS44uQl4vLhtfgFioDV3SY06il4hFldv3casFbjXxsSSE3R44vAw1
         EX0dCuLthPY6h/KcPxJg70E4bH412cN3/oQUWdYCY2f5XvctzhE/BeAkDXpJn4S6VSX2
         LZLDgV4DOERDarY08Bbh86iOwVrccsi7Phv1WQl8hDuCBADYYI52wHI+4LJD8CXjIRrO
         DUlOCCUN0plEABPSE5lFo+6JxqNh8z+X88TyYs+7UAbjxzFh02nmXujiZaPVbIF/+Zgb
         cK9g==
X-Forwarded-Encrypted: i=1; AJvYcCVgu1ZV3OT0Y44JPNd89Q5Al7ppNmeIgZz2vYYqmjRZvoehFfqprz3NXS3YX4SIPRpm1uScFoY1U5Vs+AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU76LKtTExlxGS7SGHuQQPymeWDZnEXGFJhoQmedN+Ui5TbW6N
	jiYXzAcE0FkMAAkYaKW9zIisc3gbxb/XCsAOesfG04GFWxwzcmPS
X-Google-Smtp-Source: AGHT+IFSfrNX5+ZdgLCD+cmSwZmmpfoMEsHjHpd/2Frq+M22Gl1QZHtrdQuR+01rVBpVHguU2B3qQw==
X-Received: by 2002:a05:6402:51cd:b0:5c5:c2f4:c4e2 with SMTP id 4fb4d7f45d1cf-5c720764447mr2105166a12.36.1727306473734;
        Wed, 25 Sep 2024 16:21:13 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:21:12 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] arm64: dts: imx8qm: add node for VPU dsp
Date: Wed, 25 Sep 2024 19:20:07 -0400
Message-Id: <20240925232008.205802-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DT node for i.MX8QM's DSP, which is found in the VPU subsystem.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index f8b577ebdbef..ae0165a44dcd 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -581,6 +581,33 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 		clock-output-names = "mipi_pll_div2_clk";
 	};
 
+	vpu_subsys_dsp: bus@55000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x55000000 0x0 0x55000000 0x1000000>;
+
+		vpu_dsp: dsp@556e8000 {
+			compatible = "fsl,imx8qm-hifi4";
+			reg = <0x556e8000 0x88000>;
+			clocks = <&clk_dummy>,
+				 <&clk_dummy>,
+				 <&clk_dummy>;
+			clock-names = "ipg", "ocram", "core";
+			power-domains = <&pd IMX_SC_R_MU_13B>,
+					<&pd IMX_SC_R_DSP>,
+					<&pd IMX_SC_R_DSP_RAM>,
+					<&pd IMX_SC_R_IRQSTR_DSP>,
+					<&pd IMX_SC_R_MU_2A>;
+			mbox-names = "tx", "rx", "rxdb";
+			mboxes = <&lsio_mu13 0 0>,
+				 <&lsio_mu13 1 0>,
+				 <&lsio_mu13 3 0>;
+			firmware-name = "imx/dsp/hifi4.bin";
+			status = "disabled";
+		};
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
-- 
2.34.1


