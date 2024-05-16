Return-Path: <linux-kernel+bounces-181236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522138C795F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1CC28AE32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239714D719;
	Thu, 16 May 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="niiKBIZn"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D914D2A3;
	Thu, 16 May 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873177; cv=none; b=pDL1MlDUliS/CBd+PI1KE+4HKQytJhGuC2nT7B1QchU+esRfhA9MioloCMPPm20TmKlhnfjJRtuKQ77CKgMt2FD0qnpkQRHb6KXt9E+Ris1rTp0X2Laox5s5VJgfNRyadt+qCOp1rrc4pwNOIfCMhya2Gk1TgqmiQdkvHeGjnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873177; c=relaxed/simple;
	bh=aXqDgEPjwHMD2PFCnGHgOg/xjWQI0U5DZ7CMG6pHtco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6lGv7+sxBGKIQ8ZauG3QIOmByixWEEzx2xBjjU8hALRw6CwGo8SiLzQ3Q6c7NEAOsmk5JnDV6PCeJ7B0813O6+B7LDl59Z3oKErSsR2CSsYhznNpOhFvQno0zpRS1J09ukOYAHahpHrBwIPT/aKy9mOzyvopicMIkAhULhLUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=niiKBIZn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GD5XZh009990;
	Thu, 16 May 2024 17:26:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=VDo9KLS5VfcqruiE4K9r2uLa3efLXIlw/R2YAL6iasM=; b=ni
	iKBIZnvTl78+xl/TTrU62H2Hbu6SmGhK+S23XJ8pme/OnpxxyMyZViRbbsEB/f9p
	9puVOvrbZsbomwWe4jFCKQhC/1kMafDn+MuJ/TiOTbCWrjf1MX0m9t82OtX6iMdG
	HMShfIB2jsiChlhrwE2kx++IvhsapM0iLx3CE/7vpmQEtbZVm5XsLv9KBirCxDmx
	+L89AMvFQMtaNg0GZiFm9XBYWrF0LRwfdNUO11yZuIT68ZbMdEs3HQe2OdJlZt5n
	zXXwQ7kVeA1RsRLQwCBp5mzgc4una03MdOlSe8HAirBpGiuUpJN+MtitzuoWPXwT
	NIsqQPmvjKDUyYtsAlwQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y4sxv69p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 17:26:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F01540045;
	Thu, 16 May 2024 17:25:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6D34223653;
	Thu, 16 May 2024 17:24:56 +0200 (CEST)
Received: from localhost (10.48.87.209) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 17:24:56 +0200
From: <gabriel.fernandez@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Dan Carpenter <dan.carpenter@linaro.or6g>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: st: enable STM32 access controller for RCC
Date: Thu, 16 May 2024 17:24:27 +0200
Message-ID: <20240516152427.692374-4-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516152427.692374-1-gabriel.fernandez@foss.st.com>
References: <20240516152427.692374-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Use an STM32 access controller to filter the registration of clocks.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dcd0656d67a8..602d02efc202 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -441,6 +441,7 @@ rcc: clock-controller@44200000 {
 				<&scmi_clk CK_SCMI_TIMG2>,
 				<&scmi_clk CK_SCMI_PLL3>,
 				<&clk_dsi_txbyte>;
+				access-controllers = <&rifsc 156>;
 		};
 
 		exti1: interrupt-controller@44220000 {
-- 
2.25.1


