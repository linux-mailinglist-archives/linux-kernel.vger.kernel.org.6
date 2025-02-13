Return-Path: <linux-kernel+bounces-513005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D2A3406E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0107188AAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A122157F;
	Thu, 13 Feb 2025 13:33:51 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301441F462A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453630; cv=none; b=PgK7WF0hxQPsEVbjHjK6mkLqKh7hfTAqlzHD1K+d3QsgEH7MrEnuifmk6PinHd1J3YpxRkGH1HeauksZhB7q+DHRd2EYOh1v5hv85HH8WteWmJC5e6/jk2lV99FGYiES90dVBLIcqB3UwG3f3mGuktQ5ok3lT0hJhY8sh+2Hyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453630; c=relaxed/simple;
	bh=YC6cKhK8/vxAtvKU5r9p+OZLPX/oiBq0/rpae/Z0z6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pULo/OYmjvNfNgRxh8hOrQON+7Xstez6a0RUmMvxLDLs57H1N/K899ohPLs7J+hvpHzZT6IrKDdscHPFb4/Tz2YDpkjKIkGeVF5Nm0a6zQ4yjH+IqdL7B6ogTsohuduYPB0ga27oPdvcPQFha+qyPv7z80Tc90x7Ne0JN32G/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1957D204AC;
	Thu, 13 Feb 2025 13:33:44 +0000 (UTC)
Message-ID: <c6fdb439-fc85-400a-a278-3858bd3fd90d@ghiti.fr>
Date: Thu, 13 Feb 2025 14:33:44 +0100
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
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

This patch 5 does not apply without patch 4 that is not a fix which, in 
theory, should not be sent into the next -rcX...I'd say it is not a 
problem as patch 4 is small enough.

Just to say that maybe you'll be requested to rearrange the patchset!

Thanks,

Alex


