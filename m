Return-Path: <linux-kernel+bounces-414302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0409D2617
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985B9B2C08C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123A1CBEA9;
	Tue, 19 Nov 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y6IjRfQ8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCEE192D77;
	Tue, 19 Nov 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020259; cv=none; b=oONckAjVuKR/tRgoS5etaHAOq7R6unZt6eIaNiO0m+zBWEQM63qyWVgek3GLQLcdxLGDhR88g+5HiCpB6NDokzaNHT9EEIQ9LrwLCpdUvkgUEt3P0IX3J7MkowGd310Yxrk0GkMjqh+7VCOGqSB4mnseGUgx6dSzAabNwDylUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020259; c=relaxed/simple;
	bh=WHOwspanmoDRiWvz/aAn7dETTn50KHVLm5y3GArSCl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g0OoLSk/YeR9M4cq37vDtEsKRd+NVjwk6GytCbmyBZfZ2jpOuvOr0tbQmTYolKKOZ8BYfMjqPY7XwAqNRe3tT/7TqL/jvBEZZn3p4OmozRxCZtIljyWzRx1Filr4Y+lsCOwiLEKYdz1YA8QdU/6vtjG5aIa04BRcsoNOC5HYNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y6IjRfQ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7iH1m005821;
	Tue, 19 Nov 2024 12:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ZWmgxubuTmp5pKQEsIt/iQ8R6Wub2bmEZBLqWm2aAM=; b=Y6IjRfQ8yVdeHTH8
	XZ4LtqQ1FkHK4QH5KZz9a7JhGMIAeTEfj89NRHyTuvX62C0vpXH2PBKGgwP2Ufr1
	tWNNpD8Rug7OwS9Gl0TILu0mGqTJXglAOs2GN9b4K5m7QHEviTJsy94yZuCgYyhX
	8auylOB1l4jrWYSlxqfOj2d8uAY85jSrtX6UXgLGWpEbU24cn+GX7V4ykSOdF7s4
	c4Lekjq5kIXpHkZPcRi7Dc+Yv+ao4caYr71iGTla4ccy5RgoAWo6HaLCLRLXsVQ3
	12zG1GPp2FgSfbtRnHt7ByCl51fWMS+R0XFD19kgSh+nwsQdZoNRcYoDf10o2tO+
	GIFPhw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y92hse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:44:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJCiCln029683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:44:12 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 04:44:10 -0800
Message-ID: <e0bc3168-ef0e-480d-a794-d7594c9dc7fb@quicinc.com>
Date: Tue, 19 Nov 2024 18:14:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSB1c2I6IGdhZGdldDogdV9zZXJpYWw6?=
 =?UTF-8?Q?_Fix_the_issue_that_gs=5Fstart=5Fio_crashed_due_to_accessing_null?=
 =?UTF-8?Q?_pointer?=
To: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "mwalle@kernel.org"
	<mwalle@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>
References: <TYUPR06MB621737D16F68B5ABD6CF5772D2272@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <f15c5c40-d836-4995-ba7c-ef7470d1772f@quicinc.com>
 <TYUPR06MB62173B558D42E47CD7BCDF7AD2202@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <TYUPR06MB62173B558D42E47CD7BCDF7AD2202@TYUPR06MB6217.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GnkT9wx4MzRXWrlyYHCxH_myfPhJoAAK
X-Proofpoint-ORIG-GUID: GnkT9wx4MzRXWrlyYHCxH_myfPhJoAAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190093



On 19-11-24 06:03 pm, 胡连勤 wrote:
> Hello Prashanth:
> 
>>> Considering that in some extreme cases, when u_serial driver is
>>> accessed by multiple threads, Thread A is executing the open operation
>>> and calling the gs_open, Thread B is executing the disconnect
>>> operation and calling the gserial_disconnect function,The
>>> port->port_usb pointer will be set to NULL.
>>>
>> [...]
>>> ---
>>>  drivers/usb/gadget/function/u_serial.c | 25 +++++++++++++++----------
>>>  1 file changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/u_serial.c
>>> b/drivers/usb/gadget/function/u_serial.c
>>> index 0a8c05b2746b..9ab2dbed60a8 100644
>>> --- a/drivers/usb/gadget/function/u_serial.c
>>> +++ b/drivers/usb/gadget/function/u_serial.c
>>> @@ -124,6 +124,7 @@ struct gs_port {
>>>  	struct kfifo		port_write_buf;
>>>  	wait_queue_head_t	drain_wait;	/* wait while writes drain */
>>>  	bool                    write_busy;
>>> +	bool                    read_busy;
>>>  	wait_queue_head_t	close_wait;
>>>  	bool			suspended;	/* port suspended */
>>>  	bool			start_delayed;	/* delay start when
>> suspended */
>>> @@ -331,9 +332,11 @@ __acquires(&port->port_lock)
>>>  		/* drop lock while we call out; the controller driver
>>>  		 * may need to call us back (e.g. for disconnect)
>>>  		 */
>>> +		port->read_busy = true;
>>>  		spin_unlock(&port->port_lock);
>>>  		status = usb_ep_queue(out, req, GFP_ATOMIC);
>>>  		spin_lock(&port->port_lock);
>>> +		port->read_busy = false;
>>>
>>>  		if (status) {
>>>  			pr_debug("%s: %s %s err %d\n",
>>> @@ -1412,19 +1415,21 @@ void gserial_disconnect(struct gserial *gser)
>>>  	/* tell the TTY glue not to do I/O here any more */
>>>  	spin_lock(&port->port_lock);
>>>
>>> -	gs_console_disconnect(port);
>>> +	if (!port->read_busy) {
>> start_tx/rx rely on port->port_usb for queuing the requests, and if its not
>> null during disconnect, tx/rx would keep on queuing requests to UDC even
>> after disconnect (which is not ideal). Here in your case, after read_busy is set,
>> start_rx would queue something outside of spinlock, meanwhile disconnect
>> happens but port_usb is still valid (because read_busy is set) and start_rx
>> would break early. But start_tx could continue queuing into disconnected
>> UDC (if 'started' is non-zero, which could happen due to timing). Can't you try
>> something like this,
>>
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -579,9 +579,12 @@ static int gs_start_io(struct gs_port *port)
>>                  * we didn't in gs_start_tx() */
>>                 tty_wakeup(port->port.tty);
>>         } else {
>> -               gs_free_requests(ep, head, &port->read_allocated);
>> -               gs_free_requests(port->port_usb->in, &port->write_pool,
>> -                       &port->write_allocated);
>> +               /* Free reqs only if we are still connected */
>> +               if (port->port_usb) {
>> +                       gs_free_requests(ep, head, &port->read_allocated);
>> +                       gs_free_requests(port->port_usb->in,
>> &port->write_pool,
>> +                               &port->write_allocated);
>> +               }
>>                 status = -EIO;
>>         }
>>
>> This will skip freeing reqs (and your crash) if port_usb is null and freeing
>> would be taken care by disconnect callback.
>>
>>
> First of all, the patch you gave can solve the problem we are currently facing.
> 
> When we first encountered this problem, we also thought about adding a null check operation to deal with it,
> but we saw that the entry of this function (gs_start_io) had a null check operation for port->port_usb, so I gave up
> the idea of ​​null check during free_req (maybe I made a simple problem complicated),
> and thought about optimizing it from the software logic, so that the port->port_usb pointer is always valid before gs_start_io is executed.
> 

If it solves the problem, i guess you can use the null pointer check as
I suggested and send a new patchset, the current one will introduce new
problems. Keep the issue analysis as it is in commit text since its
descriptive enough to understand the problem.

Regards,
Prashanth K


