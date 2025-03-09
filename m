Return-Path: <linux-kernel+bounces-552951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F65A58163
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462103ADFAF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B76A186294;
	Sun,  9 Mar 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW54Gs4w"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D417C77
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741506619; cv=none; b=pxNd9CEz3D/JI9VkLDbs5OwK7KI/kwN8KlscSiC7TqQ29vkHj4x7kpDOlqB5h5IccGxlqCN31cUxlEdK4fPCHzhePhl81DXM7lwU/rsR0bL23Ch7CTiYAhrZ2n0I6TzecIKDAkC6phn/LnAuUuhMFg3dsQqpC9yM6h1TwdnujoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741506619; c=relaxed/simple;
	bh=/4UNSiBYoPdChrC/c4VnDQ5DFzsk7Mw5wBAtjO2LQBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHOyc5fQY0POEfp3fhpQHqH7s6iRnS1sM90KfgolMWU9ib0bzm+lIZw+CuM0Jhsr5aeQ83x0TAeMqr7rk9rguvhga0utDO2IDL5mfoSwWk4Uqf728e/1ZYv4bq5VVecsCchuXwoXefR+IiEVWqZGtF7Q+2h3N718Tfc8kclTnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW54Gs4w; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30b83290b7bso36716391fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741506616; x=1742111416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U61qrkFOwoXR06m7zLiDQZVTSFxcg8gP2ViCYbXH5mM=;
        b=JW54Gs4wXaFG4Sp0yRbB7ehXVBu9BhGWY8x5pmyz6sTa9U26ol6Q9r+F30ly77Qsgb
         oNPbrO1/kntLSVXAT+nTeZo/YZ0Aw+8rinmXR32IGUep61HKi3LBKf5E3/tSp/d3EZOA
         ocX7NUjJR6Uwi07MS8iSYKNPPCrrmOIEudMvizV4W/X2/kwJEJybYVUI5sc+Yip56rOT
         TUbY2QN6j0yPWvVIhRhNk6Sj8d/omuWewPZOXnuHaDi+oDSIYcuMRCnbLoNptwDjZEhE
         UabOtsLBRC2vEjg/dzI0W9jj1KFaTaxbgAXJSJ/c6Vee35VMAT6RVq9sHjGFtkzrHDvp
         5p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741506616; x=1742111416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U61qrkFOwoXR06m7zLiDQZVTSFxcg8gP2ViCYbXH5mM=;
        b=Qu6uIMFXpg3aon1LGGBqgWnvcVHe6/MZ7nAcnI0pfXgOaLDW9uJyygpk6Dte1ki+pl
         ME/Wl/GInidoaTpmB9w62TGQDOHg+DVVz5Xlz0iR/5uiSUCjJXWc3U+x4v/g3o2he/hP
         FkdNBRqtNnceG6WeM/5Hmz6NmNfjM7K6I4NL1OBl0PeyPY7E9pF1GTky975guEsIRf/7
         +rNm+K01BXNZ/0va3jhfW34Mlprb2mR3IAHHXfKnzZyMr91mcGivMjDXS/7FstDfWyYv
         AEjjadK5fReYubZmjc2RGFGm+6QqhzlIs4bQEBlfQEKkUDf15qyT0OowX96RqdE462vA
         muIw==
X-Forwarded-Encrypted: i=1; AJvYcCUVNt8ZQ8rUV5ajIy2f9/ThHsBTkGCHfqqaT1Dn55UIqKs1yUNxSo4gZE0hgNeOB3AHloM6tCvbyYmk1FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWueGjVBqBT4YgC7YHgm6LrhFlzO/vdW8F+Tsg+h2lxBIcn5rP
	8n/USeAV4qC/h2kVLU+7uDF8ZZvDcABMcs0+KaIxW4J4msTJf8paUFBA66552D0/cXY7rNGFzu0
	fr6ljgSaXo3KfBjofY9pnhLI5zG/H3o2X
X-Gm-Gg: ASbGncvWHCOcEiON+7CIjfU3FndxKAhrsjY2Y0MjLjtkOIULLmSBT6iX6Lg+4f0lyzq
	UVdCigrM3Ml8wt5+5Y/fGSjMN84Lg2XVF3Ce3IzWgQQ1Rbe8RNPkVUoww7Sjb/SYnTt2S/q5UBE
	8fY8LkNlciZuhF/u4Z1PD27i1THQ==
X-Google-Smtp-Source: AGHT+IFZAPhwlu7rJk89LBID0Zh+JpgT4CJYFLEmtLXXzNOanWwC81VtkqC7otzYI4JJz716YI2EDiVPjmlwMNoCPXQ=
X-Received: by 2002:a2e:be05:0:b0:30c:ae8:8f53 with SMTP id
 38308e7fff4ca-30c0ae8908bmr5196891fa.36.1741506615588; Sat, 08 Mar 2025
 23:50:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <954c7084-3d6f-47b8-b6cc-08a912eda74c@zytor.com>
In-Reply-To: <954c7084-3d6f-47b8-b6cc-08a912eda74c@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 9 Mar 2025 08:50:08 +0100
X-Gm-Features: AQ5f1JqlmsEZAOS0QZ9ftyii4l7581MonDMIUMS15ZpDzEXHIl5uJ7AXZtlXQ58
Message-ID: <CAFULd4Z0FugNh7+6c5Di_o6zKTNOmkNytEpn0kfPhinFQEOSzA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 8:08=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrote=
:
>
> On 2/28/25 08:48, Dave Hansen wrote:
> > On 2/28/25 04:35, Uros Bizjak wrote:
> >> The code size of the resulting x86_64 defconfig object file increases
> >> for 33.264 kbytes, representing 1.2% code size increase:
> >>
> >>     text    data     bss     dec     hex filename
> >> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> >> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> >
> > So, first of all, thank you for including some objective measurement of
> > the impact if your patches. It's much appreciated.
> >
> > But I think the patches need to come with a solid theory of why they're
> > good. The minimum bar for that, I think, is *some* kind of actual
> > real-world performance test. I'm not picky. Just *something* that spend=
s
> > a lot of time in the kernel and ideally where a profile points at some
> > of the code you're poking here.
> >
> > I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> > compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
> >
> > But performance patches need to come with performance *numbers*.
>
> Incidentally, this is exactly the reason why gcc added "asm inline" *at
> our request*. We just haven't caught up with it everywhere yet.
>
> In fact, I would wonder if we shouldn't simply do:
>
> #define asm __asm__ __inline__
> #define asm_noinline __asm__
>
> ... in other words, to make asm inline an opt-out instead of an opt-in.
> It is comparatively unusual that we do complex things in inline assembly
> that we would want gcc to treat as something that should be avoided.

I don't think we need such radical changes. There are only a few
groups of instructions, nicely hidden behind macros, that need asm
noinline. Alternatives (gcc counted them as 20 - 23 instructions) are
already using asm inline (please see
arch/x86/include/asm/alternative.h) in their high-level macros, and my
proposed patch converts all asm using LOCK_PREFIX by amending macros
in 7 header files.

Uros.

