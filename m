Return-Path: <linux-kernel+bounces-199960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC978FA83B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B7C1F26453
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0A13D517;
	Tue,  4 Jun 2024 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o5rRVSVM"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBD2C861
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467545; cv=none; b=Fzk7VauVJ9KTwGQUQTbfEufCjRxc1Nd4KYOH/ceJpA1dqmMUPglOrro1FHuM8DaG0AqwJEQ3UDVP5eUfn5jzgEfSprkAY8FJeuV+U+M8xPD/vwtX/ZIN6IkxOaH0t/Tk7w9dcG5ZfRv+No2WHospS+Civ9UWRxYQ7x1EZnhW+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467545; c=relaxed/simple;
	bh=SQjBsq1pSDRa+92X8rsTn7sADmhW91X/pso6BF73AR8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=CN632Wsn/tnNhl7GP4IH2vBoihvIHRSJlodtwDxfSAmJTdS/pkSvhdLCistdpU1R7yKn43qWjfQDjDFePU105tmFMg/avwn1pI72tRpps9waPGVWtpHqoXDRmR5AqoHXtGoHWBly/d7hYuOrHOK0hm2rmXPAMgpWQODoAEIoLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o5rRVSVM; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240604021902epoutp04e7c4d6d6b210ad9dd6e571ae5c2dbc6a~Vq6FInHXB1337813378epoutp04M
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:19:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240604021902epoutp04e7c4d6d6b210ad9dd6e571ae5c2dbc6a~Vq6FInHXB1337813378epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717467542;
	bh=JrbYCyMWg5+SkRsH6d147/xUVTz498odRqOzgTstKfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5rRVSVMw+Ki3eiwwpt5EO6UBZgye6nuzLJAGvHz84fpUHt5bIW3nB8lAqMOGzqSp
	 HTzKfRXWgJE1ZvKmreYToUFlP5+rmPbekBLhoNOaJfY5gG1TjjNklmoqf8kxF4ahNg
	 QXrdS5tnvXKDg9oxz4hnEbFT3VKBPYWSyy9bZusk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240604021901epcas2p2b90b9ae5ce5cb136016f31ec5f38a043~Vq6ETaECa3090730907epcas2p2F;
	Tue,  4 Jun 2024 02:19:01 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VtZ5w6CCZz4x9Pv; Tue,  4 Jun
	2024 02:19:00 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.8A.09848.3997E566; Tue,  4 Jun 2024 11:18:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240604021859epcas2p47538af772afe3e57d25c1fde33fd28db~Vq6CYYfI60306903069epcas2p4w;
	Tue,  4 Jun 2024 02:18:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240604021859epsmtrp25dbcd778e59061ec44393ffe8b9027fd~Vq6CXfLDO0329303293epsmtrp2A;
	Tue,  4 Jun 2024 02:18:59 +0000 (GMT)
X-AuditID: b6c32a45-447fe70000002678-6b-665e7993479e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.16.08622.2997E566; Tue,  4 Jun 2024 11:18:59 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240604021858epsmtip26dff3dc71f3ee0c68295f92acf988b69~Vq6CLPIaz2236722367epsmtip2N;
	Tue,  4 Jun 2024 02:18:58 +0000 (GMT)
Date: Tue, 4 Jun 2024 11:19:35 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
	Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, "open
 list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: xhci: Add
 'write-64-hi-lo-quirk' quirk
Message-ID: <20240604021935.GB49465@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240604003013.2jwskwiqivgumrsx@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmme7kyrg0g233dSyOtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	XqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8f/4QsaCtxwVrZOvMjUwLmDvYuTkkBAwkeja85Kl
	i5GLQ0hgB6PE3d89TBDOJ0aJ9nnvGSGcb4wSLZsOMsG0nDqxD6plL6PEhTuToVqeMEpMbXkO
	NphFQEXi0awFjCA2m4CWxL0fJ5hBbBEBHYkDJ86DNTAL3GSW2P29HWyssECYxMLTt1i7GDk4
	eAW0JY62R4KEeQUEJU7OfMICYnMKWEtcX/STBaREFGj+q4P1IGMkBGZySDz4P50N4joXibkr
	uqBsYYlXx7dAPSol8fndXqh4scSt58+YIZpbGCVWvGphhkgYS8x61g52NLNAhsS95vVgyyQE
	lCWO3GKBCPNJdBz+yw4R5pXoaBOC6FSWmH55AiuELSlx8PU5qIkeEs2bGqCBtYVZ4vbLRSwT
	GOVnIXltFpJtELaOxILdn9hmAa1gFpCWWP6PA8LUlFi/S38BI+sqRrHUguLc9NRiowJDeGwn
	5+duYgQnWy3XHYyT337QO8TIxMF4iFGCg1lJhLevLjpNiDclsbIqtSg/vqg0J7X4EKMpMJ4m
	MkuJJucD031eSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MM+5f
	j006c/y4R6fA/1Pz3/A+UrW78JKzeKV87vl/3wMfbnx2vNvZ/Mx9/6MWM39N/3VW1b3ANNTr
	XOf6tlu5S97LFPhrl6qmhN7pZr1q/mr9g76u/YnyFxqu8sk9nTy19UuYrIbUCrbJ4dX+fb0L
	VdKe+Xntm2h2yKfmh3/Al2yRnYVvZe7OfuzIYXBUI/bRqXWZd/q8l9zq1cq0nrZW/VvR/hCj
	5TdlVu2ZsLA/Z/+/xtNu/fPX/88V4LE/r9NiveT2n5hzZ1V+XXU818R74ayP5woevolSh44x
	uHyqe2JjIZ7fXzzru0RIxbP5z+P/ihwrk7Ni1v4iy9e8PXJh//FbF9cvOC8q0p97dYr4YyWW
	4oxEQy3mouJEABPz5Nw/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO7kyrg0g/O3mSyOtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4MpY3rSQqWAtW8WTOUvZGxh/
	snQxcnJICJhInDqxD8jm4hAS2M0ocX1xAztEQlJi6dwbULawxP2WI6wQRY8YJSbdWMcIkmAR
	UJF4NGsBmM0moCVx78cJZhBbREBH4sCJ80wgDcwC95kl+hbNZQVJCAuESSw8fQvI5uDgFdCW
	ONoeCTF0C7PEn4l7wAbxCghKnJz5BOw8ZqChN/69ZAKpZxaQllj+jwMkzClgLXF9EcgHHByi
	QDe8Olg/gVFwFpLmWUiaZyE0L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwr
	Wlo7GPes+qB3iJGJg/EQowQHs5IIb19ddJoQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OE
	BNITS1KzU1MLUotgskwcnFINTJeNxWetd9QW7ZM4tFRXcZMTV8vBiT13ZuutfZ/sufrX1l85
	13uzHPf/v/Concn6e36HBb92RFAYQ5L9lFsdDfVcRVm6ZarFXOE5loVudettfBIqlj4rKr5h
	Uczc63v/t6K2NOt5N/nyI3++sRmyROdZ8ex9JFmktE15QWGaaPEUMe0Lf7NsKn/JWX75897H
	dOfrmr8uAREz94pFev0/9yn7H6frnMe8a7/wTtQ4vLfnBe8rK5O2F327A0M+sKbKfygP/ntm
	j4/hZvXUZrm5r7NjLr3Rtt+9+nj9bHepq/oHvkrZ27zaeeXm4x1a+pKHEg8Kzd/wb+8OJqnG
	cnWuDC+9Ofdal0SUT9JzNvijxFKckWioxVxUnAgA5x1zMQQDAAA=
X-CMS-MailID: 20240604021859epcas2p47538af772afe3e57d25c1fde33fd28db
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_436c4_"
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
	<20240603082538.GD23593@ubuntu>
	<20240604003013.2jwskwiqivgumrsx@synopsys.com>

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_436c4_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jun 04, 2024 at 12:30:32AM +0000, Thinh Nguyen wrote:
> On Mon, Jun 03, 2024, Jung Daehwan wrote:
> > 
> > This issue is not specific on SoC side but dwc3 controller. I think it's
> > better to add it to dwc3 directly but I can't find dts for dwc3. Dts for
> > SoC, which uses dwc3 would be needed in this case, right?
> > 
> 
> This quirk applies across different DWC_usb3x versions. IMO, you can
> just pass the xhci quirk flag along the dwc3_xhci_plat_quirk->quirks
> without needing to introduce a new xhci DTS binding. However, to do
> this, you should extract the xhci quirk flags to a separate header so
> that dwc3 can include and use them.
> 
> BR,
> Thinh

I haven't got using dwc3_xhci_plat_quirk. Let me try to use it.
Thanks for the comment.

Best Regards,
Jung Daehwan

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_436c4_
Content-Type: text/plain; charset="utf-8"


------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_436c4_--

