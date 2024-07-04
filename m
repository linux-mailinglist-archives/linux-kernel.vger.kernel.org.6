Return-Path: <linux-kernel+bounces-240489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FDC926E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F03B22B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3481B810;
	Thu,  4 Jul 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P30v27HF"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75346107A0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067144; cv=none; b=a03JnuelwoWA6Bt4xQR9g0grXcVWHhmv9YlzEoaCHM2IoQvGDkSkUIXKfm44TC9+2Hg/rOsZO439H6mtHsItkgPGJ3Bfvbe7HrP/zY3poCyAp6n9QUeyFTz7lSHCJdT9AjcgonsfBYv5+v82paCuG4fmR1khTm/KYXwk+VwSoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067144; c=relaxed/simple;
	bh=Ntd4/kC0r4eB4HdPlMY3OKpmwjBNmj5DuXQb6fpNyjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcREolNMY/UFPuFAd2mJtGpWM8ClDti22UdTYKGgoXC7BbJpAiJFAe1CcCCWit5y0gcRWYrQVSKZaEOOx9ywXRijlclrQ4M6NFGbECaJORR7Pbt5j/sjuALzLrnFUMOFadfVI2sOsDhubJQ4BIrTCZMC2dQ1DkovukggeLIn0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P30v27HF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64b5617ba47so1906977b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720067141; x=1720671941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9twH5qkSgSY75LRVfS9EDzs/Uj7txRv8120x7sQF9o=;
        b=P30v27HFgfN1LQnBvxIiKKPjegpKeoOhhpIqn+9dC757KTepcPipl+F4eDWZ4RYmoF
         4oSkCk1qJMcwC4KJ2bTzd+OUN1/b2jMJCJbrJUTqt7r2wb8IRJVaG7gwlp+XxAbEX00X
         JtH5D0gJjWjdNQj+NKwp+fEhpUxhFvuA0sAD/Lk7gcshzRdOgKee+nB8TSYwEXrRl5R6
         UrF2Uj7x8Teib/Ty8HL/YPNP7RILz/rJK+MifAAC1EjwhN5elyJNbtzeEdMgl5wV/A5L
         u5nlNLdYuqxMn2d3i2QGCNXIAJogau8/yulMrbysybvSMtV4HSA7FKLLBTz6bUPS9R2h
         3zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720067141; x=1720671941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9twH5qkSgSY75LRVfS9EDzs/Uj7txRv8120x7sQF9o=;
        b=L11WWMfoYsMTxxgkGHol46EvvSP0meUI485wsHx2uBtFEMXKV4MSOwamgBHpjGg333
         JjtxG9fdB3nJcqklj0L89xGsbeoN8cXQ5a56fcbOOzkswoMzqPj79TfmKiEHeAmZmU3M
         mILUrSae1F5UnGtIwgo6k8yKyDEL3GS1S2cC2uDq7Pa+pexCKMmh7AENwo9eC8pg+3XH
         SqeDIFOk/3B0YAPqB5Q/g+1cLyNzeGTuCKXtEZh8BUswvrurVlNz9qGheZ5P53MfjBII
         bbc2aw0MlJmsu9saZlgrRSTcgK2r1Vot0G+IInP4utEesqjiCHPN/EnC796CrJWzQ/oM
         xDxw==
X-Forwarded-Encrypted: i=1; AJvYcCXMlyA4Lujt+kTly7knUKRIoQdzkB50Ll9L6MkNvmAnSLdpPPHlHOYk9I7RDAvWMdCs/U0POk4k34ak70a3DZjVCZFSFP9/IDNoqfUA
X-Gm-Message-State: AOJu0YzP9lAcTfjLYrSrVsKqW6G7xDv2ehWps8+ODD95vxTDikLz+Ns1
	jTpXvn7jWdDmEfaaC2zGS7mmXgaX4p4In8BNkl/FTZVZ1Ynm/pMgD547fdtxyh4AXHP+F5bNgXK
	f8n07Rm6cyRTeK0KMPf+4i42jPWPP0TmvOurn
X-Google-Smtp-Source: AGHT+IFAwEoVU8wxC04BayIiEFSXlc0nTD9EC7c/CydPSiHIHz6Z+w/BHUfFbwGBl4XQHff0JjFGe4JgyfBFcuojEuk=
X-Received: by 2002:a81:ad1e:0:b0:632:6615:3d67 with SMTP id
 00721157ae682-652d5334868mr5549247b3.6.1720067141071; Wed, 03 Jul 2024
 21:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703221520.4108464-1-surenb@google.com> <20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
 <CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
 <CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
 <CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
 <20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
 <CAJuCfpHvNjFQYU0zHOuang2mNOLNHHiNfaWACPWuP4mSMX_OmQ@mail.gmail.com> <20240703211747.97e7740df8c9d91de324c5ce@linux-foundation.org>
In-Reply-To: <20240703211747.97e7740df8c9d91de324c5ce@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 21:25:30 -0700
Message-ID: <CAJuCfpEO3Lo9EZGQtdPUeyycbNwqJ7zvHq2N9nzd_Cc6pARchw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 9:17=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 3 Jul 2024 21:07:56 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > On Wed, Jul 3, 2024 at 8:54=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > On Wed, 3 Jul 2024 20:46:11 -0700 Suren Baghdasaryan <surenb@google.c=
om> wrote:
> > >
> > > > Ok, I confirmed that the warning is happening due to the access to
> > > > "current" from alloc_tag_save()/alloc_tag_restore() functions. I gu=
ess
> > > > when these functions access "thread_info" variable:
> > > > https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/inclu=
de/asm/thread_info.h#L96,
> > > > compiler flags that because the variable is on the stack of an __in=
it
> > > > function while alloc_tag_save()/alloc_tag_restore() when not inline=
d
> > > > are from .text section.
> > >
> > > Well, is the warning legitimate?  I don't see why an automatic variab=
le
> > > of an __init function should be considered to be .init storage - we c=
an
> > > assume it won't become an invalid reference while the .init function =
is
> > > executing?
> >
> > I don't think it's really a problem. __init function is executing, it
> > calls a function from .text (say alloc_tag_save() that was not
> > inlined) which in turn calls get_current(), which returns a pointer
> > somewhere inside __initdata. That should be fine since this can only
> > happen during init stage. If this call happens after init,
> > get_current() can't return a pointer from __initdata. If it does then
> > we have a much bigger problem.
>
> So I think you're saying "yes, the warning is legitimate and this might
> be a problem, but it isn't in this case, so the checking code is OK so
> let's just work around it"?

Yes, that's my understanding. If get_current() always returns a valid
pointer for the given execution stage (during init/after init) then it
should be safe to call it even from a function residing in the .text
section during init.

>

