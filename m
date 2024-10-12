Return-Path: <linux-kernel+bounces-362109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C099B12A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B930DB214B2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AD13A87A;
	Sat, 12 Oct 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCw0OlM6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62D85283
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713186; cv=none; b=LasLFtDzt2hsCSEAvSJXAxFfGwZmMFayoIW0WmD+xkWbKciIPKTxBoMecWZ+bcfpEQY3sKuhmGqk2ullfTh1Ie6sfaKJ9p4H2D9kVoPf+QzZf99QeLeJOOopc/tC02zK4jBlcv12lM1KDibIyxAAGxbsUcvjURQDBmVMpP4ZVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713186; c=relaxed/simple;
	bh=p3bhdSIz97AK70PkPUevDFL5eUaWsHkk+ULKNm4YWU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGI2ZzN7FgCAVhhK3UuFq2+iY+zNR9TwlBBo9jQxP+oa0VM0w+8AqXn/biSFOKAD1EJUV4Zb/KSJcxNx4149taaDYsEYoBU9DU5lzHanALcB7d9ix30ss7UiHm8X6QT7k5JdO5ScLI3a0prkmmGnX00c+T+eeZ8sV1hyHZtaaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCw0OlM6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728713183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4un6uSmnhR3waOcDWroNwGLqZDQwtwFJTENyZm7BpXg=;
	b=SCw0OlM60ehAdkEokk2+olJJrQ0+l1ypnyWXjo2tATxVWIK6xL1iPgNpf7LevFguEQmPQf
	NYM9B4H0hw5ujqRIl8SRXleOrUYmT8PuQg2s/5/90z8UCXXGz1Ely2cnd+kRTkAZP77b3x
	lnpA3tLNiFk5/lXOHC2QXieERwPBnng=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-zYvzg1IgMDO9w0wVNP5g4Q-1; Sat, 12 Oct 2024 02:06:20 -0400
X-MC-Unique: zYvzg1IgMDO9w0wVNP5g4Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e455defb9so1498843b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713179; x=1729317979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4un6uSmnhR3waOcDWroNwGLqZDQwtwFJTENyZm7BpXg=;
        b=BYcHGWwFB4i8NGyi8GZ81tlDx1vQz0Ro4haab9D1YsRJR6K6YbGSboUzB6f5DYkZaE
         o2AHnjNVRi1tMVi+s3eBbZkpTZk1BUZPFykccFlnq4790qsLQ5xEqZhm/gy5V/tj8YgW
         jUWb187ZH6R1wKfLCR8kaRts3c6OQKaj59xGXkp5Q5M9vtnq/RPfk8T4k9Fiw9mUhS9p
         x8i5z5tQuMWF0ay2kSR/PspItpJGvkrebpO6jK8b5HdUnJRPaTRFNmenEZZpNYuResRc
         kHvBtcjeBRZc/xALV3Ri3dIKHN7taySTzfM/oI9BhYHrJlRMIwd/LJSnPZMcsc5XuFqO
         9kUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUof8EB95qitGt0RJIWz74ZBvDaKQPJJJKDEjIVT+udNhlCTJxD8NH5YOAerWFNVj78zaljz4toPZEQU8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbDGiHlNyV9s58rntksQVj2CjPsDOIOBV8DIc2VV0eC7wwkFk
	TNDvLzR4rHvskRElwJFPvjGy1ZSF6tzKCziTh3h4W7nwltfOm754NpNnyDuMF2r/MFLdOiGdKwd
	5SSAfOMv6r/VQW3Wmpc3YPB3sbA1eNBvQ1kymyrd/5KxadnjpY8+Q3CbCuMFAxw==
X-Received: by 2002:a05:6a21:31c8:b0:1cf:31b6:18d1 with SMTP id adf61e73a8af0-1d8c96c2ce5mr2259102637.48.1728713179237;
        Fri, 11 Oct 2024 23:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1eYiTG3wr0KgnhwPFbo8d8nOIzZ9nhtHL32SxmP6Jl4bro0T4stNrN6bmkVU9ob7oecwkzg==
X-Received: by 2002:a05:6a21:31c8:b0:1cf:31b6:18d1 with SMTP id adf61e73a8af0-1d8c96c2ce5mr2258777637.48.1728713172412;
        Fri, 11 Oct 2024 23:06:12 -0700 (PDT)
Received: from [192.168.68.54] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea6e9a5244sm383767a12.69.2024.10.11.23.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 23:06:11 -0700 (PDT)
Message-ID: <5999b021-0ae3-4d90-ae29-f18f187fd115@redhat.com>
Date: Sat, 12 Oct 2024 16:06:02 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <7a83461d-40fd-4e61-8833-5dae2abaf82b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/24 2:22 AM, Suzuki K Poulose wrote:
> On 11/10/2024 15:14, Steven Price wrote:
>> On 08/10/2024 05:12, Gavin Shan wrote:
>>> On 10/5/24 12:43 AM, Steven Price wrote:
>>>> From: Sami Mujawar <sami.mujawar@arm.com>
>>>>
>>>> Introduce an arm-cca-guest driver that registers with
>>>> the configfs-tsm module to provide user interfaces for
>>>> retrieving an attestation token.
>>>>
>>>> When a new report is requested the arm-cca-guest driver
>>>> invokes the appropriate RSI interfaces to query an
>>>> attestation token.
>>>>
>>>> The steps to retrieve an attestation token are as follows:
>>>>     1. Mount the configfs filesystem if not already mounted
>>>>        mount -t configfs none /sys/kernel/config
>>>>     2. Generate an attestation token
>>>>        report=/sys/kernel/config/tsm/report/report0
>>>>        mkdir $report
>>>>        dd if=/dev/urandom bs=64 count=1 > $report/inblob
>>>>        hexdump -C $report/outblob
>>>>        rmdir $report
>>>>
>>>> Signed-off-by: Sami Mujawar <sami.mujawar@arm.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>> v3: Minor improvements to comments and adapt to the renaming of
>>>> GRANULE_SIZE to RSI_GRANULE_SIZE.
>>>> ---
>>>>    drivers/virt/coco/Kconfig                     |   2 +
>>>>    drivers/virt/coco/Makefile                    |   1 +
>>>>    drivers/virt/coco/arm-cca-guest/Kconfig       |  11 +
>>>>    drivers/virt/coco/arm-cca-guest/Makefile      |   2 +
>>>>    .../virt/coco/arm-cca-guest/arm-cca-guest.c   | 211 ++++++++++++++++++
>>>>    5 files changed, 227 insertions(+)
>>>>    create mode 100644 drivers/virt/coco/arm-cca-guest/Kconfig
>>>>    create mode 100644 drivers/virt/coco/arm-cca-guest/Makefile
>>>>    create mode 100644 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c

[...]

>>>> +/**
>>>> + * arm_cca_report_new - Generate a new attestation token.
>>>> + *
>>>> + * @report: pointer to the TSM report context information.
>>>> + * @data:  pointer to the context specific data for this module.
>>>> + *
>>>> + * Initialise the attestation token generation using the challenge data
>>>> + * passed in the TSM descriptor. Allocate memory for the attestation
>>>> token
>>>> + * and schedule calls to retrieve the attestation token on the same CPU
>>>> + * on which the attestation token generation was initialised.
>>>> + *
>>>> + * The challenge data must be at least 32 bytes and no more than 64
>>>> bytes. If
>>>> + * less than 64 bytes are provided it will be zero padded to 64 bytes.
>>>> + *
>>>> + * Return:
>>>> + * * %0        - Attestation token generated successfully.
>>>> + * * %-EINVAL  - A parameter was not valid.
>>>> + * * %-ENOMEM  - Out of memory.
>>>> + * * %-EFAULT  - Failed to get IPA for memory page(s).
>>>> + * * A negative status code as returned by smp_call_function_single().
>>>> + */
>>>> +static int arm_cca_report_new(struct tsm_report *report, void *data)
>>>> +{
>>>> +    int ret;
>>>> +    int cpu;
>>>> +    long max_size;
>>>> +    unsigned long token_size;
>>>> +    struct arm_cca_token_info info;
>>>> +    void *buf;
>>>> +    u8 *token __free(kvfree) = NULL;
>>>> +    struct tsm_desc *desc = &report->desc;
>>>> +
>>>> +    if (!report)
>>>> +        return -EINVAL;
>>>> +
>>>
>>> This check seems unnecessary and can be dropped.
>>
>> Ack
>>
>>>> +    if (desc->inblob_len < 32 || desc->inblob_len > 64)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /*
>>>> +     * Get a CPU on which the attestation token generation will be
>>>> +     * scheduled and initialise the attestation token generation.
>>>> +     */
>>>> +    cpu = get_cpu();
>>>> +    max_size = rsi_attestation_token_init(desc->inblob,
>>>> desc->inblob_len);
>>>> +    put_cpu();
>>>> +
>>>
>>> It seems that put_cpu() is called early, meaning the CPU can go away before
>>> the subsequent call to arm_cca_attestation_continue() ?
>>
>> Indeed, good spot. I'll move it to the end of the function and update
>> the error paths below.
> 
> Actually this was on purpose, not to block the CPU hotplug. The
> attestation must be completed on the same CPU.
> 
> We can detect the failure from "smp_call" further down and make sure
> we can safely complete the operation or restart it.
> 

Yes, It's fine to call put_cpu() early since we're tolerant to error introduced
by CPU unplug. It's a bit confused that rsi_attestation_token_init() is called
on the local CPU while arm_cca_attestation_continue() is called on same CPU
with help of smp_call_function_single(). Does it make sense to unify so that
both will be invoked with the help of smp_call_function_single() ?

     int cpu = smp_processor_id();

     /*
      * The calling and target CPU can be different after the calling process
      * is migrated to another different CPU. It's guaranteed the attestatation
      * always happen on the target CPU with smp_call_function_single().
      */
     ret = smp_call_function_single(cpu, rsi_attestation_token_init_wrapper,
                                    (void *)&info, true);
     if (ret) {
         ...
     }

     
Thanks,
Gavin


