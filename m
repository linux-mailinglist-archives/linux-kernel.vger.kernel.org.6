Return-Path: <linux-kernel+bounces-257227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06891937701
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AD61F220A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC084D0E;
	Fri, 19 Jul 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="moKWrtoP"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8641B86D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387433; cv=none; b=A3BcBS4AsKrpKS6wG9RT6q655q/buNRNtglYRSde4GjgJWKFnSrSvAAb+KyozbOLm8qSe0gWtwBLUQKMnR57y2l59zvx7ord4nG12NyQJzd0iQWyr83UsOWKp8xWVVE9okeYvlaLiR+OQJLukJaXKh3VKlAIOspPfnedfuP0hBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387433; c=relaxed/simple;
	bh=FLpC8utwEIJQLiEshcqIPSR5PVM/wZvPxXyaAC6uHsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=FeHJjTTEdopJXZYtHxIrKVb0yzMiMvFqJndJR9f6iBBhVeYxd07qFe+HbtOc2YZ98/xKAjLfbryp6WQlArsYWHpviptFyZ+ISrGtYU19AcpvNGPtjqevvWHgpTD4f9pRcWFFA3yCRc5dt4wYf8z1CRnU+kHX1vSUWAYuvQlFOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=moKWrtoP; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240719110234epoutp03d85840b2be49e4a2e8e0e58c32c30a7d~jmFCTkZQO2891428914epoutp03Y
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:02:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240719110234epoutp03d85840b2be49e4a2e8e0e58c32c30a7d~jmFCTkZQO2891428914epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721386954;
	bh=tcuRRKl9VdtIuqpxCnve4eFVQA4up3PEYahY4FJVRzI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=moKWrtoPH7Rxg8mbqoMZBa35TA6D5e0xzBFWbXvQj98N7sGTZu+/sleo5x4h+AwT2
	 SUl3KTnKah/NWdHIqrM4AeIgsSGgxF9wYQqWTcsvcx9sAvWsbsvihmOb2p6U0cZ+D7
	 tFo0FuEXlGENDOPpySnFAeT5W2Y4YWD1tVqygAAA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240719110234epcas5p38d1d74df6ad45f6e034449db901cd3ee~jmFB7KYtE0712207122epcas5p3a;
	Fri, 19 Jul 2024 11:02:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WQRbD5sMnz4x9Pr; Fri, 19 Jul
	2024 11:02:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.7C.09989.8C74A966; Fri, 19 Jul 2024 20:02:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2~jmEYmHhz02242422424epcas5p34;
	Fri, 19 Jul 2024 11:01:49 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240719110149epsmtrp25c08edf6ec93b393aa106dc5111b81b6~jmEYkGekN1989019890epsmtrp2i;
	Fri, 19 Jul 2024 11:01:49 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-0c-669a47c80f32
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.84.07412.D974A966; Fri, 19 Jul 2024 20:01:49 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240719110146epsmtip2d040cbc2bf24a38e8310d9f22193ebb0~jmEVwip5h0667406674epsmtip2J;
	Fri, 19 Jul 2024 11:01:46 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH] usb: dwc3: Potential fix of possible dwc3 interrupt storm
Date: Fri, 19 Jul 2024 16:30:55 +0530
Message-ID: <20240719110100.329-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmuu4J91lpBks/qlm8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	mHRQ1GLVggPsDnwe++euYffo27KK0WPL/s+MHp83yQWwRGXbZKQmpqQWKaTmJeenZOal2yp5
	B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvh3didzwVTJimvdJ1kbGH8IdTFy
	ckgImEhMm9DJ2sXIxSEksJtRYuaGxcwQzidGiQuzTjFCON8YJVpXnmKCaZnxsoMdIrGXUeLk
	3tVQzndGiYstq4BaODjYBAwlnp2wAWkQESiRuPR2IxNIDbNAB5NE57IHrCAJYQEviQ1LNrOD
	2CwCqhLr1n5kBLF5BawkJrdMZIHYpinxZ8VeFoi4oMTJmU/AbGYBeYnmrbPBbpUQ+Msu0d65
	gw2iwUVizo41UM3CEq+Ob2GHsKUkPr/bC1VTLbH6zkc2iOYWRonDT75BFdlLPD76iBnkA2ag
	zet36UOEZSWmnlrHBLGYT6L39xNoUPBK7JgHY6tKnGq8DDVfWuLekmusELaHxKQn21lARgoJ
	xEq0XtaYwCg/C8k7s5C8Mwth8QJG5lWMkqkFxbnpqcWmBUZ5qeXwmE3Oz93ECE6rWl47GB8+
	+KB3iJGJg/EQowQHs5IIr9+3mWlCvCmJlVWpRfnxRaU5qcWHGE2BYTyRWUo0OR+Y2PNK4g1N
	LA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamCStF3T1OShNuNrX3jLHZOn
	18Sfct35W+m6aevytetZX+oquH0652tyv9Us1ehGxGPlV/2mHHnpPK/MT05+z7uw69uSXxEr
	S6ZJ7Swxz40R5OZbpWHnwHG/W1ab2+WIoKMXF7P1lB8az83+lnO5J7k6LX4f+m5Jm0pbC8+0
	GvcPnTXBiyxfyWefqrHZvT688M3KtBcM198nOdXNnrBY/9jnJ+UPzZTzzetvHqg/3FPt6e83
	+dzvdt+VJSGVS3+7BNabz7mz4N324k19f2KZWudl9Jcl+YnP2CWQ7v7dK2zlopcWqkIpriGH
	rM8sm5TdWctYtlqwd5eCglVtvgGbuZ3WmYexUlNCuae1Ok/uUmIpzkg01GIuKk4EAPW+Kss0
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvO5c91lpBot2yFq8ubqK1eLOgmlM
	FqeWL2SyaF68ns1i0p6tLBZ3H/5gsbi8aw6bxaJlrcwWn47+Z7VY1TmHxeLI8o9MFpe/72S2
	mHRQ1GLVggPsDnwe++euYffo27KK0WPL/s+MHp83yQWwRHHZpKTmZJalFunbJXBl/Du7k7lg
	qmTFte6TrA2MP4S6GDk5JARMJGa87GDvYuTiEBLYzSjR/+0eO0RCWuL1rC5GCFtYYuW/51BF
	Xxklmjs72LoYOTjYBAwlnp2wAakREaiQeLxwBgtIDbPAFCaJBdMOsoAkhAW8JDYs2Qw2lEVA
	VWLd2o9gQ3kFrCQmt0xkgVigKfFnxV4WiLigxMmZT8BsZgF5ieats5knMPLNQpKahSS1gJFp
	FaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcIBraexgvDf/n94hRiYOxkOMEhzMSiK8
	ft9mpgnxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAFC9Q
	zCx86t6bo8/0X3syRjbKtCxaUFietyjm+ntei3P7zunXCqr+dVrm+YDBKfHDKs+vuhMe6whF
	ibxjNp7N8Pzlhc7tvjo7DVp0JYPsl8Ux1HJVZOvVaWdOdri94eTPnUqF0+6/f9Wzp/ii4fOb
	H1cGKlWVbhQt6+tR09Ff4/Bs5Vt2jf9dPQ/8P4WdnsEuNuNvkOdLMeXJrDsaOS48K/xvfPeU
	BceqZ4q/O11FvZT0n8zv/sDHuvGu0JqTU2YvN0210wlMPMMklL8zZM4t1c4+/iWV8SVNwVJb
	uOK2iMcte9ek/v344wr+85IfZ/3t33vm2aoib9tLGuceaIQskXsb8/72WYm5DM+uHF73Qoml
	OCPRUIu5qDgRAJBasAzfAgAA
X-CMS-MailID: 20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2
References: <CGME20240719110149epcas5p3dd468685a095c094ed2e540279bf3ec2@epcas5p3.samsung.com>

In certain scenarios, there is a chance that the CPU may not be
scheduled the bottom half of dwc3 interrupt. This is because the CPU
may hang up where any work queue lockup has happened for the same CPU
that is trying to schedule the dwc3 thread interrupt. In this scenario,
the USB can enter runtime suspend as the bus may idle for a longer time
, or user can reconnect the USB cable. Then, the dwc3 event interrupt
can be enabled when runtime resume is happening with regardless of the
previous event status. This can lead to a dwc3 IRQ storm due to the
return from the interrupt handler by checking only the evt->flags as
DWC3_EVENT_PENDING, where the same flag was set as DWC3_EVENT_PENDING
in previous work queue lockup.
Let's consider the following sequences in this scenario,

Call trace of dwc3 IRQ after workqueue lockup scenario
======================================================
IRQ #1:
->dwc3_interrupt()
  ->dwc3_check_event_buf()
        ->if (evt->flags & DWC3_EVENT_PENDING)
                     return IRQ_HANDLED;
        ->evt->flags |= DWC3_EVENT_PENDING;
        ->/* Disable interrupt by setting DWC3_GEVNTSIZ_INTMASK  in
                                                        DWC3_GEVNTSIZ
        ->return IRQ_WAKE_THREAD; // No workqueue scheduled for dwc3
                                     thread_fu due to workqueue lockup
                                     even after return IRQ_WAKE_THREAD
                                     from top-half.

Thread #2:
->dwc3_runtime_resume()
 ->dwc3_resume_common()
   ->dwc3_gadget_resume()
      ->dwc3_gadget_soft_connect()
        ->dwc3_event_buffers_setup()
           ->/*Enable interrupt by clearing  DWC3_GEVNTSIZ_INTMASK in
                                                        DWC3_GEVNTSIZ*/

Start IRQ Storming after enable dwc3 event in resume path
=========================================================
CPU0: IRQ
dwc3_interrupt()
 dwc3_check_event_buf()
        if (evt->flags & DWC3_EVENT_PENDING)
         return IRQ_HANDLED;

CPU0: IRQ
dwc3_interrupt()
 dwc3_check_event_buf()
        if (evt->flags & DWC3_EVENT_PENDING)
         return IRQ_HANDLED;
..
..

To fix this issue by avoiding enabling of the dwc3 event interrupt in
the runtime resume path if dwc3 event processing is in progress.

Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..610792a70805 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -549,8 +549,12 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 			lower_32_bits(evt->dma));
 	dwc3_writel(dwc->regs, DWC3_GEVNTADRHI(0),
 			upper_32_bits(evt->dma));
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
-			DWC3_GEVNTSIZ_SIZE(evt->length));
+
+	/* Skip enable dwc3 event interrupt if event is processing in middle */
+	if (!(evt->flags & DWC3_EVENT_PENDING))
+		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+				DWC3_GEVNTSIZ_SIZE(evt->length));
+
 	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), 0);
 
 	return 0;
-- 
2.17.1


