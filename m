Return-Path: <linux-kernel+bounces-554451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF0A597E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FEE1883B68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7B22B8AF;
	Mon, 10 Mar 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiXPzjX1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B022576A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617565; cv=none; b=HkJL36eoCa3KkPl4JQ3IpEnQzNnVupcX1neU/YE4uxqaDOVtXbCtCc2gaz+vpShWJ+GAcrVzXPJDEZGW8wbbnV6lDYl9hzRsGv0w7/eJA4/9L3YnjYmjuDIcAfglL7Dmunmyd7SFFLm6cBdA3IvTqvSFMJZZ/4kWwWYdujtnFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617565; c=relaxed/simple;
	bh=tnTJiZPz2ufHQUuirbZx8UKcD03ja78KjLyAgJf9EO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfe5oukXXY5Hgi5enWRdcWhayw1lVNoEirH3uy6K/dDI9U5b8zts0yDSBsHKtqz9I9kuct1LXcgIAF7+0iG36O4wfaZo5REUGAvZaNTlm+nrmGGGZj5XDuu1ID3f/zwF1qA7rO4nMKRJh/jKZ9M/ZEXWEMZdRJG++5jUGG73xC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiXPzjX1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bf8632052so30286681fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741617561; x=1742222361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RFWBA9JER4UT7QvrwlvRn6vyweHG/A4vT9DO9mBKj+o=;
        b=QiXPzjX1TXFSAuA88hmzlgeD8cCJHD0JG5K1zPbJp9Pay3zUz7sEF2HJCqOaaFoO5J
         6P03P8EpcAYh82wYNcjr8NinZwpYiuBxk+y+gCTc6Jl21+K1DaXPKMTa2KbmnzQVKNLR
         ItHsVjLPj+d4wH6MYHWTl3HM2SjuqqAAE0pecXVysmESIT5NuDT42dCHqJmcKaIPeseB
         P1SQJx3xyryJyv+aREBhr4sgvGHoy6PrPM9fbH+VZvV8LAXM/o1MFGf4zhhBmUA1TcqI
         X9VvxomdIB372aFLNHMB742CA5Ke49sXPERCbYQlfvRdBs8EttfXhy7TnTMrTbhrMc8R
         wwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617561; x=1742222361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFWBA9JER4UT7QvrwlvRn6vyweHG/A4vT9DO9mBKj+o=;
        b=Ez5UJ4a66mtoFgIMofl9Gbm9dvtjg67USBhKL3twoyz0ddMf4U8mPrWg5SNsyo7IG6
         3TUBi/S/EnURBKQIsd05sJjWqhI6Slok1ZqFEhs8O7xsNvBymxWhRSjqc+wSl4lcrJTc
         9RnUeGWPFDm12m6NmLriTiCDoQv2x66ND3XvkJxwKXOvo3VvQxlTgBxFsPaQQ/3Sw3XE
         C4Uy8BEEAfM1OVUafFWo9ZmbiF32m8dHY6wej4Xv6Mfe+LH0npqzndnak5ypIbRgIaHB
         l9S72gyHM/uKVMe6mXpOLF66RwkwGl9awtn3a6sxwdqcCrXcewd5VGd1CYRzcq5oe6eq
         U9eg==
X-Forwarded-Encrypted: i=1; AJvYcCXaQeLCLDO6Dq1PdHbwPsaHOgoAzXpCLZVv/8Jb+HqzKGwr2i4xsgr3bzBoTEcMq5QIrQG6IBZ93PVFhi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadxFSk70vl9+JzxUEWFIXm0L6ZEct63oeiI8I0/IEf6+TuhZu
	rmWWRC2BwQ9t1wj2gNWRdFrn5KnKbY9Ptt3C65x5bXdXHG320v8UjJ23dm/dNfCfDYqhbndt1Mc
	2Buzxb5U3NXQfykHk+0mWkiIp9uedIyaNm5Ll
X-Gm-Gg: ASbGncv+DjqSkAxyJJwC7VIZbT8X2mfXUaQP8ibHeit4GTLMt6uk4N7ukYR6Hwf7R4X
	YKKTmPlXXcYd2nxMHSCv0SLWP7Sv7W4bMcmWFI4IbF1vqdCzeLk9kAohXrTLR4UwyJfFSmZrfXH
	vAoToWgM57yYWchcGc76o7ej+j
X-Google-Smtp-Source: AGHT+IG0Maa20eIeuxqPEC+leLaOQVIVmOmxTsk6+h5XXrjyAulVd3ZiS+LpX3uALwiPdheQPNG8xi3F87OXmII2qxo=
X-Received: by 2002:a2e:7207:0:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-30bf461caecmr42892931fa.37.1741617561081; Mon, 10 Mar 2025
 07:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com> <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
 <CACT4Y+bxV-keWg6-NGnA2k039gzMf_9COCe+zQWpcup8bMhToQ@mail.gmail.com> <28358cb6-135b-4126-ab80-f2e2d0cb4389@efficios.com>
In-Reply-To: <28358cb6-135b-4126-ab80-f2e2d0cb4389@efficios.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 10 Mar 2025 15:39:06 +0100
X-Gm-Features: AQ5f1JofYVYwCPxisde6nRNiMf22HlK5cgDqZ-xmWwQBvJJpQttEsdotumD_WAk
Message-ID: <CACT4Y+Zip7O1gAF9atqib52UnEhs4K7+4hkL2xpnwYt34eqMeA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rseq: Make rseq work with protection keys
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	aruna.ramakrishna@oracle.com, elver@google.com, 
	"Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 15:31, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-03-08 05:02, Dmitry Vyukov wrote:
> > On Thu, 27 Feb 2025 at 15:03, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> If an application registers rseq, and ever switches to another pkey
> >> protection (such that the rseq becomes inaccessible), then any
> >> context switch will cause failure in __rseq_handle_notify_resume()
> >> attempting to read/write struct rseq and/or rseq_cs. Since context
> >> switches are asynchronous and are outside of the application control
> >> (not part of the restricted code scope), temporarily switch to
> >> pkey value that allows access to the 0 (default) PKEY.
> >>
> >> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> >> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Boqun Feng <boqun.feng@gmail.com>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Borislav Petkov <bp@alien8.de>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >> Cc: x86@kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >
> > Any remaining concerns with this series?
> >
> > What tree should it go into?
>
> Usually the rseq bits go through the -tip tree.

Thomas, Ingo, can you please take this to -tip tree? Or who would that be?


> Thanks,
>
> Mathieu
>
> >
> >> ---
> >> Changes in v6:
> >>   - Added a comment to struct rseq with MPK rules
> >>
> >> Changes in v4:
> >>   - Added Fixes tag
> >>
> >> Changes in v3:
> >>   - simplify control flow to always enable access to 0 pkey
> >>
> >> Changes in v2:
> >>   - fixed typos and reworded the comment
> >> ---
> >>   include/uapi/linux/rseq.h |  4 ++++
> >>   kernel/rseq.c             | 11 +++++++++++
> >>   2 files changed, 15 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> >> index c233aae5eac90..019fd248cf749 100644
> >> --- a/include/uapi/linux/rseq.h
> >> +++ b/include/uapi/linux/rseq.h
> >> @@ -58,6 +58,10 @@ struct rseq_cs {
> >>    * contained within a single cache-line.
> >>    *
> >>    * A single struct rseq per thread is allowed.
> >> + *
> >> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> >> + * then the assigned pkey should either be accessible whenever these structs
> >> + * are registered/installed, or they should be protected with pkey 0.
> >>    */
> >>   struct rseq {
> >>          /*
> >> diff --git a/kernel/rseq.c b/kernel/rseq.c
> >> index 2cb16091ec0ae..9d9c976d3b78c 100644
> >> --- a/kernel/rseq.c
> >> +++ b/kernel/rseq.c
> >> @@ -10,6 +10,7 @@
> >>
> >>   #include <linux/sched.h>
> >>   #include <linux/uaccess.h>
> >> +#include <linux/pkeys.h>
> >>   #include <linux/syscalls.h>
> >>   #include <linux/rseq.h>
> >>   #include <linux/types.h>
> >> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> >>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>   {
> >>          struct task_struct *t = current;
> >> +       pkey_reg_t saved_pkey;
> >>          int ret, sig;
> >>
> >>          if (unlikely(t->flags & PF_EXITING))
> >>                  return;
> >>
> >> +       /*
> >> +        * Enable access to the default (0) pkey in case the thread has
> >> +        * currently disabled access to it and struct rseq/rseq_cs has
> >> +        * 0 pkey assigned (the only supported value for now).
> >> +        */
> >> +       saved_pkey = enable_zero_pkey_val();
> >> +
> >>          /*
> >>           * regs is NULL if and only if the caller is in a syscall path.  Skip
> >>           * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> >> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >>          }
> >>          if (unlikely(rseq_update_cpu_node_id(t)))
> >>                  goto error;
> >> +       write_pkey_val(saved_pkey);
> >>          return;
> >>
> >>   error:
> >> +       write_pkey_val(saved_pkey);
> >>          sig = ksig ? ksig->sig : 0;
> >>          force_sigsegv(sig);
> >>   }
> >> --
> >> 2.48.1.658.g4767266eb4-goog
> >>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

