Return-Path: <linux-kernel+bounces-407827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9719D9C74DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8791F2264B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862F12DD8A;
	Wed, 13 Nov 2024 14:56:19 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C192AD21
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509779; cv=none; b=BFJfqbx5VB/JgDU0G7qFIcErPirU8jct06I7burSVow2syBX9LPw9WhRAkmxIfdwV7ygpVLbwwQI8BPfzmj6WBXuAmVogLhdVZQIwoMKbSE9QSpzxgJrJs/wPgXIk4IBkKON2U+dBk8U797k0PGuC8KohUNWmh3y+QHioOJz6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509779; c=relaxed/simple;
	bh=ZFiMeblYhyawTki15sRENgZujlQpHHU3ZE7JYgt4Kcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2aEIbdmSCRjHrMjPaecPnwQTedxJsXZNjLyXRMIAdZelmih5dwVZIO5/2L/Y2/L5UiNulTtYHQ7UGzaWgKiIBGhlMbDmtOAzoYdewQw+nVjtblNz2w/HIFPXpN/84HYLYqCSg1aoXy43bMfAGUo+SAnd7Bc+JcEd5XyYqg0FyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBEmj-000000000Gz-3QDa;
	Wed, 13 Nov 2024 09:55:57 -0500
Date: Wed, 13 Nov 2024 09:55:57 -0500
From: Rik van Riel <riel@surriel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
 mingo@redhat.com, x86@kernel.org, kernel-team@meta.com, hpa@zytor.com,
 bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241113095557.2d60a073@imladris.surriel.com>
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

> On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > While profiling switch_mm_irqs_off with several workloads,
> > it appears there are two hot spots that probably don't need
> > to be there. =20
>=20
> One of those three is causing the below here, zapping them from tip.
>=20

TL;DR: __text_poke ends up sending IPIs with interrupts disabled.

> [    3.186469]  on_each_cpu_cond_mask+0x50/0x90
> [    3.186469]  flush_tlb_mm_range+0x1a8/0x1f0
> [    3.186469]  ? cpu_bugs_smt_update+0x14/0x1f0
> [    3.186469]  __text_poke+0x366/0x5d0

Here is an alternative to avoid __text_poke() from calling
on_each_cpu_cond_mask() with IRQs disabled:

---8<---
=46rom e872edeaad14c793036f290afc28000281e1b76a Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Wed, 13 Nov 2024 09:51:16 -0500
Subject: [PATCH] x86/alternatives: defer poking_mm TLB flush to next use

Instead of doing a TLB flush of the poking_mm after we have
already switched back to the prev mm, we can simply increment
the tlb_gen for the poking_mm at unuse time.

This will cause switch_mm_irqs_off to flush the TLB next time
it loads the poking_mm, in the unlikely case that poking_mm still
has an ASID on that CPU by then.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/kernel/alternative.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d17518ca19b8..f3caf5bc4df9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1830,6 +1830,9 @@ static inline void unuse_temporary_mm(temp_mm_state_t=
 prev_state)
 	lockdep_assert_irqs_disabled();
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
=20
+	/* Force a TLB flush next time poking_mm is used. */
+	inc_mm_tlb_gen(poking_mm);
+
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm
 	 * was loaded.
@@ -1940,14 +1943,6 @@ static void *__text_poke(text_poke_f func, void *add=
r, const void *src, size_t l
 	 */
 	unuse_temporary_mm(prev);
=20
-	/*
-	 * Flushing the TLB might involve IPIs, which would require enabled
-	 * IRQs, but not if the mm is not used, as it is in this point.
-	 */
-	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
-			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
-			   PAGE_SHIFT, false);
-
 	if (func =3D=3D text_poke_memcpy) {
 		/*
 		 * If the text does not match what we just wrote then something is
--=20
2.45.2


