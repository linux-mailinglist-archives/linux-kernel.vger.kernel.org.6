Return-Path: <linux-kernel+bounces-184686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C808CAA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD0028323C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF5612EB;
	Tue, 21 May 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7B4LBMY"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737760BBE
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282844; cv=none; b=atDzWKqgvNPZnqWRQt346jW6hEcdtV74dBBpkpegNfp4DXQGbW1nC5bCLxUzyJSnKaYZ6ZBKU49I0DplNKbkP3Ob2QgymDTfNe6UQQym8zd3wtWlkumK5e8S0UX9eRuL+Y7A3kGHu+oy7xY3C7HVBOe5+Ir3MJcDK7T+SBxbzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282844; c=relaxed/simple;
	bh=gsQ/9v+Ww0+k8PG9ZOe0TIJm5Lf0GndH5Ni1tTfFNms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVS3qUUtCGloOR2OHESs9ldD7+XmTvy7ciC4qId3+PcVcae6FiyXKBx5+QJJoP9k/VfmBV/rgLgqkvsJM8Y5hP2rxsIQebP7BbskPU9hB+neQRE9jxgDepIn/vyfKET8T5UHtKRohSUtBJ2GVN59dYJAM6ykJQa8gaHat/mIbhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7B4LBMY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso53017111fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716282841; x=1716887641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkEcZV9otfNet+oPSyzKllj/HRtvnW65yYTPY3r8R7c=;
        b=c7B4LBMYYgVk3uhHMYUD1zwF2CM9zPTPOQLdWSeVDfx2kYAMc88rSzETfH6oZI4NoW
         WxO2mvxcAw7i9hhzdGG50M6QTAKCNpg3gn/mIkL41VAS10SQPbGcCvLCvZSMXr0+vnIc
         bXzlvIWmBErZH/1IPWu+NtRBmzrVXRo2RkjVd9d0XBkz1llwzQIat/7rgehponbCTade
         egYkkPqFGHgN77WtY6b8ZtWirnJsz8tmV7OdNcBcBcAqdR/U4mJ+wXSTblSZBdLOb6vR
         tsDK3S//9WoTjB8yKOHLdADBwGyaDMf6f+phzD+4skt6+dnMtvBzuMKcZpJOC0a9ZaLi
         wy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282841; x=1716887641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkEcZV9otfNet+oPSyzKllj/HRtvnW65yYTPY3r8R7c=;
        b=SLLcqjCih+XNNeh3/8BeonIsddaH4FyOBzc2aBwXbuQv2iM/vBuNJ1LwIcLCU84vwi
         skgojGd0OtFp+H3Bf0u471n2ZulEKOvuhU2VJz5/Cr8dG0ukfSTUY84K8Vb6UyrJrkNy
         fDQczCYXAV6kOOUo8LbZxqyCl+SHV6qEFdGBFMIyDOhp9+VRysZLqrkmJmWD+EchYKTp
         TIyND11Xin5rd1UbloNXHIdMAAXX2RB21oi2996A5XwsPkn0e7xXrtPP94N3UTDG1mzl
         ZSkaMmd15Q8GI6igvf0OfiVLLTOrEFDZNhoxmutmQHagM8NS6jzvm8+JeVSyIZpJftaN
         X4AA==
X-Gm-Message-State: AOJu0YzDD8s5WKq351viOIQOuXBDgscgnElqqDx2V/HQw6rrddLRy1nv
	YfPOk/FaMffQPSy4uAHBAVM3Wwvb3t0cT9E2rVdsgyBjwmQG3CdYrkA2kNnNnm4jb6esajNd9Rf
	R7NimB0uQWHRIAdK5sFZ2AuFq6TU=
X-Google-Smtp-Source: AGHT+IHTgsMsQu9irQccR5FbYjGLrxW5NkW0sX0QWPOsy2HY0W/KV12K90sxh9WZS1q9R2HYKev6vkz2cXRjJQV5Fww=
X-Received: by 2002:a2e:7e05:0:b0:2dc:bf5c:9648 with SMTP id
 38308e7fff4ca-2e51fd4b1f2mr226672731fa.19.1716282840655; Tue, 21 May 2024
 02:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520082134.121320-1-ubizjak@gmail.com> <ZkxY04qY7spBvlYb@gmail.com>
In-Reply-To: <ZkxY04qY7spBvlYb@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 21 May 2024 11:13:49 +0200
Message-ID: <CAFULd4YPBSdfyUYr8D6_wDbRZSnXrT-4OcgNUNoYpAqefrnA+w@mail.gmail.com>
Subject: Re: [PATCH] x86/percpu: Enable named address spaces for all capable
 GCC versions
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:18=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Enable named address spaces also for GCC 6, GCC 7 and GCC 8
> > releases. These compilers all produce kernel images that boot
> > without problems.
> >
> > Use compile-time test to detect compiler support for named
> > address spaces. The test passes with GCC 6 as the earliest
> > compiler version where the support for named address spaces
> > was introduced.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 9d16fee6bdb8..c9e0a54f469e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2430,7 +2430,8 @@ source "kernel/livepatch/Kconfig"
> >  endmenu
> >
> >  config CC_HAS_NAMED_AS
> > -     def_bool CC_IS_GCC && GCC_VERSION >=3D 90100
> > +     def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(C=
C) -x c - -S -o /dev/null)
> > +     depends on CC_IS_GCC
>
> So ... will this test also trigger on Clang, which might have a
> __seg_fs/__seg_gs work-alike definition?

Yes, but please note the dependence on CC_IS_GCC. This dependence can
be removed once CLANG is tested to create correct code for named AS.

Thanks,
Uros.

