Return-Path: <linux-kernel+bounces-303503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02BF960D14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F201C22785
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAED21C4EF0;
	Tue, 27 Aug 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2DAPTX8v"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C81C3F24;
	Tue, 27 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767565; cv=none; b=Mzj0c0OeaYcRe6wn/+qjSKw6KqsnXM1fE/wfxu5aMwXdbKqhKVChddx5lUViXa8w37S0bOentq2S7lUu0ou+yJbYIxjBHJz+O3Uqu+xcVXjU+pfvAh//Gx9YbAlrtUbeqtH2qAHM1UgshLgLuIY3YU+I4QigydiliFwH/zAvfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767565; c=relaxed/simple;
	bh=b+OWBLADBrr/GmrDMPz7EfexwhNN5RR6CxuBlLpqDIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnXGCS6j16j4iNDMHaXcf68d7rflnZFZe0LJPSVSIcJ69JvaXHK2CKKOL9gLQW/KBquoqtgKUQHfifVM1D4u2cz6YLkvfThBzmuULNQ1eNFDEwb5rFOYVe87rffpq//9Plpav5cwSvnYzmQqhZqHdKEDKPD48gyYTChX8Sd4F+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2DAPTX8v; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RD2WGM022442;
	Tue, 27 Aug 2024 16:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kIOHLwaJmjvrB/zlD7QldFbSwDEMLSBvbw1Ydt0JxtU=; b=2DAPTX8vus+rZckV
	F+GC3Bonr3JXQCF4nQ9O29IAqN6v8uEwqshDbu5ix36UwWol2jUjKAdsuogdQsS4
	U7EhU3O/RQtj/3hmLsj1b68ZrYX120czdJ4M3qNL6kXVFR+HOWsceQzUkgpX7ofm
	Ag4EA8amt/8fbcUcwb5nq6g1yleBOCaqt+UMKYMppxvTPFI4Y6Bv9XNzFHqXYUM0
	ZOlGAuD3nQ1T0Y+f5HejAoq6XBhlW3/LP/KmjMN0GT+9QiZmWzMql4UV6wl5bET8
	k7d3YL5vaDnKvmEM5aRubF6j8caVgjBv3acAS61+6qfmnSdzUQ+ETQTnVpUfsavk
	offUww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fb408vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B6E5240044;
	Tue, 27 Aug 2024 16:05:41 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 110EE26C45C;
	Tue, 27 Aug 2024 16:05:13 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:12 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:12 +0200
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
Subject: [PATCH 3/9] ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp157c-dk2
Date: Tue, 27 Aug 2024 16:04:49 +0200
Message-ID: <20240827140455.345086-4-valentin.caron@foss.st.com>
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

On stm32mp157c-dk2 board, WLAN/BT module LPO_IN pin is wired to
RTC OUT2_RMP pin.

Provide a pinctrl configuration to enable LSCO on OUT2_RMP.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
index 7a701f7ef0c70..8ac1233f9a02d 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
@@ -84,6 +84,16 @@ ltdc_ep1_out: endpoint@1 {
 	};
 };
 
+&rtc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtc_rsvd_pins_a>;
+
+	rtc_lsco_pins_a: rtc-lsco-0 {
+		pins = "out2_rmp";
+		function = "lsco";
+	};
+};
+
 &usart2 {
 	pinctrl-names = "default", "sleep", "idle";
 	pinctrl-0 = <&usart2_pins_c>;
-- 
2.25.1


