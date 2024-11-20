Return-Path: <linux-kernel+bounces-416088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4F9D40A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35294B324B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF24153820;
	Wed, 20 Nov 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I8H6Q3C2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EBF9D9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120250; cv=none; b=KKiT3sffNpYXwabXWrh0ElXOqCaxCBRnMBf0NrfisGLN0qKMzCS25QYHz58ZqJOOO6JxPwFWV/peu5FOF9bwlrc0M0DEqQO+GQZQvX1aFQ7xaQ4M+aW1IKf1RlKYqkjVBs+4FYMHjtfBfiV/8wtsj+DDFV+2Tg3iwkdLamHuMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120250; c=relaxed/simple;
	bh=FPPe8IMBUiQ932DDbct7XjskM3rDwkJw02j/f3T2Aoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkCg5B3v3CpxQi+f0uM90RtBSKP5To0ipB2A6PlRsA8s+GwBqyvoEvXVn8X+QoJSJdM3DSJ+VzKyEJOfv8SqF8XbOMs4kD56hYsDswuZzAcKze8H6Qyo8XhJpKZWVTmwZ9PJ8QclQWMCYA9oLmdL58H0UtIz3ivxn4gszWot09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I8H6Q3C2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ed49edd41so433012966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732120246; x=1732725046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TkvJNVkCS5/GXtYV/acnx7cL5dd+Ptbobk3R1u8IQo=;
        b=I8H6Q3C2x6sWwnsm1uVnYuCGFUavBwQ8Bhg0aanxG3RnzuNzaWXZT8q+WvLIxRsuDc
         qDX67ivd7DpKfhaPigH0x+UMyk6869uNLyofUpbuG6GJ4YMi1aHOi6Blh91lHb+7ZEHf
         76m66DlLVfTkTqBnSL4ghXAZgcc3wiK1p7MbmKgbcyi5I8e+ibO2OnGq3pudgd38kCyA
         XKVzE9WTqyqbX4ZrgiosHAu8plPrk752kXyoVqB5ULr1Nlx4QzbKauWpWFFjOhfPn7il
         RgtXznqWdH1vQ32VyIPOJkIJ1jngZWwysgeH/c7pp3IR0VcWQfbMKDxl1Is1rgjruhHY
         P6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120246; x=1732725046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TkvJNVkCS5/GXtYV/acnx7cL5dd+Ptbobk3R1u8IQo=;
        b=mjEefsBMEDmjpa1SRxXq0yiXZUEqWvRxDKxxhH1bS83pSNpymOcGcsfp5JFZFC3mhQ
         rAHMmZ18oOIECSEqWdtQIQHufegVrOM0V+C96ZVjsSaYsNAFgThloevQ880lRQUlk0Pz
         mfdTqPuFwjE2PlElNZOt3AyHvWzL9yamEF7nC1SFgnhCdcXbPYHZLfBodzuIkPv4mH2v
         7wMak6ENjj146FUnryIGhwCSMwUGypE2dT4e7e0uF4/bGgz0AwNxkMnKGLg3derW7rrv
         Zmr6gzd87BjqZyyZFwWJYS7b62YG6WQyDOPpZt2huxPXeSSoBihDVEvkevLw2nExvU4H
         DZkg==
X-Forwarded-Encrypted: i=1; AJvYcCVRjL6iCirj44RY3JeKVsqFaPGAhEi8q4YD96QzGdt9APsfBzvq+wsjMcMnHN8T7YctT8phqm4AMgKnoPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0lcXO8G1HPbzNDn7scO1OfyNv4STyCe2aCTAaHf/PMXFCJqyo
	gGaf2iiWkKN0jH5bE9Uq9l+FF4GixibXxJVson/RZpG5GYR3ZQB8RKhTzrcTa62JHF5XlsA0SDj
	ZVnYvifZ0QuZSfXHHXLkVGWQMamnEygRfzcaTjw==
X-Gm-Gg: ASbGnctzZIxEDSZ9cCZjeICx0HNw4TSQR3QhaxbwK8ixF4/u36VbC3JVvs0FjVfr+Wb
	dm+kRqY0dqYnF98GML7DACOVzBpNtVY3ZOCLebKPY49IbzG6P3V6xoeTU7IhR
X-Google-Smtp-Source: AGHT+IEUEAh9CJqavFJkdZWByCXo00jQAeJwKiJWgiFk9qS9hJZvTtKK3Fb/ndHG2BLruQ13FNj1WZuTqC1G0UgIvrM=
X-Received: by 2002:a17:906:c143:b0:aa4:844d:e5ee with SMTP id
 a640c23a62f3a-aa4dd748ec8mr320393866b.56.1732120246196; Wed, 20 Nov 2024
 08:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com> <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 20 Nov 2024 17:30:35 +0100
Message-ID: <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Suren Baghdasaryan <surenb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:

> Hmm. The original scenario I was thinking about when I proposed this
> WARN_ON() was deemed impossible, so I think the only other possibility
> is that the task being killed somehow skipped psi_memstall_leave()
> before its death... Did you have the instrumentation I suggested to
> track imbalance between psi_memstall_enter()/psi_memstall_leave() and
> to record the _RET_IP_? If so, did it trigger at all?

Hi Suren,

it has taken a few months, but today, this bug was trapped by 6.11.9
with your patch:

 ------------[ cut here ]------------
 Stall from readahead_expand+0xcf/0x1d0 was never cleared
 WARNING: CPU: 2 PID: 22644 at kernel/exit.c:933 do_exit+0x8c7/0x970
 Modules linked in:
 CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Not tainted
6.11.9-cm4all2-vm+ #242
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 RIP: 0010:do_exit+0x8c7/0x970
 Code: 75 bb 4c 89 ef 48 89 dd e8 b6 21 0d 00 48 c7 c7 80 60 60 a5 e8
ca dd ba 00 e9 5b fa ff ff 48 c7 c7 d8 4d fc a4 e8 e9 9e ff ff <0f> 0b
e9 1d fe ff ff e8 4d e6 24 00 e9 9b fd ff ff 48 8b 78 68 e8
 RSP: 0018:ffffc2bdd2fafc50 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffff9f96762bab80 RCX: 0000000000000027
 RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
 RBP: ffffc2bdd2faf6a8 R08: 00000000ffffbfff R09: 0000000000000001
 R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffffc2bdd2fafc60
 R13: ffff9faa09fed5d8 R14: 0000000000000001 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x7c/0x110
  ? do_exit+0x8c7/0x970
  ? report_bug+0x14c/0x170
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x13/0x60
  ? asm_exc_invalid_op+0x16/0x20
  ? do_exit+0x8c7/0x970
  do_group_exit+0x2c/0x80
  __x64_sys_exit_group+0x14/0x20
  x64_sys_call+0x14aa/0x16a0
  do_syscall_64+0x64/0x100
  ? __memcg_kmem_charge_page+0xdc/0x1d0
  ? do_fault+0x270/0x490
  ? __handle_mm_fault+0x321/0x1280
  ? __count_memcg_events+0x53/0xf0
  ? handle_mm_fault+0xa0/0x260
  ? do_user_addr_fault+0x33b/0x5b0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f0c00c5365a
 Code: Unable to access opcode bytes at 0x7f0c00c53630.
 RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
 RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
 R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
 R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------
 Stall from readahead_expand+0xcf/0x1d0 was never cleared
 WARNING: CPU: 2 PID: 22644 at kernel/sched/psi.c:989
psi_task_switch+0x126/0x230
 Modules linked in:
 CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Tainted: G        W
       6.11.9-cm4all2-vm+ #242
 Tainted: [W]=3DWARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 RIP: 0010:psi_task_switch+0x126/0x230
 Code: f6 75 e6 41 f6 44 24 18 80 74 36 41 f6 84 24 a8 08 00 00 02 74
2b 49 8b b4 24 b0 08 00 00 48 c7 c7 d8 4d fc a4 e8 5a de f9 ff <0f> 0b
41 f6 44 24 18 80 74 0d 41 f6 84 24 a8 08 00 00 02 74 02 0f
 RSP: 0018:ffffc2bdd2fafb48 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
 RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
 RBP: 000000000000001c R08: 00000000ffffbfff R09: 0000000000000001
 R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffff9f96762bab80
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x7c/0x110
  ? psi_task_switch+0x126/0x230
  ? report_bug+0x14c/0x170
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x13/0x60
  ? asm_exc_invalid_op+0x16/0x20
  ? psi_task_switch+0x126/0x230
  ? psi_task_switch+0x126/0x230
  __schedule+0x954/0x1150
  do_task_dead+0x3e/0x40
  do_exit+0x6f0/0x970
  do_group_exit+0x2c/0x80
  __x64_sys_exit_group+0x14/0x20
  x64_sys_call+0x14aa/0x16a0
  do_syscall_64+0x64/0x100
  ? __memcg_kmem_charge_page+0xdc/0x1d0
  ? do_fault+0x270/0x490
  ? __handle_mm_fault+0x321/0x1280
  ? __count_memcg_events+0x53/0xf0
  ? handle_mm_fault+0xa0/0x260
  ? do_user_addr_fault+0x33b/0x5b0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f0c00c5365a
 Code: Unable to access opcode bytes at 0x7f0c00c53630.
 RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
 RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
 R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
 R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 22644 at kernel/sched/psi.c:994
psi_task_switch+0x13b/0x230
 Modules linked in:
 CPU: 2 UID: 2148030876 PID: 22644 Comm: php-was Tainted: G        W
       6.11.9-cm4all2-vm+ #242
 Tainted: [W]=3DWARN
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01=
/2014
 RIP: 0010:psi_task_switch+0x13b/0x230
 Code: 2b 49 8b b4 24 b0 08 00 00 48 c7 c7 d8 4d fc a4 e8 5a de f9 ff
0f 0b 41 f6 44 24 18 80 74 0d 41 f6 84 24 a8 08 00 00 02 74 02 <0f> 0b
48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 41
 RSP: 0018:ffffc2bdd2fafb48 EFLAGS: 00010002
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000027
 RDX: ffff9fb1bee9b188 RSI: 0000000000000001 RDI: ffff9fb1bee9b180
 RBP: 000000000000001c R08: 00000000ffffbfff R09: 0000000000000001
 R10: 0000000000000003 R11: ffff9fb1beca0000 R12: ffff9f96762bab80
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff9fb1bee80000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0bfd7b0000 CR3: 000000027762e003 CR4: 00000000003706b0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? __warn+0x7c/0x110
  ? psi_task_switch+0x13b/0x230
  ? report_bug+0x14c/0x170
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x13/0x60
  ? asm_exc_invalid_op+0x16/0x20
  ? psi_task_switch+0x13b/0x230
  ? psi_task_switch+0x126/0x230
  __schedule+0x954/0x1150
  do_task_dead+0x3e/0x40
  do_exit+0x6f0/0x970
  do_group_exit+0x2c/0x80
  __x64_sys_exit_group+0x14/0x20
  x64_sys_call+0x14aa/0x16a0
  do_syscall_64+0x64/0x100
  ? __memcg_kmem_charge_page+0xdc/0x1d0
  ? do_fault+0x270/0x490
  ? __handle_mm_fault+0x321/0x1280
  ? __count_memcg_events+0x53/0xf0
  ? handle_mm_fault+0xa0/0x260
  ? do_user_addr_fault+0x33b/0x5b0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  ? clear_bhb_loop+0x45/0xa0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f0c00c5365a
 Code: Unable to access opcode bytes at 0x7f0c00c53630.
 RSP: 002b:00007ffc678fba38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c00c5365a
 RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 00007ffc678fba88 R08: 00007ffc678fb938 R09: 0000000000000018
 R10: 0000000000000008 R11: 0000000000000246 R12: 00007f0c004db8a0
 R13: 00007ffc678fbab0 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---

