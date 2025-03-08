Return-Path: <linux-kernel+bounces-552416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99293A579A7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2097F1895A5E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6781AF0BA;
	Sat,  8 Mar 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hl0HnRKx"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B61624C0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428025; cv=none; b=ged2qosatD6FNWEPX0/C0PN+6NgRvI/EtzwhsYZXn2gu8LZOptyQBmoNPhQMEm8oSqmsG0rx18ZM9B2NuV3UTiX8ImNq1uCqRHChyHbJGe1A0exoFmEmcxnw/BHTF70KcsjN4cGUawduKkKQQw0slaN08bOFhWEXj0uIUqxum/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428025; c=relaxed/simple;
	bh=UWpfiX3eWSLlfomPYZ++NjpgdIvAWNwdxsvyoksscO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsJf0+5EKz/rWY9Jj4m1KIU3PRTtz2+js+Iu9OwwCFqbmmx4hJTGOj/eli/cTLk/U3tECKuNkcbIPOuJPTZW/PRWVejpRG998Iu0t2rfdhzij1ne2TDLSGas8zWLSnQWl8/SoPDz+VzPAVQ9/XpzOTvSWkSyuC6B9vmbGC8P5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hl0HnRKx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a59so29252181fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741428021; x=1742032821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S6uIFtQrYeT1tKei1G8u36mCk/72dHjWycWuDYe5TJo=;
        b=hl0HnRKxbZvV/DGqTpR51gxj+Ec93Z+weei0g8E5ZuFFycVoQ3DO8oce7iGhfh3klu
         WtouGZZwz9M1fmRBvm3kHIbcRwZ2MVEVTuz9VVszkYw7sWvVmjaTLg2fcjZFSiZ5meef
         j9wbHAnDlGEXluID1AhtItBXHmvJNL5PlGvFZFwMj5cKB79WvuQfXBxaVcffRgnB+XKb
         +Uc3Zc1Ypd9i+jnBK8trTH9XNeHKCEw3S8xdOCQ6CwZPg3Evnpn6uOB0mKOAZpH8v/7B
         9nf8x24XhTUhV6l2U5q1YQXZPUxyb5jrv4QCzhIWMqB2HzIdhREl8MOsHmSeimt9Reha
         oxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741428021; x=1742032821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6uIFtQrYeT1tKei1G8u36mCk/72dHjWycWuDYe5TJo=;
        b=mDmILT/rlN4L+E67KRmIfIBGLY5kdmWYPzf3wPhs6k9gtBfN7yKMjOw77FUTEOPAz5
         MYoLd3kxgawMGDyesEuUwulwxMNEp4uCXGwHvqkiZ79HRe+tpU9BZYaMBww15ISQ+tX7
         pSbWOmcBhoPzGU5N8GNJxBLaDI6qAKV8B3YOOjnGAWgkSQ8wAd17T6AgZiBqum68M89s
         EyUKH2GM5G1RuNW3q2x82B1snSP0g9/Xol5J39XXIa3LAWZcfGtFJidr1zPsYee+r5Pu
         E4gjpAV5PySwv7k5BK0J1rwIVTu+qZQUmCySIzoOZ9tr4kIusO+YxAqXFyw5Si5WdoT9
         K1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTuus+Qa8cKxsB58TnxqqlCv0nIMvXcNySWqGMfdQilAb+r+dYTEbQprVMNhyt2KxRxiVFmQaR0En9Bi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwToRhOTc8OXBuTv8BP16hUSnhmVJnnMPFMQJ5A4wlTxporTnOo
	gi1weluYp0tja0nkSaEudcBBBwcUbNxUFoptwtM78FJDrSSU/bBTKAJAskTQoHxj0X/jUF5nu2a
	SKMqBvVQ6LQSADOu+imApB/Xa9UXll+7honYp
X-Gm-Gg: ASbGncsgnvSw7FTPYWYmWAdrtj9DWx++b8s8WLpfz1hKWum6/tcERVYyd98A1033XlJ
	w0XU1KiU9wUbkbu6S27jfz2ejcYe3wm7F5rr/Qpl/CFeue8jI7dcGIjIo4ELxX7Avau92JlAOmM
	eMJiTsVH6pH/NqhGY/lZ2fyCHulv6O5YmZVF92ERmsjp98GdUwiBMCqJZkIBU=
X-Google-Smtp-Source: AGHT+IGubJbShcjmCRUedp5qeK9lj9GO7ly63pW0lnJcLUADqEY1POvXRWv6pq0XOWUwnIOiEph5l1yi5O9HRTF94aY=
X-Received: by 2002:a2e:be0b:0:b0:30b:f94a:a954 with SMTP id
 38308e7fff4ca-30bf94aaadcmr15062121fa.16.1741428020691; Sat, 08 Mar 2025
 02:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740386567.git.dvyukov@google.com> <de940218d0a59fd930ec244d87f2375b16a7815a.1740386567.git.dvyukov@google.com>
In-Reply-To: <de940218d0a59fd930ec244d87f2375b16a7815a.1740386567.git.dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 8 Mar 2025 11:00:09 +0100
X-Gm-Features: AQ5f1JrAEz7lXTf4cBw6xQrjreG3r9oBNgidQ3LzkVQ4BJP7tZn6D1JDrFSyKyQ
Message-ID: <CACT4Y+baLmcJ=vrcaTmPFTsspYO_WvrQ=uTOnfcbagvK9bz3Vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] syscall_user_dispatch: Allow allowed range wrap-around
To: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com
Cc: Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 09:45, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> There are two possible scenarios for syscall filtering:
>  - having a trusted/allowed range of PCs, and intercepting everything else
>  - or the opposite: a single untrusted/intercepted range and allowing
>    everything else
> The current implementation only allows the former use case due to
> allowed range wrap-around check. Allow the latter use case as well
> by removing the wrap-around check.
> The latter use case is relevant for any kind of sandboxing scenario,
> or monitoring behavior of a single library. If a program wants to
> intercept syscalls for PC range [START, END) then it needs to call:
> prctl(..., END, -(END-START), ...);
> which sets a wrap-around range that excludes everything
> besides [START, END).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gregory Price <gregory.price@memverge.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-kernel@vger.kernel.org

Any remaining concerns with this series?

Are syscall_user_dispatch patches pulled via x86 tree?

> ---
>  kernel/entry/syscall_user_dispatch.c | 9 +++------
>  kernel/sys.c                         | 6 ++++++
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 5340c5aa89e7d..a0659f0515404 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -37,6 +37,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>         struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>         char state;
>
> +       /* Note: this check form allows for range wrap-around. */
>         if (likely(instruction_pointer(regs) - sd->offset < sd->len))
>                 return false;
>
> @@ -80,13 +81,9 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
>                 break;
>         case PR_SYS_DISPATCH_ON:
>                 /*
> -                * Validate the direct dispatcher region just for basic
> -                * sanity against overflow and a 0-sized dispatcher
> -                * region.  If the user is able to submit a syscall from
> -                * an address, that address is obviously valid.
> +                * Note: we don't check and allow arbitrary values for
> +                * offset/len in particular to allow range wrap-around.
>                  */
> -               if (offset && offset + len <= offset)
> -                       return -EINVAL;
>
>                 /*
>                  * access_ok() will clear memory tags for tagged addresses
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cb366ff8703af..666322026ad72 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2735,6 +2735,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                 error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>                 break;
>         case PR_SET_SYSCALL_USER_DISPATCH:
> +               /*
> +                * Sign-extend len for 32-bit processes to allow region
> +                * wrap-around.
> +                */
> +               if (in_compat_syscall())
> +                       arg4 = (long)(s32)arg4;
>                 error = set_syscall_user_dispatch(arg2, arg3, arg4,
>                                                   (char __user *) arg5);
>                 break;
> --
> 2.48.1.601.g30ceb7b040-goog
>

