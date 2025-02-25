Return-Path: <linux-kernel+bounces-531559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17998A44218
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE6A3B2641
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11B269D16;
	Tue, 25 Feb 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPv+uyUK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6720E6E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492468; cv=none; b=Jm/oxn3iQ806Ht1dOtHAav6/40oHrPoivHYryJ1pWr/cTthdB2CRyOB8rdR/gBvwqp4cxeG6ymXkJT7ViXjD5TbBTBm9hVEToAXiSnbeQwwrHA/J4icaicMLgCZkB8JkBYDbPSQ04f7vApK9/zCxmASNu1SNf9SfYeNuunbGoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492468; c=relaxed/simple;
	bh=1a3uoNWYcA34lM2e0glAXOZcpPFOXHmyG4bMGPN4TRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VolQRDOztHAu2omv1AlK77ZcWs85e/tz7bOkHMN+1f4WzUeHLvmqSGG5xKA1W7ynYz+uENUFrno0R+p1w6Q+VhEKdPXVdwayFEAWla2c8hEKEa+Ypuz9KW6V9j06ubXZPAQBcitOvy88YLkiYSaKOra2gL3M9BCmWtNutunML8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPv+uyUK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so62876801fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740492464; x=1741097264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jI28IyEOGDbLPM685Px+YI1ZQ05mVrpyqFP3VNNwkCY=;
        b=tPv+uyUKO0ISOzsdeomwSVwr9ot0tBuTOmkAIRH3LtjXAW89koMn3Pxr+miOXTQeeV
         RQk3bRjhn/IiTB26KsNVVKcADqdGmQ/x6Dwg3htHVdt7g/GraUQII22d6aonSBYt7nM0
         JN7O38NxRJuMsqQ3O3qnaENEKOlpqLQivuHoGIUA5GGs1nXDWBv1Qdqov+iPkhYurOKF
         VdQ3vD+AUGlOYsTU9OuSBCnxhZQsdeajPf0rtybm+uuFWGMtSkKYRuoXgd5D1sB+F5n8
         oDR2YwbfvyB2y9EhRvIeGNtRr+V+fn7xSUwX1EJ8oyBhhjDKWVii3UOwlPJJEuanr+Le
         jPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492464; x=1741097264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jI28IyEOGDbLPM685Px+YI1ZQ05mVrpyqFP3VNNwkCY=;
        b=vBDmENSvzkBXRQBy176et882NbTq0lCpEHbW5+aRpvxrsPNpzaKBAel11i+XRrFBEo
         +RgoujLVIhCdL6B9edy9QQhtrt4/pSknFLe0Pyzv3CKzRJp/vxAqRUk1enFNjRVyUYYp
         QPKMF+d1I4bI6m/Wvtiw59+oQfWjESdDhX/ra//j+51EpCXgeL2RJ1sOozNVfdayJPoO
         aIctaZALdiaVVz8gSfaCdyCSGCqDe+RbSphAgUP6f+yyh27KZRumwXjEMJ/kkv3nKCkg
         OgkIocWC69O30+Kmx+TKcbJ47/CTwjr/nPgUP8jgoV3Hx/5GqawrhcxxpgRqoRwz03qx
         FQmg==
X-Forwarded-Encrypted: i=1; AJvYcCVEPCgz4/mKZECG6gv0pHKFNRQjoLvjQ/kq/uaM2q/ZvNgb53R+upLWszcowYzLuoFASQHEaOyUU07hAoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKou4Fso5c3cEEfkw0MWefHX4kbgCqsmnEB+uck2MOATdEX1nF
	KXsIBfgpmZ5qqO0e3B7kbAtHFlSeUp3DD67fj1L/9ep3D/6GEdo6HCDnvGVn2vgpVOXVtscLg+L
	ULrxaB+72XRMW8Sd1jCPZVn+f6KCqF1J08+Fz
X-Gm-Gg: ASbGncuZiX1kKqJu9EXo+znuAXQ8vfflTnfM5yWm1LmN+5H21GF5mhYwxYwGoXrLG+k
	03Fk9XRtosqKHHiTqIbl1XMkShttp6bCMxE8S92WgLuihmuiLZyA/9XwaVMWLl2+Xyj3GKDCZ+u
	9FirtXspsf/7Cpd62rlXwqutnDemTDWAex3hOCNuXi
X-Google-Smtp-Source: AGHT+IHQ+vhhmMPb6EA0f2fgaQTMOZyyjGF2ZLXvxLwWoaYyS5QUYnVj6I3WMQEE/0NQy3Q87doFFueSeFCyn1CJPDo=
X-Received: by 2002:a2e:a166:0:b0:302:2598:dec2 with SMTP id
 38308e7fff4ca-30a59895c20mr53121261fa.14.1740492464197; Tue, 25 Feb 2025
 06:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com> <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
 <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com>
In-Reply-To: <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 25 Feb 2025 15:07:31 +0100
X-Gm-Features: AQ5f1Jr7rbSB-TX1SNksww5jhAmqwe20zBDuR3Mo8TYalrSQ-qI6Qb5gd6H-u_8
Message-ID: <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 20:18, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-24 08:20, Dmitry Vyukov wrote:
> > If an application registers rseq, and ever switches to another pkey
> > protection (such that the rseq becomes inaccessible), then any
> > context switch will cause failure in __rseq_handle_notify_resume()
> > attempting to read/write struct rseq and/or rseq_cs. Since context
> > switches are asynchronous and are outside of the application control
> > (not part of the restricted code scope), temporarily switch to
> > pkey value that allows access to the 0 (default) PKEY.
>
> This is a good start, but the plan Dave and I discussed went further
> than this. Those additions are needed:
>
> 1) Add validation at rseq registration that the struct rseq is indeed
>     pkey-0 memory (return failure if not).

I don't think this is worth it for multiple reasons:
 - a program may first register it and then assign a key, which means
we also need to check in pkey_mprotect
 - pkey_mprotect may be applied to rseq of another thread, so ensuring
that will require complex code with non-trivial synchronization and
will add considerable overhead to pkey_mprotect call
 - a program may assign non-0 pkey but have it always accessible, such
programs will break by the new check
 - the misuse is already detected by rseq code, and UNIX errno-based
reporting is not very informative and does not add much value on top
of existing reporting
 - this is not different from registering rseq and then unmap'ing the
memory, checking that does not look like a good idea, and checking
only subset of misuses is inconsistent

Based on my experience with rseq, what would be useful is reporting a
meaningful siginfo for access errors (address/unique code) and fixing
signal delivery. That would solve all of the above problems, and
provide useful info for the user (not just confusing EINVAL from
mprotect/munmap).

But I would prefer to not mix these unrelated usability improvements
and bug fixes with this change. That's not related to this change.


> 2) The pkey-0 requirement is only for struct rseq, which we can check
>     for at rseq registration, and happens to be the fast path. For struct
>     rseq_cs, this is not the same tradeoff: we cannot easily check its
>     associated pkey because the rseq_cs pointer is updated by userspace
>     when entering a critical section. But the good news is that reading
>     the content of struct rseq_cs is *not* a fast-path: it's only done
>     when preempting/delivering a signal over a thread which has a
>     non-NULL rseq_cs pointer.

rseq_cs is usually accessed on a hot path since rseq_cs pointer is not
cleared on critical section exit (at least that's what we do).

>     Therefore reading the struct rseq_cs content should be done with
>     write_permissive_pkey_val(), giving access to all pkeys.

You just asked me to redo the code to simplify it, won't this
complicate it back again? ;)


> Thanks,
>
> Mathieu
>
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
> > Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >
> > ---
> > Changes in v4:
> >   - Added Fixes tag
> >
> > Changes in v3:
> >   - simplify control flow to always enable access to 0 pkey
> >
> > Changes in v2:
> >   - fixed typos and reworded the comment
> > ---
> >   kernel/rseq.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index 2cb16091ec0ae..9d9c976d3b78c 100644
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
> > @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> >   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >   {
> >       struct task_struct *t = current;
> > +     pkey_reg_t saved_pkey;
> >       int ret, sig;
> >
> >       if (unlikely(t->flags & PF_EXITING))
> >               return;
> >
> > +     /*
> > +      * Enable access to the default (0) pkey in case the thread has
> > +      * currently disabled access to it and struct rseq/rseq_cs has
> > +      * 0 pkey assigned (the only supported value for now).
> > +      */
> > +     saved_pkey = enable_zero_pkey_val();
> > +
> >       /*
> >        * regs is NULL if and only if the caller is in a syscall path.  Skip
> >        * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> > @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >       }
> >       if (unlikely(rseq_update_cpu_node_id(t)))
> >               goto error;
> > +     write_pkey_val(saved_pkey);
> >       return;
> >
> >   error:
> > +     write_pkey_val(saved_pkey);
> >       sig = ksig ? ksig->sig : 0;
> >       force_sigsegv(sig);
> >   }
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

