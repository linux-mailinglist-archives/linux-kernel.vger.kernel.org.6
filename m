Return-Path: <linux-kernel+bounces-518772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444C0A39437
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D6D3A4D92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215941FFC5D;
	Tue, 18 Feb 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYjactN3"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6751EDA1E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865354; cv=none; b=p98IhzHPbGfB5OMF2mta2Y7YpxzxD0sXOlZJycRr8lwVrllQVNaCgF0UnAylA1uy/6jmhTDLLl0b0pM/Cd1A2/uwsvBajfw5RDNpoJ9s/F+fdw8tRbYETI/gIx/eIFCkPLsNVhUcKSD35LvA17OSvSQlEX0qMQwEBYZ01El9694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865354; c=relaxed/simple;
	bh=78CBqu7nFXfkTrnl7nf/R9t2kH+0OhMeS/1SjnvDuEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYjlRW7aTcKYKVytrGwvwPnoBBmPawLqCroEALA0YPTpX8QTNh6CcRPsnir4XprghFRqyte6Fnx4B6lsxDsYTYzwwGEora5b56pw0A19+E4XpQzK5TF21Wp0D8t3sJlY8h4rRYKghG4RhksnHOzsKs0bJ26/FdD4oHSU4lkruV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EYjactN3; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30737db1ab1so47396161fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739865350; x=1740470150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AmZSDaAsTOuG4MwN5a0V7qM/h0uBWdn0gkT6M2vW8xM=;
        b=EYjactN365ok8B3tbiO0Z9G45h/vDq6GnPDZQN66hBLFphSaJitN0O39fY2kpGTp/6
         Ve6N+PR65iLEAm6A/maeBxDEU9iSYLCFKwO+GdIoOjYjzaoww/EAs+gQ+oenSOc8r1nV
         6Cwa6f93SgiYR7oUn5JUdksr80tDhdzJb7EGweCrZr4FExysgw/o08p6nPHYlbIhvfem
         AUU6c+272x6OWxk2SSGzvHt6lpwL3IGmgPbzvQbPZfklpgJTxtkUkLqJjiorqYCfU0Zy
         NZ+X43xWf+U2bTsJ+/SGK8R0mbyZ67stYCYI2f2uw4IsDOjvTfBfYcwrAb+QBZ9F1jjF
         ESWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739865350; x=1740470150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmZSDaAsTOuG4MwN5a0V7qM/h0uBWdn0gkT6M2vW8xM=;
        b=T7Ahw+IqsvAQDt/YpQJLZiMKxl6pEYanH6OAj1n+DkzKXqYqhxYHllbPJnX+IUzvkf
         KC/YDIuU3YkISk5/vDW14j8mHhjVaVOFbWnlJ9mlPXrgoWs8/1yYxAdHtwn+C9M22Uzv
         GbkFdGfjvQLbn7HrTpyu5fnjm7zlIe90Vl/8qqaANbp85szqZ1pnwzNJTOYzOlyeEJiY
         6mH+QyGbNFc9BaB9tsKyLTcdoCUNpLfdi1WwzvwQFZHn0CIWPE2FJj1Ob5OeeYj0KnEn
         rXzIDq5FY+YGm1i1evuKwQ0aeuOWzZxZgTNlYRXwdhDsiIebfbSUHuVfPbapFw39mFpF
         y3GA==
X-Forwarded-Encrypted: i=1; AJvYcCXMPZA/XlFqa6rS+oHh2LfsECWhERAspz+EAstHcuKw0g+85brbEW4eU3tTihOMP6s82Qfj3adycdBba3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmmP6T7jp2nWYEQdV3HLq3eMfB3cGzpaZen5tv/tbggpsUg+s
	3RFEZfIu8cb5MSm7BkqTuhBMDZ8bzwxiMr9xaCJ8v0QJRX9o1D/WuISkzrTmbsiM4wPxv9wEwfF
	WbDGpJ7oOIEOi0wk3OXkMwpfXhIpuXPM+DlPu
X-Gm-Gg: ASbGncuQRnnrjlTcXM726nZ7/LpgGZcUla2c7NkLYv6nASs7bXiY0KbQvIL7acke9J5
	x5ZTOrJI1mpIcm/aA0RYk2FCqCg7YqOkrWJM3TN93FKiIgYMD/thg3PZnQA+LA9LRXvezO8BDzM
	mAdFVPcKZcez/ymTjocsGWFlm/sUv4fQ==
X-Google-Smtp-Source: AGHT+IF2KwXups2hFyrCUOtONgMEIJupugBucSDc7NZVEHaQES6H0B02aOprrj+kcb2raM69m7l28wiMFe77ktUsZ4U=
X-Received: by 2002:a2e:a163:0:b0:308:fa1d:d833 with SMTP id
 38308e7fff4ca-30927b283damr34097051fa.37.1739865350435; Mon, 17 Feb 2025
 23:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
In-Reply-To: <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 18 Feb 2025 08:55:39 +0100
X-Gm-Features: AWEUYZmXZN1TvCNb7watXO4g8ChSu3sqd4UdM2Ok4pQypM7hmuXZS0vCyHnwo4A
Message-ID: <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-17 06:07, Dmitry Vyukov wrote:
> > If an application registers rseq, and ever switches to another pkey
> > protection (such that the rseq becomes inaccessible), then any
> > context switch will cause failure in __rseq_handle_notify_resume()
> > attempting to read/write struct rseq and/or rseq_cs. Since context
> > switches are asynchronous and are outside of the application control
> > (not part of the restricted code scope), temporarily switch to
> > premissive pkey register to read/write rseq/rseq_cs, similarly
>
> permissive
>
> > to signal delivery accesses to altstack.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   kernel/rseq.c | 36 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 36 insertions(+)
> >
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index 442aba29bc4cf..31cd94b370ef3 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -10,6 +10,7 @@
> >
> >   #include <linux/sched.h>
> >   #include <linux/uaccess.h>
> > +#include <linux/pkeys.h>
> >   #include <linux/syscalls.h>
> >   #include <linux/rseq.h>
> >   #include <linux/types.h>
> > @@ -403,10 +404,13 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >   {
> >       struct task_struct *t = current;
> >       int ret, sig;
> > +     pkey_reg_t saved;
> > +     bool switched_pkey_reg = false;
> >
> >       if (unlikely(t->flags & PF_EXITING))
> >               return;
> >
> > +retry:
> >       /*
> >        * regs is NULL if and only if the caller is in a syscall path.  Skip
> >        * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> > @@ -419,9 +423,41 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >       }
> >       if (unlikely(rseq_update_cpu_node_id(t)))
> >               goto error;
> > +     if (switched_pkey_reg)
> > +             write_pkey_reg(saved);
> >       return;
> >
> >   error:
> > +     /*
> > +      * If the application registers rseq, and ever switches to another
> > +      * pkey protection (such that the rseq becomes inaccessible), then
> > +      * any context switch will cause failure here attempting to read/write
> > +      * struct rseq and/or rseq_cs. Since context switches are
> > +      * asynchronous and are outside of the application control
> > +      * (not part of the restricted code scope), we temporarily switch
>
> Remove "we".
>
> > +      * to premissive pkey register to read/write rseq/rseq_cs,
>
> permissive
>
> > +      * similarly to signal delivery accesses to altstack.
> > +      *
> > +      * We don't bother to check if the failure really happened due to
>
> Remove "We".
>
> > +      * pkeys or not, since it does not matter (performance-wise and
> > +      * otherwise).
> > +      *
> > +      * If the restricted code installs rseq_cs in inaccessible to it
> > +      * due to pkeys memory,
>
> This sentence should be reworded.
>
>   we still let this function read the rseq_cs.
> > +      * It's unclear what benefits the resticted code gets by doing this
>
> restricted
>
> > +      * (it probably already hijacked control flow at this point), and
> > +      * presumably any sane sandbox should prohibit restricted code
> > +      * from accessing struct rseq, and this is still better than
> > +      * terminating the app unconditionally (it always has a choice
> > +      * of not using rseq and pkeys together).
>
> Note that because userspace can complete an rseq critical section
> without clearing the rseq_cs pointer, this could happen simply because
> the kernel is preempting the task after it has:
>
> 1) completed an rseq critical section, without clearing rseq_cs,
> 2) changed pkey.
>
> So allowing this is important, and I would remove the comment about
> hijacked control flow and such. This can happen with normal use of the
> ABI.

Thanks for the review!

I've addressed all comments in the series in v2.

I've reworded this paragraph to simplify sentences, but I still kept
the note aboud malicious rseq_cs.

If we would not be circumventing normal protection, then, yes, these
cases would be the same. But since we are circumventing protection
that otherwise exists, I think it's important to think about
potentially malicious cases. In this context inaccessible rseq_cs
values that resulted from normal execution are very different from
malicious onces. Normal ones will point to a fixed set of real
well-formed rseq_cs objects, while malicious ones may point to
god-knows-where in an attempt of an attacker to do things we can't
even imagine right now (e.g. rseq_cs overlapping with protected crypto
keys).

It's as if a particular instance of copy_to_user would allow
user-space to write arbitrary kernel memory, and memory of other
processes circumventing all normal protections. In that context we
would need to be very careful regarding what we actually allow.


> Thanks,
>
> Mathieu
>
>
> > +      */
> > +     if (!switched_pkey_reg) {
> > +             switched_pkey_reg = true;
> > +             saved = switch_to_permissive_pkey_reg();
> > +             goto retry;
> > +     } else {
> > +             write_pkey_reg(saved);
> > +     }
> >       sig = ksig ? ksig->sig : 0;
> >       force_sigsegv(sig);
> >   }
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

