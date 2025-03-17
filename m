Return-Path: <linux-kernel+bounces-564382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB19A653EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F816D708
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7CA248166;
	Mon, 17 Mar 2025 14:39:09 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B052441A0;
	Mon, 17 Mar 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222348; cv=none; b=bH3GGRdkTf3eY4spdXQGYXAigLos0T4PjLCIIozXWDik0SvQhpnon4Kb8a7j0sypakGqEwJ1Vv4BXoBhIjkJRjw0cgFZ6C5YnvAVS+sYrSNaYJeEC33N2iARjyT+GVsNswEPvVgy5y29EUYQ8gdk5RvhM9Nd/wsUbJs5g6d17RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222348; c=relaxed/simple;
	bh=5sctOWQdDZU6goyyowPsbITQ4Qx7EMOcJkexjRoQrMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/AaY87u4wO2EhgynHToccaD5BZZv0EUZYeUnNKtinp1zlLddT2U3C7Dnz9o3OIPDl+GPzgHonyWLpWziGCDJJ497oU8seCP5e8yW0VMqDBvaShm7Bu9ogAC5rBD6YBkIH64MIZ2r3DEZf1+grrTdgKmVAfWCVhD+uvS2/xIgjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 624FC44382;
	Mon, 17 Mar 2025 14:39:02 +0000 (UTC)
Message-ID: <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
Date: Mon, 17 Mar 2025 15:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, charlie@rivosinc.com,
 cleger@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, corbet@lwn.net
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250304120014.143628-17-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeljeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpr
 ghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Drew,

On 04/03/2025 13:00, Andrew Jones wrote:
> Allow skipping scalar and vector unaligned access speed tests. This
> is useful for testing alternative code paths and to skip the tests in
> environments where they run too slowly. All CPUs must have the same
> unaligned access speed.

I'm not a big fan of the command line parameter, this is not where we 
should push uarch decisions because there could be many other in the 
future, the best solution to me should be in DT/ACPI and since the DT 
folks, according to Palmer, shut down this solution, it remains using an 
extension.

I have been reading a bit about unaligned accesses. Zicclsm was 
described as "Even though mandated, misaligned loads and stores might 
execute extremely slowly. Standard software distributions should assume 
their existence only for correctness, not for performance." in rva20/22 
but *not* in rva23. So what about using this "hole" and consider that a 
platform that *advertises* Zicclsm means its unaligned accesses are 
fast? After internal discussion, It actually does not make sense to 
advertise Zicclsm if the platform accesses are slow right?

arm64 for example considers that armv8 has fast unaligned accesses and 
can then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though 
some uarchs are slow. Distros will very likely use rva23 as baseline so 
they will enable Zicclsm which would allow us to take advantage of this 
too, without this, we lose a lot of perf improvement in the kernel, see 
https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.

Or we could have a new named feature for this, even though it's weird to 
have a named feature which would basically  mean "Zicclsm is fast". We 
don't have, for example, a named feature to say "Zicboz is fast" but 
given the vague wording in the profile spec, maybe we can ask for one in 
that case?

Sorry for the late review and for triggering this debate...

Thanks,

Alex


>
> The code movement is because we now need the scalar cpu hotplug
> callback to always run, so we need to bring it and its supporting
> functions out of CONFIG_RISCV_PROBE_UNALIGNED_ACCESS.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/unaligned_access_speed.c | 187 +++++++++++++--------
>   1 file changed, 121 insertions(+), 66 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index d9d4ca1fadc7..18e334549544 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -24,8 +24,12 @@
>   DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
>   DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
>   
> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +static long unaligned_scalar_speed_param = RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
> +static long unaligned_vector_speed_param = RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN;
> +
>   static cpumask_t fast_misaligned_access;
> +
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>   static int check_unaligned_access(void *param)
>   {
>   	int cpu = smp_processor_id();
> @@ -130,6 +134,50 @@ static void __init check_unaligned_access_nonboot_cpu(void *param)
>   		check_unaligned_access(pages[cpu]);
>   }
>   
> +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> +static void __init check_unaligned_access_speed_all_cpus(void)
> +{
> +	unsigned int cpu;
> +	unsigned int cpu_count = num_possible_cpus();
> +	struct page **bufs = kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);
> +
> +	if (!bufs) {
> +		pr_warn("Allocation failure, not measuring misaligned performance\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Allocate separate buffers for each CPU so there's no fighting over
> +	 * cache lines.
> +	 */
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +		if (!bufs[cpu]) {
> +			pr_warn("Allocation failure, not measuring misaligned performance\n");
> +			goto out;
> +		}
> +	}
> +
> +	/* Check everybody except 0, who stays behind to tend jiffies. */
> +	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> +
> +	/* Check core 0. */
> +	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> +
> +out:
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		if (bufs[cpu])
> +			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> +	}
> +
> +	kfree(bufs);
> +}
> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> +static void __init check_unaligned_access_speed_all_cpus(void)
> +{
> +}
> +#endif
> +
>   DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>   
>   static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
> @@ -188,21 +236,29 @@ arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
>   
>   static int riscv_online_cpu(unsigned int cpu)
>   {
> -	static struct page *buf;
> -
>   	/* We are already set since the last check */
> -	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN)
> +	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN) {
> +		goto exit;
> +	} else if (unaligned_scalar_speed_param != RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN) {
> +		per_cpu(misaligned_access_speed, cpu) = unaligned_scalar_speed_param;
>   		goto exit;
> -
> -	check_unaligned_access_emulated(NULL);
> -	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -	if (!buf) {
> -		pr_warn("Allocation failure, not measuring misaligned performance\n");
> -		return -ENOMEM;
>   	}
>   
> -	check_unaligned_access(buf);
> -	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +	{
> +		static struct page *buf;
> +
> +		check_unaligned_access_emulated(NULL);
> +		buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +		if (!buf) {
> +			pr_warn("Allocation failure, not measuring misaligned performance\n");
> +			return -ENOMEM;
> +		}
> +
> +		check_unaligned_access(buf);
> +		__free_pages(buf, MISALIGNED_BUFFER_ORDER);
> +	}
> +#endif
>   
>   exit:
>   	set_unaligned_access_static_branches();
> @@ -217,50 +273,6 @@ static int riscv_offline_cpu(unsigned int cpu)
>   	return 0;
>   }
>   
> -/* Measure unaligned access speed on all CPUs present at boot in parallel. */
> -static void __init check_unaligned_access_speed_all_cpus(void)
> -{
> -	unsigned int cpu;
> -	unsigned int cpu_count = num_possible_cpus();
> -	struct page **bufs = kcalloc(cpu_count, sizeof(*bufs), GFP_KERNEL);
> -
> -	if (!bufs) {
> -		pr_warn("Allocation failure, not measuring misaligned performance\n");
> -		return;
> -	}
> -
> -	/*
> -	 * Allocate separate buffers for each CPU so there's no fighting over
> -	 * cache lines.
> -	 */
> -	for_each_cpu(cpu, cpu_online_mask) {
> -		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -		if (!bufs[cpu]) {
> -			pr_warn("Allocation failure, not measuring misaligned performance\n");
> -			goto out;
> -		}
> -	}
> -
> -	/* Check everybody except 0, who stays behind to tend jiffies. */
> -	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> -
> -	/* Check core 0. */
> -	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> -
> -out:
> -	for_each_cpu(cpu, cpu_online_mask) {
> -		if (bufs[cpu])
> -			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> -	}
> -
> -	kfree(bufs);
> -}
> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> -static void __init check_unaligned_access_speed_all_cpus(void)
> -{
> -}
> -#endif
> -
>   #ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>   static void check_vector_unaligned_access(struct work_struct *work __always_unused)
>   {
> @@ -372,8 +384,8 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
>   
>   static int riscv_online_cpu_vec(unsigned int cpu)
>   {
> -	if (!has_vector()) {
> -		per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> +	if (unaligned_vector_speed_param != RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN) {
> +		per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
>   		return 0;
>   	}
>   
> @@ -388,30 +400,73 @@ static int riscv_online_cpu_vec(unsigned int cpu)
>   	return 0;
>   }
>   
> +static const char * const speed_str[] __initconst = { NULL, NULL, "slow", "fast", "unsupported" };
> +
> +static int __init set_unaligned_scalar_speed_param(char *str)
> +{
> +	if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW]))
> +		unaligned_scalar_speed_param = RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
> +	else if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_SCALAR_FAST]))
> +		unaligned_scalar_speed_param = RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
> +	else if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED]))
> +		unaligned_scalar_speed_param = RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED;
> +	else
> +		return -EINVAL;
> +
> +	return 1;
> +}
> +__setup("unaligned_scalar_speed=", set_unaligned_scalar_speed_param);
> +
> +static int __init set_unaligned_vector_speed_param(char *str)
> +{
> +	if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW]))
> +		unaligned_vector_speed_param = RISCV_HWPROBE_MISALIGNED_VECTOR_SLOW;
> +	else if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_VECTOR_FAST]))
> +		unaligned_vector_speed_param = RISCV_HWPROBE_MISALIGNED_VECTOR_FAST;
> +	else if (!strcmp(str, speed_str[RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED]))
> +		unaligned_vector_speed_param = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> +	else
> +		return -EINVAL;
> +
> +	return 1;
> +}
> +__setup("unaligned_vector_speed=", set_unaligned_vector_speed_param);
> +
>   static int __init check_unaligned_access_all_cpus(void)
>   {
>   	int cpu;
>   
> -	if (!check_unaligned_access_emulated_all_cpus())
> +	if (unaligned_scalar_speed_param == RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN &&
> +	    !check_unaligned_access_emulated_all_cpus()) {
>   		check_unaligned_access_speed_all_cpus();
> -
> -	if (!has_vector()) {
> +	} else {
> +		pr_info("scalar unaligned access speed set to '%s' by command line\n",
> +			speed_str[unaligned_scalar_speed_param]);
>   		for_each_online_cpu(cpu)
> -			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> -	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
> -		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
> +			per_cpu(misaligned_access_speed, cpu) = unaligned_scalar_speed_param;
> +	}
> +
> +	if (!has_vector())
> +		unaligned_vector_speed_param = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
> +
> +	if (unaligned_vector_speed_param == RISCV_HWPROBE_MISALIGNED_VECTOR_UNKNOWN &&
> +	    !check_vector_unaligned_access_emulated_all_cpus() &&
> +	    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
>   		kthread_run(vec_check_unaligned_access_speed_all_cpus,
>   			    NULL, "vec_check_unaligned_access_speed_all_cpus");
> +	} else {
> +		pr_info("vector unaligned access speed set to '%s' by command line\n",
> +			speed_str[unaligned_vector_speed_param]);
> +		for_each_online_cpu(cpu)
> +			per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
>   	}
>   
>   	/*
>   	 * Setup hotplug callbacks for any new CPUs that come online or go
>   	 * offline.
>   	 */
> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>   	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>   				  riscv_online_cpu, riscv_offline_cpu);
> -#endif
>   	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>   				  riscv_online_cpu_vec, NULL);
>   

