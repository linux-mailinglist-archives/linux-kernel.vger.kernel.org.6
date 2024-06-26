Return-Path: <linux-kernel+bounces-230351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA1917B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7EB1C23D58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A716630E;
	Wed, 26 Jun 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITcXiV/J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD631411EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392509; cv=none; b=PXF7xSlFVfXypbRisDdh+X8vgaVXyodK+lVLSMOXdx0KF0WZt2QhaytE5Ipqlnfy0PkxLd+J8wKzW8hLoNY8ZxoTVF7s3ORBmBjJN7C7wohUWDEd0fx81u4ix0RvgQ+8j5flAV5pjYi+hzVKQEVhWnnUTZAHoySzcXpqRlFoWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392509; c=relaxed/simple;
	bh=2ciIN+SpmSpfnglqOXEBiKHd1ccbS1FEXjS9vxowFKg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uFnberrV9n5B3D+sL8hfYrYYATzJnU/fk2ltMxx8SG/F3cf8BGWlFWgKrlMgiVlSIIN/cmSPyiLW8ZEhM8QIu0rBPuXZvLtcb7B6hLQngSRhwdbmVh0WrAZZGttQllvsIhMdN+cM0hm2v/0Hf3GPieMqwxVXtUrYOzIeySuGfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITcXiV/J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719392506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1oadlD53pCQIFec/zKp7mDa0vRATXxlFgTZ1DCZKpA=;
	b=ITcXiV/JRK19Qty4Mv03970YKsTgx2dMK2Lbca2+cLBK6dJgFMI/jxKjOog8jn4g2hAfdy
	oCixboswO8RPIbaj8lD+tVqYYtG/x4I6jfwlqKJV/L8n1y0s7B8Q0xC3z/MMuXIoERYV+D
	WRzntlQCXSpN1/5jMAy6b4rccw8q0tk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-EdbvEZYzPSeZqMf-ZTbkqQ-1; Wed, 26 Jun 2024 05:01:43 -0400
X-MC-Unique: EdbvEZYzPSeZqMf-ZTbkqQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2c3b9fd4fso1625865a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392502; x=1719997302;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1oadlD53pCQIFec/zKp7mDa0vRATXxlFgTZ1DCZKpA=;
        b=gBIoyyF6arlQjZ1mPQ4qQleCtVK/2Kdqke4U4fiXMKGDzIMC2PU/8DEbLzcIuyz+sT
         tQdAtkqX5bX42zd0bPUbl4EGye4HLV5XGjGKMiUTjYqplne9Ygz02pt2EWg9T+h+cVw7
         Yaqn1+CDTwzU+uZQ0dWmnd3Wp7G94iicSjSmDAh5vgYOykyETA+lOwqifFOFJXyZe+04
         eFve7vl42p4k2TMzlSsRS8YtKFZZCkde69CKBdsh4aM7SM1wtBgVuSNpV8YxFuwfgMZc
         j4SECFK8OK+ZjLMBZ3/ndG01eCNgK5lF/8S3A7FB0HrcRqIREXNes9ROUOF8cGHU39m7
         xNYA==
X-Forwarded-Encrypted: i=1; AJvYcCU8tHdNfcpwYs3IUu/nifpNSscAa/rJQak/DtAo45pWX9m6/t94bp/JK28GVuPhWd9ZKbtwj5MLcVDGXTDUxCj3HAo2+m1UM6e6yl3P
X-Gm-Message-State: AOJu0Yz2sJMqpGnQiE3yrp7Vv0lPDyKmyQVFIQxLhGiJdQjVTmco/XcN
	5hEIcU9/tyVwyRFvLXFrJfZfOULpTPLrnWxcXi8ivtGZNGjLeoi0p54FKe0OZHp+Yf48eLuEMid
	AzjNK1d2y3Q24BdYojqY693Cn/fFdnzmWkrlf5Vvd8Gz4dsVAxRYC4CnolaqLuw==
X-Received: by 2002:a17:90a:8c9:b0:2c4:d63b:cde with SMTP id 98e67ed59e1d1-2c8459a1666mr10209374a91.1.1719392502407;
        Wed, 26 Jun 2024 02:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6fec9cHWNZyNFNAaBU5CpBsvoyabkVfAUSxogFAm8SfcX7v6bhEwGYG4eMaAqENJK+DiniQ==
X-Received: by 2002:a17:90a:8c9:b0:2c4:d63b:cde with SMTP id 98e67ed59e1d1-2c8459a1666mr10209350a91.1.1719392502002;
        Wed, 26 Jun 2024 02:01:42 -0700 (PDT)
Received: from [10.72.116.72] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d8094371sm1115742a91.54.2024.06.26.02.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 02:01:41 -0700 (PDT)
Message-ID: <d0077254-94ef-43cb-8d2b-f45bd8851a47@redhat.com>
Date: Wed, 26 Jun 2024 17:01:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] KVM: arm64: Allow userspace to change
 ID_AA64PFR1_EL1
From: Shaoqin Huang <shahuang@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240618063808.1040085-1-shahuang@redhat.com>
 <20240618063808.1040085-2-shahuang@redhat.com> <86ed8uk8cr.wl-maz@kernel.org>
 <f73cabc6-8c48-4c12-9d60-269e50df41f3@redhat.com>
 <861q4qk9z7.wl-maz@kernel.org>
 <6935be08-f29e-4dd1-9fe7-3d51d3f97509@redhat.com>
Content-Language: en-US
In-Reply-To: <6935be08-f29e-4dd1-9fe7-3d51d3f97509@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/26/24 15:33, Shaoqin Huang wrote:
> Hi Marc,
> 
> On 6/21/24 15:53, Marc Zyngier wrote:
>> On Fri, 21 Jun 2024 07:17:57 +0100,
>> Shaoqin Huang <shahuang@redhat.com> wrote:
>>>
>>> Hi Marc,
>>>
>>> On 6/18/24 15:39, Marc Zyngier wrote:
>>>> On Tue, 18 Jun 2024 07:38:06 +0100,
>>>> Shaoqin Huang <shahuang@redhat.com> wrote:
>>>>>
>>>>> Allow userspace to change the guest-visible value of the register with
>>>>> some severe limitation:
>>>>>
>>>>>     - No changes to features not virtualized by KVM (MPAM_frac, 
>>>>> RAS_frac)
>>>>> ---
>>>>>    arch/arm64/kvm/sys_regs.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>>>> index 22b45a15d068..bead81867bce 100644
>>>>> --- a/arch/arm64/kvm/sys_regs.c
>>>>> +++ b/arch/arm64/kvm/sys_regs.c
>>>>> @@ -2306,7 +2306,8 @@ static const struct sys_reg_desc 
>>>>> sys_reg_descs[] = {
>>>>>               ID_AA64PFR0_EL1_GIC |
>>>>>               ID_AA64PFR0_EL1_AdvSIMD |
>>>>>               ID_AA64PFR0_EL1_FP), },
>>>>> -    ID_SANITISED(ID_AA64PFR1_EL1),
>>>>> +    ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RAS_frac |
>>>>> +                       ID_AA64PFR1_EL1_MPAM_frac)),
>>>>>        ID_UNALLOCATED(4,2),
>>>>>        ID_UNALLOCATED(4,3),
>>>>>        ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
>>>>
>>>> This isn't a valid patch.
>>>>
>>>> Furthermore, how about all the other features that may or may not be
>>>> currently handled by KVM? Please see [1] and make sure that all
>>>> existing fields have a known behaviour (a combination of masked,
>>>> preserved, capped, writable or read-only).
>>>>
>>>> I can at least see problems with MTE_frac and MTEX, plus all the other
>>>> things that KVM doesn't know how to save/restore (THE, GCS, NMI...).
>>>>
>>>> What I asked you to handle the whole register, I really meant it.
>>>
>>> I currently only found the BT and SSBS fields can be written without
>>> any unknown behavior.
>>
>> I can only assume you haven't looked hard enough.
>>
>>>
>>> All other fields in the ID_AA64PFR1_EL1 are either not supported by
>>> KVM or the field involved with other register and KVM don't know how
>>> to handle them.
>>
>> Why can't CSV2_frac be writable? Why can't most of the other fields be
>> hidden depending on the VM configuration, as pointed out above?
> 
> I looked at the "struct arm64_ftr_bits ftr_id_aa64pfr1[]" in the 
> kernel/cpufeature.c, I don't see the CSV2_frac has been supported on ARM 
> bare-mental. In this situation, can we first support it in KVM? If so, 
> how can we do that, I don't understand that, could you give me some 
> hints about that.

More description about the CSV2_frac.

static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_SME_SHIFT, 4, 0),
	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 
ID_AA64PFR1_EL1_MPAM_frac_SHIFT, 4, 0),
	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 
ID_AA64PFR1_EL1_RAS_frac_SHIFT, 4, 0),
	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MTE_SHIFT, 4, 
ID_AA64PFR1_EL1_MTE_NI),
	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, 
ID_AA64PFR1_EL1_SSBS_SHIFT, 4, ID_AA64PFR1_EL1_SSBS_NI),
	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_BTI),
				    FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_BT_SHIFT, 4, 0),
	ARM64_FTR_END,
};

If we make the CSV2_frac writable, there isn't definition about 
CSV2_frac in the ftr_id_aa64pfr1. And the KVM really depends on the 
ftr_id_aa64pfr1 in the arm64_check_features() function. We're missing 
the CSV2_frac.

So the arm64_check_features() will not check the CSV2_frac if it's 
writable, and the user can write any value into it.

Thanks,
Shaoqin

> 
> Other fields are same with CSV2_frac I think. The KVM don't know the 
> configuration about them. Why we should allow them writable and hidden 
> them right now? Instead of just make them still unwrittable? >
> Thanks,
> Shaoqin
> 
>>
>>     M.
>>
> 

-- 
Shaoqin


