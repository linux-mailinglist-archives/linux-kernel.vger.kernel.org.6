Return-Path: <linux-kernel+bounces-407802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6C9C759C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1E2B23E23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333015A848;
	Wed, 13 Nov 2024 14:39:10 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB7208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508750; cv=none; b=sCSVGFTlGXcrJR4i7uXiqy4kPxb8rql0dWD+4vlBtIvIlx6KwHvenX6KeQzqNFqVyh4WNlK8cl004u8S8lSqxhattzhTyFbJsI42b97ksJwUjnpxPYA7v3/pT0eehdObG2H8b6Rm2shWkxeQlPVRw+JIxE18PXo8ly3a9S9XZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508750; c=relaxed/simple;
	bh=CL6bAueQXedVclLmLJ4tmQmg6rJTXuZVJb8gz1HGzQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/Z7E6K5rasUFlyXIIT4ZzhHpWZX1vXjKxjEajKQrhZuEX0JpaIcU6tcFWkvYw4Ad6lS5mlEOT/zmXv5kTHptz+ovNjcMccear5XU2fBt7yendgsjpYX2/HV9Jqu144QA7/43wgbgoKHSjJwYqn2HbL/bIfHmDkr8V7aAE7QIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBEVm-000000008WS-2Xem;
	Wed, 13 Nov 2024 09:38:26 -0500
Date: Wed, 13 Nov 2024 09:38:26 -0500
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
 mingo@redhat.com, x86@kernel.org, kernel-team@meta.com, hpa@zytor.com,
 bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241113093826.667c4918@imladris.surriel.com>
In-Reply-To: <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
References: <20241109003727.3958374-1-riel@surriel.com>
	<20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: riel@surriel.com

On Wed, 13 Nov 2024 10:55:50 +0100
Borislav Petkov <bp@alien8.de> wrote:
On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > While profiling switch_mm_irqs_off with several workloads,
> > it appears there are two hot spots that probably don't need
> > to be there.
>=20
> One of those three is causing the below here, zapping them from tip.
>=20

This is interesting, and unexpected.

> [    3.186469] ------------[ cut here ]------------
> [    3.186469] WARNING: CPU: 16 PID: 97 at kernel/smp.c:807
> smp_call_function_many_cond+0x188/0x720

This is the lockdep_assert_irqs_enabled() from this branch:

        if (cpu_online(this_cpu) && !oops_in_progress &&
            !early_boot_irqs_disabled)
                lockdep_assert_irqs_enabled();

> [    3.186469] Call Trace:
> [    3.186469]  <TASK>
> [    3.186469]  on_each_cpu_cond_mask+0x50/0x90
> [    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
> [    3.186469]  __text_poke+0x366/0x5d0

... and sure enough, it looks like __text_poke() calls
flush_tlb_mm_range() with IRQs disabled!

> [    3.186469]  text_poke_bp_batch+0xa1/0x3d0
> [    3.186469]  text_poke_finish+0x1b/0x30
> [    3.186469]  arch_jump_label_transform_apply+0x18/0x30
> [    3.186469]  static_key_slow_inc_cpuslocked+0x55/0xa0
...

I have no good explanation for why that lockdep_assert_irqs_enabled()
would not be firing without my patches applied.

We obviously should not be sending out any IPIs with IRQs disabled.

However, __text_poke has been sending IPIs with interrupts disabled
for 4 years now! No wonder we see deadlocks involving __text_poke
on a semi-regular basis.

Should we move the local_irq_restore() in __text_poke() up a few lines,
like in the patch below?

Alternatively, should we explicitly clear the mm_cpumask in unuse_temporary=
_mm,
to make sure that mm never has any bits set in mm_cpumask?

Or, since we do not flush the TLB for the poking_mm until AFTER we have swi=
tched
back to the prev mm, should we simply always switch to the poking_mm in a w=
ay
that involves flushing the TLB? That way we won't even have to flush the en=
try
after unuse...

What is the best approach here?
---8<---
=46rom a2e7c517bbd2cf108fc14c51449bf8e53e314b53 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Wed, 13 Nov 2024 09:19:39 -0500
Subject: [PATCH] x86,alternatives: re-enable interrupts before sending TLB =
 flush IPI

__text_poke() calls flush_tlb_mm_range() to flush the mapping of
the text poke address. However, it does so with interrupts disabled,
which can cause a deadlock.

We do occasionally observe deadlocks involving __text_poke(), but
not frequently enough to spend much time debugging them.

Borislav triggered this bug while testing a different patch, which
lazily clears bits from the mm_cpumask, resulting in more bits being
set when __text_poke() calls flush_tlb_mm_range(), which in turn
triggered the lockdep_assert_irqs_enabled() in smp_call_function_many_cond(=
).

Avoid sending IPIs with IRQs disabled by re-enabling IRQs earlier.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Cc: stable@kernel.org
Fixes: 7cf494270424 ("x86: expand irq-off region in text_poke()")
---
 arch/x86/kernel/alternative.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d17518ca19b8..f71d84249f6e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1940,6 +1940,9 @@ static void *__text_poke(text_poke_f func, void *addr=
, const void *src, size_t l
 	 */
 	unuse_temporary_mm(prev);
=20
+	/* Re-enable interrupts before sending an IPI. */
+	local_irq_restore(flags);
+
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled
 	 * IRQs, but not if the mm is not used, as it is in this point.
@@ -1956,7 +1959,6 @@ static void *__text_poke(text_poke_f func, void *addr=
, const void *src, size_t l
 		BUG_ON(memcmp(addr, src, len));
 	}
=20
-	local_irq_restore(flags);
 	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }
--=20
2.45.2




