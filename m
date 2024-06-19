Return-Path: <linux-kernel+bounces-220448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7F90E1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B01C21C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E675466B;
	Wed, 19 Jun 2024 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br2ZkZ3R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC215381A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766863; cv=none; b=WqCwHztBIoAeOykaGo1GdnFsSB+xMYVvDkKZklfN8rkvFDlaOau01g+c8xRZmFs0tcZfFJEODtaXpLVDTso+cJ7fKAkWg1ie0UO4wH2gaIHYHvLlx4Dcr+NGYt2dXujCI+MrsRLZdCEIrajS5i6KbxqW5whPP/UNvr4ScxAegJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766863; c=relaxed/simple;
	bh=HCO/NBM4UiS3q3hQ8PL3dHNxoff5mt29/TnShlpKiIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtfHHFa4llrw/h86I2Xer9y6tFd7TCAxBusu/txQraCbORVFuSJP8JvgVajkSzkIiAuG8O6N5Oj3hHf2+yVpjd5Tz1MEI9vRtOF9oaLzTq5Af8RCfSNjj6J8e4v7hPfdQJ/DOr2vdXVKyhZslrQMK7DVAYNwB0hLE+UiS5EAks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=br2ZkZ3R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718766860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu1FpPzl8IevhKciNXGcEefUI4jkbj9fi9eUxAv5GvM=;
	b=br2ZkZ3RcsidG1QDXPXtg/SHzToQ+iifxU5QFVEKx/DdmVhAVfGbk2gBn+sBCFkI14gRm1
	Z0+jN9utLF/hgG75u+mR3CewXWurCPRCm+bCLdFdfE+PO07EqVfLIHL1CQG5UFaOgadk02
	X4TU4F40A92o4O7TEXa0eEkv3AnViZg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-20mcV-HEPfiuaGlWDGDQMA-1; Tue, 18 Jun 2024 23:14:18 -0400
X-MC-Unique: 20mcV-HEPfiuaGlWDGDQMA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c7a8dc0e60so219854a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766857; x=1719371657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu1FpPzl8IevhKciNXGcEefUI4jkbj9fi9eUxAv5GvM=;
        b=JH3Zcv4mPJ2bpRNdagaKMW+zrB5QHWP+eqbXKmHElOqSixkBINu+CUT7qN+jnMRvnH
         LhylqRk/SNiJgheO+N6NU2SrTy1J5063TQfRhbG9BcZd1RsBjbHnX5m+eErFSRLsCwKh
         WR0Ig2L4IQS+y62Y89z5hK2+TtikIeBEN6Y1Aph6+cLZfIpyBysqkunFWF/GMKWaDfCk
         5b4kjlanAXDkRah4RxCK0jvHEU94TqWPcwe4gX+3iLfB/67OZI12s4G8DL0GEttsTo8M
         M4U9Kuh4cEMd2PKkBZ1OJehEo7IDwZx0bowqFeEQgVO++Tc7Ts+zqAC9j37NZKfXFOS1
         Lkqg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ssQQiKh1nNd+CsBo07QM1DHQR62QfxKGg8BRc/y6TFLJL8sOB0wVOWvxEgwLTwBKA6VBIgx4Krjuqw+9uNd7Xx0hO/elfQMSJu/r
X-Gm-Message-State: AOJu0YyogVLivasNHZWs0H1wiBzxLkcLSHD4JYuTKWzuOOg8B8qmLWSB
	Iao3dKMDd6pi69FhKW7G/pThYqbsYPwFlht5B1mOwOswb+vu0MhJWABStHAzbqZfmosnI4xOlKR
	irTFAGatAqIwp8RbhzzdBPV1velDn8w/IhcAQsljwVVMaF4ISOgJF+g0G4201pg==
X-Received: by 2002:a05:6a21:3288:b0:1af:cefe:dba3 with SMTP id adf61e73a8af0-1bcbb15a367mr1457866637.0.1718766857486;
        Tue, 18 Jun 2024 20:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRGQn2HiBnUoo04NErpQEUuoD9nSU7bThW4HxX4VzWxwqGB9fgoYsiu1NOrGthWpCZdiB7w==
X-Received: by 2002:a05:6a21:3288:b0:1af:cefe:dba3 with SMTP id adf61e73a8af0-1bcbb15a367mr1457849637.0.1718766857096;
        Tue, 18 Jun 2024 20:14:17 -0700 (PDT)
Received: from [10.72.113.31] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f15a9csm105106995ad.222.2024.06.18.20.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 20:14:16 -0700 (PDT)
Message-ID: <b5be75e2-4dd4-4cae-9b88-382733bd4e4d@redhat.com>
Date: Wed, 19 Jun 2024 11:14:10 +0800
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

Thanks for pointing out the problem. I will figure those field out and 
update this patch later on.

> 
> 	M.
> 
> [1] https://developer.arm.com/documentation/ddi0601/2024-03/AArch64-Registers/ID-AA64PFR1-EL1--AArch64-Processor-Feature-Register-1?lang=en

Ok I found that I used the obsolete ARM document so I didn't see the 
MTE_frac and MTEX. Thanks for letting me know the latest ARM document.

Thanks,
Shaoqin

> 

-- 
Shaoqin


