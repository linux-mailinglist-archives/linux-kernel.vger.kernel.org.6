Return-Path: <linux-kernel+bounces-447605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B69F34CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24577A30AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D520627A;
	Mon, 16 Dec 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dMH7Iju0"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609061448E4;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363659; cv=none; b=N7yN1E/8DolHuGGePCIr2eRgvX0/TWC6V38KW5tOVStUwAgtcNqvyTWFza6QpEJDhPn4N4ov2bJ/KlKBkb5xyrxJC7qYMDrnlN0KsFrsExc3cDT0ehw/2Gf27yQxU7iVdOGy6bQnW8jI3jXdnlsoV6UfRqy7CuQB4YOvI2nIvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363659; c=relaxed/simple;
	bh=9DNIauzaXg1hkOQtTX2G0/c6dVnryyX0aB3vRrCI1ZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAsWtzj9NhMyibDnu9N6b88k8ZrCcK6QSJwgj/BPwnfISWW5yYsKVP/Lk/v6cB8y84+uT+7/G8WXR4l8DvPS3bmHcSNaKrKkwSoJ0NJYTHFHw1o1n9/NEZNmP3uuQP3+W0o/I706yW0bZWyUInUFfRyTIwTzw9hRiop9YNvaGLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dMH7Iju0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEYKiY029957;
	Mon, 16 Dec 2024 16:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	s/v1YHGVNRYUeWMmDsWob1hB9FIOwu/mNjAMSlsgc94=; b=dMH7Iju0Z0vXJZaP
	l27EatwrpqbCT/aUc7furYe28ESR/Tg4UqG8mEhdw1u3wycqD1DMV3W1fszv5zWe
	Cnw6x18h0w4SFjJ9zYukBkPiLg3QU0N7W1BeVO1xKjaytOAvhFf20RhT8CswiG3+
	FoggqotezUZ/nDWkUtPgy5lZDUUDGhPVAJSKq1ZN9UGiNSxK3G+TuGSyEmfucFXO
	loIpoi07CmnNvUd5po/OVyOgCXBKcS8OnuPUzlJCckCt9ULzK1JHoYGjd72X/Ock
	mXx8zr2QloSOYZBKcaHbfeldc8VcEfApOqabgrewncHMWVBBhDZXf+mngC0MhOVq
	U6UdzA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3987bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8115140046;
	Mon, 16 Dec 2024 16:39:47 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A880277E0C;
	Mon, 16 Dec 2024 16:39:20 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:20 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:19 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 1/5] ARM: dts: stm32: populate all timer counter nodes on stm32mp13
Date: Mon, 16 Dec 2024 16:39:04 +0100
Message-ID: <20241216153908.3069548-2-fabrice.gasnier@foss.st.com>
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
 arch/arm/boot/dts/st/stm32mp131.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index e1a764d269d2..0019d12c3d3d 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -261,6 +261,11 @@ timers6: timer@40004000 {
 			dma-names = "up";
 			status = "disabled";
 
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+
 			timer@5 {
 				compatible = "st,stm32h7-timer-trigger";
 				reg = <5>;
@@ -281,6 +286,11 @@ timers7: timer@40005000 {
 			dma-names = "up";
 			status = "disabled";
 
+			counter {
+				compatible = "st,stm32-timer-counter";
+				status = "disabled";
+			};
+
 			timer@6 {
 				compatible = "st,stm32h7-timer-trigger";
 				reg = <6>;
@@ -1196,6 +1206,11 @@ timers12: timer@4c007000 {
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
@@ -1221,6 +1236,11 @@ timers13: timer@4c008000 {
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
@@ -1246,6 +1266,11 @@ timers14: timer@4c009000 {
 				access-controllers = <&etzpc 25>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -1276,6 +1301,11 @@ timers15: timer@4c00a000 {
 				access-controllers = <&etzpc 26>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -1304,6 +1334,11 @@ timers16: timer@4c00b000 {
 				access-controllers = <&etzpc 27>;
 				status = "disabled";
 
+				counter {
+					compatible = "st,stm32-timer-counter";
+					status = "disabled";
+				};
+
 				pwm {
 					compatible = "st,stm32-pwm";
 					#pwm-cells = <3>;
@@ -1332,6 +1367,11 @@ timers17: timer@4c00c000 {
 				access-controllers = <&etzpc 28>;
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


