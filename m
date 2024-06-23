Return-Path: <linux-kernel+bounces-226349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B7913D57
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74D71C20F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73161836CB;
	Sun, 23 Jun 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiGb7GBy"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB09183063
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164620; cv=none; b=MTsG3RnPLFpObhQpwCx5t3jJiihDHcznPahoOLPiBCsqWI/uXvLwODDc516AAOTw9MrJotyJuslyQpCQ7sJkgSt50mermb9X0JwaDS1gO7GZ3uYUY1HoHuwk76bNnqK9CbIj81XXpTem0zG/uuHMXEUmLHPW2UgjQTgYK0bniNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164620; c=relaxed/simple;
	bh=v+ZzpdCRjAELgpAEmY0vdwMmaX/MIfHlmnjpv5P6J2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E88G/+E4bkx8+/YC1cQKS7OzzRWzFKadu+XKHrPMau3/cPrf94UnqNN0mCinNgqMasVOpgfw0z8q2awcpZs5MekTeYPwQi3vuLmnQiAWnTXwGJbITE1Wx5Gt8jHPjhLdJxfTujaV8aX7QrPdsUOZTYfjBnTYXP23MXvizjtvOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiGb7GBy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso31464711fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719164617; x=1719769417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK/T5O0+4Mc8GYDVFOJ9RT6rq1/f7Kk7IQFox0VDAto=;
        b=PiGb7GByBM6MvUXm27snjoGQ1trf6a1+IURcgBk7r4g8zGAdv7xr3cisFDiqsPbT+z
         5LCebatnUCbGvex4uBYK1CYvKAUfLo+J+124jfUDWLmq5XoE5Cvp+rgRQOPO+T8c7XLj
         zf0raThttm20oOE2CguoqSDbY/sh6CdnEIVS/BRvwpZZRXzrIRAPT7uI0xQb0ll3PDS5
         C1J7As6bsTuihR0D4u4x7x5Hx2GWHDIOtlZOp2Aog7SdAy4ZPoaZQbXKOTKCQe1gng0k
         Hkzxx7kHw75u0sb8hG5Tfxkgg5ftrxMEGj12w66kcf4Bgm2WR7y1HEIKGz64BPYr3YGq
         BBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719164617; x=1719769417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK/T5O0+4Mc8GYDVFOJ9RT6rq1/f7Kk7IQFox0VDAto=;
        b=hE2/dj7gkc9uAotudGQcZaK9aumOtDjG9JKUt+w86bbidIj0AxOMWb5aWVjaVsDtvP
         iRcLQiuSIURJr4tTHr8GBaQPqcl2vPUBCWl87CTJOIFtbF3IqAhee0bw2q3Y6ZupaIDL
         gOwjXux+svJNcGUMeC60ZWPFlDy1waDa1DyukwcAtOIb4yxWXbRW9dCvmuafasisVg/D
         hidqRWqhLU1TIdRMaQjoLCqrkTYcFzMHgFDi46o3J2akaAJcvUasYNyuMpJQTFflagOZ
         ZCdN0CN//iUbY9eLVwugD8Ggiz/EACuwx3jmskn1qpMi1J+Jn8hNRN5FT2PSCTyqtRuO
         ur1w==
X-Forwarded-Encrypted: i=1; AJvYcCVmYd3DMeH61fa7Oa4fCU4eFbRvMjQH6gaF7S4OYIczPrzPQbI1BzSppeicI98hw7u5r7c2F3M3Z6GGrt89/fuTp8eQ2pzjZ5OX3KKO
X-Gm-Message-State: AOJu0YxHCEeiHhkLNEJ6H1t5tGhrtYghoms7DQ9z0bbk8qKfdTlGRw9P
	Jpiwq0oXWr5cfJAxxARaqfnqZ1L9Qy85w2ZbD39hPnVKpgO2PJRnM+nPLNMd0lK26tTuvS//PA9
	FTZWCim4MCF0DbbQSQT3RJ7MjfPI=
X-Google-Smtp-Source: AGHT+IEOcLQ3UCLmDTs0ks/TZ1OdR1osUEIXt4VLxPlVwVfkbBEoE1W7hx9wfQrDPmzZJmPFfx1Ps9mC/lGEP8a/r70=
X-Received: by 2002:a2e:8508:0:b0:2ec:505e:c45a with SMTP id
 38308e7fff4ca-2ec56cb006bmr10878621fa.24.1719164616286; Sun, 23 Jun 2024
 10:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 23 Jun 2024 19:43:31 +0200
Message-ID: <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 5:42=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 23 Jun 2024 at 06:14, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > The referred patch actually mitigates the issue, as explained in
> > details here [1].
>
> Clearly not.
>
> It might help things in theory, but in practice it clearly just makes
> things worse, and causes problems for clang.
>
> And the thing about practice is that it always trumps theory.
>
> > So, without some interest from x86 maintainers, the issue will remain
> > unfixed. If they want x86_32 arch to die then inline locking
> > primitives involving cmpxchg8b are one of the nails in its coffin.
>
> What? No.
>
> That commit will get reverted. It caused problems, and now you are
> blaming others.
>
> You can't just go "I caused issues, but the x86 maintainers aren't
> interested in this area, so it's their fault".

I disagree with the above. There is no one to blame, let alone blaming othe=
rs.

The cmpxchg8b is a complex beast, It needs 4 input registers (a pair
of them inout) and optionally 2 address registers. When the frame
pointer is active, the instruction can consume all available registers
on x86_32, so the compiler has to work extremely hard to satisfy the
required insn constraints (and also pass live values over the
instruction). The two examples I quoted in my previous mail just
illustrate this.

> And no, "improved code generation with one compiler version" does not
> then mean "other compilers don't matter".

Using try_cmpxchg *improves* the situation, as there is a double-word
value that does not have to be live over the insn. So, leaving the
situation as it is will just trigger the issue later. We had exactly
these problems in GCC with __atomic builtins, and GCC learned how to
handle this extreme register pressure.

> Now, I do suspect that the issue is some very random thing that could
> be fixed by massaging the inline asm a bit.
>
> For example, why does that 32-bit __arch_try_cmpxchg64() do this:
>
>         if (unlikely(!ret))                                             \
>                 *(_oldp) =3D o.full;                                     =
 \
>
> when I think it would be simpler and more straightforward to just do
> that *(_oldp) =3D o.full unconditionally? The "dereference" is purely
> syntactic, the intent is that the compiler will just use a register
> for this all (well, two registers on 32-bit), and making it
> conditional makes things worse, because now that "oldp" register
> cannot be the same as "o" itself.

The  primitive is written in this way because we would like to use it
in a cmpxchg loop, as well as as a condition in an if clause. Without
the above referred condition, the compiler will emit a dead store in
the later case. I have tested this macro extensively, and the above is
really the best we can do, it results in a tight cmpxchg loop and
without unneeded moves/stores in code without loops.

> I didn't look very closely into this, but maybe that would just fix
> code generation. And maybe it wouldn't. If there's no other fix
> somebody comes up with, we just have to revert.

As said in my previous message, if the compiler can't handle
__try_cmpxchg implementation, the most straightforward and reliable
solution is to implement atomic64_{and,or,xor} as outline functions,

Uros.

