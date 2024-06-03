Return-Path: <linux-kernel+bounces-198578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216888D7A80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818352810CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E3EAD7;
	Mon,  3 Jun 2024 03:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KnOVMahQ"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401A631
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717386245; cv=none; b=ANgvPQp5bZdZo/OotEZmu6R9AdCq6haJ1tz2g00kLVDjUjPjb57tVK/bCAymxoVm7ueL6UgWAzQUrbeGqgA16BC5ovZenkxflsn6cR5XRi2TgCnK0QigFbVwxS5iFASgvo5/Mg9cM4H+0IIm6E79fbZ2y7xG9ht9oUzwF+MLYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717386245; c=relaxed/simple;
	bh=CTTiIGRwq0Vgd2Pg2kLvPB+WD6kCgwVfMNuTFJd5a90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=AoZUbkQTEeDb+8rQvtJilQVpHFFAozPSeBQm1TBXXCJEwhI2TIcaHZOzEcVFV0bEi8GN69rrqhwpb/P7NXisT3Gt8gvaz8emV7NgcCze3XPQR4zLxIjE8G5i8xgCW/+ZBBSVwbpsV1VP0G8tcyG6bmFZAzdi7mpAvKSce+3UKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KnOVMahQ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240603034401epoutp010a848253a066003b4de0a16265ac47dd~VYbAX2M9k1405314053epoutp019
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:44:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240603034401epoutp010a848253a066003b4de0a16265ac47dd~VYbAX2M9k1405314053epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717386241;
	bh=5NRjs4RhuxoBELCEZk64LegBIKhlKW9kwzOVWgcQuxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KnOVMahQpv0k2Snx9acISYU6wUBBc3RWS4LEqjUG3fyBwj0q4htp6VYRdhVAwFuk1
	 IPrUj6oHTNlywEiZMVGN49VxrnJyp3Aaj/ASHLs7PJyvpSvu+ra8uDHCgWD2PO+/A4
	 FdP+/oaJ+zl+DqiJ7P2cc0ahmogJng+zJAYpMfps=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240603034401epcas2p378493b11f6c4504282b1df16cdbb82cb~VYa-9HBE92491424914epcas2p3E;
	Mon,  3 Jun 2024 03:44:01 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vt02T0L0tz4x9Pv; Mon,  3 Jun
	2024 03:44:01 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.61.08613.00C3D566; Mon,  3 Jun 2024 12:44:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240603034400epcas2p3ee526cd508075ad4209539ae395ea91a~VYa-R-33x0546405464epcas2p3s;
	Mon,  3 Jun 2024 03:44:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240603034400epsmtrp12e0649f855faed71b12531121fcc5677~VYa-RQORp0644706447epsmtrp1B;
	Mon,  3 Jun 2024 03:44:00 +0000 (GMT)
X-AuditID: b6c32a43-38731a80000021a5-c3-665d3c00d945
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.46.08622.00C3D566; Mon,  3 Jun 2024 12:44:00 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603034400epsmtip1332d768cbfbfbb5d565933bed9ed5409~VYa-HeVQu0849108491epsmtip16;
	Mon,  3 Jun 2024 03:44:00 +0000 (GMT)
Date: Mon, 3 Jun 2024 12:44:35 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Mathias
	Nyman <mathias.nyman@intel.com>, Felipe Balbi <balbi@kernel.org>, "open
 list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] usb: host: xhci-plat: Add support for
 XHCI_WRITE_64_HI_LO_QUIRK
Message-ID: <20240603034435.GC23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c9d74c0-72a2-418a-b3c6-a0f9716c943d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmqS6DTWyawbX71hbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
	WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
	L9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmDWrna3gEU/Fy4O72BoYn3J1MXJySAiYSPTeOMEC
	YgsJ7GCUeP3Mp4uRC8j+xCjxZlkbI4TzjVFifv91FpiOZw1TWSESexkljix8zgThPGGUWLdz
	KztIFYuAikTjielgHWwCWhL3fpxgBrFFBDQlrv/9DtbNLHCHWWLSuhNsIAlhgViJj3dmAhVx
	cPAKaEssfV8OEuYVEJQ4OfMJ2BxOATuJcwvOg5WIAs1/dbAeZIyEwEwOiT2TDzBDXOcisezG
	BlYIW1ji1fEt7BC2lMTL/jYou1ji1vNnzBDNLYwSK161QDUbS8x61s4IYjMLZEg8vDuJFWSZ
	hICyxJFbLBBhPomOw3/ZIcK8Eh1tQhCdyhLTL0+AWispcfD1OaiJHhKXrs9mg4RPN5PEjGt/
	WCcwys9C8tosJNsgbB2JBbs/sc0CWsEsIC2x/B8HhKkpsX6X/gJG1lWMYqkFxbnpqclGBYbw
	yE7Oz93ECE61Ws47GK/M/6d3iJGJg/EQowQHs5IIb19ddJoQb0piZVVqUX58UWlOavEhRlNg
	PE1klhJNzgcm+7ySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KLYPqYODilGpj0
	d5VamKrUC1Y0zLaYvrLebJ7z98g7uavOmAYfe8fBfaqlaJ7Nzd5X//QNrnIotfz9ffThh60N
	qc/D+I9PiPbf0H/JU/Vq2DG7xqI/xb/8xPqN3tTNOm15ZhMPz+aP11e3/Cv5daGlRuLpjr47
	c0yEz0VY7nyZ+st4unfxLX6H0AWcwQktFatd87684Zn9yEcp63KdqvymtIzaAJFtz1LzTIyn
	x83V27fj/84ZlZzRL7SDRFt1BSK2qfSsT/z/YFKliODaHOYGh/9SZYcye9Z3XEpLcyk7cL43
	xn73zQPv2H/mftJpbct8Y2b1W/Lw/0PsXhceRLFtfPxVj3X18ZqeKoY9m1S+e/gG6x/aXaPE
	UpyRaKjFXFScCAC5nLzUPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnC6DTWyawaslqhbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGcdmkpOZklqUW6dslcGVM2rGDrWARV8WV1VsYGxj3
	cXQxcnJICJhIPGuYytrFyMUhJLCbUeLN3QusEAlJiaVzb7BD2MIS91uOQBU9YpRY0tsOlmAR
	UJFoPDGdBcRmE9CSuPfjBDOILSKgKXH973ewBmaBR8wS0188YQNJCAvESny8MxOoiIODV0Bb
	Yun7coih3UwS324cB2vmFRCUODnzCdhQZqChN/69ZAKpZxaQllj+D+xqTgE7iXMLzoONEQW6
	4dXB+gmMgrOQNM9C0jwLoXkBI/MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgWNHS
	2sG4Z9UHvUOMTByMhxglOJiVRHj76qLThHhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQ
	nliSmp2aWpBaBJNl4uCUamASmLnk+M2qSd+Z9v26XyU6S+DUY6mP9ZdttqyfkObdaSa9/7IB
	x8RX2ysb7xsuj426epWl7+vbmmOvI3h47yjx5/VY3r3q36golhpxb3rASm47/wdPLou9nrUy
	43BM7PagTPPDz4/Zt0451GRjtlqzRFfYtmHzx68MvLKik/35Bdq9eG/zvdTK7uQ2efBGsTVV
	q3PFVbXoyJ6f8d+eqF3MXbu0sunMkhazN08Fsz/sErypENvFU3cwyNCG9YRESvVR27kGd18c
	XtCYbWdyjO/cE4Wrh97kHdpq568XK75FV9W7/qjY1kcZbPXB34uebc43WtT4T9BtacWpF62n
	zQQdmk6fezZRasmnTbxrTnsqsRRnJBpqMRcVJwIAtMs/NwQDAAA=
X-CMS-MailID: 20240603034400epcas2p3ee526cd508075ad4209539ae395ea91a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_376ea_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441@epcas2p4.samsung.com>
	<1717135657-120818-6-git-send-email-dh10.jung@samsung.com>
	<9c9d74c0-72a2-418a-b3c6-a0f9716c943d@kernel.org>

------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_376ea_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, May 31, 2024 at 10:12:36AM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2024 08:07, Daehwan Jung wrote:
> > This is set by dwc3 parent node to support writing high-low order.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 3d071b8..31bdfa5 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -256,6 +256,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
> >  		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
> >  			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
> >  
> > +		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
> > +			xhci->quirks |= XHCI_WRITE_64_HI_LO;
> 
> Where is any user of this property (DTS)? Just to clarify: your
> downstream does not matter really.
> 

This is set by dwc3 parent node by software node.

[PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add 'snps,xhci-write-64-hi-lo-quirk' quirk
https://lore.kernel.org/r/1717135657-120818-2-git-send-email-dh10.jung@samsung.com/

Best Regards,
Jung Daehwan

> Best regards,
> Krzysztof
> 
> 

------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_376ea_
Content-Type: text/plain; charset="utf-8"


------GYrZwOZf271lb0asq-_m8oi27wabo7t24X0BK_QM5T4hVeLi=_376ea_--

