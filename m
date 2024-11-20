Return-Path: <linux-kernel+bounces-415982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631089D3EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A321F24958
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84991B5ED2;
	Wed, 20 Nov 2024 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M+FUHra/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535131A9B3B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115242; cv=none; b=H8AGgljvw46g6lvTqRWUbvKZeLiy/T20qLfYUMCqufmg9ot4NtfAoPVqtAQfkEO+KlQFPxTX4pSi/V05IIu3DH56P9bAPsA38rp38fXsAeSQEwHNNC3yCuBvNKW4etnEDBVOos+LiI7xkyxyy9TvxG1tUM8/iPsjEfA9FyqdCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115242; c=relaxed/simple;
	bh=1t/6N9hCHjBXgTRsjuiN0ajPB6aEzlYX+6CiXhj9TwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MrMnDGwNlmeREgyIKWhCmhfPLDq6Mcbhi+AJYh0enk0YWd3mJs+OPQXZO/KRCjxEixQ6fCW0VTUpFhZKv6kV0k08Q6x4pMxdDkxYu+fIZzHpMyZ7/FVTMZL5HKpiU3z2sZS9FW/l8y4OLoe7OjVF7q75F1vIK2xfAO1m8lwOE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M+FUHra/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK7gCb1027509;
	Wed, 20 Nov 2024 15:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MNtJV4GQJxQNjXf05f1XeKL9OhkbYi
	YRSSqjWf9gb6o=; b=M+FUHra/I84fgjGUSc0PSMD7gsm+RhVtYoKstFozzAEoz4
	Twrxgym/RTBie3M5Y7XprVWUfaL59JqR/qXe7UvbocVLgYybS0mdkguapv8+6hqA
	h6BeO+22rQjYYKNk9lqiBB4LX9PO9N8XZJeWplwYu61ARGL+fYjh6LnI8tkl5bU1
	hBxW9wvyp7eVBxYBrqmKF+4S2NbMN5UA+scIr8SOk7ky9jZEJTa+3AyCqR9gi+ee
	Swgo013Xc3Lntj6/W+dZAxIU7R9QoGzvHJvzrvk9mkoriZL6SX+7r/p7Afr3mBOr
	T1x/PXkv5NfMrWIkWvrKdR0zxzJu5h4FfyAwS7hA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjwjk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:07:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AKEZ8x4001403;
	Wed, 20 Nov 2024 15:07:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xhtjwjjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:07:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKE3o5c030920;
	Wed, 20 Nov 2024 15:07:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63yvhr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 15:07:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKF6ukg54460840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:06:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CE4A2004B;
	Wed, 20 Nov 2024 15:06:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F76020043;
	Wed, 20 Nov 2024 15:06:52 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.221.111])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 20 Nov 2024 15:06:52 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 20 Nov 2024 20:36:51 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Narayana Murty N
 <nnmlinux@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org,
        ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: Fix get PE state translation
In-Reply-To: <87ttc8d0vf.fsf@gmail.com>
References: <20241107042027.338065-1-nnmlinux@linux.ibm.com>
 <87ttc8d0vf.fsf@gmail.com>
Date: Wed, 20 Nov 2024 20:36:51 +0530
Message-ID: <87cyiq3px0.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ch3WGdkmSRlpPittI8EafON0y6XvPe1r
X-Proofpoint-GUID: nDR0RN2ZvcaybgFb48LL70CR94XwNhBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411200100

Hi Ritesh,

Thanks for looking into this patch. My responses on behalf of Narayana
below:

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>
>> The PE Reset State "0" obtained from RTAS calls
>> ibm_read_slot_reset_[state|state2] indicates that
>> the Reset is deactivated and the PE is not in the MMIO
>> Stopped or DMA Stopped state.
>>
>> With PE Reset State "0", the MMIO and DMA is allowed for
>> the PE.
>
> Looking at the PAPR spec - I do agree that it states the same. i.e.
> The "0" Initial PE state means the "Not Reset", "Load/Store allowed" &
> "DMA allowed" (Normal Operations). 
>
>> The function pseries_eeh_get_state() is currently
>> not indicating that to the caller because of  which the
>> drivers are unable to resume the MMIO and DMA activity.
>
> It's new to me, but could you help explain the user visible effect
> of what gets broken. Since this looks like pseries_eeh_get_state() has
> always been like this when it got first implemented.
> Is there also a unit test somewhere which you are testing?
Without this patch a userspace process performing VFIO EEH-Recovery wont
get the correct indication that EEH recovery is completed. Test code at
[2] has an example test case that uses VFIO to inject an EEH error on to
a pci-device and then waits on it to reach 'EEH_PE_STATE_NORMAL' state
. That state is never reached without this patch.

[2] :
https://github.com/nnmwebmin/vfio-ppc-tests/commit/006d8fdc41a4

>
> IIUC eeh_pe_get_state() was implemented[1] for supporting EEH for VFIO PCI
> devices. i.e. the VFIO_EEH_PE_GET_STATE operation of VFIO EEH PE ioctl op
> uses pseries_eeh_get_state() helper to query PE state on pseries LPAR.
> So are you suggesting that EEH functionality for VFIO PCI device was
> never enabled/tested before on pseries?
VFIO-EEH had been broken for pseries for a quite some time and was
recently fixed in kernel. So this issue was probably not discovered
until recently when we started testing with userspace VFIO.

>
> [1]: https://lore.kernel.org/all/1402364517-28561-3-git-send-email-gwshan@linux.vnet.ibm.com/
>
> Checking the powernv side of implementation I do see that it does
> enables the EEH_STATE_[MMIO|DMA]_ENABLED flags in the result mask for
> the callers. So doing the same for pseries eeh get state implementation
> does look like the right thing to do here IMO.
>
>> The patch fixes that by reflecting what is actually allowed.
>
> You say this is "fixes" so I am also assuming you are also looking for
> stable backports of this? If yes - could you please also add the "Fixes"
> tag and cc stable?
Yes, agree will re-send adding the fixes tag.

>
> -ritesh
>
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index 1893f66371fa..b12ef382fec7 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
>>  
>>  	switch(rets[0]) {
>>  	case 0:
>> -		result = EEH_STATE_MMIO_ACTIVE |
>> -			 EEH_STATE_DMA_ACTIVE;
>> +		result = EEH_STATE_MMIO_ACTIVE	|
>> +			 EEH_STATE_DMA_ACTIVE	|
>> +			 EEH_STATE_MMIO_ENABLED	|
>> +			 EEH_STATE_DMA_ENABLED;
>>  		break;
>>  	case 1:
>>  		result = EEH_STATE_RESET_ACTIVE |
>> -- 
>> 2.45.2
>

-- 
Cheers
~ Vaibhav

