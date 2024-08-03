Return-Path: <linux-kernel+bounces-273565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F6946AB1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721A11C205BC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8317C7F;
	Sat,  3 Aug 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AYoebKjW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510613FF9;
	Sat,  3 Aug 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722705821; cv=none; b=rfDtbnzD+TktZS+2Vu2MKqtjYBTQNSqAi40/AoKpEiQ1NydKeEeS6l6UikIGqub476xkfpPPh9EFPfmJaz9qwaICb2FA7gQUc8xb359qhSlO9Nkj3uyoijxJjdLs6N57zfJK4YlzPW9UDd4zIUB4BKT0D5osdUCvk1WIsz/+hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722705821; c=relaxed/simple;
	bh=ei9iQAsajKmKaikDEbq/+rHvQZrS2rhWkcbqSy9KghY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O3LoKRlB3ga8JDkln0wXziXsCK9e4CXYWZWITw5zdhCOdPV8e8V07BYbrZcy+e0/JkdUAHryFQ18BGDjN4lRSoW6HFyCgG8uYcYHVqnIryJbwaMHB6ICj8/YJo6ESVeS+EvPv7D4dW8AvD7gqC9JBgfsbjupAB5NvAXdob0xUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AYoebKjW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 473HN5Fg027050;
	Sat, 3 Aug 2024 17:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qBWibEVZcuSWmPxGhXwl/VWam/qCpv+3ewsWZvHWhNo=; b=AYoebKjWVNBjyuR5
	jqZjiXvID5YHroykwaECz9s9cBYU+w22wA9+KEG6QUinBbT1KygIQsT2HVV+eTkO
	zlpvn68GqA/4HJeYenlzLKYNdhVmTK8AUN2u33en1osVRwlOBlAbnNR7z9zmue71
	aUj+3mS628DYyvbH1yQAA2JFe9T38YGE50Z61Rvd30T8l3EfpI7biRyXk2JlfueR
	i+O68SeR+n2GcoU9a1nMzMf7YIwXe/qZKaqfPqPKIyZNrjdUIRiAw0r6OvjwOqDE
	7pw0yMTQgZ7BKUlcCR0RibWSm3a1GgrN1hiV93EjdwDidVSxbV+NvV5dmOPlvMQf
	ZOCfGw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scmtrtd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 17:23:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 473HNVoC017215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 17:23:31 GMT
Received: from [10.216.9.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 3 Aug 2024
 10:23:27 -0700
Message-ID: <df07951e-36fb-4642-8135-385b430cfa5c@quicinc.com>
Date: Sat, 3 Aug 2024 22:53:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_uac1: Change volume name and remove alt
 names
To: <crwulff@gmail.com>, <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones
	<lee@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        Perr Zhang
	<perr@usb7.net>, Pavel Hofman <pavel.hofman@ivitera.com>,
        <linux-kernel@vger.kernel.org>
References: <20240803155215.2746444-2-crwulff@gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240803155215.2746444-2-crwulff@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qbXWJPg7x8yFVib-Av3L4jfZ85DTXWyK
X-Proofpoint-GUID: qbXWJPg7x8yFVib-Av3L4jfZ85DTXWyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-03_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408030121



On 8/3/2024 9:22 PM, crwulff@gmail.com wrote:
> From: Chris Wulff <crwulff@gmail.com>
> 
> This changes the UAPI to align with disussion of alt settings work.
> 
> fu_name is renamed to fu_vol_name, and alt settings mode names
> are removed for now in favor of future work where they will be
> settable in subdirectories for each alt mode.
> 

Just a nit.

It would be good to keep the discussion thread link inside commit text 
rather than below the SoB. It would give more context when the patch is 
applied.

Regards,
Krishna,

> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
> discussion thread for api changes for alt mode settings:
> https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/
> ---
>   .../ABI/testing/configfs-usb-gadget-uac1      |  8 ++---
>   Documentation/usb/gadget-testing.rst          |  8 ++---
>   drivers/usb/gadget/function/f_uac1.c          | 36 +++++++------------
>   drivers/usb/gadget/function/u_uac1.h          |  8 ++---
>   4 files changed, 18 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documentation/ABI/testing/configfs-usb-gadget-uac1
> index cf93b98b274d..64188a85592b 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
> @@ -33,13 +33,9 @@ Description:
>   		p_it_name		playback input terminal name
>   		p_it_ch_name		playback channels name
>   		p_ot_name		playback output terminal name
> -		p_fu_name		playback functional unit name
> -		p_alt0_name		playback alt mode 0 name
> -		p_alt1_name		playback alt mode 1 name
> +		p_fu_vol_name		playback mute/volume functional unit name
>   		c_it_name		capture input terminal name
>   		c_it_ch_name		capture channels name
>   		c_ot_name		capture output terminal name
> -		c_fu_name		capture functional unit name
> -		c_alt0_name		capture alt mode 0 name
> -		c_alt1_name		capture alt mode 1 name
> +		c_fu_vol_name		capture mute/volume functional unit name
>   		=====================	=======================================
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index a89b49e639c3..7a94490fb2fd 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -960,15 +960,11 @@ The uac1 function provides these attributes in its function directory:
>   	p_it_name        playback input terminal name
>   	p_it_ch_name     playback channels name
>   	p_ot_name        playback output terminal name
> -	p_fu_name        playback functional unit name
> -	p_alt0_name      playback alt mode 0 name
> -	p_alt1_name      playback alt mode 1 name
> +	p_fu_vol_name    playback mute/volume functional unit name
>   	c_it_name        capture input terminal name
>   	c_it_ch_name     capture channels name
>   	c_ot_name        capture output terminal name
> -	c_fu_name        capture functional unit name
> -	c_alt0_name      capture alt mode 0 name
> -	c_alt1_name      capture alt mode 1 name
> +	c_fu_vol_name    capture mute/volume functional unit name
>   	================ ====================================================
>   
>   The attributes have sane default values.
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
> index 06a220fb7a87..bb36ce2be569 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -1254,16 +1254,16 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
>   	strings_uac1[STR_USB_OUT_IT].s = audio_opts->p_it_name;
>   	strings_uac1[STR_USB_OUT_IT_CH_NAMES].s = audio_opts->p_it_ch_name;
>   	strings_uac1[STR_IO_OUT_OT].s = audio_opts->p_ot_name;
> -	strings_uac1[STR_FU_OUT].s = audio_opts->p_fu_name;
> -	strings_uac1[STR_AS_OUT_IF_ALT0].s = audio_opts->p_alt0_name;
> -	strings_uac1[STR_AS_OUT_IF_ALT1].s = audio_opts->p_alt1_name;
> +	strings_uac1[STR_FU_OUT].s = audio_opts->p_fu_vol_name;
> +	strings_uac1[STR_AS_OUT_IF_ALT0].s = "Playback Inactive";
> +	strings_uac1[STR_AS_OUT_IF_ALT1].s = "Playback Active";
>   
>   	strings_uac1[STR_IO_IN_IT].s = audio_opts->c_it_name;
>   	strings_uac1[STR_IO_IN_IT_CH_NAMES].s = audio_opts->c_it_ch_name;
>   	strings_uac1[STR_USB_IN_OT].s = audio_opts->c_ot_name;
> -	strings_uac1[STR_FU_IN].s = audio_opts->c_fu_name;
> -	strings_uac1[STR_AS_IN_IF_ALT0].s = audio_opts->c_alt0_name;
> -	strings_uac1[STR_AS_IN_IF_ALT1].s = audio_opts->c_alt1_name;
> +	strings_uac1[STR_FU_IN].s = audio_opts->c_fu_vol_name;
> +	strings_uac1[STR_AS_IN_IF_ALT0].s = "Capture Inactive";
> +	strings_uac1[STR_AS_IN_IF_ALT1].s = "Capture Active";
>   
>   	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
>   	if (IS_ERR(us))
> @@ -1687,16 +1687,12 @@ UAC1_ATTRIBUTE_STRING(function_name);
>   UAC1_ATTRIBUTE_STRING(p_it_name);
>   UAC1_ATTRIBUTE_STRING(p_it_ch_name);
>   UAC1_ATTRIBUTE_STRING(p_ot_name);
> -UAC1_ATTRIBUTE_STRING(p_fu_name);
> -UAC1_ATTRIBUTE_STRING(p_alt0_name);
> -UAC1_ATTRIBUTE_STRING(p_alt1_name);
> +UAC1_ATTRIBUTE_STRING(p_fu_vol_name);
>   
>   UAC1_ATTRIBUTE_STRING(c_it_name);
>   UAC1_ATTRIBUTE_STRING(c_it_ch_name);
>   UAC1_ATTRIBUTE_STRING(c_ot_name);
> -UAC1_ATTRIBUTE_STRING(c_fu_name);
> -UAC1_ATTRIBUTE_STRING(c_alt0_name);
> -UAC1_ATTRIBUTE_STRING(c_alt1_name);
> +UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
>   
>   static struct configfs_attribute *f_uac1_attrs[] = {
>   	&f_uac1_opts_attr_c_chmask,
> @@ -1724,16 +1720,12 @@ static struct configfs_attribute *f_uac1_attrs[] = {
>   	&f_uac1_opts_attr_p_it_name,
>   	&f_uac1_opts_attr_p_it_ch_name,
>   	&f_uac1_opts_attr_p_ot_name,
> -	&f_uac1_opts_attr_p_fu_name,
> -	&f_uac1_opts_attr_p_alt0_name,
> -	&f_uac1_opts_attr_p_alt1_name,
> +	&f_uac1_opts_attr_p_fu_vol_name,
>   
>   	&f_uac1_opts_attr_c_it_name,
>   	&f_uac1_opts_attr_c_it_ch_name,
>   	&f_uac1_opts_attr_c_ot_name,
> -	&f_uac1_opts_attr_c_fu_name,
> -	&f_uac1_opts_attr_c_alt0_name,
> -	&f_uac1_opts_attr_c_alt1_name,
> +	&f_uac1_opts_attr_c_fu_vol_name,
>   
>   	NULL,
>   };
> @@ -1792,16 +1784,12 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
>   	scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Input terminal");
>   	scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playback Channels");
>   	scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Output terminal");
> -	scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Volume");
> -	scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback Inactive");
> -	scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback Active");
> +	scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Playback Volume");
>   
>   	scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Input terminal");
>   	scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Capture Channels");
>   	scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Output terminal");
> -	scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volume");
> -	scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture Inactive");
> -	scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture Active");
> +	scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Capture Volume");
>   
>   	return &opts->func_inst;
>   }
> diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
> index 67784de9782b..feb6eb76462f 100644
> --- a/drivers/usb/gadget/function/u_uac1.h
> +++ b/drivers/usb/gadget/function/u_uac1.h
> @@ -57,16 +57,12 @@ struct f_uac1_opts {
>   	char			p_it_name[USB_MAX_STRING_LEN];
>   	char			p_it_ch_name[USB_MAX_STRING_LEN];
>   	char			p_ot_name[USB_MAX_STRING_LEN];
> -	char			p_fu_name[USB_MAX_STRING_LEN];
> -	char			p_alt0_name[USB_MAX_STRING_LEN];
> -	char			p_alt1_name[USB_MAX_STRING_LEN];
> +	char			p_fu_vol_name[USB_MAX_STRING_LEN];
>   
>   	char			c_it_name[USB_MAX_STRING_LEN];
>   	char			c_it_ch_name[USB_MAX_STRING_LEN];
>   	char			c_ot_name[USB_MAX_STRING_LEN];
> -	char			c_fu_name[USB_MAX_STRING_LEN];
> -	char			c_alt0_name[USB_MAX_STRING_LEN];
> -	char			c_alt1_name[USB_MAX_STRING_LEN];
> +	char			c_fu_vol_name[USB_MAX_STRING_LEN];
>   
>   	struct mutex			lock;
>   	int				refcnt;

