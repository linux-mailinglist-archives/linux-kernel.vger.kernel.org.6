Return-Path: <linux-kernel+bounces-198563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742B8D7A58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A741F2166C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E9F4FC;
	Mon,  3 Jun 2024 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qE692qp5"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B2CA7D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383775; cv=none; b=c7jM61zNyoJkDdmQvEaWO7gKJuDAqAkAhn8dgsMV6ZMWbu8dHGLJZALG3UEJudHLiuYpBWQrg1nEHYutSUpftqhcJ0/AdfKi4InbVaICrUOdz5jbqgoPXH1HoDk9y1BPRD3biVyWQ/dHi7kqXj0B8UskWxEbQRAjEe2iRNv24rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383775; c=relaxed/simple;
	bh=vwVBCpX/FGg3PfaBO0k1Rrx6BR58RpWVDue+Wtv72iM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Wckn6WJ/RSDVL3ePGjDcIRUGzAI0GYANkNUH/T1YFliCg7b2NovB8PZ49U/LJiK4NfhiQ4+1JOTBgRNsl025gtFPj+6rmg52x55hnfv13IWAL0nBYckadGHw4WpzevROWHA3ekfYUqhjFC5VgTtb/DwU+bRWdr6vim/T+cvLSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qE692qp5; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240603030245epoutp03864e8e8c941fe331c78dbae5f576132c~VX2_RPY2u0705507055epoutp03Z
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:02:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240603030245epoutp03864e8e8c941fe331c78dbae5f576132c~VX2_RPY2u0705507055epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717383765;
	bh=yK3jZ1lFIlSjHLzlsiqveDzMQX7tRJzrC//UtMKk/XM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qE692qp5FBH4Efpx9UDxyAKk30uphGAKDEuY87V5CZXJjKVs3HTr7xlSngYJO1RRh
	 qf9kNH9Lpxsds72aYaqHUvYTylJ/rFdv5PKWbTHTXB1CkVqH8ynMGGDTSopnOvOeCW
	 6QRQPRMFuud7BndAZpTZBBuvhlwUlMwbCv6N8TfM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240603030244epcas2p324a0b3f1044706420d7c96cba5066b1e~VX29mm9Vi3054930549epcas2p3D;
	Mon,  3 Jun 2024 03:02:44 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.98]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vsz6r2rtxz4x9Ps; Mon,  3 Jun
	2024 03:02:44 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.5C.08613.4523D566; Mon,  3 Jun 2024 12:02:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240603030244epcas2p47cc72b4243f0194b42115e54affe0b5b~VX28yFCXH1328313283epcas2p4k;
	Mon,  3 Jun 2024 03:02:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240603030244epsmtrp1722f2265e8d92a321dddb0543e208a8d~VX28xTb5V1562215622epsmtrp1W;
	Mon,  3 Jun 2024 03:02:44 +0000 (GMT)
X-AuditID: b6c32a43-af7ff700000021a5-48-665d32548095
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.54.18846.3523D566; Mon,  3 Jun 2024 12:02:44 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603030243epsmtip2da4b384bf41932d59d6bdfc2f88061c8~VX28nFVST0472404724epsmtip2d;
	Mon,  3 Jun 2024 03:02:43 +0000 (GMT)
Date: Mon, 3 Jun 2024 12:03:16 +0900
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
Message-ID: <20240603030316.GA23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57966949-8080-4aa5-8d38-63ded1c2b467@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhW6IUWyawbaVwhbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
	WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
	L9ArTswtLs1L18tLLbEyNDAwMgUqTMjOuD6hl6VgAX/F8y1GDYxHeLoYOTkkBEwkXj5fy9zF
	yMUhJLCDUWL/l+WsIAkhgU+MEkd/VkMkgOzFy54wwXS8PvMLqmMno8STh7NYIZwnjBIrL3xn
	A6liEVCR6D+9gx3EZhPQkrj34wQziC0ioClx/e93sAZmgTvMEpPWnQBrEBZIlXh9rBtsBa+A
	tsTjvbvZIGxBiZMzn7CA2JwCdhJHVtxg7GLk4BAFWvDqYD3IHAmBiRwST17MZQWJSwi4SJz+
	xApxqbDEq+Nb2CFsKYmX/W1QdrHErefPmCF6WxglVrxqYYZIGEvMetbOCGIzC2RIzNjYzQwx
	U1niyC0WiDCfRMfhv+wQYV6JjjYhiE5liemXJ0CtlZQ4+Poc1EQPiSWHV7JBwqebSeLh8jWM
	ExjlZyH5bBaSbRC2jsSC3Z/YZgGtYBaQllj+jwPC1JRYv0t/ASPrKkax1ILi3PTUZKMCQ3hc
	J+fnbmIEJ1ot5x2MV+b/0zvEyMTBeIhRgoNZSYS3ry46TYg3JbGyKrUoP76oNCe1+BCjKTCe
	JjJLiSbnA1N9Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTJOb
	fFb+m7klbgaTv3rdxnrLv1uyPrJ8fC5+I+VcQpyPyD2n+7+Pi5TezDz2/3yE/s5zyTU5MYkG
	rh88ooJ3TJJR4Dr+Y927JZs29cs9ObglXG/nvVLjoPkfgm6ZNy9atnxjfPWFPTllcnz+GjMm
	FdRMnD6zpvhkxV6vO/sm399zP+5+50FTNuNixocMyve4N2+sVl9V7OfNmLzgaKqvejtPqmxA
	0sYv2xhXO7rc4dF9ssJX4m3TNd0qkT3OezYE9t4Wz6vcOJehdmr6qbscnVvirk3YcP8Ez2zN
	KM539krzKtwt7Wp9ejZtYL6syRy30PO1gJjGsfPates7pb97nTdN5fvz6Ivy4Y41/ef28Smx
	FGckGmoxFxUnAgC2n23rPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvG6IUWyaQftKRotjbU/YLdbsPcdk
	Mf/IOVaL5sXr2SxezrrHZnH+/AZ2i8u75rBZLFrWymzRvGkKq8X/PTvYLVYtOMDuwO2xeM9L
	Jo9NqzrZPPbPXcPusWX/Z0aPz5vkAlijuGxSUnMyy1KL9O0SuDK+Pl/DVPCAp+JvR3QD41yu
	LkZODgkBE4nXZ34xdzFycQgJbGeU2LZoDhNEQlJi6dwb7BC2sMT9liOsEEWPGCXmtl5hBkmw
	CKhI9J/eAVbEJqAlce/HCbC4iICmxPW/38EamAUeMUtMf/GEDSQhLJAq8fpYN9gGXgFticd7
	d7NBTO1mkvj7+i4rREJQ4uTMJywgNjPQ1Bv/XgI1cADZ0hLL/3GAhDkF7CSOrLjBCBIWBTri
	1cH6CYyCs5A0z0LSPAuheQEj8ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4BjRCtrBuGz9
	X71DjEwcjIcYJTiYlUR4++qi04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGan
	phakFsFkmTg4pRqYsm5nr7sT0Pu4uEpIu5nr56fX/yQS0s6HN61Jkn5mKHlrX6eVfGbn7EOT
	7kxVY9/P0Or3Lj/3Jfvka42C7bqrryidvXInUOGpGzNvyg8p7VK19z8SS2YnRS53/L1MUYDb
	SEry1NLE1F3nv73lW+kkc+O08yTlO33ZzGnbko9GTfTKnHD1LcecD5qnpULvXbHafumrdsPH
	v6K6La23LyWIPCuc5PXTpiNi3v7Vuzo/iq8qyVq7eH9aPZOah9rbmQfz4vm+iksm25zrb5yX
	eij5srff9sfP7vreU3jVtfOS+rVHfRZpa5/PuOt3qtzrSOekrxMD70XO+X3spVsy3/V3ugfd
	e4SexUlONe+5mW67QYmlOCPRUIu5qDgRABfQEQ4AAwAA
X-CMS-MailID: 20240603030244epcas2p47cc72b4243f0194b42115e54affe0b5b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_372cf_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060728epcas2p358edd115ee217a50712f1ca3b3b22bd7@epcas2p3.samsung.com>
	<1717135657-120818-2-git-send-email-dh10.jung@samsung.com>
	<57966949-8080-4aa5-8d38-63ded1c2b467@kernel.org>

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_372cf_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, May 31, 2024 at 10:10:30AM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2024 08:07, Daehwan Jung wrote:
> > Add a new quirk for dwc3 core to support writing high-low order.
> 
> This does not tell me more. Could be OS property as well... please
> describe hardware and provide rationale why this is suitable for
> bindings (also cannot be deduced from compatible).
> 
> 

Hi,

I'm sorry I didn't describe it in dt-bindings patches.
It's described in cover-letter and other patches except in dt-bindings.
I will add it in next submission.

I've found out the limitation of Synopsys dwc3 controller. This can work
on Host mode using xHCI. A Register related to ERST should be written
high-low order not low-high order. Registers are always written low-high order
following xHCI spec.(64-bit written is done in each 2 of 32-bit)
That's why new quirk is needed for workaround. This quirk is used not in
dwc3 controller itself, but passed to xhci quirk eventually. That's because
this issue occurs in Host mode using xHCI.

Below are answers from Synopsys support center.

[Synopsys]- The host controller was design to support ERST setting
during the RUN state. But since there is a limitation in controller
in supporting separate ERSTBA_HI and ERSTBA_LO programming,
It is supported when the ERSTBA is programmed in 64bit,
or in 32 bit mode ERSTBA_HI before ERSTBA_LO

[Synopsys]- The internal initialization of event ring fetches
the "Event Ring Segment Table Entry" based on the indication of
ERSTBA_LO written.

Best Regards,
Jung Daehwan

> 
> Best regards,
> Krzysztof
> 
> 
> 

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_372cf_
Content-Type: text/plain; charset="utf-8"


------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_372cf_--

