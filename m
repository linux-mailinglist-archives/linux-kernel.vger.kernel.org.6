Return-Path: <linux-kernel+bounces-210382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75B8904306
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD33B226DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A8464A98;
	Tue, 11 Jun 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UiLZmZ1A"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D15FB8A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128819; cv=none; b=iD8YoZur93EXzGnRMbayaaW6Iq3SH5O0hvzAdaN2ltagLJ75lTbzaoCIAIioAluRr/8NKKkO1gljV5qIyFriew0Gqz+WjjDVXCtD6P3OPZ1fWFxMdopTngq1xEZ3VG2CihowDcPNK89aML3JECXJyre30e/bfitz7kor2hq2Kw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128819; c=relaxed/simple;
	bh=nwpZTn8pFzGOwf4ZB/VvlBs8EE7Mx/yz85WdIMLghPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGyPP50KKkYKB3sgRRilzuEEK6OE2naZZBOpvEL4m4XD8acLngprXO31BqS2Zb/4zGvS/aL9yLq9/oF4QPAG2THrBib2wIHDfE7qo+W92zdTlNz9P2FdqKZ97S9IKP1EwaENwhllpVWezyTw36PY5vgl1+md8iOFdUBVwuANnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UiLZmZ1A; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso1242250e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718128815; x=1718733615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dfppZ4J9iItfp/zeqA6eCwjM7fUz1YkqRKfl9RCRvzw=;
        b=UiLZmZ1ABvT2swqdEKyDedzRudERfQm8u9YYGQJPaC1dsQVNtdDHmZQp88I1GCIwmK
         U3LfuiDtCRWao/fW8QlAoCxk55G14pR5wHdJsMEYxLDGR8JK2YkDy7DhorQ3EEERJOi3
         dBa8np3BTsZpUqLTv8bHYhGAoZ/GOlgZ7Bobc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718128815; x=1718733615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfppZ4J9iItfp/zeqA6eCwjM7fUz1YkqRKfl9RCRvzw=;
        b=RaD2ZwuvQTVI5vMM7GCWCMig9ZhOOABa5SCwqALqb/ddLwbhY9GqzO4z6Q5+uD/kax
         R6erpLWpuRUvmCwqF+4rry/0uPg/OzKfaYreBdxvhEZS+IZA1aK9n+GmJ3tY0Wuf+9ZX
         rIqAVjaJRrQoyzs8iq84BxkJCYzIBb5PiRyAN+ftiu9jjLBlN0UH5ZlsQuyLArL9+9hg
         TW4rWNMnUlWy7bWmBYTCVUIQxo1DEJI4/q/pM45Zoc2AYEcmFmneiqBYwEYoCoONsJuV
         ghMVfKd/bEgEYesBvHDH7kIh2ihqg+cngcPwjYzCKSkyAEvv20TVDojhTvGegnuoB5VA
         vweQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWEuAcNZ/oWXOAZ9Uq3sYf119/xJ7I9xACOqukm3QgrkY8nQNHsJBEMStJRHOml0enxIbYe9sJw/PzGWglExI8s90VRiBMUHu2/rRP
X-Gm-Message-State: AOJu0Yzji6v3ALJ6/RHxWDDCqKFQFwZFt93K898VngxJPtiyyNHCyvnZ
	Uadpsc60HzLuIrjUL54eN6PFdLMHVudqaVmO7UoY4wd49A5SXeh4qSrcRlQlpwV7yxqzdpkestm
	akB4=
X-Google-Smtp-Source: AGHT+IH4uKB3qd+yxQPA01T38eIpFoTiWsk5CmQhyL55Cv3PU9JLLz06GLvMK73/MNE57kThKKoDWw==
X-Received: by 2002:a19:5e45:0:b0:52c:890e:bf23 with SMTP id 2adb3069b0e04-52c890ebff7mr5540802e87.21.1718128815002;
        Tue, 11 Jun 2024 11:00:15 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f4108d502sm35464366b.135.2024.06.11.11.00.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:00:13 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso1777182a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:00:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5sfqWm5pjyu6CwJEQQzsp3uNIKM9+zFo5IolEoHlFU0meM0BJ499xr7/AkXx1ZN71e6WfU0/AOvA+Bu3zDISvSjhuSPRCgzQRK2/g
X-Received: by 2002:a50:d69c:0:b0:57c:5f7e:d0f1 with SMTP id
 4fb4d7f45d1cf-57c5f7ed498mr8641041a12.38.1718128812554; Tue, 11 Jun 2024
 11:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com> <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
In-Reply-To: <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 10:59:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
Message-ID: <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 10:48, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Fair enough if that's a pain on x86, but we already have them on arm64, and
> hence using them is a smaller change there. We already have a couple of cases
> which uses MOVZ;MOVK;MOVK;MOVK sequence, e.g.
>
>         // in __invalidate_icache_max_range()
>         asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
>                                     "movk %0, #0, lsl #16\n"
>                                     "movk %0, #0, lsl #32\n"
>                                     "movk %0, #0, lsl #48\n",
>                                     ARM64_ALWAYS_SYSTEM,
>                                     kvm_compute_final_ctr_el0)
>                      : "=r" (ctr));
>
> ... which is patched via the callback:
>
>         void kvm_compute_final_ctr_el0(struct alt_instr *alt,
>                                        __le32 *origptr, __le32 *updptr, int nr_inst)
>         {
>                 generate_mov_q(read_sanitised_ftr_reg(SYS_CTR_EL0),
>                                origptr, updptr, nr_inst);
>         }
>
> ... where the generate_mov_q() helper does the actual instruction generation.
>
> So if we only care about a few specific constants, we could give them their own
> callbacks, like kvm_compute_final_ctr_el0() above.

I'll probably only have another day until my mailbox starts getting
more pull requests (Mon-Tue outside the merge window is typically my
quiet time when I have time to go through old emails and have time for
private projects).

So I'll look at doing this for x86 and see how it works.

I do suspect that even then it's possibly more code with a
site-specific callback for each case, but maybe it would be worth it
just for the flexibility.

                   Linus

