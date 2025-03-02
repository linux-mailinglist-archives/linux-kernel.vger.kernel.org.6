Return-Path: <linux-kernel+bounces-540690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98663A4B3C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05113B0EEC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3321EB187;
	Sun,  2 Mar 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gynVeezE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3D322E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740936551; cv=none; b=AeR/qreKrQIyaOVyUdF0768QwRFhDEIegOJBCEC1bvE9JyT2LA24gBxH7AgOdNreROz7GWB5SqgcyprC2m7c+qXtvYI6QNBlbqnqU7iyCtkyHFIUfSkc7pZ5EN4HUQEoJiC5v7KsHqL4OWDjYPoLQLE1zg3HJr33nFn1UkaXKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740936551; c=relaxed/simple;
	bh=N9sLRvWMkdTRBrbOJ58Q0j1D6t6gq0WZbBij2+I4guk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl72BpnklNNsuPGhH3L4gq4gor5BoGH6pn6aPD0zZp9PnivWT/0qwiUHcozYKL+byj5MJCRc1qsliV1w3E2mtX43oPPzlK/OrDChAr++mD4MyBbwK/y0eKnU+e/gVFF0+YumttItPC5vAUGGxPopDj6b8DSMau8RGBb58PUjUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gynVeezE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52260f0L022636;
	Sun, 2 Mar 2025 17:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p9M0an
	i+vU9FgtUZfCm07TcwRXu/sPcqGJAqdQo24Vg=; b=gynVeezErB63J6y4JCdzGz
	vRz40SoSnTTf/mdjRoo1Q3he2xnn5ruBWjO2sQ3pB7Vxvpil3nalynSKid9yZwP0
	y0PNrMgbYsnAZCp+z1yWNQFnfrAQTVwEKJVVjPEeJaS7cLFX/fm/JhckH4Gd5pb9
	p3cw8R71wi2esZ7QlKnMzNcxf4q1+aBhCBmniEji1J+5C82jsmdtojFZeXlurz+l
	Er3WfxkR7/1ry6CoASeBa71BMUguPz3HFUjAP9jGJF0MsbxsMGYmaMCryBGYV0x+
	CPTF1/5erdJZ/aEpp3KIkKyf/YUpDhnxWsLMoaa2BhFwCh4VQR7bxVBsO7QDYKcg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454h82sy37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 17:28:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 522Drmnf032219;
	Sun, 2 Mar 2025 17:28:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjskcfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 17:28:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 522HSftS26608268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 17:28:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6900658058;
	Sun,  2 Mar 2025 17:28:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD0AB58057;
	Sun,  2 Mar 2025 17:28:38 +0000 (GMT)
Received: from [9.61.128.138] (unknown [9.61.128.138])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Mar 2025 17:28:38 +0000 (GMT)
Message-ID: <5bafe993-b78a-499f-9e57-3f315439f0cf@linux.ibm.com>
Date: Sun, 2 Mar 2025 22:58:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
 <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
 <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gge3y_9xcY1Si1uHrN8_HWcYdUEAbwoD
X-Proofpoint-ORIG-GUID: gge3y_9xcY1Si1uHrN8_HWcYdUEAbwoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_05,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=873 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503020141



On 2/28/25 6:44 PM, John Meneghini wrote:
> On 2/28/25 1:28 AM, Nilay Shroff wrote:
>> On 2/28/25 8:55 AM, John Meneghini wrote:
>>> The new NVME_MULTIPATH_PARAM config option requires updates
>>> to the warning message in nvme_init_ns_head(). Remove
>>> the old warning message and add new ones.
>>>
>>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>>> ---
>>>   drivers/nvme/host/core.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 818d4e49aab5..c2b7e6834535 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>>>               dev_warn(ctrl->device,
>>>                   "Found shared namespace %d, but multipathing not supported.\n",
>>>                   info->nsid);
>>> +#ifdef CONFIG_NVME_MULTIPATH
>>> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
>>> +            dev_warn_once(ctrl->device,
>>> +                "Shared namespace support requires core.nvme_multipath=Y.\n");
>>> +
>>> +#endif
>>> +#else
>>>               dev_warn_once(ctrl->device,
>>> -                "Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>>> +                "Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
>>> +#endif
>>>           }
>>>       }
>>>   
>>
>> As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies
>> that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
>> So above logic could be simplified.
>>
>> However on another note, I really don't understand why do we need to add
>> new warning here as there's already a warning present just above your
>> changes.
> 
> Agreed.  How about if we just remove the
> 
>        dev_warn_once(ctrl->device,
>         "Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>  
> This is real problem.  This is a confusing message since there is no now plan to remove any of these config options from the kernel.
I read it as "NVMe (native) multipathing is only supported when CONFIG_NVME_MULTIPATH
is configured". 

So personally, I find existing warning messages (we print two warning messages when 
multipath is false but shared namespace is detected) sufficient, however lets see 
what others suggest.

Thanks,
--Nilay 

