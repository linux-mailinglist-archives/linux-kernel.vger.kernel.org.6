Return-Path: <linux-kernel+bounces-331193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC6397A97C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A72288223
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E8015DBC1;
	Mon, 16 Sep 2024 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nCtPDNUE"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DFF9FE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726528735; cv=none; b=nPLbNjBqSbl83aKbjarFH7Vi71tRwMnVMx8HjXpDztgcT09DBZSKUOmPIuek4a6LUkUEIrl+y9ecxdOjhYYgUMb06DtiPDBJSpeDKmdOQzlDACd/WEKU6zK/fnbrtV60Gv6yrxiTxNef6La1IgKKIiEArduAGdrB4lJg0qKp+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726528735; c=relaxed/simple;
	bh=EAkrRyWWsaw41+qQU6LsGs7V24atXDdHn8IEAT8POzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=rDfRxB+Jm5OQsHclt7aVWCmY9O0rxAa806195xiiAUa9c/K9ddqj7Akmm84WHR2/pCXOw3DE4TXsy4wZdA2EyNAYfe91bUqhxOAynFF9ymNONNF+eAeFORSdNH9JtLm1h1+Tbv5TI2cRIx+fNhctim846mdAZ2S+6gprxwcXAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nCtPDNUE; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240916231850epoutp02438eca34a40b2d50f06ddc393d91b4a6~13LumHdml1190811908epoutp02U
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240916231850epoutp02438eca34a40b2d50f06ddc393d91b4a6~13LumHdml1190811908epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726528730;
	bh=lv9/Fnu2SiRPUvL+6bb2Mpc54pmLuygGOmtM2PEJFDU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nCtPDNUElFfNXuBgRWZEkGWub7P4P+5xbJH9IgTXdVv7NbDIHBbb+RBFQ6f7M+v8t
	 3VuswfuOWXX0PXVeEVRntPUDhkFH4hQ03egn5aV4CAGCmhfTC4U8X1v7ZpDjypV4LI
	 srKnpRnAoJpEUDLoff7ZT7ysYdKVrr1kc5OnikFE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240916231849epcas5p23d52ba51068846f2819eeb3a70f8522d~13LthWVPe2901729017epcas5p2C;
	Mon, 16 Sep 2024 23:18:49 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X717W65kXz4x9Pp; Mon, 16 Sep
	2024 23:18:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.C6.19863.7DCB8E66; Tue, 17 Sep 2024 08:18:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916231847epcas5p19dc48e3baeea70619dc766ba86938fee~13LrddUa_2203822038epcas5p1M;
	Mon, 16 Sep 2024 23:18:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240916231847epsmtrp2b29813f45bc78aa2f2a91699039eb517~13LrctLtk1941019410epsmtrp2C;
	Mon, 16 Sep 2024 23:18:47 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-11-66e8bcd7cff5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.F2.19367.7DCB8E66; Tue, 17 Sep 2024 08:18:47 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916231844epsmtip24ba2cf6c9c51f43d91dc64c0e231dd0f~13LpR9fJX1066810668epsmtip2s;
	Mon, 16 Sep 2024 23:18:44 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable@kernel.org
Subject: [PATCH v3] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Date: Tue, 17 Sep 2024 04:48:09 +0530
Message-ID: <20240916231813.206-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmpu71PS/SDE4tMbB4c3UVq8WdBdOY
	LE4tX8hkMf9mkkXz4vVsFpP2bGWxuPvwB4vF5V1z2CwWLWtltvh09D+rxarOOSwWR5Z/ZLK4
	/H0nUOz8BaDig6IWqxYcYHcQ8Ni0qpPNY97JQI/9c9ewe/RtWcXosWX/Z0aPz5vkAtiism0y
	UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5WUihLzCkF
	CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnN30
	i71gu3JF/9pdzA2Mf2S7GDk4JARMJF5OtOhi5OIQEtjDKLHu2EvGLkZOIOcTo8TReckQCSC7
	b+V8VpAESMPtpu3sEImdjBJNBx9BOd8ZJZ5tvs8GMpZNwFDi2QkbkAYRgSmMEt/m1oHUMAvM
	ZpKYt+0tE0hCWCBBounhO3YQm0VAVeLZrZlgNq+AlcShju1sENs0Jdbu3cMEEReUODnzCQuI
	zSwgL9G8dTYzyFAJgYkcEu/fHoY6z0Vi4r+V7BC2sMSr41ugbCmJz+/2Qg2tllh95yMbRHML
	o8ThJ9+giuwlHh99xAzyATPQ5vW79CGW8Un0/n7CBAkvXomONiGIalWJU42XoUZKS9xbcg3q
	BA+J7Z2vocEYK3F09hvGCYxys5C8MAvJC7MQli1gZF7FKJVaUJybnppsWmCom5daDo/M5Pzc
	TYzgBKsVsINx9Ya/eocYmTgYDzFKcDArifDa/n6aJsSbklhZlVqUH19UmpNafIjRFBiwE5ml
	RJPzgSk+ryTe0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJnEu/xPH
	bm7tzVSybuVwn1+1IFI0V0AopvV4xYMa4+DC2+tt9/2pEZ+5YdLyxC9Z51SCzzt3e6qwseQI
	nXuwRSozfInZ/dKULFdX/ksnDR81fT1+tYPXbd+LuQc8F18Uv5vO5lfnusrzZvyDgmvG9qk+
	Uh9zN9QE3GfKiHcLY3/P7OF9eF9hQ+OaBcYHXEsFuhc+jRcRjmq4JeS24njJqXxjTr+lNtPv
	FN5bwDG9q/uGU3Sm6aflUsrnfnqt52+pvRGuWLbC9WX0d5Zq3ytybQkJ3LIzmLtuvE8VrFty
	heXZsUk9jktrDDQjHiWsN6ypSjhw83S7FLP7Fgm3+gVqj8zvi+Q7J3xNfStfxanEUpyRaKjF
	XFScCAAtepIkOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO71PS/SDLpncFu8ubqK1eLOgmlM
	FqeWL2SymH8zyaJ58Xo2i0l7trJY3H34g8Xi8q45bBaLlrUyW3w6+p/VYlXnHBaLI8s/Mllc
	/r4TKHb+AlDxQVGLVQsOsDsIeGxa1cnmMe9koMf+uWvYPfq2rGL02LL/M6PH501yAWxRXDYp
	qTmZZalF+nYJXBlnN/1iL9iuXNG/dhdzA+Mf2S5GTg4JAROJ203b2bsYuTiEBLYzSrxdMoUV
	IiEt8XpWFyOELSyx8t9zqKKvjBK3Xk5g6WLk4GATMJR4dsIGJC4iMINR4smna6wgDrPASiaJ
	P1dmgXULC8RJ7L48lQnEZhFQlXh2ayY7iM0rYCVxqGM7G8QGTYm1e/cwQcQFJU7OfMICYjML
	yEs0b53NPIGRbxaS1CwkqQWMTKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgsNfK2gH47L1
	f/UOMTJxMB5ilOBgVhLhtf39NE2INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2
	ampBahFMlomDU6qBya758Ylb+iWhSybHJN/8fUUgkFf19v3AM0ZJRwVf9fy5whkSXmhytPfR
	PCbbRYG7eHhXbHTQV1uqcfbrs/uHc2+9UV7DxzZX+xaDnPQcecf4hcaeeR2vhDOtuPt3NEwQ
	6ihsFmpzU9E7cTjM52LMg7Xrnx19+HiRl1H8mVUMMiXxjzTywywFv6tMUlvcrmPYzqMQIzRp
	/+yFGWrXT8VrHC0Ia36VO++8daP0owBmkfgpfCY5/utec/7eWLx6QsPv35cPmP02ZLDtnZKe
	81pow4n/PSX8pQp8tm4SRvtepkoZ8zR4T1ta73P3YsnShPWzLzudnMaiP117gsaqx9Zrl02a
	H+N4//n39SqqizfWK7EUZyQaajEXFScCAD1+1tHuAgAA
X-CMS-MailID: 20240916231847epcas5p19dc48e3baeea70619dc766ba86938fee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240916231847epcas5p19dc48e3baeea70619dc766ba86938fee
References: <CGME20240916231847epcas5p19dc48e3baeea70619dc766ba86938fee@epcas5p1.samsung.com>

This commit addresses an issue where events were being processed when
the controller was in a halted state. To fix this issue by stop
processing the events as the event count was considered stale or
invalid when the controller was halted.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Cc: stable@kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---

Changes in v3:
- Updated Cc tag and a typo mistake.
- Link to v2: https://lore.kernel.org/lkml/20240916224543.187-1-selvarasu.g@samsung.com/
---

Changes in v2:
- Updated the code changes that suggested by reviewer (Thinh Nguyen).
- Link to v1: https://lore.kernel.org/lkml/20240719110100.329-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/core.c   | 22 +++++++++++++++++++---
 drivers/usb/dwc3/core.h   |  4 ----
 drivers/usb/dwc3/gadget.c | 11 -----------
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9eb085f359ce..152376977a8e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -544,6 +544,7 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return 0;
@@ -556,8 +557,10 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 			upper_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 			DWC3_GEVNTSIZ_SIZE(evt->length));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 	return 0;
 }
 
@@ -584,7 +587,10 @@ void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0), 0);
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), DWC3_GEVNTSIZ_INTMASK
 			| DWC3_GEVNTSIZ_SIZE(0));
-	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
+
+	/* Clear any stale event */
+	reg = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
+	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), reg);
 }
 
 static void dwc3_core_num_eps(struct dwc3 *dwc)
@@ -2499,7 +2505,11 @@ static int dwc3_runtime_resume(struct device *dev)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_process_pending_events(dwc);
+		if (dwc->pending_events) {
+			pm_runtime_put(dwc->dev);
+			dwc->pending_events = false;
+			enable_irq(dwc->irq_gadget);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 	default:
@@ -2589,6 +2599,12 @@ static void dwc3_complete(struct device *dev)
 static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	.complete = dwc3_complete,
+
+	/*
+	 * Runtime suspend halts the controller on disconnection. It relies on
+	 * platforms with custom connection notification to start the controller
+	 * again.
+	 */
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
 };
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c71240e8f7c7..9c508e0c5cdf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1675,7 +1675,6 @@ static inline void dwc3_otg_host_init(struct dwc3 *dwc)
 #if !IS_ENABLED(CONFIG_USB_DWC3_HOST)
 int dwc3_gadget_suspend(struct dwc3 *dwc);
 int dwc3_gadget_resume(struct dwc3 *dwc);
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
@@ -1687,9 +1686,6 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 	return 0;
 }
 
-static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-}
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
 #if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..10178e5eda5a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4728,14 +4728,3 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 
 	return dwc3_gadget_soft_connect(dwc);
 }
-
-void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
-{
-	if (dwc->pending_events) {
-		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
-		pm_runtime_put(dwc->dev);
-		dwc->pending_events = false;
-		enable_irq(dwc->irq_gadget);
-	}
-}
-- 
2.17.1


