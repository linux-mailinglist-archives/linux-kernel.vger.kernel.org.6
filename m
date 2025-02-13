Return-Path: <linux-kernel+bounces-512979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B3A34004
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09171888E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC320ADE0;
	Thu, 13 Feb 2025 13:15:29 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A72AD25
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452529; cv=none; b=ONBUt2F+Jx1/S9+Pc5C0PSiGCFF/ewf4kabp99XZkv7vflH3CN8S+K8s7lm56yU5msmMdyZRjoRay3N0IO00678CaK/bULxZ6+Be+8Sb7cMfA/4Ohd2ikBb3dbrALNEkd01UTdiWULSAckDgipJqqNKh7h5WgXrAve83RBJBhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452529; c=relaxed/simple;
	bh=CqOuhjUXTbJZCjnZilgE0mEtfGYZNgJA3cO9HL8kJcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6P0Y6bq/aZbLIkBIN1vzZIHc7XfpAn7/2d6NbNnrTqkbl/fm3FzyXh3wLS/bexNIB6+s7fYRpqSK4B1mf/XdEgRGFL1aGHfNtYbuHTC4q2HHKmKLWUCDvk0OnjwKYeMMbTWLxTBdBrn9DjNgimrluxIezlBNApfnll7+k/YtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE84E442C8;
	Thu, 13 Feb 2025 13:15:23 +0000 (UTC)
Message-ID: <14898598-8411-4c2d-b983-07c8bb50159a@ghiti.fr>
Date: Thu, 13 Feb 2025 14:15:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] riscv: Change check_unaligned_access_speed_all_cpus
 to void
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 jesse@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20250207161939.46139-11-ajones@ventanamicro.com>
 <20250207161939.46139-15-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250207161939.46139-15-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjvghsshgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr


On 07/02/2025 17:19, Andrew Jones wrote:
> The return value of check_unaligned_access_speed_all_cpus() is always
> zero, so make the function void so we don't need to concern ourselves
> with it. The change also allows us to tidy up
> check_unaligned_access_all_cpus() a bit.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/unaligned_access_speed.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 02b485dc4bc4..780f1c5f512a 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -218,7 +218,7 @@ static int riscv_offline_cpu(unsigned int cpu)
>   }
>   
>   /* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static int __init check_unaligned_access_speed_all_cpus(void)
> +static void __init check_unaligned_access_speed_all_cpus(void)
>   {
>   	unsigned int cpu;
>   	unsigned int cpu_count = num_possible_cpus();
> @@ -226,7 +226,7 @@ static int __init check_unaligned_access_speed_all_cpus(void)
>   
>   	if (!bufs) {
>   		pr_warn("Allocation failure, not measuring misaligned performance\n");
> -		return 0;
> +		return;
>   	}
>   
>   	/*
> @@ -261,12 +261,10 @@ static int __init check_unaligned_access_speed_all_cpus(void)
>   	}
>   
>   	kfree(bufs);
> -	return 0;
>   }
>   #else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int __init check_unaligned_access_speed_all_cpus(void)
> +static void __init check_unaligned_access_speed_all_cpus(void)
>   {
> -	return 0;
>   }
>   #endif
>   
> @@ -403,10 +401,10 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
>   
>   static int __init check_unaligned_access_all_cpus(void)
>   {
> -	bool all_cpus_emulated;
>   	int cpu;
>   
> -	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
> +	if (!check_unaligned_access_emulated_all_cpus())
> +		check_unaligned_access_speed_all_cpus();
>   
>   	if (!has_vector()) {
>   		for_each_online_cpu(cpu)
> @@ -417,9 +415,6 @@ static int __init check_unaligned_access_all_cpus(void)
>   			    NULL, "vec_check_unaligned_access_speed_all_cpus");
>   	}
>   
> -	if (!all_cpus_emulated)
> -		return check_unaligned_access_speed_all_cpus();
> -
>   	return 0;
>   }
>   

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


