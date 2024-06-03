Return-Path: <linux-kernel+bounces-198794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB98D7D7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627BEB2381E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2206823AF;
	Mon,  3 Jun 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FPxEJbrq"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D17F7D1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403788; cv=none; b=Kxpi0e/pzIHxaxNao2ETIQ0mPJxHRsslWybVqrizCCdHULenI0iBNrlNaBv3E+fC48PofPujy4+Yh5ePr9QYQKnkU5zCXgV7XR2yHgmTe04dm5gneCwJ8+9orXnpP6ZfzyyDqZv7FAu1GDFJqIW0BxfbYV9KDjw0PeYWK8HcUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403788; c=relaxed/simple;
	bh=ax0iRHdz96YP7f3j9nn4F+5uHRSqxLUFy88RU9iHAyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=S/bWxpUr5nU/KndgwCZOdkTgpztLVsvv0KtH2o3e/Qvmu2SxcWTImTp358lsDysutP5f10TycR1wjpxqmAwQQpozjiO7jpuni9a+x9zSUrsGdgIkCySebSY7CElMVZQcaQebcVQ/90Nntlqe00S8qOmb8oysa31E0LinZcHBa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FPxEJbrq; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240603083624epoutp02c2de4f9dc6082bd323d0e08ef6b8cd07~VcaSC1cgU1754517545epoutp02x
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:36:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240603083624epoutp02c2de4f9dc6082bd323d0e08ef6b8cd07~VcaSC1cgU1754517545epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717403784;
	bh=1i4h+U/OjuDvnO0eABaI14pGNFllzrKbyYDQLcQT6jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FPxEJbrqtZU6HOoYsqqhWth6F/E5/xyV976FYCHa/hZDYFjUao89fMvD+8ZQURz3d
	 T6Xb+h8gt4DVc0hBZ2K5SANp0okOIQi2Du06qusdPLW39k6v4Ys0GRVsyFg8+BjhZF
	 lyE9YNPDae5nPhCUB4Rdn+szi0iZq9jVCRT7c140=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240603083623epcas2p24502b63cd55099780b32b04a138f34d3~VcaRZ_mMu2494824948epcas2p2G;
	Mon,  3 Jun 2024 08:36:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vt6Wq1kB8z4x9Q3; Mon,  3 Jun
	2024 08:36:23 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.A7.09806.7808D566; Mon,  3 Jun 2024 17:36:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240603083622epcas2p44b6fb5135a5b9e719a06322b487f8e13~VcaQvVSTL1343513435epcas2p4U;
	Mon,  3 Jun 2024 08:36:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603083622epsmtrp256c9f310045c64276bf51fcda59d1382~VcaQuSs3N1638016380epsmtrp2m;
	Mon,  3 Jun 2024 08:36:22 +0000 (GMT)
X-AuditID: b6c32a47-4f767a800000264e-05-665d808738de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.EE.18846.6808D566; Mon,  3 Jun 2024 17:36:22 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603083622epsmtip2757069851c5ffb92ed1f10f9da516d1c~VcaQjGHGH1582715827epsmtip2X;
	Mon,  3 Jun 2024 08:36:22 +0000 (GMT)
Date: Mon, 3 Jun 2024 17:36:57 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, "open
 list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add
 'snps,xhci-write-64-hi-lo-quirk' quirk
Message-ID: <20240603083657.GE23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eb13e81c-2669-4e82-86eb-d61203475962@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhW57Q2yawaoVXBbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
	WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
	L9ArTswtLs1L18tLLbEyNDAwMgUqTMjO2PpiKmvBEb6KQ2/PMzcw3uTuYuTkkBAwkbi3+z5z
	FyMXh5DADkaJfe8vsUI4nxglnuxZywbnPPr6iQ2m5fKECVAtOxklFj75xwLhPGGUODf1MhNI
	FYuAisTP3q9gHWwCWhL3fpxgBrFFBDQlrv/9DraDWeAOs8SkdSfAioQFUiVeH+sGa+YV0Ja4
	13IKyhaUODnzCQuIzSlgJ/F42gHGLkYODlGgBa8O1oPMkRCYyiHx9sNsJojzXCS+HT/HDmEL
	S7w6vgXKlpL4/G4v1AvFEreeP2OGaG5hlFjxqoUZImEsMetZOyOIzSyQIdE64wMLyDIJAWWJ
	I7dYIMJ8Eh2H/7JDhHklOtqEIDqVJaZfnsAKYUtKHHx9Dmqih8SSwyuhwfiQSeJr81PmCYzy
	s5C8NgvJNghbR2LB7k9ss4BWMAtISyz/xwFhakqs36W/gJF1FaNYakFxbnpqsVGBMTy6k/Nz
	NzGC062W+w7GGW8/6B1iZOJgPMQowcGsJMLbVxedJsSbklhZlVqUH19UmpNafIjRFBhRE5ml
	RJPzgQk/ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGJoOZa87E
	T9h+JU/xhnDPwvX1NmabTT9Hrl8XzJMYxR9tMCW6PG0yU6rgzEgFcaeVQivcxX+2TTH9fkh0
	pczfC64Hlu5r2e3EevaqtZSrBP/9dcHGV1+/S9IrWbprssKEic8k5/+7e0vn++2fK+0vvrh5
	VEd3y2qN/nZdEbZD/9v+a0x2r/rm0HThQdrdiWu6OGMv7lXvb/C+UrX0Q1xe6KQdj6ZLsno/
	SHggKby5he32qQVPArIP/Lt2Xqj68zWJmpZ6N9Fg71kt5TtmZzMWRhayzLJd3Hj/S5b/zN8q
	NoYLjmcs5FokNuV5B5tuT0hLX+SbH0cva5WknEv5fTW8g4V/olLshcnPgkpLGo50iyixFGck
	GmoxFxUnAgAw+gi2QAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvG5bQ2yawZ8ZBhbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGcdmkpOZklqUW6dslcGWceHmPpaCFp+LWsQ1MDYyb
	OLsYOTkkBEwkLk+YwNzFyMUhJLCdUWLvljMsEAlJiaVzb7BD2MIS91uOsEIUPWKUaD1xigkk
	wSKgIvGz9ysbiM0moCVx78cJZhBbREBT4vrf72ANzAKPmCWmv3gCViQskCrx+lg3WDOvgLbE
	vRaQQSBTHzJJ7Hl3iBUiIShxcuYTsDOYgabe+PcSqIgDyJaWWP6PAyTMKWAn8XjaAUaQsCjQ
	Ea8O1k9gFJyFpHkWkuZZCM0LGJlXMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgRHiVbQDsZl
	6//qHWJk4mA8xCjBwawkwttXF50mxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1
	OzW1ILUIJsvEwSnVwNRx5eHZlR+8d25TCLtplfCyWGbXLvU/N1nn1dk8+NH07n/I65KlRel3
	iwMLQyXNNhZF1/xRWtL/i0+hqF8tpXrHvODrbnyBf85NseheHSswtzJk3hS3/MPZoRuauDf/
	bF/3YFnrqro/i4uKXbynpiwQ2CrBHfq0ddZhCXaTpE3XttbKf2VkfSSXniu7fObCM3LBwb5n
	M7n0z77aP2fy22kbu8+oTDWeGJw/r31uYduDta2vFVrkzwuZX3S9HVOxJulZ5nHj+oKA/b+y
	f+ilTHopftSlhWVZXWKJ3nvvI2nbZijJ7Sgte7Z0qtmnhKv6Brd0stJXTJkq+o/re1P3sxsq
	p1eyP3x8au43l5ViyeJKLMUZiYZazEXFiQCNEuwdAQMAAA==
X-CMS-MailID: 20240603083622epcas2p44b6fb5135a5b9e719a06322b487f8e13
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----pMGQB5Kx8CcFe4a2OrTD1laxas9T8E6znMm-R6uZIIDZNQ_y=_3b5a7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7@epcas2p3.samsung.com>
	<1717135657-120818-2-git-send-email-dh10.jung@samsung.com>
	<57966949-8080-4aa5-8d38-63ded1c2b467@kernel.org>
	<20240603030316.GA23593@ubuntu>
	<eb13e81c-2669-4e82-86eb-d61203475962@kernel.org>

------pMGQB5Kx8CcFe4a2OrTD1laxas9T8E6znMm-R6uZIIDZNQ_y=_3b5a7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jun 03, 2024 at 08:57:16AM +0200, Krzysztof Kozlowski wrote:
> On 03/06/2024 05:03, Jung Daehwan wrote:
> > On Fri, May 31, 2024 at 10:10:30AM +0200, Krzysztof Kozlowski wrote:
> >> On 31/05/2024 08:07, Daehwan Jung wrote:
> >>> Add a new quirk for dwc3 core to support writing high-low order.
> >>
> >> This does not tell me more. Could be OS property as well... please
> >> describe hardware and provide rationale why this is suitable for
> >> bindings (also cannot be deduced from compatible).
> >>
> >>
> > 
> > Hi,
> > 
> > I'm sorry I didn't describe it in dt-bindings patches.
> > It's described in cover-letter and other patches except in dt-bindings.
> > I will add it in next submission.
> > 
> > I've found out the limitation of Synopsys dwc3 controller. This can work
> > on Host mode using xHCI. A Register related to ERST should be written
> > high-low order not low-high order. Registers are always written low-high order
> > following xHCI spec.(64-bit written is done in each 2 of 32-bit)
> > That's why new quirk is needed for workaround. This quirk is used not in
> > dwc3 controller itself, but passed to xhci quirk eventually. That's because
> > this issue occurs in Host mode using xHCI.
> > 
> 
> If there is only one register then you should just program it
> differently and it does not warrant quirk property.
> 

Could you tell me why you think it does not warrant? I think this is
good to use quirk.

Best Regards,
Jung Deahwan

> Best regards,
> Krzysztof
> 
> 

------pMGQB5Kx8CcFe4a2OrTD1laxas9T8E6znMm-R6uZIIDZNQ_y=_3b5a7_
Content-Type: text/plain; charset="utf-8"


------pMGQB5Kx8CcFe4a2OrTD1laxas9T8E6znMm-R6uZIIDZNQ_y=_3b5a7_--

