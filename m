Return-Path: <linux-kernel+bounces-374707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C79A6ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EF2282203
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D11CCB50;
	Mon, 21 Oct 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKlzz+lH"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE11CDA31;
	Mon, 21 Oct 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525993; cv=none; b=rZQI0OzqWKPtQcNrDvi5nbiyBXXj9s9LEoZz55Qes6bAnKRPHZKft0EQaQm3vWAzl3cLRcsowLQF5J0MZPJE+oOMvaIEoVzbnBfIPS8Tvwl/EHtCql0e2y4E9rRwkRuKqlEVUPZj+9VdJ/t1LVlxoBcTeVkUxnFH9l54rwbiyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525993; c=relaxed/simple;
	bh=Epo2f8CClFWOU7OZcabjsgsgMJkLE6WS88mqKAYz3SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkWG9A2dm627SqqvWl/xD7ZQF7nVDPazE+ZVpvAAV/KnujJQvglyTKj/doLNM/VaTvABItgFCMfMSQ3i3n332nmKNOjMFsd5OxcKCe+icGU/WY2FACd/azfX5nUGuZ9M9eswUWZcp99OfGt92ECDE95+12b4OqK6rm91/z1LS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKlzz+lH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso561961666b.1;
        Mon, 21 Oct 2024 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525989; x=1730130789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2chh1gFajejKZHrarLEBUexr/8trAcrKkIwoVI3Z4qg=;
        b=nKlzz+lHounfMfdg3t4XOtIxyJbTp+D5r1h+BN/UC3GvS+4g+ZP2MR3+nbOnaUGj9n
         TGyQJSNWX3LoAiyR8tBVM9jE6yAbz2ccbvzYmv4xQ47PzSu4F+/KdRadZn5RULgmxNTs
         Vk9R8FGszO73DZ/eJ7VkeHFBDCASmF+ErthDsza9RPpoMpljZDPOUyT4uTkega5Hw/hu
         RIO4PK7mGGWJloOmaUQyMaE4U9PLhrUPByoH3z5rP6ZxekUuXqyRnLTZD66Bi3emBh/3
         lGvod7jH6a1/KO5wVomYONvrC7XjG3aTeaPBsNv5vN5bGMLx6O0k/btkmp6kr4zd2M78
         Ra5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525989; x=1730130789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2chh1gFajejKZHrarLEBUexr/8trAcrKkIwoVI3Z4qg=;
        b=H0fhCv6YbmUa5JS7yzLDCXcWY3H6qED+17CPPvPG8BLOoSRmCLv45TYwaxIKeLtanD
         SEekRoo4s4nI1bocJBLqZfmgP8QSgtUoGYKe6gOGWPMTqv9nKrPkG6mPYdiEkVdrYifI
         hIOKg0ugx2bNzpMW7+vPgGRfkBv65zmmF0arQQJTv3MPcBqivQphCJkhMKKgWI7V8+Rq
         Lt4c0K+4wOPfOpJLfN4QTRCedFTG7qpNDK0eOVbHrjg5wi9znP6TKiwU1D26EURp6XoN
         7jeqxLXT3fDCOcH3Hv4NZP6IWG+Uss33tKx7lyWECBjq6AYbb+Cpod3nBEwJQ7nt7h84
         DrAw==
X-Forwarded-Encrypted: i=1; AJvYcCWmuvCCGb3yTxDXWekMdpV5i6Jg6v4BNf43fE596RTzpsNn/e1sic4GTxEzCIUukJQjsbduZ5N3M/GIZm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAc2Fjx15IIqY0Ltt+L+O4W3tLNQh5B2xzCRXWh+JA15AcOYh2
	bZDLHGL80z3i9uZStF6xce7QGtl3/l7AnPQGHJaRmTUYkPpLRlh8
X-Google-Smtp-Source: AGHT+IGakfEy8rOuT2uN5Y5ML3kJAkTNrahvSRBkdLnfVpcFg+EpcKzRgNgLvMofjovBFMrKtZNDzA==
X-Received: by 2002:a17:907:9628:b0:a9a:e9c:1d8d with SMTP id a640c23a62f3a-a9a69a75087mr1048668566b.17.1729525989094;
        Mon, 21 Oct 2024 08:53:09 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:08 -0700 (PDT)
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
Subject: [PATCH v4 5/6] arm64: dts: imx8qm: add node for VPU dsp
Date: Mon, 21 Oct 2024 11:52:20 -0400
Message-Id: <20241021155221.112073-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index f8b577ebdbef..abd7cfd9a6c2 100644
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
+			mboxes = <&lsio_mu13 0 0>,
+				 <&lsio_mu13 1 0>,
+				 <&lsio_mu13 3 0>;
+			mbox-names = "tx", "rx", "rxdb";
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


