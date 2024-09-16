Return-Path: <linux-kernel+bounces-331162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0597A94B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FF728BBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937114A09C;
	Mon, 16 Sep 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vMDmavKT"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06621B85C1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526799; cv=none; b=hNR1zZCAsFYXVzPpJhdgnGh78eWG1hewLZXCyQYp0SdlwLBrGWHmaZD3EfNc6z9up173Yd624LW8XllMmuS+w8Pp7X59xQ1E4QMIgUBHN2FxUu9DZ9uStn+c8F/6qaUla8HaysTB0LJYvI630MdJTzEuY2MglgqTggv9LubHwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526799; c=relaxed/simple;
	bh=1Dc9bAz+Oh205dCftd8HURcb7c11L4LkHWoHGfvdaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=rc+RIIyXUVuPbaEaqO2CFSxqCYkCqyUdSoG1CWSD7l7tv86bLH6RoExcoYe73DWnjBcngdvm8h2idIbmkQAb9LrPms2aLCCmpzh9WvYJaCumIL6fRilEasBLMBHHYVC30GOwstcdpDL/nF9sgBDbWjjDTjJCKVJynOJN4Ln268k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vMDmavKT; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240916224633epoutp0117f74bf37c2b385ba3a80917b4812d7d~12viwSPB-3260932609epoutp01z
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:46:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240916224633epoutp0117f74bf37c2b385ba3a80917b4812d7d~12viwSPB-3260932609epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726526793;
	bh=ElSQ03JvnpcpNQ+d5oM7jM1soYKwWyMeyIq4z3n4+ac=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vMDmavKTyrHeKqxPP2f8Mr2J7OBaicanuEHyHIJnTB8WCnsRpdbwWYlAjWPwpk0+p
	 m8DPu13wWbd3/gjwHuD0gByN89KbOZW/PIRLvJkXtdcMJ9CMPlxqLNfXEyxtCcs465
	 T4KhLe2Mt0Gb82I+f8IAnQDj3CwNcInG0eHns8hA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240916224632epcas5p2ef48a285aafd57235560fb1bca2ad6d8~12vhy6wC70627906279epcas5p2J;
	Mon, 16 Sep 2024 22:46:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X70QH18XQz4x9Pq; Mon, 16 Sep
	2024 22:46:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.D8.09743.645B8E66; Tue, 17 Sep 2024 07:46:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e~12vfwdV4q2782427824epcas5p4N;
	Mon, 16 Sep 2024 22:46:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916224630epsmtrp17866936d088f2d0515b31a8a4cd9b362~12vfvqcHk2935029350epsmtrp1S;
	Mon, 16 Sep 2024 22:46:30 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-c4-66e8b54601b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.E1.19367.645B8E66; Tue, 17 Sep 2024 07:46:30 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916224628epsmtip2ce6e0eef8f436c1456633b83139613d4~12vdiNS2Y2234122341epsmtip2P;
	Mon, 16 Sep 2024 22:46:28 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable <stable@kernel.org>
Subject: [PATCH v2] usb: dwc3: core: Stop processing of pending events if
 controller is halted
Date: Tue, 17 Sep 2024 04:15:41 +0530
Message-ID: <20240916224543.187-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmuq771hdpBotWMVm8ubqK1eLOgmlM
	FqeWL2SymH8zyaJ58Xo2i0l7trJY3H34g8Xi8q45bBaLlrUyW3w6+p/VYlXnHBaLI8s/Mllc
	/r4TKHb+AlDxQVGLVQsOsDsIeGxa1cnmMe9koMf+uWvYPfq2rGL02LL/M6PH501yAWxR2TYZ
	qYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFcrKZQl5pQC
	hQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzDjxZ
	z1TwTbFi9p1PrA2M12S6GDk5JARMJBpPN7F0MXJxCAnsZpTYPvU9M4TziVHi8pcOFjjn8IsT
	TDAtz+b/garayShxffJhqKrvjBI7nhxn7GLk4GATMJR4dsIGpEFEYAqjxLe5dSA1zAJLmCQ2
	b17PBlIjLJAgsWyzOUgNi4CqxP9rC1hAbF4BK4n2qW+ZIZZpSqzdu4cJIi4ocXLmE7AaZgF5
	ieats8GOkBCYyCHxfck5RogGF4npi++wQtjCEq+Ob2GHsKUkXva3QdnVEqvvfGSDaG4Beu3J
	N6iEvcTjo4+YQY5jBtq8fpc+xDI+id7fT5hAwhICvBIdbUIQ1aoSpxovs0HY0hL3llyDWush
	MenobbCJQgKxEk8vnGOfwCg3C8kLs5C8MAth2QJG5lWMkqkFxbnpqcWmBUZ5qeXwyEzOz93E
	CE6wWl47GB8++KB3iJGJg/EQowQHs5IIr+3vp2lCvCmJlVWpRfnxRaU5qcWHGE2B4TqRWUo0
	OR+Y4vNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamCaqtw+48ac
	xLTgKP8z7nu7jR3jdp54fnEpl0/tlWjbrRbmTOt3Lf7KknDl3qwPAqKvjPP2uIlWhwXnnjxz
	5JNqyxM15pKXifrSExr4Fj1+/SuyuX1hiaNqTUeOxOHEu/53z5/VVDlxYGuFR4J98pUb2oFr
	fSd+zhTn3vqcY4ejD6eu+Jk3l7dcmCs7T9PJt3j+WoNPG17EVLDNCJLJuGmXaiP/1/mItJpc
	nsW+7VVPNZoElDQOh0i8K9u/x//Q+YjLfDliykaCXEcfCrkEZ/XFl3NpHrjoVrFmW3LnRW5V
	roYEr3MCPMtmfJorGqV9wj+t4dSinOtSbkbfp7W+nfEj0F4u6XDP0eSohY9ncSixFGckGmox
	FxUnAgAyw8nLOQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvK7b1hdpBh+myVi8ubqK1eLOgmlM
	FqeWL2SymH8zyaJ58Xo2i0l7trJY3H34g8Xi8q45bBaLlrUyW3w6+p/VYlXnHBaLI8s/Mllc
	/r4TKHb+AlDxQVGLVQsOsDsIeGxa1cnmMe9koMf+uWvYPfq2rGL02LL/M6PH501yAWxRXDYp
	qTmZZalF+nYJXBkHnqxnKvimWDH7zifWBsZrMl2MnBwSAiYSz+b/Ye5i5OIQEtjOKNFw9Ckj
	REJa4vWsLihbWGLlv+fsEEVfGSV6n3eydjFycLAJGEo8O2EDEhcRmMEo8eTTNVYQh1lgE5NE
	+8LvYN3CAnES56+0sYPYLAKqEv+vLWABsXkFrCTap75lhtigKbF27x4miLigxMmZT8BqmAXk
	JZq3zmaewMg3C0lqFpLUAkamVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjB4a8VtINx2fq/
	eocYmTgYDzFKcDArifDa/n6aJsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1
	tSC1CCbLxMEp1cBkHrptuduUawfMV2UVX169wfSS38dF305we50SexhnPjuvz2MGy32b/ZMz
	PoV2nBT0VF+ksZmXsf957AvmNfPqtrPscbX9edzr4nIPW3kmg47tmpqmon8VPBe761v+3L0p
	4rdkgE+yrFBG9TK92xEPz6y7sMNhrlzA7X1za+YezZB9c1n0e+K2o9fXx2qmefZ15iUq2vor
	GrRMXezZxNETYSc4x0VlgsesCy/dV5p82Bh2Q2TqrpcWxadKUqQ4eOt/SWXz7N2/vEI+uTWr
	enLv1JX8NoIxDQ0ef7+6SKQuC0mbcTQ+Wz2DN3CXn1KjT6p6nkxo+N1LdbOOz52ot7vnWP7P
	91YJT7eqth3e8VWJpTgj0VCLuag4EQAD4AvO7gIAAA==
X-CMS-MailID: 20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e
References: <CGME20240916224630epcas5p42b355e2884c665e19d3c9c3a5afd428e@epcas5p4.samsung.com>

This commit addresses an issue where events were being processed when
the controller was in a halted state. To fix this issue by stop
processing the events as the event count was considered stale or
invalid when the controller was halted.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Cc: stable <stable@kernel.org>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
index 9eb085f359ce..65ae5203b89e 100644
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
+	 * Runtime suspend halts the controller on disconnection. It replies on
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


