Return-Path: <linux-kernel+bounces-442714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4739EE0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B12867E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BE20B7E4;
	Thu, 12 Dec 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftPvew5p"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7C202F9D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990256; cv=none; b=oXgggrtenXeO5KbaO5g8LBzZ7KbJs5wUWSTlEFx7uWciwXPWSdUUl/UrfuByBDZ41z/p9O6VTPciFeKaMCQCnJOQ6rqnrOfhlJfXGKgrWXS62xp1v4lsxDaXkNzceuIVVUtQ7J24d+qV7LwgkSny6AfedpoopVrP2EHnpQy0ktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990256; c=relaxed/simple;
	bh=lMS9mzxdUofoVuv/CBlu23JLYnMawY1N3dIo+GQHa/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYRbZo+vbjHQzESnophtE8W5P/5aj3eJK80FFjrp5AtrzuCxpvPivzOLxV9wHwLep+WD8EkzRN4SVNO5GEJ8g8XMC1mwtAdtu8hQLPoT2szZIdX2xFEgFnz+6eoqSeVZOcLicdD647Vuv8I7hasrNsBMOkVREgeCspg0+yL5ToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftPvew5p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC6mqnf029640;
	Thu, 12 Dec 2024 07:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zVSpZe
	iiisuY2jLF6K0NbwIBhEDOKkDLe1d8fSnP5K0=; b=ftPvew5peqavgKPt8+S6cC
	i4XiTSdf9kB7J9mim/a7s50izvZHzctbkqaCzCrADm9ypiEOVaLTcfnTdVcuAwNL
	Hq39xznFfbBL4qs8Y3XGVNVsc8qYhLjz2l07ik1EMgIE9dL5GHH3mL/tpUhMN/h3
	ZvHE/qZC8srlacGwUMSm7Pl3czMQYUxooJjGuqt3zn4UP8mifEzfsBQJDCFoMf6e
	beJre2A7nVkLeIyATMTlyTBbyzGZZvKmfb2PmbgCn7YcOEqicmihP7lpYUYaS0/R
	wW1x0xqlxrGE+BlP+FIdWvIjhyePX3v0cvHZlGR+iCqc8QXGgK2Ni6+2dXNtBajg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjshhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:57:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BC7lZfB023145;
	Thu, 12 Dec 2024 07:57:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjshhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:57:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC6Hv6T016926;
	Thu, 12 Dec 2024 07:57:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yf8vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:57:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BC7vCEC50135492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 07:57:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A39F32004B;
	Thu, 12 Dec 2024 07:57:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5821A20049;
	Thu, 12 Dec 2024 07:57:07 +0000 (GMT)
Received: from [9.61.244.241] (unknown [9.61.244.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 07:57:06 +0000 (GMT)
Message-ID: <50681cca-20f3-4583-997e-8e571edaeef5@linux.ibm.com>
Date: Thu, 12 Dec 2024 13:27:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pseries/eeh: Fix get PE state translation
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org,
        ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
References: <20241107042027.338065-1-nnmlinux@linux.ibm.com>
 <87ttc8d0vf.fsf@gmail.com> <87cyiq3px0.fsf@vajain21.in.ibm.com>
 <87zflswebb.fsf@gmail.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <87zflswebb.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rmYE5Qsp52-V6bBHfdHXs7JLbJsnn3Bo
X-Proofpoint-ORIG-GUID: KAqzacUqbdHTA5Y0vfT2d9HJCObp6C-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120050


On 22/11/24 1:26 AM, Ritesh Harjani (IBM) wrote:
> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
>> Hi Ritesh,
>>
>> Thanks for looking into this patch. My responses on behalf of Narayana
>> below:
>>
>> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>>
>>> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>>>
>>>> The PE Reset State "0" obtained from RTAS calls
>>>> ibm_read_slot_reset_[state|state2] indicates that
>>>> the Reset is deactivated and the PE is not in the MMIO
>>>> Stopped or DMA Stopped state.
>>>>
>>>> With PE Reset State "0", the MMIO and DMA is allowed for
>>>> the PE.
>>> Looking at the PAPR spec - I do agree that it states the same. i.e.
>>> The "0" Initial PE state means the "Not Reset", "Load/Store allowed" &
>>> "DMA allowed" (Normal Operations).
>>>
>>>> The function pseries_eeh_get_state() is currently
>>>> not indicating that to the caller because of  which the
>>>> drivers are unable to resume the MMIO and DMA activity.
>>> It's new to me, but could you help explain the user visible effect
>>> of what gets broken. Since this looks like pseries_eeh_get_state() has
>>> always been like this when it got first implemented.
>>> Is there also a unit test somewhere which you are testing?
>> Without this patch a userspace process performing VFIO EEH-Recovery wont
>> get the correct indication that EEH recovery is completed. Test code at
>> [2] has an example test case that uses VFIO to inject an EEH error on to
>> a pci-device and then waits on it to reach 'EEH_PE_STATE_NORMAL' state
>> . That state is never reached without this patch.
>>
>> [2] :
>> https://github.com/nnmwebmin/vfio-ppc-tests/commit/006d8fdc41a4
>>
> Right. Thanks for helping with that test code. It's much clearer now. So
> after the error inject and/or the PE hot reset, the PE is never reaching
> it's normal state. That is due to this kernel bug in the pseries EEH
> handling, where it fails to advertise the MMIO & DMA enabled capability
> flag back to the caller. This therefore can cause the userspace VFIO
> driver to incorrectly assume that MMIO/DMA operations cannot be done.
>
>>> IIUC eeh_pe_get_state() was implemented[1] for supporting EEH for VFIO PCI
>>> devices. i.e. the VFIO_EEH_PE_GET_STATE operation of VFIO EEH PE ioctl op
>>> uses pseries_eeh_get_state() helper to query PE state on pseries LPAR.
>>> So are you suggesting that EEH functionality for VFIO PCI device was
>>> never enabled/tested before on pseries?
>> VFIO-EEH had been broken for pseries for a quite some time and was
>> recently fixed in kernel. So this issue was probably not discovered
>> until recently when we started testing with userspace VFIO.
>>
> ohk right, then maybe we might have started testing it after the eeh
> error inject op was implemented for pseries here [1].
>
> [1]: https://lore.kernel.org/linuxppc-dev/20240909140220.529333-1-nnmlinux@linux.ibm.com/#t
>
>>> [1]: https://lore.kernel.org/all/1402364517-28561-3-git-send-email-gwshan@linux.vnet.ibm.com/
>>>
>>> Checking the powernv side of implementation I do see that it does
>>> enables the EEH_STATE_[MMIO|DMA]_ENABLED flags in the result mask for
>>> the callers. So doing the same for pseries eeh get state implementation
>>> does look like the right thing to do here IMO.
>>>
>>>> The patch fixes that by reflecting what is actually allowed.
>>> You say this is "fixes" so I am also assuming you are also looking for
>>> stable backports of this? If yes - could you please also add the "Fixes"
>>> tag and cc stable?
>> Yes, agree will re-send adding the fixes tag.
>>
> Yes and maybe let's also add some more context & information to the
> commit message from this discussion.
>
> -ritesh
yes Ritesh, added fixes tag and send it to the stable branch also.
>
>>> -ritesh
>>>
>>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> index 1893f66371fa..b12ef382fec7 100644
>>>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>>>> @@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
>>>>   
>>>>   	switch(rets[0]) {
>>>>   	case 0:
>>>> -		result = EEH_STATE_MMIO_ACTIVE |
>>>> -			 EEH_STATE_DMA_ACTIVE;
>>>> +		result = EEH_STATE_MMIO_ACTIVE	|
>>>> +			 EEH_STATE_DMA_ACTIVE	|
>>>> +			 EEH_STATE_MMIO_ENABLED	|
>>>> +			 EEH_STATE_DMA_ENABLED;
>>>>   		break;
>>>>   	case 1:
>>>>   		result = EEH_STATE_RESET_ACTIVE |
>>>> -- 
>>>> 2.45.2
>> -- 
>> Cheers
>> ~ Vaibhav

Thank you Ritesh and Vaibhav for reviewing the patch. Please find the

changes addressed in 
https://lore.kernel.org/all/20241212075044.10563-1-nnmlinux@linux.ibm.com/.

Regards,

Narayana Murty N



