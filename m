Return-Path: <linux-kernel+bounces-198815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E88D7DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4631F255BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5276EEA;
	Mon,  3 Jun 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sy6zMox2"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B4C6BFA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404641; cv=none; b=hPwpGE8Jy9+VyGSH3A/Zic1eOcHXt6o4xuWmeul0hhTby6XKjTDETVPTdVv7MxkS9DfKkgeBq6WmdrrfuD5SGZAUkBDqxb2tsPVhKQjgo+tkVS1INcDs8Bae9Hy24lxbMkRLlq3JtEpxOuBpezryub9AMvhJF86zZDmCJ/Ip7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404641; c=relaxed/simple;
	bh=IQqnyaXr27D8iEHI83OZloKc/LvSJfx1rTCKgPLyL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=A0EgsfT8QKoVpRDPtIUkOf4jQbpQFFP2z9E820M6u5DT971bq+wAZObTb2T81WZulfZhuH+iQZoBVssLqtnjbKyGP48M8bFDI3rnVdzz4bn6bEWcuYvFzh5/Zns8CD5Y6Q3Chk7hT6U1Ks9S5jYJdSX7fnIWzNgeYYyFYmHKlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sy6zMox2; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240603085037epoutp0231e61c487db901780f2510fa98dcad3a~Vcmsyk0yl2956529565epoutp029
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:50:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240603085037epoutp0231e61c487db901780f2510fa98dcad3a~Vcmsyk0yl2956529565epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717404637;
	bh=7CaecCtDlW5kOsvhVVRXocMm0ooR9SmmgAcFqoXkcTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sy6zMox2SPwDLP/JPKwCd95EDGCDCLbYrGEVZSa4YW6sO41BAJfmnD/J0uT5a1wLL
	 O+7vRoc6Duz31co0qgXw07RuoHRNG3Cfe0y8cAjsmtZBj4ggLCZh5Kx/BqQOVBesle
	 IzeLcidVhog+geN4qN9nXy00RnP3/TdmR1TCrmHA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240603085037epcas2p13e036872c1de314d297e83587cab0d09~VcmsWbOlO0979009790epcas2p14;
	Mon,  3 Jun 2024 08:50:37 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Vt6rD5mTgz4x9Ps; Mon,  3 Jun
	2024 08:50:36 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	BE.EC.09479.CD38D566; Mon,  3 Jun 2024 17:50:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20240603085036epcas2p1fc4df4c804b3ce38dd5a09ac96a56924~VcmrrI27p1376813768epcas2p1X;
	Mon,  3 Jun 2024 08:50:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240603085036epsmtrp2520c78db3e0698f148723a5eb109187e~Vcmrqaekb2396223962epsmtrp2r;
	Mon,  3 Jun 2024 08:50:36 +0000 (GMT)
X-AuditID: b6c32a48-ea7ff70000002507-27-665d83dce810
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.AE.07412.CD38D566; Mon,  3 Jun 2024 17:50:36 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603085036epsmtip2cfe9bf8cc9160e24eb80b72d31a6287c~Vcmrej5fl2188021880epsmtip2A;
	Mon,  3 Jun 2024 08:50:36 +0000 (GMT)
Date: Mon, 3 Jun 2024 17:51:11 +0900
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
Message-ID: <20240603085111.GF23593@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eb1d9734-fa19-4051-9e78-a6e72ac12662@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmue6d5tg0g4tHtC2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	XqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsf7QFcaCu/wVf87FNzB283YxcnJICJhI7Pt/lq2L
	kYtDSGAHo8T1XZfYQRJCAp8YJb5u9YBIfGOU+P28kRmmY+aWjawQib2MEm/X7IZynjBKrDv0
	iQWkikVAReLygktgNpuAlsS9HyfAukUENCWu//0O1sAscIdZYtK6E2wgCWGBWImPd2aCFfEK
	aEssWfyMFcIWlDg58wnYIE4BO4nTGzqYuhg5OESBFrw6WA8yR0JgJodE36N3rBDnuUhMmfwU
	6lRhiVfHt7BD2FISn9/tZYOwiyVuPX/GDNHcwiix4lULVIOxxKxn7YwgNrNAhkTLgROsIMsk
	BJQljtxigQjzSXQc/ssOEeaV6GgTguhUlph+eQLUCZISB1+fg5roIXHp+mxo+D5kkph88RDL
	BEb5WUhem4VkG4StI7Fg9ye2WUArmAWkJZb/44AwNSXW79JfwMi6ilEstaA4Nz212KjABB7Z
	yfm5mxjBqVbLYwfj7Lcf9A4xMnEwHmKU4GBWEuHtq4tOE+JNSaysSi3Kjy8qzUktPsRoCoyo
	icxSosn5wGSfVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDk32S
	564qnv4mrm+f9tfLnAtOsnOZrH6lZ1uj9H+ZWP+cN1cmVj4Mfhub9Xvb9FMG917HCCrNlcx1
	O3PmJqv/xKuFKrzL+r/oV8ddLS39UREUzbnszyIZ6eU26yK/K351VVI/JM9qLdwQsu6j+P+8
	pDLPF6qquetXHih6MfnjYr6QKx/P1a/+cWu7t0pSnkxtRkXetOPHD71lUH/GtsqIQeHWq+Nx
	hvtlpvCtfDvZ5nSG3c0H/roB6fIy535wiy3benn/gerr7idepWx4yZlyg9P3y5WmrhsfW1fs
	qP7jb3w26PBU4xWv3ISdlt2ZsMb3X+wr7uRDqjy/VnvN3HHRVHDyTZ7AmXEFN5QKz+j3Viux
	FGckGmoxFxUnAgCyQ9rDPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvO6d5tg0g2nLRS2OtT1ht1iz9xyT
	xfwj51gtmhevZ7N4Oesem8X58xvYLS7vmsNmsWhZK7NF86YprBb/9+xgt1i14AC7A7fH4j0v
	mTw2repk89g/dw27x5b9nxk9Pm+SC2CN4rJJSc3JLEst0rdL4MrY8/MRc8Fc3or5m1awNTA+
	4epi5OSQEDCRmLllI2sXIxeHkMBuRokfL+8zQyQkJZbOvcEOYQtL3G85wgpiCwk8YpSY/r0O
	xGYRUJG4vOASC4jNJqAlce/HCbBeEQFNiet/v4MNZRZ4xCwx/cUTNpCEsECsxMc7M8GKeAW0
	JZYsfga1+SGTxM5Np5ggEoISJ2c+AZvKDDT1xr+XQHEOIFtaYvk/DpAwp4CdxOkNHWBhUaAj
	Xh2sn8AoOAtJ8ywkzbMQmhcwMq9ilEwtKM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiOFS2N
	HYz35v/TO8TIxMF4iFGCg1lJhLevLjpNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLp
	iSWp2ampBalFMFkmDk6pBiYthrin+lvLEhtmX99+eMGxvhcVwh4HVS6Exzod1uBYMrXp0b2W
	vOakefs4VevbEnafaJq37uStn7fcVNdmHFWX3XJM7KVU74tfC8V/xSz32OCpULfOt/lee+eB
	9z//5Pj8MpPesf6B+FKmF+1t4p9fVVzvje6ujGSRWq5YGG0zd3N+SZ/8tuWK+5d/5ZPdZKBU
	PXOr243JMQWSbVWTvern+WjfM7F0WBtk/mirfKVp1ptdn/VCl3y/MHGXovm/o1NqTxxap82q
	x7Q+4/C3Ng3F1R/tIy5fe5N3ZqGaffCslv7/UyylIyeuN+5LE5z53+ztEYWnah5Hda/x7NzW
	Gzr31IIura7Si7KTyl59mLNMiaU4I9FQi7moOBEAblXuHgQDAAA=
X-CMS-MailID: 20240603085036epcas2p1fc4df4c804b3ce38dd5a09ac96a56924
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_3b4f3_"
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

------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_3b4f3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Jun 03, 2024 at 08:56:09AM +0200, Krzysztof Kozlowski wrote:
> On 03/06/2024 05:44, Jung Daehwan wrote:
> > On Fri, May 31, 2024 at 10:12:36AM +0200, Krzysztof Kozlowski wrote:
> >> On 31/05/2024 08:07, Daehwan Jung wrote:
> >>> This is set by dwc3 parent node to support writing high-low order.
> >>>
> >>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> >>> ---
> >>>  drivers/usb/host/xhci-plat.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> >>> index 3d071b8..31bdfa5 100644
> >>> --- a/drivers/usb/host/xhci-plat.c
> >>> +++ b/drivers/usb/host/xhci-plat.c
> >>> @@ -256,6 +256,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
> >>>  		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
> >>>  			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
> >>>  
> >>> +		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
> >>> +			xhci->quirks |= XHCI_WRITE_64_HI_LO;
> >>
> >> Where is any user of this property (DTS)? Just to clarify: your
> >> downstream does not matter really.
> >>
> > 
> > This is set by dwc3 parent node by software node.
> > 
> > [PATCH v2 1/5] dt-bindings: usb: snps,dwc3: Add 'snps,xhci-write-64-hi-lo-quirk' quirk
> > https://lore.kernel.org/r/1717135657-120818-2-git-send-email-dh10.jung@samsung.com/
> 
> This is not a patch to DTS.
> 
> 

This is set by software node from dwc3. That's why I think this patch doesn't
need DTS patch. I would add DTS patch in dwc3 not xhci if it's needed.

Best Regards,
Jung Daehwan

> Best regards,
> Krzysztof
> 
> 

------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_3b4f3_
Content-Type: text/plain; charset="utf-8"


------CGP_Yo4KSd1.GMH1id3MjqccfDy5Ep7f4Yd1jhLawOabyReQ=_3b4f3_--

