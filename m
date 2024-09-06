Return-Path: <linux-kernel+bounces-319143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BEB96F873
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2622281306
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BD1D2F6E;
	Fri,  6 Sep 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+HlsD2b"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D761C8FCE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637088; cv=none; b=VKfu/vPHGn+aWC+eYsjBNxtzs6ix6ruKbQMdUlE1okA4bSnQHYOjzEqjRORXaq+sbSAP65hz6wMKIXc6Frojm8HlwNgbclBIZVDZih+42oGq6+FrzJbb1N3KI+pi8RVKcdDA9aQBjCiJHtjVcg34SMZG5yhhX7YP/ce0qMZh+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637088; c=relaxed/simple;
	bh=Fbwhku1H3Hv6CXpiNrpiJsXJmT0rO8n01IkZMIWnkok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svE4BJ3TfnvrCSHWS+PB0nMaIDBc0yRI6lx7Q1fSRAINHbqig1No9UYI39i/maVzosuBAV7YYTs3VluekzpqnbS4O9QndtMgnC7zCfvFKJof+qN9PZ8S2xjbxDgWT99QG0eyqfiPGL69NKXMCegni9KXkDGPIluqOeWjBPQ0pIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R+HlsD2b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4868GQqQ019213;
	Fri, 6 Sep 2024 15:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=1SgdAixw3Dva4vhzmvhrbo0SJvloO8Mj7vL3piT8bK8=; b=R+HlsD2bllEg
	QhoeLPFz2HwV6eLv+JWoC5VzRfgkhqCOvb9jaJAK1fCyXhKYGRgokTySoa9Np7Hv
	QXqlxpmkKjWZ36RCZEiN+lCc094bEITMprfRQBm6UgmWK2WDuCdvSWlZF/vfaLCF
	6P8YYFnEkMObS7dm4aC3S6u+hiBskxKNJ5u/4DdQTsQe8y/th9tgqCP+ux4fwx6c
	Pg0rybJeEdGRo8LTqYZa2LeO3QRCkRF+QDzqs5ygD4yNsHyCcHM8t7sIFCO9qw03
	D464UoHaFtX6fsF3ER3OuoQr+Yo573wu7/jQ+Gw9jmRVGjjKFU/9ZbtLNmVJRfL7
	aJ21x5vg6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj1m4w0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 15:37:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 486FWtt4032070;
	Fri, 6 Sep 2024 15:37:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj1m4w0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 15:37:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 486BwP3V000480;
	Fri, 6 Sep 2024 15:37:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41fj494cf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 15:37:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 486Fbl9W58720742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 15:37:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03C058060;
	Fri,  6 Sep 2024 15:37:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322AB58056;
	Fri,  6 Sep 2024 15:37:40 +0000 (GMT)
Received: from [9.43.122.119] (unknown [9.43.122.119])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Sep 2024 15:37:39 +0000 (GMT)
Message-ID: <237bc4c4-101a-4124-b7db-8c461825e22c@linux.ibm.com>
Date: Fri, 6 Sep 2024 21:07:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Josh Don <joshdon@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240829220427.2764399-1-joshdon@google.com>
 <e915c024-9a53-4736-9194-988e5cdd06a3@linux.ibm.com>
 <CABk29Nsx3cX=GmO0OSH5N_Ggqyi7iUxtVxU+yhHDKJW6y7h9JQ@mail.gmail.com>
Content-Language: en-US
Reply-To: CABk29Nsx3cX=GmO0OSH5N_Ggqyi7iUxtVxU+yhHDKJW6y7h9JQ@mail.gmail.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CABk29Nsx3cX=GmO0OSH5N_Ggqyi7iUxtVxU+yhHDKJW6y7h9JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcCWHoz7iQNaFt1YtfMd0fLhIS8-2mAx
X-Proofpoint-ORIG-GUID: cqIOIMmbuBe39TD-tLYVMzMmsHPanbaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060115

Hi Josh Don,

On 04/09/24 03:03, Josh Don wrote:
> Hi Madadi,
> 
> On Sun, Sep 1, 2024 at 7:25 AM Madadi Vineeth Reddy
> <vineethr@linux.ibm.com> wrote:
>>
>> Hi Josh Don,
>>
>> On 30/08/24 03:34, Josh Don wrote:
>>> Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
>>> a WARN when a per-task affinity assignment races with a cpuset update.
>>>
>>> Specifically, we can have a race where a cpuset update results in the
>>> task affinity no longer being a subset of the cpuset. That's fine; we
>>> have a fallback to instead use the cpuset mask. However, we have a WARN
>>> set up that will trigger if the cpuset mask has no overlap at all with
>>> the requested task affinity. This shouldn't be a warning condition; its
>>> trivial to create this condition.
>>>
>>> Reproduced the warning by the following setup:
>>>
>>> - $PID inside a cpuset cgroup
>>> - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
>>> - another thread repeatedly setting the $PID affinity (via taskset) to 2
>>>
>>
>> I was testing the patch using the following two scripts run concurrently:
>>
>> Script 1:
>> while true; do
>>     echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
>>     echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
>> done
>>
>> Script 2:
>> while true; do
>>     sudo taskset -p 0x2 $$;
>> done
>>
>> However, I am unable to trigger the warning in dmesg on the unpatched kernel.
>> I was expecting to see the warning as described, but it doesn't seem to appear.
>>
>> Additionally, I also tried the following script to increase the chances of
>> triggering the race condition:
>>
>> while true; do
>>     echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
>>     sudo taskset -p 0x2 $$;
>>     sleep 0.1;
>>     echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
>> done
>>
>> Despite this, the warning still does not appear in dmesg.
>>
>> Am I missing something in my testing approach, or is there a different setup
>> required to reproduce the issue?
> 
> taskset -p 0x2 $$ will affine to cpu 1 :)
> 
> I'd recommend using the '-c' arg to specify the mask as a cpulist, as
> it is easier to validate.
> 
> taskset -c -p 2 $$
> 

Thanks for the clarification.

Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy

>>
>> Thanks and Regards
>> Madadi Vineeth Reddy
>>
>>> Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask")
>>> Signed-off-by: Josh Don <joshdon@google.com>
>>
> 
> Best,
> Josh


