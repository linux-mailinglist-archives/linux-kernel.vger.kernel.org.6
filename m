Return-Path: <linux-kernel+bounces-420906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7019D8591
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FDEB3AE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4C1991D9;
	Mon, 25 Nov 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrGMFYhN"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B21990CE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533574; cv=none; b=Y94NnynN802CyrDS6pXmSt851xvv4+z7QkYYD1V21UI47dOc5jIQNRGh6YzSknIXhftiGZXsgOB1/jg2kNIGjtz/XzdbVVGENaXYXA7T0/2Fynogv/K0fEBPl1iFU4c/XOwI7SHwM8W8tze3vryAIsImdRNCkAIA87sHk4gvpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533574; c=relaxed/simple;
	bh=Odxo28YgY8IxCqvnmsPfSmoQ/gO7glAU6dllmdvSMgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJD89Lr6k8AEh4VPLn6+eWZ0mzOYC/3E53WBvWq5th3BJKbGnbMNAQmn/cUmFBPWBMz81VNMJdj08ANt+21UsUlSmjyYNl6KMGAmGcjmfI4HADh0i7n5x5sGFWk21GMfziUI02GWsBwHN+J2TqxdIkDHfAMMlJo4XC7jZLc1I+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrGMFYhN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so21866021fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732533571; x=1733138371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+uhR74hcAQidbntjWvBDULQoiBq+eDvtJid0uWUA5U=;
        b=zrGMFYhNrwlrpKvsfX0Gx1z0PJnNfYth3jwhvPrj1RKgAU2aDHkK/pz/yOM/sfdjlE
         dJVAA6PPSaPNSZ8fzQDdxdnNXec8jS67RvyUurnTF1Hd+PAp97G+eTlIP0aPpr4edAEV
         AemTb2M9U2V8qF0bPJqWcfS7DQksXPIbRDDq41hcfmHFwRWHvj4pxKhiOTqT/jB3RNvv
         1zkrlP7bPcu0HHO6TWQcwXb9inFI1f8WOV/okmBju+s5g2SUKgV28r39tgfCIC2M7NTr
         ibYvuLdW5Ji4eTIQXwkUlQFQjk8e5dRIH62t+mYuShpLIcvVKGZ1ld2Bl4u0FH4GOFzn
         5E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533571; x=1733138371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+uhR74hcAQidbntjWvBDULQoiBq+eDvtJid0uWUA5U=;
        b=Vx3E7z7ImPAGjP0cBIYrP5gvLYW8AIa6JgD4BuYySfEWHqmeD0md/qnjKL8+6OeKL+
         YlkhDRur6qZzXj3snHCsCGYvLOmjyYtlEjcqi9F/eeJMlmUTjqdxNYbu7jdw/Y8/nKrs
         d6L6HkY9lWt78qzqDLyBMJblMW42x9+TgZ/1yL9MsY5uccM2YR4tH0gyxudfHxNBwXV5
         DDObDFlqBNUuRA0b42ijhWJzUEAxty+sctBeM2zHnD+p67kFvP5A+JA2gw3pdAXr2EMX
         uJ87GO4jg35quaXkmjk2rUEqc6AuwhnoBy5FUd6OqZKwaPGmx77RB6RFxRnRE8qk2xZT
         pC9w==
X-Forwarded-Encrypted: i=1; AJvYcCVKx8PmQ/FgClljw/rBEMIK7CCwaXodVP+QbupF6JSXacNruuB1AwsRpno1lxeO7MyfJ2jPw45JBUGiKjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4K9MJr+V6M7VAyzH+KLvnLC0vmM+ceLnHPY4EBn14xD4rO94T
	oaNvSPsuBwj1Cj8YMpM+wGVq1ARIkU6vBJX0dwYVylfIGrD9/3cKMXs9/q8v/si/w6xk8+I/yUx
	YhJ+TE9tcPdRz6xEm72jI3PBLhY00oMHQwEA+4egzRX1CoLP1rNLh
X-Gm-Gg: ASbGncvOEOFueXCTprFam7TyJ+4m5HPEhEDMntZo3DiqGaHwRxe1ks/gSigNaS8cWoR
	sh1Axv3kl0HwFcKzDnmQlP/GGLmtOO7o2n/4zUlZOl+b8xTFnb0mHjZ6sLGfQ4pRY
X-Google-Smtp-Source: AGHT+IEgCCRUAYMNMXm5YVXYCKuprgewhzC/7WL+dMW78lmj7ZW701M50sfY6JHIy0GViN5Pu9wq2jsz24kqE82o+aI=
X-Received: by 2002:a2e:a556:0:b0:2fb:5da7:47a7 with SMTP id
 38308e7fff4ca-2ffa7197a78mr61355421fa.25.1732533571061; Mon, 25 Nov 2024
 03:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122234811.60455-1-frederic@kernel.org> <20241123101312.GA12843@redhat.com>
 <CACT4Y+YQGLtD0673Oxm2=0mHy9cSx1wTPtVCyxjORSv47M+vUw@mail.gmail.com> <20241125111254.GB20402@redhat.com>
In-Reply-To: <20241125111254.GB20402@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 25 Nov 2024 12:19:19 +0100
Message-ID: <CACT4Y+YBO_1oYccnQdZrS_o1G2bSSPBmYBdjsMXN_8d2zncbQA@mail.gmail.com>
Subject: Re: [PATCH] posix-timers: Target group sigqueue to current task only
 if not exiting
To: Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Anthony Mallet <anthony.mallet@laas.fr>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 12:13, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/25, Dmitry Vyukov wrote:
> >
> > On Sat, 23 Nov 2024 at 11:13, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 11/23, Frederic Weisbecker wrote:
> > > >
> > > > - * the same thread group as the target process, which avoids
> > > > - * unnecessarily waking up a potentially idle task.
> > > > + * the same thread group as the target process and its sighand is
> > > > + * stable, which avoids unnecessarily waking up a potentially idle task.
> > > >   */
> > > >  static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
> > > >  {
> > > >       struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
> > > >
> > > > -     if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
> > > > +     if (t && tmr->it_pid_type != PIDTYPE_PID &&
> > > > +         same_thread_group(t, current) && !current->exit_state)
> > > >               t = current;
> > >
> > > Thanks!
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> >
> > Can't the group leader be exiting as well?
>
> It can. It is even possible that the group leader is already a zombie.
>
> But this is fine. release_task(zombie-or-exiting-leader) (which does __exit_signal()
> and clears ->sighand) won't be called until all the sub-threads have exited.
>
> And. If all the sub-threads (and the group leader) have exited, then send_sigqueue()
> makes no sense, the whole process is dead. so we do not care if lock_task_sighand()
> fails in this case.

Ah, I see. Thanks.

> > Though, that's still an
> > improvements. People usually don't do that (exiting from main w/o
> > killing the process).
>
> See above. Nothing to improve, AFAICS.
>
> > So thanks for the fix.
>
> Yes, thank you Anthony and Frederic!
>
> Oleg.
>

