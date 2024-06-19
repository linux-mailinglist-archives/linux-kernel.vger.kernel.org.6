Return-Path: <linux-kernel+bounces-220407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B696090E155
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFB8B21B49
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD8AD32;
	Wed, 19 Jun 2024 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GDzwUmEY"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11363A9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718760819; cv=none; b=fB5G/+YUeszZycciRUK+dg2E6kuw7iowuWkqMjY2GdI9fRvHfhDATZwNqRCtAHGr72mRxmnAPwb/OS2kqSLZvErLAxTVyWWFJFvJiJTGu9dWMzg4uGnys4tnrLL8iOrewuj+XEl2p/MeFvdGqrEmeEr38uYx1/PiL2+QhwhRzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718760819; c=relaxed/simple;
	bh=AgBQfUPLoqrbhuSoC4dUS42wrCdlYP45yQF/5SJEYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gdHSi2tsEYdzR0H7eU+yIuWB5PHt3zag/Fy1LFq3Yd8Bz2Xm2ZHN1rgtGfYaPNGM9lexyK3MPID2ySObDM8mvHGAMuK9Eofqj6oyEERLmP+6fknp/ps1ViA1TKTgqBRS/EinSnPYTu+7x2sKRNq5+h9GhRWfN3JovN/rpBA0j+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GDzwUmEY; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240619013329epoutp01fa5e7eb2a203fcb02ba3150ac4b61377~aQ9l-UMPu0610906109epoutp01k
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:33:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240619013329epoutp01fa5e7eb2a203fcb02ba3150ac4b61377~aQ9l-UMPu0610906109epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718760809;
	bh=4t/SmYLar+HaG2yFNDOf3LyoDqlKE/6BTNN5g/MR14Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDzwUmEYkrqDlIXzI8+m6PqScF6BtKnrjoOf4fbpzsUgrrWwokY6aQS1sKGLQC8CY
	 yoi9tGd6F2kZHhncfX3NUF6zUCK/bdqjsMCMKrxm7+Lbbd+7cPaJ32lodZsB2X/51e
	 wLQTlZMdmXViP/rn4a5sKBRQPpgL0g1sUwQRl24o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240619013328epcas2p494f2194ebe55b1b6c1f899a77d359d17~aQ9lUZRaF2096220962epcas2p4M;
	Wed, 19 Jun 2024 01:33:28 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W3mNS0zWCz4x9Q1; Wed, 19 Jun
	2024 01:33:28 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1C.00.25328.86532766; Wed, 19 Jun 2024 10:33:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20240619013327epcas2p46269e8b7db43b5897a65c4c67fa7ff58~aQ9kV-voa2094720947epcas2p4d;
	Wed, 19 Jun 2024 01:33:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240619013327epsmtrp10184b41cf3437c9bff27ee4706de600a~aQ9kVQoj52781227812epsmtrp1R;
	Wed, 19 Jun 2024 01:33:27 +0000 (GMT)
X-AuditID: b6c32a4d-d53ff700000262f0-3f-667235688e26
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.EC.07412.76532766; Wed, 19 Jun 2024 10:33:27 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240619013327epsmtip29d769f5bdd0ca8faf4c2876b7be0a569~aQ9kKoWM92746027460epsmtip2P;
	Wed, 19 Jun 2024 01:33:27 +0000 (GMT)
Date: Wed, 19 Jun 2024 10:34:26 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: joswang <joswang1221@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jos Wang
	<joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read
 timeout
Message-ID: <20240619013423.GA132190@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240618213600.63fdhod6nnx4h4m6@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmmW6GaVGawdntLBbNi9ezWdx/y27R
	fW0Pk8XlXXPYLBYta2W2WLDxEaPFqgUH2B3YPXbOusvucfbXS2aP/XPXsHts2f+Z0ePzJrkA
	1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
	yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
	2RndMwQLjrJVLJv5gLGBcT1rFyMnh4SAicS++dcZuxi5OIQE9jBK/Nm6kw3C+cQo8fDhaxYI
	5xujxLxpB1hgWrrWtjBDJPYySiz8d50dwnnCKDHt1mdmkCoWAVWJV0t+MoLYbAJaEvd+nACL
	iwjoSBw4cZ4JpIFZYDaTxNzfD4GKODiEBfwllmyQAKnhBapZdeE/G4QtKHFy5hOwzZwC1hKz
	Gg6zgZSLCqhIvDpYDzJGQuAru8SN75eZIa5zkXi44grUpcISr45vYYewpSRe9rdB2cUSt54/
	Y4ZobmGUWPGqBarZWGLWs3awo5kFMiR+fZnIDrJMQkBZ4sgtFogwn0TH4b9QYV6JjjYhiE5l
	iemXJ0DDVFLi4OtzUBM9JK7OmAoNn43MEl3/NzNPYJSfheS1WUi2Qdg6Egt2f2KbBbSCWUBa
	Yvk/DghTU2L9Lv0FjKyrGKVSC4pz01OTjQoMdfNSy+ERnpyfu4kRnEi1fHcwvl7/V+8QIxMH
	4yFGCQ5mJRFep2l5aUK8KYmVValF+fFFpTmpxYcYTYFxNZFZSjQ5H5jK80riDU0sDUzMzAzN
	jUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYKpyPZ9Uy3uzZeVa1w1337m5HnPY2sYi
	VVex7M4xtb+nm1L/i/op6Al9v3JLRzwzufdD1cpJoksOWz261JmZZKa8ZHe64oXuc70LH/9d
	zPm9/tHEQ4sX5Gf/PKex+aiRm6PfBKUPrebiRxhVT9xiODxrU4M0h2BYlkPZu6rnWp4WLuf3
	HxIUUDAx0c1vjetIChOM4F7ncF28eK3PvWfnjl0WMiqumjRhtdSkvx3vZjSFTWf8JD1j+pza
	5cWHA2OO7C2ZFa0r9tFsmmnG7rXKLTl/VcRuVut/15if8t5O6xAXE9PWAGGuc7/FZz5cvLjk
	zuojB7KztmfWFS1ie5TD9etoGrd6wzVjr6VnvXM1LJVYijMSDbWYi4oTAWx46pctBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvG66aVGawfp/ohbNi9ezWdx/y27R
	fW0Pk8XlXXPYLBYta2W2WLDxEaPFqgUH2B3YPXbOusvucfbXS2aP/XPXsHts2f+Z0ePzJrkA
	1igum5TUnMyy1CJ9uwSujFMHtzAWtLJUTNp8k7mBsYO5i5GTQ0LARKJrbQuQzcUhJLCbUeL5
	6fVQCUmJpXNvsEPYwhL3W46wQhQ9YpSY0dgNVsQioCrxaslPRhCbTUBL4t6PE2BxEQEdiQMn
	zjOBNDALzGaSOHdvBViRsICvxPl9PWA2L1DRqgv/2SCmbmSW6PzbzQqREJQ4OfMJC4jNDDT1
	xr+XQJM4gGxpieX/OEDCnALWErMaDrOBhEUFVCReHayfwCg4C0nzLCTNsxCaFzAyr2KUTC0o
	zk3PTTYsMMxLLdcrTswtLs1L10vOz93ECI4BLY0djPfm/9M7xMjEwXiIUYKDWUmE12laXpoQ
	b0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwcnFINTEfNc7rjfm6L
	3FPcdufAPdGcfW3pvKfP3uUsZr72Omx6c/R80W/vzn3pz0xXi+HWn3fdyNb24Z33s7cWlP+s
	+afWO/V5X6K735nQHfXc8XtlhQqm8+YlnrkccFNmJ6fvyrNHLOY+sj+ntdf1e4qHlFzaBtct
	bClOG9y7ayweNeuqznbTKP+wfKnj7PmivYf9nf1++xZvefCrOsX69j39XFZZpzKl13LTJjkk
	/zdrTOLJyp6xdvu3Y+cyBCNt5W6b/Q2wevuo7DPDFX81m8Vn4yx+eW++4GTVEjCVIStqSuSB
	xs8a91WynBT2H6uSb9x5Q197dfxjob2GBqI/drz7IjRr1a2yC9mvwsRn/O6cpMRSnJFoqMVc
	VJwIAITzWYrwAgAA
X-CMS-MailID: 20240619013327epcas2p46269e8b7db43b5897a65c4c67fa7ff58
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_de1c8_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240618000530epcas2p15ee3deff0d07c8b8710bf909bdc82a50
References: <20240601092646.52139-1-joswang1221@gmail.com>
	<20240612153922.2531-1-joswang1221@gmail.com>
	<2024061203-good-sneeze-f118@gregkh>
	<CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
	<CGME20240618000530epcas2p15ee3deff0d07c8b8710bf909bdc82a50@epcas2p1.samsung.com>
	<20240618000502.n3elxua2is3u7bq2@synopsys.com>
	<20240618042429.GA190639@ubuntu>
	<20240618213600.63fdhod6nnx4h4m6@synopsys.com>

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_de1c8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jun 18, 2024 at 09:36:03PM +0000, Thinh Nguyen wrote:
> On Tue, Jun 18, 2024, Jung Daehwan wrote:
> > 
> > Hi Thinh,
> > 
> > We faced similar issue on DRD mode operating as device.
> > Could you check it internally?
> > Case: 01635304
> > 
> 
> Hi Jung,
> 
> It's a separate case. Please check through our support channel to avoid
> any miscommunication/disconnect.
> 
> Thanks,
> Thinh

Thanks for the check. I will check through the support channel again.

Best Regards,
Jung Daehwan

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_de1c8_
Content-Type: text/plain; charset="utf-8"


------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_de1c8_--

