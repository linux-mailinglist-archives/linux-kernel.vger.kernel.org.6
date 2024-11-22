Return-Path: <linux-kernel+bounces-417933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50009D5AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FB1283126
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81218B466;
	Fri, 22 Nov 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EZV88gDT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E18230999;
	Fri, 22 Nov 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263813; cv=none; b=m2T/abWP3zdf2bnHrOYVopoJk+q5Lhz+JUMuaE1E08qxo5NhtOb+H0BcsnQGSmUMr3Hi5Wsn2Fp0bAJYKv2n+ch2Hg6mtSUCnhLd1kBEgoxZI933Ev2ZuZQ8r7ClwGqE555C2VRRi9+FkaE6yhZQNjN/6z6V1bhISUV4ctFBUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263813; c=relaxed/simple;
	bh=+90x8ipmdVX6miQf0anF1MHE4BoGxn0rjCkE+7vkBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FxWNh5MZFhsNk273gv63hcFEYzZHRYIzWDEkrIYJ7+2o9q5YvoSLMeATF/O5Gio/lX5rff2ZHnhD1MnSPQy+zZ8lue4mMaCotwC/DePb6cwQ3gvUPgBMhGgrraWwXqhOhYup/NqwXef7CPRvBsFeiQe1c9Qx0ZyvVV2hipYrHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EZV88gDT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM86Mjg015290;
	Fri, 22 Nov 2024 08:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXK88vdFCm1QXw1Qx9Uf7DVqi2cIBaB+sI6faAk7MhQ=; b=EZV88gDTQWSg4hO3
	zND8pQc9DjJWMy4NNgt+RSb6/wFxyZSipEyvVI/Rr6aqEmWMJv4VceMN9i+poKpQ
	/ZQSgkjUu/yQrB+54SZq/n/ETIPwreMJciEjBqqEJzYShrJVzvVuz0AlXYsEczJZ
	j8XiP1W8P/zX8kaK9xrNwcYdrpVtZseCYDoMsAYVHP+9prs0Th+/oJLcBtM9Hf0C
	9ZbMF7Ar9aTF4Ob/EQmTgsGQqq9ySgjS1xYvvTDVZvl9YLEuxRXHluW58wwTwCJE
	24seZ0tCi21oZnKYa8+1tKRGjSAGyt1KRkWH43dscdYqmZksm4LwAw+Z3tzvlVQ2
	hbuRGA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4320y9kfn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:23:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AM8NR3g020080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:23:27 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 22 Nov
 2024 00:23:24 -0800
Message-ID: <b0c787ad-55a1-4fb1-b9cd-1f688ea65316@quicinc.com>
Date: Fri, 22 Nov 2024 13:53:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "mwalle@kernel.org"
	<mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>
References: <TYUPR06MB62178D00DC96CC2702114CF5D2222@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB62178D00DC96CC2702114CF5D2222@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hxfozCmV-bRNx2zVD2IZRRfxl8lsTxu
X-Proofpoint-ORIG-GUID: 4hxfozCmV-bRNx2zVD2IZRRfxl8lsTxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220069



On 21-11-24 06:11 pm, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases,
> when u_serial driver is accessed by multiple threads,
> Thread A is executing the open operation and calling the gs_open,
> Thread B is executing the disconnect operation and calling the
> gserial_disconnect function,The port->port_usb pointer will be set to NULL.
> 
> E.g.
>     Thread A                                 Thread B
> 
>     gs_open()                                gadget_unbind_driver()
> 
You can remove these extra lines.
>     gs_start_io()                            composite_disconnect()
> 
>     gs_start_rx()                            gserial_disconnect()
>     ...                                      ...
>     spin_unlock(&port->port_lock)
>     status = usb_ep_queue()                  spin_lock(&port->port_lock)
>     spin_lock(&port->port_lock)              port->port_usb = NULL
>     gs_free_requests(port->port_usb->in)     spin_unlock(&port->port_lock)
>     Crash
> 
> This causes thread A to access a null pointer (port->port_usb is null)
> when calling the gs_free_requests function, causing a crash.
> 
> To avoid this, add a null pointer check to gs_start_io before attempting
> to access the value of the pointer port->port_usb.
> 
> Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000000e8
> pc : gs_start_io+0x164/0x25c
> lr : gs_start_io+0x238/0x25c
> sp : ffffffc08b75ba00
> x29: ffffffc08b75ba00 x28: ffffffed8ba01000 x27: 0000000000020902
> x26: dead000000000100 x25: ffffff899f43a400 x24: ffffff8862325400
> x23: ffffff88623256a4 x22: ffffff8862325690 x21: ffffff88623255ec
> x20: ffffff88623255d8 x19: ffffff885e19d700 x18: ffffffed8c45ae40
> x17: 00000000d48d30ad x16: 00000000d48d30ad x15: 0010000000000001
> x14: ffffffed8c50fcc0 x13: 0000000040000000 x12: 0000000000000001
> x11: 0000000080200012 x10: 0000000080200012 x9 : ffffff88623255d8
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : ffffffed8ae0b9a4 x4 : fffffffe267d0ea0 x3 : 0000000080200012
> x2 : ffffff899f43a400 x1 : 0000000080200013 x0 : ffffff899f43b100

These address lists can also omitted. And the below stack can be shortened.

> Call trace:
>  gs_start_io+0x164/0x25c
>  gs_open+0x108/0x13c
>  tty_open+0x314/0x638
>  chrdev_open+0x1b8/0x258
>  do_dentry_open+0x2c4/0x700
>  vfs_open+0x2c/0x3c
>  path_openat+0xa64/0xc60
>  do_filp_open+0xb8/0x164
>  do_sys_openat2+0x84/0xf0
>  __arm64_sys_openat+0x70/0x9c
>  invoke_syscall+0x58/0x114
>  el0_svc_common+0x80/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x38/0x68
>  el0t_64_sync_handler+0x68/0xbc
>  el0t_64_sync+0x1a8/0x1ac
> Code: f2fbd5ba eb14013f 540004a1 f940e708 (f9407513)
> ---[ end trace 0000000000000000 ]---
> 
> Suggested-by: Prashanth K <quic_prashk@quicinc.com>
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>

Include fixes tag and CC stable kernel.
> 
> v2:
>  - Modify patch content and description according to "v1 suggestion"
>  - Link to v1: https://lore.kernel.org/all/TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com/
> 
>  drivers/usb/gadget/function/u_serial.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 0a8c05b2746b..53d9fc41acc5 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -579,9 +579,12 @@ static int gs_start_io(struct gs_port *port)
>  		 * we didn't in gs_start_tx() */
>  		tty_wakeup(port->port.tty);
>  	} else {
> -		gs_free_requests(ep, head, &port->read_allocated);
> -		gs_free_requests(port->port_usb->in, &port->write_pool,
> -			&port->write_allocated);
> +		/* Free reqs only if we are still connected */
> +		if (port->port_usb) {
> +			gs_free_requests(ep, head, &port->read_allocated);
> +			gs_free_requests(port->port_usb->in, &port->write_pool,
> +				&port->write_allocated);
You can also mention in commit text that skip freeing reqs if port_usb
is null, since it will be done by gser_disconnect.  Maybe you can wait
for other people to review before sending next version.
> +		}
>  		status = -EIO;
>  	}
>  
Regards,
Prashanth K


