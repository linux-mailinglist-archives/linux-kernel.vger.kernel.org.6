Return-Path: <linux-kernel+bounces-198576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949348D7A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3242F1F213F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F217BB9;
	Mon,  3 Jun 2024 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JXKuoPeU"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFD208D6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385638; cv=none; b=H4phXgL2bDvNaiOkaFgfdpGDP2Fac3Xmrp74514UqJEX9/NEbSgtXUrfZuR4rzTRTe0Ejn/sIYDyPgfXkcOTGoKtVx0oLoy3nSjl5BOiSgGZd6ucCiKeM/42PwWel2zIGsqClZUnCmO331vjgNubJHDwq1YU6Nr1FPMvupnty6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385638; c=relaxed/simple;
	bh=CUDdI5D92D3Oqky0aEdC6RXk5+X1lolIr5T5+5DbMFw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=HsF9rkoFjQbk7s2ZbOl2j8bPmCWjJ1gYptyDAMeLFv8athAMPhADhrGy2S0DzAZ7KdniiJWDK3YPBqqcWenBTT35aKCXJPd6Ex/f/QOiU/U9S0qYETuF+/IeAOKjCPTapM70tO4as1kteHW+32mOsn6OgKv3pkFxMrOPXfYWDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JXKuoPeU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240603033354epoutp036bdae1da51be2674b79898daa314f9b2~VYSKX5jKc0251902519epoutp034
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:33:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240603033354epoutp036bdae1da51be2674b79898daa314f9b2~VYSKX5jKc0251902519epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717385634;
	bh=tKsjIjB6Iu8arVC3CsXOGSg9ibPBsNHvRR07m1WCnSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXKuoPeUZZJLki7u+FU5wG6PHKc0ELfHw/zyqF4avqa3J19m+6IiyVE8tAqcrjdtc
	 z4JvSWBVsRA2wZ1DjTWigimOB8VZ0ZoSopmkGS9foLrsXrWmRn43fc5gEFcC/3ygcY
	 ZuzCG7VgHJ9811iFLdxS/qCTREI0Y9C55xRBm5gk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240603033353epcas2p2a6c6ac2bf16a78d460304ae5f54166b7~VYSJzTe0o1217212172epcas2p26;
	Mon,  3 Jun 2024 03:33:53 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vszpm6tKqz4x9Pv; Mon,  3 Jun
	2024 03:33:52 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.58.09485.0A93D566; Mon,  3 Jun 2024 12:33:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240603033352epcas2p2e930fadaa3e5a52f77ea4b91aa60aef7~VYSI6du0H1767917679epcas2p2P;
	Mon,  3 Jun 2024 03:33:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603033352epsmtrp2588403cd585fb3c1102453ca33243848~VYSI5wG9X0454704547epsmtrp2v;
	Mon,  3 Jun 2024 03:33:52 +0000 (GMT)
X-AuditID: b6c32a46-19bfa7000000250d-ca-665d39a08277
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.D5.07412.0A93D566; Mon,  3 Jun 2024 12:33:52 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603033352epsmtip24bcec0733e3dfb031b5052b9a6a4473d~VYSIuVVB12580725807epsmtip2x;
	Mon,  3 Jun 2024 03:33:52 +0000 (GMT)
Date: Mon, 3 Jun 2024 12:34:27 +0900
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
Message-ID: <20240603033427.GB23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcbff3b2-c5ae-4a95-aa36-f9b88a97e72c@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmme4Cy9g0g2MXTSyOtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	XqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdseHvU5aCM3wV/xaWNTC+4e5i5OSQEDCROLv3NXsX
	IxeHkMAORonfF94xQjifGCXaXz9jgnC+MUr03TjLDtPyf/4fqMReRolLO09D9T9hlHjd/poF
	pIpFQEXi/6qVYDabgJbEvR8nmEFsEQFNiet/v7OCNDAL3GGWmLTuBBtIQlggTGLh6VusIDav
	gLbE4+2ToWxBiZMzn4AN4hSwk1jRBjKIg0MUaMGrg/UgcyQEpnJI7Fs2FSwuIeAi0dAuDXGp
	sMSr41ugrpaS+PxuLxuEXSxx6/kzZojeFkaJFa9amCESxhKznrUzgsxhFsiQOHHNDWKkssSR
	W2AXMAvwSXQc/ssOEeaV6GgTgmhUlph+eQIrhC0pcfD1OaiBHhLNmxpYIMHTzSQx6ckNxgmM
	8rOQPDYLYdkssA06Egt2f2KDCEtLLP/HAWFqSqzfpb+AkXUVo1hqQXFuemqxUYERPKqT83M3
	MYLTrJbbDsYpbz/oHWJk4mA8xCjBwawkwttXF50mxJuSWFmVWpQfX1Sak1p8iNEUGEsTmaVE
	k/OBiT6vJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmIUt51+OO
	vW/0QtX5FvZcsb/QzBBx1f6m2CY21vMHk57PmqmbNNnr2tHgEjM29r6iw5UyRx/ycc6tc3Uq
	0DdhMODl+n15y4PVs24maomsbU1UzVvjmVCwtHfdZQPZ73bsjDnHLfbu4bXY5mUw9Zx+/OIb
	55fO5JDpCM/T+JVndnTaU1bN2MLNcefyG65M7A2ZzmXnGfpeeU+SzRReY0XmxPJq9g38As47
	p5SIPVEQvHnv8qnLQWbuQmuKpvw51L48Zqpcd1Ff9ZzSlG+7EqIuhdsy/4zuZ1rncGTe+njb
	eR2vsheeTWQJVfncYGRjU8ztdHnql2dL3gh+anLZW3E/N2LK1u3JS/rfLjrlPUeJpTgj0VCL
	uag4EQCnU43vPAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO4Cy9g0g54WGYtjbU/YLdbsPcdk
	Mf/IOVaL5sXr2SxezrrHZnH+/AZ2i8u75rBZLFrWymzRvGkKq8X/PTvYLVYtOMDuwO2xeM9L
	Jo9NqzrZPPbPXcPusWX/Z0aPz5vkAlijuGxSUnMyy1KL9O0SuDJWfj3LXtDDU/Hys0cD41HO
	LkZODgkBE4n/8/8wdTFycQgJ7GaU2LjvFRtEQlJi6dwb7BC2sMT9liOsEEWPGCUW7zoHlmAR
	UJH4v2olC4jNJqAlce/HCWYQW0RAU+L63+9gDcwCj5glpr94AjZVWCBMYuHpW6wgNq+AtsTj
	7ZPBbCGBbiaJmf+kIOKCEidnPgEbygw09Ma/l0DncQDZ0hLL/3GAhDkF7CRWtIHs4uAQBbrh
	1cH6CYyCs5A0z0LSPAuheQEj8ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOBI0dLY
	wXhv/j+9Q4xMHIyHGCU4mJVEePvqotOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCe
	WJKanZpakFoEk2Xi4JRqYDpY2rM284f45E9cltfUNErZmyuMb61QtTO+r9mwfarBgq2hK1TS
	dws9y3bYXpphZahu/e5w362VU+JyZkmtcitaafc1kpXRy+R6/nHumyF3UtIFok7e+HelRm7J
	582sbMqBT7ZUL2SXZeSTVulTu5nbc2vPvZ8RXCruUS1669je72XcevT1gWhW64oj3g+y73Fd
	yJDyOZo745Tl9LY3n/ivXHsXLbPncerbhtebtCVCkz771KWoJLTW5pnP96xxalRiK1izzsvo
	Qcr0Fy/C6gX0f73TE5mhJLkjgPeuHhtP72HdJ0/SZhoqn3C9bty34JL4PPUTEtNjE5akPhC+
	zKOou2Sz/PJNBorB2gLJSizFGYmGWsxFxYkAtUjapwMDAAA=
X-CMS-MailID: 20240603033352epcas2p2e930fadaa3e5a52f77ea4b91aa60aef7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_377ca_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060729epcas2p1df12dd3b14c5fa2fa0716f72010b3dbd@epcas2p1.samsung.com>
	<1717135657-120818-4-git-send-email-dh10.jung@samsung.com>
	<bcbff3b2-c5ae-4a95-aa36-f9b88a97e72c@kernel.org>

------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_377ca_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, May 31, 2024 at 10:12:03AM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2024 08:07, Daehwan Jung wrote:
> > xHCI specification 5.1 "Register Conventions" states that 64 bit
> > registers should be written in low-high order. All writing operations
> > in xhci is done low-high order following the spec.
> 
> What is high-low / low-high order? Are you talking about endianness?
> 

It's not about endianness. It means 64 bit is written by 2 of 32 bit.
It's when low-high / high-low order is needed.

> > 
> > Add a new quirk to support workaround for high-low order.
> 
> Why? If they should be written low-high, then why breaking the spec? Why
> this cannot be deduced from compatible?
> 

This quirk is for the controller that has a limitation in supporting
separate ERSTBA_HI and ERSTBA_LO programming.

I've copied below from other reply to tell why this is needed.

I've found out the limitation of Synopsys dwc3 controller. This can work
on Host mode using xHCI. A Register related to ERST should be written
high-low order not low-high order. Registers are always written low-high order
following xHCI spec.(64-bit written is done in each 2 of 32-bit)
That's why new quirk is needed for workaround. This quirk is used not in
dwc3 controller itself, but passed to xhci quirk eventually. That's because
this issue occurs in Host mode using xHCI.

> Which *upstream* hardware is affected?
>

dwc3 and xhci are affected.

Best Regards,
Jung Daehwan

> 
> 
> Best regards,
> Krzysztof
> 
> 
> 

------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_377ca_
Content-Type: text/plain; charset="utf-8"


------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_377ca_--

