Return-Path: <linux-kernel+bounces-364874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C599DA72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792481C21386
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912DDDBB;
	Tue, 15 Oct 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1zdDSwB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461C442F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950517; cv=none; b=hEZohLoDDwILS0C793+e0fIC3vbpiIpVB8ztTfbJNak4jW2KwgYuJa9jUGiVBANaMY7R3toggdaYhvkqBhT0a+va7pZEWZ7PBYP6hG8V6d7xUY+lZ9zLiKPvk7d+j8oh72OG2YGKE20zUbYER2cvGaqjTKzMb3yAkmnvGn+n14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950517; c=relaxed/simple;
	bh=Q8iS8IxHSVGTjbc9AGbpjOQg0EWYXS/kKQdTlWSiROE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg4IsZtXLp7N8UvxSDUHFBS/hT5/2kj6ZNcB+PEmiPofmx9cq1q35nhDCfAZmItE9iN35R4fIBpMVDa8V86/O/hkAnPxDoE+w/ftVZ5c1LIp8E8cNjVpsOmzPE4ER88RVyvYLjt1MadE/lSsK/bRjMgXI2d0IRsXlYbPRRB16hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1zdDSwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728950514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fVXTa8XIsbgoiuVpOKk+BswyA+FGg23RGxfcTSTItE=;
	b=Z1zdDSwBvS65yDKt3QQGiqPZwVwExnejo9v3mcSYv0K6cwRK8TW0YSFcb990LbF+QkgBaP
	QHG57V5UFi9OX2gXtK8ZlI8rOmATATMUv05Yw3r9QNMR3xchT0rero+Z5OhoVpFRC0Lh59
	H65EPoc3xXCRREajxEf2Fr6IJAGEkh4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-duS_OnTUOF-U9ipdXA7nuQ-1; Mon, 14 Oct 2024 20:01:52 -0400
X-MC-Unique: duS_OnTUOF-U9ipdXA7nuQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so6276513a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950510; x=1729555310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fVXTa8XIsbgoiuVpOKk+BswyA+FGg23RGxfcTSTItE=;
        b=LzDKom8trZ0MvZ5GHxH/9CjYBpopXA9ZLWS2l/BZIK4zwO3jCitK8yFyEZrdN6yPmm
         8wcP7NLja2LVQRNxtftBaGQksi4fZLIPtueYENimhJQBe8bLlNPSG/3ixreKAqe4gR7c
         YKXyODQpZYcx0Vu8hJsGbsjxD0l6E71tCP/9tMhx4PGED5NBSm2vS4Lutg0RHgVQ1AkZ
         SjTAlumWwMpohbrjH3Loy1X19N86xr88I/UMsVbenhN9S8HHGKPgl9QY9npULRaePbI+
         rW8DJPoDNR2NULhBeEucYmtS/HpLw6YunhmDVZLWYbvIyw5JRA1Nza+o1ZNjnm0vrs3J
         i79w==
X-Forwarded-Encrypted: i=1; AJvYcCWtfZmaEn0fHdbniIvmgDLVTXLNFS45FhczoZ9gKEvbVG6VBuSbaX08eopLGpdU2MOxdzy5BZtFVlnzmQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWZZCgDflaSAywyWWw7aB5g/P+OaMolw+VXi+hF1vwCl7k8Jb
	PFrcjqOBBHPZIRvz0qAzExIQTpGO3E0bavt8n0uoUJQqlmtxZY4P7IemqnzZXYzJP0vokRtx82n
	9otMelikyAFepaMxQLb8BSAshIcn7bQbBxH3k6uu5kytqXPyooZ6IMNfSj7phcg==
X-Received: by 2002:a05:6a20:d501:b0:1d2:ea38:39bc with SMTP id adf61e73a8af0-1d8c9594e7dmr14937923637.11.1728950510196;
        Mon, 14 Oct 2024 17:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJcAFjePFn8mOJXk/8VHRUXLze+FJupfXBRL7K3VuUoXPsbgGUDvbOUz+Vrv3oSTsD9DVmWw==
X-Received: by 2002:a05:6a20:d501:b0:1d2:ea38:39bc with SMTP id adf61e73a8af0-1d8c9594e7dmr14937869637.11.1728950509802;
        Mon, 14 Oct 2024 17:01:49 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c71a8aesm114810a12.81.2024.10.14.17.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 17:01:49 -0700 (PDT)
Message-ID: <6d6253a6-c113-44af-856e-118d02e1e409@redhat.com>
Date: Tue, 15 Oct 2024 10:01:39 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/11] virt: arm-cca-guest: TSM_REPORT support for
 realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Sami Mujawar <sami.mujawar@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, Dan Williams <dan.j.williams@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20241004144307.66199-1-steven.price@arm.com>
 <20241004144307.66199-11-steven.price@arm.com>
 <5a3432d1-6a79-434c-bc93-6317c8c6435c@redhat.com>
 <6c306817-fbd7-402c-8425-a4523ed43114@arm.com>
 <7a83461d-40fd-4e61-8833-5dae2abaf82b@arm.com>
 <5999b021-0ae3-4d90-ae29-f18f187fd115@redhat.com>
 <11cff100-3406-4608-9993-c29caf3d086d@arm.com>
 <f3ce0718-064d-48e4-a681-7058157127b0@arm.com>
 <56d9edcb-2574-43fe-8ebb-65cc4fdbc3d0@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <56d9edcb-2574-43fe-8ebb-65cc4fdbc3d0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 12:46 AM, Suzuki K Poulose wrote:
> On 14/10/2024 15:41, Steven Price wrote:
>> On 14/10/2024 09:56, Suzuki K Poulose wrote:
>>> On 12/10/2024 07:06, Gavin Shan wrote:
>>>> On 10/12/24 2:22 AM, Suzuki K Poulose wrote:
>>>>> On 11/10/2024 15:14, Steven Price wrote:
>>>>>> On 08/10/2024 05:12, Gavin Shan wrote:
>>>>>>> On 10/5/24 12:43 AM, Steven Price wrote:
>>>>>>>> From: Sami Mujawar <sami.mujawar@arm.com>
>>>>>>>>
>>>>>>>> Introduce an arm-cca-guest driver that registers with
>>>>>>>> the configfs-tsm module to provide user interfaces for
>>>>>>>> retrieving an attestation token.
>>>>>>>>
>>>>>>>> When a new report is requested the arm-cca-guest driver
>>>>>>>> invokes the appropriate RSI interfaces to query an
>>>>>>>> attestation token.
>>>>>>>>
>>>>>>>> The steps to retrieve an attestation token are as follows:
>>>>>>>>      1. Mount the configfs filesystem if not already mounted
>>>>>>>>         mount -t configfs none /sys/kernel/config
>>>>>>>>      2. Generate an attestation token
>>>>>>>>         report=/sys/kernel/config/tsm/report/report0
>>>>>>>>         mkdir $report
>>>>>>>>         dd if=/dev/urandom bs=64 count=1 > $report/inblob
>>>>>>>>         hexdump -C $report/outblob
>>>>>>>>         rmdir $report
>>>>>>>>
>>>>>>>> Signed-off-by: Sami Mujawar <sami.mujawar@arm.com>
>>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>>>>>> ---
>>>>>>>> v3: Minor improvements to comments and adapt to the renaming of
>>>>>>>> GRANULE_SIZE to RSI_GRANULE_SIZE.
>>>>>>>> ---
>>>>>>>>     drivers/virt/coco/Kconfig                     |   2 +
>>>>>>>>     drivers/virt/coco/Makefile                    |   1 +
>>>>>>>>     drivers/virt/coco/arm-cca-guest/Kconfig       |  11 +
>>>>>>>>     drivers/virt/coco/arm-cca-guest/Makefile      |   2 +
>>>>>>>>     .../virt/coco/arm-cca-guest/arm-cca-guest.c   | 211
>>>>>>>> ++++++++++++ ++++++
>>>>>>>>     5 files changed, 227 insertions(+)
>>>>>>>>     create mode 100644 drivers/virt/coco/arm-cca-guest/Kconfig
>>>>>>>>     create mode 100644 drivers/virt/coco/arm-cca-guest/Makefile
>>>>>>>>     create mode 100644 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>>>>
>>>> [...]
>>>>
>>>>>>>> +/**
>>>>>>>> + * arm_cca_report_new - Generate a new attestation token.
>>>>>>>> + *
>>>>>>>> + * @report: pointer to the TSM report context information.
>>>>>>>> + * @data:  pointer to the context specific data for this module.
>>>>>>>> + *
>>>>>>>> + * Initialise the attestation token generation using the
>>>>>>>> challenge data
>>>>>>>> + * passed in the TSM descriptor. Allocate memory for the attestation
>>>>>>>> token
>>>>>>>> + * and schedule calls to retrieve the attestation token on the
>>>>>>>> same CPU
>>>>>>>> + * on which the attestation token generation was initialised.
>>>>>>>> + *
>>>>>>>> + * The challenge data must be at least 32 bytes and no more than 64
>>>>>>>> bytes. If
>>>>>>>> + * less than 64 bytes are provided it will be zero padded to 64
>>>>>>>> bytes.
>>>>>>>> + *
>>>>>>>> + * Return:
>>>>>>>> + * * %0        - Attestation token generated successfully.
>>>>>>>> + * * %-EINVAL  - A parameter was not valid.
>>>>>>>> + * * %-ENOMEM  - Out of memory.
>>>>>>>> + * * %-EFAULT  - Failed to get IPA for memory page(s).
>>>>>>>> + * * A negative status code as returned by
>>>>>>>> smp_call_function_single().
>>>>>>>> + */
>>>>>>>> +static int arm_cca_report_new(struct tsm_report *report, void *data)
>>>>>>>> +{
>>>>>>>> +    int ret;
>>>>>>>> +    int cpu;
>>>>>>>> +    long max_size;
>>>>>>>> +    unsigned long token_size;
>>>>>>>> +    struct arm_cca_token_info info;
>>>>>>>> +    void *buf;
>>>>>>>> +    u8 *token __free(kvfree) = NULL;
>>>>>>>> +    struct tsm_desc *desc = &report->desc;
>>>>>>>> +
>>>>>>>> +    if (!report)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>
>>>>>>> This check seems unnecessary and can be dropped.
>>>>>>
>>>>>> Ack
>>>>>>
>>>>>>>> +    if (desc->inblob_len < 32 || desc->inblob_len > 64)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * Get a CPU on which the attestation token generation will be
>>>>>>>> +     * scheduled and initialise the attestation token generation.
>>>>>>>> +     */
>>>>>>>> +    cpu = get_cpu();
>>>>>>>> +    max_size = rsi_attestation_token_init(desc->inblob,
>>>>>>>> desc->inblob_len);
>>>>>>>> +    put_cpu();
>>>>>>>> +
>>>>>>>
>>>>>>> It seems that put_cpu() is called early, meaning the CPU can go
>>>>>>> away before
>>>>>>> the subsequent call to arm_cca_attestation_continue() ?
>>>>>>
>>>>>> Indeed, good spot. I'll move it to the end of the function and update
>>>>>> the error paths below.
>>>>>
>>>>> Actually this was on purpose, not to block the CPU hotplug. The
>>>>> attestation must be completed on the same CPU.
>>>>>
>>>>> We can detect the failure from "smp_call" further down and make sure
>>>>> we can safely complete the operation or restart it.
>>>>>
>>>>
>>>> Yes, It's fine to call put_cpu() early since we're tolerant to error
>>>> introduced
>>>> by CPU unplug. It's a bit confused that rsi_attestation_token_init()
>>>> is called
>>>> on the local CPU while arm_cca_attestation_continue() is called on
>>>> same CPU
>>>> with help of smp_call_function_single(). Does it make sense to unify
>>>> so that
>>>> both will be invoked with the help of smp_call_function_single() ?
>>>>
>>>>       int cpu = smp_processor_id();
>>>>
>>>>       /*
>>>>        * The calling and target CPU can be different after the calling
>>>> process
>>>>        * is migrated to another different CPU. It's guaranteed the
>>>> attestatation
>>>>        * always happen on the target CPU with smp_call_function_single().
>>>>        */
>>>>       ret = smp_call_function_single(cpu,
>>>> rsi_attestation_token_init_wrapper,
>>>>                                      (void *)&info, true);
>>>
>>> Well, we want to allocate sufficient size buffer (size returned from
>>> token_init())  outside an atomic context (thus not in smp_call_function()).
>>>
>>> May be we could make this "allocation" restriction in a comment to
>>> make it clear, why we do it this way.
>>
>> So if I've followed this correctly the get_cpu() route doesn't work
>> because of the need to allocate outblob. So using
>> smp_call_function_single() for all calls seems to be the best approach,
>> along with a comment explaining what's going on. So how about:
>>
>>     /*
>>      * The attestation token 'init' and 'continue' calls must be
>>      * performed on the same CPU. smp_call_function_single() is used
>>      * instead of simply calling get_cpu() because of the need to
>>      * allocate outblob based on the returned value from the 'init'
>>      * call and that cannot be done in an atomic context.
>>      */
>>     cpu = smp_processor_id();
>>
>>     info.challenge = desc->inblob;
>>     info.challenge_size = desc->inblob_len;
>>
>>     ret = smp_call_function_single(cpu, arm_cca_attestation_init,
>>                        &info, true);
>>     if (ret)
>>         return ret;
>>     max_size = info.result;
>>
>> (with appropriate updates to the 'info' struct and a new
>> arm_cca_attestation_init() wrapper for rsi_attestation_token_init()).
> 
> That sounds good to me.
> 

+1, it looks good to me as well.

Thanks,
Gavin


