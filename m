Return-Path: <linux-kernel+bounces-293744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED19583E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A641C247B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7B18CBE9;
	Tue, 20 Aug 2024 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nZ5Aq8uj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67E18E374;
	Tue, 20 Aug 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148961; cv=none; b=Zd0CWtr8YDvoHDzkHW6SsIiB0fK3wlf5Ex+NhDDw/3CWympimQ9JUOeoWmnot/ra6lsuWPcoBZhrNMZa+b++JNAJrGCH4Cx/Pxtrbhdlt5JadQSJ+KlB7WYhBBxqCdQoMbZJGRq0fF1c1w64ZhfQ93UqnV/sFZ+sEGHaW4BV0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148961; c=relaxed/simple;
	bh=n6EpnwEQCDe4L7fXtQ9PDmiOKHb0n9V492GjwQhgZo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gRyRoukpDNgYHXJbpU393HW9lmV4UKOGNQjxqQVsXKNFNtKW07kfuk4jBJALYOHP+zxv60JkGHnMl/c+Z6eMeFNsD8qOi0Op0DUYfV9l+BlF8W1WUGXAYVvCfknJeiPAPa8TpTC+5s7reVgI6nOJLPjzQGGKod3Wp82sB+V50/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nZ5Aq8uj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K8En9e021350;
	Tue, 20 Aug 2024 10:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vokHMK54LAaNGaBzaKgJf6ny8vA9LLUy1X3MPPWKDrs=; b=nZ5Aq8ujjfXQJAbJ
	WUzN1WEHp5dSEgVSErFcYxZFLwZdyOgom7m8W9MzrHtIbrDY83/U1KcjkTFsJ2H5
	3ZNDjp4PjrWzktk1T7YIp+0CVspLNWfzEUCkj8IICWcAkNxqjLHAtGB/TO7TYdx9
	7FfvGJEi8+Oq/PKtZYw9+yv9jvJuSi5kpRka3f0qbtm+nf7nw+Ztm6TBgWV4ZLxm
	6heIgxeesZS6+cv7OFpkHTGUc9Gf3H3jShY/94NdxEMizqWXEP3QEjXRbcNk64Ft
	0HhN23+oUQPXVGe7EzKKUv9ZBtoyEftxfvSX2nTNLjUmC25y+c2Si+HXD9MjBDA2
	lJqLVg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412hjdfgn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:15:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KAFhhH029656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:15:43 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 20 Aug
 2024 03:15:40 -0700
Message-ID: <1a81f498-f7dd-86e6-74fa-fdeefad6a7b4@quicinc.com>
Date: Tue, 20 Aug 2024 15:45:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] usb: gadget: u_serial: check Null pointer in EP
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
References: <PUZPR06MB62242AA2715789D100FA2E60D28D2@PUZPR06MB6224.apcprd06.prod.outlook.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <PUZPR06MB62242AA2715789D100FA2E60D28D2@PUZPR06MB6224.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KZBsIUsPFNTVgWlIk6s5AFjs56YWSooS
X-Proofpoint-ORIG-GUID: KZBsIUsPFNTVgWlIk6s5AFjs56YWSooS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=713 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200076



On 20-08-24 02:59 pm, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Added null pointer check to avoid system crash.
Address whats becoming Null and why its happening
> 
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
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
> ---
> v2:
>   - Optimize code comments
>   - Delete log printing
> ---
>  drivers/usb/gadget/function/u_serial.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index b394105e55d6..65637d53bf02
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -454,6 +454,14 @@ static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
>  {
>  	struct gs_port	*port = ep->driver_data;
>  
> +	/* When port is NULL, return to avoid panic. */
> +	if (!port)
> +		return;
> +

This doesn't protect the port from going to NULL right after the above
the check. Since you mentioned gser_disconnect is making port to NULL,
add the serial_port_lock to protect port (just like its done on
gser_disconnect/suspend/resume). Something like this would do.

diff --git a/drivers/usb/gadget/function/u_serial.c
b/drivers/usb/gadget/function/u_serial.c
index f975dc03a190..a33f8cd871ac 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -451,10 +451,21 @@ static void gs_rx_push(struct work_struct *work)

static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
{
-       struct gs_port  *port = ep->driver_data;
+       struct gs_port  *port;
+       unsigned long   flags;
+
+       spin_lock_irqsave(&serial_port_lock, flags);
+       port = ep->driver_data;
+
+       if (!port) {
+               spin_unlock_irqrestore(&serial_port_lock, flags);
+               return;
+       }

-       /* Queue all received data until the tty layer is ready for it. */
       spin_lock(&port->port_lock);
+       spin_unlock(&serial_port_lock);
+
+       /* Queue all received data until the tty layer is ready for it. */
       list_add_tail(&req->list, &port->read_queue);
       schedule_delayed_work(&port->push, 0);
       spin_unlock(&port->port_lock);

>  	/* Queue all received data until the tty layer is ready for it. */
>  	spin_lock(&port->port_lock);
>  	list_add_tail(&req->list, &port->read_queue);
> @@ -465,6 +473,14 @@ static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
>  {
>  	struct gs_port	*port = ep->driver_data;
>  
> +   /* When port is NULL, return to avoid panic. */
> +	if (!port)
> +		return;
> +
>  	spin_lock(&port->port_lock);
>  	list_add(&req->list, &port->write_pool);
>  	port->write_started--;
Same here also

Best Regards,
Prashanth K

