Return-Path: <linux-kernel+bounces-186985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333968CCB83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F91F22E06
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502A129A78;
	Thu, 23 May 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uA2hKpb5"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545333FE
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439853; cv=none; b=YK7a/3gmNdytSMeGft3KbX+yUVkpsqt6xzoYi2FqMSwhAvoaRjlzdza14wGmA50E9UKCx8feziSgP/S7uzi5AKs6IKD6WiB69r5ZlkqByVSfW6VwgGG/fBFzPY2S174xFB/QczkbD/XuRDwgc2YOUlFRnOdRPRI8DJdUTlWEV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439853; c=relaxed/simple;
	bh=zNZfPGfkCbxAWHwdPp0NdHojr7tUW+Mq7W6lS3WV2YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JIP7gnln4kQCBXYtFaM8hoZJCuB/F0GR0DLgrVhckj12gpfc3Ju7iBYE6K1Lkhf7QKX+1WTqsbOOeJu4ULQo4/F8PIT6V4TEUqcdFXfk9JoqShktHY5h7Xah0HCcnx9tpaWosxnKqRDJWd9WnKHRnuzHyhyPjYE3y3IhnEZo534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uA2hKpb5; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240523044302epoutp01908ba467372e99bd52bfc446817d2cc9~SBIY2y4ZI0266302663epoutp01n
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240523044302epoutp01908ba467372e99bd52bfc446817d2cc9~SBIY2y4ZI0266302663epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716439382;
	bh=ccGphUKCftSzx9C+qXoyXbSsJSmSoy3fCYyCwt5nOew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uA2hKpb5NCl74C5CF4k/1upnqhQh1opHmN4ayJ3iqqGKtTQaZqOF9tSyxZWmJZAcY
	 ZaaOENlOteM3Hv1iMav3uprxzf+F9t28sgKNs5xzLqnaG4YlepqKDLrtQB6/lcodzf
	 UbQseifI13nhVoQC3tfI+3BAR+KBC7I6Mnv8kUQc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240523044301epcas2p2d716169e324fcb13c0a32bef56820b59~SBIYYnUul1731317313epcas2p2X;
	Thu, 23 May 2024 04:43:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VlFsd352tz4x9Q0; Thu, 23 May
	2024 04:43:01 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.26.09639.559CE466; Thu, 23 May 2024 13:43:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240523044300epcas2p45fb52dc2e4e7a1ffeac37d65929dc3d7~SBIXbSHss2576925769epcas2p4Z;
	Thu, 23 May 2024 04:43:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240523044300epsmtrp1fc172bbd66fd85f92354de6c14d14fe9~SBIXZR4iU2206822068epsmtrp1i;
	Thu, 23 May 2024 04:43:00 +0000 (GMT)
X-AuditID: b6c32a46-681ff700000025a7-73-664ec95542d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.15.19234.459CE466; Thu, 23 May 2024 13:43:00 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240523044300epsmtip2f4eeae0ec016a7998593e9727b022e21~SBIXQgnuA0985809858epsmtip2w;
	Thu, 23 May 2024 04:43:00 +0000 (GMT)
Date: Thu, 23 May 2024 13:43:14 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Thinh
	Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [RFC] usb: host: xhci-mem: Write high first on erst base of
 secondary interrupter
Message-ID: <20240523044314.GA58326@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a4767b5-1e2f-dbec-58ca-c44eb0fca6f1@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmqW7oSb80gyczRS2aF69ns7i8aw6b
	xaJlrcwWzZumsFq8/tDEYrFqwQF2BzaPxXteMnnMOxnosX/uGnaPLfs/M3p83iQXwBqVbZOR
	mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
	KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj/ffj
	7AUfZCuuf37A2MD4TaKLkZNDQsBEYkb/FbYuRi4OIYEdjBKL3y1jhnA+MUo8amhihHOOnJvB
	DtPy8/VsqJadjBJfLx1l7WLkAHKeMEoccAepYRFQlfg8bRELiM0moCVx78cJZhBbRMBQ4tul
	7WBDmQXeM0o8e76CDSQhLJAgse32XlYQm1dAW2LntxtsELagxMmZT8AGcQo4S6xbtgpsl6iA
	isSrg/UgcyQEPrJLdOz+zAhxnIvE2eNfoQ4Vlnh1fAuULSXxsr8Nyi6WuPX8GTNEcwujxIpX
	LcwQCWOJWc/awQYxC2RInH/5nw1kmYSAssSRWywQYT6JjsN/2SHCvBIdbUIQncoS0y9PYIWw
	JSUOvj4HNdFDoqNlPthEIYFLjBIzr+lMYJSfheSzWUiWQdg6Egt2fwKyOYBsaYnl/zggTE2J
	9bv0FzCyrmIUSy0ozk1PLTYqMILHdXJ+7iZGcNLUctvBOOXtB71DjEwcjIcYJTiYlUR4o1f6
	pgnxpiRWVqUW5ccXleakFh9iNAXG00RmKdHkfGDaziuJNzSxNDAxMzM0NzI1MFcS573XOjdF
	SCA9sSQ1OzW1ILUIpo+Jg1Oqgelk8bYbnn8bY7K3L+9mrPL70aldF/P9KNOiyAp3RjatjFlM
	Ss/TJ81qyv96xPr4vgXmRTdXti7WOnup9ifLjfzp87izWf8GHdzkEWhoG6cb8XdGP2vDvLu/
	NjxYWuOVmSz69FUf387Vn53mR9uc3txwVTLw+I38XZmXmyLjn/SorYnk5c4Rst5VX7D07MrD
	Npr6bu01h651tn6IPF5wU/XqzPTmxzcn5u/hitHhiHNvdnPOyTt61/VwgcQW6+dyh9M2ix7s
	CHt6Zy0zJ+8GafkTTCGrZA8v5ld6uGBxrtsBkfMreoyuVDZtPdny0YfTy+j/zzsJOQ0TVP5N
	q0t7/yn+mcpBk8WrhQ13aaytOKrEUpyRaKjFXFScCAAC4um7IwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvG7ISb80gzXHjC2aF69ns7i8aw6b
	xaJlrcwWzZumsFq8/tDEYrFqwQF2BzaPxXteMnnMOxnosX/uGnaPLfs/M3p83iQXwBrFZZOS
	mpNZllqkb5fAlXFuU0TBBumKh0cWMTcwnhfrYuTkkBAwkfj5ejYbiC0ksJ1R4uQRRYi4pMTS
	uTfYIWxhifstR1i7GLmAah4xSszsncYIkmARUJX4PG0RC4jNJqAlce/HCWYQW0TAUOLbpe2M
	IA3MAh8ZJe61TWAFSQgLJEhsu70XzOYV0JbY+e0GG8TUS4wSE3b+gkoISpyc+QRsKjPQ1Bv/
	XjJ1MXIA2dISy/9xgIQ5BZwl1i1bxQoSFhVQkXh1sH4Co+AsJM2zkDTPQmhewMi8ilE0taA4
	Nz03ucBQrzgxt7g0L10vOT93EyM42LWCdjAuW/9X7xAjEwfjIUYJDmYlEd7olb5pQrwpiZVV
	qUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUwln8KK91o/8byWucp6
	fcdOi/9v/x9i5l1WZ/o3179xiSpb1vEF9wyfvH4Rs1b9uJyA94tHDQKiLlt6nkslXZ4Uwn1I
	52RxfrfEvFM8n6qmX78gm1jnc5P7D2fGKp8Vt7OK1y14otm/t1k9czPrr7zNU08WbJ7M9/Lo
	q53dh8WrX990Pb9SS3zpscj7t0vXMtlPWGNq+/kCk8hOD5kt6cu0Oza3HjzlVicktjNf55Kb
	pwzjw6eT8s43ZipXMQuzvSz9mvZt6We+bh827tqviyw0eZaeEk0/U19z1p/p0Fy9pw5m825G
	PfBuWbCytVVg6U7lvue1FYqJ2aeNHwsv1xe9Pce86FkR24/6Jo/kaa+VWIozEg21mIuKEwF+
	64kI5QIAAA==
X-CMS-MailID: 20240523044300epcas2p45fb52dc2e4e7a1ffeac37d65929dc3d7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----BbtZ7qlu1xTtNXmXFmapKVIwgBoKBa_9lu5sWsXX_PnLLLIn=_46a6f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199
References: <CGME20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199@epcas2p4.samsung.com>
	<1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
	<6a4767b5-1e2f-dbec-58ca-c44eb0fca6f1@linux.intel.com>

------BbtZ7qlu1xTtNXmXFmapKVIwgBoKBa_9lu5sWsXX_PnLLLIn=_46a6f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, May 22, 2024 at 04:40:56PM +0300, Mathias Nyman wrote:
> On 22.5.2024 4.03, Daehwan Jung wrote:
> >ERSTBA_HI should be written first on secondary interrupter.
> >That's why secondary interrupter could be set while Host Controller
> >is already running.
> >
> >[Synopsys]- The host controller was design to support ERST setting
> >during the RUN state. But since there is a limitation in controller
> >in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> >It is supported when the ERSTBA is programmed in 64bit,
> >or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> 
> xHCI specification 5.1 "Register Conventions "states that 64 bit
> registers should be written in low-high order
> 
> >
> >[Synopsys]- The internal initialization of event ring fetches
> >the "Event Ring Segment Table Entry" based on the indication of
> >ERSTBA_LO written.
> >
> 
> Any idea if this is a common issue with this host?
> Should other 64 bit registers also be written in reverse order.
> 
> >Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >---
> >  drivers/usb/host/xhci-mem.c | 5 ++++-
> >  drivers/usb/host/xhci.h     | 6 ++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> >index 3100219..36ee704 100644
> >--- a/drivers/usb/host/xhci-mem.c
> >+++ b/drivers/usb/host/xhci-mem.c
> >@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
> >  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
> >  	erst_base &= ERST_BASE_RSVDP;
> >  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> >-	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >+	if (intr_num == 0)
> >+		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> >+	else
> >+		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
> 
> This may cause issues with other hosts expecting low-high order as stated
> in the specification.
> 
> If all 64 bit registers should be written in high-low order for this host then
> maybe set a quirk flag and change xhci_write_64()instead.
> 
> xhci_write_64(...)
> {
> 	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> 		hi_lo_writeq(val, regs);
> 	else
> 		lo_hi_writeq(val, regs);
> }
> 

Mathias, Thanks for the comment.

I've seen this issue only writing the base address of ERST.
It's better to use a quirk flag as you said.
How about using the quirk only in xhci_add_interrupter?

@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
  	erst_base &= ERST_BASE_RSVDP;
  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
	else
		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);

OR

@@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
  	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
  	erst_base &= ERST_BASE_RSVDP;
  	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
 	if (!xhci->quirks & XHCI_WRITE_64_HI_LO)
		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
	else
		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);

}

> Thanks
> Mathias
> 

------BbtZ7qlu1xTtNXmXFmapKVIwgBoKBa_9lu5sWsXX_PnLLLIn=_46a6f_
Content-Type: text/plain; charset="utf-8"


------BbtZ7qlu1xTtNXmXFmapKVIwgBoKBa_9lu5sWsXX_PnLLLIn=_46a6f_--

