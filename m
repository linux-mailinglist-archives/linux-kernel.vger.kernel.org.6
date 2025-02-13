Return-Path: <linux-kernel+bounces-513001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B42A6A3405F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7E188DAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84A227EA3;
	Thu, 13 Feb 2025 13:28:20 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB623F417
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453300; cv=none; b=E4tZ5YwOJjkPu1hXeb1TqgUC1Qi94Ofp+kwiC6meFai46Q4LHN1ku4WiiGRh9rtN2Pvvb/onFmJIlIedLvFdDcwRtUIsjLu3PCmF0aElu4zUswl55w433xnx9VcjeLpQQBvxkzgA12zDOE8WyxieSSUxI8u4b43/9o+MmpQjNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453300; c=relaxed/simple;
	bh=RQY6bGYDJeKZMLI7Z+sAL/C0yIu2KTRgxfUjPDXt8hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pO6aB4eGcSP8nx1VAEP792HykQFzumU42HG9DvYR5AcaxGEDiRUqpD1e2NVYg/3yFo06EOQePoZP1GI/muFDFBlaDSQ8ODy8AWpwhG0Bs0G3l62DtsJGL+Zc7Sx3Ls7Psgi6Jmx0Ib+D5Q7DRPVKiboLiHg3hA7LFSimNftmf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2034441A0;
	Thu, 13 Feb 2025 13:28:13 +0000 (UTC)
Message-ID: <0a895286-2084-42d5-9d19-5a27d9cb6ef9@ghiti.fr>
Date: Thu, 13 Feb 2025 14:28:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] riscv: Fix set up of vector cpu hotplug callback
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 jesse@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20250207161939.46139-11-ajones@ventanamicro.com>
 <20250207161939.46139-17-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250207161939.46139-17-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjvghsshgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr


On 07/02/2025 17:19, Andrew Jones wrote:
> Whether or not we have RISCV_PROBE_VECTOR_UNALIGNED_ACCESS we need to
> set up a cpu hotplug callback to check if we have vector at all,
> since, when we don't have vector, we need to set
> vector_misaligned_access to unsupported rather than leave it the
> default of unknown.
>
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/unaligned_access_speed.c | 31 +++++++++++-----------
>   1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index c9d3237649bb..d9d4ca1fadc7 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -356,6 +356,20 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
>   	per_cpu(vector_misaligned_access, cpu) = speed;
>   }
>   
> +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> +static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> +{
> +	schedule_on_each_cpu(check_vector_unaligned_access);
> +
> +	return 0;
> +}
> +#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> +static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static int riscv_online_cpu_vec(unsigned int cpu)
>   {
>   	if (!has_vector()) {
> @@ -363,27 +377,16 @@ static int riscv_online_cpu_vec(unsigned int cpu)
>   		return 0;
>   	}
>   
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>   	if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN)
>   		return 0;
>   
>   	check_vector_unaligned_access_emulated(NULL);
>   	check_vector_unaligned_access(NULL);
> -	return 0;
> -}
> -
> -/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> -{
> -	schedule_on_each_cpu(check_vector_unaligned_access);
> +#endif
>   
>   	return 0;
>   }
> -#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> -static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> -{
> -	return 0;
> -}
> -#endif
>   
>   static int __init check_unaligned_access_all_cpus(void)
>   {
> @@ -409,10 +412,8 @@ static int __init check_unaligned_access_all_cpus(void)
>   	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>   				  riscv_online_cpu, riscv_offline_cpu);
>   #endif
> -#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>   	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>   				  riscv_online_cpu_vec, NULL);
> -#endif
>   
>   	return 0;
>   }

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


