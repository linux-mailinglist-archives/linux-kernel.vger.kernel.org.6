Return-Path: <linux-kernel+bounces-276527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46B6949563
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206D1B2DB83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE744AEF7;
	Tue,  6 Aug 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iEjhZ4s"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E2487BF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959789; cv=none; b=VXrACLN1YQQRi7qhoYUx59lIzSEErzm8xD1Ww5+CDB5yuCjj6XOdEsUPzvEFjTZSh0WW4kgNKIgqIAeN4Fad4eL5IKEKNHtbVS6TDCqi20Sq+kHC7YirZLRQCUZAZjmQ0AvtqZHYrANwBMpAacPdhi5Awom0E+6NI6vppWb5gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959789; c=relaxed/simple;
	bh=Bv5hZoBJj5QINjDZW2gvA29OWnHWwbFbHK+psESXUj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tux52W4gAbClgt1bgVMk8aEcn9WjRtOKYx2CYvngEzR5at57tTp/C2w3d4gD4TCL78mW7v3UZD7GKvfaZNYG6pmc4UpQhlH6gF2dlZ83/u93uzipBi0LWNAO7IPYy12uWYm8MGTskngUqracxook+SmPrmY3sWvvcgTZW3Rxx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iEjhZ4s; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368584f9e36so421264f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722959786; x=1723564586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMG6bZpSMlLE3oYkCTgpasvj2/iRg2giQDnPUt3OztU=;
        b=4iEjhZ4sN9/94DcoNVw00A7aGcgWTu/Py01IWScsK2URvmWCoXqrAn9rbJLjI8mZdK
         BBpsBUNjhDGEy7+lKQPMQ+x+SWVQXXIdkFSZXoOGktgnWECPSAgD9KqDti7n49GnkWac
         EW5OUjm+2rT+1+G2EKo67y7GH8fKGhuJ7KWe84YIjOb+xM7uFHj+LrvnZAmy1ZPh4LJY
         Iw5oQDSC5YY7MUEe2DLlPJYRUpP4EXNzs6LP4rCFXtCbiQ6jemehC/efr6Zak/qKnF/E
         XPKWBn3LPAwU8a5SMycoiYVQf9T0TlQFi5XEcci8iPAw6Hs0XW4fncyY8qZrL9ru2nMm
         x6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959786; x=1723564586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMG6bZpSMlLE3oYkCTgpasvj2/iRg2giQDnPUt3OztU=;
        b=tnggpv1C3tJ6GlFSu0ZPWWDOaJgzV+3yJdbPQh38WZvU9eBiqMoYz1JLm8ezaCi9Ov
         T0j4gREadqDXycSn0oOszDwrrVc3NPZJrbKk69Cs26KxKLTAvGi0JO5w6LpEkSpOkxNk
         akKpJJO+VM/G0xunjBJymWaGGE5jizIR3cWM2oZF5z1LCXOWsHtEyv8gVRhHGldu+aFZ
         uTat2LrwJiqcK52sAL7vQwk7Ej/8zAsA62hi5cYsQqGMJiS/ZNoygoc0DW2S80/dAXdC
         DDNIFPvtbSlrLyGX+Sta1wfirKehtJ05GPLHebiJ0CNnbBOo7mVxJkopLdqEVTLFNXzQ
         HwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyBJmGi4j57qK06eGmSf4d8CNMK4tHOZ+m8SOaXK8ODNdrKneSpA8P+bLg47rjvliahlu8/gAx28QmHPntLR2pXVljPLmojf+r6iQT
X-Gm-Message-State: AOJu0Yya4WtWkVhsLboBebrAkvxjMynotlwN43CchHv7EnAvWRxnDu/Y
	c1YgrjhKxOqpe+GX672kBbcpfx6s6uxkiabDDavfF6VTPhl6shfmw9BsTzc1+OlzXCGn7rJ0Azi
	B9JLsLHtcs6++avxdJhmvxNPxvKLurVQbeXlc
X-Google-Smtp-Source: AGHT+IEpbWD4229w97H08b2o8GFdDllyRXfxnKdVPgzrri8PQRB0M6p38Paz+k2dOGQYl/FVMmCU6MvVc5h3nhTN3pA=
X-Received: by 2002:a5d:4d0f:0:b0:368:3717:10b3 with SMTP id
 ffacd0b85a97d-36bbc0a847cmr9727070f8f.8.1722959785672; Tue, 06 Aug 2024
 08:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com> <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
In-Reply-To: <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 6 Aug 2024 08:56:09 -0700
Message-ID: <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:35=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Wed, Jun 12, 2024 at 7:01=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > I think you can check if this theory pans out by adding a WARN_ON() ar
> > the end of psi_task_switch():
> >
> > void psi_task_switch(struct task_struct *prev, struct task_struct
> > *next, bool sleep)
> > {
> > ...
> >         if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
> >                 clear &=3D ~TSK_ONCPU;
> >                 for (; group; group =3D group->parent)
> >                         psi_group_change(group, cpu, clear, set, now,
> > wake_clock);
> >         }
> > +        WARN_ON(prev->__state & TASK_DEAD && prev->psi_flags & TSK_MEM=
STALL);
> > }
>
> Our servers have been running with this experimental WARN_ON line you
> suggested, and today I found one of them had produced more than 300
> warnings since it was rebooted yesterday:
>
>  ------------[ cut here ]------------
>  WARNING: CPU: 38 PID: 448145 at kernel/sched/psi.c:992
> psi_task_switch+0x114/0x218
>  Modules linked in:
>  CPU: 38 PID: 448145 Comm: php-cgi8.1 Not tainted 6.9.12-cm4all1-ampere+ =
#178
>  Hardware name: Supermicro ARS-110M-NR/R12SPD-A, BIOS 1.1b 10/17/2023
>  pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : psi_task_switch+0x114/0x218
>  lr : psi_task_switch+0x98/0x218
>  sp : ffff8000c5493c80
>  x29: ffff8000c5493c80 x28: ffff0837ccd18640 x27: ffff07ff81ee3300
>  x26: ffff0837ccd18000 x25: 0000000000000000 x24: 0000000000000001
>  x23: 000000000000001c x22: 0000000000000026 x21: 00003010d610f448
>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 0000000000000004 x13: ffff08072ca62000 x12: ffffc22f32e1a000
>  x11: 0000000000000001 x10: 0000000000000026 x9 : ffffc22f3129b150
>  x8 : ffffc22f32e1aa88 x7 : 000000000000000c x6 : 0000d7ed3b360390
>  x5 : ffff08faff6fb88c x4 : 0000000000000000 x3 : 0000000000e9de78
>  x2 : 000000008ff70300 x1 : 000000008ff8d518 x0 : 0000000000000002
>  Call trace:
>   psi_task_switch+0x114/0x218
>   __schedule+0x390/0xbc8
>   do_task_dead+0x64/0xa0
>   do_exit+0x5ac/0x9c0
>   __arm64_sys_exit+0x1c/0x28
>   invoke_syscall.constprop.0+0x54/0xf0
>   do_el0_svc+0xa4/0xc8
>   el0_svc+0x18/0x58
>   el0t_64_sync_handler+0xf8/0x128
>   el0t_64_sync+0x14c/0x150
>  ---[ end trace 0000000000000000 ]---
>
> And indeed, it has a constant (and bogus) memory pressure value:
>
>  # cat /proc/pressure/memory
>  some avg10=3D99.99 avg60=3D98.65 avg300=3D98.70 total=3D176280880996
>  full avg10=3D98.16 avg60=3D96.70 avg300=3D96.82 total=3D173950123267

Hmm. The original scenario I was thinking about when I proposed this
WARN_ON() was deemed impossible, so I think the only other possibility
is that the task being killed somehow skipped psi_memstall_leave()
before its death... Did you have the instrumentation I suggested to
track imbalance between psi_memstall_enter()/psi_memstall_leave() and
to record the _RET_IP_? If so, did it trigger at all?

>
> It's taken nearly two months. and none of the other servers had
> produced this; this seems to be a bug that's really rare.
>
> Max

