Return-Path: <linux-kernel+bounces-303507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D7960D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278EC1C22786
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81661C7B73;
	Tue, 27 Aug 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bf+7eYHp"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC041C3F0D;
	Tue, 27 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767566; cv=none; b=sw+bNPaGolQqME+fJMtP38OcJmUyduJ3mDnqZizpD3Fruz3TQMaPa2LM64Y7fcC5C70KZoWYKn5+OdPj66XFH0Z7sLamcyixeCYK9TBBuIaRw+cHfbv9vWpP4O8Rw3TgUisnnAAuFfT231LVg/g84fMc1v8TrS5LIxYxNefm9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767566; c=relaxed/simple;
	bh=2gUrI/wnDkkwevIEBsqI2sQI/7DW27Ycob+3WGd3ImA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xaq033zHDMhK93WasPUepuN7xng9wNNwTG71PiFA6rxz+Y2aC9HsaAj7qdL1zdE1FVCtIsCebobryfDeLSd6+Os+9JUrRz91a6cJZUxASBMFmwpUXKPQ+uQkY6E5QE6WRMVxlF5kwOhtL7QSOZoRQREI0YSFXzx0jH6kYKKa0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bf+7eYHp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RD2FKI022301;
	Tue, 27 Aug 2024 16:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=OWUzcb7sZC3fpmb7ZiuMCd
	Jr03L3mabve5VPP9D+l+A=; b=Bf+7eYHp/Rd6NAA6DfRy4CLOpA4eynoi6fioTM
	gLOB+pHKiECfWGQsagJ/dS9VA99P/lXQcVSxZ7K94FKF0POqMkgncYpj5xIEGWie
	Xv3++IQcwmS4weOjiUh9cYnjJJKLrXwYDubhXeONcC3q3T77oNzTaFCzBH1XFj08
	7mlLIbbvE/m3XPralZxdfUbgcezz2fkk09C8d4ZE/anxkWzvegauS0cJ5vPKKc1/
	fMsPLowVNc61uU/zHs7xP/Pq8GBs8q2fhzhRewm0mLRaKZkpSnRdnkkDPUXBaXzB
	ST7hARvw9avuFin3rO/Sn5RFUs0VypZEY+kMSgA1zgm52ozg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419fb408vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:05:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 24F2B40047;
	Tue, 27 Aug 2024 16:05:40 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF30B26C449;
	Tue, 27 Aug 2024 16:05:10 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:10 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:10 +0200
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
Subject: [PATCH 0/9] ARM: dts: st: add WLAN/BT on disco boards
Date: Tue, 27 Aug 2024 16:04:46 +0200
Message-ID: <20240827140455.345086-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

This series enable WLAN/BT module on stm32mp1x discovery boards.
Use LSCO from RTC to supply 32kHz clock to WLAN/BT modules.
This is done by selecting "rtc_lsco_pins_a" in the WLAN pinctrl node.

And also add RTC nodes on stm32mp25x to enable RTC on stm32mp257f-ev1
board.

Christophe Roullier (2):
  ARM: dts: stm32: add support of WLAN/BT on stm32mp157c-dk2
  ARM: dts: stm32: add support of WLAN/BT on stm32mp135f-dk

Valentin Caron (7):
  ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp15
  ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp13
  ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp157c-dk2
  ARM: dts: stm32: rtc, add LSCO to WLAN/BT module on stm32mp135f-dk
  arm64: dts: st: add RTC on stm32mp25x
  arm64: dts: st: enable RTC on stm32mp257f-ev1 board
  ARM: dts: stm32: rtc, add pin to provide LSCO on stm32mp25

 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  7 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 52 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi   |  7 +++
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts      | 51 +++++++++++++++++-
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  6 +++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 10 ++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  4 ++
 7 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.25.1


