Return-Path: <linux-kernel+bounces-222532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2591035B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF951C21661
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0D42ABA;
	Thu, 20 Jun 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bj6MOS+L"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5451ABCD6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884062; cv=none; b=t7QxxBlpH4KcozFIVug6uMg6MGRfGXwTDhW0gW34UI9xv8jiMRw081CPUOLs1CZPdYZkT8nepVT4AmDcTK93e6BUPATWVUHUznZFayqhVt2oVa+6N3zEJfY+6sP8PB+lh8NeSZCj0hq2AxD3LaasrezO7MXmG9a2WFg62C+pVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884062; c=relaxed/simple;
	bh=6qIB9XcSMPAgWlb3vQK2xuvQgl05RZ3eK3FWt+zdbRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8YQICKqjU85QbiWfS9nqXF7FUI++kl0UQb53Ai8So6b+gmoK18h5wnoiOQZlcv2zXmWTUnOgFFnU/KqCm9JjFWSCr1sgDw5smDA12jGOK5LUsFlOlZAFFZh0lUIBE/eBcYMXNkMQpTzZ7b1JxTlzMFs9PBIwgUMN19HuqGMK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bj6MOS+L; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b5136965a7so2879726d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884059; x=1719488859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDwdH5z/zkL6+tbqxf8Riv9fVhDg6OuGLlTLaC/xubk=;
        b=Bj6MOS+L86bkhJlMd4FzppCS5secPq/ZT7IJSA6lzbxH3QNf4CXTG8Dql1KsVwaZPG
         W8hLRHO8qZCnzvOJb1miUaTOhGj02GYVHYTlWaQ227iwwWJzhHDj4yg6bnmHEMyAJX0D
         JzqUPx9MQx8Vr7cSgEovfgiI9bfIr4HhFxJFok0jiM2VmOT8aDNZcy26tj807cPpw6Tm
         sr3kjEAYe7VpE6T2Qs7Wd3Xy7s/FSpWUhgw3ggQAOSC0xmspEwzFIPJ/aEco67WLhAzs
         kpX0s2luaxj//0KQ5pL8KxAgss2z8NVh9zNY60eKjboVRCMVKifqnI0E2Vb3B6cER6Bt
         ByqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884059; x=1719488859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDwdH5z/zkL6+tbqxf8Riv9fVhDg6OuGLlTLaC/xubk=;
        b=mjFLX9UYniASJb0bU1T15tjcFqgyg2YeZ0wgXHeIcrUKLGI1WwT7ZGYQ/QIwj++/lT
         5QF4qJzU+RdMgbFaROmWya/feDGF7KMn+YVLsLwCanzcFJtHKTsPeyaEHKI4ubhAdqfx
         vmrLF+Q6PRJZF5Z43JPjdaERLHxxNW3GlebYWTl9jBacOBy7+Z2Oq9Q0vBkYeWYqM2K1
         p/6r8EAk6uE+J/Sw90tnu3UsCy/n0z97lVbg4ZaqzQW0npdEUjTQv0zZ/spLvciIhgSJ
         N8DqHVKfLKwm/POyq3cDluw5lpuHq/mp+BgVzoxw6jegnhql13k5EIfCoCOzQmty8Uyj
         lf6g==
X-Forwarded-Encrypted: i=1; AJvYcCWwzSs3bCIWBt8Cj5ZXpe1Fua6iGBndUMI652VgbLYiO8Md7s9y+9o4mY6nVohr5yQXHzEUrVLad6KzXp0CI3p4ZBbDNXCzvCwqqx8o
X-Gm-Message-State: AOJu0Yxhq6rVJztazFbVo98vU1nsFnY+aFNKa7ywrptiWzsp5yo8y7X7
	fsnVHWXIjMqAfwQ+/rnskp9Bz8ANFU6/5NWcF/BN/hyymkldN7icq7oCDjVtMcgkNKD+DZhx3bF
	Pv211yLF5oFTj82D/pZ2HUjaeaax8OQbehVyv
X-Google-Smtp-Source: AGHT+IFTZb3hcmYsSPaMTpBvK5gmxppyrh4SewXIlDFuNry/LTMFMH5GyZM9u3XI0dP08A7JVHvNAIlAK7pDQ5tOFHQ=
X-Received: by 2002:ad4:5a4e:0:b0:6b2:cb24:f395 with SMTP id
 6a1803df08f44-6b50b2a314dmr32156226d6.39.1718884059087; Thu, 20 Jun 2024
 04:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-34-iii@linux.ibm.com>
 <CAG_fn=V8Tt28LE9FtoYkos=5XG4zP_tDP1mF1COfEhAMg2ULqQ@mail.gmail.com> <aaef3e0fe22ad9074de84717f36f316204ae088c.camel@linux.ibm.com>
In-Reply-To: <aaef3e0fe22ad9074de84717f36f316204ae088c.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 13:46:57 +0200
Message-ID: <CAG_fn=ULC+vUH2d9bPhFg9xQDnm6fUmsaDkiPFauw8WhWoMzLw@mail.gmail.com>
Subject: Re: [PATCH v5 33/37] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:19=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Thu, 2024-06-20 at 10:36 +0200, Alexander Potapenko wrote:
> > On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm=
.com>
> > wrote:
> > >
> > > put_user() uses inline assembly with precise constraints, so Clang
> > > is
> > > in principle capable of instrumenting it automatically.
> > > Unfortunately,
> > > one of the constraints contains a dereferenced user pointer, and
> > > Clang
> > > does not currently distinguish user and kernel pointers. Therefore
> > > KMSAN attempts to access shadow for user pointers, which is not a
> > > right
> > > thing to do.
> >
> > By the way, how does this problem manifest?
> > I was expecting KMSAN to generate dummy shadow accesses in this case,
> > and reading/writing 1-8 bytes from dummy shadow shouldn't be a
> > problem.
> >
> > (On the other hand, not inlining the get_user/put_user functions is
> > probably still faster than retrieving the dummy shadow, so I'm fine
> > either way)
>
> We have two problems here: not only clang can't distinguish user and
> kernel pointers, the KMSAN runtime - which is supposed to clean that
> up - can't do that either due to overlapping kernel and user address
> spaces on s390. So the instrumentation ultimately tries to access the
> real shadow.
>
> I forgot what the consequences of that were exactly, so I reverted the
> patch and now I get:
>
> Unable to handle kernel pointer dereference in virtual kernel address
> space
> Failing address: 000003fed25fa000 TEID: 000003fed25fa403
> Fault in home space mode while using kernel ASCE.
> AS:0000000005a70007 R3:00000000824d8007 S:0000000000000020
> Oops: 0010 ilc:2 [#1] SMP
> Modules linked in:
> CPU: 3 PID: 1 Comm: init Tainted: G    B            N 6.10.0-rc4-
> g8aadb00f495e #11
> Hardware name: IBM 3931 A01 704 (KVM/Linux)
> Krnl PSW : 0704c00180000000 000003ffe288975a (memset+0x3a/0xa0)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 000003fed25fa180 000003fed25fa180
> 000003ffe28897a6
>            0000000000000007 000003ffe0000000 0000000000000000
> 000002ee06e68190
>            000002ee06f19000 000003fed25fa180 000003ffd25fa180
> 000003ffd25fa180
>            0000000000000008 0000000000000000 000003ffe17262e0
> 0000037ee000f730
> Krnl Code: 000003ffe288974c: 41101100           la      %r1,256(%r1)
>            000003ffe2889750: a737fffb           brctg
> %r3,000003ffe2889746
>           #000003ffe2889754: c03000000029       larl
> %r3,000003ffe28897a6
>           >000003ffe288975a: 44403000           ex      %r4,0(%r3)
>            000003ffe288975e: 07fe               bcr     15,%r14
>            000003ffe2889760: a74f0001           cghi    %r4,1
>            000003ffe2889764: b9040012           lgr     %r1,%r2
>            000003ffe2889768: a784001c           brc
> 8,000003ffe28897a0
> Call Trace:
>  [<000003ffe288975a>] memset+0x3a/0xa0
> ([<000003ffe17262bc>] kmsan_internal_set_shadow_origin+0x21c/0x3a0)
>  [<000003ffe1725fb6>] kmsan_internal_unpoison_memory+0x26/0x30
>  [<000003ffe1c1c646>] create_elf_tables+0x13c6/0x2620
>  [<000003ffe1c0ebaa>] load_elf_binary+0x50da/0x68f0
>  [<000003ffe18c41fc>] bprm_execve+0x201c/0x2f40
>  [<000003ffe18bff9a>] kernel_execve+0x2cda/0x2d00
>  [<000003ffe49b745a>] kernel_init+0x9ba/0x1630
>  [<000003ffe000cd5c>] __ret_from_fork+0xbc/0x180
>  [<000003ffe4a1907a>] ret_from_fork+0xa/0x30
> Last Breaking-Event-Address:
>  [<000003ffe2889742>] memset+0x22/0xa0
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>
> So is_bad_asm_addr() returned false for a userspace address.
> Why? Because it happened to collide with the kernel modules area:
> precisely the effect of overlapping.
>
> VMALLOC_START: 0x37ee0000000
> VMALLOC_END:   0x3a960000000
> MODULES_VADDR: 0x3ff60000000
> Address:       0x3ffd157a580
> MODULES_END:   0x3ffe0000000

I see, thanks for the clarification!

> Now the question is, why do we crash when accessing shadow for modules?
> I'll need to investigate, this does not look normal. But even if that
> worked, we clearly wouldn't want userspace accesses to pollute module
> shadow, so I think we need this patch in its current form.

Ok, it indeed makes sense.

Reviewed-by: Alexander Potapenko <glider@google.com>

