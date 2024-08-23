Return-Path: <linux-kernel+bounces-298593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98B95C930
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717F32857E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C91514C9;
	Fri, 23 Aug 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UF+I0aum"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA639139D00;
	Fri, 23 Aug 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405167; cv=none; b=fq1O1k4TnnEVXi0GHChox+giX03+RUhhMbUznb1KTJAU/kLawf4AvZGXjO56fgnEgWbKM6X5KmSVfmbey3uLssQ8hKc6ezswJCDP0Q2KFAxwfg25e8EFrubrvCW41HXPtMZXDyweU4hB9hF1lfmrJ7v7/QV3dyw3bA83pnWnTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405167; c=relaxed/simple;
	bh=KKURVbxpG44VWHQ8FWkQZv5L5eQkvOOa/qKmI5gdZ0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HASEVOzezru+lVdWOoZsXYT2XpeBuugwlVI3MR5SprByP0AXTlaSYYlU3s0Vt4jpjc7GKYuMfPNmRb87jm9fnvjSO7JoN32H0LXYWl4lYSC1LGok0xxTubyh/MEvIceNtNAAiuIQ5WA1OKyCqurtJ8cKQczN71RlPFi1gwhKus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UF+I0aum; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MNa5fK020311;
	Fri, 23 Aug 2024 09:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vAHQCZzWqtt2MygJQz2IfCsu8bOuoX9ZCdyweAATd5I=; b=UF+I0aum+7h0M1At
	GPHAGk9sxJyxFaXgF6DZp9pYGH/2ZwtGEjeuCZzspoxJSrqjyBpKSxuKtwqbAH40
	npkMXtyPbGhASCPknWP//BRt1fOZ4s56I440JrwmHUZo+c9ME2CayuCX/FU8159A
	nMOiBcUiRuVV8j59X1wFu52GropvRM0Aj87FARUsWpEWBXNXpgrG+c/XmPb1oGjL
	VHbpJOsmZHu+JNib1DM+2a6KDRcbVZ5XvZpkQYT9c8CrzJPbmSuaYw4+FSbGEujG
	I0YRl++nsGxmrTY2NZ3OBNLxdVEOVNLKB+aJzjH22z9d9uOk5U7VHqiFTwrSkHUl
	5wTNQQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415bkwfb2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 09:25:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47N9PsrN032446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 09:25:54 GMT
Received: from [10.216.13.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 23 Aug
 2024 02:25:51 -0700
Message-ID: <64ad7661-4551-7b00-604b-6e15da23a1c7@quicinc.com>
Date: Fri, 23 Aug 2024 14:55:47 +0530
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
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: =?UTF-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
 <8ab0ca38-1bf4-ed3e-eef0-cbed2a524b34@quicinc.com>
 <CAOf5uwmQ_drN9xE88Eyf01kmh=GLwitLCSo7KxiNDE9-h-D0KQ@mail.gmail.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <CAOf5uwmQ_drN9xE88Eyf01kmh=GLwitLCSo7KxiNDE9-h-D0KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e1m-iiWoz4GnVk8S904-SNy0nI59qEZL
X-Proofpoint-GUID: e1m-iiWoz4GnVk8S904-SNy0nI59qEZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_06,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=686 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230068



On 23-08-24 01:27 pm, Michael Nazzareno Trimarchi wrote:
> Hi Prashanth
> 
> On Fri, Aug 23, 2024 at 9:34 AM Prashanth K <quic_prashk@quicinc.com> wrote:
>>
>>
>>
>> On 23-08-24 12:28 pm, Michael Nazzareno Trimarchi wrote:
>>> Hi
>>>
>>> On Fri, Aug 23, 2024 at 8:40 AM 胡连勤 <hulianqin@vivo.com> wrote:
>>>>
>>>> Hello linux community expert:
>>>>
>>>>>> Fixes: c1dca562be8a ("usb gadget: split out serial core")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
>>>>>> ---
>>>>>> v6:
>>>>>>   - Update the commit text
>>>>>>   - Add the Fixes tag
>>>>>>   - CC stable kernel
>>>>>>   - Add serial_port_lock protection when checking port pointer
>>>>>>   - Optimize code comments
>>>>>>   - Delete log printing
>>>>
>>>>> You need to list ALL of the versions here, I seem to have missed v4 and
>>>>> v5 somewhere so I don't know what changed there.
>>>>
>>
>> [...]
>>>>> nested spinlocks, why?  Did you run this with lockdep enabled to verify you aren't hitting a different bug now?
>>>>  Because there is a competition relationship between this function and the gserial_disconnect function,
>>>>  the gserial_disconnect function first obtains serial_port_lock and then obtains port->port_lock.
>>>>  The purpose of nesting is to ensure that when gs_read_complete is executed, it can be successfully executed after obtaining serial_port_lock.
>>>>  gserial_disconnect(..)
>>>>  {
>>>>         struct gs_port  *port = gser->ioport;
>>>>         ...
>>>>         spin_lock_irqsave(&serial_port_lock, flags);
>>>>         spin_lock(&port->port_lock);
>>>>         ...
>>>>         gser->ioport = NULL;   ---> port = NULL;
>>>>         ...
>>>>         spin_unlock(&port->port_lock);
>>>>         spin_unlock_irqrestore(&serial_port_lock, flags);
>>>>  }
>>>>
>>>> After enabling the lockdep function (CONFIG_DEBUG_LOCK_ALLOC=y), there is no lockdep-related warning information.
>>>>
>>>>> And why is one irqsave and one not?  That feels odd, it might be right, but you need to document here why the difference.
>>>>  After the gs_read_complete function is executed, spin_unlock_irqrestore is used to restore the previous state，
>>>
>>> 胡连勤 this is not a common locking pattern that is the reason that
>>> should be properly described.
>> This pattern was already used on gser_suspend/resume callbacks, this was
>> done because the lock was stored under port (and port itself was
>> becoming null), hence we added a static spinlock to mitigate it.
>>>
> I see now, but why don't disable the endpoint before disconnecting?
> 
> /* disable endpoints, aborting down any active I/O */
> usb_ep_disable(gser->out);
> usb_ep_disable(gser->in);
> 
> Michael
> 
Not sure about this case, I think generally we need stop IO before
disabling EP, otherwise TX/RX functions may queue requests while EP is
getting disabled, thats why i think port is removed before ep_disable.
Moreover these callbacks (complete/suspend/resume etc) comes from UDC
and can be async, so better to use locks to prevent these kind of races.

Regards,
Prashanth K

