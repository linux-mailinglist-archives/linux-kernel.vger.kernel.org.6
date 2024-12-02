Return-Path: <linux-kernel+bounces-428487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BF9E0F32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA3163EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8F1DFD9A;
	Mon,  2 Dec 2024 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K0CPNamH"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0C1D79B4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180564; cv=none; b=uZY6viIC4h/Z292uJKO7Ct0mvUBsEx4x67jK+7H+mZ14rIaN+4T2MY9GSxr3EDdqr3JEAJmOFUp8NtuOkqNv+z5kqoU2ih/iSxwjnKYN2nUZ75Xzm6eROjPv46G9v8WRS7pW8wk4yVTP9Qvz359OrXQVUbzo+tckgNDNobn6YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180564; c=relaxed/simple;
	bh=0o/VeYa0bbOGyirOVhNvZLZhLD1xrhRXWY07BbhU40M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3qRw+NwmoBwVIhGqWaN0pu4nj4AyEV8jjJWvu1wmGvJSw9GnM6MjsVv8G+FosBIPDpz0Quei2/kDhbhNOYkdA6KkF3AZXUHCeTeeaL7Hpd7eyj0LVqE9flz6XJsZ04cRtp9njgbVd74yjfXY009FToaSVP4AY8U3UwtJb0esdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=K0CPNamH; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71d4d0516e6so2340385a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733180562; x=1733785362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBGqkK/v5Iev96wXKEIFiXllPqz6RLCGsNpAQ8PdYPY=;
        b=K0CPNamHa88OinRjAImF3h9aCeN4UAivsslpkDJTMR7PMFApdxpXtdVlYejqi/wmK1
         Q3ifTFLhBpvYijEM/8RjmYNzTc1m66BtgvchUlvAje2k1QP72sB4fGZbSUUoQJQXkWQp
         ZflO4D/DsTH+x2+0dXylOFIoColdiQ63bsvifKcfDJqO36vriv5I1YGJWxOpOwT+1PTS
         yt2Az4k6s4PQOfJX6zMVEYg/VhMn5ufPE83zsdYI4PUL/ldXyC5yBHGJbnI3dh5qqFTB
         mdIQbBVsJa+m9ZQM8Lpq3cpiT8uiHN+UCWJ1cHVIDTeEo9F+QCk3RsSkOk5xErxXscNY
         P9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733180562; x=1733785362;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBGqkK/v5Iev96wXKEIFiXllPqz6RLCGsNpAQ8PdYPY=;
        b=uhIkMkdNpxL/m9dMSLp49tBLzbFoX7Y43V/RAAg4IvuqMHxjZI6QDtVH9YBQxfdjQ7
         ExRpTBBUqM1N5xhjwOwWiGC0ZsU9QHkqtA2J4CC3wYgUeuP7MSTbjTEJdI9G2aK389V1
         TAnh0ZnLfKpItlEITDaUXBZCiIO+2mto5nySLJ/gp99ySxA3uZ+x9aZSCcuHWd/2iRHT
         Fe/WZCYdMwGBTw4nUtw/PaO43cNfEKN0tQsz/ACO5vRtS/IsClenOYXR7Euhqjcz1dEt
         my5gpE7R3A+6KdR7rGLYybHCoBXY75GGyvbbP5M6ViWs8JkwwPeSQHcELlp7CBz7PXUx
         T+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD1+nWxMexTDvJpmmX9o+mS8IE4CZgzJa8L8M51doWGjk7TRxpRig8FC51o0gtBtEFZXPRjz5j6baDh+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyZAIrv6/5cceGQEz5QXKRodlPruOSYII04aB8Nq8nw0bvYrd
	lXY/B09YrI3xt3klYTvV2s4hAp/5J9xrk04xLJh+ss1pvm0EdnSyklO53xFEOzE=
X-Gm-Gg: ASbGncuhW/elF2JWbvdL7/JmB0YCAluMq87LKcN/fmXMbpuCazoEM+U9Eq540ytvEDR
	yBr6VQYcKa7wIIITtIXsheXQKvmGeO3pzLdQBqMQN4vHs76HxMNzeuUBCNjQ3osa7zdGpDpyFj8
	7Cx+TGIaiXMlgsxzSgsM/V507CJV5nmLYoZpFqmW2f0hHVF9ZZvSQVFE5DF+lGhgkUPUijPkvLA
	EHytDaJlDKiRm7/e025O/E4yLpyGshWRp/1uFvYCEMhktW2JnuRL8hgs6CkRgxGKNXVIJZZmCY=
X-Google-Smtp-Source: AGHT+IEv1JBbSaCa71BDRL05MtUtqi8CljIjDPjho0wurIfJyJM/U1viaWwUhmNhZ6XHgApvGm5kLA==
X-Received: by 2002:a05:6830:25d4:b0:710:fa7e:e002 with SMTP id 46e09a7af769-71dad6015c9mr537077a34.5.1733180561967;
        Mon, 02 Dec 2024 15:02:41 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230de08f6sm2269346173.79.2024.12.02.15.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 15:02:41 -0800 (PST)
Message-ID: <8dc7e94c-4bf2-4367-8561-166bec6ec315@sifive.com>
Date: Mon, 2 Dec 2024 17:02:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] RISC-V: KVM: Implement get event info function
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
 <20241119-pmu_event_info-v1-7-a4f9691421f8@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20241119-pmu_event_info-v1-7-a4f9691421f8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-11-19 2:29 PM, Atish Patra wrote:
> The new get_event_info funciton allows the guest to query the presence
> of multiple events with single SBI call. Currently, the perf driver
> in linux guest invokes it for all the standard SBI PMU events. Support
> the SBI function implementation in KVM as well.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  3 ++
>  arch/riscv/kvm/vcpu_pmu.c             | 67 +++++++++++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |  3 ++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> index 1d85b6617508..9a930afc8f57 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -98,6 +98,9 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
>  int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
>  				      unsigned long saddr_high, unsigned long flags,
>  				      struct kvm_vcpu_sbi_return *retdata);
> +int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low,
> +				  unsigned long saddr_high, unsigned long num_events,
> +				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata);
>  void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
>  void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index efd66835c2b8..a30f7ec31479 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -456,6 +456,73 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>  	return 0;
>  }
>  
> +int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low,
> +				  unsigned long saddr_high, unsigned long num_events,
> +				  unsigned long flags, struct kvm_vcpu_sbi_return *retdata)
> +{
> +	unsigned long hva;
> +	struct riscv_pmu_event_info *einfo;
> +	int shmem_size = num_events * sizeof(*einfo);
> +	bool writable;
> +	gpa_t shmem;
> +	u32 eidx, etype;
> +	u64 econfig;
> +	int ret;
> +
> +	if (flags != 0 || (saddr_low & (SZ_16 - 1))) {
> +		ret = SBI_ERR_INVALID_PARAM;
> +		goto out;
> +	}
> +
> +	shmem = saddr_low;
> +	if (saddr_high != 0) {
> +		if (IS_ENABLED(CONFIG_32BIT)) {
> +			shmem |= ((gpa_t)saddr_high << 32);
> +		} else {
> +			ret = SBI_ERR_INVALID_ADDRESS;
> +			goto out;
> +		}
> +	}
> +
> +	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, shmem >> PAGE_SHIFT, &writable);
> +	if (kvm_is_error_hva(hva) || !writable) {
> +		ret = SBI_ERR_INVALID_ADDRESS;

This only checks the first page if the address crosses a page boundary. Maybe
that is okay since kvm_vcpu_read_guest()/kvm_vcpu_write_guest() will fail if a
later page is inaccessible?

> +		goto out;
> +	}
> +
> +	einfo = kzalloc(shmem_size, GFP_KERNEL);
> +	if (!einfo)
> +		return -ENOMEM;
> +
> +	ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
> +	if (ret) {
> +		ret = SBI_ERR_FAILURE;
> +		goto free_mem;
> +	}
> +
> +	for (int i = 0; i < num_events; i++) {
> +		eidx = einfo[i].event_idx;
> +		etype = kvm_pmu_get_perf_event_type(eidx);
> +		econfig = kvm_pmu_get_perf_event_config(eidx, einfo[i].event_data);
> +		ret = riscv_pmu_get_event_info(etype, econfig, NULL);
> +		if (ret > 0)
> +			einfo[i].output = 1;

This also needs to write `output` in the else case to indicate that the event is
not supported; the spec does not require the caller to initialize bit 0 of
output to zero.

Regards,
Samuel

> +	}
> +
> +	kvm_vcpu_write_guest(vcpu, shmem, einfo, shmem_size);
> +	if (ret) {
> +		ret = SBI_ERR_FAILURE;
> +		goto free_mem;
> +	}
> +
> +free_mem:
> +	kfree(einfo);
> +out:
> +	retdata->err_val = ret;
> +
> +	return 0;
> +}
> +
>  int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
>  				struct kvm_vcpu_sbi_return *retdata)
>  {
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> index e4be34e03e83..a020d979d179 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -73,6 +73,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
>  		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
>  		break;
> +	case SBI_EXT_PMU_EVENT_GET_INFO:
> +		ret = kvm_riscv_vcpu_pmu_event_info(vcpu, cp->a0, cp->a1, cp->a2, cp->a3, retdata);
> +		break;
>  	default:
>  		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
>  	}
> 


