Return-Path: <linux-kernel+bounces-259600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE731939934
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CE5282BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858313CA8E;
	Tue, 23 Jul 2024 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/Vrccag"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275F134B6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712949; cv=none; b=hkKhGsX0vQ6OKKXZzMJJSq9xMgVxQOQj9wamwSV8AYoC1EgHVVdDhGqMcVKG1owYgClHRxmEgWOQylMR77vjV8c+Lo95uWhbugy6bSv0FaEhA42IKcXn3fg/dkahTqsLbpAbZbgF1Hl3wJVlToQHcZNMh/X3vLLHuyisurmDyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712949; c=relaxed/simple;
	bh=VtdTtInp8xltP7woCl3ZLIkQdg2goHxfX1mvCYp/CEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mofK9Wo1THRlVhZe2L32lCo3W1n1mWxVYa5/Eol1y5QMDvix2b9XgpOGN/0fq3rKw/cKq0Yryj2mkpE7Tsa1i5mFW7jLWBL3uo3DXNUj1aC5AGRPrGhUWdLJNvB4HFZHNtcQCsu/fioyX45ST5ygW1vuKP+ic6zC+lcunO4FXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/Vrccag; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721712946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW1THt75DeB8IkjnkNQ5OOu8ISWACnD4UYq7Ars9y+U=;
	b=Y/VrccagCFQum1K3ACnQznnP42GBqaM78ij0kW5tV0EOorkmCvHBhcZ0U552b6uS+flV2s
	t+5pHuTHf8dXQVcsEGwY5D6tHcszUcf56H/NwT6s3c3BJkAyVf5MoJuH2Nxk8lqQ2WY70f
	6KXwhG2kV0wEZ77WJs0UhfwFjq8asJE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-GOFcN9snOxuku5UhB9eE6A-1; Tue, 23 Jul 2024 01:35:43 -0400
X-MC-Unique: GOFcN9snOxuku5UhB9eE6A-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70d1469f5e1so1791243b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721712942; x=1722317742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW1THt75DeB8IkjnkNQ5OOu8ISWACnD4UYq7Ars9y+U=;
        b=EsDYj1VEZAwuKebmwupf+UwkhECAI+YzyzKN1mnsTL5UnHM2Sz7BhkErB7qRUUNx5A
         FqDMAsT41x1ik4KvB67Y9bzzzsWQ7rcB9SX0oO82HRbPpm9A50Viqiw9kKGJFJjet+0U
         KhelV6pIbwVc17t9+cZfvSs7vYAVQ9WC6cEg24vyFwgAEGbItdTTHGt1mbRjB5xuthND
         jzIZW/qJcFsP7epbeXt5ZOR4aOqZ2prdjLBmdzEYMSQWyspQh8ZCkshP+4WOHo6LSE1k
         e6DooYGsTk6zjSYMsgfksh8/RsFBdfc2KpQQqwvS+SN3UcFoDpBb7RIkFtCCvZrL5n2v
         y9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXeq3j5m/IvsTg9YcyMUUFWzAESnGfS895aqcksn2kORhPEXWEtw+sAUuif8wqjEehh4R1Y/Kjr1WnbieduPVQqrn7i5KKVPk0wTKhO
X-Gm-Message-State: AOJu0Yw8BO00J2JNVsEOWMhAENtQi5PP5Ynq/O5cpfNUvQy06XAAon70
	OMHMLlhUIZYajjay0SCLjRc80B0ldLzhXP3ueLb7H/4+W5bLektbHsc8ObzPiSxzqLz9TR5BVYW
	gf46tldrxLat7sXgom7yNdldTNgCn0FX0dcRuO0AGORCbksUDpOLH47uOfsvh7w==
X-Received: by 2002:a05:6a20:841c:b0:1c2:9cbf:cc3e with SMTP id adf61e73a8af0-1c4285dfbb7mr8095013637.45.1721712942171;
        Mon, 22 Jul 2024 22:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUfgk+Po+fWXzUtaVQDwmY3IatFJXFV7UxMV0i7PuLgsZH5vwiyfgOw2C73FeYVdG6yKkjMw==
X-Received: by 2002:a05:6a20:841c:b0:1c2:9cbf:cc3e with SMTP id adf61e73a8af0-1c4285dfbb7mr8094992637.45.1721712941776;
        Mon, 22 Jul 2024 22:35:41 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ba12970sm4760247a12.50.2024.07.22.22.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 22:35:40 -0700 (PDT)
Message-ID: <682d62b8-6cca-4782-b4e4-ffd2a706fadf@redhat.com>
Date: Tue, 23 Jul 2024 15:35:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] arm64: rsi: Add RSI definitions
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei
 <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
References: <20240701095505.165383-1-steven.price@arm.com>
 <20240701095505.165383-2-steven.price@arm.com>
 <3b1c8387-f40f-4841-b2b3-9e4dc1e35efc@redhat.com>
 <3b2ddd79-c7f0-4d41-8795-13d1305e3d08@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <3b2ddd79-c7f0-4d41-8795-13d1305e3d08@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/24 1:34 AM, Steven Price wrote:
> On 09/07/2024 06:19, Gavin Shan wrote:
>> On 7/1/24 7:54 PM, Steven Price wrote:
>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>
>>> The RMM (Realm Management Monitor) provides functionality that can be
>>> accessed by a realm guest through SMC (Realm Services Interface) calls.
>>>
>>> The SMC definitions are based on DEN0137[1] version A-eac5.
>>>
>>> [1] https://developer.arm.com/documentation/den0137/latest
>>>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>> Changes since v3:
>>>    * Drop invoke_rsi_fn_smc_with_res() function and call arm_smccc_smc()
>>>      directly instead.
>>>    * Rename header guard in rsi_smc.h to be consistent.
>>> Changes since v2:
>>>    * Rename rsi_get_version() to rsi_request_version()
>>>    * Fix size/alignment of struct realm_config
>>> ---
>>>    arch/arm64/include/asm/rsi_cmds.h |  38 ++++++++
>>>    arch/arm64/include/asm/rsi_smc.h  | 142 ++++++++++++++++++++++++++++++
>>>    2 files changed, 180 insertions(+)
>>>    create mode 100644 arch/arm64/include/asm/rsi_cmds.h
>>>    create mode 100644 arch/arm64/include/asm/rsi_smc.h
>>>
>>
>> [...]
>>
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/rsi_smc.h
>>> @@ -0,0 +1,142 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2023 ARM Ltd.
>>> + */
>>> +
>>> +#ifndef __ASM_RSI_SMC_H_
>>> +#define __ASM_RSI_SMC_H_
>>> +
>>> +/*
>>> + * This file describes the Realm Services Interface (RSI) Application
>>> Binary
>>> + * Interface (ABI) for SMC calls made from within the Realm to the
>>> RMM and
>>> + * serviced by the RMM.
>>> + */
>>> +
>>> +#define SMC_RSI_CALL_BASE        0xC4000000
>>> +
>>
>> These fields have been defined in include/linux/arm-smccc.h. Those definitions
>> can be reused. Otherwise, it's not obvious to reader what does 0xC4000000 represent.
>>
>> #define SMC_RSI_CALL_BASE    ((ARM_SMCCC_FAST_CALL << ARM_SMCCC_TYPE_SHIFT)   | \
>>                                   (ARM_SMCCC_SMC_64 << ARM_SMCCC_CALL_CONV_SHIFT) | \
>>                                   (ARM_SMCCC_OWNER_STANDARD << ARM_SMCCC_OWNER_SHIFT))
>>
>> or
>>
>> #define SMC_RSI_CALL_BASE       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,            \
>>                                                     ARM_SMCCC_SMC_64,               \
>>                                                     ARM_SMCCC_OWNER_STANDARD,       \
>>                                                     0)
> 
> Good point, even better is actually to just drop SMC_RSI_CALL_BASE and
> just redefine SMC_RSI_FID() in terms of ARM_SMCCC_CALL_VAL().
> 

Agreed, it's going to be more clear. The point is to reuse the existing definitions
in include/linux/arm-smccc.h.

Sorry for slow response. I spent some time going through tf-a/tf-rmm implementation
to understand how GPT and stage-2 page-table are managed in order to review this
series. I realized it's complicated to manage GPT and stage-2 page-table and lots
of details still need more time to be figured out.

Thanks,
Gavin


