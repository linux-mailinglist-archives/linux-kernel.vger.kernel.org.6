Return-Path: <linux-kernel+bounces-428480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1C9E0F05
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0278282945
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB501DFD84;
	Mon,  2 Dec 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Gnc6pJ1f"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9421DB940
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179755; cv=none; b=OJnnUWC2QTXdw9UgwaO7+PjZyIzvUUmU0tmP5RCu6h5S9gA7NNYLQ5e0A4qzbwxv9JvwkJPYAeOd/oQwKECgBZBEjL9qkfWaugr+MnFsHkMvONMk/v1yMmYaNHI8lw5E7klfoGB7XxknpwUGoiurgQpoNsquWYLOzMU2fusf4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179755; c=relaxed/simple;
	bh=OiT8bZBW9JwxhYUpHWYCsgYxRPzHueGdKeT0Ly3ZIK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuNILxCz9b9NubN9E63iZ7RN5xNNIpiDWll0PjLjps/xFo35bJ9fEAGcWtkrxdI9KTDVIXc1s5k/pFvtGmn2NeiJTpRLF8AEgLhnF2CnZhQjTrWUtqqsTgw6gH01Ionw7i1pkqSrSbZrFlnoX9tjVWlETQ+/YhryUzSIiPOLk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Gnc6pJ1f; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a74d9aeb38so16406545ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733179751; x=1733784551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fURT0toHjcy+ckEXrUmwcruMUsZPdjbEVGK7GwErbNE=;
        b=Gnc6pJ1fG0rB83dsd3dT8XpdKXnxdI0+SKilAQVGfP5v6S6BGBOVvLVoCPg1M+tmJo
         MEE54UDfEkDuRWRvi5texQYX0erveeaJEF+q64Zj6IJB1/ppKyWGf5Axu4dxE0HqUBEJ
         ffNLHwjRqFh1SIB61OLos/gt/BI1k36UVfvqCjnEoHKjGCRbbSXLDSlnUFe+Y3OiJBZQ
         sx26l9P+3b1jnJkdliIXXLQjcNVElKMVodApf6TKtMpPH25NRDMAtSS125sol82590hN
         pdpvxSU/UvsBi/AFuvrBviYyFMGeej5SBBxsfiqC2Kizpyeq/qPwlRuMKexKN8MECIXv
         VQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179751; x=1733784551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fURT0toHjcy+ckEXrUmwcruMUsZPdjbEVGK7GwErbNE=;
        b=qz0OyB9mdN4aXN8vkgSj6bDsAbASEo+QwlLdX17Cz3h0PlnyNTA84tuElIQzlkYYCm
         GucvRLu5NTRBLi2ub/v6hAR8F+koN+5hSe09mON1JuK/brilCx+UfZyeA/O+4kDQpXCP
         UTpBbazFEDGVBR3UB9lNcik9FJCdu9Qp8dA11fUFuMqtkpuRNgPjS2oM9M8oByxtvnJK
         Hkd2C2v1CqnTC9LxEjHzT5pPF057/dmPHpfLZxxaBJPym9u9GWfhabSeeuvSWYy1ICUk
         2k+ElYOp8iZUnnIFL3S0ho9//BCeykyyq4DjKwc/VfOKBnMeZHtQtwJFOOKRDNYuoMdY
         +AUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRHLW+a3lIU2y57XJv2wYGaN+skAb48E/TuoNFfbfEwt0JauOxiBY/32k3xTkdJSu8w6Ve+MBzUdEh+6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQHM8bDJrJuqh8YJpGpOY8q/plgmRKAHWJCWzdUSIriDpOmJ9
	uxECfqqMVy0ytU/7RU8FWUQp5Y+6Q86NR4MjcXSfP+/Ipx7f/ikC7GRZGCC/+TU=
X-Gm-Gg: ASbGncv2EtAjq05RlAWJFc1gcdOypWCuZ8pBk45iXZB2GDc6HfziVDZ1lBxP+DDjnC9
	jMEKq/PI/y2rNo1dJW0Vscil813WTnlgwltd+GRRTAQ/cGSge6i9fvUOHpBYSbOuUknJrwRpokF
	K5s3lhtgDQunKfcTdDQrptCucPxI9usjosC+ucjeNQ9qwMUy81W2UzC9OWN8u7EXd8VzAwfSJvv
	WnmHqEun0xBVMuNebXVEmMRAuHIMSyNAqcQKuKNaGGh4EO6XOOqG7bDRiUTQmA7WVgmU5gVQbE=
X-Google-Smtp-Source: AGHT+IF9tXYZOtmonlaAqjdjkiR3RpZurv0DzZ0bFu7NZtqj+dCVIe1TaFCSnbY1pyQjqWZh355Bpg==
X-Received: by 2002:a92:c54f:0:b0:3a7:8720:9de5 with SMTP id e9e14a558f8ab-3a7f9a36198mr3019085ab.1.1733179751641;
        Mon, 02 Dec 2024 14:49:11 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e5f1easm2357604173.95.2024.12.02.14.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:49:10 -0800 (PST)
Message-ID: <0a4a569e-dfab-4aed-90df-2fe9719a3803@sifive.com>
Date: Mon, 2 Dec 2024 16:49:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drivers/perf: riscv: Implement PMU event info
 function
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
 <20241119-pmu_event_info-v1-5-a4f9691421f8@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20241119-pmu_event_info-v1-5-a4f9691421f8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Atish,

On 2024-11-19 2:29 PM, Atish Patra wrote:
> With the new SBI PMU event info function, we can query the availability
> of the all standard SBI PMU events at boot time with a single ecall.
> This improves the bootime by avoiding making an SBI call for each
> standard PMU event. Since this function is defined only in SBI v3.0,
> invoke this only if the underlying SBI implementation is v3.0 or higher.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h |  7 +++++
>  drivers/perf/riscv_pmu_sbi.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 3ee9bfa5e77c..c04f64fbc01d 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -134,6 +134,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_FW_READ,
>  	SBI_EXT_PMU_COUNTER_FW_READ_HI,
>  	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +	SBI_EXT_PMU_EVENT_GET_INFO,
>  };
>  
>  union sbi_pmu_ctr_info {
> @@ -157,6 +158,12 @@ struct riscv_pmu_snapshot_data {
>  	u64 reserved[447];
>  };
>  
> +struct riscv_pmu_event_info {
> +	u32 event_idx;
> +	u32 output;
> +	u64 event_data;
> +};
> +
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_PLAT_FW_EVENT_MASK GENMASK_ULL(61, 0)
>  /* SBI v3.0 allows extended hpmeventX width value */
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index f0e845ff6b79..2a6527cc9d97 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -100,6 +100,7 @@ static unsigned int riscv_pmu_irq;
>  /* Cache the available counters in a bitmask */
>  static unsigned long cmask;
>  
> +static int pmu_event_find_cache(u64 config);

This new declaration does not appear to be used.

>  struct sbi_pmu_event_data {
>  	union {
>  		union {
> @@ -299,6 +300,68 @@ static struct sbi_pmu_event_data pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>  	},
>  };
>  
> +static int pmu_sbi_check_event_info(void)
> +{
> +	int num_events = ARRAY_SIZE(pmu_hw_event_map) + PERF_COUNT_HW_CACHE_MAX *
> +			 PERF_COUNT_HW_CACHE_OP_MAX * PERF_COUNT_HW_CACHE_RESULT_MAX;
> +	struct riscv_pmu_event_info *event_info_shmem;
> +	phys_addr_t base_addr;
> +	int i, j, k, result = 0, count = 0;
> +	struct sbiret ret;
> +
> +	event_info_shmem = (struct riscv_pmu_event_info *)
> +			   kcalloc(num_events, sizeof(*event_info_shmem), GFP_KERNEL);

Please drop the unnecessary cast.

> +	if (!event_info_shmem) {
> +		pr_err("Can not allocate memory for event info query\n");

Usually there's no need to print an error for allocation failure, since the
allocator already warns. And this isn't really an error, since we can (and do)
fall back to the existing way of checking for events.

> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> +		event_info_shmem[count++].event_idx = pmu_hw_event_map[i].event_idx;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> +		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
> +			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
> +				event_info_shmem[count++].event_idx =
> +							pmu_cache_event_map[i][j][k].event_idx;
> +		}
> +	}
> +
> +	base_addr = __pa(event_info_shmem);
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO, lower_32_bits(base_addr),
> +				upper_32_bits(base_addr), count, 0, 0, 0);
> +	else
> +		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_EVENT_GET_INFO, base_addr, 0,
> +				count, 0, 0, 0);
> +	if (ret.error) {
> +		result = -EOPNOTSUPP;
> +		goto free_mem;
> +	}
> +	/* Do we need some barriers here or priv mode transition will ensure that */

No barrier is needed -- the SBI implementation is running on the same hart, so
coherency isn't even a consideration.

> +	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
> +		if (!(event_info_shmem[i].output & 0x01))

This bit mask should probably use a macro.

> +			pmu_hw_event_map[i].event_idx = -ENOENT;
> +	}
> +
> +	count = ARRAY_SIZE(pmu_hw_event_map);
> +
> +	for (i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++) {
> +		for (j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++) {
> +			for (k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++) {
> +				if (!(event_info_shmem[count].output & 0x01))

Same comment applies here.

Regards,
Samuel

> +					pmu_cache_event_map[i][j][k].event_idx = -ENOENT;
> +				count++;
> +			}
> +		}
> +	}
> +
> +free_mem:
> +	kfree(event_info_shmem);
> +
> +	return result;
> +}
> +
>  static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>  {
>  	struct sbiret ret;
> @@ -316,6 +379,14 @@ static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
>  
>  static void pmu_sbi_check_std_events(struct work_struct *work)
>  {
> +	int ret;
> +
> +	if (sbi_v3_available) {
> +		ret = pmu_sbi_check_event_info();
> +		if (!ret)
> +			return;
> +	}
> +
>  	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
>  		pmu_sbi_check_event(&pmu_hw_event_map[i]);
>  
> 


