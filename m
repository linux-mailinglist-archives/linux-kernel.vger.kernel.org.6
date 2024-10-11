Return-Path: <linux-kernel+bounces-361358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAC99A72D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17701F246C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D4197A6C;
	Fri, 11 Oct 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgKa8TCb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AC198823;
	Fri, 11 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659164; cv=none; b=rORELQVdB76damgIs0V2nMZ+TYgi6iacFH5dndtCuLlIhXSbunZrXHc1IOpAbb72DO3a9iFAU9Vx7VU1xSBQyX+Aj4frW9rAs55oQO2D/Xq91zsZyRn+Bq4aMTrWIjamNA+4amECtsV+h4+A8mwxNQ0UwsmLoV+/A1XaWlEHGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659164; c=relaxed/simple;
	bh=HOrUBsmnTP5kUCPQrgNppvm3i8MgiMn7KdUPyymMl5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPhynN1Z4e/pX+oSI1EapLy3whhmGm6d45WsAPk/FJT7ojGU+9E09CnvmqLkhFB7xAEqfkOwSa/N6+68Upeyp+I3bJF7GV9EXUfL8CZjrIg1S0PJogsCS6q9BzmkHnaO4qCNMTxZQFnYoc0GX0IJYnVJMAT43iu+shhPaji32AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgKa8TCb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53997328633so3674170e87.3;
        Fri, 11 Oct 2024 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659161; x=1729263961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqRNfnCg/qPRyymj7N8Ka+MkmJ8hZ2bKmM3stNf1O/A=;
        b=LgKa8TCb5ApB5zMcgrAZDlGXGqFZBkycp4XP76QYbY7EJiStn/bTKqF3MxHG/EZxQZ
         n2pd2fvwqE6KbGaEveVfYOpLAfFCe5f1huwToBD40GVexzdIJ/qjOYR2vS3tRxVtFYlP
         ufx3AUsL2iewqxprQnnUnjWiRfwSiJRm0hNYnK6ChjfdtnmvcN9/CG8rrY8y7ckj3Kci
         QJNCPsw0Ipr5rzfvfEhSORfsHSaINaSpgsVAA0CtUBuf8R7jnhwIhgw6uTqvDPmlM22D
         gDrw9sXwv7dAGMULux2izfJUscyCYO+zCgr6TCkEcwXDK1mqi8k24k25+xZk4Oq9tiPJ
         BfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659161; x=1729263961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqRNfnCg/qPRyymj7N8Ka+MkmJ8hZ2bKmM3stNf1O/A=;
        b=gbVEgoGPc9gMS90q1TWrss7Jv4Vr43ap2Qku7uFUWPUh4T2vEral1N0EwAGhF8FBtC
         ItVbfRQyNM4NpiiGsHoNzicSTtka8TeXZ6f4j0HLRy8Our+FGWw3omluQWJyAJKynb+K
         UEFlXLfCcpgyUhpaXWIWP5YMYAqnLaBvughBcMaPa2Z8+VDHlP9EKcIgh4PLs61Ap0li
         b4WcCBJCwEHxyHAXz0pHl6ul/NeyxZdqQAuKWtPQcJfOswbSxt2MXoCUxfNuQkQeepuc
         WeV3K9vlHtwd7PSxbXrp0hdo6DFaUcJBIsuQLAETMOhVcHNDJNJ+2Z88fFJdCgffjaC0
         ueDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKZZk2gDfqPpUpM4lD6DLGrpbByz3y9D9mEhPZDyy6amVEFaT2MOf7H9SGRk2mIp0pMtLB7tKww3QyAFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusiFWb3SwziMT91kA0bDF6cniAquHrWAKjJJRsdYPF9kar3wj
	Eep4QJACjQy98wcCnsiTdGsTwa2HuywlhQakWycUMB6xa/FWlEkV
X-Google-Smtp-Source: AGHT+IEKT0YkXSTJh2zrXW7Gn7aBjsFlDsfYaG04GDGzDuTHMb+ZgvkgKBp+eaHUzrpn0jmr8e3R7w==
X-Received: by 2002:a05:6512:1113:b0:536:55cc:963e with SMTP id 2adb3069b0e04-539da564a1dmr2617584e87.44.1728659160589;
        Fri, 11 Oct 2024 08:06:00 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:59 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/6] arm64: dts: imx8qm: add node for VPU dsp
Date: Fri, 11 Oct 2024 11:04:38 -0400
Message-Id: <20241011150439.4027-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index f8b577ebdbef..74857a94bcd3 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -581,6 +581,32 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
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


