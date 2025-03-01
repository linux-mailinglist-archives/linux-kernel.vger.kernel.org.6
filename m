Return-Path: <linux-kernel+bounces-539663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0DFA4A703
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701F6189D017
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489017580;
	Sat,  1 Mar 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP6usaP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022512B73
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789203; cv=none; b=Cru7qqrIWVSlnklhhhT6NJRYdU6DpnylSyqp5234CfZbDvGxLeXpGdQP9Sn0sPGateIcFEoZTHU9u+tX+bMRvWUqs8dsxu9niWFcfoJVgAc7Q5XS6QtPMilxVNR21KYDgH/eR3EIXwXuwHsnPTuIq+mvVge8w1uvtYTXrIOk4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789203; c=relaxed/simple;
	bh=zWKzoDryyg6Rn7A17K2agTJJZfVSssFh1IkiOhO/i/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv65CqUgrxUsSLLoBF10bEim1i3eOtxa48owxoc19O5tv+b+6J79XI81Xu553XDanOkENJodkox41sCaybZpLLVb558xpt8wjnG8IATnQMMLhcu2cQUAAX4M5ArYWREK95POQsbLJMPZvByZiTENOv7ELNJXn13YJkqc/+2TwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP6usaP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742B7C4CED6;
	Sat,  1 Mar 2025 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740789203;
	bh=zWKzoDryyg6Rn7A17K2agTJJZfVSssFh1IkiOhO/i/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uP6usaP8CuqzJGSax/Zzw5t0b/nUiDA/HSvW/iO7XCoxXZiUTB5+EOiYuTu7FkVWX
	 i4VeejKxS4Pe1nS5k8CXZlROBjDrDkeDierSm2DzDsb5mxX1j1FQDRmEZkIHpkOF17
	 nJtuvjs3KVl6Ula64hyrdeW1LvbhrXuyr/U2ct/uzMkj9biwH5dfKpJ/Y/GSgZemdf
	 NBExFTA7DouP3FTxO3wA8Z78RORCjS33ngshEP2kaBJdcSU/7OUdMkE6y22OJ4j3JW
	 lXDhen3ejzPuekukB6I4fBwXr/Fg++gaC0qPtum3D3IERvLGwelmlfHj6ozRBdpisr
	 JtYrflvQJj2xQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E017CE0DEB; Fri, 28 Feb 2025 16:33:23 -0800 (PST)
Date: Fri, 28 Feb 2025 16:33:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: patryk.wlazlyn@linux.intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [BUG objtool,x86] Missing __noreturn annotation in
 acpi_processor_ffh_play_dead()
Message-ID: <25592ab5-5d8a-46ed-86a2-a0c58eed9f60@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>
 <20250228191213.7drb265s7jrrjf7b@jpoimboe>
 <35dfcb6b-ccdf-4ac2-a44b-94edd72ed302@paulmck-laptop>
 <20250228220039.tjimagjqkswzooi4@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228220039.tjimagjqkswzooi4@jpoimboe>

On Fri, Feb 28, 2025 at 02:00:39PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 28, 2025 at 11:51:26AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 28, 2025 at 11:12:13AM -0800, Josh Poimboeuf wrote:
> > > On Fri, Feb 28, 2025 at 11:00:07AM -0800, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > My recent -next testing hits this objtool complaint:
> > > > 
> > > > vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation
> > > > 
> > > > My attempts to silence this by adding the suggested __noreturn annotations
> > > > didn't help, and often got me compiler warnings about __noreturn functions
> > > > actually returning.  So I bisected, which converges on this innocent-looking
> > > > commit:
> > > > 
> > > > a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
> > > > 
> > > > Several runs verified that this really is the commit that objtool is
> > > > complaining about.  Unfortunately, this commit does not revert cleanly.
> > > > 
> > > > This is from builds using clang version 19.1.5 (CentOS 19.1.5-2.el9).
> > > > 
> > > > Help?
> > > 
> > > I can take a look.  Is it LLVM defconfig?  Otherwise can you send the
> > > .config?
> > 
> > Thank you!  And rcutorture modifies whatever defconfig it gets. so please
> > see below for the full .config.
> 
> With your config I actually get a different warning:
> 
>         vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0x67: mwait_play_dead() is missing a __noreturn annotation
> 
> The below patch should fix both, can you confirm it fixes yours?
> 
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] x86/smp: Fix __noreturn annotations for mwait_play_dead() and
>  acpi_processor_ffh_play_dead()
> 
> mwait_play_dead() doesn't return, but only has a partial __noreturn
> annotation.
> 
> acpi_processor_ffh_play_dead() also doesn't return due to its
> unconditional calling of mwait_play_dead().
> 
> Fix the annotations for both functions.
> 
> This fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0x67: mwait_play_dead() is missing a __noreturn annotation
>   vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation
> 
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Fixes: a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
> Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Aha!  The tools/objtool/noreturns.h is either new to me or was forgotten
by me.  ;-)

This does indeed handle the objtool warnings for CONFIG_SMP=y builds,
so thank you!

But for CONFIG_SMP=n builds, I get the following:

arch/x86/kernel/acpi/cstate.c: In function ‘acpi_processor_ffh_play_dead’:
arch/x86/kernel/acpi/cstate.c:216:1: error: ‘noreturn’ function does return [-Werror

And in this build configuration, it does look like mwait_play_dead is an
empty static inline function.  I could imagine making that __noreturn be
a CPP macro, but I could also imagine making mwait_play_dead() refrain
from returning.

Thoughts?

							Thanx, Paul

> ---
>  arch/x86/include/asm/smp.h    | 2 +-
>  arch/x86/kernel/acpi/cstate.c | 2 +-
>  include/acpi/processor.h      | 2 +-
>  tools/objtool/noreturns.h     | 2 ++
>  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 80f8bfd83fc7..9c7ae0a214dc 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,7 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  
>  void smp_kick_mwait_play_dead(void);
> -void mwait_play_dead(unsigned int eax_hint);
> +void __noreturn mwait_play_dead(unsigned int eax_hint);
>  
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 86c87c01d23d..d25584255ab8 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -206,7 +206,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>  
> -void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct cstate_entry *percpu_entry;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 63a37e72b721..86b6b17b0f70 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,7 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>  				    struct acpi_processor_cx *cx,
>  				    struct acpi_power_register *reg);
>  void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> -void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
> +void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>  #else
>  static inline void acpi_processor_power_init_bm_check(struct
>  						      acpi_processor_flags
> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> index b2174894f9f7..5a4aec4c4639 100644
> --- a/tools/objtool/noreturns.h
> +++ b/tools/objtool/noreturns.h
> @@ -16,6 +16,7 @@ NORETURN(__tdx_hypercall_failed)
>  NORETURN(__ubsan_handle_builtin_unreachable)
>  NORETURN(__x64_sys_exit)
>  NORETURN(__x64_sys_exit_group)
> +NORETURN(acpi_processor_ffh_play_dead)
>  NORETURN(arch_cpu_idle_dead)
>  NORETURN(bch2_trans_in_restart_error)
>  NORETURN(bch2_trans_restart_error)
> @@ -34,6 +35,7 @@ NORETURN(kunit_try_catch_throw)
>  NORETURN(machine_real_restart)
>  NORETURN(make_task_dead)
>  NORETURN(mpt_halt_firmware)
> +NORETURN(mwait_play_dead)
>  NORETURN(nmi_panic_self_stop)
>  NORETURN(panic)
>  NORETURN(panic_smp_self_stop)
> -- 
> 2.48.1
> 

