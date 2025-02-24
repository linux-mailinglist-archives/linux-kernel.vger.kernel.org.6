Return-Path: <linux-kernel+bounces-529695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5DA429F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF21889F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B46264A87;
	Mon, 24 Feb 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="w9s1lCrw"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D226280D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418436; cv=none; b=o5jS71i9MxQQ+Omyu8qLrdAPYImLbqta5ZX7dU/4XtbTb7rwrfv33+lDZ40Y1bhZQhdXCNDwK9jLCz+pogVuyw53syLr+zXzKLQFCx0DhXs9ltU26m8qHnNcPDHE9LOqG8pU2xZk2mVii+zQfxyndpjAtM/BF3CKG/XjTMYdl/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418436; c=relaxed/simple;
	bh=t+Z6EVqiQ5EVpV7MZa7bLNejvZB/MmW5APEZS/vyamA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lASuX4zb9h+j0zYdwRRYlzfdW7opb8kpIFhD0xmA/IANgl275sLhZnq8Sag2PiRCMjrR7mgnMMBumJz4e+u3cEltJTUGCGnerzjN85GuOQS1A3g+RPypAt0z6Y1vvbwnkEVKltUVm8SMyiYszWQMfF55HBoiSzgbxOJ43WqAwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=w9s1lCrw; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OE6a8p019227;
	Mon, 24 Feb 2025 18:33:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=aM49dtU5bK9q5PUsk/o5Ph
	DwC7TRmbnftSFkh2mjTtw=; b=w9s1lCrwhPCUAMJgO3nO5qZZm0Yc5TstgWsUI+
	9UH+dVEKjCQV+rYFE6B/aiyj1HqHldtVYdQAtNI9UFm5pwSmDbwMPa3b9uvurhaN
	baU4pF0yCv9IC6dwug+RHYBl7eUbSlRxW4UbARHD9hgulHY0MmrANR/WZP23Um/p
	S/HtGavs4JCyQ+PgV8w9nOiLN52EXRu4Eo9XO83AuSXLDZX6QHYShwu8hP3j/HcF
	XIIlenVUTcWGwAY16ZjnSDyOsny8pgMW+nhst9zL3YLzAwAhEBbLLP+Krttpr2jI
	YKRup0tVixvo+F2dX6WbGMIEsZsBIsUg8r0fOk26aMLKYXLw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44ytdn64g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 18:33:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 52B4140059;
	Mon, 24 Feb 2025 18:32:19 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7B204F3E81;
	Mon, 24 Feb 2025 18:21:25 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 18:21:25 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 18:21:25 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] clocksource: stm32-lptimer: add support for PM
Date: Mon, 24 Feb 2025 18:21:01 +0100
Message-ID: <20250224172101.3448398-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01

Add support for power management on STM32 LPTIMER clocksource driver:
- Upon clockevents_suspend(), shutdown the LPTIMER, and balance the
clk_prepare_enable() from the probe routine.
- Upon clockevents_resume(), restore the prescaler that may have been lost
during low power mode, and restore the clock.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/clocksource/timer-stm32-lp.c | 32 +++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c95161cb22..9cd487dd5a3a 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -24,7 +24,9 @@ struct stm32_lp_private {
 	struct regmap *reg;
 	struct clock_event_device clkevt;
 	unsigned long period;
+	u32 psc;
 	struct device *dev;
+	struct clk *clk;
 };
 
 static struct stm32_lp_private*
@@ -120,6 +122,27 @@ static void stm32_clkevent_lp_set_prescaler(struct stm32_lp_private *priv,
 	/* Adjust rate and period given the prescaler value */
 	*rate = DIV_ROUND_CLOSEST(*rate, (1 << i));
 	priv->period = DIV_ROUND_UP(*rate, HZ);
+	priv->psc = i;
+}
+
+static void stm32_clkevent_lp_suspend(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv = to_priv(clkevt);
+
+	stm32_clkevent_lp_shutdown(clkevt);
+
+	/* balance clk_prepare_enable() from the probe */
+	clk_disable_unprepare(priv->clk);
+}
+
+static void stm32_clkevent_lp_resume(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv = to_priv(clkevt);
+
+	clk_prepare_enable(priv->clk);
+
+	/* restore prescaler */
+	regmap_write(priv->reg, STM32_LPTIM_CFGR, priv->psc << CFGR_PSC_OFFSET);
 }
 
 static void stm32_clkevent_lp_init(struct stm32_lp_private *priv,
@@ -134,6 +157,8 @@ static void stm32_clkevent_lp_init(struct stm32_lp_private *priv,
 	priv->clkevt.set_state_oneshot = stm32_clkevent_lp_set_oneshot;
 	priv->clkevt.set_next_event = stm32_clkevent_lp_set_next_event;
 	priv->clkevt.rating = STM32_LP_RATING;
+	priv->clkevt.suspend = stm32_clkevent_lp_suspend;
+	priv->clkevt.resume = stm32_clkevent_lp_resume;
 
 	clockevents_config_and_register(&priv->clkevt, rate, 0x1,
 					STM32_LPTIM_MAX_ARR);
@@ -151,11 +176,12 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->reg = ddata->regmap;
-	ret = clk_prepare_enable(ddata->clk);
+	priv->clk = ddata->clk;
+	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return -EINVAL;
 
-	rate = clk_get_rate(ddata->clk);
+	rate = clk_get_rate(priv->clk);
 	if (!rate) {
 		ret = -EINVAL;
 		goto out_clk_disable;
@@ -191,7 +217,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk_disable:
-	clk_disable_unprepare(ddata->clk);
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
-- 
2.25.1


