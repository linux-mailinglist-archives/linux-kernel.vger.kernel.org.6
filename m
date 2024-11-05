Return-Path: <linux-kernel+bounces-396763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3B9BD1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990EE1F251BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51016DC12;
	Tue,  5 Nov 2024 16:04:18 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADA1384B3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822658; cv=none; b=gIlBgtYbHinnYPKnJcrwUGHIikSYmlQP02hp+v9Zj+6/aF9Aa3Qit0iKkAj8kAdEeHh99bfnd19bxUzjYFcNr4hSN9VtN4qypa8F+IP5gFWSjEHYr9WVzEszK+FZUDH8k3DvFy333LRgu9UbIYoX0lXdW9iP7W4mAAKVOt8bx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822658; c=relaxed/simple;
	bh=W3eKg/9kBhtLGmidWjliShMRjQiv/FMq0JCLac9x3y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmiLOkrXVvze77CuoLcLOD9CLIQ9YP5Hrtoa47Y7iaEyvsedk8QNW9irzISCOIiWUdgEYFJvCDDlzsi9Tp1KX7wsyIl1Eoyeu0E82f3vXn8LtsFeOSMZQe0JLoQey/NrQQ+6Gr1UDBpVHWyLMvzxRk1uftdR0dBG9r5e7zkK2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso6039457276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822654; x=1731427454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNyXOIVPBlmU0stxaqtQLJR2lM5cPjTKiHulmutb7ZY=;
        b=kTGZMrMdJXrJMpPysFEXu1UB063I2rdlW28nVH5r1O6YqIKdSaGg1fjMtlw9MOnwS6
         RFYvUH7R+5QQLNO1DcXHj2NEqUcEJP+C8VDYSh3UHxKA6Bv00rkBKlbH2npgw89TWzCm
         1bJ9Ahs1eoA15LtEFGk6v2/Kk3sypziIgAE1QcvZRu3gE7mlJHy/G89HjVp/q7/Fb7h9
         /0IvI1YrdkX7gtAqFp0j7JAGufeKnwARvsfP+zjK36nQPPQ23NlQwOP3bB3+Hg9P2WtK
         OHHcuxZeLdHtCfhgbg5SvvjYPQi5aRDFZkz0BPSfTp1Y+27s4VQ3q3WyPdAHTujfJeVT
         V46A==
X-Forwarded-Encrypted: i=1; AJvYcCWtHL3FdL0Nsp4sveNOL07n8M5H1CTiF+XuVmWRkECgsvlIPsmGti0Yr9hbZGlL1UfEGt8ma8o0EPeC35Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSsPeS/4lGkjY5dQncuQT3ZlKqB5hB2w1yqt5y4C1qBUCy/K4
	SJ3xcNUwjRvQ8FPO8A5XdK3FzqmtizasZ32kgzFfIFW3XqiA5z0VRU1ufNhe
X-Google-Smtp-Source: AGHT+IF3gcti6VTXt/+o0u9ZBLlfL+R3JDFP+4tORr0EWpwMFUHPUnir2s7UhRjlhe39xWDD4xJhGQ==
X-Received: by 2002:a05:690c:620f:b0:6e3:3227:ec64 with SMTP id 00721157ae682-6ea64bb1d36mr167600137b3.35.1730822654331;
        Tue, 05 Nov 2024 08:04:14 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7beaae0dsm15762207b3.48.2024.11.05.08.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 08:04:13 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e30d821c3e0so5700611276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7CYbFJJF3wvstNrgYoWV3peToL4KbjJfkLVctt4NKOuwUqewKHQuPbeOBubTFiVQW57X457EukQ5O9ow=@vger.kernel.org
X-Received: by 2002:a05:690c:6201:b0:6e3:28af:730d with SMTP id
 00721157ae682-6ea64be79a7mr171494157b3.43.1730822653623; Tue, 05 Nov 2024
 08:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fix-jump-label-v1-1-eb74c5f68405@yoseli.org>
 <CAMuHMdULfk-_VGXBsnD+Gc7h4c5PRAYDdgx1zEeW=4+1fA0N_Q@mail.gmail.com> <d8d99f60-7a51-4b5f-b281-11fe6322a01e@yoseli.org>
In-Reply-To: <d8d99f60-7a51-4b5f-b281-11fe6322a01e@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 17:04:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWV9aAV89gB-57e9cmFYax=BUbg0k2m7R1+t9E5YSySvw@mail.gmail.com>
Message-ID: <CAMuHMdWV9aAV89gB-57e9cmFYax=BUbg0k2m7R1+t9E5YSySvw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Initialize jump labels early during setup_arch()
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

On Tue, Nov 5, 2024 at 3:56=E2=80=AFPM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> On 11/5/24 15:03, Geert Uytterhoeven wrote:
> > On Wed, Oct 16, 2024 at 6:18=E2=80=AFPM Jean-Michel Hautbois
> > <jeanmichel.hautbois@yoseli.org> wrote:
> >> The jump_label_init() should be called from setup_arch() very
> >> early for proper functioning of jump label support.
> >>
> >> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/m68k/kernel/setup_mm.c
> >> +++ b/arch/m68k/kernel/setup_mm.c
> >> @@ -249,7 +249,11 @@ void __init setup_arch(char **cmdline_p)
> >>          process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
> >>          *cmdline_p =3D m68k_command_line;
> >>          memcpy(boot_command_line, *cmdline_p, CL_SIZE);
> >> -
> >> +       /*
> >> +        * Initialise the static keys early as they may be enabled by =
the
> >> +        * cpufeature code and early parameters.
> >> +        */
> >> +       jump_label_init();
> >>          parse_early_param();
> >>
> >>          switch (m68k_machtype) {
> >
> > This is indeed what some (but not all) other architectures are doing, s=
o
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > I assume you saw some "static key used before call to jump_label_init()=
"
> > warning[1]? Since I never saw such a message, can you please elaborate
> > and explain your use case, so I can add that to the patch description
> > when applying?
>
> Indeed ! I saw this when I was passing the "threadirqs" parameter to the
> kernel commandline and the "select IRQ_FORCED_THREADING" line to the
> Kconfig.

Thanks, I can reproduce it using that method.

> I suspect this might be true for other keys.

Indeed. But m68k and its configs don't enable much code that uses keys.
The only one I found was "thread_backlog_napi". Adding that to the
kernel command line gives:

    WARNING: CPU: 0 PID: 0 at include/linux/jump_label.h:322
setup_backlog_napi_threads+0x40/0xa0
    static_key_enable(): static key '0x5ceec0' used before call to
jump_label_init()

so I'll add that to the patch description.

> BTW, threaded IRQs work fine ;-).

On Atari (ARAnyM), they blow up spectacularly:

    Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
    Oops: 00000000
    Modules linked in:
    PC: [<00040baa>] try_to_wake_up+0x90/0x1b8
    SR: 2701  SP: (ptrval)  a2: 0055b660
    d0: 00000003    d1: 00000003    d2: 00000000    d3: 00002700
    d4: 00000008    d5: 00000000    a0: 00558000    a1: 00558000
    Process swapper (pid: 0, task=3D(ptrval))
    Frame format=3D7 eff addr=3D00000000 ssw=3D0505 faddr=3D00000000
    wb 1 stat/addr/data: 0000 00000000 00000000
    wb 2 stat/addr/data: 0000 00000000 00000000
    wb 3 stat/addr/data: 0000 00000000 00000000
    push data: 00000000 00000000 00000000 00000000
    Stack from 00559ea8:
    00000000 0000000f 00007874 01006140 00559ef0 00050ec6 0000000f 00559ed8
    00040ce6 00000000 00000003 00000000 00559f14 0003b9b6 00000000 00000000
    00592710 010040c0 00000000 00559ef4 00559ef4 0003ba26 00051cd2 010040c0
    ffffffff 004fc9a1 00559f2c 00559ff8 00050ef8 00051cd2 010040c0 ffffffff
    004fc9a1 0000000f 004f9268 00000000 00592710 010040c0 00051566 010040c0
    0000000f 00000000 00000000 0000000f 00007874 00000000 010040c0 00592710
    Call Trace: [<00007874>] stdma_int+0x0/0x1c
     [<00050ec6>] setup_irq_thread+0x0/0x98
     [<00040ce6>] wake_up_process+0x14/0x18
     [<0003b9b6>] __kthread_create_on_node+0xca/0x11e
     [<0003ba26>] kthread_create_on_node+0x1c/0x26
     [<00051cd2>] irq_thread+0x0/0x184
     [<00050ef8>] setup_irq_thread+0x32/0x98
     [<00051cd2>] irq_thread+0x0/0x184
     [<00051566>] __setup_irq+0x172/0x582
     [<00007874>] stdma_int+0x0/0x1c
     [<00051a34>] request_threaded_irq+0xbe/0x14e
     [<0003ab86>] parse_args+0x0/0x202
     [<0000556e>] m68k_setup_irq_controller+0x0/0x48
     [<00255bda>] __is_suppressed_warning+0x0/0x42
     [<005da080>] stdma_init+0x2a/0x42
     [<00007874>] stdma_int+0x0/0x1c
     [<00200080>] ksys_shmctl+0x420/0x5f8
     [<00007874>] stdma_int+0x0/0x1c
     [<005d9f82>] atari_init_IRQ+0xc0/0x194
     [<00412cc8>] _printk+0x0/0x18
     [<00255bda>] __is_suppressed_warning+0x0/0x42
     [<005d62b0>] start_kernel+0x40e/0x618
     [<005d5344>] _sinittext+0x344/0x9e8

    Code: 0008 5281 2341 0008 b6fc fc3c 6700 011e <2213> c280 6700
0108 202b 0018 4bf9 0004 05a6 6700 0096 486e fffc 2f0b 4eb9 0004
    Disabling lock debugging due to kernel taint
    Kernel panic - not syncing: Attempted to kill the idle task!
    ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]=
---

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

