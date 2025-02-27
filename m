Return-Path: <linux-kernel+bounces-536512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99BA48099
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CD83AEBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FBE2356B4;
	Thu, 27 Feb 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDGHYAu+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072922D4EB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665052; cv=none; b=haG7eUEDmc5FOY6nm9CUndBZbDTjPct+q6XsMzxFAztRm6XjyadW+kLE9ld1SBaDsaV7vIKsioAkfaG2eP60YamDafeXl0jr9+ft7WrXzYhcjI5Akwe92nx4RLNFVAfH68mTsbKLj5+zIey5cTl0eX7QkL4BR4CIL4rPi6FjIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665052; c=relaxed/simple;
	bh=XcusgTAVVQtlQDszlpacACpLjyuVO17dozRD5f1L3k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBTgLNLW6hph803SfSC0ICfIf1eAFmk0AN1wOKNL0sHK+HdPLKVFIfAtExm6b4dcVyu1ky96lfcxxvENntnvkw7wtPigHo4qg98tinr2zYkglxFKllfafxb44JRZaL3YSP65znH4SxQE5V6fTNPe6sEAm90eMyJoW9OoLHfNF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDGHYAu+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so11390281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665048; x=1741269848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKKnflOz1uXd9oW7+XvymAra511EF9561fZScXfE3GU=;
        b=tDGHYAu+2Evt7/YpUO/f1jNi45HP2lamvUMW31z8f94gP0aHa8ZrQSMaey9hOQy8xw
         GM/hgBJIXYZ7GqyO0GZoreEoCVqoWgDcpc8pNGm1l3PGix/WyfW4FWmpHh+IZyODf4f1
         +UfLQyeGuao6UEzE4VWstPrhL8daPF0RB/Af+1yk4sRRB4jGgnsfCx/cx4+B0bkaBZSP
         Wauv4NsnNwuFhj+saN4QrlaSSzO11fSTuRVyddS0hHNMyBSTUt/VLjvi2WaJeQVC405p
         bvLz7Dql91oQABOIhJtOeD6x6WOS0f5wU+j6pxqqNKpX+Io9QJz1YMcrlPyjX19B7ULN
         xUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665048; x=1741269848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKKnflOz1uXd9oW7+XvymAra511EF9561fZScXfE3GU=;
        b=PzlgnZ+xh/ewlaIPhF2armlgHIb+KRwwXpnS/ch83a5ki8XBvIHb+pW28EX6Khdp5A
         CFQFL/o8hSUZQGALA31665jKeF6QoKqUPIyBnI0aarXwOMkHdFM5wuHQRhnrh5QfZc3V
         AHIfY+3gYqNdcqX8MvrVjxsYjz5gbmWX5Eti+sNUXZIGoCHrlAayGHSp39hz9ZCGL111
         6+x6e/LJXvRjAlE8DY5EX04PLoAPsme7SpXx4GCY67C7Rp1DkTV3zx14uY8xgJBRoWpO
         WCZrWE+rdfn1cpApV1zHHc8ogT0Uv8VbjOmETAGjG5PemsgyGaQpO8C0SAGnb+Ypnt8O
         OJBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoZUDrLzBNxkzmWxcTxJQk6yT48nO/jKZL02qjZNkXtjQODu0RrPxuU7Krr1G7vY01jx6seGhLLKQUnLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCi8MI4dtinFiBwfdUby0OTO6ipzeSox1NuHtIZFsVaiPE4xy8
	7cva5JJj0oGYpWitSF+5ohK+rQ0mrWYE25RBRR1uTPTb8BeQ9GP3c7n8hR8tVpqZVEKrE+B6edF
	TtnFQaRag/ChFPHLV4FqVXdA+I/OS4Xf2zXk6
X-Gm-Gg: ASbGncsagxJK7fhon+pHc1z1WAkVNiDtpEfbq7wnskW8Pqm5eWsJeYgMF0O1kyY760e
	IlrEDBLnplDIykM5Xlhed2v9rLQ99I81bejeZluVIRuB5SxgXQUwwe2eTlejil+Bh98twPkqk4F
	WaO8UOremNiXLQlNy3Ft5t3oXORspdaYeZDnq/fg==
X-Google-Smtp-Source: AGHT+IHe4JRgV/AXWk2iKChTU3vlt6rAHD/eoARaP8995cpNVRNLmcWVz4Kk1TbPzJ8mac/89f9lwg/W5mjaHBksPB0=
X-Received: by 2002:a2e:9010:0:b0:2ff:a928:a23e with SMTP id
 38308e7fff4ca-30a5996d253mr100052531fa.25.1740665046222; Thu, 27 Feb 2025
 06:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com> <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
 <b18e6478-ef4b-42b3-8cc4-42467b3a0a7f@efficios.com> <CACT4Y+YxmkW6opFVJFOOFd=c73gz7yFvwBBCnjMndj-jffjBCw@mail.gmail.com>
 <b42dc8d7-2f2e-466f-bdca-0d532a0d5928@efficios.com> <CACT4Y+Y9RodZO7T2RSJGohwjAdgBktgySCvCZ9xaPdVJafYzJw@mail.gmail.com>
 <47797927-4d87-4101-9834-eac84d814114@efficios.com>
In-Reply-To: <47797927-4d87-4101-9834-eac84d814114@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 27 Feb 2025 15:03:54 +0100
X-Gm-Features: AQ5f1JquV_mA2fgEHq_JURCFhAk6sWwmYVgu0MrKtgOLTsV9gisl3Jh1mu0bNB0
Message-ID: <CACT4Y+bko9d_p8u1bd8434gLp-xXzeKxEBbsph-WZuXyN_LXFA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 15:53, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-02-25 09:51, Dmitry Vyukov wrote:
> > On Tue, 25 Feb 2025 at 15:28, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2025-02-25 09:07, Dmitry Vyukov wrote:
> >>> On Mon, 24 Feb 2025 at 20:18, Mathieu Desnoyers
> >>> <mathieu.desnoyers@efficios.com> wrote:
> >>>>
> >>>> On 2025-02-24 08:20, Dmitry Vyukov wrote:
> >>>>> If an application registers rseq, and ever switches to another pkey
> >>>>> protection (such that the rseq becomes inaccessible), then any
> >>>>> context switch will cause failure in __rseq_handle_notify_resume()
> >>>>> attempting to read/write struct rseq and/or rseq_cs. Since context
> >>>>> switches are asynchronous and are outside of the application control
> >>>>> (not part of the restricted code scope), temporarily switch to
> >>>>> pkey value that allows access to the 0 (default) PKEY.
> >>>>
> >>>> This is a good start, but the plan Dave and I discussed went further
> >>>> than this. Those additions are needed:
> >>>>
> >>>> 1) Add validation at rseq registration that the struct rseq is indeed
> >>>>       pkey-0 memory (return failure if not).
> >>>
> >>> I don't think this is worth it for multiple reasons:
> >>>    - a program may first register it and then assign a key, which means
> >>> we also need to check in pkey_mprotect
> >>>    - pkey_mprotect may be applied to rseq of another thread, so ensuring
> >>> that will require complex code with non-trivial synchronization and
> >>> will add considerable overhead to pkey_mprotect call
> >>>    - a program may assign non-0 pkey but have it always accessible, such
> >>> programs will break by the new check
> >>>    - the misuse is already detected by rseq code, and UNIX errno-based
> >>> reporting is not very informative and does not add much value on top
> >>> of existing reporting
> >>>    - this is not different from registering rseq and then unmap'ing the
> >>> memory, checking that does not look like a good idea, and checking
> >>> only subset of misuses is inconsistent
> >>>
> >>> Based on my experience with rseq, what would be useful is reporting a
> >>> meaningful siginfo for access errors (address/unique code) and fixing
> >>> signal delivery. That would solve all of the above problems, and
> >>> provide useful info for the user (not just confusing EINVAL from
> >>> mprotect/munmap).
> >>>
> >>> But I would prefer to not mix these unrelated usability improvements
> >>> and bug fixes with this change. That's not related to this change.
> >>
> >> I agree with your arguments. If Dave is OK with it, I'd be fine with
> >> leaving out the pkey-0 validation on rseq registration, and eventually
> >> bring meaningful siginfo access errors as future improvements.
> >>
> >> So the new behavior would be that both rseq and rseq_cs are required
> >> to be pkey-0. If they are not and their pkey is not accessible in the
> >> current context, it would trigger a segmentation fault. Ideally we'd
> >> want to document this somewhere in the UAPI header.
> >
> > Makes sense. I will wait for Dave comments/ack before sending v6. But
> > to save a round-trip, does this look reasonable?
> >
> > --- a/include/uapi/linux/rseq.h
> > +++ b/include/uapi/linux/rseq.h
> > @@ -58,6 +58,10 @@ struct rseq_cs {
> >    * contained within a single cache-line.
> >    *
> >    * A single struct rseq per thread is allowed.
> > + *
> > + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> > + * then the assigned pkey should either be accessible whenever these structs
> > + * are registered/installed, or they should be protected with pkey 0.
>
> The wording is OK with me.
>
> Thanks,
>
> Mathieu

Sent v6 with this documentation change.

> >    */
> >   struct rseq {
> >
> >
> >
> >>>> 2) The pkey-0 requirement is only for struct rseq, which we can check
> >>>>       for at rseq registration, and happens to be the fast path. For struct
> >>>>       rseq_cs, this is not the same tradeoff: we cannot easily check its
> >>>>       associated pkey because the rseq_cs pointer is updated by userspace
> >>>>       when entering a critical section. But the good news is that reading
> >>>>       the content of struct rseq_cs is *not* a fast-path: it's only done
> >>>>       when preempting/delivering a signal over a thread which has a
> >>>>       non-NULL rseq_cs pointer.
> >>>
> >>> rseq_cs is usually accessed on a hot path since rseq_cs pointer is not
> >>> cleared on critical section exit (at least that's what we do).
> >>
> >> Fair point.
> >>
> >>>
> >>>>       Therefore reading the struct rseq_cs content should be done with
> >>>>       write_permissive_pkey_val(), giving access to all pkeys.
> >>>
> >>> You just asked me to redo the code to simplify it, won't this
> >>> complicate it back again? ;)
> >>
> >> I'm fine with the pkey-0 approach for both rseq and rseq_cs if Dave is
> >> also OK with it.
> >
> > It should work for my current use case, at least how I currently see
> > it. Ways people use pkeys are pretty unique, so it's hard to
> > extrapolate. But there is one more possibility: when a program
> > switches PKEYs, it may also clear stale rseq_cs pointer from rseq.
> > This way rseq_cs may have non-0 keys assigned, but they are always
> > accessible while installed.
> >
> >
> >
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>>
> >>>
> >>>> Thanks,
> >>>>
> >>>> Mathieu
> >>>>
> >>>>>
> >>>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
> >>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>>> Cc: Ingo Molnar <mingo@redhat.com>
> >>>>> Cc: Borislav Petkov <bp@alien8.de>
> >>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >>>>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >>>>> Cc: x86@kernel.org
> >>>>> Cc: linux-kernel@vger.kernel.org
> >>>>> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >>>>>
> >>>>> ---
> >>>>> Changes in v4:
> >>>>>     - Added Fixes tag
> >>>>>
> >>>>> Changes in v3:
> >>>>>     - simplify control flow to always enable access to 0 pkey
> >>>>>
> >>>>> Changes in v2:
> >>>>>     - fixed typos and reworded the comment
> >>>>> ---
> >>>>>     kernel/rseq.c | 11 +++++++++++
> >>>>>     1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
> >>>>> index 2cb16091ec0ae..9d9c976d3b78c 100644
> >>>>> --- a/kernel/rseq.c
> >>>>> +++ b/kernel/rseq.c
> >>>>> @@ -10,6 +10,7 @@
> >>>>>
> >>>>>     #include <linux/sched.h>
> >>>>>     #include <linux/uaccess.h>
> >>>>> +#include <linux/pkeys.h>
> >>>>>     #include <linux/syscalls.h>
> >>>>>     #include <linux/rseq.h>
> >>>>>     #include <linux/types.h>
> >>>>> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> >>>>>     void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>>>>     {
> >>>>>         struct task_struct *t = current;
> >>>>> +     pkey_reg_t saved_pkey;
> >>>>>         int ret, sig;
> >>>>>
> >>>>>         if (unlikely(t->flags & PF_EXITING))
> >>>>>                 return;
> >>>>>
> >>>>> +     /*
> >>>>> +      * Enable access to the default (0) pkey in case the thread has
> >>>>> +      * currently disabled access to it and struct rseq/rseq_cs has
> >>>>> +      * 0 pkey assigned (the only supported value for now).
> >>>>> +      */
> >>>>> +     saved_pkey = enable_zero_pkey_val();
> >>>>> +
> >>>>>         /*
> >>>>>          * regs is NULL if and only if the caller is in a syscall path.  Skip
> >>>>>          * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> >>>>> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>>>>         }
> >>>>>         if (unlikely(rseq_update_cpu_node_id(t)))
> >>>>>                 goto error;
> >>>>> +     write_pkey_val(saved_pkey);
> >>>>>         return;
> >>>>>
> >>>>>     error:
> >>>>> +     write_pkey_val(saved_pkey);
> >>>>>         sig = ksig ? ksig->sig : 0;
> >>>>>         force_sigsegv(sig);
> >>>>>     }
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

