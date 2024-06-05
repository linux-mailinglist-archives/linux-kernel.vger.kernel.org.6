Return-Path: <linux-kernel+bounces-201655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9208FC169
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39695B26026
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850CA56470;
	Wed,  5 Jun 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TPEuragX"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127F1EA90
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552181; cv=none; b=Nmq7Tl3dwoiVm4KaJXlnFVr0TjY/nDXnwkMbMd+ZZCJ+vOPOWZHGH469bh5XQzQZUKReZHR69Rlb67o2rHLVk91jtJvxUXgQDmuBdBM08iGf8bkj8W0hyBEMGMwQdCt765ZSdF8fsIcbenxpT7VOdKNRlo5HoWAhu3IZdtbc91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552181; c=relaxed/simple;
	bh=54xGD9mwhdTUfJvhlirOvqh8dGVz6PFWwFl4GPdlsSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=IoiPj9pzKr5xPkzS53kOAiQZn/gA4t0qU7bX60VTcQj/Hi8E72dlYhx8ypDPudF+glLurVyV4z4dNDIdN3/I7xwpXfBfmXmgwGqoHrn3UtzeihYrr4K3Xj4anJMaedzPTQN9bvt4nhUihCMzFm1aK4J04wk8bW1VyVhI4pGGjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TPEuragX; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240605014937epoutp0320363452d45d69f81af161dc42de154a~V_JsFgVdB0587905879epoutp03j
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:49:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240605014937epoutp0320363452d45d69f81af161dc42de154a~V_JsFgVdB0587905879epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717552177;
	bh=F5s/37u811Q469zE6i98obPqxxD2mwwdYws0s56w6D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TPEuragX9kWStU3D4c85z2qDNv2rdnUStKqfRm6gt9qUd77R1DzgcIwx33dVbdCzS
	 o8M/JVlthRBz6k8ntdS5sKGQbA6rynFzz85wgzYzxFx3MnwVtPecDJIXjC7vp+js3G
	 ZDbbrWCulbAqr390omyEM1zZ868NzITsMflFGsTE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240605014937epcas2p220b03702a6f5c1b65e5c3bb229553cb1~V_Jrh4nE12571225712epcas2p21;
	Wed,  5 Jun 2024 01:49:37 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vv9PX4QjZz4x9Pp; Wed,  5 Jun
	2024 01:49:36 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.45.09479.034CF566; Wed,  5 Jun 2024 10:49:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240605014936epcas2p2aef39bb60589271af07737a1059d3d4c~V_JqwN-wm0462504625epcas2p2N;
	Wed,  5 Jun 2024 01:49:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240605014936epsmtrp157818f9a5c878445047e778261e221a3~V_JqvgBl42315723157epsmtrp1Y;
	Wed,  5 Jun 2024 01:49:36 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-32-665fc4309100
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.1B.08336.F24CF566; Wed,  5 Jun 2024 10:49:36 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240605014935epsmtip10c11447db649ccb708543d313fa09d5c~V_JqgYdri2617126171epsmtip1d;
	Wed,  5 Jun 2024 01:49:35 +0000 (GMT)
Date: Wed, 5 Jun 2024 10:50:10 +0900
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
Message-ID: <20240605015010.GA57120@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1935a30f-b4fd-4240-93f0-e2baf218223d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmua7Bkfg0g46TShbH2p6wW6zZe47J
	Yv6Rc6wWzYvXs1m8nHWPzeL8+Q3sFpd3zWGzWLSsldmiedMUVov/e3awW6xacIDdgdtj8Z6X
	TB6bVnWyeeyfu4bdY8v+z4wenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
	WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
	L9ArTswtLs1L18tLLbEyNDAwMgUqTMjOONY3lb2gnadiy7QmlgbGV5xdjBwcEgImEn9+Sncx
	cnEICexglJjxcj47hPOJUeJ68zc2COcbo8Tqj1fYYTpuTdOBiO9llNg1+T4rhPOEUWLzj3OM
	XYycHCwCKhIfj4E0cHKwCWhJ3PtxghnEFhHQlLj+9ztYA7PAHWaJSetOsIEkhAViJT7emQlW
	xCugLfF0w0tWCFtQ4uTMJywgNqeAncTUht1sIFeIAi14dbAeJCwhMJNDYv0SSQjbReL5mY9M
	ELawxKvjW9ghbCmJl/1tUHaxxK3nz5hBbpAQaGGUWPGqhRkiYSwx61k72APMAhkST+7NZ4L4
	WFniyC0WiDCfRMfhv9CA4JXoaBOC6FSWmH55AiuELSlx8PU5qIkeEpeuz4YG4nZmiVsnl7BP
	YJSfheSzWUi2Qdg6Egt2f2KbBbSCWUBaYvk/DghTU2L9Lv0FjKyrGMVSC4pz01OLjQpM4HGd
	nJ+7iRGcaLU8djDOfvtB7xAjEwfjIUYJDmYlEV6/4vg0Id6UxMqq1KL8+KLSnNTiQ4ymwHia
	yCwlmpwPTPV5JfGGJpYGJmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwubma
	SFktXeuw69zUJ/M2zf5+Z+/Vm0vEZ8U6zZBgTW6cbB33tc5LYPHBR0JvZrpkG7Dobpv9c8nH
	SQp3lTX1n51Zzh/YuFLjA+/evK/cu9j1NSy/zK0w9l2gYPV8+XWZo5NftG9Pvrh+0wbTVacU
	jqbL+uRs6z71w0j4jPd9lVcXbslwRp+Kvz9v2cIal3/TzF382p5NOT8nR/W2seyhl2eXN6j8
	m/IyoznX/Ll65G/OtJspx9W92o3YmH0S816752hNuXxrDofM6Ydnz779zKV+wG7RmhUvwy71
	3KqYLTzPQGXGs5utkhfPW15bx/b5k2e9Nt8vOftU6+cW5s/VEh3OTbvOb83rWvc0iY/X/4gS
	S3FGoqEWc1FxIgCYDzEjPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK7Bkfg0g//rGC2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4MrY+2Myc8FxzoqL93eyNDAe
	Zu9i5OCQEDCRuDVNp4uRi0NIYDejxKnDC1i7GDmB4pISS+feYIewhSXutxxhhSh6xChx9NhP
	NpAEi4CKxMdjV8CK2AS0JO79OMEMYosIaEpc//sdrIFZ4BGzxPQXT8AahAViJT7emQlWxCug
	LfF0w0uoqduZJWbvWsUCkRCUODnzCZjNDDT1xr+XTCCnMgtISyz/xwES5hSwk5jasJsNJCwK
	dMSrg/UTGAVnIWmehaR5FkLzAkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGi
	pbmDcfuqD3qHGJk4GA8xSnAwK4nw+hXHpwnxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIk
	kJ5YkpqdmlqQWgSTZeLglGpgqnl/w7fGNSk4WfCna3niGxbHcyq+71/onzdvn74ofMPKW6ty
	+S26WeJrvrywyudY+UNa8s8Jm1mxdqLXOsS3WdrqSWUWOQZJLvz8SEQ4Jdl/8fY5v+9XfzMS
	WPXsfnWLjVByOsuignmBsf+CHb98ecr1xnrei7N9eat1Aqbll567qX43gz1r0Zc31e3bV8+/
	dMH0nNFq79NyrMufnfe/X7Ao9Ge028KWM1XPYpKMr6bPzrrT4PPuNfNjX04bx/r0xwVa80T5
	b8qt+KF7X9df8bi9YGb9nsVX51n89jli8mif3tt/b3ukVsQcrNdR6LqrHZ93SU9r5cT1muFP
	z+oXrg1X8HFd+N/8mNaDVYJXlViKMxINtZiLihMBf3VjTQQDAAA=
X-CMS-MailID: 20240605014936epcas2p2aef39bb60589271af07737a1059d3d4c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_4fd93_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060731epcas2p4f14afae9f00a7e71e6bd3863f0a51441@epcas2p4.samsung.com>
	<1717135657-120818-6-git-send-email-dh10.jung@samsung.com>
	<9c9d74c0-72a2-418a-b3c6-a0f9716c943d@kernel.org>
	<20240603034435.GC23593@ubuntu>
	<eb1d9734-fa19-4051-9e78-a6e72ac12662@kernel.org>
	<20240603085111.GF23593@ubuntu>
	<1935a30f-b4fd-4240-93f0-e2baf218223d@kernel.org>

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_4fd93_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jun 04, 2024 at 08:20:44AM +0200, Krzysztof Kozlowski wrote:
> On 03/06/2024 10:51, Jung Daehwan wrote:
> >>>>>  
> >>>>> +		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
> >>>>> +			xhci->quirks |= XHCI_WRITE_64_HI_LO;
> >>>>
> >>>> Where is any user of this property (DTS)? Just to clarify: your
> >>>> downstream does not matter really.
> >>>>
> >>>
> >>> This is set by dwc3 parent node by software node.
> >>>
> >>> [PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add 'snps,xhci-write-64-hi-lo-quirk' quirk
> >>> https://lore.kernel.org/r/1717135657-120818-2-git-send-email-dh10.jung@samsung.com/
> >>
> >> This is not a patch to DTS.
> >>
> >>
> > 
> > This is set by software node from dwc3. That's why I think this patch doesn't
> > need DTS patch. I would add DTS patch in dwc3 not xhci if it's needed.
> > 
> 
> What?
> 
> I asked you question which upstream SoC (link to DTS) uses it, and you
> say that "no need for DTS patch"? That's not an answer.
> 
> Best regards,
> Krzysztof
> 
> 

I'm sorry I didn't get your point. I've been working on Exynos SoC.
But there's no upstream user of this property yet in this patchset.

Best Regards,
Jung Daehwan

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_4fd93_
Content-Type: text/plain; charset="utf-8"


------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_4fd93_--

