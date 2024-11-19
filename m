Return-Path: <linux-kernel+bounces-414245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDD9D252B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7D2B2812C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB991CBE86;
	Tue, 19 Nov 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G6n4eP0b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1080211C;
	Tue, 19 Nov 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017244; cv=none; b=YOkPg5U5zdtMNsTZYzzD1/ZO4akXqmdV8e0E9m7rB6wcqAsO5/gNbd9RMVw82hKsjcE0SvIOMSJssgbuk42LXjPkLwgFVQDSe6ta4ZBCs6uUS+OCs/hs8wCsLntUeXFWfkGNwSXtkN4vfyQOvy4w1ZM1ez3glcK6ku9Fh8M6ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017244; c=relaxed/simple;
	bh=3Uy7zsZTwGSmBQsIHbEGllHv8zn6+L7Lp+weFduMDZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MwSpQdVPIHDf5RIYyGAtT+7fMkyr3BqFilY54awJe5LLYJi9iahXWOEsYj2cP7ybwm7FobWRpWlVc3+CN69XwissE33yKdMPWUoQ2RQdf5NtRoOeFOk4XXdauxjCSNrc/8lTK5ll3fq/cDrWMs33x86AKSklfXZ8J4sWLvAZdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G6n4eP0b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7o8nV027393;
	Tue, 19 Nov 2024 11:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5M+GK6BJ9w7KOgfnPP+ch4bonH0wtIx8kksK4Iwh29Y=; b=G6n4eP0bQUOusDRm
	Gga4CZsYs3+alC+8UOsZZgXIdN2ELfLAE7RdDLZmWIboFkBvFhZyFFdmDujWt+xs
	5coRueUw5QnF8ZOKEIE87p1sJe6FnAMQOBMcqQXIBr1TBKvyXB1dsA180+Et3gnq
	wlFdxUom1JQGTHCjqZPKIVvCLwPOUS2LL+0fvd9gxeIzX9xSiqrvY5mX2WfmQxno
	jtRn6od40IaGUXiL4cJPSFkELnqSzt9oWKJFJG7W7C/wIG0dN47r4yXRrOmLnDHV
	V0DNDvHMOonJuErAQbLsQK3731p0hfMBUXxpI3lEjwrPZO8T382IH7r43Kzv89dm
	IZziKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y6te81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 11:53:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJBrw1s030563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 11:53:58 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 03:53:55 -0800
Message-ID: <f15c5c40-d836-4995-ba7c-ef7470d1772f@quicinc.com>
Date: Tue, 19 Nov 2024 17:23:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_serial: Fix the issue that gs_start_io
 crashed due to accessing null pointer
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "mwalle@kernel.org"
	<mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>
References: <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fRwFPec0MKzK4WQMGUnPeI1RwSLqhq6y
X-Proofpoint-GUID: fRwFPec0MKzK4WQMGUnPeI1RwSLqhq6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190086



On 18-11-24 08:42 am, 胡连勤 wrote:
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Considering that in some extreme cases,
> when u_serial driver is accessed by multiple threads,
> Thread A is executing the open operation and calling the gs_open,
> Thread B is executing the disconnect operation and calling the
> gserial_disconnect function,The port->port_usb pointer will be set to NULL.
> 
[...]
> ---
>  drivers/usb/gadget/function/u_serial.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 0a8c05b2746b..9ab2dbed60a8 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -124,6 +124,7 @@ struct gs_port {
>  	struct kfifo		port_write_buf;
>  	wait_queue_head_t	drain_wait;	/* wait while writes drain */
>  	bool                    write_busy;
> +	bool                    read_busy;
>  	wait_queue_head_t	close_wait;
>  	bool			suspended;	/* port suspended */
>  	bool			start_delayed;	/* delay start when suspended */
> @@ -331,9 +332,11 @@ __acquires(&port->port_lock)
>  		/* drop lock while we call out; the controller driver
>  		 * may need to call us back (e.g. for disconnect)
>  		 */
> +		port->read_busy = true;
>  		spin_unlock(&port->port_lock);
>  		status = usb_ep_queue(out, req, GFP_ATOMIC);
>  		spin_lock(&port->port_lock);
> +		port->read_busy = false;
>  
>  		if (status) {
>  			pr_debug("%s: %s %s err %d\n",
> @@ -1412,19 +1415,21 @@ void gserial_disconnect(struct gserial *gser)
>  	/* tell the TTY glue not to do I/O here any more */
>  	spin_lock(&port->port_lock);
>  
> -	gs_console_disconnect(port);
> +	if (!port->read_busy) {
start_tx/rx rely on port->port_usb for queuing the requests, and if its
not null during disconnect, tx/rx would keep on queuing requests to UDC
even after disconnect (which is not ideal). Here in your case, after
read_busy is set, start_rx would queue something outside of spinlock,
meanwhile disconnect happens but port_usb is still valid (because
read_busy is set) and start_rx would break early. But start_tx could
continue queuing into disconnected UDC (if 'started' is non-zero, which
could happen due to timing). Can't you try something like this,

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -579,9 +579,12 @@ static int gs_start_io(struct gs_port *port)
                 * we didn't in gs_start_tx() */
                tty_wakeup(port->port.tty);
        } else {
-               gs_free_requests(ep, head, &port->read_allocated);
-               gs_free_requests(port->port_usb->in, &port->write_pool,
-                       &port->write_allocated);
+               /* Free reqs only if we are still connected */
+               if (port->port_usb) {
+                       gs_free_requests(ep, head, &port->read_allocated);
+                       gs_free_requests(port->port_usb->in,
&port->write_pool,
+                               &port->write_allocated);
+               }
                status = -EIO;
        }

This will skip freeing reqs (and your crash) if port_usb is null and
freeing would be taken care by disconnect callback.


> +		gs_console_disconnect(port);
>  
> -	/* REVISIT as above: how best to track this? */
> -	port->port_line_coding = gser->port_line_coding;
> +		/* REVISIT as above: how best to track this? */
> +		port->port_line_coding = gser->port_line_coding;
>  
> -	port->port_usb = NULL;
> -	gser->ioport = NULL;
> -	if (port->port.count > 0) {
> -		wake_up_interruptible(&port->drain_wait);
> -		if (port->port.tty)
> -			tty_hangup(port->port.tty);
> +		port->port_usb = NULL;
> +		gser->ioport = NULL;
> +		if (port->port.count > 0) {
> +			wake_up_interruptible(&port->drain_wait);
> +			if (port->port.tty)
> +				tty_hangup(port->port.tty);
> +		}
> +		port->suspended = false;
>  	}
> -	port->suspended = false;
>  	spin_unlock(&port->port_lock);
>  	spin_unlock_irqrestore(&serial_port_lock, flags);
>  
Regards,
Prashanth K

