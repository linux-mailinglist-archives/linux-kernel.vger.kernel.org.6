Return-Path: <linux-kernel+bounces-447600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6799F34C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F571888399
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345711C4A3D;
	Mon, 16 Dec 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QBjCY4aN"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60953148FF0;
	Mon, 16 Dec 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363657; cv=none; b=bD0aro3ZHsOzkg82p37jkfh1wzfEARpvpxhMF6E0E2oQ1LiUAad5BZEL6tnYMS9229fn2EZIZnpkiGtnzEv+cQk29aVKsItQlU340kmxqRHTMH3gYBs+s0C2shGUAb64OuGKe+T7mRB4Wssf4xRvnJgc3wbpADWPaOtHUHbh50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363657; c=relaxed/simple;
	bh=oFwMCFZ2MZ6KSyy3gYMaAl/TnanV97irGAsEcqjJzJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFahd2kVC4sqboDCBIF/MvtyvJiU4O2uovMVTDkeuwtW+bCuLzhMaHgRHDjt/Ejc4eUjqyL3HegFEbGuaxrFhEPmVnnPN1abmUChAphEHurJDoCEpJHxN3CHtaiPIJjnpfY1HFtBabsrn6vL74VEHU/N+YfjCi0fAFuj2IEqPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QBjCY4aN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEYOkk030050;
	Mon, 16 Dec 2024 16:40:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	D3j5CJpUfFk44bu0NIpTsj1poKDcdrjF8B4oIGcYhK8=; b=QBjCY4aNw08iVj/2
	Ff55vd4QhNyoFO2XRJea4CYS/xym4oyfmGqHk9gP5+la5mR6cHlzcs9pBiRGdwMf
	3BYc3ohkrFoJtk8WyBXHH6h3JSwDhO0AYLI3dNQ9jXP56L9wgVSZvsEp+xO+FqYJ
	YhZEz8hFbqhRAXuw5Xnnqyl3je8ji4/v+SvT2djRYhFkfLOBlrykUCKnmyvC3H8m
	AH3nbPkwutasGJx6Vuvzc4s1QPXvQ419zdZwKmoPbXcUnNCPe9D+lUj6zOcQMWfI
	D35BRbqPLj3at5KmsF1aY1dmHnSQI7ta7gpdOE/8qc7OHE980z+KbI/q+LT3OKpF
	98p8vw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jp3987c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 16:40:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 65F3D4004C;
	Mon, 16 Dec 2024 16:39:52 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B822F2843D3;
	Mon, 16 Dec 2024 16:39:22 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:22 +0100
Received: from localhost (10.252.30.129) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 16:39:22 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <alexandre.torgue@foss.st.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>, <olivier.moysan@foss.st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: add counter subnodes on stm32mp157c-ev1
Date: Mon, 16 Dec 2024 16:39:07 +0100
Message-ID: <20241216153908.3069548-5-fabrice.gasnier@foss.st.com>
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
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
index 9eb9a1bf4f2c..8f99c30f1af1 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
@@ -306,6 +306,9 @@ &timers2 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm2_pins_a>;
 		pinctrl-1 = <&pwm2_sleep_pins_a>;
@@ -321,6 +324,9 @@ &timers8 {
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "disabled";
+	counter {
+		status = "okay";
+	};
 	pwm {
 		pinctrl-0 = <&pwm8_pins_a>;
 		pinctrl-1 = <&pwm8_sleep_pins_a>;
@@ -336,6 +342,9 @@ &timers12 {
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


