Return-Path: <linux-kernel+bounces-303504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C24960D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72BF28968E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9C1C7B71;
	Tue, 27 Aug 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TMBW+ThP"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8851C3F2A;
	Tue, 27 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767565; cv=none; b=UmNlOegQ7nDPj511yothmxycNMDycGJhUL4cnjDwgo15kuyEzQRb9HAIktkFGPW2lIulaF0MmkjCF4IOezCtn3kItYHbw0v9PRRW2k7+hnpbv8bMK7sF4+ja/Mz8H8s1s+GQdVQVu2blmZS0YfDN0JYxRWdoULeMxOEotkbAfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767565; c=relaxed/simple;
	bh=NJV2GpTYupn/9CCbpIRby7MiSvYS7eBCUO+0JatVDCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkUwkSknUF5Ha8JGhoc3U0wvpXsq3Wb7c7Xd+Bh25QUJlVMw+ZouzNTSv7KtOFVF2aORNuRvHHCa7aVsZRsHbBy5XS9ZfRQuZxEFaf2uuLn4xuJUeg1hO1B1QWq9xSUrKvqMJ3R/gb5b0pHKMWPwHCf7ick4t/rg7PDLC2sX1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TMBW+ThP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RD2EvV022293;
	Tue, 27 Aug 2024 16:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	sDJkLqaTPIYddIRhbJ78+aOcEQCOOTJ579ffK0YZauU=; b=TMBW+ThPkqlpdnYk
	w1ODqcGqttwIoWGIg6NPzqrIPVRZ2HWCb/Dksd9OA3R4HQ59m9uZjgKiJIj61215
	s9a0JjPRhPzS6RCrYHOAh3+Jy44RnGfe4U7AOHryNHyaFk7pK+1d14D+yj1LKdds
	DXGqdNy8kHEOWpefxd0CcgogvPmS8NIfy0LPKarNuwUqTAZSF3Kb92MGilSTRU//
	lB5uo5r6H7wvJdH0NR17z+/ksnNu4rzyo4tlCLw3tWPV71NMb7wSBphj02kxtGqN
	u2YOMxYnN2bvmqT9r2PporULZObmj0NUL21Oy9EtwgDer/roUL4J0uqx9GuZxMw8
	tfmV2Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fb408vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E64E04004B;
	Tue, 27 Aug 2024 16:05:41 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 48CC526C453;
	Tue, 27 Aug 2024 16:05:12 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:12 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:11 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH 2/9] ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp13
Date: Tue, 27 Aug 2024 16:04:48 +0200
Message-ID: <20240827140455.345086-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827140455.345086-1-valentin.caron@foss.st.com>
References: <20240827140455.345086-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

Declare pin for LSCO in stm32-pinctrl provider node to reserve this pin
for RTC OUT2_RMP, in stm32mp13-pinctrl.dtsi.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index c9f588a650944..5c28de7e365d9 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -582,6 +582,13 @@ pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	rtc_rsvd_pins_a: rtc-rsvd-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 1, ANALOG)>; /* RTC_OUT2_RMP */
+		};
+	};
+
 	/omit-if-no-ref/
 	sai1a_pins_a: sai1a-0 {
 		pins {
-- 
2.25.1


