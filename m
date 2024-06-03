Return-Path: <linux-kernel+bounces-198779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31508D7D48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D081C210B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140B5A7AA;
	Mon,  3 Jun 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Oyrgqn8L"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77457CBA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403109; cv=none; b=Igll3uaF4CHAwCR1FnClne+ixC8dmsJ4KR5X5icZRsYtgRkweZUSKFusQVpQnxop9HilLUAYjcIZaqYGbIkyx56un+GcwmkPiW6zL6x6jS1nrkUud7Zm0FRHtu6jkAOLAXWZbMFKfFNFyEbaRFPbKq3xaZaZZQJv/pym0wZwNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403109; c=relaxed/simple;
	bh=AG7zLoYa6pwVVh8VED662descfrj6HY1FKJRhkNeXHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=WbLPF+j/J9CZcodDsO9YvZOYd665dbkIzOZGZLzMCDd85TqWzSCUlwc9Wo1fOL2hNt8CAIqSYBlHIBe+A/Y0BqqdY8yqvOIc7DQQEXrKhgux1pWp1nFCOB+E8Us0DFpycPudP23NwYMeInZsqhADr/v5A4dDI1xOU5eFu0ypDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Oyrgqn8L; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240603082505epoutp016c58f00a104ef2763d7a7f6789844b22~VcQZu5M-S0516605166epoutp01w
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:25:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240603082505epoutp016c58f00a104ef2763d7a7f6789844b22~VcQZu5M-S0516605166epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717403105;
	bh=1C3qOa5AlVsWyu/+OQ95MS9SgJOaa5GX8eCB8NUS8Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oyrgqn8L8vFljoTfbuftEXaCWNnct3Cjn/SNqEMkajXhjfnUy7IcEcX6krNOAA1VG
	 ryHW6++1rRB7RD3OQn+0f4g4hpaQI2JJoDzP+BGZd6E+U+0eB+FMoBdCLniVvR2JQq
	 H6496W6rlWrRIF5+LX9wTLnUZBV268KVYQUdKv8s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240603082504epcas2p4bb36c2b9feb084821f4a83c8095a3887~VcQZSwMwR1272312723epcas2p43;
	Mon,  3 Jun 2024 08:25:04 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vt6Gm2Qmwz4x9QD; Mon,  3 Jun
	2024 08:25:04 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.BF.09479.0ED7D566; Mon,  3 Jun 2024 17:25:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240603082503epcas2p360843b6f118307123576f5b7b4dc8cae~VcQYbzxle1491214912epcas2p3J;
	Mon,  3 Jun 2024 08:25:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603082503epsmtrp256251f655094270bff752770b0688df8~VcQYa6x2x0907809078epsmtrp29;
	Mon,  3 Jun 2024 08:25:03 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-e7-665d7de03408
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.9B.08622.FDD7D566; Mon,  3 Jun 2024 17:25:03 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603082503epsmtip18cf0192b5b53d9ba2e2698c0c07a7c98~VcQYP5xsL2048920489epsmtip1_;
	Mon,  3 Jun 2024 08:25:03 +0000 (GMT)
Date: Mon, 3 Jun 2024 17:25:38 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, "open
 list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: xhci: Add
 'write-64-hi-lo-quirk' quirk
Message-ID: <20240603082538.GD23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <69c954ce-d7a2-420c-b3f6-72caee02d84f@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmme6D2tg0g627BCyOtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	XqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8ffAKaaCO0IVZ1/NY2xg/M3XxcjJISFgInF+2g22
	LkYuDiGBHYwSX1afZ4RwPjFKfF7fxALhfGOUePtmDitMy9IDDVAtexklLl+8DVX1hFHi4uMt
	zCBVLAIqEr9bpzOC2GwCWhL3fpwAi4sIaEpc//udFaSBWeAOs8SkdSfYQBLCAmESC0/fAlvB
	K6At0Xj6FZQtKHFy5hMWEJtTwE7ix8Hd7F2MHByiQAteHawHmSMhMJND4vS1BSwQ57lIbDq2
	gBHCFpZ4dXwLO4QtJfH53V42CLtY4tbzZ8wQzS2MEitetTBDJIwlZj1rZwRZwCyQIXHmoRyI
	KSGgLHHkFth4ZgE+iY7Df9khwrwSHW1CEI3KEtMvT4AGkKTEwdfnoAZ6SDRvaoCGz0Mmia3H
	DjFPYJSfheSzWQjLZoFt0JFYsPsTG0RYWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KTOCR
	nZyfu4kRnGq1PHYwzn77Qe8QIxMH4yFGCQ5mJRHevrroNCHelMTKqtSi/Pii0pzU4kOMpsBo
	msgsJZqcD0z2eSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MNUf
	v/hmycNXWZsrFnG9SQrQPBnl27vY5IOTFMurOct+xYg9jk17OuXqmZjZr2oe5M041sP7f+1R
	txOxr2zVNWcZuO5kml2yt+gNS4bHiRM2PBk6C1/tnJ38UvdybLh8sPClSac4pP8tYJZ6pWCy
	6dMcxd4JfoUCi11Ym7Yv/e3MyL4gxkfF5lWsc9E+wbMvHWa6+zs8VAqb1mtkeqOwqKK4k0PG
	Mn2b959DUWJKaXvV1Iu3rZlnXbPrN9tjP75//gacEe0pnLKPLivPlb7v5Nlhmthq6HFyaXXe
	/quVnUYlFodendHsEZJgODRZjovjnmXQfI396Ru9Fh09p5zzanLziVzHYyf+nTtgzCPLqMRS
	nJFoqMVcVJwIAMrJbqo+BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO792tg0gy0rTC2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4Mq48bOdqWCOQMXVJdsZGxiv
	8HQxcnJICJhILD3QwNbFyMUhJLCbUeLvyWY2iISkxNK5N9ghbGGJ+y1HWCGKHjFKvPmzkhkk
	wSKgIvG7dTojiM0moCVx78cJsLiIgKbE9b/fwRqYBR4xS0x/8QRsqrBAmMTC07dYQWxeAW2J
	xtOvoKY+ZJJ4euc8O0RCUOLkzCcsIDYz0NQb/14ydTFyANnSEsv/cYCEOQXsJH4c3M0OEhYF
	OuLVwfoJjIKzkDTPQtI8C6F5ASPzKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4GjR
	0trBuGfVB71DjEwcjIcYJTiYlUR4++qi04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIk
	kJ5YkpqdmlqQWgSTZeLglGpg2l62USz3/0bpV3+e9paabjoyPdHYtqj3Je/v9WKTAr2Pvng0
	wyroiqbjxy0/7H2WKrH3mkT/PGShzyxzsFOiyKaBRy+bielh8LK7X103PraY8fj2h/aAK8Ux
	rBu/m4suKxf0eFy5pHD7duEtPj8mHCld7RXJ8v/iQWdHQ6+5VulGzzS+2l/ntvDd7xj7blP2
	5dIM7/3aQvbCHLlL1v7T5VFe8XXlzeXfH9xoXCE4r/b/+aUyXw5NPLy0a/Wrub8/9F/QCHzU
	Nttx36cJJmbqspE1AsX3D0i/jzUsC67eZa/BE6LNFHrL+0GOXtPNxiXMnz0mGa9vZN/XN+dR
	skOwzJltD196B6d90987X2t2pxJLcUaioRZzUXEiACX/Q3sFAwAA
X-CMS-MailID: 20240603082503epcas2p360843b6f118307123576f5b7b4dc8cae
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_3b0dc_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd@epcas2p1.samsung.com>
	<1717135657-120818-4-git-send-email-dh10.jung@samsung.com>
	<bcbff3b2-c5ae-4a95-aa36-f9b88a97e72c@kernel.org>
	<20240603033427.GB23593@ubuntu>
	<69c954ce-d7a2-420c-b3f6-72caee02d84f@kernel.org>

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_3b0dc_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jun 03, 2024 at 08:58:10AM +0200, Krzysztof Kozlowski wrote:
> On 03/06/2024 05:34, Jung Daehwan wrote:
> > On Fri, May 31, 2024 at 10:12:03AM +0200, Krzysztof Kozlowski wrote:
> >> On 31/05/2024 08:07, Daehwan Jung wrote:
> >>> xHCI specification 5.1 "Register Conventions" states that 64 bit
> >>> registers should be written in low-high order. All writing operations
> >>> in xhci is done low-high order following the spec.
> >>
> >> What is high-low / low-high order? Are you talking about endianness?
> >>
> > 
> > It's not about endianness. It means 64 bit is written by 2 of 32 bit.
> > It's when low-high / high-low order is needed.
> > 
> >>>
> >>> Add a new quirk to support workaround for high-low order.
> >>
> >> Why? If they should be written low-high, then why breaking the spec? Why
> >> this cannot be deduced from compatible?
> >>
> > 
> > This quirk is for the controller that has a limitation in supporting
> > separate ERSTBA_HI and ERSTBA_LO programming.
> > 
> > I've copied below from other reply to tell why this is needed.
> > 
> > I've found out the limitation of Synopsys dwc3 controller. This can work
> > on Host mode using xHCI. A Register related to ERST should be written
> > high-low order not low-high order. Registers are always written low-high order
> > following xHCI spec.(64-bit written is done in each 2 of 32-bit)
> > That's why new quirk is needed for workaround. This quirk is used not in
> > dwc3 controller itself, but passed to xhci quirk eventually. That's because
> > this issue occurs in Host mode using xHCI.
> > 
> >> Which *upstream* hardware is affected?
> >>
> > 
> > dwc3 and xhci are affected.
> 
> Which upstream controllers or SoCs are affected. You did not post any
> user of this.
> 

This issue is not specific on SoC side but dwc3 controller. I think it's
better to add it to dwc3 directly but I can't find dts for dwc3. Dts for
SoC, which uses dwc3 would be needed in this case, right?

Best Regards,
Jung Daehwan

> Best regards,
> Krzysztof
> 
> 

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_3b0dc_
Content-Type: text/plain; charset="utf-8"


------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_3b0dc_--

