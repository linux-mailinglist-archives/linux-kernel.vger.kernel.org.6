Return-Path: <linux-kernel+bounces-512947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F9A33FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766F5168C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F0221701;
	Thu, 13 Feb 2025 12:59:25 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA020B7FF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451565; cv=none; b=GmxMJ33XUf5kybgqf9jDkasg6PKaR1pXCHKt0FbQmskP6z7sitAJeG+79L002cxgwXAVQ/CnkKXK5aUYoUNaDhBT5TdH+iJx1ix73BM/DWMWhUEHtKZGzujFODzO8Sb/gmdUn6Z2J5r1vAQ+Keov+19qKLk1YvwCX0ev5z0Nn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451565; c=relaxed/simple;
	bh=f1apTZjgcyQcalHONvc37Jn+lOhyfQvkQCYOEI4TB9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC72JeYjctzY872ff88arrdBJQbR9HpKKlSKsVzuYx266ihA20rfQWpc9iA2NPM3lRS8pn4HKCYsJ9042dNsNJXEfIuZMFDUEVe9mpCt/4ekQVEi3mi2IxLEQULPEqLNkYSZouX4p6O9JETVBDV9luQqxe7M86L4yS5+sOeyiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 668FC44267;
	Thu, 13 Feb 2025 12:59:13 +0000 (UTC)
Message-ID: <fa88bc3a-7945-456c-8f12-3bb1a269fb36@ghiti.fr>
Date: Thu, 13 Feb 2025 13:59:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] riscv: Annotate unaligned access init functions
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 jesse@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20250207161939.46139-11-ajones@ventanamicro.com>
 <20250207161939.46139-12-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250207161939.46139-12-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudgutggvmegvhedugeemheegjegvmegstdhfkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjvghsshgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Drew,

On 07/02/2025 17:19, Andrew Jones wrote:
> Several functions used in unaligned access probing are only run at
> init time. Annotate them appropriately.
>
> Fixes: f413aae96cda ("riscv: Set unaligned access speed at compile time")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/cpufeature.h        |  4 ++--
>   arch/riscv/kernel/traps_misaligned.c       |  8 ++++----
>   arch/riscv/kernel/unaligned_access_speed.c | 14 +++++++-------
>   3 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 569140d6e639..19defdc2002d 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -63,7 +63,7 @@ void __init riscv_user_isa_enable(void);
>   #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
>   	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
>   
> -bool check_unaligned_access_emulated_all_cpus(void);
> +bool __init check_unaligned_access_emulated_all_cpus(void);
>   #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>   void check_unaligned_access_emulated(struct work_struct *work __always_unused);
>   void unaligned_emulation_finish(void);
> @@ -76,7 +76,7 @@ static inline bool unaligned_ctl_available(void)
>   }
>   #endif
>   
> -bool check_vector_unaligned_access_emulated_all_cpus(void);
> +bool __init check_vector_unaligned_access_emulated_all_cpus(void);
>   #if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
>   void check_vector_unaligned_access_emulated(struct work_struct *work __always_unused);
>   DECLARE_PER_CPU(long, vector_misaligned_access);
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 7cc108aed74e..aacbd9d7196e 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -605,7 +605,7 @@ void check_vector_unaligned_access_emulated(struct work_struct *work __always_un
>   	kernel_vector_end();
>   }
>   
> -bool check_vector_unaligned_access_emulated_all_cpus(void)
> +bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>   {
>   	int cpu;
>   
> @@ -625,7 +625,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>   	return true;
>   }
>   #else
> -bool check_vector_unaligned_access_emulated_all_cpus(void)
> +bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>   {
>   	return false;
>   }
> @@ -659,7 +659,7 @@ void check_unaligned_access_emulated(struct work_struct *work __always_unused)
>   	}
>   }
>   
> -bool check_unaligned_access_emulated_all_cpus(void)
> +bool __init check_unaligned_access_emulated_all_cpus(void)
>   {
>   	int cpu;
>   
> @@ -684,7 +684,7 @@ bool unaligned_ctl_available(void)
>   	return unaligned_ctl;
>   }
>   #else
> -bool check_unaligned_access_emulated_all_cpus(void)
> +bool __init check_unaligned_access_emulated_all_cpus(void)
>   {
>   	return false;
>   }
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index 91f189cf1611..b7a8ff7ba6df 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -121,7 +121,7 @@ static int check_unaligned_access(void *param)
>   	return 0;
>   }
>   
> -static void check_unaligned_access_nonboot_cpu(void *param)
> +static void __init check_unaligned_access_nonboot_cpu(void *param)
>   {
>   	unsigned int cpu = smp_processor_id();
>   	struct page **pages = param;
> @@ -175,7 +175,7 @@ static void set_unaligned_access_static_branches(void)
>   	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
>   }
>   
> -static int lock_and_set_unaligned_access_static_branch(void)
> +static int __init lock_and_set_unaligned_access_static_branch(void)
>   {
>   	cpus_read_lock();
>   	set_unaligned_access_static_branches();
> @@ -218,7 +218,7 @@ static int riscv_offline_cpu(unsigned int cpu)
>   }
>   
>   /* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static int check_unaligned_access_speed_all_cpus(void)
> +static int __init check_unaligned_access_speed_all_cpus(void)
>   {
>   	unsigned int cpu;
>   	unsigned int cpu_count = num_possible_cpus();
> @@ -264,7 +264,7 @@ static int check_unaligned_access_speed_all_cpus(void)
>   	return 0;
>   }
>   #else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static int check_unaligned_access_speed_all_cpus(void)
> +static int __init check_unaligned_access_speed_all_cpus(void)
>   {
>   	return 0;
>   }
> @@ -379,7 +379,7 @@ static int riscv_online_cpu_vec(unsigned int cpu)
>   }
>   
>   /* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> +static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>   {
>   	schedule_on_each_cpu(check_vector_unaligned_access);
>   
> @@ -393,13 +393,13 @@ static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unuse
>   	return 0;
>   }
>   #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
> -static int vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
> +static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
>   {
>   	return 0;
>   }
>   #endif
>   
> -static int check_unaligned_access_all_cpus(void)
> +static int __init check_unaligned_access_all_cpus(void)
>   {
>   	bool all_cpus_emulated, all_cpus_vec_unsupported;
>   


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


