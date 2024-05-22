Return-Path: <linux-kernel+bounces-186769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283748CC8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9617E1F22763
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C8146A7E;
	Wed, 22 May 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2iztdgy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLvsKOZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D575812B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415972; cv=none; b=moHv8JPNKp+d9MzMdTT2hgK+gVLlyVi0RIHzRM2KNVTlR3N6VxC84DgXENK2k3jgdQ437ZvURsIdwC+vd0xzbxor904FBZ83tF6NVJnLRMi11uUJ/oUMteIRzzFaYP/22SHDRG9+hWFKsIS32BH64T0EVY6WWrOXy6iqbVurhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415972; c=relaxed/simple;
	bh=noX44XBYEvX4GMdI/hKOMAQfeMnaIys1OJvIUNWhBMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYM0kXaTSRpVsOPacy52DFRjtjPZjZUQTlKuUC6zK+oouz96/R2vqMm9x5MCnrR6TYHwLMgre/tVAdTbmUvSB1QAv+jaUqTqCK6O0kuuqkMGFRtESEZ9rG78wzrNz6qIrwc1rT1vIurDUZEomkvhHX4qOJe1j3QDW3g3ctWdqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2iztdgy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLvsKOZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716415968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+uYNjBSstA2FYxrH4vlDNEEByHlM5YkexbOQbr0VrM=;
	b=L2iztdgymNVBacdWXs+KN/RKo5Ox8oRtGXlFoQomH9bYFElFfI90PgLlmMO2APar/h7Sqe
	LkC5S4efnd3uY2h/P3S+arxi+WwJgUG4yPeSXvrOhOl5UMOa0WrAcRQk12bu8sjZrKGeVC
	gtsz3LmavebMPU7zUhwfs7i9+ZnNfsbSiYi1u/ezX3Y9Qhb5ScXignZyh0cbrtxQ4FBNM8
	e/sfHHk+chEvN/cb69aIAIa7w8JqnaQuWPJck3FuA9X4ZgvCXAbDO7/VOiMk5r1JOreK9Z
	PF37OM3/C76ilqOLxVkzg8jPAmU9/jb0vF4uKUkpgC3lkAWJAw2wA4uZDGnvAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716415968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+uYNjBSstA2FYxrH4vlDNEEByHlM5YkexbOQbr0VrM=;
	b=sLvsKOZJIaUn24FOn9G+EFsk/CRt0EIKNzJUbcmtYAPCfFsclmKmW1ORhA1M5u29/j2V20
	9wHF0dqvG0Y56uBw==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
 <87jzjxn6s5.ffs@tglx>
 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
 <87bk58n6le.ffs@tglx>
 <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
 <87wmntkhak.ffs@tglx>
 <d4496b4ed8a8a7bb34cf12e4cce65a6ad6705bc0.camel@redhat.com>
Date: Thu, 23 May 2024 00:12:47 +0200
Message-ID: <874japh4ww.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Wed, May 22 2024 at 15:35, Lyude Paul wrote:

Thank for testing!

> Awesome! This patch does seem to make the system boot, thank you for
> your help

The only thing what's awesome here is that it confirms my analysis of
the underlying problem. I offered Borislav a bet on that, but he
politely declined :(

The not so awesome part is the question what to do with that insight.

The first issue is that we don't know whether that's only a problem on
your particular system or if there is an underlying systematic problem
on that particular CPU variant (model/stepping).

Unless the AMD folks can give an authoritative answer we have three options:

  1) Targeted via quirk

     As you are so far the only one complaining about this, it might be
     sufficient to enforce the physical flat mode for your particular
     machine via a DMI quirk or on the actual CPU model/stepping.

  2) Tie it to interrupt remapping

     That's the patch I provided you for testing

  3) Remove the default logical destination mode on 64bit completely

     My favourite

#1 is stupid IMO because it's likely that other systems are affected by
   this nonsense and I don't want to end up adding quirks over and over

#2 is silly because it effectively enforces physical destination mode on
   any system which has interrupt remapping available in hardware.

   That's pretty much everything halfways modern.

#3 makes a lot of sense because:

   - it reduces the amount of code

     Given the trend of the last decade this actually removes code which
     will be used less frequently as the number of logical CPUs keeps
     increasing.

   - the only benefit of logical destination mode over physical
     destination mode is the ability to send IPIs to multiple CPUs in
     one operation.

     The question is whether this still matters.

     IMO it does not matter because anything which is IPI sensitive is
     running on machines which have more than 8 CPUs today. The time
     where 8 CPU (threads) workstations and servers were state of the
     art are long gone.

   - physical destination mode is guaranteed to work because it's the
     only way to get a CPU up and running via the INIT/INIT/STARTUP
     sequence, while obvioulsy logical destination mode has its issues
     not only on the system at hand (see physflat_acpi_madt_oem_check()).

   Patch for this below.

Thanks,

        tglx
---
 arch/x86/kernel/apic/apic_flat_64.c |  116 ------------------------------------
 1 file changed, 3 insertions(+), 113 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -18,126 +18,19 @@
 #include "local.h"
 
 static struct apic apic_physflat;
-static struct apic apic_flat;
 
-struct apic *apic __ro_after_init = &apic_flat;
+struct apic *apic __ro_after_init = &apic_phys_flat;
 EXPORT_SYMBOL_GPL(apic);
 
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 1;
-}
-
-static void _flat_send_IPI_mask(unsigned long mask, int vector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
-	local_irq_restore(flags);
-}
-
-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static void
-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-	int cpu = smp_processor_id();
-
-	if (cpu < BITS_PER_LONG)
-		__clear_bit(cpu, &mask);
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static u32 flat_get_apic_id(u32 x)
-{
-	return (x >> 24) & 0xFF;
-}
-
-static int flat_probe(void)
-{
-	return 1;
-}
-
-static struct apic apic_flat __ro_after_init = {
-	.name				= "flat",
-	.probe				= flat_probe,
-	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-
-	.dest_mode_logical		= true,
-
-	.disable_esr			= 0,
-
-	.init_apic_ldr			= default_init_apic_ldr,
-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-
-	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
-
-	.calc_dest_apicid		= apic_flat_calc_apicid,
-
-	.send_IPI			= default_send_IPI_single,
-	.send_IPI_mask			= flat_send_IPI_mask,
-	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= default_send_IPI_allbutself,
-	.send_IPI_all			= default_send_IPI_all,
-	.send_IPI_self			= default_send_IPI_self,
-	.nmi_to_offline_cpu		= true,
-
-	.read				= native_apic_mem_read,
-	.write				= native_apic_mem_write,
-	.eoi				= native_apic_mem_eoi,
-	.icr_read			= native_apic_icr_read,
-	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
-};
-
-/*
- * Physflat mode is used when there are more than 8 CPUs on a system.
- * We cannot use logical delivery in this case because the mask
- * overflows, so use physical mode.
- */
-static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-#ifdef CONFIG_ACPI
-	/*
-	 * Quirk: some x86_64 machines can only use physical APIC mode
-	 * regardless of how many processors are present (x86_64 ES7000
-	 * is an example).
-	 */
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
-		printk(KERN_DEBUG "system APIC only can use physical flat");
-		return 1;
-	}
-
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
-		return 1;
-	}
-#endif
-
-	return 0;
-}
-
 static int physflat_probe(void)
 {
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return 1;
 }
 
 static struct apic apic_physflat __ro_after_init = {
 
 	.name				= "physical flat",
 	.probe				= physflat_probe,
-	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
 
 	.dest_mode_logical		= false,
 
@@ -167,7 +60,4 @@ static struct apic apic_physflat __ro_af
 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
 
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+apic_drivers(apic_physflat);

