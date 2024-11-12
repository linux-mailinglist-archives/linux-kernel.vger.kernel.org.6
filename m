Return-Path: <linux-kernel+bounces-405268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036E9C4F53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C18B23C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E220ADC4;
	Tue, 12 Nov 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DUIdKcDy"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439C1F7092;
	Tue, 12 Nov 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396071; cv=none; b=VWQ+4hDzFR/eOzRKRwQbYfMa5b+fRTioFC3ToFu8YCpZ2l/ppCiI7ilUPgOrBKFj6T9Fkk6V8ZQxrwpt6OkkYooOKNy4xwttdXN3btYSFGSz75puCWzJKIicHRmunVqpPATbkpPVbVsPzMjP3PNvqqhkpVYL8WUe3lkDjc/cJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396071; c=relaxed/simple;
	bh=wrKIdWFIRjnYM0/FEARW8Zoz/7hxcoFVjPBqwJYEUBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FiDS7uIskfXMs0MVZFy0SmEaWUF/l/v5TYf3CWN0L+84cQnLBkbpJ3QESLtA8FHqY5/Ou+GCIOBR172INlFHCG9BOo0QvQOcCx1+z5hB5OI6vd7jl6qXUYpkaircIKyd4ipyfoGLnjNDiD2IEvCC3bKXY2JcFDsMAwLWEDqe8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DUIdKcDy; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABLu5gD016704;
	Mon, 11 Nov 2024 23:20:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=JlUZyI451SP0ByeDZt2Rr3A
	tu/Ic1hLEBuyaHi0J/rI=; b=DUIdKcDyd/y/2a0eEEEn9Day9UOpaLqDDEg0+rU
	M5mOSNstO5lO9hp6Nvyr9s30laMKRpE5xYCP5MlY6O6M6EY52P7XCosooRWJMSsC
	MKESpfwW1pO7ad7z1x3h1iD0v7IS11h0bWQRSsVmDmz6ON2VuKldX+dmbar5Blz+
	p4NIpVCRNOUkApcvrOOyQ7VSXA3blfkVImWgdAZdFY54FYOsVAsOMKXSJsr8GI4Q
	v085s1BbBpxyh4a11uR686gMwiH5dpo7njCqCZek19qPPOdajUBfv2bTNDLeQIdS
	7UsXZps2yo+Evmkxx6BFMfM9T3qGGWU18NNp5mswpiJQ52w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42un9d1d29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 23:20:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 23:20:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 23:20:54 -0800
Received: from localhost.localdomain (unknown [10.111.135.16])
	by maili.marvell.com (Postfix) with ESMTP id AD5C73F707B;
	Mon, 11 Nov 2024 23:20:53 -0800 (PST)
From: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
To: <linux@armlinux.org.uk>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <salee@marvell.com>, <dingwei@marvell.com>,
        Jenishkumar Maheshbhai Patel
	<jpatel2@marvell.com>
Subject: [PATCH 1/1] arm64: dts: marvell: mcbin: fix PCIe reset property
Date: Mon, 11 Nov 2024 23:20:49 -0800
Message-ID: <20241112072049.765097-1-jpatel2@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7PIGneXPdl4sxcjbtoUaIgMZ9Nl_kyln
X-Proofpoint-ORIG-GUID: 7PIGneXPdl4sxcjbtoUaIgMZ9Nl_kyln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Set reset gpio to active high

Fixes: b83e1669adce ("arm64: dts: marvell: mcbin: add support for PCIe")

Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index c864df9ec84d..a8c732a47360 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -181,7 +181,7 @@ &cp0_pcie0 {
 	pinctrl-0 = <&cp0_pcie_pins>;
 	num-lanes = <4>;
 	num-viewport = <8>;
-	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
+	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_HIGH>;
 	ranges = <0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
 	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>,
 	       <&cp0_comphy2 0>, <&cp0_comphy3 0>;
-- 
2.25.1


