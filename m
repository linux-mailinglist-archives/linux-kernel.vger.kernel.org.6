Return-Path: <linux-kernel+bounces-321566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441B971C16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E5E1C23180
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFA1B5826;
	Mon,  9 Sep 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b1CF+czc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260822095
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890687; cv=none; b=IIC4g4CDvFzfZ6MpPYSvVS7UJf69xM3Wr9ufu0oH59LeeDeAImLfa/Yy96Zc7Usrqv29qy+sMHz7ZbGNCvgwjZ6uwWF9kbmQ/pkPtlFvhhpk8/TfPpspXDMYzok4MHqo9/kQeI4VuD4bbEBKbIurA2rJpLJbuCGT8a8CJm0yhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890687; c=relaxed/simple;
	bh=Vh4pLtxdZtbS3hCyjBv3SKte5AGWGx3B0en4haCDVu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AU4Spg1Vo/AnLSGtE8EOsr0BFG3jfe1StzfqPAWsrDapUPc31Ew4bvb/1iNsrj1Go2sMzgA+jfrQEBEASK+R1l0tGmf/FZqLiNrTpQdJJv4WecXt6ZZ8Dhc1DcQvms6HcFkItJ9CF3JsHTnZRBqPmQ4q6YdfE2raTeHiPKg9NqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b1CF+czc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899SWSM028493;
	Mon, 9 Sep 2024 14:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	WeKnLh7j171W3o0vnrs6rgz/OyHAOjCX7QJuAuvN8x8=; b=b1CF+czc5S4k+9EL
	qc0eI6X/JvyvUA6VXjd8oXeBGP6qZggHuTEceShsZYgrZMcO+YhjOeZckBXAgTCb
	kkyyWCmy+4MtGihkc1++kFUkoTCTSfj7ymcTXuooSTedUkSMyl3AMiIn19JLurEq
	KFpjyJOfbJzpERA1TtUsoyPiqidxEfMtpge6TIbGvNldNsEjp/UCCJRrKAokMxVY
	FIMX1obMMPw7r0yfIYhB2AMRg/JuESOQ9H66BmbikGdr5zQdNhq4XHogI7obaCQn
	2SHMCSOTRv/fXb7dgylVQxbL+qrqLFPH1ARlt9ix4+EogIgwQfcKTk13dISyLUfY
	iDp/Tg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefya4y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:04:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489E4WfH022044;
	Mon, 9 Sep 2024 14:04:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefya4y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:04:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489CjDXd013476;
	Mon, 9 Sep 2024 14:04:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3ckxf2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 14:04:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489E4Sr050921886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 14:04:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F6E2004B;
	Mon,  9 Sep 2024 14:04:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B545320043;
	Mon,  9 Sep 2024 14:04:23 +0000 (GMT)
Received: from [9.61.248.162] (unknown [9.61.248.162])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 14:04:23 +0000 (GMT)
Message-ID: <66e3558d-a9a6-4caa-9102-7c22a695acda@linux.ibm.com>
Date: Mon, 9 Sep 2024 19:34:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com,
        ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
References: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
 <877cbq5k1y.fsf@mail.lhotse>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <877cbq5k1y.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RlxcfRHUjNEBYuEAm3N5TpPxikbLwuPO
X-Proofpoint-ORIG-GUID: C7YU61U7blTkJ3XKmErHkmeLyNJy2e8D
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_06,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090113


On 05/09/24 6:33 PM, Michael Ellerman wrote:
> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
>> due to missing implementation of err_inject eeh_ops for pseries.
>> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
>> eeh_ops. Implements support for injecting MMIO load/store error
>> for testing from user space.
>>
>> The check on PCI error type code is moved to platform code, since
>> the eeh_pe_inject_err can be allowed to more error types depending
>> on platform requirement.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>
>> Testing:
>> ========
>> vfio-test [1] by Alex Willamson, was forked and updated to add
>> support inject error on pSeries guest and used to test this
>> patch[2].
>>
>> References:
>> ===========
>> [1] https://github.com/awilliam/tests
>> [2] https://github.com/nnmwebmin/vfio-ppc-tests/tree/vfio-ppc-ex
>>
>> ================
>> Changelog:
>> V1:https://lore.kernel.org/all/20240822082713.529982-1-nnmlinux@linux.ibm.com/
>> - Resolved build issues for ppc64|le_defconfig by moving the
>> pseries_eeh_err_inject() definition outside of the CONFIG_PCI_IOV
>> code block.
>> - New eeh_pe_inject_mmio_error wrapper function added to avoid
>> CONFIG_EEH is not set.
>   
> I don't see why that's necessary?
>
> It's only called from eeh_pseries.c, which is only built for
> PPC_PSERIES, and when PPC_PSERIES=y, EEH is always enabled.
>
>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> index 91a9fd53254f..8da6b047a4fe 100644
>> --- a/arch/powerpc/include/asm/eeh.h
>> +++ b/arch/powerpc/include/asm/eeh.h
>> @@ -308,7 +308,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
>>   int eeh_pe_configure(struct eeh_pe *pe);
>>   int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>   		      unsigned long addr, unsigned long mask);
>> -
>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>>   /**
>>    * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>>    *
>> @@ -338,6 +338,10 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>>   	return 0;
>>   }
>>   
>> +static inline int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>> +{
>> +	return -ENXIO;
>> +}
>>   #define eeh_dev_check_failure(x) (0)
>>   
>>   static inline void eeh_addr_cache_init(void) { }
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index d03f17987fca..49ab11a287a3 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1537,10 +1537,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>>   	if (!eeh_ops || !eeh_ops->err_inject)
>>   		return -ENOENT;
>>   
>> -	/* Check on PCI error type */
>> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> -		return -EINVAL;
>> -
>   
> The change log should mention why it's OK to remove these checks. You
> add the same checks in pseries_eeh_err_inject(), but what about
> pnv_eeh_err_inject() ?
>
> It is OK AFAICS, because pnv_eeh_err_inject() already contains
> equivalent checks, but you should spell that out.
>
> cheers

yes mpe. I do agree, your comments are addressed in V3 posted

here 
https://lore.kernel.org/all/20240909140220.529333-1-nnmlinux@linux.ibm.com/

regards,

Narayana Murty.


