Return-Path: <linux-kernel+bounces-183817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D18C9E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D6B228DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA21369B8;
	Mon, 20 May 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MsvF/ukI"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CC135A6B;
	Mon, 20 May 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213718; cv=none; b=mxHuNFiZWQUfPWdiywy+4vOZmcjS8dZqfE7A8+Na8F+mMsRHexz39IhlB1UMmebiTOUbTjQJrEvtjsYO2MVR4fMi7mSulJ8ytu3/m9gdrFBci8rUD3TcB7xt/iMSvkzV2T2RWKanrtpAxscBBvt1Zb43DrqkDQXH6MxOdi5zFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213718; c=relaxed/simple;
	bh=TNgDFSSMCv6U9WmBWIyOblr8xZyFTjT67V2gCdCXa9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMJNeiw60i1uQUDhcMKzQdtSAMU8DSTbvU0G5CdIHrzsQOFBy4heq980QmYSXxqlM8XaoafgNkXgITycMqhS9a7dKdtKMe+gWH/+WPtr5P0wpHkyAR/78agKEONn5BJcseQPMlnPCfNWGpSBtCJsSd+Ozgw5PMtJjVXfqlJPN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MsvF/ukI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KDxAV5023047;
	Mon, 20 May 2024 16:01:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=f9k8KFpeNIYsTHqtNNW8OjMXp6vJaNWX8ngMl7er10Q=; b=Ms
	vF/ukIiO2cgJEkMvHkMWN19QNEFT0y7Da0DRZVWihQyh6wiYrIFjRHi+ng4uHo6N
	FhWsPuchvsGkGSeGgV8DgR+V3aVwz8AFsI0eacXBrcJMkWhftpNtazted6nD+jsh
	pWavvIIlwgkfVKqBOisHK+DOmGTCXkdIAEAeqJicPTGSKSVv4iIRyGD3ROgGyD2k
	jZ4xfuHbrjF7igN0LtqxXr4Jf5gSebZoVOmYGGH5qQjpjqm57OcyKc9+AGBzbHz0
	Fmam+tNUwZ5hFR5yswh+y1Usimw/iToKPW9N1HRUgBYyir1Wk9La3mR+EqqXjMHA
	kH8/CEh6clisWo/Fkmww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y6n6hfb1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 16:01:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C8D540050;
	Mon, 20 May 2024 16:01:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BE01222C88;
	Mon, 20 May 2024 16:00:37 +0200 (CEST)
Received: from localhost (10.48.86.111) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 16:00:37 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 2/3] arm64: dts: st: add usart6 pinctrl used on stm32mp257f-ev1 board
Date: Mon, 20 May 2024 16:00:23 +0200
Message-ID: <20240520140024.3711080-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520140024.3711080-1-valentin.caron@foss.st.com>
References: <20240520140024.3711080-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01

Add pins for USART6 on GPIO connector on stm32mp257f-ev1 board.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 7a82896dcbf60..4e677e64c406f 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -128,6 +128,47 @@ pins {
 				 <STM32_PINMUX('A', 8, ANALOG)>; /* USART2_RX */
 		};
 	};
+
+	usart6_pins_a: usart6-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 13, AF3)>, /* USART6_TX */
+				 <STM32_PINMUX('G', 5, AF3)>;  /* USART6_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 14, AF3)>, /* USART6_RX */
+				 <STM32_PINMUX('F', 15, AF3)>; /* USART6_CTS_NSS */
+			bias-pull-up;
+		};
+	};
+
+	usart6_idle_pins_a: usart6-idle-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 13, ANALOG)>, /* USART6_TX */
+				 <STM32_PINMUX('F', 15, ANALOG)>; /* USART6_CTS_NSS */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 5, AF3)>; /* USART6_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('F', 14, AF3)>; /* USART6_RX */
+			bias-pull-up;
+		};
+	};
+
+	usart6_sleep_pins_a: usart6-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 13, ANALOG)>, /* USART6_TX */
+				 <STM32_PINMUX('G', 5, ANALOG)>,  /* USART6_RTS */
+				 <STM32_PINMUX('F', 15, ANALOG)>, /* USART6_CTS_NSS */
+				 <STM32_PINMUX('F', 14, ANALOG)>; /* USART6_RX */
+		};
+	};
 };
 
 &pinctrl_z {
-- 
2.25.1


