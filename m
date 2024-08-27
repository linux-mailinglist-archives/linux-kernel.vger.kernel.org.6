Return-Path: <linux-kernel+bounces-302942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D10960554
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF7281D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216F19D88A;
	Tue, 27 Aug 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZYXni5yg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AB76056;
	Tue, 27 Aug 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750167; cv=none; b=kXO8gYHFkh2HFvLA/D81uxUaSBI0j4BJbZwMRWKpJ2+JYYeKLWvzPVTsZ2kniKr7lw/61Xufg4XALmgN+snSSi8QTTesONmQzSRWhhtRRie2lHVd31XSJS6lKCe+vbVRs/aNpVhz5aIMHuaYLW6GAucIwfiFeDgw5j3R8i2bbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750167; c=relaxed/simple;
	bh=Rlu5n1CgqQ9ZEns9yR69BhZINc/7WBPKiF+V3/BhUM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GoFrJdqOAKUAd71Qs8En/NdHDBo6zudh+3eyQiPoSSMeXm3qD3pRiL5yJK0XhTl9FrQLfF0GkCZ4HNErfY+o1GeRLK45g2Wit0MmxtCpu2/USO9wYrKSX3JFXh8TX6ZgcCVPuk06ffHoTV1MdeScjuJxg+IT4hWOgB9F2Mkbf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZYXni5yg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R7kf6C002653;
	Tue, 27 Aug 2024 09:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3J8Hej+cDjlPlbTqVxRoSC+EFUooWsxZ5wqv5MlLRRM=; b=ZYXni5ygVNuwr+u0
	yMLYdKz3CJJpRZf98lRs9QXb3bjM9J03KLyaB+CV310hBBKmBNNWnkahNPvCu/Ge
	vj56juvxJV0mF8ZCpS+gtdXCLU11k7tZG5hs55TCIKKWyIC6pmxDe2FI1pEfua7H
	SIrHJc+C1PlYV0ElZ7QCM0GVTKuboJz7LLVi7lawtoLDGEKnCis+wEYrK6HWiTzX
	jz9gGR2UJdkLTpBDkBLLAzHe9l3wAvH2ElwcducWz2nSktJQbOdFdxjZGG7aBtu+
	S5ZJSU1/4vx/ZEFVP23QVGnld02qo3kOrI4bdjSOifMrqUQBtx17Fm4WNox797TS
	Tx3MuQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419aq787s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 09:15:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R9Fwqm027511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 09:15:58 GMT
Received: from [10.216.25.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 02:15:54 -0700
Message-ID: <33fe50c8-cf98-bd04-87b7-06ec07cc9277@quicinc.com>
Date: Tue, 27 Aug 2024 14:45:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Content-Language: en-US
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        Michael Nazzareno Trimarchi
	<michael@amarulasolutions.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
References: <TYUPR06MB6217989A40FA4E18598DC694D28A2@TYUPR06MB6217.apcprd06.prod.outlook.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB6217989A40FA4E18598DC694D28A2@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m5IHa8Y4CKc8eL1K4JBhO3_MJb0dzaLL
X-Proofpoint-ORIG-GUID: m5IHa8Y4CKc8eL1K4JBhO3_MJb0dzaLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=865 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270069



On 25-08-24 01:58 pm, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases, when the unbind operation
> is being executed, gserial_disconnect has already cleared gser->ioport,
> and the controller has not stopped & pullup 0, sys.usb.config is reset

As mentioned by Michael earlier, avoid android specific (sys.usb.config)
operations.

> and the bind operation will be re-executed, calling gs_read_complete,
> which will result in accessing gser->iport, resulting in a null pointer
> dereference, add a null pointer check to prevent this situation.
> 
> Added a static spinlock to prevent gser->ioport from becoming
> null after the newly added check.
> 
> Unable to handle kernel NULL pointer dereference at

[...]
> 
> Fixes: c1dca562be8a ("usb gadget: split out serial core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v7:
>   - Remove code comments
>   - Update the commit text
>   - Add the Fixes tag
>   - CC stable kernel
>   - Add serial_port_lock protection when checking port pointer
>   - Optimize code comments
>   - Delete log printing

We usually indicate what had changed in each versions.
v7: Remove code comments
v6: xx
v5: xx
v4: xx
v3: xx
v2: Delete log printing

> ---
No need for this '---' here, just leave an empty line
>  drivers/usb/gadget/function/u_serial.c | 33 ++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index b394105e55d6..e43d8065f7ec 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -452,20 +452,43 @@ static void gs_rx_push(struct work_struct *work)
>  
>  static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct gs_port	*port = ep->driver_data;
> +	struct gs_port	*port;
> +	unsigned long  flags;
> +
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = ep->driver_data;
> +
> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, flags);
> +		return;
> +	}
>  
> -	/* Queue all received data until the tty layer is ready for it. */
>  	spin_lock(&port->port_lock);
> +	spin_unlock(&serial_port_lock);
> +
> +	/* Queue all received data until the tty layer is ready for it. */
>  	list_add_tail(&req->list, &port->read_queue);
>  	schedule_delayed_work(&port->push, 0);
> -	spin_unlock(&port->port_lock);
> +	spin_unlock_irqrestore(&port->port_lock, flags);
>  }
>  
>  static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct gs_port	*port = ep->driver_data;
> +	struct gs_port	*port;
> +	unsigned long  flags;
> +
> +	spin_lock_irqsave(&serial_port_lock, flags);
> +	port = ep->driver_data;
> +
> +	if (!port) {
> +		spin_unlock_irqrestore(&serial_port_lock, flags);
> +		return;
> +	}
>  
>  	spin_lock(&port->port_lock);
> +	spin_unlock(&serial_port_lock);
>  	list_add(&req->list, &port->write_pool);
>  	port->write_started--;
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

