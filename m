Return-Path: <linux-kernel+bounces-397690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5769BDF0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6A1F23CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB500192D8E;
	Wed,  6 Nov 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k0KWqQsu"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C07149E00
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876430; cv=none; b=KsjMO3UrVCwvrYkBT5oCXmeWM7lCp01VLV0G9QtmzAslzA8Y+mVjEtiiEVl2lrM6TQgI+1oqmK723bqc8bJVW0pPzzexynqeOAxE7TqVepEIkkgx6UE9VKZtaHMMAzxCCSWsHpzBFAiWDnP9PP02IyZ6ZWId85FlYJx8aOarbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876430; c=relaxed/simple;
	bh=H1q+kz7HeN1mgjpvFwXPm/8+AngBAeaCQfbCDQ450aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hvkEUwrUck+tzHqlEXTdq+K/bRDn3o/N/uhJxCpClGvKa/csk5YoqIWM66AwfOasmaTKSxtyXtn51hgcdECahRPoK1cUBKhMfL5e3Nru5TG/WXfGdOxMH/tcj1uT9HHt+j84be9eBcNZTS8cr58FYDFQqgUFURdPMnFghaSJ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k0KWqQsu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241106070019epoutp02382768c22aaa60a3786862a29b3faed1~FTu6998ym2912729127epoutp02W
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:00:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241106070019epoutp02382768c22aaa60a3786862a29b3faed1~FTu6998ym2912729127epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730876419;
	bh=GTjuOk/dlcE8eyX6yp0X7lZB5UBYs8n0NUYxZCe8jY4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=k0KWqQsupxZZbB6/jwyhUz5Rnb1sCKYqBeKRn7q3vmsjFeP9BEIwI1piHmvuC0KBL
	 SG6sVjPZkZSFmEqNFCb7og5aVY5jPrkHiciyan18UrWDo9wj+YxoQjlXvBVXjyHdE0
	 /+1SGnLDhpOQCU/8CNpwpjCz0DVQMoV/9JmcfBO8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241106070018epcas5p3d44f29526f61eddb0463737305f8575b~FTu6fSM9Q2464824648epcas5p3m;
	Wed,  6 Nov 2024 07:00:18 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xjx0w0JRFz4x9QJ; Wed,  6 Nov
	2024 07:00:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.5E.08574.FF31B276; Wed,  6 Nov 2024 16:00:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241106070014epcas5p23146dbb7865d00d789f7c90c88811de3~FTu2_B5Ka2493024930epcas5p2N;
	Wed,  6 Nov 2024 07:00:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241106070014epsmtrp175c08d1c4cded231d0fb8bc6150f6bdd~FTu25-ahI2325523255epsmtrp1H;
	Wed,  6 Nov 2024 07:00:14 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-9d-672b13ffd9e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.81.08227.EF31B276; Wed,  6 Nov 2024 16:00:14 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241106070011epsmtip2bc1f3b4248e0c58eeeb3168b00345abf~FTuzwYJS52176321763epsmtip2g;
	Wed,  6 Nov 2024 07:00:11 +0000 (GMT)
Message-ID: <c1f6377f-5ddf-4617-bc69-9a4975c271e8@samsung.com>
Date: Wed, 6 Nov 2024 12:29:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
To: Akash Kumar <quic_akakum@quicinc.com>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jing Leng <jleng@ambarella.com>, Felipe Balbi
	<balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Daniel Scally
	<dan.scally@ideasonboard.com>
Cc: Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>, Krishna Kurapati
	<quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <20241017064423.7056-1-quic_akakum@quicinc.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed87pBZKSY5HxCRmW4wVhA9oNyoeBjgQkjRsbhml2SQYn5aQl
	lLbpRbYlOhBhwATlIpMCA1FhlkWWCuiQrsDYQHC6DERFGSHrzBgi4do5uazlsI1/z/vmeZ43
	z/t+Hx8XLnH9+BkaI6PX0GqK60l0fB8cFLru/bJSfCV/G3py18JBPxY4eKikqYuLHjVUYWiw
	+TyG8i60clF5VzuBxif/IlD1gyqAzFcqASoqu8hDw521XNTYlI+j+R/WOejhio2DOtcaMeSc
	nuOgp5NDAFlvlHKQpaiWQMPOb3FU3uODLA3dvDhfeb+zmyevKazmyK2WIq7cXvc1T17WdVxe
	2mYB8jb7ApAvWAOS+e9nxqgYOp3RixiNQpueoVHGUm+kpManRkrFklBJNIqiRBo6i4mlEt5M
	Dk3MULsyUqKjtNrkaiXTBgMVLovRa01GRqTSGoyxFKNLV+sidGEGOstg0ijDNIxxv0QsfjXS
	RUzLVA18dRXTWUI/mr3fwssBA7uLAZ8PyQi42revGHjyheQNAH9quYuzxTyAed0FRDHwcBXL
	AD6pNrqxW/Ddyshm3wZguzOcFcwAePJ2CeZ2FZAyuHJpv5tDkLvhePMSz40F5DZ4s9qxofUh
	d8KJsXMbfW8yBa52N3LdPtvJszgsWp3juAuc/BuDQ8u3MDcLJ33hmKN+YwCXlMDHAzHutgcZ
	AyvujGxSdsK89pqNBJCs8YAztknAxkyA4ycQG8Ab/tnfxmOxH5w6XbCJFbCrfHETq2CvpRdn
	8euwpeEWx22Dk8GwtTOcHeUFS547MNZdAAsLhCx7DxzMHeay2B/+enGUw2I5bH7UhLGrOg1g
	7mwucQaIzFvWYt4S0rwljfn/yQ2AsIAdjM6QpWQUkTqJhsn+79oKbZYVbLz/kITr4H79Wlgv
	wPigF0A+Tm0XfMkEKYWCdPrjTxi9NlVvUjOGXhDpuk8Z7uej0Lo+kMaYKomIFkdIpdKI6Nek
	EspXMJ1fly4klbSRyWQYHaP/V4fxPfxysMC1bNuEZBGtv3tbS5yZldhGSjzp1Qp65LdniQ/7
	U7xKb6osvJkCsdfJynnDPWfiDnzo8KeiwcziHPuydO1xHY8IPJ62LjJO7GXa7FPro/XZ5oCU
	y59Z35J1HHrp0sqFuA8dvh8sHAs2fmOeDpi+6jnXQURdFhaFXOv54oi1U38o9ynpkRYPlk5V
	/NFzlvpdrTp/zZ60J6N0btHyOefgVPa+Win1c2QgD1yf/SXpgF+eYnTyiHdWpdb3WZIpapcp
	vurg8FFZuSzncNiBAXv2e+WGuKRzrySaW1v68tKO9d2JLrn33F/2jiboFNexYMHffrB3rKbn
	hL/thdAXp510baGAIgwqWhKC6w30P3dwd9GIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA01RfUyMcRz3e97u6dnOHle6H7ayh7mEEuEXx/inHYual+Sl6VaP66Zyu+vN
	a6bV3JmIvHShOnT1hLarM67rPSRbdmQKZVlOlilxsqS4Yuu/z/fz+X6+n8/2pXFJOzGbVicl
	89okZQJHMcS9Js53yZjnItXS7NIF6PNLgUSPsntF6EyJnUJviy5hqNVcjKHMGxUUOm+3Eqir
	5yeB8jsvAWS8mweQPvemCL2wXaWQqSQLR0MPx0n0ZrSGRLYxE4aG+7+S6EvPU4As1TkkEvRX
	CfRi+AGOzjfMREJRvWi9VPF4uF6kKDiVTyosgp5S1F27LVLk2o8rcqoEoKiq+wYU3yw+EfRu
	Rh7HJ6hTeW3guhgmvqW0EtMIS9IHOspFJ0DLfAPwoCEbDGtH2wkDYGgJWw1g9tkKMCnMgf1G
	wz/sCcvGPorcWML2A5j1OcQAaFrMroOjt1a7aYKdD7vMrokVMTsDPsnvJdx4JusL372+MsF7
	stvg73oT5c7yYi/jsLbDBdwDzo5g8GONCUy2OAugbdBCuS04K4WvewsxdxrFBkFni9xNe7By
	eOFZOza5shIarJNF8b9pmdYC/ByQGKcUMU65ZJxiMU6xFAFCALN4jS5RlagL0ixL4tMCdMpE
	XUqSKiD2YKIFTDze3/8+sAuDAY0Ao0EjgDTOeYmv8zKVRBynPHSY1x7cp01J4HWNYA5NcFLx
	j/4zcRJWpUzmD/C8htf+VzHaY/YJrPJkaOxLs6dwIMMnj+k6/uGYOv7td5LeEvbrNBqfkbnm
	SLr3qz1mLrxV4zCORNsdzK8wwwbHSSY9b2lwSniudN4bl3bI1/pcj9+qrrD7V283ODmHZm9E
	W8x02yL1z0N7U2Vyp3x5lqpvsCgwMt1Z0rx4evTomF/UYEVoiLG5Y9NR9YrCrV5plSworrLe
	a7IF+0V+Ouxz97SMrPxQLFMWRIU5nPPKQyMdyQNm1ffmkayGktVdhFS/0CSmeuO5TmGabieT
	Y5GJiqMzmsLD3pPdqXkJgvdG9TGuLTp5y+a+gvWduRFzV7HCkGtt0EUnc3OX69HG5u6yHalD
	e/bf4QhdvDLIH9fqlH8AChuXT2cDAAA=
X-CMS-MailID: 20241106070014epcas5p23146dbb7865d00d789f7c90c88811de3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241017064506epcas5p4fd10695c100c84c659d4124d2f77e6a8
References: <CGME20241017064506epcas5p4fd10695c100c84c659d4124d2f77e6a8@epcas5p4.samsung.com>
	<20241017064423.7056-1-quic_akakum@quicinc.com>


On 10/17/2024 12:14 PM, Akash Kumar wrote:
> The current logic is rigid, setting num_fifos to fixed values.
> 3 for any maxburst greater than 1.
> tx_fifo_resize_max_num for maxburst greater than 6.
> Additionally, it did not differentiate much between bulk and
> isochronous transfers, applying similar logic to both.
>
> The updated logic is more flexible and specifically designed to meet
> the unique requirements of both bulk and isochronous transfers. We
> have made every effort to satisfy all needs and requirements, verified
> on our specific platform and application.
>
> Bulk Transfers: Ensures that num_fifos is optimized by considering both
> the maxburst and DT property "tx-fifo-max-num" for super speed and
> above. For high-speed and below bulk endpoints, a 2K TxFIFO allocation
> is used to meet efficient data transfer needs, considering
> FIFO-constrained platforms.
>
> Isochronous Transfers: Ensures that num_fifos is sufficient by
> considering the maximum packet multiplier for HS and below and maxburst
> for Super-speed and above eps, along with a constraint with the DT
> property "tx-fifo-max-num".
>
> This change aims to optimize the allocation of Tx FIFOs for both bulk
> and isochronous endpoints, potentially improving data transfer efficiency
> and overall performance. It also enhances support for all use cases,
> which can be tweaked with DT parameters and the endpoint’s maxburst and
> maxpacket. This structured approach ensures that the appropriate number
> of FIFOs is allocated based on the endpoint type and USB speed.
>
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
> Changes for v7:
> fixed indentations for if checks.
>
> Changes for v6:
> The code has been refactored to replace multiple if checks with a
> switch-case structure based on the USB speed. This change improves
> readability and maintainability by clearly defining behavior for
> different USB speeds. This structured approach ensures that the
> appropriate number of FIFOs is allocated based on the endpoint
> type and USB speed.
>
> Changes for v5:
> Update Calculation for HS and below bulk and isoc eps based on
> suggestion and fixed at 2k for bulk eps considering fifo constrained
> platforms.
>
> Changes for v4:
> Updated commit message as per review comments to clarify that it has
> been tested on specific platforms only and tried best to match all
> expectations.
>
> Changes for v3:
> Redefine logic for resizing tx fifos,added check based on  operating
> speed and used maxp for HS and maxburst for SS  and defined max allocation
> based on dt property.
>
> Changes for v2:
> Redefine logic for resizing tx fifos, handled fifo based on  minimum of
> maxp and maxburts.
>
> Changes for v1:
> Added additional condition to allocate tx fifo for hs isoc  eps, keeping
> the other resize logic same
> ---
>   drivers/usb/dwc3/gadget.c | 33 ++++++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 10178e5eda5a..af3d5b2f7b67 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -771,15 +771,30 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>   
>   	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>   
> -	if ((dep->endpoint.maxburst > 1 &&
> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
> -		num_fifos = 3;
> -
> -	if (dep->endpoint.maxburst > 6 &&
> -	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
> -		num_fifos = dwc->tx_fifo_resize_max_num;
> +	switch (dwc->gadget->speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
> +		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
> +			num_fifos = min_t(unsigned int,
> +					  dep->endpoint.maxburst,
> +					  dwc->tx_fifo_resize_max_num);
> +		break;
> +	case USB_SPEED_HIGH:
> +		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
> +			num_fifos = min_t(unsigned int,
> +					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,

Hi Akash,

We are currently working on enabling UVC functionality on supports USB 
HS and below speeds with using a single port RAM configuration.

In order to better understand the logic behind resizing HS ISO transfers 
when using a streaming packet size of 3072 in the UVC use case, we would 
like to know if there is a specific reason for using 
(usb_endpoint_maxp_mult(dep->endpoint.desc) + 1) to determine the number 
of FIFOs. This calculation could result in having 4 FIFOs instead of 3, 
even though 3 FIFOs should be sufficient for handling the 3072 streaming 
packet size. In our specific use case, this could potentially lead to an 
insufficient RAM issue, as we are limited by the amount of RAM available 
in the single port RAM configuration and supports upto HS-speed.

> +					  dwc->tx_fifo_resize_max_num);
> +			break;
> +		}
> +		fallthrough;
> +	case USB_SPEED_FULL:
> +		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
> +			num_fifos = 2;


And we need to understand on above logic as well. Why using num_fifos =2 
for bulk transfer for HS and FULL speed?. It can ending with 2k (4 * 
Maxpacktsize).
As per our understanding (2 x Maxpacketsize) is sufficient for bulk. Its 
means that num_fifos = 1 is sufficient for bulk. As i mentioned above 
this could potentially lead to an insufficient RAM issue in our platform.
> +		break;
> +	default:
> +		break;
> +	}
>   
>   	/* FIFO size for a single buffer */
>   	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);

