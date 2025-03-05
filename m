Return-Path: <linux-kernel+bounces-546820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CDDA4FF10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C142188EF9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B32459EF;
	Wed,  5 Mar 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WQo9AnKQ"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53102245026
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179317; cv=none; b=sYySO6WG9lEzMsqNkzIqXAXb/ZsVLwDj/tnp8XFW5pG4Q7Hpo7WTv5m0P65OZVpmP1hthYARY1kWfjB+3MS/j8juOTj4QczJ5YxmRPHBDELwYnzNcrNt5SnlUUaCLEK2KpVArewiK6US17GKPzhvgX2UpQdJEJjv6TKUFwq3uFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179317; c=relaxed/simple;
	bh=FhmEtBNfXCKfrPlAMNmbhrTQhUubUXrGt+RSXE0mKuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIKFFXFOpmF34jS0O6VlXtGSnfB0qU5fzMnbUyWm6OVAStmQt5r7G8zRxnwdx1rKmB6FYullMohhpWe9hysPdO1W3KJwafFDvFZBnBOyEzzVhbUAGe32ez3hyECKEPPu15loLY4lf2eYHjqAb1qYxk67/4IwIcOrx2OYyJhb/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WQo9AnKQ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Bpj1m010815;
	Wed, 5 Mar 2025 13:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=5qR5OAEjVcqhFEhB6Kg5+d
	lLt98AeFnFdzL54hTZvlw=; b=WQo9AnKQGjuAo9tnbOQrifVGQxt8Il91K/8yw7
	tppqFNxXzUh8OPYin9zOOSvxipmff/mcqf/7dOmONtyVZ/MeFWZvRytc2h94PhdJ
	/e4UBd+nFC6wkuDxQTkvfJoTiL8McfITWWLFruYSo5TY/2kBDHNGimhls4JpAKLS
	8dEkiec5FReXI4EgDyDXD8Y7uw8x4PMS0K3XaLP4zjxosmVH9OtFxAyWN9N8xjOk
	7VkbVGM0GdUuPQCEntvpm+gYtMRv/rPnpny4sjMF44GcxffC1vx9lonCLD5po6K6
	xUNrI9jdYcwRbDapKgnO/AhsSDqTngeL3FB8eqcr/kVkE1Hg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 455wbhuk9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 13:55:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9C2674008B;
	Wed,  5 Mar 2025 13:54:05 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C38B62D58A;
	Wed,  5 Mar 2025 13:51:54 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 13:51:54 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 13:51:53 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <alexandre.torgue@foss.st.com>, <olivier.moysan@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] clocksource: stm32-lptimer: use wakeup capable instead of init wakeup
Date: Wed, 5 Mar 2025 13:51:46 +0100
Message-ID: <20250305125146.1858978-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_05,2025-03-05_01,2024-11-22_01

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

"wakeup-source" property describes a device which has wakeup capability
but should not force this device as a wakeup source.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/clocksource/timer-stm32-lp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index 96d975adf7a4..f08baa6720f8 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -186,9 +186,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
-		ret = device_init_wakeup(&pdev->dev, true);
-		if (ret)
-			goto out_clk_disable;
+		device_set_wakeup_capable(&pdev->dev, true);
 
 		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
 		if (ret)
-- 
2.25.1


