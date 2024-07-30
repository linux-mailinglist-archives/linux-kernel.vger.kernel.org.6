Return-Path: <linux-kernel+bounces-268074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6494200D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EF41C22CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C64518A6DD;
	Tue, 30 Jul 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H6EDESz8"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003B1482F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365634; cv=none; b=jauVMYxhBRQ43ULjoUhRznc2J+jh3wv2ugpQWcuvxaNlqUwYzkm2dypnbM2iM+LB+vtNmNc2/Y2IfAR5zyfPqgsUuEkJWQenGjkHDwOldBPlGOwW0dpFn5y5z0w+2OpGt5qJb99HgB7pexoni3KS9K+fEamY9bociCMndvA/fXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365634; c=relaxed/simple;
	bh=BUOJ19Sx2S+tjma5mr84benPkdA9XqkBnmJ6+BWRz7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhIBW6JOVKsTUfh7Fl06TAyOjpfDFbJWwzjFok/rNBUB7zw4CWYprfChBpyEWOolhQjQLmK+yqhB7aC1PmsX2VyDwDhiHAfWj6R6OAAtW50M3LH92LV7FH5l0QP6Dwo5Ph/iyblE8/wqb7SHGZ/gtBagJkvof85l3fhc/HaMZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H6EDESz8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7abf92f57bso638181366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722365631; x=1722970431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/aWSJuydHws7A1g+QbY9VBGsBopZyR9+EuLrgpUIJk=;
        b=H6EDESz8jzbTcfArGm4A8klGXIeTPe0kp9sPhZIbuWS3tnq0l8vFxPPK/GoxA/fkJw
         +FGpAyWQFheX/mQyueMY/1iP/bkCXHy1JfiyRI2VbknozHaSRweSJNC9o11KjoWzP0uX
         DKSyAR4/AmruQQrzmYBV5mpqJAlu1fSspceVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365631; x=1722970431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/aWSJuydHws7A1g+QbY9VBGsBopZyR9+EuLrgpUIJk=;
        b=BkTc6dZBeCHJIQsYn2O6P9o4UR6zsqAfkVAcJOyAjyE6GR5etohnabR5UZWBHQ1Efy
         qE5COih5pE+v5vBWsxZaeUL388xgrZBnj2ngbG02tdquf8U1wggjz4URcz6Wp8XjCMXg
         mnQ+raUd8d1FMbtvAAxHEuSRv5dB+gFX082a+XqHHmMs9UiJ/hatrM2s1ci22RfiorRf
         P/7Nb8y84rZW4JmlDQWNpV6jvh6Gmu5CfM5AOE39HKY+4WG22X/vi6lBlt+A1KM8SBv9
         KwXseSwqz6WfuUYkDCgDteKb/G8U6HkaCxdvFPxVhyvXbzuiQx+FJ7/56VPFbtiKWGwU
         9rlQ==
X-Gm-Message-State: AOJu0YyqSnzgezF3QVFRuvJ0bZg4FjENmD2sxMaFENOaTfemQHE3AKLI
	UWF4jrM5YmZAMk4hAYBmXmoxw+r7Gcs0GK31JXOuLdidkxzP2xgkLUglQSu3WIHQxg6jujS+6JS
	P9GqUfQ==
X-Google-Smtp-Source: AGHT+IG3LwQh3JCiObWLnldwNdkRHd4vDhBreyHhiGuV3NSC/ccG+ob928PPm4Gj6iQYQIlTOatyOA==
X-Received: by 2002:a17:907:d06:b0:a7a:8cc7:ca48 with SMTP id a640c23a62f3a-a7d40128924mr845050666b.46.1722365630586;
        Tue, 30 Jul 2024 11:53:50 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab536cesm676680066b.84.2024.07.30.11.53.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:53:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so6855046a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:53:48 -0700 (PDT)
X-Received: by 2002:a50:aa8a:0:b0:58b:35ef:88c4 with SMTP id
 4fb4d7f45d1cf-5b0223da61bmr6687869a12.37.1722365627759; Tue, 30 Jul 2024
 11:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
In-Reply-To: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jul 2024 11:53:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
Message-ID: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Anvin <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[ Adding x86-32 entry code people, more context at the thread in:

  https://lore.kernel.org/all/3f65bfad-bd04-4651-bbe3-e2b1925f1a13@kernel.dk/

  for people who were dragged in late ]

On Tue, 30 Jul 2024 at 10:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> From the crash log:

The full log is more informative, at

  http://server.roeck-us.net/qemu/x86-nosmp/

which has that config too.

> [    3.605247] sr 2:0:0:0: Attached scsi generic sg0 type 5
> [    3.764508] sched_clock: Marking stable (3740032902, 23766486)->(3766853760, -3054372)
> [    3.768164] registered taskstats version 1
> [    3.768271] Loading compiled-in X.509 certificates
> [    3.990683] Btrfs loaded, zoned=no, fsverity=no
> [    4.005012] cryptomgr_test (68) used greatest stack depth: 6136 bytes left
> [    4.029889] traps: PANIC: double fault, error_code: 0x0

Double faults are bad bad juju.  Nasty to debug, because it means
something went wrong at a horribly bad time.

> [    4.030613] EIP: asm_exc_page_fault+0x0/0x10

Sadly, this mainly says that taking a page fault was part of the
horribly bad time.

> [    4.031389]  <ENTRY_TRAMPOLINE>
> [    4.031392]  ? asm_exc_int3+0x10/0x10
> ...
> [    4.033360]  ? asm_exc_int3+0x10/0x10
> [    4.033368]  ? restore_all_switch_stack+0x65/0xe6
> [    4.033386]  </ENTRY_TRAMPOLINE>

Yeah "restore_all_switch_stack" is also part of "horribly bad time".

And from the full log, I see that the "..." is a *lot* of asm_exc_int3+0x10.

Which makes me think it's asm_exc_int3 just recursively failing.

Which will cause a stack overflow, and then - after a time - a double fault.

[ Time passes, I build the i386 kernel image with your config just to
get an image that looks like yours ]

Hmm. I think the stack dump output confused me. Because
"asm_exc_int3+0x10/0x10" doesn't end up making much sense, but it
turns out that "asm_exc_int3+0x10" is actually the same as
'asm_exc_page_fault'.

So it smells like we're taking a page fault, but somehow the page
fault text address has been unmapped, so taking a page fault causes a
page fault and then we end up finally in that same "no more stack,
double fault" situation.

Either page table corruption, or some issue with the page table mitigation.

The fact that it started happening with the block merge may be because
the block code causes some major corruption, or may just be random bad
luck and it just changed some alignment somewhere, and exposed a
hidden but pre-existing issue.

Jens separately said that he can see it with gcc-11, but not his
regular compiler, so regardless it seems to be compiler-dependent.

Let's see it x86 people have some idea, but that

   restore_all_switch_stack+0x65/0xe6

and doing an objdump to see the code generation, it is literally here:

        0f 20 d8                mov    %cr3,%eax
        0d 00 10 00 00          or     $0x1000,%eax
        0f 22 d8                mov    %eax,%cr3
        eb 16                   jmp    <restore_all_switch_stack+0x7d>

with that "jmp" instruction being the restore_all_switch_stack+0x65 address.

So the infinite page faults seem to literally happen right after the
"mov %eax,%cr3".

Definitely something wrong with the page tables. But where that
wrongness comes from, I have no idea.

            Linus

