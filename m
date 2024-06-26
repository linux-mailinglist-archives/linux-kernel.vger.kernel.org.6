Return-Path: <linux-kernel+bounces-230418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 445D5917C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37241F21D78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584B16A930;
	Wed, 26 Jun 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBsbQeMZ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC308BEF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394405; cv=none; b=UBWLyAzZ0g10/ZQ8hd/XVjnGt0p+IQtl3LNclMZmmyBLseKSXToXrcAxWJes2lPn5g+52bJhbv7oK5y7GrAM5C3uJnsiVHIsnBzU1bJPbQmq237tasWmTHDXs0+XgtROkqzsu49ccqBtMul7uMg12xyRKJSN6TZ7cxOY/HFRmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394405; c=relaxed/simple;
	bh=BLr+UZM1tjC7FJ2r2FmEjZapNn4NPffHqyznS7e3aIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSUWZ6voGTPZK53dYY+D4O2pfG0TBzTFdCTeLqQi6F/7PUcZjt7THbgBTXJsqbWVdKKE0eyi0PUaYwThVWG5CUZqFftyWWjFbrG7isLXeRsSMES4Y4FsBRGjQ4xGtfhhRwi3ENXpJ2OShCbV/KhaLxAgnhJghktdjBzhRTk++XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBsbQeMZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so87579511fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719394402; x=1719999202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V49/0pew242ZgNtxXQHjpBzNVHDt7hGxiTQwTXbALU=;
        b=DBsbQeMZGq6V39eJBdXG3WvFOwiJw9tQ29Kew44ZKR2t/Nb4rS+OXs18/2ZdzsRcag
         JqL+BaqCrRJdy8qTZCm6zXH4mFXC1fvz/mihMNv1OoRmyddIf2JL/XCNiYQqDGiJcO2G
         RDnnMOYKlz+rB7swVhrGApUF4DBASQRpu9hUOiX48Xz2FFUHNg6ypvJ56l7UtWOTb+LS
         Sgq1tECIkEXQFZg8RxmjwvM80MrxKbG7EnjM6zsXGB3L/uOjWtcMlCXjaM5bJlHASYwF
         O6+pxxkQ9ytAal3odZCNLJlR77eOR5TUZAnNKNN3Ecu56bI1U27gu5dfDFI4W3rIrqDR
         sPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394402; x=1719999202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V49/0pew242ZgNtxXQHjpBzNVHDt7hGxiTQwTXbALU=;
        b=vpACSg2rFipebkRl5yLKhZLBeys7rikxLHPCDtyFCzacZks7e6BcA2KNaJz3sy8xrX
         2AvAYiLACb168jBpo1kwZMpZp5mC87imI0z9dcXrEc7efj6NDnpBpyMP9qgs720slJJi
         vcOcK8TL32oJR9qoKPVym5d/cOpWIuu5gGaKx2cegxRrjtfzaY9Io2EiNumGjyUejiH0
         e1MsxQu0cV/1wqGDb57lYFBv7bl89GUVBJONQetAPHFLsAGF5azcwXPn4u24nWv1saxJ
         tVmGtSHoHACuhtIPa8wXl4EJlMf/Eom0pz3SC+V4ZxjVb55E7+f3ElzyVTZHGuD2fnFX
         JwwA==
X-Forwarded-Encrypted: i=1; AJvYcCXpttr0R9VADAzc7/xK4iq8kR07PYqhlXl3WQBkEDatq0uRl1QmrXjVY75ld6/dAOwazBgAXKYC31880P5HhBBhKLdNcAHc+NiHhdau
X-Gm-Message-State: AOJu0Yyg2wjmqzl4WUp8WlXhLLwNmg8ZUCPhLPparoirI8Hl8zn7Aet1
	DdhsRsJxQD4QdAZv+ItWVsQIWN4l31QU9aR3D3bIil+7McNxDaOUFKKX6IoXMbtAWCsVd9gj2eV
	SdkIvO353MuaX5UdRvtv5dL7++yc=
X-Google-Smtp-Source: AGHT+IEcVRLtuoU/fhayFG07fR0EbbCVk+f99Sk3JFVCJ1Z0wTWy6WXp57DQFwoTZC1sLStYobjeoAjMj4l3m3f/P1Q=
X-Received: by 2002:a2e:6a12:0:b0:2ed:5af6:e846 with SMTP id
 38308e7fff4ca-2ed5af6ea7dmr9443931fa.50.1719394401391; Wed, 26 Jun 2024
 02:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
 <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
 <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com>
 <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com> <20240626092841.GC31592@noisy.programming.kicks-ass.net>
In-Reply-To: <20240626092841.GC31592@noisy.programming.kicks-ass.net>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Jun 2024 11:33:09 +0200
Message-ID: <CAFULd4ZUBaK+FNSKfiJzzZNFQM1bWorZGmaY=fb-sFN2uPK4MA@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:28=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Jun 25, 2024 at 11:31:05AM -0700, Linus Torvalds wrote:
>
> > The thing is, when cmpxchg doesn't fail, then oldp should already be "o=
ld", no?
>
> Correct.
>
> > I mean, by the very definition, atomic_try_cmpxchg() can *not* be
> > successful if the new value didn't match the old one.
> >
> > I mean, just look at the very doc you point to - the "definition" is
> >
> >   bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
> >   {
> >     int ret, old =3D *oldp;
> >     ret =3D atomic_cmpxchg(ptr, old, new);
> >     if (ret !=3D old)
> >       *oldp =3D ret;
> >     return ret =3D=3D old;
> >   }
> >
> > iow, it only returns success of "ret =3D=3D old", and "old" by definiti=
on
> > is "the contents of oldp".
> >
> > (Here "oldp" is a local variable, not something that can be changing).
> >
> > So I *think* the whole
> >
> >     if (ret !=3D old)
> >       *oldp =3D ret;
> >
> > is actually counter-productive, and could/should be just that simpler
> > unconditional *oldp =3D ret,
>
> IIRC the reason I added that conditional is because at the time the GCC
> compiler I tried it on generated slightly better code like this.

Please see the thread at [1].

[1] https://lore.kernel.org/lkml/CACT4Y+bG+a0w6j6v1AmBE7fqqMSPyPEm4QimCzCou=
icmHT8FqA@mail.gmail.com/

Uros.

>
> ISTR it emitting some superfluous assignments with the unconditional
> store variant. Typically what seemed to happen is that since the
> cmpxchg() user would have a loop termination on ret =3D=3D old, it was ab=
le
> to recognise it only needed that assignment in the failure case. Without
> the condition on it would also do that assignment in the success case.
>
> But yeah, otherwise it doesn't matter.

