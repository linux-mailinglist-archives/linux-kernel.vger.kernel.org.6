Return-Path: <linux-kernel+bounces-298385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DE95C68F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C075B1F24D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657013C3F6;
	Fri, 23 Aug 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LIbLMu7Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673E3D994;
	Fri, 23 Aug 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398471; cv=none; b=GL5T8yMaHOCqLUnEqKhwP/JP6u16HpwZML9DYN3t0MXBKWotqk/Pow8mME8p+ye0+fdlUPkGUKz8SmG0fIffUAshuEuSvx1Bc6oAzPIFEHO/wiFNt5yCSLGo2naMqfeCEzOwh8VSAuPRWW8G1UjAC1D2H+Vh+JijH45UQpAHxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398471; c=relaxed/simple;
	bh=6pc+RGYqN2CC8mU9RvBq51KKUzS3wd2glfVe4iOsSUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WJRz7S2DU3GteH0FmRaoleTat/CwHT9JEVPpPpSxrrb74OeF5StciR4j/Sa0fcTRoUXyJCm8yhgtpr3LpTBsdVW88nVLTTm4baZz48uIZ1klWT+tjrEEDC3zN3AifT4xwVNQX82+2jVOTdRdHVBAhdbF//90PJN495YuyzS/XvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LIbLMu7Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N0L79O007768;
	Fri, 23 Aug 2024 07:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8RkPxVYZW4NOOnL9BOpJQ5RCOqSMD2P4miKf7zsxB1Q=; b=LIbLMu7ZtgAu4fLO
	kGM7cgnC2II94GFMO0pcY9SbSWFW+5HQfug2VMrQPLFaMuXkQ5121VHgR/skCXS3
	fca+CMWOJBXYrL/vDkM+P/15BBbnDcF+0SGPf7Gw0PM+TFukzU818QVqf7GwK9SG
	sOUKJtxMjA9lGSJSifveK39jBP4LDqwYwG8uM2VeG6PetcdmlqAP7HmRfm+h2KGi
	q36J717S63XtvOZi1MZ4nmI1ydhV9KQ0VjUf0Vp7L9fxZLSOod3eORXqD4/I/GmI
	KB6+dBrPEdAhQHNNkb6qsnQqIzdyayLN6r8FUcS3WTO+k1p2WUFWj+6DHK2/chxM
	+09org==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pe5tbnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 07:34:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47N7YQZi031808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 07:34:26 GMT
Received: from [10.216.13.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 00:34:23 -0700
Message-ID: <8ab0ca38-1bf4-ed3e-eef0-cbed2a524b34@quicinc.com>
Date: Fri, 23 Aug 2024 13:04:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6] usb: gadget: u_serial: Add null pointer check in
 gs_read_complete & gs_write_complete
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel <opensource.kernel@vivo.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
References: <TYUPR06MB62171A7BF25AB6963CBA07FED28F2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024082251-grief-profanity-b0da@gregkh>
 <TYUPR06MB62176043F3E6D6B6675301D3D2882@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwnz01F28kw12ZN5k3usTcCBMKpFJpAXTaYBZ_3zgWQU3Q@mail.gmail.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <CAOf5uwnz01F28kw12ZN5k3usTcCBMKpFJpAXTaYBZ_3zgWQU3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ynVzx0SeR6dI2ZjvOG4X7t1zool8w47k
X-Proofpoint-GUID: ynVzx0SeR6dI2ZjvOG4X7t1zool8w47k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_04,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=759 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408230053



On 23-08-24 12:28 pm, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Fri, Aug 23, 2024 at 8:40 AM 胡连勤 <hulianqin@vivo.com> wrote:
>>
>> Hello linux community expert:
>>
>>>> Fixes: c1dca562be8a ("usb gadget: split out serial core")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
>>>> ---
>>>> v6:
>>>>   - Update the commit text
>>>>   - Add the Fixes tag
>>>>   - CC stable kernel
>>>>   - Add serial_port_lock protection when checking port pointer
>>>>   - Optimize code comments
>>>>   - Delete log printing
>>
>>> You need to list ALL of the versions here, I seem to have missed v4 and
>>> v5 somewhere so I don't know what changed there.
>>

[...]
>>> nested spinlocks, why?  Did you run this with lockdep enabled to verify you aren't hitting a different bug now?
>>  Because there is a competition relationship between this function and the gserial_disconnect function,
>>  the gserial_disconnect function first obtains serial_port_lock and then obtains port->port_lock.
>>  The purpose of nesting is to ensure that when gs_read_complete is executed, it can be successfully executed after obtaining serial_port_lock.
>>  gserial_disconnect(..)
>>  {
>>         struct gs_port  *port = gser->ioport;
>>         ...
>>         spin_lock_irqsave(&serial_port_lock, flags);
>>         spin_lock(&port->port_lock);
>>         ...
>>         gser->ioport = NULL;   ---> port = NULL;
>>         ...
>>         spin_unlock(&port->port_lock);
>>         spin_unlock_irqrestore(&serial_port_lock, flags);
>>  }
>>
>> After enabling the lockdep function (CONFIG_DEBUG_LOCK_ALLOC=y), there is no lockdep-related warning information.
>>
>>> And why is one irqsave and one not?  That feels odd, it might be right, but you need to document here why the difference.
>>  After the gs_read_complete function is executed, spin_unlock_irqrestore is used to restore the previous state，
> 
> 胡连勤 this is not a common locking pattern that is the reason that
> should be properly described.
This pattern was already used on gser_suspend/resume callbacks, this was
done because the lock was stored under port (and port itself was
becoming null), hence we added a static spinlock to mitigate it.
> 
>> -       /* Queue all received data until the tty layer is ready for it. */
>>         spin_lock(&port->port_lock);
>> +       spin_unlock(&serial_port_lock);
>> +
>> +       /* Queue all received data until the tty layer is ready for it. */
>>         list_add_tail(&req->list, &port->read_queue);
>>         schedule_delayed_work(&port->push, 0);
>> -       spin_unlock(&port->port_lock);
>> +       spin_unlock_irqrestore(&port->port_lock, flags);   ---> Here we use spin_unlock_irqrestore to restore the state
>>  }
>>
>> Thanks
> 
> Thank you

