Return-Path: <linux-kernel+bounces-526250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F2A3FC23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656B9188A1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374461F4E38;
	Fri, 21 Feb 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJzE5PCp"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C071F3FD0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156493; cv=none; b=ecPJWjF16s7Rfi00obJfJ6e6SoQpMNy4rhObg6CnDmIazyOr1oVJNCyng5mN87ZAxpOXAOTsN7voJ5ulQmnAMc3dVT2h4v98uIMFq7MN+kNaqKQEQSEafZXLMOB0ziRDeSNVnfyUKqATcVlvjZo1/eXKbV16HrUsPnEoiN5Bgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156493; c=relaxed/simple;
	bh=xDkUrjANbu2Ai8OxBpO+59ftWT31QwGEo1BS2CQkGnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIyc5v6/J4NBiHflNpKmZ22dfXgtbKwto22wy+4PYv0DFRu42ElUg4pIid9ncpibTsPvRjjkxV0avijS7nrvAsoOwIy6hs00SrRo+RKtg6gnz01pbnvahYxa3l30HZEf4iGI9pvIRUX+xJ0kutyfBz6kEyw1Uodl3b0u5OhPi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJzE5PCp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439e331cceso2498750e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156488; x=1740761288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2qM4sgfAfTkBWO31bolqN4kVsMXF0DWWxA0NN1kFVo=;
        b=jJzE5PCp7S2/u52ko039QPlIyccVXtIKlyKk3N7l920OlMKk3WuGw/pBkkiqwOAOth
         wGomFldy2daWsp48CGm59XFEwGaBTNrP8oI8zJeuWKajqCx741/7UYCPmDUEY2792iJL
         TRJua4rMakT3UtqK7VsCEhLQHkKuSp+Or1LU7VJ05f9a7WjUlUQD7ABRIZQrXaMVxIRT
         b/XwLbv4lK2CBfw+dpw839bdj9c7fe2cuyV7uS/Laadlp0sNhUA2aXiFHiGwUxpyhQkG
         nO+tht0An4Oe3WUXXWv3d8HwaFhokaSwjGgdG3KUsDia7OFNLbo8O5XaLmYHQQ5gf3ei
         EFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156488; x=1740761288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2qM4sgfAfTkBWO31bolqN4kVsMXF0DWWxA0NN1kFVo=;
        b=IkCrTb7ZwEBKeIO6uDwSccLByXXP69zYgh/YcuDvwQlRk7ovUHbNmE4mZ7j1tgc83/
         /NQc3mkameeDfQTMpCaJUuAgOwjjwHKI60aY5wgRWQ5JtMcjEUmnjhyzjmD6+HNHwVuP
         oyNEHSjYSV656AYcYSRHcYjKFbLne18jJYfE3EqWZSk38ZA+vqt1ktKYI4NNklZpDz94
         FDb3o3ifiYX+euMHY1ZnnwXt6pLB86K37rE3vQ0tiFtEkTlJZJhGt+ebaoRQnDvyclBg
         TfwnNxbIl0HNaGLaLFUU4Zx4egFBMAQE6vojbueUJZPoDewogeup9UznMsmiEeTAnLIK
         L1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqUdMk7VhDQT2Yp8pK1SBQRFM0HfbEN17vmuD/uinSUOKfVb/O/uOrq9MLoTmWl/R+I43fRjSEbUYNdYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6clnfwETUVv1U1lqHpZ4OI/DIZ7OlE9gf/9hEHs+PUCAvJtWl
	LcKw3jXjvSnx6E0opcvEdCFsN24d4voSS/U84dDaOrrrQU5TE0IBHB3ts/KEFLep5le/7Y/LtJO
	Y8+qXTG+DrSX1KQFnaDSgy/xhig==
X-Gm-Gg: ASbGnctakuSWUp+FOMYoWliLYGKmZhGzitpyw2F3F6Ac8E9w1jsIrQ7gqgrxz0AUXWh
	+8Vs8ZDH/JQZuH4WBRzzcsDipu6Od+Qcckp4s5Wx2aN9NOEkUl1N5tldIWKl/dCcehhbTH7d3I2
	P58ATogYHAZ9nWs3Tqn7bXOA==
X-Google-Smtp-Source: AGHT+IEGRF4Q5nZy7MPlYaiQh3naZL4bqgXQbjo0dKgktqYE6tVxhFUOB14LSSgJHw08Kgm5WZSlNB8sw79GdZr3GCs=
X-Received: by 2002:a05:6512:118d:b0:545:5be:a6b5 with SMTP id
 2adb3069b0e04-54838f5e166mr1808315e87.49.1740156487749; Fri, 21 Feb 2025
 08:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com>
 <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
 <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
 <CAMj1kXGKDtWxcuWbPP+o=6_pwhOHKJF_NnOL8F95y0tXt-dQQg@mail.gmail.com>
 <CAFULd4YuL9DCOs23Ev+iXooirLfKT3O_9poSUM7JeW_dO34o9A@mail.gmail.com>
 <CAMj1kXG_zKei335-CqXwNi=+AkqtQt6xmoVw+qD1XzW7q-aPtA@mail.gmail.com>
 <CAMzpN2hPWSQudpmccDtCAQAy_rHFwbBwo+95GMaqw6P-E4RPZg@mail.gmail.com> <CAFULd4aO6-1_FKXFyXW+QT5UL-3mU3Tr=yjjwt9-b1yM=TrN+w@mail.gmail.com>
In-Reply-To: <CAFULd4aO6-1_FKXFyXW+QT5UL-3mU3Tr=yjjwt9-b1yM=TrN+w@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Fri, 21 Feb 2025 11:47:53 -0500
X-Gm-Features: AWEUYZnVWRrXSrPvqPnHGBB37jy-DpJfL8Zl30KKNRpLTcECcFaERKAg4X2agGE
Message-ID: <CAMzpN2jXKRV0TnTtd+AjThH11gM+kDKg7392Rc8fXn7nDyUKHw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:02=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
>
> On Fri, Feb 21, 2025 at 4:54=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Fri, Feb 21, 2025 at 9:38=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Fri, 21 Feb 2025 at 15:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 3:13=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > >
> > > > > > > I got a warning from the relocs tool, but not a hard error.  =
What
> > > > > > > compiler/linker are you using?
> > > > > > >
> > > > > > > Does the attached patch build in your configuration?
> > > > > >
> > > > > > Ah, the attached patch is similar to my previous approach, wher=
e the
> > > > > > build system *warned* on an offset (the patch was abandoned due=
 to
> > > > > > Ard's request to put stack_canary to the *beginning* of struct
> > > > > > pcpu_hot, and this allowed for a simplified patch).
> > > > > >
> > > > > > The attached patch builds for me without warning/error for both=
, SMP
> > > > > > and !SMP build.
> > > > > >
> > > > >
> > > > > Did you try building modules too?
> > > >
> > > > make -j 24 olddefconfig prepare modules_prepare bzImage modules
> > > >
> > > > for defconfig, SMP and !SMP.
> > > >
> > >
> > > OK.
> > >
> > > I think I prefer Brian's approach - the only nit is that the placemen=
t
> > > of stack_canary creates a padding hole in struct pcpu_hot. However,
> > > that does not actually matter until we run out of space so I think it
> > > is fine as is.
> >
> > Going off on a tangent, as struct pcpu_hot grows I think it can be
> > done better as a subsection of percpu data (".data..percpu..hot").
> > That way each variable has its own symbol again and it reduces header
> > dependencies.
>
> Please note an optimization in common.h:
>
> /* const-qualified alias to pcpu_hot, aliased by linker. */
> DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
>             const_pcpu_hot);
>
> struct pcpu_hot has its const alias, so we are able to use:
>
>     if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
>         return this_cpu_read_const(const_pcpu_hot.current_task);
>
> where the compiler is able to eliminate a sequence of reads to the
> const_pcpu_hot.current_task.
>
> LTO does not like the approach, though, but clang does not use x86 seg
> support, and gcc does not perform LTO.

Noted.

I'll look into this over the weekend.


Brian Gerst

