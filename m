Return-Path: <linux-kernel+bounces-303502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2D960D12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FDB1C21544
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7D1C4EED;
	Tue, 27 Aug 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bhoA5mL7"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D301C2DD8;
	Tue, 27 Aug 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767565; cv=none; b=IFvOrgZVfvWKFDkOhuozgHSFOQOG23oUvvng+3kvzo8KNPMWW85dwDlBD8uc3c88AsDF2BaEpoRsb5eLHjp8NXTd0J/ttU+4S2VK1X4Cs4U0rF6jxttlgt9LBV3CTMD2PK0DaHNwnCv/aSOp0S56ern20U1PXgqIvVhZAlP3vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767565; c=relaxed/simple;
	bh=xwqGoVeYYcCiLQqDn/9Z6LfOpganhHaNBECsEqTgQsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUFX7z+VsE2aF/RaDrrNb4Fx775xEsuiNDnISIWL8zi8YAfbD/MqkZrQ1CKHv6vsPjeVha7DD0/N2I9RA6U0B1dJW+6aKTLKV1BW+qLXkxrAgiyleAocLGG1DiNnU0yeXK2W7e/Lmn2iiK7Xr8goRt1ywGRfD4h4GQkpFfsY9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bhoA5mL7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RDTE5e001108;
	Tue, 27 Aug 2024 16:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	WzSKuQohSXWkGwWoz9YprP+94aYdvrJkgRz9d9MM6WY=; b=bhoA5mL7o+ZQVI89
	cxhl3x7l+4F01LoQe2QyPIGdIE0DDDvYTRf9tpcGEGc6y1sjF9SqMcuokqnkv82h
	CxJS1BCCZdwbmF/R2PnTiw5FpZEkDqF76eDv4yUOJ8bSAGCVEnm7dD+UWkrPy+p7
	HGN+IpHZPBoivxkDFJvR9G56tt4+gXCSytJQ8cBr8Bg32ejN8vQ/kFz9+zSQywnj
	zEbZoMwpxdFFfvZrgJHkSxCzg6TZhPfKt22BhAATGaswRiASmDMZPhCtI9G11cSW
	f9sKQ2r5sEaSobYC7mNvHMMdzYofrN2t0KKQI1GbOiCQacytW9IvkrK7fKHh+JmU
	p7OQQg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fqs850y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7EF9640049;
	Tue, 27 Aug 2024 16:05:41 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5F6126C45F;
	Tue, 27 Aug 2024 16:05:13 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:14 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:13 +0200
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
Subject: [PATCH 4/9] ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp135f-dk
Date: Tue, 27 Aug 2024 16:04:50 +0200
Message-ID: <20240827140455.345086-5-valentin.caron@foss.st.com>
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

On stm32mp135f-dk board, WLAN/BT module LPO_IN pin is wired to
RTC OUT2_RMP pin.

Provide a pinctrl configuration to enable LSCO on OUT2_RMP.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 1af335a39993b..ef33cbf3e601c 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -346,7 +346,14 @@ ltdc_out_rgb: endpoint {
 };
 
 &rtc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtc_rsvd_pins_a>;
 	status = "okay";
+
+	rtc_lsco_pins_a: rtc-lsco-0 {
+		pins = "out2_rmp";
+		function = "lsco";
+	};
 };
 
 &scmi_regu {
-- 
2.25.1


