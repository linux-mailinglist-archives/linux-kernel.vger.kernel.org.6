Return-Path: <linux-kernel+bounces-264540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE393E4B1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4513A1F217D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B34381AA;
	Sun, 28 Jul 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbpTDSzi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3Cid4rV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A42BB1B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722164781; cv=none; b=FIuqdIH32HoER0chCKPnRclxqrTuI+UXx6K22NUsdZ2g8U37RsMVodyLhPwUaz/i9w4Z6TvG6AucEVzH/KhsPI70qThxlJJIQJUBn2IwrX3Z4n/8fn6xLdIQRqBPFr0/Am7Gi3bD4ZnfKT0LeZ3EbJwB/1+hxPpzqR6TrdtEE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722164781; c=relaxed/simple;
	bh=Xr6XiYTFzMzfCcbZK1ASNVpY+f6Ud9KvpJpmVEdV23Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6wkJHrMFKfaxJAYPYJYDnuYb+cQZ4JDGPaDzovbeGTCpOHL8YqjP7W5c8bSUTqagvHItMReSG3gdUX551PWxIX7oLRDtBRjBfSBiLrKlh8QQE0FLHdUX9S8uhWLbnz8rw9Wu+VNDhYFLhodOyg6/tTJU18BxgAt0uTdVK8qm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbpTDSzi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3Cid4rV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722164770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o24sg/v1TKqSJnXSyzItof46Y31GceiaBZpiDHTPFTI=;
	b=kbpTDSzivNItwDlUPPlFF8xTO/Kbn17ER3JOZQ/GCAb+RpBq2U46pDx1A3b1+aL5/ZQqZJ
	mV4YGe6/2qxiCjDL5bEHee7zcEHCzCyGkIMV23R0uG4pltP9DioTejBZrDhGFBUPB6m2On
	QvqOOPjA6LWGRmOv11ARKYtD/Qcwxw/vyqGGfa7mKkafUGI7IdBD+6zaCyf7d1Eu70vxWY
	Ql9+Ym8Z/cvSvjOV8Mdowf24nvCTwMz1a3c0Y7o+yzc1qeyLGgAf9KFaV2/1OhT7A0O0x1
	254JY3lRXqVGhSED5U+YfnR1byCoEC64gxOUpbzyV0fHUseM7Vm61Qe3ibaSQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722164770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o24sg/v1TKqSJnXSyzItof46Y31GceiaBZpiDHTPFTI=;
	b=t3Cid4rVaEoV2EyHYP91LmKbi7JYAqNsXzCZfkTkrGsqWJFjnBaBmK9Lxf6gsGfkZrm3aT
	Q9PbLlhPuPvH3wDg==
To: Rob <rob@durendal.co.uk>
Cc: Christian Heusel <christian@heusel.eu>, Borislav Petkov <bp@alien8.de>,
 regressions@lists.linux.dev, x86@kernel.org, Joerg Roedel
 <joro@8bytes.org>, Tony Luck <tony.luck@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Lyude
 Paul <lyude@redhat.com>
Subject: [PATCH] x86/apic: Remove logical destination mode for 64-bit
In-Reply-To: <87cymyua9j.ffs@tglx>
References: <361b2ba5-7fc3-4e9a-af63-adfd4bc20304@heusel.eu>
 <20240723120246.GBZp-b5nHHT0BWmKMZ@fat_crate.local>
 <5e08cab0-c6b5-4169-8d42-ddb0ffb4a6c9@heusel.eu>
 <20240725105029.GAZqIt9aLsIaG7JqN5@fat_crate.local>
 <12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu> <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2> <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx> <ZqTufKvJKvotC-o_@vendhya2> <87cymyua9j.ffs@tglx>
Date: Sun, 28 Jul 2024 13:06:10 +0200
Message-ID: <877cd5u671.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Logical destination mode of the local APIC is used for systems with up to
8 CPUs. It has an advantage over physical destination mode as it allows to
target multiple CPUs at once with IPIs.

That advantage was definitely worth it when systems with up to 8 CPUs
were state of the art for servers and workstations, but that's history.

Aside of that there are systems which fail to work with logical destination
mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out there
which fail when interrupt remapping is enabled. The latter can be cured by
firmware updates, but not all OEMs distribute the required changes.

Physical destination mode is guaranteed to work because it is the only way
to get a CPU up and running via the INIT/INIT/STARTUP sequence.

As the number of CPUs keeps increasing, logical destination mode becomes a
less used code path so there is no real good reason to keep it around.

Therefore remove logical destination mode support for 64-bit and default to
physical destination mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h         |    8 --
 arch/x86/kernel/apic/apic_flat_64.c |  119 ++----------------------------------
 2 files changed, 7 insertions(+), 120 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -345,20 +345,12 @@ extern struct apic *apic;
  * APIC drivers are probed based on how they are listed in the .apicdrivers
  * section. So the order is important and enforced by the ordering
  * of different apic driver files in the Makefile.
- *
- * For the files having two apic drivers, we use apic_drivers()
- * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
 	static const struct apic *__apicdrivers_##sym __used		\
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") = { &sym }
 
-#define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
-	__aligned(sizeof(struct apic *))				\
-	__section(".apicdrivers") = { &sym1, &sym2 }
-
 extern struct apic *__apicdrivers[], *__apicdrivers_end[];
 
 /*
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,129 +8,25 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
 
-#include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
 #include "local.h"
 
-static struct apic apic_physflat;
-static struct apic apic_flat;
-
-struct apic *apic __ro_after_init = &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
-
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
+static u32 physflat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
 
-static int flat_probe(void)
+static int physflat_probe(void)
 {
 	return 1;
 }
 
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
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
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
-static int physflat_probe(void)
-{
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return 1;
 }
 
 static struct apic apic_physflat __ro_after_init = {
@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_af
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
+	.get_apic_id			= physflat_get_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_af
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
+apic_driver(apic_physflat);
 
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+struct apic *apic __ro_after_init = &apic_physflat;
+EXPORT_SYMBOL_GPL(apic);

