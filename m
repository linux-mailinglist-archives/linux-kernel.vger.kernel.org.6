Return-Path: <linux-kernel+bounces-539706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA2A4A79E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5644916C9D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84D86333;
	Sat,  1 Mar 2025 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVu0COVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56835942
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793276; cv=none; b=jZ1kHqw3mmKp3emOxOVx3p2aelejyBCAsJjutMjN+/Vk6SNXuaBdTVv7fbk7A3VBY5mPdqh4/L1hzQElwSReUTSv1vLJxGbra4ip5VupOTqOpD7w9pCadSi4wzDR6fydAeAFUrhII5k9fDOuuq0+fy59cjW0HIXJfcCqdvT/gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793276; c=relaxed/simple;
	bh=lpj053KmanI8Q9mRWs9ZJ1Mmo3ixre3TPI0Mj4YQtWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9TldyX9j/wEA4jvlFQaNaAepOnn2oQvB8D5han24XpZwEcvtqlUaDy6yLFKIz4C9E9niE7hrOpk9L3fOylvYE4A03I0vhKVHFExglE0bwQlh+KytiEaj5u90N977r8DYCLq75hNBfgdau8XQL47zud9qF9EtTDKyL6i4mx3c8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVu0COVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC54C4CED6;
	Sat,  1 Mar 2025 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793276;
	bh=lpj053KmanI8Q9mRWs9ZJ1Mmo3ixre3TPI0Mj4YQtWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVu0COVgxzTorUmQyja23ckVxgH3Z17J37LTqxCBrFzie5GvrjatiIErtS627gbdK
	 9Z+QukOUkpqUaU08QrZ1CYDrTLEW92mup/QPYA2H2+AEFymL6kyQVXsLpD9DG5k9pg
	 dY3heIQaFBoGbkddvmU/uC6DrifGs+edX7tFJwigin7TLedRqTa/tfX9gk6RlhTPw6
	 23Xm/aHEfJc93EoRRAyckVBlbl4TgClQL34Poiao2yb+KM56ftaSzD9jaHOkbzS5Vl
	 uJAa34FFyC8IRyjMfnbE7iUdAvkv0oUWm/ZL20Jjo3XR0CeCdN1+eeUV2E0UOyu8uS
	 4kQxX4r+acvAA==
Date: Fri, 28 Feb 2025 17:41:14 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: patryk.wlazlyn@linux.intel.com, artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com, gautham.shenoy@amd.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, peterz@infradead.org
Subject: Re: [BUG objtool,x86] Missing __noreturn annotation in
 acpi_processor_ffh_play_dead()
Message-ID: <20250301014114.fasws3rh5ubxobbe@jpoimboe>
References: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>
 <20250228191213.7drb265s7jrrjf7b@jpoimboe>
 <35dfcb6b-ccdf-4ac2-a44b-94edd72ed302@paulmck-laptop>
 <20250228220039.tjimagjqkswzooi4@jpoimboe>
 <25592ab5-5d8a-46ed-86a2-a0c58eed9f60@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25592ab5-5d8a-46ed-86a2-a0c58eed9f60@paulmck-laptop>

On Fri, Feb 28, 2025 at 04:33:23PM -0800, Paul E. McKenney wrote:
> Aha!  The tools/objtool/noreturns.h is either new to me or was forgotten
> by me.  ;-)
> 
> This does indeed handle the objtool warnings for CONFIG_SMP=y builds,
> so thank you!
> 
> But for CONFIG_SMP=n builds, I get the following:
> 
> arch/x86/kernel/acpi/cstate.c: In function ‘acpi_processor_ffh_play_dead’:
> arch/x86/kernel/acpi/cstate.c:216:1: error: ‘noreturn’ function does return [-Werror
> 
> And in this build configuration, it does look like mwait_play_dead is an
> empty static inline function.  I could imagine making that __noreturn be
> a CPP macro, but I could also imagine making mwait_play_dead() refrain
> from returning.

"play_dead" is an SMP thing and should never be called on non-SMP.  And
it's a very good idea for noreturn behavior to be consistent across
configs anyway.

So yeah, I think it's as simple:

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 80f8bfd83fc7..32990e7396e0 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -166,7 +166,7 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return (struct cpumask *)cpumask_of(0);
 }
 
-static inline void mwait_play_dead(unsigned int eax_hint) { }
+static inline void __noreturn mwait_play_dead(unsigned int eax_hint) { BUG(); }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST

