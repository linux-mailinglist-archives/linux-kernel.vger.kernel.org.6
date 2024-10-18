Return-Path: <linux-kernel+bounces-371553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F39A3C96
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C011F216FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395822040BF;
	Fri, 18 Oct 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a8b+8n2Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8220370A;
	Fri, 18 Oct 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249213; cv=none; b=jWAIJ7rclQ4Tn2RerR9apgpFJzI05mN5CpvFFtlwcaVlGFcK51nDBcX04bCgeMoEx6KuWD8U3k9ww7ytiB5GRLMc5ZXeT+ObopW5HMWBzxG83MaDob4yLty4M1ldrAktygKcZni/KL13RygSQ1n3BEGACn4yB9tRCljkqRj8lLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249213; c=relaxed/simple;
	bh=QsyhH25rLOxiNgZIQB5iNNRFKMjAvpxrtni47ZVSoHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GsHDXTiukoQFCTpnVnN3tYbYD1IGh0x9iJl/13QN3DwmiNszG+fxlcIyOdhIjS81j8KnLAU7HHrzL/BAZ+W3Yw7SVR13vxByw51zlNHEEW4MGXcXcfB/efILGqXsSE34BktSN9WLWndbiqWdw4NfwCXaFJrV4LnAiXhH907d+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a8b+8n2Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9M1Jb005759;
	Fri, 18 Oct 2024 11:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSgBwG3VOgSX9ZcNnIj9sjTE7GQOeW7zkIpMbYd/z0E=; b=a8b+8n2Q5VqwSbdM
	d84PJMX5kkngQ1c32t4FGgRAXoeO0thcajJghMpr/qxTr0bF/gzPBE9VOnecMKAX
	TV5RFQL7+kW9XbNU67gXPaI5krlJ67I+oLoxbtTZP+KNzdE8KltAds948iVz5l5Y
	7fQUtybIw5x1OcYe72RdPIYYZVkITAETZ+kpluu8+bJYfs+0i9m+2Q90gO0dfrT8
	tdWx2S983OMzksEFJ5HgmO5EATZyDoFwHnAW0szycPQ7bJYKAvH01OZB70LieMSU
	Bl8ArMbsibd5sJmbkwVZGb96ylEh4TsUHbaMmuG4cq0jDU3FvJcV/7Wmc3UdhsS5
	XMp8Iw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42bmys8c25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 11:00:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IB03lp024139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 11:00:04 GMT
Received: from [10.218.13.161] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 03:59:47 -0700
Message-ID: <3cf738f9-f0c7-41b7-b2ef-b73aca6f9448@quicinc.com>
Date: Fri, 18 Oct 2024 16:29:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: dwc3: core: Add support to ignore single SE0
 glitches
Content-Language: en-US
To: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
 <20241017114055.13971-3-quic_uaggarwa@quicinc.com>
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20241017114055.13971-3-quic_uaggarwa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mO-XzJiP_LooUhNBA4wFEbpBZEQbmPn6
X-Proofpoint-ORIG-GUID: mO-XzJiP_LooUhNBA4wFEbpBZEQbmPn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410180070

Hi Uttkarsh, Thinh,

On 10/17/2024 5:10 PM, Uttkarsh Aggarwal wrote:
> Currently in few of Qualcomm chips USB (Low speed) mouse not
> detected showing following errors:
>
>    usb 1-1: Device not responding to setup address.
>    usb 1-1: device not accepting address 2, error -71
>    usb 1-1: new low-speed USB device number 3 using xhci-hcd
>    usb 1-1: Device not responding to setup address.
>    usb 1-1: Device not responding to setup address.
>    usb 1-1: device not accepting address 3, error -71
>    usb usb1-port1: attempt power cycle
>
> Based on the Logic analyzer waveforms, It has been identified that there
> is skew of about 8nS b/w DP & DM linestate signals (o/p of PHY & i/p to
> controller) at the UTMI interface, Due to this controller is seeing SE0
> glitch condition, this is causing controller to pre-maturely assume that
> PHY has sent all the data & is initiating next packet much early, though
> in reality PHY is still busy sending previous packets.
>
> Enabling the GUCTL1.FILTER_SE0_FSLS_EOP bit29 allows the controller to
> ignore single SE0 glitches on the linestate during transmission. Only two
> or more SE0 signals are recognized as a valid EOP.
>
> When this feature is activated, SE0 signals on the linestate are validated
> over two consecutive UTMI/ULPI clock edges for EOP detection.
>
> Device mode (FS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then for device LPM
> handshake, the controller ignores single SE0 glitch on the linestate during
> transmit. Only two or more SE0 is considered as a valid EOP on FS port.
>
> Host mode (FS/LS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then the controller
> ignores single SE0 glitch on the linestate during transmit.
>
> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
> ---
>   drivers/usb/dwc3/core.c | 13 +++++++++++++
>   drivers/usb/dwc3/core.h |  4 ++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 86b37881aab4..4edd32c44e73 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -222,6 +222,17 @@ static void __dwc3_set_mode(struct work_struct *work)
>   
>   	switch (desired_dr_role) {
>   	case DWC3_GCTL_PRTCAP_HOST:
> +	       /*
> +		* Setting GUCTL1 bit 29 so that controller
> +		* will ignore single SE0 glitch on the linestate
> +		* during transmit.
> +		*/
> +		if (dwc->filter_se0_fsls_eop_quirk) {
> +			reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
> +			reg |= DWC3_GUCTL1_FILTER_SE0_FSLS_EOP;
> +			dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
> +		}
> +
Since this bit is useful for device mode as well along with host mode,we 
should set this in dwc3_core_init
where we are already writing for GUCTL1 bit disable parkmode, instead of 
host mode only. Like below

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1444,6 +1444,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
                 if (dwc->parkmode_disable_hs_quirk)
                         reg |= DWC3_GUCTL1_PARKMODE_DISABLE_HS;

+               if (dwc->filter_se0_fsls_eop_quirk)
+                       reg |= DWC3_GUCTL1_FILTER_SE0_FSLS_EOP;
+
                 if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY)) {
                         if (dwc->maximum_speed == USB_SPEED_FULL ||
                             dwc->maximum_speed == USB_SPEED_HIGH)
>   		ret = dwc3_host_init(dwc);
>   		if (ret) {
>   			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -1788,6 +1799,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>   
>   	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
>   				"snps,tx_de_emphasis_quirk");
> +	dwc->filter_se0_fsls_eop_quirk = device_property_read_bool(dev,
> +				"snps,filter-se0-fsls-eop-quirk");
>   	device_property_read_u8(dev, "snps,tx_de_emphasis",
>   				&tx_de_emphasis);
>   	device_property_read_string(dev, "snps,hsphy_interface",
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index cc3f32acfaf5..33d53a436fd7 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -276,6 +276,7 @@
>   
>   /* Global User Control 1 Register */
>   #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
> +#define DWC3_GUCTL1_FILTER_SE0_FSLS_EOP		BIT(29)
>   #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
>   #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
>   #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
> @@ -1140,6 +1141,8 @@ struct dwc3_scratchpad_array {
>    * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
>    *                          running based on ref_clk
>    * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
> + * @filter_se0_fsls_eop_quirk: set to ignores single
> + *				SE0 glitch on the linestate during transmit.
>    * @tx_de_emphasis: Tx de-emphasis value
>    *	0	- -6dB de-emphasis
>    *	1	- -3.5dB de-emphasis
> @@ -1373,6 +1376,7 @@ struct dwc3 {
>   	unsigned		gfladj_refclk_lpm_sel:1;
>   
>   	unsigned		tx_de_emphasis_quirk:1;
> +	unsigned		filter_se0_fsls_eop_quirk:1;
>   	unsigned		tx_de_emphasis:2;
>   
>   	unsigned		dis_metastability_quirk:1;
Thanks,
Akash

