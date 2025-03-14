Return-Path: <linux-kernel+bounces-561531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C716DA6131B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE0C3AB8FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5B1FFC7A;
	Fri, 14 Mar 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gQvd/ZRR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA02B1FFC41
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960443; cv=none; b=sXl8wFtIaDv4WaT4hYkuKsqIcGnxjQv/A1VOUaotVsDiv4ZJtdFrebUWrBMelDmYsbCeIxLBI6L3hK/me3yUX6Lw4TWBpnzHdI/8eLp1BeoQyzTfYjkdEigbRVjWsLJrPY1YJfCuIEirvgT/lLPTAp2azUztyMbXfId0stbRtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960443; c=relaxed/simple;
	bh=hkuxj9Z6LalKPIM3SuTs15HhyoVDZbez+SnQN16sWVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs8I00gvQKVAUadhOC6EfcPk3SKzHce245KGIess7QKtmZV9kZ6nNI7UbxvzI+cfqvJ9DmKmaKmod/V4qbrv4xLT+iip5Cimhm80UeIncfHS5L9mDV8QJnaD+C+mqLJzcTCG75gze02OqAtoen8PvHbFaJWogndozQK6lCgNpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gQvd/ZRR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0a5cfd7dso14423405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741960440; x=1742565240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fagz20QrFuAHZhTQ6FrQZLAd/rBpo65R2q5CpO1e6Ms=;
        b=gQvd/ZRRu6LYDSLMLDmBfNswGH/Et4f+0d3rlUMDhuloBWJEItFLzR5tg6tNiHhXVb
         cDX24d8I4MUBPr4C1p0MyJj2j1p7NPSHSFXzphxvW7NLPQh6nhyLyKyh3OapZdWdvz/N
         vXSg40qKzeC+FJacbQKjWgcFsfXDIQ/ISHkNgoeLNttT4jzLLhq/ekd/hZ63XG8tmr37
         ntYCjx3lLJVGmnvL2RZqzP5tLNGW6PRl0IMPrFbyVRgF0jJlkjfHt3tDh6Jjsnlk8X2O
         c2gtYIeIGQDaKjTHTW9uezxIn167j0zQ3BOVTLMEBIW+jDocyq9GJ65U2EbZWH2ptowr
         VQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960440; x=1742565240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fagz20QrFuAHZhTQ6FrQZLAd/rBpo65R2q5CpO1e6Ms=;
        b=od5Ri0AzBYObVHvxJcZt+Jb4F/JMYPAEHH/QlxkxYpVpXlsazluSqt/mNTVsj9qFmp
         7C8+iFXipzyeV4jxaJq5605LRE+tCJU4AvfyT+nWTeCj+Il+l5rMjlf+1MganIK9cE5h
         CXtmznXtrbrbxugdIfEIAm83RgBUXwNHverVVQzRwk17nAQ9Qkj6tR+KCvNI4xaI2Lae
         XFx3sUp9sMWlDR8EMjOaDEL4JP99WisLULSOEKeyqKtXYwQZkBs+Kx29lboIEMXBd14D
         TeCzHvKcqD9epTHeGeDlwY82z0qgofZTDyWKGbijti4oP7J7jRWgvi3CKep049WVcNeA
         BO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhZqQlF0w2Y59n7WmDQ7pAa32T9/+gFzk2u875yZXnirROUYzWhDoQQt1+awxGslKklV/8tBXZ3bBRXIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69IRc9ypbsP5hhiyA3E5cKCRwEgLEZgQhpGD8V4u7uWFxToHW
	/YbFuGvAmKIUpLpOVcrKtFGSF+lWs7jZ/hSIA2SrxOI7l55O/SF29Wu9sX+KjBQ=
X-Gm-Gg: ASbGncv82ZszaTC5ptfq1CZ+WssBQKOvBIvQG7pD+50pfhuWmFw9+AxYUJV/wdEFV7g
	D427/YRQWkB1t8TRLew14xuppl7WVVgCdl9kRxJMxLnVVpS5VX60mb5+LjctCr+Te5Djt75Hh4b
	yw+1xYLQD24L3qFjSjdtraUTjAsleWvymHG26gPQHe95F7KDVmuWOKen1klBcABSjV2T4Lt/9PH
	kI9GH5p+fXtnaJohUJ8c1mo3IEeg+tSWgzcsFt/OvnR/7B3AwXyTcqBo/ybNaLKFtu10XwqUvS/
	6o6JgCBTTucgMKL+KHw1NwDN0Ld1kcXFOz/YfqYJJeI7ShJGkNDQCGjAV8cQXQqh3WXhjh8jmPN
	pT3jeFUMHnv34AQ==
X-Google-Smtp-Source: AGHT+IFiUfIYzj4rjDfIocFY+Zq89FGHUz0Fh/cjhy+mbnj+WnaTwAetyDwYahJAg/CF95TRVy0QHw==
X-Received: by 2002:a05:6000:2a6:b0:391:1806:e23d with SMTP id ffacd0b85a97d-3971d03d1b7mr3515213f8f.6.1741960439864;
        Fri, 14 Mar 2025 06:53:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb8c2sm5503118f8f.85.2025.03.14.06.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 06:53:59 -0700 (PDT)
Message-ID: <ed45849c-12b6-446e-b7ad-3e0469378b4d@rivosinc.com>
Date: Fri, 14 Mar 2025 14:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/17] RISC-V: KVM: add SBI extension init()/deinit()
 functions
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-15-cleger@rivosinc.com>
 <20250313-f08cee46c912f729d1829d37@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-f08cee46c912f729d1829d37@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 15:27, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:21PM +0100, Clément Léger wrote:
>> The FWFT SBI extension will need to dynamically allocate memory and do
>> init time specific initialization. Add an init/deinit callbacks that
>> allows to do so.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
>>  arch/riscv/kvm/vcpu.c                 |  2 ++
>>  arch/riscv/kvm/vcpu_sbi.c             | 29 +++++++++++++++++++++++++++
>>  3 files changed, 40 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> index 4ed6203cdd30..bcb90757b149 100644
>> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
>> @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
>>  
>>  	/* Extension specific probe function */
>>  	unsigned long (*probe)(struct kvm_vcpu *vcpu);
>> +
>> +	/*
>> +	 * Init/deinit function called once during VCPU init/destroy. These
>> +	 * might be use if the SBI extensions need to allocate or do specific
>> +	 * init time only configuration.
>> +	 */
>> +	int (*init)(struct kvm_vcpu *vcpu);
>> +	void (*deinit)(struct kvm_vcpu *vcpu);
>>  };
>>  
>>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run);
>> @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_ext(
>>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
>> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>>  
>>  int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long reg_num,
>>  				   unsigned long *reg_val);
>> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
>> index 60d684c76c58..877bcc85c067 100644
>> --- a/arch/riscv/kvm/vcpu.c
>> +++ b/arch/riscv/kvm/vcpu.c
>> @@ -185,6 +185,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>  
>>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>>  {
>> +	kvm_riscv_vcpu_sbi_deinit(vcpu);
>> +
>>  	/* Cleanup VCPU AIA context */
>>  	kvm_riscv_vcpu_aia_deinit(vcpu);
>>  
>> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
>> index d1c83a77735e..858ddefd7e7f 100644
>> --- a/arch/riscv/kvm/vcpu_sbi.c
>> +++ b/arch/riscv/kvm/vcpu_sbi.c
>> @@ -505,8 +505,37 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
>>  			continue;
>>  		}
>>  
>> +		if (!ext->default_disabled && ext->init &&
>> +		    ext->init(vcpu) != 0) {
>> +			scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
>> +			continue;
>> +		}
> 
> I think this new block should be below the assignment below (and it can
> drop the continue) and it shouldn't check default_disabled (as I've done
> below). IOW, we should always run ext->init when there is one to run here.
> Otherwise, I how will it get run later?

Ok, i did not saw that there was a possibility to enable the extension
at a later time. I'll fix that.

Thanks,

Clément

> 
>> +
>>  		scontext->ext_status[idx] = ext->default_disabled ?
>>  					KVM_RISCV_SBI_EXT_STATUS_DISABLED :
>>  					KVM_RISCV_SBI_EXT_STATUS_ENABLED;
> 
>                 if (ext->init && ext->init(vcpu))
>                     scontext->ext_status[idx] = KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE;
> 
>>  	}
>>  }
>> +
>> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_vcpu_sbi_context *scontext = &vcpu->arch.sbi_context;
>> +	const struct kvm_riscv_sbi_extension_entry *entry;
>> +	const struct kvm_vcpu_sbi_extension *ext;
>> +	int idx, i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(sbi_ext); i++) {
>> +		entry = &sbi_ext[i];
>> +		ext = entry->ext_ptr;
>> +		idx = entry->ext_idx;
>> +
>> +		if (idx < 0 || idx >= ARRAY_SIZE(scontext->ext_status))
>> +			continue;
>> +
>> +		if (scontext->ext_status[idx] == KVM_RISCV_SBI_EXT_STATUS_UNAVAILABLE ||
>> +		    !ext->deinit)
>> +			continue;
>> +
>> +		ext->deinit(vcpu);
>> +	}
>> +}
>> -- 
>> 2.47.2
>>
> 
> Thanks,
> drew


