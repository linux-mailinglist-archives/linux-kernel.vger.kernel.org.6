Return-Path: <linux-kernel+bounces-539922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F3A4AAE6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D49C18965A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EC1DED71;
	Sat,  1 Mar 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEAtrltJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A141DE885
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831497; cv=none; b=ZPdC0sADG5jSDb5/Rm+0RXzaZZFnKewkn8S6tB6s1ADq40RD+m7wYq5AjcosFJmtm4Q2cHdZgp9bn6zkoHu4gACbQnzBcletlOMi/hczZ9bUtO42RdJZoyeOKMoT6h3xpm3tFK623gqKEVSwkuU3RplW1tl90ks/Q53xJJFzaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831497; c=relaxed/simple;
	bh=A/i7DsTMFIdHWmooslwDLgV/zb/muFcx45/ikBPhx14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgfU0beVUfnAchbYwrpQ3tFv45qT3FOUcDBFUkvul6sjXtnm+3d5cC4pczSfff4LIAK3KAU/Ixlt8scp+JvLUkTnv2oNwePCfylM8veHwL8k6l3zQXL8QKKZWNNIe+2zpAUzshu4em6nthyduCk7/k3/M6gnCl/HV1MVRQmZDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEAtrltJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D516C4CEDD;
	Sat,  1 Mar 2025 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740831494;
	bh=A/i7DsTMFIdHWmooslwDLgV/zb/muFcx45/ikBPhx14=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vEAtrltJoyS4r3mjuvEnzjfUkEgSIrulOynY1xLh54gx9DDTWjzxySMqLF8YWB/Hs
	 ePW/pfOhWpHYB+ouiG4eDgmX7tu0lC4HGvG+sjc+XCTrX+UeXUzHLAmiKFZCE82aAM
	 zLkcXIszrmHISaC270sxNYTepLJYPxn5RdnIGB/QoSzKsxLzZn9fhMWfZSnIfG3toO
	 WC2OPwIV4vkz26saTWOOBxStVyCBVUSUx+fYFQ6/OFGXtD4jTvsmD9tQ0kSU9801MG
	 sDa3F9xyQfhfjAdvabps+iVePV4Ewk8dqv8ypFQlQGwD8tK4xBfetV1N465yYlFccl
	 /HZQ9O1/qJX5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1016CCE0DCA; Sat,  1 Mar 2025 04:18:14 -0800 (PST)
Date: Sat, 1 Mar 2025 04:18:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: patryk.wlazlyn@linux.intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [BUG objtool,x86] Missing __noreturn annotation in
 acpi_processor_ffh_play_dead()
Message-ID: <f039afdc-22e5-4f6a-9550-bd28dd0f8686@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>
 <20250228191213.7drb265s7jrrjf7b@jpoimboe>
 <35dfcb6b-ccdf-4ac2-a44b-94edd72ed302@paulmck-laptop>
 <20250228220039.tjimagjqkswzooi4@jpoimboe>
 <25592ab5-5d8a-46ed-86a2-a0c58eed9f60@paulmck-laptop>
 <20250301014114.fasws3rh5ubxobbe@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250301014114.fasws3rh5ubxobbe@jpoimboe>

On Fri, Feb 28, 2025 at 05:41:14PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 28, 2025 at 04:33:23PM -0800, Paul E. McKenney wrote:
> > Aha!  The tools/objtool/noreturns.h is either new to me or was forgotten
> > by me.  ;-)
> > 
> > This does indeed handle the objtool warnings for CONFIG_SMP=y builds,
> > so thank you!
> > 
> > But for CONFIG_SMP=n builds, I get the following:
> > 
> > arch/x86/kernel/acpi/cstate.c: In function ‘acpi_processor_ffh_play_dead’:
> > arch/x86/kernel/acpi/cstate.c:216:1: error: ‘noreturn’ function does return [-Werror
> > 
> > And in this build configuration, it does look like mwait_play_dead is an
> > empty static inline function.  I could imagine making that __noreturn be
> > a CPP macro, but I could also imagine making mwait_play_dead() refrain
> > from returning.
> 
> "play_dead" is an SMP thing and should never be called on non-SMP.  And
> it's a very good idea for noreturn behavior to be consistent across
> configs anyway.
> 
> So yeah, I think it's as simple:

And that passes my tests, thank you!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 80f8bfd83fc7..32990e7396e0 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -166,7 +166,7 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  	return (struct cpumask *)cpumask_of(0);
>  }
>  
> -static inline void mwait_play_dead(unsigned int eax_hint) { }
> +static inline void __noreturn mwait_play_dead(unsigned int eax_hint) { BUG(); }
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST

