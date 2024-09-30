Return-Path: <linux-kernel+bounces-344519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93D98AAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4111F21C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6BD194C9E;
	Mon, 30 Sep 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="T7YwdDKt"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6234A18C01E;
	Mon, 30 Sep 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716305; cv=none; b=js4VdZfNXs6/A16SVR9cuBqiSOIC/aVoGA6kTnD+MFA+8/AXs6y8PfX9z0VLzVc16KMwUrfBpJ9jfHjNCfla/LoJkMqXuPwov02deG9lGxUmHdFxk6FWAIvw48Uz1aURExvIN/BNrcdHldX4VQLFrm8UTKVXIB7UauyCOmhxmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716305; c=relaxed/simple;
	bh=t0BLmAmsmkqp0Spb8JIL1V8Va8Wj/LUFfSt6VGjC3zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaZr/RnDoz3fYKGSQjlUBdL85TYb+IVWzWj035pLlu+X3YevecR1WvMvbGd44PvIr2vaofJ8URJ6Ey3NIaAH8Nfqai9Ev337qLPzUFGj1noh7iBu14h3wv2Lt+YoXpsqgSJo5fLfpc6uH8b0+HOdiz042PgrdlwZeTsrw2nlDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=T7YwdDKt; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEtVZF018684;
	Mon, 30 Sep 2024 19:11:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HC41gKbNTPTheLxQatK65Adbh2JRdRstc3B3EX+giRg=; b=T7YwdDKtGj/WR0sY
	lv3yo54pRpH61OD2DclPpA5+RcIsittINLI2Fce6bz6Rm6u04l83uD04VAAC2+Nb
	0Bo+AZVOlJ8PnY5w+3GkcurMb9h7fx10EIN9Psz9ZFdxdCtlvOu+1/eyqDszJJX8
	4wijO0lpdlF3tt1638gS8eXNXrsfR38DrJrzXqr6jcfYtBVbXC76zIjtcqnfZlOh
	S4bCKNktBZn3ObIrvdxZj9NcRMKP9/rIkqo9yN/rpElhb6iObACuAwOyohitV60G
	VXxco0QJNJdjAmqpdl2WBI/mvIBVIVwTCwYC1hxUGIkaG0rE3XVt/vZ649kzX75H
	9fg6vA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41x77gj3xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:11:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6C6D84005F;
	Mon, 30 Sep 2024 19:09:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AEB32A5D7F;
	Mon, 30 Sep 2024 19:09:07 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 30 Sep
 2024 19:09:06 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v9 3/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
Date: Mon, 30 Sep 2024 19:08:45 +0200
Message-ID: <20240930170847.948779-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930170847.948779-1-christian.bruel@foss.st.com>
References: <20240930170847.948779-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add myself as STM32MP25 COMBOPHY maintainer

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a70b7c9c3533..73fd76dab699 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21908,6 +21908,12 @@ F:	drivers/*/stm32-*timer*
 F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 
+STM32MP25 USB3/PCIE COMBOPHY DRIVER
+M:	Christian Bruel <christian.bruel@foss.st.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
+F:	drivers/phy/st/phy-stm32-combophy.c
+
 STMMAC ETHERNET DRIVER
 M:	Alexandre Torgue <alexandre.torgue@foss.st.com>
 M:	Jose Abreu <joabreu@synopsys.com>
-- 
2.34.1


