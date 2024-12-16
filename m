Return-Path: <linux-kernel+bounces-447601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FC9F34C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7AA1645EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569311F706A;
	Mon, 16 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JQhFuTsr"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A251494AD;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363657; cv=none; b=mz4oJW2A9H0v5Xao8RFTX/vF8Q8uyt87E2HwcERSdf5vtw1VZ9+cszgKAb8iK5avH1TSpDOTM/2kf8QFobIjm1cHnsKmGNSK9iNlvPvzWGMX4ykbOB1uJtRQfXBCv1lfEr8NsN3OHx1QgxKKwpzyXihn6KM9nEcubpBZAE092Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363657; c=relaxed/simple;
	bh=jomqpe+omGfxO3r+Y4kxsNuI4XjEPlfg8XuDgZ3eY1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP8RBTODsTYkT2x7UPl7YNmO1Io2kb+n+OpgIcNAHiUBs/X7nb8yrsv1UHLY18QocgHGrvZwFN93AAXiWlxddt4KENbDzvS5C3pnnqaW+JGSvs3CGEgqQRhXEu+tHtRonwosdynlMmJyEXMU9CP2RAF2lSs19xMj7Fq3yXXAJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JQhFuTsr; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEZApx028644;
	Mon, 16 Dec 2024 16:40:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	nvLF11FcB2dtW8666kmjq3LshJkFjb/3saLUTOv8TrM=; b=JQhFuTsrszvz8XAs
	7FOPa6MafgqLur+RtNhm+ZrYhG+BT3/gf6yFoh8YvUzkz+TmWGGFZI8KG0l9QFl/
	6HsZ1ld78LGLWGNMtBlgwMorkJL8YA1C22WJFEpk/w2mPs5DONzDiucZW9Hdq3Cz
	VeOviV+2zIIucGCeK+9JGGpEzFrz3XKwHmoakWm4cVKE2gJKd+ixhNRV8QODV+ji
	pnottnxz7H1EDKGD5BaYRSFsMEmh+86t5+o6b/2EMvEOaHQLhAwf5kdMNpSayzAi
	AJtSZ12KrFw03RCRfNAEGmjCFBDjApwsxOfXUdg3ypZSq0OHFumO68XG0mLXcis7
	jU3skg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3mg77c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8C9BF4004A;
	Mon, 16 Dec 2024 16:39:51 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E5C8C277E13;
	Mon, 16 Dec 2024 16:39:21 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:21 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:21 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 3/5] ARM: dts: stm32: add counter subnodes on stm32mp135f-dk
Date: Mon, 16 Dec 2024 16:39:06 +0100
Message-ID: <20241216153908.3069548-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216153908.3069548-1-fabrice.gasnier@foss.st.com>
References: <20241216153908.3069548-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Enable the counter nodes without dedicated pins. With such configuration,
the counter interface can be used on internal clock to generate events.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 1af335a39993..c6a5bfe89a38 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -396,6 +396,9 @@ &timers3 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		/* PWM output on pin 7 of the expansion connector (CN8.7) using TIM3_CH4 func */
 		pinctrl-0 = <&pwm3_pins_a>;
@@ -412,6 +415,9 @@ &timers4 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		/* PWM output on pin 31 of the expansion connector (CN8.31) using TIM4_CH2 func */
 		pinctrl-0 = <&pwm4_pins_a>;
@@ -428,6 +434,9 @@ &timers8 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		/* PWM output on pin 32 of the expansion connector (CN8.32) using TIM8_CH3 func */
 		pinctrl-0 = <&pwm8_pins_a>;
@@ -442,6 +451,9 @@ timer@7 {
 
 &timers14 {
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		/* PWM output on pin 33 of the expansion connector (CN8.33) using TIM14_CH1 func */
 		pinctrl-0 = <&pwm14_pins_a>;
-- 
2.25.1


