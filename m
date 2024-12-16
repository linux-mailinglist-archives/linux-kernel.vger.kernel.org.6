Return-Path: <linux-kernel+bounces-447602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513309F34CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDE8161C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE014EC4B;
	Mon, 16 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="r/rFzRaH"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60848360;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363658; cv=none; b=mQy02Yh5zGS4cLVp+ovZUvl5vQe2st2dz49AH5ORKKe25VMttEkq+RTTdmPdQHHpF5EmlEKxW+1BwnMgDA92ZiR4GcAQZxT7MGqX3rl+OsyNwSeJcMdFJvc+pNQjqGG/tLay84oX7DrGRaK3UYvkssaM2NHxEck7SnhY885Bqjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363658; c=relaxed/simple;
	bh=JYHYIHdthW37euPS1gVIzPnw6++o9+7WFxj2lRorT14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np949ymWIsQcUYg1mAXKlS8XnSqmTJNYZ4atQUQXgD4WUWm6c+Kd0XVmswfM2Q9We2upaPkbxgp9R+lfELRIr4dmeACcdtNndSQbZCum3Wm3scVq4gpD/rhgZ538g61bBWYSOThWALkXda3+lbc1GqHwKuD0IVVgJwFus1vdHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=r/rFzRaH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEYN89030036;
	Mon, 16 Dec 2024 16:40:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oyvfV+AYwDjBOXDtTWGqGeG/DtUzeN6+72wCHLNtRTI=; b=r/rFzRaHcJBnwpyu
	wgMwaZrS9W+xmRnmEEXU6/ksTqmhA1XAI6vxvbsmJC0oT2kw2GjSzCsJIUVxVeiu
	Zjw3/Fzke9nu9/65ch70VMTob8/SM4kMzldmzJ2V05MXypDMQjlTYoIqPzfbPmEq
	rgINum/MSpBogQ3d9lOQo0I1J6HDiWzkX5ExT+viks5PrQFm5aqxlp2e+rA4xeIO
	ImQQt0cjpSxe0ZqakelkjCUrgrc1t7sOjP6By74bVzzy9pdc7BPu0AJlOYKoKEPT
	y6QiW5tOUabtelsCyq7cJhMR9AHgehQy1/93lYgkF8BZLx99MPTxc8EtFnFitmwX
	Tp1pmQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3987c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 386384004B;
	Mon, 16 Dec 2024 16:39:52 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D395285ED5;
	Mon, 16 Dec 2024 16:39:23 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:23 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:23 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: add counter subnodes on stm32mp157 dk boards
Date: Mon, 16 Dec 2024 16:39:08 +0100
Message-ID: <20241216153908.3069548-6-fabrice.gasnier@foss.st.com>
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
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
index f7634c51efb2..a5511b1f0ce3 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
@@ -570,6 +570,9 @@ &timers1 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm1_pins_a>;
 		pinctrl-1 = <&pwm1_sleep_pins_a>;
@@ -585,6 +588,9 @@ &timers3 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm3_pins_a>;
 		pinctrl-1 = <&pwm3_sleep_pins_a>;
@@ -600,6 +606,9 @@ &timers4 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm4_pins_a &pwm4_pins_b>;
 		pinctrl-1 = <&pwm4_sleep_pins_a &pwm4_sleep_pins_b>;
@@ -615,6 +624,9 @@ &timers5 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm5_pins_a>;
 		pinctrl-1 = <&pwm5_sleep_pins_a>;
@@ -630,6 +642,9 @@ &timers6 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	timer@5 {
 		status = "okay";
 	};
@@ -639,6 +654,9 @@ &timers12 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm12_pins_a>;
 		pinctrl-1 = <&pwm12_sleep_pins_a>;
-- 
2.25.1


