Return-Path: <linux-kernel+bounces-524232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DDA3E0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D0586122E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4B720C473;
	Thu, 20 Feb 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpDKQb5r"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979B20C028
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069061; cv=none; b=SEVGypGH9MJak3CsonRVFj9uu9L9hfMiy1Uqr4tVgZx5R2fw5Ja7n8In5cR75h/d6RUyGD3wYi3VnMfmNcKhiY9p78hS6WrALBj4Q+ukWQeWFgcIl1/m/oZKoTALAIlg7GnVUQkNzupUgAh+befdmZJQ6vTd85Ofs6+Ua6CoYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069061; c=relaxed/simple;
	bh=42rqNDCaujYxpOveulSZOy3q1G2V7uMbO/rPRo+TUWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJhr+CehHUqradlc9r+m3M+qDWFS9i62XGZW+XV5oYgm8l/vpYLTmQeoTR+eFP9jB482ps7x4EPp0pTeOL9a4CSExgPPKwWg3fYtQpHV0EQ4S18GGGsjcCjcL7Jz3txcuKcw4ts2DTP4Slzbm0kVch1RTk85+ScNAkdWBUnfPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpDKQb5r; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso542226a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740069059; x=1740673859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RunbDwqsCKiDMq6NQxy4XFRnim+xmAlewv0MU2PV7ik=;
        b=fpDKQb5rOspxpE1QRE4zK34Vp5J8rWmaTxq6wsQ7ADrvqxzqp7mTzjdDc5YIFdA1gk
         K0BKbF2KH3hDpl3SWzDPoEnKlgpqac+mEj0bebEWt1eNO3+MdWenaRCciQLH5omI3D0d
         nF48QDxhX86o7IOBhur2CrpsroKMSs/tqDWazxDzNFspk9rgm5vUGePSd7xEvBT73egg
         P9PuXKS9jUrpNaiyc/8NgJM/y8/Rm1mJqsZ38S4YZ2AHqP88/6KkkPmg+P5NU6+wS8zL
         oEd/dQaZ5fv78vG7d8pSnCCH+rKjNB6Y3hch8NWcxwa1aunkUYiGGaUVJWBFtzBK+KMk
         lAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069059; x=1740673859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RunbDwqsCKiDMq6NQxy4XFRnim+xmAlewv0MU2PV7ik=;
        b=kpmhgXo9pDYp1DsS/plwsDjCI7OAksK/A2EdkpMSofyxGXxgpDcIaKLXT7N33zXQNk
         J8XTl4a/PvsXX+4N0lcKEYsgBSKfulnU8zX5U46wQ0RPqKoL5a33yBl7u020o/6Hb8Xe
         usyjO9tdOZPwuq5EBmOaAUqLCluTYNwe2Awr8H8ASZdDqWUNJfDN/OaD22IdqnEr+2c0
         uJKkLPzl4MIeICnmzubJdLTzjK+cjfe5GSafjrKZ2X40BbovHl27R3ALuw1lpZwCYKiE
         AtgDi7vN/AR/TmgXUSMKoGVrsWGPqOjmeO4RYkbAFZcKbWNZdPakNBHbaAPwsI1jiDn1
         aQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU8g570iQM88/cRbad5BMvui+lMY0CxSfK/thOfPBKHQPZrQazbMBrsyaklfPKsW1Wxj0qbiiC0Nl4bsvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CO20seP3pFH+3Tn+MJ9RJOgUAU9543LaWOVheeRTPYvLH9IW
	7TNg0pQKFUuOmAK5rfrn4KmnCT+uYQ0KXRQ/BZpUjURVtGk6FfnbDsJFjkdWwAOZZBiAELGs942
	A8PzMe8fA13OxLV6DdWiKjHQtmaQt77X4erux
X-Gm-Gg: ASbGncu16CvfPgvfMcrmLt4ByE1K1lsp08qiHVdwdXa68t4N8igu/nh68NBLhIBIdTE
	uPe6t2GSTSUQ2bFcTmADqC4e62qYygWGHqujWoSLACkbwZL8+eV0+Afmdpr1YsI/LM124yhqmne
	nq8sLUYMHrFp2CIvqc7G8DzHwtKYU=
X-Google-Smtp-Source: AGHT+IFdqO9ngHYhveH35oJHO22aeobAr6glftEnXejC12aebBifGJtpg6TkKA77hUr2iCeDWZSqoxHWRC4YUmQWiZk=
X-Received: by 2002:a17:90b:278b:b0:2fa:1a8a:cff8 with SMTP id
 98e67ed59e1d1-2fcb5aba7admr13293676a91.29.1740069058693; Thu, 20 Feb 2025
 08:30:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z7bUC9QY815Cv6nb@xsang-OptiPlex-9020> <20250220155722.2Z2a-3z0@linutronix.de>
In-Reply-To: <20250220155722.2Z2a-3z0@linutronix.de>
From: Marco Elver <elver@google.com>
Date: Thu, 20 Feb 2025 17:30:22 +0100
X-Gm-Features: AWEUYZl9XyuxFIVLWSjhfqqO0OUA4wn0EYnMOUYAgeDjJV6JjoSIe-IH-I10jY8
Message-ID: <CANpmjNN9zpcPa4S+Zq+vJWJ3EcO0zCZJ=Z4FgNzDRXdi0YQA9g@mail.gmail.com>
Subject: Re: [linux-next:master] [x86] 66fbf67705: kernel-selftests.kvm.hardware_disable_test.fail
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Petr Pavlu <petr.pavlu@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Kees Cook <kees@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:57, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
[...]
> Now. Based on this:
> The RCU read section increased the runtime (on my hardware) for the test
> from 30 to 43 seconds which is roughly 43%.
> This is due to the lockdep annotation within rcu_read_lock() and
> unlock() which is not existing in preempt_disable(). After disabling
> UBSAN + KASAN  the lockdep annotation has no effect. My guess that
> UBSAN/ KASAN is in charge of countless backtraces while enabled. Those
> backtraces seem to be limited to the core kernel.
>
> How much do we care here? Is this something that makes UBSAN + KASAN
> folks uncomfortable? Or is lockdep slowing things down anyway?

Does this series from Waiman help?
https://lore.kernel.org/all/20250213200228.1993588-4-longman@redhat.com/

> If so, we could either move the RCU section down (as in #5) so it is not
> used that often or go the other direction and move it up. I got this:
> | ~# time ./hardware_disable_test
> | Random seed: 0x6b8b4567
> |
> | real    0m32.618s
> | user    0m0.537s
> | sys     0m13.942s
>
> which is almost the pre-level with the hunk below after figuring out
> that most callers are from arch_stack_walk().
>
> diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
> index 7cede4dc21f0..f20e3613942f 100644
> --- a/arch/x86/include/asm/unwind.h
> +++ b/arch/x86/include/asm/unwind.h
> @@ -42,6 +42,7 @@ struct unwind_state {
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>                     struct pt_regs *regs, unsigned long *first_frame);
>  bool unwind_next_frame(struct unwind_state *state);
> +bool unwind_next_frame_unlocked(struct unwind_state *state);
>  unsigned long unwind_get_return_address(struct unwind_state *state);
>  unsigned long *unwind_get_return_address_ptr(struct unwind_state *state);
>
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index ee117fcf46ed..4df346b11f1e 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -21,8 +21,9 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>         if (regs && !consume_entry(cookie, regs->ip))
>                 return;
>
> +       guard(rcu)();
>         for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
> -            unwind_next_frame(&state)) {
> +            unwind_next_frame_unlocked(&state)) {
>                 addr = unwind_get_return_address(&state);
>                 if (!addr || !consume_entry(cookie, addr))
>                         break;
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 977ee75e047c..402779b3e90a 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -465,7 +465,7 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
>         return false;
>  }
>
> -bool unwind_next_frame(struct unwind_state *state)
> +bool unwind_next_frame_unlocked(struct unwind_state *state)
>  {
>         unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
>         enum stack_type prev_type = state->stack_info.type;
> @@ -475,9 +475,6 @@ bool unwind_next_frame(struct unwind_state *state)
>         if (unwind_done(state))
>                 return false;
>
> -       /* Don't let modules unload while we're reading their ORC data. */
> -       guard(rcu)();
> -
>         /* End-of-stack check for user tasks: */
>         if (state->regs && user_mode(state->regs))
>                 goto the_end;
> @@ -678,6 +675,13 @@ bool unwind_next_frame(struct unwind_state *state)
>         state->stack_info.type = STACK_TYPE_UNKNOWN;
>         return false;
>  }
> +
> +bool unwind_next_frame(struct unwind_state *state)
> +{
> +       /* Don't let modules unload while we're reading their ORC data. */
> +       guard(rcu)();
> +       return unwind_next_frame_unlocked(state);
> +}
>  EXPORT_SYMBOL_GPL(unwind_next_frame);
>
>  void __unwind_start(struct unwind_state *state, struct task_struct *task,
>
> Sebastian

