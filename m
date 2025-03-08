Return-Path: <linux-kernel+bounces-552418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C4A579AB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9F116EFCB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716121AAA0F;
	Sat,  8 Mar 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsoLRz2Z"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BD1624C0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428146; cv=none; b=egRYcLVTGjIErGDTig2/y9fidb5l9NPcwlQb/VrpuFOLg3XIWCLlcUSx92Qbl1MbFCmEwaDuXE7okGQ0H/UKsbHO7J0nUn5D4FqxPFPp+aWBtC0xDOEjcRUEvjPtU0FfdsoUOKvbxPKUlvJQc0qXIlyqIogNW8pnRdGkWN5zago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428146; c=relaxed/simple;
	bh=dBQyyL3vL1C2U+hw5avKU2W2uQl0ffo6ReVMWCh8v00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrzcoDuBs8uKw4XdKGcHSm9Cr+c2mmzyQhVJ3RXLCiOWVs/4gckWQee0imhp1+kNu2093LR/VByoIzxJVGj7Wxc3yzACQl61pp5vtaMoPidQ0gjS/xW6xdXfW9UavL+50L5IrjAzALSJZVwwqdOe3NuE/9tkZYOKjYpN6INbgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsoLRz2Z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-548430564d9so2902494e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741428143; x=1742032943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0iByLy4aSrR5QfjhqE9ehl4b8VA7AQ4/ftXBtZEPWvc=;
        b=KsoLRz2ZuqhN2jrLBx7UyUsmMr1Q04rAGWr1t+Uy7USRZgDZ1ASg0+9OKyGgBHKj3/
         NcHSyMgy4HreWWg6tYeUfgIWLUBhK+9EYdAlOcdnj33bFC9anvAoWvdUwAAEOSqeyfjJ
         /ZzBSN+o8em8rIIDpU/llPYkIt5QOL6BBrHTvJv42f3/jBgw68fQXDfqrSVfA4USZe2n
         GpIOPo5t3Udvqogz5/U9413PiP7qwMn0/wXN4BU9PLG6dqvYAbQzKuTOtK+T26fUbBym
         11xRtkhYfamZ0trbCeXU6DAe8ZtN2WG4oMord3eIIbb3eswHEJaQJNQvEzz8bzaKUcI0
         76YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741428143; x=1742032943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iByLy4aSrR5QfjhqE9ehl4b8VA7AQ4/ftXBtZEPWvc=;
        b=Urudv2qhcmQpqOnMf32h0EXuDyL2/hGNJIglLcnq62ojMYBBaSVwDaTuVy0qRLmlca
         BqmfLXKnNydX3Fj+TqI4rH9LnttxPd/NiJsRfP8NStMIjnTTqk8ztb99iZEHy377RBFE
         J+CjPP6G7ZTOUvf7mHN+5SHjf6MMBwPeeX11FNA8iQ2jX5frCKOtTHcJ/afR9i9Ci4m5
         U0wkw52D67mAHo80UWfKC9h5QfJqDHi99reWdskWvRND6Jnnru/Smri7ih2Ub0S6y4Yk
         hLyigQRCqsihn3tw+0cy9OPrOWTlO1VGH+H6QMAzJXosqRsFpk5+AEZVApLNG0JsDryA
         knxw==
X-Forwarded-Encrypted: i=1; AJvYcCVzUH2nPF1DccxuFZppgCxhwcdwICQ/irulNO07e/SwQAbVK8N8uJkW5eMDnszEsuj4WX2wJpdn5jZMRxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyprcSdMFqNeRGju2gJTl3y12DfNqdDi6y4ivx53ucxmq1ybgH
	e2tcSY2x7lKJb5XtZlbImy/j+95zvmJZcRecFFfvFL1Y+ciaJ/5WDHbwc01wInofYSKWK+cAf+I
	dFrvjf/+v3FPymUA2Lcvb0zi6cHSd7tfaiOnO
X-Gm-Gg: ASbGncvyb1vzQcx1Lyv/YDRnDxXk9ovVcE/MjkJkllb5+Y4IBdro1OpQhcu4K/Yf0XP
	cI3IHQbf1Chpkr3LTeUgkGpl6Js6/vvtBsR37dvs9kxwi0PuLg2Yae5UN25SuvVITbt9mUjvLcq
	+0nBJTsYvSspDcJUQomA44eNDsEhmV6W6atgXl0OaHsL6mewGtYlbM4GwB1+Y=
X-Google-Smtp-Source: AGHT+IGnJHNIzytVFWJfy8RYeXOpRM/tNm6CZsZEWZPJJRrsa4X6j5gMAWfnhfq9BEgIS7pBNQO+WvWqhtKwQzUXXQY=
X-Received: by 2002:a05:6512:ad1:b0:549:7d6d:3db6 with SMTP id
 2adb3069b0e04-54990e672fbmr2690678e87.23.1741428142738; Sat, 08 Mar 2025
 02:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com> <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
In-Reply-To: <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 8 Mar 2025 11:02:11 +0100
X-Gm-Features: AQ5f1Jq9J4cnkVBX-EZ1Lgmd2ZIeq0_cd3j6WuKCRtc1QBPwemOAwp8enxxxs4c
Message-ID: <CACT4Y+bxV-keWg6-NGnA2k039gzMf_9COCe+zQWpcup8bMhToQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] rseq: Make rseq work with protection keys
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 15:03, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily switch to
> pkey value that allows access to the 0 (default) PKEY.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

Any remaining concerns with this series?

What tree should it go into?

> ---
> Changes in v6:
>  - Added a comment to struct rseq with MPK rules
>
> Changes in v4:
>  - Added Fixes tag
>
> Changes in v3:
>  - simplify control flow to always enable access to 0 pkey
>
> Changes in v2:
>  - fixed typos and reworded the comment
> ---
>  include/uapi/linux/rseq.h |  4 ++++
>  kernel/rseq.c             | 11 +++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac90..019fd248cf749 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -58,6 +58,10 @@ struct rseq_cs {
>   * contained within a single cache-line.
>   *
>   * A single struct rseq per thread is allowed.
> + *
> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> + * then the assigned pkey should either be accessible whenever these structs
> + * are registered/installed, or they should be protected with pkey 0.
>   */
>  struct rseq {
>         /*
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 2cb16091ec0ae..9d9c976d3b78c 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>  #include <linux/syscalls.h>
>  #include <linux/rseq.h>
>  #include <linux/types.h>
> @@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>  void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  {
>         struct task_struct *t = current;
> +       pkey_reg_t saved_pkey;
>         int ret, sig;
>
>         if (unlikely(t->flags & PF_EXITING))
>                 return;
>
> +       /*
> +        * Enable access to the default (0) pkey in case the thread has
> +        * currently disabled access to it and struct rseq/rseq_cs has
> +        * 0 pkey assigned (the only supported value for now).
> +        */
> +       saved_pkey = enable_zero_pkey_val();
> +
>         /*
>          * regs is NULL if and only if the caller is in a syscall path.  Skip
>          * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>         }
>         if (unlikely(rseq_update_cpu_node_id(t)))
>                 goto error;
> +       write_pkey_val(saved_pkey);
>         return;
>
>  error:
> +       write_pkey_val(saved_pkey);
>         sig = ksig ? ksig->sig : 0;
>         force_sigsegv(sig);
>  }
> --
> 2.48.1.658.g4767266eb4-goog
>

