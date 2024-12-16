Return-Path: <linux-kernel+bounces-447604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24729F34CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AB71888F21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E514EC62;
	Mon, 16 Dec 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vJ6RsNca"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088C139CEF;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363658; cv=none; b=NSUbkNMXicfPO0hMMqqWBWrJswd3/EUhnti1asoA2z7gnXgn7F31P4QTP1uRPl5uF7cqQlCV7iyaIZq2YZDiZzeQ2CSvyQA2+PGx6i62MOc0RcYOr3uy44n+UsY4G8SirbdhyCZUkIuzocWbpz/xWhefjPrJMq7FXLUsNKE3Eeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363658; c=relaxed/simple;
	bh=N2kgzZOVzWLDW459NXaK2r/pAzur8WNILYSxQ5e0Mas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWkNLvTwkmk0egwgkY5DmaoWBZcBlhVJucylmSkqKV1gcbPdJNot/EiD6jbvVyaVmlalK6U6VNcQPYs1gMVgb3WDwKmDVMBsm2I5oSF8q6E1E5uuYOyhWWQoziPGoDQ1Oovh8PDrR6Bw+72FBedR7DG1lW2v8LaZ+GD8VEmeSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vJ6RsNca; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEYNe4030009;
	Mon, 16 Dec 2024 16:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	H52atDEyL00FQVVfOBWHhzLfvjxFekAzDVvPvLDq+Ms=; b=vJ6RsNcaxfIyqgBi
	nGuI82nmGsDVnqd/dKq5ssuoKnZx3SXEBaHWm4TBgs7qubFxhh71pnda7y4pihjg
	Y/ZVyrkNrXMFutGTAGxm8R/NuQz5uT217tt24oJ4GoJfYClwxeCkpsB7TnWcJt0x
	6Oz19/B9NNwtIYWBa9Et6wMbo0Z8WuWIPk91UAHi0VdhzKwmaTud2p6TE50I5ksD
	jeDlU0UYzS1ScjUDGygNSEsDbAST9qN7QSvnKmM28RREY13+V74xScgKoLb4Dv3E
	woAqn93hQtGfhg3oRJlnSlLxHwO4kS0CdpCOI6c6NdCOOaWH+ZpZIMnkfCXnF+0c
	Gtj6/w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3987bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BC71740049;
	Mon, 16 Dec 2024 16:39:50 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C49C2843BA;
	Mon, 16 Dec 2024 16:39:21 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:20 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:20 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 2/5] ARM: dts: stm32: populate all timer counter nodes on stm32mp15
Date: Mon, 16 Dec 2024 16:39:05 +0100
Message-ID: <20241216153908.3069548-3-fabrice.gasnier@foss.st.com>
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

Counter driver originally had support limited to quadrature interface
and simple counter. It has been improved[1], so add the remaining
stm32 timer counter nodes.

[1] https://lore.kernel.org/linux-arm-kernel/20240307133306.383045-1-fabrice.gasnier@foss.st.com/

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index 4f878ec102c1..13e172371eac 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -576,6 +576,11 @@ timers6: timer@40004000 {
 				access-controllers = <&etzpc 20>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				timer@5 {
 					compatible = "st,stm32h7-timer-trigger";
 					reg = <5>;
@@ -597,6 +602,11 @@ timers7: timer@40005000 {
 				access-controllers = <&etzpc 21>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				timer@6 {
 					compatible = "st,stm32h7-timer-trigger";
 					reg = <6>;
@@ -616,6 +626,11 @@ timers12: timer@40006000 {
 				access-controllers = <&etzpc 22>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -641,6 +656,11 @@ timers13: timer@40007000 {
 				access-controllers = <&etzpc 23>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -666,6 +686,11 @@ timers14: timer@40008000 {
 				access-controllers = <&etzpc 24>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -1114,6 +1139,11 @@ timers15: timer@44006000 {
 				access-controllers = <&etzpc 54>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -1142,11 +1172,17 @@ timers16: timer@44007000 {
 				access-controllers = <&etzpc 55>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
 					status = "disabled";
 				};
+
 				timer@15 {
 					compatible = "st,stm32h7-timer-trigger";
 					reg = <15>;
@@ -1169,6 +1205,11 @@ timers17: timer@44008000 {
 				access-controllers = <&etzpc 56>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
-- 
2.25.1


