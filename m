Return-Path: <linux-kernel+bounces-416130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A985A9D410A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA10B2EB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EC154BFC;
	Wed, 20 Nov 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIJGwEy7"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C31420DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121795; cv=none; b=Ng2uztW31hK7QbWfoz9U1oR4bsWvyJZyaTbpRNTp0ubnEBBMeGRwteQpM9avRrbOHmAp/ShSJfdR50Gj7661tLSiBQcnj9RUeDg1N+/sSppWXrQOfcqDjf9eVYixiN//hzMwI64kTe51/uTQskmg1HoRzAYaZn6GvvR1b4ql++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121795; c=relaxed/simple;
	bh=5xwOpUzusORxob6pqTPYTRKJg0Sipzqwj9sr6Ai5ZJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWrCNYWbT1pvwGEuBdJL97OJpTQ9+VbaOcoFyW4jOdaB/B6xr6guacb+/40F4Eq6qeeCS4HlSWMnFphnrtRMuLWMXSfNNWyWH9BEt9W3BeTeu0WIT2aqWnsf/xfUmK8i5WHmjfLv1qNZRI2GwNdNCBzaa6OaAUXNXD1qhTUjPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIJGwEy7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608dddaa35so837771cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732121792; x=1732726592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn2N1RlyoEGK5Er0Y7LLgp676li1d/jUmAWtFBqkJus=;
        b=jIJGwEy741TGj4OVJdn+l4pLx3I8oWHoWiZVFWHam1eVb2ffyrlyjQpxO1QV7D1ekn
         z6nNs71ZgRJauCJ//WMXr4ILCkuN5JHuH7XY7Mqk/rIEL1Zv2Z5J+ALivU/8Cu/7G2Rv
         H5foNwhBvDMC8arqnnhv70rHjlFdswLFhyfBbQMVsntcQ1bLzfS5XNnr5yzvY6p8WXGS
         fJBiogCDknIa9dcUDYq4GUHJWX+9PwNY+hBW2JjSztVx+xLCewHQBgYiE5KWe5BiLcYa
         xK996lYwEssHwBpwXzvqyPH7EMDgpS6HSgD5tTxhVQWUFwJM5lSO4lK9GOo/XY4RJ4hz
         GtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121792; x=1732726592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn2N1RlyoEGK5Er0Y7LLgp676li1d/jUmAWtFBqkJus=;
        b=KoXDeZWf0KfV9UZPKg/HLjrcGKJW4uJg6bsZsvS+Wb/gQpz83k2hETNNP8qo6AD/O5
         X1RANr9Ykplvfnn2tBXCwNmlceSfKVZT3nbnqjReDDUT8ovcOU8E5iZYXSMO6AKHyHPB
         ta4PB2E10Y7lo8mK/QGjsFPvmTCMFfbmT8x3YtSRttdpF4sXyFwBDG85ZpNZoC0JOapb
         COZDEf80WTAkNv80gt/AY+dighgl9LJPmztp7LIdJYEQ4Zu+WcyeBoKh/H68q/LpPu/k
         6VGwc/kBv5SVxRbCn+Znp0u0sTElMwoAiOO5pIF+5Ye0DC8C1D+Z77tosjQ5Ks6X6U4I
         oU/A==
X-Forwarded-Encrypted: i=1; AJvYcCXC270HGFDZ7R1UjcGxpcK4689N7hIvMlAP4zdD67eJOliT8fOwBFJgHYqTSJQ+oWgZVzkuBNrLqwVZzaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpl4A4Lw7A45rlqRYdPbC1HHeo/uELkygBUIRdjooPjmIuHJOz
	w+2/nvt7/V2aC4yWHHl3earS+yLmxA9kalP0pyFy/Cuxedi5bm/5Y468c3FT+ItbONpVA3TmxBy
	CbvJZTjYtTL+FJN24TDVE/u+W9SUeFIY1d6yI
X-Gm-Gg: ASbGncu4uOOwj6XbHBCvi7CUkk4ZkuvAt1+KZkrjfMT2w/tBkZvoqaDyyjBbGzTBwIa
	l9q+7QsE/i7PfbLbQsaOzmyXnlbgwZ7GPx2wWpF1bllhfCUn/Ex6gyQN7YTPLuA==
X-Google-Smtp-Source: AGHT+IH6Z/qBjr+rI/cHZRUCenYOzhCPmiiuYvR3sntVaXzTfwR74L2rb2y2YvG6WE45uAaiSWigtAzhHNb00T6ehmU=
X-Received: by 2002:a05:622a:549a:b0:460:491e:d2a2 with SMTP id
 d75a77b69052e-464d3018e4cmr3170761cf.17.1732121792243; Wed, 20 Nov 2024
 08:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com> <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
In-Reply-To: <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Nov 2024 08:56:21 -0800
Message-ID: <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:30=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Tue, Aug 6, 2024 at 5:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> > Hmm. The original scenario I was thinking about when I proposed this
> > WARN_ON() was deemed impossible, so I think the only other possibility
> > is that the task being killed somehow skipped psi_memstall_leave()
> > before its death... Did you have the instrumentation I suggested to
> > track imbalance between psi_memstall_enter()/psi_memstall_leave() and
> > to record the _RET_IP_? If so, did it trigger at all?
>
> Hi Suren,
>
> it has taken a few months, but today, this bug was trapped by 6.11.9
> with your patch:
>
>  ------------[ cut here ]------------
>  Stall from readahead_expand+0xcf/0x1d0 was never cleared

This is interesting. readahead_expand() indeed has
psi_memstall_enter() without a matching psi_memstall_leave():
https://elixir.bootlin.com/linux/v6.11.9/source/mm/readahead.c#L727
and https://elixir.bootlin.com/linux/v6.11.9/source/mm/readahead.c#L754.
Looks like this was introduced in [1].  I'm not sure if that's a bug
or psi_memstall_leave() is supposed to be called from somewhere else.
CC'ing Christoph to clarify.

[1] 176042404ee6 "mm: add PSI accounting around ->read_folio and
->readahead calls"

>  WARNING: CPU: 2 PID: 22644 at kernel/exit.c:933 do_exit+0x8c7/0x970
>  Modules linked in:
>  CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Not tainted
> 6.11.9-cm4all2-vm+ #242
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/=
01/2014
>  RIP: 0010:do_exit+0x8c7/0x970
>  Code: 75 bb 4c 89 ef 48 89 dd e8 b6 21 0d 00 48 c7 c7 80 60 60 a5 e8
> ca dd ba 00 e9 5b fa ff ff 48 c7 c7 d8 4d fc a4 e8 e9 9e ff ff <0f> 0b
> e9 1d fe ff ff e8 4d e6 24 00 e9 9b fd ff ff 48 8b 78 68 e8
>  RSP: 0018:ffffc2bdd2fafc50 EFLAGS: 00010286
>  RAX: 0000000000000000 RBX: ffff9f96762bab80 RCX: 0000000000000027
>  RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
>  RBP: ffffc2bdd2faf6a8 R08: 00000000ffffbfff R09: 0000000000000001
>  R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffffc2bdd2fafc60
>  R13: ffff9faa09fed5d8 R14: 0000000000000001 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x7c/0x110
>   ? do_exit+0x8c7/0x970
>   ? report_bug+0x14c/0x170
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x13/0x60
>   ? asm_exc_invalid_op+0x16/0x20
>   ? do_exit+0x8c7/0x970
>   do_group_exit+0x2c/0x80
>   __x64_sys_exit_group+0x14/0x20
>   x64_sys_call+0x14aa/0x16a0
>   do_syscall_64+0x64/0x100
>   ? __memcg_kmem_charge_page+0xdc/0x1d0
>   ? do_fault+0x270/0x490
>   ? __handle_mm_fault+0x321/0x1280
>   ? __count_memcg_events+0x53/0xf0
>   ? handle_mm_fault+0xa0/0x260
>   ? do_user_addr_fault+0x33b/0x5b0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0c00c5365a
>  Code: Unable to access opcode bytes at 0x7f0c00c53630.
>  RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
>  RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
>  R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
>  R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>  ------------[ cut here ]------------
>  Stall from readahead_expand+0xcf/0x1d0 was never cleared
>  WARNING: CPU: 2 PID: 22644 at kernel/sched/psi.c:989
> psi_task_switch+0x126/0x230
>  Modules linked in:
>  CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Tainted: G        W
>        6.11.9-cm4all2-vm+ #242
>  Tainted: [W]=3DWARN
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/=
01/2014
>  RIP: 0010:psi_task_switch+0x126/0x230
>  Code: f6 75 e6 41 f6 44 24 18 80 74 36 41 f6 84 24 a8 08 00 00 02 74
> 2b 49 8b b4 24 b0 08 00 00 48 c7 c7 d8 4d fc a4 e8 5a de f9 ff <0f> 0b
> 41 f6 44 24 18 80 74 0d 41 f6 84 24 a8 08 00 00 02 74 02 0f
>  RSP: 0018:ffffc2bdd2fafb48 EFLAGS: 00010086
>  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
>  RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
>  RBP: 000000000000001c R08: 00000000ffffbfff R09: 0000000000000001
>  R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffff9f96762bab80
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x7c/0x110
>   ? psi_task_switch+0x126/0x230
>   ? report_bug+0x14c/0x170
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x13/0x60
>   ? asm_exc_invalid_op+0x16/0x20
>   ? psi_task_switch+0x126/0x230
>   ? psi_task_switch+0x126/0x230
>   __schedule+0x954/0x1150
>   do_task_dead+0x3e/0x40
>   do_exit+0x6f0/0x970
>   do_group_exit+0x2c/0x80
>   __x64_sys_exit_group+0x14/0x20
>   x64_sys_call+0x14aa/0x16a0
>   do_syscall_64+0x64/0x100
>   ? __memcg_kmem_charge_page+0xdc/0x1d0
>   ? do_fault+0x270/0x490
>   ? __handle_mm_fault+0x321/0x1280
>   ? __count_memcg_events+0x53/0xf0
>   ? handle_mm_fault+0xa0/0x260
>   ? do_user_addr_fault+0x33b/0x5b0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0c00c5365a
>  Code: Unable to access opcode bytes at 0x7f0c00c53630.
>  RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
>  RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
>  R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
>  R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 22644 at kernel/sched/psi.c:994
> psi_task_switch+0x13b/0x230
>  Modules linked in:
>  CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Tainted: G        W
>        6.11.9-cm4all2-vm+ #242
>  Tainted: [W]=3DWARN
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/=
01/2014
>  RIP: 0010:psi_task_switch+0x13b/0x230
>  Code: 2b 49 8b b4 24 b0 08 00 00 48 c7 c7 d8 4d fc a4 e8 5a de f9 ff
> 0f 0b 41 f6 44 24 18 80 74 0d 41 f6 84 24 a8 08 00 00 02 74 02 <0f> 0b
> 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 41
>  RSP: 0018:ffffc2bdd2fafb48 EFLAGS: 00010002
>  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
>  RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
>  RBP: 000000000000001c R08: 00000000ffffbfff R09: 0000000000000001
>  R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffff9f96762bab80
>  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x7c/0x110
>   ? psi_task_switch+0x13b/0x230
>   ? report_bug+0x14c/0x170
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x13/0x60
>   ? asm_exc_invalid_op+0x16/0x20
>   ? psi_task_switch+0x13b/0x230
>   ? psi_task_switch+0x126/0x230
>   __schedule+0x954/0x1150
>   do_task_dead+0x3e/0x40
>   do_exit+0x6f0/0x970
>   do_group_exit+0x2c/0x80
>   __x64_sys_exit_group+0x14/0x20
>   x64_sys_call+0x14aa/0x16a0
>   do_syscall_64+0x64/0x100
>   ? __memcg_kmem_charge_page+0xdc/0x1d0
>   ? do_fault+0x270/0x490
>   ? __handle_mm_fault+0x321/0x1280
>   ? __count_memcg_events+0x53/0xf0
>   ? handle_mm_fault+0xa0/0x260
>   ? do_user_addr_fault+0x33b/0x5b0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   ? clear_bhb_loop+0x45/0xa0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0c00c5365a
>  Code: Unable to access opcode bytes at 0x7f0c00c53630.
>  RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
>  RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
>  R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
>  R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>  ---[ end trace 0000000000000000 ]---

