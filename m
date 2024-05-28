Return-Path: <linux-kernel+bounces-191970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6928D16BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461FF1F22653
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3A13D255;
	Tue, 28 May 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c5yGkcfT"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A13BB59
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716886670; cv=none; b=aZbUI4ZFG0PWubC5P99ONrpkVaCvEdLFVOGGjLY6B3+/BSCqAx/OqPaqxkIP5wu9MR7NEFW91DWOCHU+gEAFM6lEd/2/U0u/gBLGCiVGscGe8JSW1suGHAGckHfQ3flT8+t7Pc892g1LDU4NFa4vyBTcNCHbGfHehMHT3fH9iO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716886670; c=relaxed/simple;
	bh=Z2ZVzLCB1DLel0wDQ208lWGGxo/Ay96Am8WGQzDhPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=mOu/pcQjM2/JEk0CInyEOMaClWKGddbqW8gxTQsaduPuhPaAtEfuVpMgtNE52X1987Ac0ueLu7tu9OSrFKqBPGcDRLUa3kbx/hKYl23vdWHOTCI2r2NGtwsTEsF/YSicREksxrX6EWy/QXMtkz2b52q99+GKFqgFWFNHhk1kcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c5yGkcfT; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240528085745epoutp0237e82599e8585f160aabf6918d09d48e~Tm1NmGVX72056520565epoutp02V
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:57:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240528085745epoutp0237e82599e8585f160aabf6918d09d48e~Tm1NmGVX72056520565epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716886665;
	bh=Cpu9ZrpHLT33e+kzQYs6/leK8/1+IyQzeyr+U+VgPWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c5yGkcfTKwG6DPcftPW7vrt42GIOFyvAxMcbeKyoQFgQWg6SSIsjB2+TqMNq+6Pd6
	 7D5/gQ7PBwO+lkNMdxUBo6GPIaLVK7CgJo3om5kM8PSfEHNNFK39Q9L095nH02XYac
	 fOPzdjxrFnYZj4InjfJcUVbt3KzoKLda4DvzY0Ps=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240528085744epcas2p3abf3306c8cf83279c818e86be677dd03~Tm1M7iOkp1471314713epcas2p3g;
	Tue, 28 May 2024 08:57:44 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VpRHD1gjGz4x9Pv; Tue, 28 May
	2024 08:57:44 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.F3.08613.88C95566; Tue, 28 May 2024 17:57:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240528085743epcas2p2d0114fa01dea187ada84609cc601d8ba~Tm1MJKiIP1279712797epcas2p2w;
	Tue, 28 May 2024 08:57:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240528085743epsmtrp2d4f592fff53cca60b829e6c9922cb814~Tm1MIkTR80217702177epsmtrp28;
	Tue, 28 May 2024 08:57:43 +0000 (GMT)
X-AuditID: b6c32a43-af7ff700000021a5-5c-66559c884088
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.3D.08336.78C95566; Tue, 28 May 2024 17:57:43 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240528085743epsmtip10324d002be65f1b61e8a6ae724c7ee9d~Tm1L-jB_O0485504855epsmtip1X;
	Tue, 28 May 2024 08:57:43 +0000 (GMT)
Date: Tue, 28 May 2024 17:58:05 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Thinh
	Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: host: Add a quirk for writing ERST in high-low
 order
Message-ID: <20240528085805.GA80763@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024052838-fifth-liver-fb4e@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVLdjTmiawbMJnBbNi9ezWVzeNYfN
	YtGyVmaL5k1TWC1WLTjA7sDqsXjPSyaP/XPXsHts2f+Z0ePzJrkAlqhsm4zUxJTUIoXUvOT8
	lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
	/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxZm+ezFfRKVTR/vcPU
	wDhFtIuRk0NCwERi8pdGVhBbSGAHo8TSGSZdjFxA9idGie4zS6AS3xgl3t72gml4vOMCC0TR
	XkaJjeca2CCcJ4wS73f9YwOpYhFQlXh2di8TiM0moCVx78cJZhBbRMBYov/sLHYQm1lgD6PE
	wplCILawQIDE+i+bgHo5OHgFtCX6PxmDhHkFBCVOznzCAmJzChhKTF3QyQ5SIiqgIvHqYD3I
	WgmBt+wS+6+fZ4Q4zkXi1MzFrBC2sMSr41vYIWwpic/v9rJB2MUSt54/Y4ZobmGUWPGqhRki
	YSwx61k7I8RtGRLPe7qYQJZJCChLHLnFAhHmk+g4/JcdIswr0dEmBNGpLDH98gSotZISB1+f
	g5roIbH8xF9mSPC8Y5SYc2Ai2wRG+VlIXpuFZBuErSOxYPcntllAK5gFpCWW/+OAMDUl1u/S
	X8DIuopRLLWgODc9NdmowBAe1cn5uZsYwQlSy3kH45X5//QOMTJxMB5ilOBgVhLhPTMpNE2I
	NyWxsiq1KD++qDQntfgQoykwmiYyS4km5wNTdF5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLp
	iSWp2ampBalFMH1MHJxSDUwOqkHuJkd7Hm1yit51/u2l+FOTswLcAyZwnZCb+Ev5/hvPmONr
	s0Mup+Y0eN+oqTdqddBJ+fRiQt3PDbsYTltdeRXj4Th1UUmpaUJUMr8V03eJoxf1Sm5svL6+
	U6jlTszRXzHMS58f8Xa8Pm/+5hyGCQtO3HQQzn6+5kAmc/3xecUvln77MCX8zc5tH88/+VDI
	4nHZ9ej6Bt/bE/PPW0hduyF6pYxX+UdQwdcdXNWz4jhShR+9+2XC7addUlJht79073wVrWYG
	7caVW39ufe+ix6auo8MsvL891H56uOOOtx0ryl58zb2w67nc6Wod27U1V8+6t3klxv1cdZ9z
	03b9vhBXpWPfik+/eNll1OWmxFKckWioxVxUnAgAuzis/xkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnG77nNA0gx3tRhbNi9ezWVzeNYfN
	YtGyVmaL5k1TWC1WLTjA7sDqsXjPSyaP/XPXsHts2f+Z0ePzJrkAligum5TUnMyy1CJ9uwSu
	jC1fexgLzopXTP61lrWB8a1QFyMnh4SAicTjHRdYuhi5OIQEdjNKrP/3hhUiISmxdO4Ndghb
	WOJ+yxFWiKJHjBItE3azgSRYBFQlnp3dywRiswloSdz7cYIZxBYRMJboPzuLHaSBWWAfo8SP
	J5NYQBLCAn4S0x+uAbI5OHgFtCX6PxlDDH3HKDHlWDsjSA2vgKDEyZlPwOqZgYbe+PeSCaSe
	WUBaYvk/DpAwp4ChxNQFnewgYVEBFYlXB+snMArOQtI8C0nzLITmBYzMqxglUwuKc9Nziw0L
	DPNSy/WKE3OLS/PS9ZLzczcxgoNcS3MH4/ZVH/QOMTJxMB5ilOBgVhLhPTMpNE2INyWxsiq1
	KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD084Xas/+ND1pPnVtAfP/
	eUaMiaVy5nMqeSXzxT9drLosr7dObkfYt8XfXpxwMnTxT+sRVns376noruNNcsUL5b9wlKhm
	uJmfmKHVX3qTTeSqXIH7uuKk705fznelam/QP8kko/xz26rZZjWyTL81l5R+XhtdvK2M0XTV
	iZvznrpkVsmuS54jeP5NyPOV/wqVQ66JTd7/8ueaw3lT/vuucG+4baz1Y3a0vR5fRdgX/vc9
	zkXKDs6a80PWLM9ak7Z+4VwXCwfubQtT3rfOVs6uuVSkNv+DynRPrzOi7gtv2a1oDudxMv1p
	/+5rZEaumGGJMOfHsFaPLzYms/ZFv8/XaFJ7knnrasnTHa8nV19sU2Ipzkg01GIuKk4EALbQ
	rebhAgAA
X-CMS-MailID: 20240528085743epcas2p2d0114fa01dea187ada84609cc601d8ba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_1c70e_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
	<1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
	<2024052814-exponent-domestic-6da2@gregkh>
	<2024052838-fifth-liver-fb4e@gregkh>

------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_1c70e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, May 28, 2024 at 09:30:34AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 28, 2024 at 09:23:43AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, May 28, 2024 at 02:57:16PM +0900, Daehwan Jung wrote:
> > > [Synopsys]- The host controller was design to support ERST setting
> > > during the RUN state. But since there is a limitation in controller
> > > in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> > > It is supported when the ERSTBA is programmed in 64bit,
> > > or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> > > 
> > > [Synopsys]- The internal initialization of event ring fetches
> > > the "Event Ring Segment Table Entry" based on the indication of
> > > ERSTBA_LO written.
> > > 
> > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > ---
> > >  drivers/usb/host/xhci-mem.c | 5 ++++-
> > >  drivers/usb/host/xhci.h     | 2 ++
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > > index 3100219..ef768e6 100644
> > > --- a/drivers/usb/host/xhci-mem.c
> > > +++ b/drivers/usb/host/xhci-mem.c
> > > @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
> > >  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
> > >  	erst_base &= ERST_BASE_RSVDP;
> > >  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> > > -	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> > > +	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> > > +		hi_lo_writeq(erst_base, &ir->ir_set->erst_base);
> > > +	else
> > > +		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> > >  
> > >  	/* Set the event ring dequeue address of this interrupter */
> > >  	xhci_set_hc_event_deq(xhci, ir);
> > > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > > index 3041515..8664dd1 100644
> > > --- a/drivers/usb/host/xhci.h
> > > +++ b/drivers/usb/host/xhci.h
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/usb/hcd.h>
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > +#include <linux/io-64-nonatomic-hi-lo.h>
> 
> Why not put this in the .c file?

I add it following similar header file.
#include <linux/io-64-nonatomic-lo-hi.h>

Do you think it should be put in .c file because .c file only uses it?
If so, I will modify it in the next submission.

> 
> > >  /* Code sharing between pci-quirks and xhci hcd */
> > >  #include	"xhci-ext-caps.h"
> > > @@ -1627,6 +1628,7 @@ struct xhci_hcd {
> > >  #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
> > >  #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
> > >  #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
> > > +#define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
> 
> Note, you define this, and check it, but it is never set, so this patch
> is useless on its own and so we can not accept it as-is at all.
> 
> How was this tested?

I got it. I will add other patches and send the patchset.

> 
> thanks,
> 
> greg k-h
> 

------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_1c70e_
Content-Type: text/plain; charset="utf-8"


------9rvGp.wOoe8SBwNMBd7Hnn8uuLJro-MzoefNgNBE_LtzfeiS=_1c70e_--

