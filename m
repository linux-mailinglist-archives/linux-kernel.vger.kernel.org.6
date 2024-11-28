Return-Path: <linux-kernel+bounces-424920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F89DBB43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4292C28418E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D271BD9DB;
	Thu, 28 Nov 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4zTx64o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D32744E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732811185; cv=none; b=hWPv9fukbkSv6IyG9q5xIsgo7kMpuZVhpHssEZ+k29QJhauWqO4ugNDlLkRYIvqg3mfnSZwwvIAvQxGFRWblr1bVfN+R1XEIR/q9wnYcYMMKo/x9JWtNDsHV8NOl3OmiSC7Bn51uIsxOaQ5daS93LiDF8ilMwcXmaerdkNosT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732811185; c=relaxed/simple;
	bh=YWuLHOQnHddATEwi4qhCNtm9Q5H6JmzVotpeUJcfm8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa9anQT5oKulxjlJjc+4hUvyJgcVIPY4KPaCWc6E5fUQ5/Bfv80BVZ7bv+whduYDX8Lkg3wTGsnQ1F06jDfkQHNfQ25CwPQhsqjACvmsJaUOAh5XCT3WSmhlc+UEan4jRNULJ+ZaNyNuhkI3tpZK2ATgGMmJ7OGTMULPBLI9tmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4zTx64o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF4C4CECE;
	Thu, 28 Nov 2024 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732811184;
	bh=YWuLHOQnHddATEwi4qhCNtm9Q5H6JmzVotpeUJcfm8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4zTx64ondRlA/dVEhHjRrnKx3sw7SgbEpm7i74hAOYP7O9z70YWDHfiZtRoIOOMI
	 /yNQK1sQCwvJWps/awTfNKgHUVQj/gplhQkJoEaIEsSXqGmpe6JsgTwmAeJKOSL71d
	 5kyXwkRiKb55A5QQUJCEe5bvy/X6taFHFYfGX5WJiRQGsdkYYIzwk3G38RIiuZ8K0L
	 MFO3alyX8Fabtz9KGytlidE6uJOK+aqpVyYZ9f4brOxMaZKGegjF47cS/xg6KEPHNE
	 yIhcU78yjyq6oqvm2OiSaV606lVvhja6T6bGYxyxAk6Wima7aOxkyYp3mHgPxMprjl
	 41yBHJNutDTkA==
Date: Thu, 28 Nov 2024 16:26:19 +0000
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/21] arm64: Keep first mismatched 32bits el0 capable
 CPU online through its callbacks
Message-ID: <20241128162618.GA3653@willie-the-truck>
References: <20241112142248.20503-1-frederic@kernel.org>
 <20241112142248.20503-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112142248.20503-12-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Frederic,

On Tue, Nov 12, 2024 at 03:22:35PM +0100, Frederic Weisbecker wrote:
> The first mismatched 32bits el0 capable CPU is designated as the last
> resort CPU for compat 32 bits tasks. As such this CPU is forbidden to
> go offline.
> 
> However this restriction is applied to the device object of the CPU,
> which is not easy to revert later if needed because other components may
> have forbidden the target to be offline and they are not tracked.
> 
> But the task cpu possible mask is going to be made aware of housekeeping
> CPUs. In that context, a better 32 bits el0 last resort CPU may be found
> later on boot. When that happens, the old fallback can be made
> offlineable again.
> 
> To make this possible and more flexible, drive the offlineable decision
> from the cpuhotplug callbacks themselves.

Sadly, I don't think this can work.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 718728a85430..53ee8ce38d5b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3591,15 +3591,15 @@ void __init setup_user_features(void)
>  	minsigstksz_setup();
>  }
>  
> -static int enable_mismatched_32bit_el0(unsigned int cpu)
> -{
> -	/*
> -	 * The first 32-bit-capable CPU we detected and so can no longer
> -	 * be offlined by userspace. -1 indicates we haven't yet onlined
> -	 * a 32-bit-capable CPU.
> -	 */
> -	static int lucky_winner = -1;
> +/*
> + * The first 32-bit-capable CPU we detected and so can no longer
> + * be offlined by userspace. -1 indicates we haven't yet onlined
> + * a 32-bit-capable CPU.
> + */
> +static int cpu_32bit_unofflineable = -1;
>  
> +static int mismatched_32bit_el0_online(unsigned int cpu)
> +{
>  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
>  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
>  
> @@ -3611,7 +3611,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
>  	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
>  		return 0;
>  
> -	if (lucky_winner >= 0)
> +	if (cpu_32bit_unofflineable < 0)

nit: I think you meant '>=' here, but it doesn't matter. See below..

> +static int mismatched_32bit_el0_offline(unsigned int cpu)
> +{
> +	return cpu == cpu_32bit_unofflineable ? -EBUSY : 0;
> +}

I think this is far too late. The reason we prevent hot-unplug of the
last 32-bit CPU is because 32-bit tasks need somewhere to run. By the
time our offline notifier runs, those tasks have already been migrated.

On my setup, this explodes because that migration fails (as expected):


[  125.954586] ------------[ cut here ]------------
[  125.955661] kernel BUG at kernel/sched/core.c:3501!
[  125.957585] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[  125.959371] Modules linked in:
[  125.961850] CPU: 2 UID: 0 PID: 27 Comm: migration/2 Not tainted 6.12.0-00001-ge7689036c862-dirty #10
[  125.963711] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[  125.964859] Stopper: __balance_push_cpu_stop+0x0/0x134 <- balance_push+0x118/0x1ac
[  125.968507] pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  125.969648] pc : select_fallback_rq+0x2f4/0x2f8
[  125.970477] lr : select_fallback_rq+0x198/0x2f8
[  125.971273] sp : ffff800080153d20
[  125.971897] x29: ffff800080153d30 x28: 0000000000000002 x27: ffffddbd31d79d30
[  125.973416] x26: 0000000000000001 x25: ffffddbd31d79c70 x24: 0000000000000008
[  125.974436] x23: ffffddbd31d79000 x22: ffffddbd31a77190 x21: 0000000000000004
[  125.975452] x20: ffff0000c506a280 x19: 0000000000000000 x18: ffffddbd30fb1df0
[  125.976467] x17: 0000000000000000 x16: 0000000000000001 x15: 000000000018132d
[  125.977490] x14: 00000000ffffffe0 x13: 0000040000000000 x12: 00000c0000000000
[  125.978499] x11: 000000002ae00002 x10: 000000000000000c x9 : 0000000000000040
[  125.979507] x8 : 0000000000000000 x7 : 000000000000000c x6 : 000000000000000c
[  125.980501] x5 : ffff0000c506a578 x4 : ffffddbd2fe53eb0 x3 : 0000000000000010
[  125.981508] x2 : 0000000000000004 x1 : 0000000000000004 x0 : 0000000000000004
[  125.982671] Call trace:
[  125.983065]  select_fallback_rq+0x2f4/0x2f8
[  125.983550]  __balance_push_cpu_stop+0x94/0x134
[  125.983983]  cpu_stopper_thread+0xbc/0x174
[  125.984352]  smpboot_thread_fn+0x1e4/0x24c
[  125.984732]  kthread+0xfc/0x184
[  125.985065]  ret_from_fork+0x10/0x20
[  125.985741] Code: 9000d9c0 91306000 9441667a 17ffffef (d4210000) 
[  125.986445] ---[ end trace 0000000000000000 ]---


As I mentioned before, I think we need to turn this the other way around
so that the non-unpluggable 32-bit core is forced to be a housekeeping]
CPU. You said it was hard to revert CPUs from being treated as nohz_full,
but I'm wondering whether we can prevent it from being added in the first
place. The arch code has fingers in all the early boot pies.

Yet another option (which I'm not hugely fond of, but may be ok) would
be to treat 32-bit-capable nohz_full CPUs as being 64-bit-only when
'allow_mismatched_32bit_el0' is enabled (and documenting this as a
limitation).

Will

