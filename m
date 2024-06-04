Return-Path: <linux-kernel+bounces-199943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87648FA7FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE2B1F2723B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350FA13D504;
	Tue,  4 Jun 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Th53HUJy"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E813D62E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466332; cv=none; b=DpX/nMnQIcGhGxgh4/Ai7byr+ilhNanwE8e+AZqGIH+eumyks1xv3Z6FCTztu4xlrc0R1a5Hfct2jXliJAYFzS+0inlrbLmTrC0+ql2nP5Omai/t8jTKwvixKGOfIz6WcG6GnGQtLyqklWbaorZWRN75FYMh8fb5URIBhq0CTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466332; c=relaxed/simple;
	bh=rgMCn6lMtYT3C6MH4IXwlBWYt7HZx/BGAC7eWAk9iGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JQtP1mSPWoeeYlO33zCG7ScHK0bcb+/4GE58U3/Fkvtj4LZmx6NOo4Lv8CmlfHggQxABS05tMOYMRaFownJg8cGGF7n6AYKwZGZSg6c9yL+25du4Uxvbno8ahVX0f29XbJ/WZtyoIELBpjOEMVuGkCz4FUQjmnOBn1a8JjaUiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Th53HUJy; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240604015843epoutp04c44123050bf6e80f571419387d82a5d8~VqoWHAzVv2495224952epoutp04D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240604015843epoutp04c44123050bf6e80f571419387d82a5d8~VqoWHAzVv2495224952epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717466323;
	bh=ULzoNe3gq/jqt0kCQiGI47UROKcm+zVrZOwhKuLBnN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Th53HUJyIOgsBUZrHYrAM7ThiUo91hHeKPtkulUZlxN1tk+jN4hPHbJy10mk1Sa9P
	 cUq0VIN0pCqBswFsZUY7T/VTxYyUzP8Cg7MphNKCZ8PhyH3OrkKwZA4utskhWaKUbw
	 G43OC3+X1Qe4owO/avc+kpv8HtEhNQQ8mBnWgXlg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240604015843epcas2p28a1c7b793ed977e44c33729dbabc796e~VqoVxzLqt0577505775epcas2p2R;
	Tue,  4 Jun 2024 01:58:43 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VtYfV2wy6z4x9QB; Tue,  4 Jun
	2024 01:58:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	5E.C7.09485.2D47E566; Tue,  4 Jun 2024 10:58:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240604015841epcas2p3c21e0326a40e9d82e6b82d6cb2b8748f~VqoUyggJ00103001030epcas2p3a;
	Tue,  4 Jun 2024 01:58:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240604015841epsmtrp1ac43e0d3cfcfc3ca01b5f7a14111cbbe~VqoUxmMG71914419144epsmtrp1f;
	Tue,  4 Jun 2024 01:58:41 +0000 (GMT)
X-AuditID: b6c32a46-f3bff7000000250d-6f-665e74d21c1a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.34.07412.1D47E566; Tue,  4 Jun 2024 10:58:41 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240604015841epsmtip174006edde616e8b12616da7f8f76e792~VqoUku_Fn1932519325epsmtip1i;
	Tue,  4 Jun 2024 01:58:41 +0000 (GMT)
Date: Tue, 4 Jun 2024 10:59:15 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, Felipe Balbi
	<balbi@kernel.org>, "open list:USB  SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND  FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] usb: dwc3: Support quirk for writing high-low
 order
Message-ID: <20240604015900.GA49465@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240604001619.nflngpnm6zu6nwnl@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmhe6lkrg0g10TRC2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8XlXXPYLBYta2W2aN40hdXi/54d7BarFhxgd+DyWLznJZPHplWd
	bB77565h99iy/zOjx+dNcgGsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
	eYm5qbZKLj4Bum6ZOUBXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNz
	i0vz0vXyUkusDA0MjEyBChOyM+acvshUcEe24lDvHLYGxgkSXYycHBICJhKfjrxg7WLk4hAS
	2MEocf59MzOE84lR4s/ZRkYI5xujxKt7q5i6GDnAWhbstoOI72WUOPzlEVTHE0aJRac+ghWx
	CKhIPJ0oArKCTUBL4t6PE8wgtoiAjsSBE+eZQOqZBTYxSzxtX8QKkhAWCJRY//0sO4jNK6At
	8eFrLxOELShxcuYTFpCZnALWEo+XcIGYokDjXx2sBxkjITCVQ+Ld0U9MEO+4SCxduQ7KFpZ4
	dXwLO4QtJfGyvw3KLpa49fwZM0RzC6PEilctzBAJY4lZz9oZQWxmgQyJ7Qt62CAeVpY4cosF
	Iswn0XH4LztEmFeio00IolNZYvrlCawQtqTEwdfnoCZ6SFycNIkJEjwdTBLLHi9nncAoPwvJ
	Z7OQbIOwdYDB+wnI5gCypSWW/+OAMDUl1u/SX8DIuopRLLWgODc9tdiowAge18n5uZsYwelV
	y20H45S3H/QOMTJxMB5ilOBgVhLh7auLThPiTUmsrEotyo8vKs1JLT7EaAqMponMUqLJ+cAE
	n1cSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA5P8Bi4he/d7JutW
	958ynHhDQ8km2a782dOa+CumKd+t1M8vdDW6H5X71GjV4xfVK/f80vVKffn70c4WpvsKutqr
	ardtiVE/nr6t3Hnn0t5te59EPL69YeJRiX1Wv0OXOz9/xqRoPHf57v3NDK83rVuhlyopOX1x
	5t/Uk2s05C4Wi8eclXyw9V4/f7PT3Iidv5ij9Pl3ab6/dq36qU9/rS4bZ8Gj3xvTclSsWd88
	Zag4vGBNd+dc8a7UJyI2650vhc1qSIgW7phwVT9ILfv2DleHx3t6+zqWBK7eXGG6cNvReHYd
	zv7o7ZduZRWtu9qm+tNjcVH6lgwVD4uzO55YONzP/L6FW6Lgz42S00Flu2yVWIozEg21mIuK
	EwF/1tinOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO7Fkrg0g3srjS2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8XlXXPYLBYta2W2aN40hdXi/54d7BarFhxgd+DyWLznJZPHplWd
	bB77565h99iy/zOjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ3VOvsRbMka54tbmVtYHxpWgXIweH
	hICJxILddl2MXBxCArsZJX5+fsLYxcgJFJeUWDr3BjuELSxxv+UIK4gtJPCIUeLHfyaQXhYB
	FYmnE0VAwmwCWhL3fpxgBrFFBHQkDpw4zwQyk1lgB7PEk4P3wGYKCwRKrP9+Fmwmr4C2xIev
	vUwQizuYJPadaWOBSAhKnJz5BMxmBpp6499LsGXMAtISy/9xgJicAtYSj5dwgZiiQCe8Olg/
	gVFwFpLeWUh6ZyH0LmBkXsUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERwbWho7GO/N
	/6d3iJGJg/EQowQHs5IIb19ddJoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1Kz
	U1MLUotgskwcnFINTNLn7/LPnvGEwdvcMKzw46ZUjfQd9j6PF6dX3LrSsi/00fmfE1RPhGqY
	xxy20n63/vek8/OFTlUUKr5YmvCUMSd3eqRcr2+W6IYbmeXtk0qn/t6adep427dURW2jnxn6
	qd5BU998Lyu517lYL2S5Ct/c46sftK1ZY8KsUrz94JM7L37L7DtQd4EtjCv7yyNupeYXlj92
	rqs6vfvS40UffQp/bnnh6H4v9Prjn6Gzt0+IOCRywv/r/g+6G8qTva0lt03pUcprFeu0WpRa
	4Lc1/8OWI9O1zt1MMuiJrNHYIxi2vGnHSv6CTwFWeY5LfO8GbV69aVLJxtnrXlxxkv/P2Wl3
	vT6rIZ/1K1dY3HbfrktKLMUZiYZazEXFiQDRPowS/AIAAA==
X-CMS-MailID: 20240604015841epcas2p3c21e0326a40e9d82e6b82d6cb2b8748f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_43222_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b
References: <1717135657-120818-1-git-send-email-dh10.jung@samsung.com>
	<CGME20240531060729epcas2p2d895a441b017f1797b1bc1e2558d9e1b@epcas2p2.samsung.com>
	<1717135657-120818-3-git-send-email-dh10.jung@samsung.com>
	<20240604001619.nflngpnm6zu6nwnl@synopsys.com>

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_43222_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jun 04, 2024 at 12:16:33AM +0000, Thinh Nguyen wrote:
> On Fri, May 31, 2024, Daehwan Jung wrote:
> > Set xhci "write-64-hi-lo-quirk" property via
> > "snps,xhci-write-64-hi-lo-quirk" property.
> 
> Please describe the change as if the reader has no context of the other
> patches in the series.
> 
Thanks for the comment. I will add it in next submission.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> 
> Please provide change note for v2.
I will do it.
> 
> >  drivers/usb/dwc3/core.c | 3 +++
> >  drivers/usb/dwc3/core.h | 2 ++
> >  drivers/usb/dwc3/host.c | 5 ++++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 7ee61a8..89985fd 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1716,6 +1716,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
> >  	dwc->dis_split_quirk = device_property_read_bool(dev,
> >  				"snps,dis-split-quirk");
> >  
> > +	dwc->xhci_write_64_hi_lo_quirk = device_property_read_bool(dev,
> > +				"snps,xhci-write-64-hi-lo-quirk");
> > +
> >  	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
> >  	dwc->tx_de_emphasis = tx_de_emphasis;
> >  
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 3781c73..ab5913c 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1142,6 +1142,7 @@ struct dwc3_scratchpad_array {
> >   *	3	- Reserved
> >   * @dis_metastability_quirk: set to disable metastability quirk.
> >   * @dis_split_quirk: set to disable split boundary.
> > + * @xhci_write_64_hi_lo_quirk: set if we enable quirk for writing in high-low order.
> 
> The description should be more detail here. But I don't think we need
> this. Just pass the PROPERTY_ENTRY_BOOL("write-64-hi-lo-quirk") to xhci
> platform unconditionally. This should apply to all released versions (at
> the moment) of DWC_usb3x.
> 
I got it. If so, I also think it's not needed. I will remove this.
> >   * @sys_wakeup: set if the device may do system wakeup.
> >   * @wakeup_configured: set if the device is configured for remote wakeup.
> >   * @suspended: set to track suspend event due to U3/L2.
> > @@ -1369,6 +1370,7 @@ struct dwc3 {
> >  	unsigned		dis_metastability_quirk:1;
> >  
> >  	unsigned		dis_split_quirk:1;
> > +	unsigned		xhci_write_64_hi_lo_quirk:1;
> >  	unsigned		async_callbacks:1;
> >  	unsigned		sys_wakeup:1;
> >  	unsigned		wakeup_configured:1;
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > index a171b27..8cc0def 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
> >  
> >  int dwc3_host_init(struct dwc3 *dwc)
> >  {
> > -	struct property_entry	props[5];
> > +	struct property_entry	props[6];
> >  	struct platform_device	*xhci;
> >  	int			ret, irq;
> >  	int			prop_idx = 0;
> > @@ -162,6 +162,9 @@ int dwc3_host_init(struct dwc3 *dwc)
> >  
> >  	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
> >  
> > +	if (dwc->xhci_write_64_hi_lo_quirk)
> > +		props[prop_idx++] = PROPERTY_ENTRY_BOOL("write-64-hi-lo-quirk");
> > +
> >  	if (dwc->usb3_lpm_capable)
> >  		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
> >  
> > -- 
> > 2.7.4
> > 
> 
Best Regards,
Jung Daehwan
> Thanks,
> Thinh

------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_43222_
Content-Type: text/plain; charset="utf-8"


------NM.SL-8AX4fCWwUaz12YupYcgI_4q5PcTQ1CNbbJhqicWcnv=_43222_--

