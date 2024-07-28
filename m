Return-Path: <linux-kernel+bounces-264810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9AF93E8AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC2B1F21884
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556358203;
	Sun, 28 Jul 2024 16:55:10 +0000 (UTC)
Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F66FD5
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185710; cv=none; b=F+Bf6+Xw004Hr/VC7Hv39wIDCuYKX6v/hYao78CW433ZdfY/shpGvVx7dF7PZd4dq0pQNg1P5EB19NvuKh4CNocM1Fz5Da4Joy98tJVwsLu5HeOaTAeQHoukeSkaeL0otOCAfOntWsoq3rIzayqhAd0UYfR/Hp8DhkNxfOxMd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185710; c=relaxed/simple;
	bh=PtDjrUISr60QwUXFMvRLPZKnXjOG+fGuxAPi1ubpbwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObJFL97pGNw3JDt4oDl5++lz1uR42EZoskf6pgP0vCD/j6lhk7tDicmbePi/lx/X6GunkcXCsBgzWQNZwaiGUdDtqLu+k7GV3eHr2J+Z+RIHzo0I5TDDlyWkQ33meLWJiZoDZjwTsNtwQcymMGGPDU9k12ADbVFrBMJd5WkdJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=durendal.co.uk; spf=none smtp.mailfrom=durendal.co.uk; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=durendal.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=durendal.co.uk
Received: from localhost ([146.198.41.26])
	by smtp with ESMTPA
	id Y77isWfWbLOPVY77jsybKP; Sun, 28 Jul 2024 17:51:57 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UsvANPwB c=1 sm=1 tr=0 ts=66a6772d
 a=uPaVN7U6Dr8slOeZeejB6w==:117 a=uPaVN7U6Dr8slOeZeejB6w==:17
 a=kj9zAlcOel0A:10 a=nKSMVCQS0CXgLSExdPYA:9 a=CjuIK1q_8ugA:10
X-AUTH: gnulinux@:2500
Date: Sun, 28 Jul 2024 17:51:54 +0100
From: Rob <rob@durendal.co.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christian Heusel <christian@heusel.eu>, Borislav Petkov <bp@alien8.de>,
	regressions@lists.linux.dev, x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>, Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
Message-ID: <ZqZ3Kp2NVctgstxs@vendhya2>
References: <5e08cab0-c6b5-4169-8d42-ddb0ffb4a6c9@heusel.eu>
 <20240725105029.GAZqIt9aLsIaG7JqN5@fat_crate.local>
 <12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu>
 <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2>
 <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx>
 <ZqTufKvJKvotC-o_@vendhya2>
 <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877cd5u671.ffs@tglx>
X-CMAE-Envelope: MS4xfOjCNNLoBDkg1oT302jRlY8EeyabyZWpGe6WHICHQEk1jB4lwYskHOi+/ceW9Yeq/i8a7EOn6JBDHt/MHWyWIRzXqMzeRnIplUl55YtpESqHW98OUEI/
 KVsM9Y0NTuwn3tNJ4TAOPNV5EeNiODbRvltFKyfixWx57x135pEOZdj/Br+gNjDE6YrARLqoLm+1CQ==

* Thomas Gleixner (tglx@linutronix.de) wrote:
>Logical destination mode of the local APIC is used for systems with up to
>8 CPUs. It has an advantage over physical destination mode as it allows to
>target multiple CPUs at once with IPIs.
>
>That advantage was definitely worth it when systems with up to 8 CPUs
>were state of the art for servers and workstations, but that's history.
>
>Aside of that there are systems which fail to work with logical destination
>mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out there
>which fail when interrupt remapping is enabled. The latter can be cured by
>firmware updates, but not all OEMs distribute the required changes.
>
>Physical destination mode is guaranteed to work because it is the only way
>to get a CPU up and running via the INIT/INIT/STARTUP sequence.
>
>As the number of CPUs keeps increasing, logical destination mode becomes a
>less used code path so there is no real good reason to keep it around.
>
>Therefore remove logical destination mode support for 64-bit and default to
>physical destination mode.

Thanks Chris for applying the patch for me.

Thomas - The patched kernel boots successfully.  I held off updating the 
BIOS so there can be no ambiguity.

Thanks,

Rob

>
>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>---
> arch/x86/include/asm/apic.h         |    8 --
> arch/x86/kernel/apic/apic_flat_64.c |  119 ++----------------------------------
> 2 files changed, 7 insertions(+), 120 deletions(-)
>
>--- a/arch/x86/include/asm/apic.h
>+++ b/arch/x86/include/asm/apic.h
>@@ -345,20 +345,12 @@ extern struct apic *apic;
>  * APIC drivers are probed based on how they are listed in the .apicdrivers
>  * section. So the order is important and enforced by the ordering
>  * of different apic driver files in the Makefile.
>- *
>- * For the files having two apic drivers, we use apic_drivers()
>- * to enforce the order with in them.
>  */
> #define apic_driver(sym)					\
> 	static const struct apic *__apicdrivers_##sym __used		\
> 	__aligned(sizeof(struct apic *))			\
> 	__section(".apicdrivers") = { &sym }
>
>-#define apic_drivers(sym1, sym2)					\
>-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
>-	__aligned(sizeof(struct apic *))				\
>-	__section(".apicdrivers") = { &sym1, &sym2 }
>-
> extern struct apic *__apicdrivers[], *__apicdrivers_end[];
>
> /*
>--- a/arch/x86/kernel/apic/apic_flat_64.c
>+++ b/arch/x86/kernel/apic/apic_flat_64.c
>@@ -8,129 +8,25 @@
>  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
>  * James Cleverdon.
>  */
>-#include <linux/cpumask.h>
> #include <linux/export.h>
>-#include <linux/acpi.h>
>
>-#include <asm/jailhouse_para.h>
> #include <asm/apic.h>
>
> #include "local.h"
>
>-static struct apic apic_physflat;
>-static struct apic apic_flat;
>-
>-struct apic *apic __ro_after_init = &apic_flat;
>-EXPORT_SYMBOL_GPL(apic);
>-
>-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
>-{
>-	return 1;
>-}
>-
>-static void _flat_send_IPI_mask(unsigned long mask, int vector)
>-{
>-	unsigned long flags;
>-
>-	local_irq_save(flags);
>-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
>-	local_irq_restore(flags);
>-}
>-
>-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
>-{
>-	unsigned long mask = cpumask_bits(cpumask)[0];
>-
>-	_flat_send_IPI_mask(mask, vector);
>-}
>-
>-static void
>-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
>-{
>-	unsigned long mask = cpumask_bits(cpumask)[0];
>-	int cpu = smp_processor_id();
>-
>-	if (cpu < BITS_PER_LONG)
>-		__clear_bit(cpu, &mask);
>-
>-	_flat_send_IPI_mask(mask, vector);
>-}
>-
>-static u32 flat_get_apic_id(u32 x)
>+static u32 physflat_get_apic_id(u32 x)
> {
> 	return (x >> 24) & 0xFF;
> }
>
>-static int flat_probe(void)
>+static int physflat_probe(void)
> {
> 	return 1;
> }
>
>-static struct apic apic_flat __ro_after_init = {
>-	.name				= "flat",
>-	.probe				= flat_probe,
>-	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
>-
>-	.dest_mode_logical		= true,
>-
>-	.disable_esr			= 0,
>-
>-	.init_apic_ldr			= default_init_apic_ldr,
>-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
>-
>-	.max_apic_id			= 0xFE,
>-	.get_apic_id			= flat_get_apic_id,
>-
>-	.calc_dest_apicid		= apic_flat_calc_apicid,
>-
>-	.send_IPI			= default_send_IPI_single,
>-	.send_IPI_mask			= flat_send_IPI_mask,
>-	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
>-	.send_IPI_allbutself		= default_send_IPI_allbutself,
>-	.send_IPI_all			= default_send_IPI_all,
>-	.send_IPI_self			= default_send_IPI_self,
>-	.nmi_to_offline_cpu		= true,
>-
>-	.read				= native_apic_mem_read,
>-	.write				= native_apic_mem_write,
>-	.eoi				= native_apic_mem_eoi,
>-	.icr_read			= native_apic_icr_read,
>-	.icr_write			= native_apic_icr_write,
>-	.wait_icr_idle			= apic_mem_wait_icr_idle,
>-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
>-};
>-
>-/*
>- * Physflat mode is used when there are more than 8 CPUs on a system.
>- * We cannot use logical delivery in this case because the mask
>- * overflows, so use physical mode.
>- */
> static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> {
>-#ifdef CONFIG_ACPI
>-	/*
>-	 * Quirk: some x86_64 machines can only use physical APIC mode
>-	 * regardless of how many processors are present (x86_64 ES7000
>-	 * is an example).
>-	 */
>-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
>-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
>-		printk(KERN_DEBUG "system APIC only can use physical flat");
>-		return 1;
>-	}
>-
>-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
>-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
>-		return 1;
>-	}
>-#endif
>-
>-	return 0;
>-}
>-
>-static int physflat_probe(void)
>-{
>-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
>+	return 1;
> }
>
> static struct apic apic_physflat __ro_after_init = {
>@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_af
> 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
>
> 	.max_apic_id			= 0xFE,
>-	.get_apic_id			= flat_get_apic_id,
>+	.get_apic_id			= physflat_get_apic_id,
>
> 	.calc_dest_apicid		= apic_default_calc_apicid,
>
>@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_af
> 	.wait_icr_idle			= apic_mem_wait_icr_idle,
> 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
> };
>+apic_driver(apic_physflat);
>
>-/*
>- * We need to check for physflat first, so this order is important.
>- */
>-apic_drivers(apic_physflat, apic_flat);
>+struct apic *apic __ro_after_init = &apic_physflat;
>+EXPORT_SYMBOL_GPL(apic);

-- 
Rob Newcater

