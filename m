Return-Path: <linux-kernel+bounces-189941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A18CF777
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A42811B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02460322E;
	Mon, 27 May 2024 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GfRrmPMK"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1051C3D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778183; cv=none; b=p5nEdAUOzRYhqVdmseRnimGXj52Y5lBK8soAoWBS8PeJR4czr2beFWQpL/7cGKn8ezz4N2xMdxVhrpOVRcsIKLs5YswVCoTRO23DKJG/aYZM5lX/D300dnDt1B1oncm/Nl8msbf5d/2l+3ryTsjg4dmhpgw17SG+GBBN7UDGbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778183; c=relaxed/simple;
	bh=3kjP/eYu8FBEzXftqyBHQNGHdQIdlOFsZ6Q2SN6VhDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=F1LA23YBmTtAxtZ8QUKnA+m/NBUy+6Ho+THt7sGEE95th9Et5cGdt1ph725wsFrZzm8lRoVgvlWmI7o3Vka4hozVOW6SDwxuNrrXqRL80E9QcWsb9tVcHxkzhSLRhCsWVeyg/E1OUj1+HRdhxgWXUDO6Kn3dMzLbdJogf/tElh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GfRrmPMK; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240527024932epoutp01315fff021475cecc792d89a16e011743~TOKbjNibY2131521315epoutp01D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:49:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240527024932epoutp01315fff021475cecc792d89a16e011743~TOKbjNibY2131521315epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716778172;
	bh=cOXMqPjzMxZ5k8DVsf9q39y57OHbfbcQvYfgBq4kAdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GfRrmPMKcnWJa9Od2cEKIxofzOh6Ni93s0ZIWylfZf3mPvNGgdxz46FQsPKg32973
	 s8pbMyKU9UrvainEScqJyo8OpnhbMWID02E8YVjfQDAWnYjsW/EVzHX5IX6Lk5706K
	 c/STJjGTh/UyYTPp/WU/XYt5QM6hAO6hN6/13u+w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240527024931epcas2p275e4d8cb1390373652295e2d4d16a3f7~TOKbJG-Y52801728017epcas2p25;
	Mon, 27 May 2024 02:49:31 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vng8q2yDWz4x9Pw; Mon, 27 May
	2024 02:49:31 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.E3.09806.BB4F3566; Mon, 27 May 2024 11:49:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240527024930epcas2p47dee026c9b332c841d7463f6a1d572c0~TOKZ0zf2H1277312773epcas2p4O;
	Mon, 27 May 2024 02:49:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527024930epsmtrp28f50a74ffe63331bb03eb46866aa86b5~TOKZz2DAg1035210352epsmtrp2x;
	Mon, 27 May 2024 02:49:30 +0000 (GMT)
X-AuditID: b6c32a47-ecbfa7000000264e-63-6653f4bbdcd8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.BE.18846.AB4F3566; Mon, 27 May 2024 11:49:30 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240527024930epsmtip28b0ee080ab33cc639ae1a05bb0959ddb~TOKZpk-k42469024690epsmtip2a;
	Mon, 27 May 2024 02:49:30 +0000 (GMT)
Date: Mon, 27 May 2024 11:49:50 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Thinh
	Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [RFC] usb: host: xhci-mem: Write high first on erst base of
 secondary interrupter
Message-ID: <20240527024950.GA146722@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b936df07-47cc-9921-0550-469fbbb6b49f@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmqe7uL8FpBgs7RC2aF69ns7i8aw6b
	xaJlrcwWzZumsFq8/tDEYrFqwQF2BzaPxXteMnnMOxnosX/uGnaPLfs/M3p83iQXwBqVbZOR
	mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
	KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj9YIz
	jAV3ZSua1xxnbGA8I9HFyMkhIWAicWXBXCYQW0hgB6PEraaULkYuIPsTo8TrhuXMcM6Z28uY
	YTo+ND2DSuxklNi99T2U84RR4uHmZnaQKhYBVYl7276ygNhsAloS936cAOsWETCU+HZpOyNI
	A7PAe0aJZ89XsIEkhAUSJLbd3ssKYvMK6Egc+rGHHcIWlDg58wnQIA4OTgFnieenLEBMUQEV
	iVcH60HGSAh8ZJe42Azxg4SAi8SzqWdYIGxhiVfHt7BD2FISn9/tZYOwiyVuPYf4QEKghVFi
	xasWqNeMJWY9a2cEsZkF0iV+7+hiBlkmIaAsceQWC0SYT6Lj8F92iDCvREebEESnssT0yxNY
	IWxJiYOvz0FN9JDoaJnPCAmftUwSXWs2MU1glJ+F5LNZSLZB2DoSC3Z/YpsFtIJZQFpi+T8O
	CFNTYv0u/QWMrKsYxVILinPTU4uNCozhkZ2cn7uJEZw2tdx3MM54+0HvECMTB+MhRgkOZiUR
	XpF5gWlCvCmJlVWpRfnxRaU5qcWHGE2B8TSRWUo0OR+YuPNK4g1NLA1MzMwMzY1MDcyVxHnv
	tc5NERJITyxJzU5NLUgtgulj4uCUamCaJVV0zfpbwqoStsmH7y99wvWJY71Uy5ONQhtO1L67
	ztkQO9/i8t8pp80+XbH70DBvyV+nW60ZE1guc7Es/9Uz4fB39dXvOBz3rbOvuD9j1RZfq/7Z
	fO0FE/LYexWFSvn26b/ZwBGY9mLfXt6bqydFX5l2Yf3U2MOzf9VEsS0pnVzEUP7R2/2spdHP
	Wafdpr0P4mSUvFWyp5TpQPnxYzN4tR3XuMrMZrmcumjB7LQkQ4bpZ5gdHjNOcVnrLM3hXK5z
	bkKno6Zynt3Exx/y3uWY7e+InjIt1lh795el5SunuERsjwx+6jFN7QLvYrMpu28f37vv2aFF
	G4+w8SlLvZXYfVgr/IWgg3lzvsve9L7Tx5VYijMSDbWYi4oTAce8g0wkBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO6uL8FpBieOSlk0L17PZnF51xw2
	i0XLWpktmjdNYbV4/aGJxWLVggPsDmwei/e8ZPKYdzLQY//cNeweW/Z/ZvT4vEkugDWKyyYl
	NSezLLVI3y6BK+PJ7QVMBQukK7ZOmMHcwLhCrIuRk0NCwETiQ9Mz5i5GLg4hge2MEo9vXGGE
	SEhKLJ17gx3CFpa433KEFaLoEaPE/kPzWUASLAKqEve2fQWz2QS0JO79OMEMYosIGEp8u7Sd
	EaSBWeAjo8S9tgmsIAlhgQSJbbf3gtm8AjoSh37sYYeYupZJ4mDbRXaIhKDEyZlPwKYyA029
	8e8lUxcjB5AtLbH8HweIySngLPH8lAWIKSqgIvHqYP0ERsFZSHpnIemdhdC7gJF5FaNoakFx
	bnpucoGhXnFibnFpXrpecn7uJkZwuGsF7WBctv6v3iFGJg7GQ4wSHMxKIrwi8wLThHhTEiur
	Uovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpgq666f+n+pP6kmqyFg
	/bHObP1jD+4ZfFN8v6RIJCvo6E7rpiPT760V2X6LN2lfOs/tZ9WNx2tvvTn98d3ujJQ33UxM
	x+xnfFZY5fo+r7PrwYuIB2e3pV7q5d7ybptC6ZGbpaLP46f9mRBrNVvk0HRZrzCd+9fOMTTs
	takL73ieUsJfaWghfb7haGyd4Ir/J1rK73L27L9/wXfW3OSCwrl2R9e+X/2Qc0f6+lnZknbu
	qT2PWD4vFxfelNTB+LpMcr6c73+xkpm/7/7I/CVic6M4uJWrU9HhriLrxmzB2Dj1K2ZP3gS3
	vc647zB5/k7BM82pHzY2rpn6S6PpYW3oy7W6d7VfTNuX2ZZ84O3NBI13SizFGYmGWsxFxYkA
	ogkZWOYCAAA=
X-CMS-MailID: 20240527024930epcas2p47dee026c9b332c841d7463f6a1d572c0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_b2de_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199
References: <CGME20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199@epcas2p4.samsung.com>
	<1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
	<6a4767b5-1e2f-dbec-58ca-c44eb0fca6f1@linux.intel.com>
	<20240523044314.GA58326@ubuntu>
	<b936df07-47cc-9921-0550-469fbbb6b49f@linux.intel.com>

------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_b2de_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, May 23, 2024 at 04:38:48PM +0300, Mathias Nyman wrote:
> On 23.5.2024 7.43, Jung Daehwan wrote:
> >On Wed, May 22, 2024 at 04:40:56PM +0300, Mathias Nyman wrote:
> >>On 22.5.2024 4.03, Daehwan Jung wrote:
> >>>ERSTBA_HI should be written first on secondary interrupter.
> >>>That's why secondary interrupter could be set while Host Controller
> >>>is already running.
> >>>
> >>>[Synopsys]- The host controller was design to support ERST setting
> >>>during the RUN state. But since there is a limitation in controller
> >>>in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> >>>It is supported when the ERSTBA is programmed in 64bit,
> >>>or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> >>
> >>xHCI specification 5.1 "Register Conventions "states that 64 bit
> >>registers should be written in low-high order
> >>
> >>>
> >>>[Synopsys]- The internal initialization of event ring fetches
> >>>the "Event Ring Segment Table Entry" based on the indication of
> >>>ERSTBA_LO written.
> >>>
> >>
> >>Any idea if this is a common issue with this host?
> >>Should other 64 bit registers also be written in reverse order.
> >>
> >>>Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >>>---
> >>>  drivers/usb/host/xhci-mem.c | 5 ++++-
> >>>  drivers/usb/host/xhci.h     | 6 ++++++
> >>>  2 files changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> >>>index 3100219..36ee704 100644
> >>>--- a/drivers/usb/host/xhci-mem.c
> >>>+++ b/drivers/usb/host/xhci-mem.c
> >>>@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
> >>>  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
> >>>  	erst_base &= ERST_BASE_RSVDP;
> >>>  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> >>>-	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >>>+	if (intr_num == 0)
> >>>+		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >>>+	else
> >>>+		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
> >>
> >>This may cause issues with other hosts expecting low-high order as stated
> >>in the specification.
> >>
> >>If all 64 bit registers should be written in high-low order for this host then
> >>maybe set a quirk flag and change xhci_write_64()instead.
> >>
> >>xhci_write_64(...)
> >>{
> >>	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> >>		hi_lo_writeq(val, regs);
> >>	else
> >>		lo_hi_writeq(val, regs);
> >>}
> >>
> >
> >Mathias, Thanks for the comment.
> >
> >I've seen this issue only writing the base address of ERST.
> >It's better to use a quirk flag as you said.
> >How about using the quirk only in xhci_add_interrupter?
> >
> >@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
> >   	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
> >   	erst_base &= ERST_BASE_RSVDP;
> >   	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> >	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >  	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> >		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
> >	else
> >		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >
> 
> This works.
> Maybe even skip the xhci_write_64_r() helper and just use hi_lo_writeq() directly.
> 
> Thanks
> Mathias
> 
> 

Thanks. I will send the quirk patch soon.

Best Regards,
Jung Daehwan

> 
> 

------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_b2de_
Content-Type: text/plain; charset="utf-8"


------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_b2de_--

