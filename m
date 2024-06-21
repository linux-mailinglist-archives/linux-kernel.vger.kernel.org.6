Return-Path: <linux-kernel+bounces-223983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA1911B70
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CD01F2425F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7816D304;
	Fri, 21 Jun 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlOv4AMc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43C16C870
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950690; cv=none; b=N4Za11GBrl0SW0cQ2JqdaQcMp1qYh7rwzpuQXo5XWwRVhgfSvJxdJfiTBVjXLCD6uFpZ8oWbDWvmbmdoN+x2Gc4pP0Ew3IWYDeRVJaF4UHPbMI5fwttQZr7OAf+DdMBV/2d/Y07/DWZ9rgpU0FIfz625cheR2ONOCnLK1K0+OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950690; c=relaxed/simple;
	bh=4kA4t2OjVgBkAaBJo7prVXyN4l1n+l8Dg6A7Nzin2c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz4IjPO4JA83EO/h1gw6iA2gs2oFQvobeexHTBQKUGAzqkX05ny3WXuEwQVXZ4Hvf9S4+Mkc08B0VJZQwwrT9izavZEbTLA77DS3wD/naZMNcehDH7H/5vFGe5XOUIawByEqivEdWyM+h13Y8O+MjDR48pIk2yWgJUHseKMf1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlOv4AMc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718950686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5p7/VGbgORzLG3uJOaywvB8lHG4XigY5Z2PGvIE4TI=;
	b=dlOv4AMc5z+fgiCVkXA8yGOcCpzpz+P46emMxyHzJo79wO19VdcLDsd+iugs4Fo/zdeSJs
	cQPG3UExeurJPsMdlp/Oc2MgVibLokiJW/GTm4Xe8XXzuVKnTvyAc307KPaUaNPnLFwDcG
	Ks6U61JcEMh7skPBhv/peJHlJiIvwKU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-aGVMyZdvP52GEubAvtfbGg-1; Fri, 21 Jun 2024 02:18:05 -0400
X-MC-Unique: aGVMyZdvP52GEubAvtfbGg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d219da9666so110556b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950684; x=1719555484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5p7/VGbgORzLG3uJOaywvB8lHG4XigY5Z2PGvIE4TI=;
        b=ddPYf77vPkR94nxmMCD5EDzBt9ZU7BP/zJDYYzpknn91R8tvUwaMEc6xIxG3WMP3ux
         dDOVOuaoPpJey2sYo0ac98rLV6h2ahjz86UwZaQ2vGnyjzKnfHioVvpUzy1RSK5n/A4w
         5Lr4oDDMd7SJjguDWqBPxqBMq5VCSbZqUyg8XUkmyKhqY57JfFE2C345aEu/udkAO6Zh
         oXD5Rf9weswYh2RF4pHSzGkgirduASzaJ7SemFHJa1Pxt4F0ybDu+gHd1/QU533YtFXE
         A1pNV7kYWCj91qQXJ+syfCznfpCjGILu5Z4YUSo/jqjDcLgjn5+eKVcZN9CUU5A/UvBa
         tznQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVf3yvhFP1osMyns5AoN4aEjwwdWy3hrLPB7OKUQeacPq97FbrO1OqKSWsP3hw8wqC4Vpf5wqBJJSlpv1MlyBPRMlV9MtqFdByxHnD
X-Gm-Message-State: AOJu0YzqYJwVQnWx6T/AvAGxpiXaFEgrjlkl/lRvCmN2g1Bz9KFhlaIV
	19WVp+VmGDvdGvy/M977wbG0cd9TmbavAnFmRPp2twN17xgZxjBhyaDNPA6azTkEeq0j6CFUu6x
	FhIxpOOLqU65pInwaCHToG5vO0W5WzpBmlYii7qQN09rqMinWfYF4Y8oVooj80w==
X-Received: by 2002:a05:6808:3091:b0:3d5:11bd:154c with SMTP id 5614622812f47-3d51b98f9a7mr8803283b6e.2.1718950683517;
        Thu, 20 Jun 2024 23:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC3Ek3Uc/wSB68KwIgzf9gYnnocy1y8MxT1dU06xNYyZzA1wwesXNJUaTfwWdM/Q2bRttI8w==
X-Received: by 2002:a05:6808:3091:b0:3d5:11bd:154c with SMTP id 5614622812f47-3d51b98f9a7mr8803271b6e.2.1718950683174;
        Thu, 20 Jun 2024 23:18:03 -0700 (PDT)
Received: from [10.72.116.78] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065119428fsm640113b3a.72.2024.06.20.23.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 23:18:02 -0700 (PDT)
Message-ID: <f73cabc6-8c48-4c12-9d60-269e50df41f3@redhat.com>
Date: Fri, 21 Jun 2024 14:17:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] KVM: arm64: Allow userspace to change
 ID_AA64PFR1_EL1
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240618063808.1040085-1-shahuang@redhat.com>
 <20240618063808.1040085-2-shahuang@redhat.com> <86ed8uk8cr.wl-maz@kernel.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <86ed8uk8cr.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 6/18/24 15:39, Marc Zyngier wrote:
> On Tue, 18 Jun 2024 07:38:06 +0100,
> Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> Allow userspace to change the guest-visible value of the register with
>> some severe limitation:
>>
>>    - No changes to features not virtualized by KVM (MPAM_frac, RAS_frac)
>> ---
>>   arch/arm64/kvm/sys_regs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 22b45a15d068..bead81867bce 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -2306,7 +2306,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>   		   ID_AA64PFR0_EL1_GIC |
>>   		   ID_AA64PFR0_EL1_AdvSIMD |
>>   		   ID_AA64PFR0_EL1_FP), },
>> -	ID_SANITISED(ID_AA64PFR1_EL1),
>> +	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RAS_frac |
>> +				       ID_AA64PFR1_EL1_MPAM_frac)),
>>   	ID_UNALLOCATED(4,2),
>>   	ID_UNALLOCATED(4,3),
>>   	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
> 
> This isn't a valid patch.
> 
> Furthermore, how about all the other features that may or may not be
> currently handled by KVM? Please see [1] and make sure that all
> existing fields have a known behaviour (a combination of masked,
> preserved, capped, writable or read-only).
> 
> I can at least see problems with MTE_frac and MTEX, plus all the other
> things that KVM doesn't know how to save/restore (THE, GCS, NMI...).
> 
> What I asked you to handle the whole register, I really meant it.

I currently only found the BT and SSBS fields can be written without any 
unknown behavior.

All other fields in the ID_AA64PFR1_EL1 are either not supported by KVM 
or the field involved with other register and KVM don't know how to 
handle them.

I'm not sure if this is right. So I want to ask about your opinion about 
how to allow each of the field to be writable in the ID_AA64PFR1_EL1 
register?

Thanks,
Shaoqin

> 
> 	M.
> 
> [1] https://developer.arm.com/documentation/ddi0601/2024-03/AArch64-Registers/ID-AA64PFR1-EL1--AArch64-Processor-Feature-Register-1?lang=en
> 

-- 
Shaoqin


