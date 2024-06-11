Return-Path: <linux-kernel+bounces-210298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C7904206
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7EE1C24BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B9A4DA00;
	Tue, 11 Jun 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R/4NmU+W"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72948CCD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124999; cv=none; b=pOj2IWNYykXKwcV5Bw6mafes1ImiN70UXUcM/L/I8Dizmu1yb94JoCReEwKRqmPlQencHL4U5yAqtiWqmgGoVzEM/5xz3D9PGUeHfWnbgpvIjByDu2DgRQMaOw9+ToQlxECAGCWSqj+NxqgVl9WnwmEtHmBfSRAMZh7SC0Sv2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124999; c=relaxed/simple;
	bh=o29lQlHY6pBB5D1miRHhOsA44JWXgR9MvIZMXmk7GOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJCwEkM4eI1SKRbaGbPIo0V8w8gaCeG4cf/D6XrV81PZ+POnl80SuCkS2shYAXeimWaC8sYY8JGS86p34nq7acXEVR/vH+41d0RL0pxbwb+3RLKlugM0+cyoB46lwQJAZnSkBcbJ0jCmNcasWqmoPo1T+/ckrRKn2y0dOS2NzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R/4NmU+W; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1567773a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718124995; x=1718729795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fd3UL80BMA34VQCo8tmKRzc+M7L8fT8pwxngoicvPg=;
        b=R/4NmU+Wuz/rBDw2TOarfy0eq39D/abecawkkTiTcgiObG8r+NmdI4/uOH9fOkCOI9
         aBAq+c/z+6+dYBngFmBUl8WIOqM3wVDs+Yz9/k5ER+T88utxsRZTDHXhWcSsUF1B79xY
         05I2NgVzJDRnGduGMoSzLNvNIL+Isv7VnRtSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124995; x=1718729795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fd3UL80BMA34VQCo8tmKRzc+M7L8fT8pwxngoicvPg=;
        b=R8sJIMVEnoXFiuO/Ba+ZU8qsWL0CvB5LSSHeTefPgorfRrxirRKpUAjXKrQXJazzv+
         PfCk4SvLVQdYbFhSjrFZoi9IGY5+CnJtsvE2Z55Yk657ohLzLaxcpWWb3gb578TER5m2
         ijSxmJn3RmYMJDUVHw19LZdrkpC25LtQZuRuy2VeozO2ZRL8s0y/uiAJvIkjIJvR3T7G
         lhfYwEOU4cWsCEoOTo0Ljj48j5BZO0ysoyzEsp7hjJoPrlu2ksS8ppOeVygVFpLFaaVr
         HDBZLyb4bddzEtKYNd6vR6op28AtbHVjaysQ+qLfrh0hQ+zIKztHQsNUJ6qImCBGTzUT
         xm5A==
X-Forwarded-Encrypted: i=1; AJvYcCVB5FdNeKtVsu00Jr3R1ooYTm0xWWh2g1tpu2CaOu6FbNPwIPriERn4ooCFJRhE4GNQb+Ow9i3T9YRvUq54eAUM1F9GMnGIfSlNRqPI
X-Gm-Message-State: AOJu0YylFGDBs365mc9rAb2Nzsw5AnWFh1s6snKLZy7GGHwZL5Q1RGJ4
	u6uFpbtRSZRI5uA23BSh8U8QeitgK/kF02a+s9KOgn3TZ1SyqtzAiaMQy29/C0QmzVKlTcJY1+Y
	nb0k=
X-Google-Smtp-Source: AGHT+IHaWVGr2vHVhPlAZAy2LAvs1fNVb/si+x1K1Pr4aQ2g6MxIy6wsEJlkvjIDIaJm0K7Uo/BM6Q==
X-Received: by 2002:a50:8719:0:b0:57c:8022:a3d9 with SMTP id 4fb4d7f45d1cf-57c8022a9demr4562505a12.20.1718124995362;
        Tue, 11 Jun 2024 09:56:35 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c9d5e29e9sm809232a12.2.2024.06.11.09.56.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 09:56:34 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so181249866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/i8DLcSLU1NKy+BxXAJH1qkQBITpfM9qF1pqwpvU/59t+a7lezSz9yYwJLsum3MG215ZUisDa3L/6SaNGkZgw3VT48kWkkPpeTukh
X-Received: by 2002:a17:907:72d3:b0:a6f:1f4a:dfba with SMTP id
 a640c23a62f3a-a6f1f4ae1eamr427237266b.43.1718124993806; Tue, 11 Jun 2024
 09:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
In-Reply-To: <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 09:56:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
Message-ID: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 07:29, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Do we expect to use this more widely? If this only really matters for
> d_hash() it might be better to handle this via the alternatives
> framework with callbacks and avoid the need for new infrastructure.

Hmm. The notion of a callback for alternatives is intriguing and would
be very generic, but we don't have anything like that right now.

Is anybody willing to implement something like that? Because while I
like the idea, it sounds like a much bigger change.

> As-is this will break BE kernels [...]

I had forgotten about that horror. BE in this day and age is insane,
but it's easy enough to fix as per your comments. Will do.

> We have some helpers for instruction manipulation, and we can use
> aarch64_insn_encode_immediate() here, e.g.
>
> #include <asm/insn.h>
>
> static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
> {
>         u32 insn = le32_to_cpu(*p);
>         insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, val);
>         *p = cpu_to_le32(insn);
> }

Ugh. I did that, and then noticed that it makes the generated code
about ten times bigger.

That interface looks positively broken.

There is absolutely nobody who actually wants a dynamic argument, so
it would have made both the callers and the implementation *much*
simpler had the "AARCH64_INSN_IMM_16" been encoded in the function
name the way I did it for my instruction rewriting.

It would have made the use of it simpler, it would have avoided all
the "switch (type)" garbage, and it would have made it all generate
much better code.

So I did that change you suggested, and then undid it again.

Because that whole aarch64_insn_encode_immediate() thing is an
abomination, and should be burned at the stake.  It's misdesigned in
the *worst* possible way.

And no, this code isn't performance-critical, but I have some taste,
and the code I write will not be using that garbage.

> This is missing the necessary cache maintenance and context
> synchronization event.

Will do.

                 Linus

