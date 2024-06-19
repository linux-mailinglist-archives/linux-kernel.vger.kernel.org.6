Return-Path: <linux-kernel+bounces-220713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C34AB90E5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A3A1F22D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2217EF09;
	Wed, 19 Jun 2024 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FDU2sbFS"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AB7C6DF;
	Wed, 19 Jun 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786249; cv=none; b=aY5rZdGZIm8KFGfIuPAguCieZGwKWYXhKfvv5ZeCWGq+MenYtKLHaEMzVcolr8MaQgabs4aDgwhnAU+GnRUPRc26JhnuWeFfBMiD731BUhlm44UE91Qc+eK6EvrnBmf64mxW7/C+4go3oTIbfEPm1gNV+6qUiWLmiJBsAtKshXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786249; c=relaxed/simple;
	bh=A6CcOSt5OgXTngZLoT07YHKknaUK/Q9MAttPeiHJhgE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WW3vWP3sPhTu4v9tZ/lnmWL9q7BTkqmiM5QWKDWxrrdjLKvqlscsT070FOWUtPbXMEnqIqOs5XWauRXxb4ZSufWayEQUUcLCWYkV+X2mp4gtN2uOOFpv4V1worSg9GzjBT1z7WQ45rIK5SPffiKq6UP2kahp+cENE/mN22RENiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FDU2sbFS; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7Ruge002275;
	Wed, 19 Jun 2024 10:37:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=XOCbwETXxIA+0drv6fkuip
	MY97pF222Z5qC+mHznX5k=; b=FDU2sbFS45KDSNH8SvVgN+ls58xYX5umz53A6A
	f7RC9K65Wciv2NUsMZJDOkd5iPmLLOXFGJofGfBUQeulQoXNpiHHa7Bobh+sFdOG
	jpLmgcZ3OQ5x1s2t4DAyCrYz9SIcWodmqp0NCnEygrgfADE9qekV0OthuAuYqSSK
	bKHCmqM0X/zYuGCILK4pPoM6u6Qztg6Ru+tr+rAEcjo429/x4ytTvExvcp0b7mwu
	lnuE0Eeh0yFJhbav8/7lzIbxp1xM693BUZw/vs0sTYsU4ReQ6NDsv5lo7I+ddjEN
	JmvZSvHR8mKfJDqxtcCT5mjxw/UCh3vZQMNKtHbO99GuVvmA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9n23rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:37:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D426B4002D;
	Wed, 19 Jun 2024 10:37:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C80620E1D0;
	Wed, 19 Jun 2024 10:36:10 +0200 (CEST)
Received: from localhost (10.48.86.232) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 10:36:09 +0200
From: Pascal Paillet <p.paillet@foss.st.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: <p.paillet@foss.st.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 0/4] Add SCMI regulators desciption on STM32MP25
Date: Wed, 19 Jun 2024 10:35:58 +0200
Message-ID: <20240619083602.33007-1-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

Add the description for SCMI regulators provided by OP-TEE firmware.
The binding file named st,stm32mp25-regulator.h will be also used in
the OP-TEE firmware.

Pascal Paillet (4):
  dt-bindings: add STM32MP25 regulator bindings
  arm64: dts: st: add scmi regulators on stm32mp25
  arm64: dts: st: describe power supplies for stm32mp257f-ev1 board
  arm64: stm32: enable scmi regulator for stm32

 arch/arm64/Kconfig.platforms                  |  1 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 35 ++++++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 43 +++++++++++++----
 .../regulator/st,stm32mp25-regulator.h        | 48 +++++++++++++++++++
 4 files changed, 118 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/regulator/st,stm32mp25-regulator.h

-- 
2.34.1


