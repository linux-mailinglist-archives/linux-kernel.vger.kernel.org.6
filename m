Return-Path: <linux-kernel+bounces-336283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5897F18C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F51F22202
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15B1A0732;
	Mon, 23 Sep 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVkgAD3q"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590B10F9
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122373; cv=none; b=ZUM7zqhf3aFyAFEE/KPyYe1OrfJEvvrZpQyN/Y/jumdaZWgyqmff4qwWoAkxEb3dcul/A35w+qL1KA8M7P79IznbI35gUFfyjIKpbxfOcp+7JIm4Tv6OGqKiKLzdoAIo9/oKY56gb5iRC48+3d/yXu/AZ/jy0MUVkAQguZau4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122373; c=relaxed/simple;
	bh=hH3xRKr8vTuEsfKeuRVsWM1cEI884W5DXGqN2EDhINo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwaYHTXSlSw5dHALaIZsJZcoMIAe4yRxEWqPvr4T1s+TAmMPcB+0SS4krlIhqUqEYl8RSb1Sby58Zj3cvaL1OUC0NsjaW4jK7EIw7zLUTLLI+hf3YmN1swpfloWvuAwyPPWVtXMOQTCKeqJTfXAb5yn/PNlO35VTfDaTkXHAdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVkgAD3q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374bb08d011so2630946f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727122370; x=1727727170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPBdIEyeOYukTmx0CMqxttQN8aHSVJKCKKsgOqt2gfY=;
        b=BVkgAD3qpJyAmbt7uaQ1oqgEsQY4uk2XumasWRLD2mgKclW6XekOjF9TtbpORhkIWo
         bijv42iLWPQ7WKp85mYJWRwc6yZQEy6XmLRtryw2aET6jyrfP7TM3oCW6V1ccuQHWJxp
         hmXluFDLJYdZel5sfPBp3X/nKfe2Y6E5dtTxzd2eDdcYuG2Slmhqbku1x+DnJTQ02pjx
         lqsMxoMwI9IzVTFGRFKLspHIQdMPXF70jtm1cHH1ODt4LFAOWnEuFXAayNpZe+vrj1vf
         T370bHR/g5Xz/qbk29pd1un3s0r8hhV5BNTdv8af4AcQ1Ey2plZDX/IpeiJZn1oV4h+A
         +nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727122370; x=1727727170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPBdIEyeOYukTmx0CMqxttQN8aHSVJKCKKsgOqt2gfY=;
        b=Yp0bDQRjrA7j86zquiQCYIVVUf77sJU1A9bmYxWzfFFocPD3h/lL0U/EeTTDfMZsV+
         usPx9lP8Ocy5oJzphOV2u+FAmLBn3QrA6W1Mzsx9RzotyA8mZX+6aSNPSd0OUHSEIqYx
         hx5Bal0P6VRC1DzDuX20mAjHE0rLGv6FBdk8mZe43+rMdqSIY4C6AimHl7CiCeQruC7+
         SYKpWq6YNIaNUOcNtWw0ivpdW7iezTBSk9dBexWY/v3KqogiLqSXdSqpg0YyiUOWYSGd
         Q4VBt6S3R8dBcsBS7lOc6CZpcGQrF5ev2fkpkmvGkaYsZWSI+LW0eQkw0O8AvV7blPfI
         lP3A==
X-Forwarded-Encrypted: i=1; AJvYcCX+veDeODcOPh7zgDvSUC/lj+sseQnr83DR28KAMmZS0Ria6jWQ8CrSSjm6L9OtJmKBtF+VfACmwRZJHvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6VfCI1H6px4wo4/mp7TNY8UUjykZtUzzReXYkrHdM3NUL6El
	8r4FyueqxXnPhZIOyiHeD7ZwRWn3D2PDsPgZABszPQCU+j7ZeMF1lkvnZ1uSppBwaKbzz8T7lbT
	J3xU1cAxOEbADK+6EuWNgqG3hqhc=
X-Google-Smtp-Source: AGHT+IE6OxELI3g2azLm1GlYvD9UV7EKXedkBwenQfQufR2DE7P+5ht3ZXjkvw2gmqfmCUQ/s1+EbU/4hGUVMKhcLtc=
X-Received: by 2002:adf:ed52:0:b0:374:c6b8:50c3 with SMTP id
 ffacd0b85a97d-37a422bf1camr6629942f8f.32.1727122369599; Mon, 23 Sep 2024
 13:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f362e80620e27859@google.com> <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org> <ZvFGwKfoC4yVjN_X@J2N7QTR9R3>
In-Reply-To: <ZvFGwKfoC4yVjN_X@J2N7QTR9R3>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 23 Sep 2024 22:12:38 +0200
Message-ID: <CA+fCnZd6gXtwjBKSnChpT+dF9u8u68q2jVmR=MQHe4JhPBuvtw@mail.gmail.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: Mark Rutland <mark.rutland@arm.com>, Alexander Potapenko <glider@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>, 
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	kasan-dev <kasan-dev@googlegroups.com>, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:46=E2=80=AFPM Mark Rutland <mark.rutland@arm.com=
> wrote:
>
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kerne=
l/setup.c:133 [inline]
> > > > BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/ker=
nel/setup.c:356
> > > > Write of size 4 at addr 03ff800086867e00 by task swapper/0
> > > > Pointer tag: [03], memory tag: [fe]
> > > >
> > > > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller=
-g33faa93bc856 #0
> > > > Hardware name: linux,dummy-virt (DT)
> > > > Call trace:
> > > >  dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
> > > >  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
> > > >  __dump_stack lib/dump_stack.c:93 [inline]
> > > >  dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
> > > >  print_address_description mm/kasan/report.c:377 [inline]
> > > >  print_report+0x118/0x5ac mm/kasan/report.c:488
> > > >  kasan_report+0xc8/0x108 mm/kasan/report.c:601
> > > >  kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
> > > >  __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
> > > >  smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> > > >  setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> > > >  start_kernel+0xe0/0xff0 init/main.c:926
> > > >  __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
> > > >
> > > > The buggy address belongs to stack of task swapper/0
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >  ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
> > > > >ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > >                    ^
> > > >  ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > >  ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > I can't spot the issue here. We have a couple of fixed-length
> > > (4 element) arrays on the stack and they're indexed by a simple loop
> > > counter that runs from 0-3.
> >
> > Having trimmed the config to the extreme, I can only trigger the
> > warning with CONFIG_KASAN_SW_TAGS (CONFIG_KASAN_GENERIC does not
> > scream). Same thing if I use gcc 14.2.0.
> >
> > However, compiling with clang 14 (Debian clang version 14.0.6) does
> > *not* result in a screaming kernel, even with KASAN_SW_TAGS.

Yeah, this is #1 from https://bugzilla.kernel.org/show_bug.cgi?id=3D218854.

> > So I can see two possibilities here:
> >
> > - either gcc is incompatible with KASAN_SW_TAGS and the generic
> >   version is the only one that works
> >
> > - or we have a compiler bug on our hands.
> >
> > Frankly, I can't believe the later, as the code is so daft that I
> > can't imagine gcc getting it *that* wrong.
>
> It looks like what's happening here is:
>
> (1) With CONFIG_KASAN_SW_TAGS=3Dy we pass the compiler
>     `-fsanitize=3Dkernel-hwaddress`.
>
> (2) When GCC is passed `-fsanitize=3Dhwaddress` or
>     `-fsanitize=3Dkernel-hwaddress` it ignores
>     `__attribute__((no_sanitize_address))`, and instruments functions we
>     require are not instrumented.
>
>     I believe this is a compiler bug, as there doesn't seem to be a
>     separate attribute to prevent instrumentation in this mode.
>
> (3) In this config, smp_build_mpidr_hash() gets inlined into
>     setup_arch(), and as setup_arch() is instrumented, all of the stack
>     variables for smp_build_mpidr_hash() are initialized at the start of
>     setup_arch(), with calls to __hwasan_tag_memory().
>
>     At this point, we are using the early shadow (where a single page of
>     shadow is used for all memory).
>
> (4) In setup_arch(), we call kasan_init() to transition from the early
>     shadow to the runtime shadow. This replaces the early shadow memory
>     with new shadow memory initialized to KASAN_SHADOW_INIT (0xFE AKA
>     KASAN_TAG_INVALID), including the shadow for the stack.
>
> (5) Once the CPU returns back into setup_arch(), it's using the new
>     shadow initialized to 0xFE. Subsequent stack accesses which check
>     the shadow see 0xFE in the shadow, and fault. Note that in the dump
>     of the shadow above, the shadow around ffff800086867d80 and above is
>     all 0xFE, while below that functions have managed to clear the
>     shadow.
>
> Compiler test case below. Note that this demonstrates the compiler
> ignores  `__attribute__((no_sanitize_address))` regardless of
> KASAN_STACK, so KASAN_SW_TAGS is generally broken with GCC. All versions
> I tried were broken, from 11.3.0 to 14.2.0 inclusive.

Thank you for the detailed investigation report!

> I think we have to disable KASAN_SW_TAGS with GCC until this is fixed.

Sounds good to me.

Please reference https://bugzilla.kernel.org/show_bug.cgi?id=3D218854 if
you end up sending a patch for this.

Also the syzbot's kvm instance should probably be switched to Clang
(@Alexander).

Thank you!

