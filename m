Return-Path: <linux-kernel+bounces-545578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AEA4EECA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A47A421D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BDF265639;
	Tue,  4 Mar 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nor27+Xt"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B491FBC98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121492; cv=none; b=IEFU/boIipf/TcFgtdIFvTAFSKCT2h5lhrBoDm9taEhoy6sdwW/ntqgnHluDvAV0gFnksiU10ghbLDvrsdsBppL5DUKCoBxVH9gpoGPCw4F1mcjRqPoF/GcP5OLKGiB/I7ZbEWefOBT0ezN98V6Km/kqezRUIvlrSj2toKXDJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121492; c=relaxed/simple;
	bh=S4zgskqTby/rdk7TA8HRhjonoTjUJkfCF2UNYsTxXy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1JzhZHsh3wKPauGJc/rF448vpZre/ziv51sObK7IN2uwPJC2++nBIg6MLW6tg54sDOgquhhkrfDjN67hgqPFTo07ydvDsPSN1azc/S9p5y1UTRSVqSfIY1AR5GQozMVwAlk3aV7EpF0GaHr8+33LOH6vNSJWGGP24QeM4EIz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nor27+Xt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f406e9f80so4621718f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121488; x=1741726288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dqCiUR+VtYZ1iXicg8DOvKaTFhWRMaeKH7BEMD7Z0kU=;
        b=Nor27+Xt4jpubTEB8uMOqBDzO01Qyklddluq3Lm6dKbRjgitBIDB3wEQkWJzPWXYrg
         kh/8jHonsDjapHLWP9Cuku9oV5xkselkMCA6sxnhr52huA9InqCPcl2DnZVpakzjm3Wl
         Loeurx+6+EklAZ6vvwngG5I8iUamLD9EnxZ053Goyc7nkPgZs96C9qcR6IQVGcu0IJC4
         16Bp7hp7/oYhu3HaqC5CTiPfggE1TufDxp9Y7t1kuMJqETRtuWAf8IZNkaSJrRnQhia3
         1qeoyP7DoFky2pHOuo9e9cXxrlpxw65NgFqbsbsdfRipx7x1IkRar9wh78GZx4S0p8A1
         oXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121488; x=1741726288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqCiUR+VtYZ1iXicg8DOvKaTFhWRMaeKH7BEMD7Z0kU=;
        b=fDEBje9g7Ik97suYitNOX2b90R7iIzSa2aGzPRkG1FkvJXkGhNamwVmY2v3lGxkfSg
         y50R6ar9hzvmFVxDTmJlkv8d96mABpB3AW4BI9mbrvLlaBzLOI7XgXpYpGeTJB0/34x0
         HnHVGokNccC+PyvnVp83BYYwhwi7FI8jHP9XSc/nKHI5bCuAVHGhS6WcBtIAQiINpGdG
         zaUV06GKmpdMoRUKL9G2/dsRHsM74HTqFTlLys21Hkgx0ih0Pce2p3VTANmWyvmakuRy
         DO/GGx/rTDdbzJKYlcPwcigRQ0iLbzZPjveOyoiYJCoktNQ0KTuOEPmn5W1cyio8GY8/
         CjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdexE3qr9lQe4I08q9RehbnL4UtZLd6wD2Jp0Is7Gww9wem3YINOZOyP0Z83lEchrSmHE+4ZfEYGEBgZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa759ZW2qt/EhR39QsZzeOnv6S8HlyqwiYYiSsPJNXQcleVaJr
	kUbkNSqPDUX4I6XuBYXWryDry2pb/56P1MqBZ8DZzafOwqKDa7hfn/0JKjtdiQE=
X-Gm-Gg: ASbGncsyvbVIU9yMX6Co5oMlKW5XsMbT0pfqTyaRlgCLqC1r5uZ3CJ0YrmbdwGWs8fE
	rD7ccU4kYacHU7UWdHt7pb+E+QrbQomQQf931eHO1yd7vnWxHm2uNwIedhlIyLfeUap9wkOTvkj
	octUC/+Qo5KkTSrDKTTYRgb0dilQvrIENQwiZn0OG1HT4bINlHDQXQpHG/oTzp5Qqsfoddk6XUC
	WRMAC8UWqnw0t+E8McIhp4/9PCUCvUKejry7u4MKlc8BLu2cdoOwLZeik7wC+ZrvwuCZsJFSB2U
	l0hyD0/Dw8M1xoxAB49822KGbVuL6m4pUi9UGTNmVL+xsqxP4mBxsoJyXPQfi9ueQmEy5YyW9I4
	L4vEg+dGM
X-Google-Smtp-Source: AGHT+IFEDfBRhDzGXmuKkh231a6HvLL4kF20x4c7He8dKb/Wku1OOVCCY/1L9jtdUl1lMgHRpDPY7g==
X-Received: by 2002:a5d:59a5:0:b0:390:f1c1:d399 with SMTP id ffacd0b85a97d-3911f7bb9b8mr200990f8f.41.1741121488037;
        Tue, 04 Mar 2025 12:51:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e4844a2dsm18831020f8f.72.2025.03.04.12.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:51:26 -0800 (PST)
Message-ID: <6511298a-4627-4d5a-a8a0-27f33f6cbea9@linaro.org>
Date: Tue, 4 Mar 2025 21:51:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] clocksource/drivers/timer-clint: Add T-Head C9xx clint
To: Jesse Taube <mr.bossman075@gmail.com>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, Jisheng Zhang <jszhang@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250117164536.3918949-1-Mr.Bossman075@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250117164536.3918949-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/01/2025 17:45, Jesse Taube wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> To use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need to take
> care two points:
> 
> 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> add a quirk for lacking mtime register") of opensbi:
> 
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
> 
> So, we need to fall back to read time CSR instead of mtime register.
> Add riscv_csr_time_available static key for this purpose.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> Treat this as a completely new patch, as it is mostly rewritten.
> Original:
> https://lore.kernel.org/all/20240410142347.964-3-jszhang@kernel.org/
> V3 -> V4:
>   - Add riscv,csr-clint
>   - Allow using of CSRs in S mode
>   - Change if return else return to if return return
>   - Change static_branch_likely to static_branch_unlikely
>   - Fix 32-bit clint_get_cycles64 csr_available check being inverted
>   - Fix is_c900_clint being uninitialized
> V4 -> V5:
>   - Remove riscv,csr-clint
>   - Remove riscv_csr_time_available
>   - Replace all static_branch_unlikely(&riscv_csr_time_available) with
>      riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR)
> ---
>   arch/riscv/include/asm/timex.h    | 12 +++++++-
>   drivers/clocksource/timer-clint.c | 50 +++++++++++++++++++++++++++----
>   2 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index a06697846e69..d78075351bf4 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -17,17 +17,26 @@ typedef unsigned long cycles_t;
>   #ifdef CONFIG_64BIT
>   static inline cycles_t get_cycles(void)
>   {
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +		return csr_read(CSR_TIME);
> +
>   	return readq_relaxed(clint_time_val);
>   }
>   #else /* !CONFIG_64BIT */
>   static inline u32 get_cycles(void)
>   {
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +		return csr_read(CSR_TIME);
> +
>   	return readl_relaxed(((u32 *)clint_time_val));
>   }
>   #define get_cycles get_cycles
>   
>   static inline u32 get_cycles_hi(void)
>   {
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +		return csr_read(CSR_TIMEH);
> +
>   	return readl_relaxed(((u32 *)clint_time_val) + 1);
>   }
>   #define get_cycles_hi get_cycles_hi
> @@ -40,7 +49,8 @@ static inline u32 get_cycles_hi(void)
>    */
>   static inline unsigned long random_get_entropy(void)
>   {
> -	if (unlikely(clint_time_val == NULL))
> +	if (!riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR) &&
> +	   (unlikely(clint_time_val == NULL)))
>   		return random_get_entropy_fallback();
>   	return get_cycles();
>   }
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 0bdd9d7ec545..cdf8b33d2dd2 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -39,6 +39,7 @@ static u64 __iomem *clint_timer_cmp;
>   static u64 __iomem *clint_timer_val;
>   static unsigned long clint_timer_freq;
>   static unsigned int clint_timer_irq;
> +static bool is_c900_clint;
>   
>   #ifdef CONFIG_RISCV_M_MODE
>   u64 __iomem *clint_time_val;
> @@ -79,6 +80,9 @@ static void clint_ipi_interrupt(struct irq_desc *desc)
>   #ifdef CONFIG_64BIT
>   static u64 notrace clint_get_cycles64(void)
>   {
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR))
> +		return csr_read(CSR_TIME);
> +

Given the critical path from where this routine is called, I suggest to 
create a different function and figure out which one to use when calling 
sched_clock_register().


>   	return clint_get_cycles();
>   }
>   #else /* CONFIG_64BIT */
> @@ -86,10 +90,17 @@ static u64 notrace clint_get_cycles64(void)
>   {
>   	u32 hi, lo;
>   
> -	do {
> -		hi = clint_get_cycles_hi();
> -		lo = clint_get_cycles();
> -	} while (hi != clint_get_cycles_hi());
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZICNTR)) {
> +		do {
> +			hi = csr_read(CSR_TIMEH);
> +			lo = csr_read(CSR_TIME);
> +		} while (hi != csr_read(CSR_TIMEH));
> +	} else {
> +		do {
> +			hi = clint_get_cycles_hi();
> +			lo = clint_get_cycles();
> +		} while (hi != clint_get_cycles_hi());
> +	}

Same comment here.

>   	return ((u64)hi << 32) | lo;
>   }
> @@ -119,6 +130,19 @@ static int clint_clock_next_event(unsigned long delta,
>   	return 0;
>   }
>   
> +static int c900_clint_clock_next_event(unsigned long delta,
> +				       struct clock_event_device *ce)
> +{
> +	void __iomem *r = clint_timer_cmp +
> +			  cpuid_to_hartid_map(smp_processor_id());
> +	u64 val = clint_get_cycles64() + delta;
> +
> +	csr_set(CSR_IE, IE_TIE);
> +	writel_relaxed(val, r);
> +	writel_relaxed(val >> 32, r + 4);
> +	return 0;
> +}
> +
>   static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
>   	.name		= "clint_clockevent",
>   	.features	= CLOCK_EVT_FEAT_ONESHOT,
> @@ -130,6 +154,9 @@ static int clint_timer_starting_cpu(unsigned int cpu)
>   {
>   	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
>   
> +	if (is_c900_clint)
> +		ce->set_next_event = c900_clint_clock_next_event;
> +
>   	ce->cpumask = cpumask_of(cpu);
>   	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
>   
> @@ -161,7 +188,7 @@ static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static int __init clint_timer_init_dt(struct device_node *np)
> +static int __init clint_timer_init(struct device_node *np)
>   {
>   	int rc;
>   	u32 i, nr_irqs;
> @@ -273,5 +300,18 @@ static int __init clint_timer_init_dt(struct device_node *np)
>   	return rc;
>   }
>   
> +static int __init clint_timer_init_dt(struct device_node *np)
> +{
> +	is_c900_clint = false;
> +	return clint_timer_init(np);
> +}
> +
> +static int __init c900_clint_timer_init_dt(struct device_node *np)
> +{
> +	is_c900_clint = true;
> +	return clint_timer_init(np);
> +}
> +
>   TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
>   TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
> +TIMER_OF_DECLARE(clint_timer2, "thead,c900-clint", c900_clint_timer_init_dt);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

