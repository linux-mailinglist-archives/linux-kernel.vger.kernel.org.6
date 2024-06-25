Return-Path: <linux-kernel+bounces-229509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0C917051
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7AC1C23472
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8D179206;
	Tue, 25 Jun 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IIuOevkE"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928D1E485
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340286; cv=none; b=W5jG7B2VDBqcr+MGPrIHF5jNJ/LLS6l+4x+M0YrzY1O2wNTJDqHwept8p7SMHmCBX/HTDe/8+EIdyMQvz4GXkmhNs01PY/bhuw5Vo8VWVhIwQ2S6b4bHBT/5fn6oDl6gJdrvfo2c0pkwINjT/bt+X+o0SM25kRuEIdKBHe0gMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340286; c=relaxed/simple;
	bh=01n+iA2XY/JcHtXGIz7V72LJ4/6ZPTLG8Jbz/Pa3XM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH9FoCtBobMhR6SOf0dmMnnctSwlCkF/lbfdIgfQbA8qxOrk9yNQes1QvHD+flbXl8dr8L7KoSg7onVrCY3kSPgzclz0tQEayuXS4NxBC0uNOofpVJDLwbtxPrNYH2MGXVnnR3WQy9KKKp5tlLk7lLwlTw0Wpad+muw+E2hG7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IIuOevkE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso7404390a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719340282; x=1719945082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9EZeqDS86Jj/CFHQ+IhN1q/yBvceksX0X7aiOh86ro=;
        b=IIuOevkEZWJV+BDEseejBoiIvzSmrrvL+qtnm5MlrV9cF07OU5TXSNdFr1qLTYWGAG
         6ehg8T61K5wEP4yNsBdUPM8q4WMtNA2kkJsIL2eebtoYNAyR1yLEVn4fCzqdY1TBbf0z
         t9NpYdd1EgrTF6Omj/gaFb4rhR/caKysRKcII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340282; x=1719945082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9EZeqDS86Jj/CFHQ+IhN1q/yBvceksX0X7aiOh86ro=;
        b=q/HSLovuEleYwh9A2yee+ogIeKw1FLH+ZW/NsiehHQxyj/6DpzTrt63nZyq4wwpqsb
         BxLhm0dg+yIyUtjqZV36wDKO18MofeeomZK6kHkMYLu/nWoR2/f7lbRg/BbsDJWWc2y2
         Euonm2hg3YZjw7+IVS6A/zE40CFL4moxumvl0OG5P/69URO8dkevBc5FgrJkMqxK6kbq
         0gbGzoYeSM/Si7wMeXHhUQXjOttRRvp/QePUbeQeuvowakHVImglSl+dtVU9v/zvrV0W
         2bKCshcNEt/cmAgTq+CxB7lrlC5RlyF17PSAENGxekhMrpNsTMEOasW7rN3cAt8V6oV/
         qJyw==
X-Forwarded-Encrypted: i=1; AJvYcCXY6TDtfMwocV6WaL+n3IjI1dkO7Kb/6PblOib4pWtbITOcTJDnz3XJH9v6xBqI2hoK3jmAJzIX2gB/yDS3o7/rQ44mHs5FgQQ6BN6M
X-Gm-Message-State: AOJu0YxvRRbr26t7bPJJKxNY0Vo02XZMszaIJuyIusa03qt3jgwM4oQo
	R2Lnmw0wI3yshmNEkZO02Oux5Z1VAtrLYpVTgNMezoAXK+H9gEz2rBRWxvLXnObnVgXJpQOt4HY
	b642tig==
X-Google-Smtp-Source: AGHT+IHWt5mHR8p92lCjT+DUYVytWtD5O2XQ9p2vdJtODyIJJdaAAKfZ7MvRgsIZrdqHP4+6eAvzAQ==
X-Received: by 2002:a50:aa96:0:b0:57d:f84:11a9 with SMTP id 4fb4d7f45d1cf-57d4a28e2e3mr8331836a12.22.1719340282440;
        Tue, 25 Jun 2024 11:31:22 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3058287fsm6178185a12.95.2024.06.25.11.31.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:31:21 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a727d9dd367so98518566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:31:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpM+z+k0BgfYUiaJJwS6SGorDYJxtp5D0WP3gfLPvrromJH7azHbTqAHdXsDq0wuom8bVtp0Xyzbc3Z2nmaeKPOv1BpFLZITtr96U0
X-Received: by 2002:a17:907:cb20:b0:a6f:489a:3a28 with SMTP id
 a640c23a62f3a-a7242cdb40amr569907066b.61.1719340281233; Tue, 25 Jun 2024
 11:31:21 -0700 (PDT)
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
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
 <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com> <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
In-Reply-To: <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Jun 2024 11:31:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
Message-ID: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

[ Sorry for not being hugely responsive the last few days - I was on
the road for a family get-together on the east coast, so I spent time
on airplanes and hotels and I don't particularly enjoy working with a
laptop ]

On Mon, 24 Jun 2024 at 08:42, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> >
> > I'm sending the patch out in the hope that another set of eyes will
> > make it actually better.
>
> + _lock "cmpxchg8b 0(%[ptr])", X86_FEATURE_CX8) \
>
> This can be just:
>
> + _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \

Thanks, yup, will fix.

> - if (unlikely(!ret)) \
> - *(_oldp) = o.full; \
> + *(_oldp) = o; \
>
> This one should really update only when cmpxchg fails.

The thing is, when cmpxchg doesn't fail, then oldp should already be "old", no?

I mean, by the very definition, atomic_try_cmpxchg() can *not* be
successful if the new value didn't match the old one.

I mean, just look at the very doc you point to - the "definition" is

  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
  {
    int ret, old = *oldp;
    ret = atomic_cmpxchg(ptr, old, new);
    if (ret != old)
      *oldp = ret;
    return ret == old;
  }

iow, it only returns success of "ret == old", and "old" by definition
is "the contents of oldp".

(Here "oldp" is a local variable, not something that can be changing).

So I *think* the whole

    if (ret != old)
      *oldp = ret;

is actually counter-productive, and could/should be just that simpler
unconditional *oldp = ret, because you have two cases:

 - ret == old: the assignment doesn't change anything and is a no-op

 - ret !=- old: the assignment needs to be done

but doing it *unconditionally* means that now as fat as the compiler
is concerned, the original *oldp value is unconditionally dead, which
sounds to me like it should be good for register allocation (the
context here being that it _looks_ like a pointer access, but it's
really meant to be a "in-out argument in a register").

Now, in practice, I suspect that everybody checks the return value and
"old" is never used afterwards in the success case, so in that sense
this doesn't matter and it's all dead regardless.

But it seems to be a complication in the docs and the implementation.

Of course, I may be missing something completely obvious, and/or you
have some subtle code generation reason why you prefer the conditional
there. Feel free to explain,

             Linus

