Return-Path: <linux-kernel+bounces-512996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369BA3403D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90E73A73C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C384227EA3;
	Thu, 13 Feb 2025 13:25:07 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C123F417
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453106; cv=none; b=S4WWVNZI9QpQCKdF5MhVWGOIKUcaDW1mjIdNHGg2y49h0jtzMlZTQp5GGaCYSIF0k99lxBjP/u9tZ838pLSw190SuNY4KpvMjn4KCBL4BgqtQFQpNxL1SNfhVi40S/fKgg4E2CDnDy4PaHPrRv5+7bEfx4x600h9T5Q4SiRzMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453106; c=relaxed/simple;
	bh=VgLqqVKXQiXo+c8ENeKOas8C1X3pIu161SkMZ6+frpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUXK7TH/+xV/DaCGX6x/mS0RYu5AVXxYyCK7NrC7eBGXpUyIexTRjzhlF0Ik3ml2FaBQ0NL/EDHLuhIGt8/VTOW0Gl4lC4XqZ81dC8r7iEfp5IPWWSF9rcm2hrVzKHPMa6FfIo0L/QVf1nzs6xGvaVl0jRQXnHPZPBxYFPQcSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2B364439E;
	Thu, 13 Feb 2025 13:25:01 +0000 (UTC)
Message-ID: <21618bbd-b6cb-4c6e-9cdd-ca78236bc907@ghiti.fr>
Date: Thu, 13 Feb 2025 14:25:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] riscv: Fix set up of cpu hotplug callbacks
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 jesse@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20250207161939.46139-11-ajones@ventanamicro.com>
 <20250207161939.46139-16-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250207161939.46139-16-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjvghsshgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr


On 07/02/2025 17:19, Andrew Jones wrote:
> CPU hotplug callbacks should be set up even if we detected all
> current cpus emulate misaligned accesses, since we want to
> ensure our expectations of all cpus emulating is maintained.
>
> Fixes: 6e5ce7f2eae3 ("riscv: Decouple emulated unaligned accesses from access speed")
> Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/unaligned_access_speed.c | 27 +++++++++++-----------
>   1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 780f1c5f512a..c9d3237649bb 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -247,13 +247,6 @@ static void __init check_unaligned_access_speed_all_cpus(void)
>   	/* Check core 0. */
>   	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
>   
> -	/*
> -	 * Setup hotplug callbacks for any new CPUs that come online or go
> -	 * offline.
> -	 */
> -	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> -				  riscv_online_cpu, riscv_offline_cpu);
> -
>   out:
>   	for_each_cpu(cpu, cpu_online_mask) {
>   		if (bufs[cpu])
> @@ -383,13 +376,6 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
>   {
>   	schedule_on_each_cpu(check_vector_unaligned_access);
>   
> -	/*
> -	 * Setup hotplug callbacks for any new CPUs that come online or go
> -	 * offline.
> -	 */
> -	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> -				  riscv_online_cpu_vec, NULL);
> -
>   	return 0;
>   }
>   #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> @@ -415,6 +401,19 @@ static int __init check_unaligned_access_all_cpus(void)
>   			    NULL, "vec_check_unaligned_access_speed_all_cpus");
>   	}
>   
> +	/*
> +	 * Setup hotplug callbacks for any new CPUs that come online or go
> +	 * offline.
> +	 */
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +				  riscv_online_cpu, riscv_offline_cpu);
> +#endif
> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +				  riscv_online_cpu_vec, NULL);
> +#endif
> +
>   	return 0;
>   }
>   

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


