Return-Path: <linux-kernel+bounces-295420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B746959AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE801C219A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003431531FE;
	Wed, 21 Aug 2024 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TY9TxHBI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889511531F1;
	Wed, 21 Aug 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239979; cv=none; b=OcGnq2hpef9jtDPfk6jNw0WSYPmKIKIDC//zdDuU60tqf2ENpDvas3L21okpA1fFeiF9Ripzkz7zgUFQTgzYpPP3FrGSQA+h/O9NVLr1gAL0v79PzY2zvR43bfDN4zywGozHRXwzp6DQoaAk2CDsAGn+21FMT/WwF3njrKnZbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239979; c=relaxed/simple;
	bh=p+4ioSkhsSo7DEZToVE5UONpMdDEqou4FVH4CZerBYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oyKz5ft57ThT7hmh4xEfsXHw+xy8m3eSZFEu4/N4RiuCr913mtE0Av2mWUzVT0onyAF9XgLstgHMzArnljie0lYFd7v0j/UKqXfG0xmlrVvC6edoX0pEsCiGjakAANk/zaADrk4w9ZTOJEYxFMIbththTuEUGZCNgPxIaRpqR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TY9TxHBI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6HnMI026072;
	Wed, 21 Aug 2024 11:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y1EF7iQw5Bh2mrid4cNrPlOuDjEMq4+PGZp/6a7D6jY=; b=TY9TxHBIJJGBINBl
	KctuAOO1Qu7dqlQLKUj6KSURkhdr/W2RIoBXZM5sN9mqD//XU7mFczIWPduOmhAe
	moRYR/d07Jh0vOA66W6S3J0pbn27sroWQkFUwUKCW48cMN+4OtXhRU2/TKJkcvNZ
	7IiJAXnprNvfLSr6KWiHsuMYHQ0Q8Ig5axwCsJyb6MgxhhuTepDf7F4fKRqzeEr0
	cWiGiMLE7Z2H3WeD0/XLP8o2OcvQdcCGlRdKsgxThpPpZc8Vm+mxdGHWibzySE20
	uhTmRWnCbRy0fxGIiq4lUiF2tbj9Bg1x0L28vNkkKGZOtuoeMAJ1ebNSZZ79f2Zb
	XGRQMw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414xb9jvku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 11:32:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LBWrqE016392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 11:32:53 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 04:32:50 -0700
Message-ID: <971ae3e9-a991-7649-dfa1-a7156e7200d4@quicinc.com>
Date: Wed, 21 Aug 2024 17:02:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] usb: gadget: u_serial: check Null pointer in EP
 callback
Content-Language: en-US
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>
References: <TYUPR06MB62175A4C6BC97FBAAC9DA72CD28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB62175A4C6BC97FBAAC9DA72CD28D2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XE114qPBBdWNjLqejL4wOb2okf7B5dQT
X-Proofpoint-ORIG-GUID: XE114qPBBdWNjLqejL4wOb2okf7B5dQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=770 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210084



On 20-08-24 08:04 pm, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Added null pointer check to avoid system crash.
> Still didn't update the commit text with reason for null pointer crash.
Please mention about the race between gser_disconnect and read/write
complete callbacks, and how the port can become Null.

> Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000001a8
> pc : gs_read_complete+0x58/0x240
> lr : usb_gadget_giveback_request+0x40/0x160
> sp : ffffffc00f1539c0
> x29: ffffffc00f1539c0 x28: ffffff8002a30000 x27: 0000000000000000
> x26: ffffff8002a30000 x25: 0000000000000000 x24: ffffff8002a30000
> x23: ffffff8002ff9a70 x22: ffffff898e7a7b00 x21: ffffff803c9af9d8
> x20: ffffff898e7a7b00 x19: 00000000000001a8 x18: ffffffc0099fd098
> x17: 0000000000001000 x16: 0000000080000000 x15: 0000000ac1200000
> x14: 0000000000000003 x13: 000000000000d5e8 x12: 0000000355c314ac
> x11: 0000000000000015 x10: 0000000000000012 x9 : 0000000000000008
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffff887cd12000
> x5 : 0000000000000002 x4 : ffffffc00f9b07f0 x3 : ffffffc00f1538d0
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000001a8
> Call trace:
> gs_read_complete+0x58/0x240
> usb_gadget_giveback_request+0x40/0x160
> dwc3_remove_requests+0x170/0x484
> dwc3_ep0_out_start+0xb0/0x1d4
> __dwc3_gadget_start+0x25c/0x720
> kretprobe_trampoline.cfi_jt+0x0/0x8
> kretprobe_trampoline.cfi_jt+0x0/0x8
> udc_bind_to_driver+0x1d8/0x300
> usb_gadget_probe_driver+0xa8/0x1dc
> gadget_dev_desc_UDC_store+0x13c/0x188
> configfs_write_iter+0x160/0x1f4
> vfs_write+0x2d0/0x40c
> ksys_write+0x7c/0xf0
> __arm64_sys_write+0x20/0x30
> invoke_syscall+0x60/0x150
> el0_svc_common+0x8c/0xf8
> do_el0_svc+0x28/0xa0
> el0_svc+0x24/0x84
> el0t_64_sync_handler+0x88/0xec
> el0t_64_sync+0x1b4/0x1b8
> Code: aa1f03e1 aa1303e0 52800022 2a0103e8 (88e87e62)
> ---[ end trace 938847327a739172 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> 
You can also add the Fixes tag and CC stable kernel, so that it can be
backported to older kernels (such as 5.15) also.

https://www.kernel.org/doc/html/v4.10/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Please refer other commits for reference.
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v3:
>   - Add serial_port_lock protection when checking port pointer
>   - Optimize code comments
>   - Delete log printing
> ---

[...]
>  
> @@ -486,7 +509,7 @@ static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
>  		break;
>  	}
>  
> -	spin_unlock(&port->port_lock);
> +	spin_unlock_irqrestore(&port->port_lock, flags);
>  }
>  
>  static void gs_free_requests(struct usb_ep *ep, struct list_head *head,

Regards,
Prashanth K

