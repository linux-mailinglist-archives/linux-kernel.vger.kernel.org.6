Return-Path: <linux-kernel+bounces-227529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3779152BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816EA2829B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301119D061;
	Mon, 24 Jun 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwMH0R9Q"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3219CCFB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243761; cv=none; b=iO3RAt+ei09Xcasw4ADA1fJL8Xa7tTXeawUKgnBCnEvqixSM7Wr2pg9hKe6rcT5+3D6mdhmBVDOVSGi7FWdsZWZPEN7OYqrwKVetqpscbL4iSjNPWcBLX6rbi9XME4eZaZHEb+Mls0TjYOt73g1sT2fcKPk0AaM3GrSN3D9ERuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243761; c=relaxed/simple;
	bh=4b2NR7ZU6RhCVAQiz4eoi6ItIYSKwVG9ISrse0aWNEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNRpusgqKCQRmKtO30rPPladTZLbJPevqgVUTUUhWR9i5xqgOPxK5O8DV3iJONfWMctP/qZ9f6uL1tHOoU4rC7uL0Q+meTPKK0VU9X1+pU8tcYtrVPezpo620zCdRiRKUStFrPN6gn3xrp/tXnFyRtH/q0Za+MnoxTdZFBJ3xlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwMH0R9Q; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so61765451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243759; x=1719848559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b2NR7ZU6RhCVAQiz4eoi6ItIYSKwVG9ISrse0aWNEo=;
        b=JwMH0R9QsU06pXV1c2IbDViyu7hTLET6J9zlPfm05x0uQfezrreAhGsy1HEG3kwfUf
         jxzoABB4hPR/gkcL/L+7vRixsjcez2MScBPS7GNjctpJkBcqXSqXwx8d3YTFB0KFcnXa
         yBwh91jBZf6gaobTY9ulCuUJvn5LyMJj//TRvO02+fjFlHOr8GQMNBn3IGJK6gnjGgy/
         kiVLKXl4gKgrv9/FP6HgmCjtGbc6AJ7zHqNRBB9VO7bafTL5B1u64Im/S6KplEs+MvTK
         TK6kyruJtZqfGXVc8raMqIorXEjT9UNyKgJwYpVW5xubjkextMqkMMo4o2h95Sj06r32
         EeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243759; x=1719848559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b2NR7ZU6RhCVAQiz4eoi6ItIYSKwVG9ISrse0aWNEo=;
        b=C/4oOATWnbwKu3+MAKgR0D1XQf0yZ6FzRoJUy5WTAvZGtyFtD48P8hOcNpA9UzpqT0
         Ezm7eNNc7THsxkKZz0ob8/Ptq5ZoqiLzQHgCRPa3C5yoWJCru1vPmHp5s4FCWD89RBDH
         nbb0v5fzbIFBB+4j348gwt2/PkcjBm+BcwIIvXk7mVYeDLi+34UkwVJ9ygPr0Jy954aW
         950M5HRwp8WSfw04R9l766Nf5LNZRuNwOQJagDX0OgxVGLDPXIhSppq88PDwNso+lWZb
         oZJbwKAjQHdR5C2HTJh0tAdGy2z4AqwRN3S85+xZt0XZo4+m2Mb9mIu0YtM12tuwtQ+s
         O3rA==
X-Forwarded-Encrypted: i=1; AJvYcCWWntyPg6Zr9pgs/n1r9K6aC7Yk2jW9BM9JiCm9Y5rbIpCKTzhjKSsLN2dzKgMSRBzugV/XAQTs8+TRXOjOlJXdZI04kfNHuQ01tfAU
X-Gm-Message-State: AOJu0YzXbuGhzXuZf0VFfTKea0tAdSHVKupx0OaU3TuMwYRip471vj1M
	ZKVePpCfPmkhWrqcuntWcRqyg1wBBxZsp48LqZFEDYkb5agAYZE4yQhU/tD9X6E0neFF878GT3r
	MHNQUshzjaVdWGPGV1esRj90bHvw=
X-Google-Smtp-Source: AGHT+IFBxn4USRqyPo0lzjb2M7Hs+SA4MriqfTierRf32hr1TE1t4qrkidUoMFdnifNpyyPHVkyMzoMzywo22FjadXE=
X-Received: by 2002:a2e:9917:0:b0:2ec:4bb7:d7f6 with SMTP id
 38308e7fff4ca-2ec5b2c4daemr36931881fa.7.1719243758350; Mon, 24 Jun 2024
 08:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com> <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
In-Reply-To: <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Jun 2024 17:42:32 +0200
Message-ID: <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 24 Jun 2024 at 09:59, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, 24 Jun 2024 at 03:36, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > A real fix, not only a workaround, is to rewrite asm arguments to
> > > something like (untested, but "should work"TM):
> >
> > Sadly, I already tried that, and it didn't help.
>
> Bah. I _had_ tried that, but I had tried it on __arch_cmpxchg64_emu(),
> not on the "try" version.
>
> And no, it hadn't helped.
>
> But doing it *right*, and also doing __arch_try_cmpxchg64_emu() *does*
> actually help.
>
> Well, at least the attached patch compiles with the bad config and clang.
>
> I'm not certain it does the right thing, because I did more than just
> the %esi games to try to simplify it.
>
> It's *ENTIRELY* possible that I screwed up. Just in this thread, I
> have looked at the wrong inline asm at least twice now, so I'm not
> feeling super-competent right now.
>
> I'm sending the patch out in the hope that another set of eyes will
> make it actually better.

+ _lock "cmpxchg8b 0(%[ptr])", X86_FEATURE_CX8) \

This can be just:

+ _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \

- if (unlikely(!ret)) \
- *(_oldp) =3D o.full; \
+ *(_oldp) =3D o; \

This one should really update only when cmpxchg fails. The relation
between cmpxchg and try_cmpxchg is documented in
Documentation/atomic_t.txt, section CMPXCHG vs TRY_CMPXCHG.

Does the compilation still crash with the condition?

Uros.

