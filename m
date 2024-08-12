Return-Path: <linux-kernel+bounces-283792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B194F8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD666B20F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB9175D3D;
	Mon, 12 Aug 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BF/DHPz1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlzVR/M4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D116BE01
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496658; cv=none; b=plzp6n502q/ciRdqraeC9iJHivcMu0Ut6XFcr3Am931FG9WqPAa/7dq6kSwjSJGu+gAij1IZ/vkQAzMEjqv61nQD9h/1mONA6W49SFu0w8VQovf62KW3kRlo4Ri2JONEp871hTvZnef8JHZFgRHokEyccDw6lI3YyFkUlqXKmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496658; c=relaxed/simple;
	bh=GClgj2R2RW57IbT0CQbkBu/2gF9k4D/CPQB58p5neRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpTE25NnzFOeeIOGh9jweGn7PORq6ldch7dVPrHD9zVsZvUm3VgdWEN/FOH/UM59jkyB0gO22JrclSw/mtrCjDLQR8fTmJ6rLI1DxFdFY4XJwMudFoktYkzVgd2hi6p+8SZIFwIPxGYbmW7Owrw37VnzpCqMXHyh1WahzAVBx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BF/DHPz1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FlzVR/M4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723496654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qylMb/PJkxVqMp/MGQvYyYmuKfeQ8u7apULPzaVdPjE=;
	b=BF/DHPz1665DNXQxD7RN8QeXgEozpA3Whb0j7fUIruRdOdsQKtz+BLo9Lqtn7VEmZHkiw3
	jWjoNl6wJj2HKMDgkeD4k3/3kr6BgHtKUmuwkmCdhRE2o6sxbeJid8+ExjT4XndManOfYK
	vVDPQ8SKf0yXo4MQwW5ewxO0UDww8SU8+naQne6EYxOYt9xv7pJOIOeGHp1Hb6BH4y0jXW
	ejb23OoQGlpqQ135FLd4Q4a9lJwfZyiwsLQzjKM5jJrfBgmx4IXf/lYRB7pQGK+Qy/SyK9
	oiBU0S50+JHCC40+WrnpfEE7hfSOTm0dK1dokhqm9fu6o1XjqZZNUBeaINJxWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723496654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qylMb/PJkxVqMp/MGQvYyYmuKfeQ8u7apULPzaVdPjE=;
	b=FlzVR/M4e8/rj1AZCr8+Bf76B5Tg+3KX6NSPWf8k3JBSTWC9GUBr3JJReb1cQ5AqmsXTzv
	MbvF7G0jVf+fl0Aw==
To: Florian Rommel <mail@florommel.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>,
 Lorena Kretzschmar <qy15sije@cip.cs.fau.de>, Stefan Saecherl
 <stefan.saecherl@fau.de>, Peter Zijlstra <peterz@infradead.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Randy Dunlap
 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: Re: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
In-Reply-To: <20240812174338.363838-3-mail@florommel.de>
References: <20240812174338.363838-1-mail@florommel.de>
 <20240812174338.363838-3-mail@florommel.de>
Date: Mon, 12 Aug 2024 23:04:13 +0200
Message-ID: <871q2tsbaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian!

On Mon, Aug 12 2024 at 19:43, Florian Rommel wrote:
> On x86, occasionally, the removal of a breakpoint (i.e., removal of
> the int3 instruction) fails because the text_mutex is taken by another
> CPU (mainly due to the static_key mechanism, I think).

Either you know it or not. Speculation is reserved for CPUs.

> The function kgdb_skipexception catches exceptions from these spurious
> int3 instructions, bails out of KGDB, and continues execution from the
> previous PC address.
>
> However, this led to an endless loop between the int3 instruction and
> kgdb_skipexception since the int3 instruction (being still present)
> triggered again.  This effectively caused the system to hang.
>
> With this patch, we try to remove the concerned spurious int3
> instruction in kgdb_skipexception before continuing execution.  This
> may take a few attempts until the concurrent holders of the text_mutex
> have released it, but eventually succeeds and the kernel can continue.

What guarantees the release of text mutex?

> Signed-off-by: Florian Rommel <mail@florommel.de>
> ---
>  arch/x86/kernel/kgdb.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> index 64c332151af7..585a7a72af74 100644
> --- a/arch/x86/kernel/kgdb.c
> +++ b/arch/x86/kernel/kgdb.c
> @@ -723,7 +723,31 @@ void kgdb_arch_exit(void)
>  int kgdb_skipexception(int exception, struct pt_regs *regs)

Btw, kgdb_skipexception() is a gross nisnomer because it rewinds the
instruction pointer to the exception address and does not skip anything,
but that's an orthogonal issue though it could be cleaned up along the
way...

>  {
>  	if (exception == 3 && kgdb_isremovedbreak(regs->ip - 1)) {
> +		struct kgdb_bkpt *bpt;
> +		int i, error;
> +
>  		regs->ip -= 1;
> +
> +		/*
> +		 * Try to remove the spurious int3 instruction.
> +		 * These int3s can result from failed breakpoint removals
> +		 * in kgdb_arch_remove_breakpoint.
> +		 */
> +		for (bpt = NULL, i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> +			if (kgdb_break[i].bpt_addr == regs->ip &&
> +			    kgdb_break[i].state == BP_REMOVED &&
> +			    (kgdb_break[i].type == BP_BREAKPOINT ||
> +			     kgdb_break[i].type == BP_POKE_BREAKPOINT)) {
> +				bpt = &kgdb_break[i];
> +				break;
> +			}
> +		}

Seriously? The KGBD core already walked that array in
kgdb_isremovedbreak() just so you can walk it again here.

struct kkgdb_bkpt *kgdb_get_removed_breakpoint(unsigned long addr)
{
        struct kgdb_bkpt *bp = kgdb_break;
       
	for (int i = 0; i < KGDB_MAX_BREAKPOINTS; i++, bp++) {
		if (bp>.state == BP_REMOVED && bp->kgdb_bpt_addr == addr)
			return bp;
	}
	return NULL;
}

bool kgdb_isremovedbreak(unsigned long addr)
{
        return !!kgdb_get_removed_breakpoint(addr);
}

bool kgdb_rewind_exception(int exception, struct pt_regs *regs)
{
        struct kgdb_bkpt *bp;

	if (exception != 3)
        	return false;

        bp = kgdb_get_removed_breakpoint(--regs->ip);
        if (!bp || !bp->type == BP_BREAKPOINT)
        	return false;

Hmm?

> +		error = kgdb_arch_remove_breakpoint(bpt);
> +		if (error)
> +			pr_err("skipexception: breakpoint remove failed: %lx\n",
> +			       bpt->bpt_addr);

Lacks curly brackets. See Documentation.

	return !error;

Aside of that the same problem exists on PowerPC. So you can move the
attempt to remove the breakpoint into the generic code, no?

Thanks,

        tglx



