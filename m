Return-Path: <linux-kernel+bounces-181130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4EF8C77D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0C1C2191F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB31474BA;
	Thu, 16 May 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ngIKh6L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNHbFsy5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114529CEA
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866744; cv=none; b=ULX4MctpHcyrWFAUnhC5YO+bQm0RaPCyg4EWH61KtW9rYsq/o6UfBw3n9n7zm+JjE8RAVvvfQgaZhCjBrYv7kZ3gyano+q5b9ZbQNDChKAd2ebfZRnnAArQVqpzI5oLpZqTNLUpWF6DF9EhiKHWsKLj4sNWbvwW9Sv/Ey65i9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866744; c=relaxed/simple;
	bh=phIMI3YyrdajUvvCNzHuD18n4LYcirgcPkJzPD9WJfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQchg2YRGS0UZvbssaCY8S72gg2tkN9oEDy3Yqi+o0gRWH4zuHZoQRhtMbn9CZsmqGsWGgIe8kHPNsI0ljd06KHj7Z9x0pvGoVUE+MSo/O86YlWbgskP9l6wx492puMVMTe1B9ARVsi74ZC/bAwrgTmjZfkfzUf8sRZ3LZYlrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ngIKh6L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNHbFsy5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715866739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgJ4tB9IbQHts8b1nKZFshXdm8OS9cJ15elhzflaJYk=;
	b=3ngIKh6LUDQYwuYD+JURGqhkm7QGopaBP2FMGezi/s5XHeVtoGc2DabPvfV6e/7zc5ALB6
	Axb9vwNwBPqfNfGQ9TbmWOCF8xoufhVJUdgcT/5GpB/uoCMYf0K54Xvmr9n9Ffs4oA8emW
	FkEnpXVkVUkj1KE5hyp4x3t5Aikkg2a4zPaBQM13c8ce35WhN0UjuqLObuDEbaM61ThHxf
	23QY1hxTGPLzbnzM2NHl8nqYtZ1ziAMrWhYZVtJdPV3hf50hG28BAA/E5HGT5yMJ6YlZ00
	jkprnd+E8MOwTWDNhr2PBuLjIxFZQHj3Chr4v75I1fe/WzCAiYNfwzTkjbAKqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715866739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgJ4tB9IbQHts8b1nKZFshXdm8OS9cJ15elhzflaJYk=;
	b=FNHbFsy54ARhzIhmAJZBE2V94VAYT+qK04NAqOTc05HIIgJCE9QOx2EDqqJANsmfnC5WuW
	w2HLPWvdH25WEmAw==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <2fd6009d21d606d13f0c472dbaa754a21f3105d9.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
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
Date: Thu, 16 May 2024 15:38:59 +0200
Message-ID: <87wmntkhak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Wed, May 15 2024 at 19:15, Lyude Paul wrote:
> On Tue, 2024-05-14 at 10:25 +0200, Thomas Gleixner wrote:
>> 
>> Which one of the debug patches did you use?
>
> The one you sent on 4/18, when you also asked me for the output of
> /sys/kernel/debug/x86/topo/
>
> (I thought I remembered that patch not booting on previous kernels but maybe
> I'm misremembering)

It booted with the -rc kernel too. :)

I found an interesting and probably related difference in the boot logs
though. Up to 8 possible CPUs the kernel uses logical destination mode
for the APIC. With more than 8 it uses physical destination mode.

Can you please test the patch below on top of 6.9 and validate that it
boots w/o any magic command line parameter?

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..db5e93a7c194 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1883,6 +1883,8 @@ static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }
 #endif /* !CONFIG_X86_X2APIC */
 
+int irq_remap_mode = -1;
+
 void __init enable_IR_x2apic(void)
 {
 	unsigned long flags;
@@ -1915,6 +1917,8 @@ void __init enable_IR_x2apic(void)
 
 	if (ir_stat < 0)
 		restore_ioapic_entries();
+	else
+		irq_remap_mode = ir_stat;
 	legacy_pic->restore_mask();
 	local_irq_restore(flags);
 }
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f37ad3392fec..5cc386db3557 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 
+#include <asm/irq_remapping.h>
 #include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
@@ -130,7 +131,8 @@ static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 
 static int physflat_probe(void)
 {
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return apic == &apic_physflat || irq_remap_mode == IRQ_REMAP_XAPIC_MODE ||
+		num_possible_cpus() > 8 || jailhouse_paravirt();
 }
 
 static struct apic apic_physflat __ro_after_init = {
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 842fe28496be..f633ab6dfa9f 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -22,6 +22,8 @@ void x2apic_send_IPI_allbutself(int vector);
 void x2apic_send_IPI_self(int vector);
 extern u32 x2apic_max_apicid;
 
+extern int irq_remap_mode;
+
 /* IPI */
 
 DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);

