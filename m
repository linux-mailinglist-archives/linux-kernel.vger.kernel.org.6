Return-Path: <linux-kernel+bounces-358316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CA7997D17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B37282CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E881A00D6;
	Thu, 10 Oct 2024 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMC1Snen"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E41311AC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541252; cv=none; b=XyTV/0Gs3YJaaOQIADiMUNDpQfkbFiJKnWqN0XHU46yVs4Re2SocrOLHMTPoJdDg0Nx5yPY/AU3zOnD7BR21skR1tjs5U9KQm6C/vZnQVIblcosFYLwuXr06zHCDN28+CzNPd9wDPH+F2VABqdN9XAhaI6xoIRcHNbUsKaWnho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541252; c=relaxed/simple;
	bh=Gr6I3Lpl4O3m2/3FmVpE+sxjOvl+/GM/2BTeayM/Gz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMzxXxLIGg+1IdCNROAX4bW8gZxKLqr65SjlC38JaFElJYlgO6jI/Nnc0yc19coaShRR4c5Gt6KkLu/yG11mf/E+T7EhXk197JghD1b5wAnmnkqwIdbO0/kpTTf7/aGouWHUfAH2gWuvN77XnZ7B6AnHqmsJaxwrLsGgH+72jck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMC1Snen; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so4756651fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728541248; x=1729146048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/5ZeQ+bZ+j/sfabBG6m03jeyZ0ILSqkZ0P6ySqgxhY=;
        b=lMC1SnenpSZyEOQvvtmQ5gK0zk1yXAbcL90spF4HaYueHhx/FpJPzUY+QvKWjuSthr
         scaOvwkVkB2BuzeaflaRZ91JTQN+aNzztyVku3qVqr0LYq4Hf8uArWcM1BnhfymAM07z
         urb63opuJn7Tp8RLH+z0j69PKB9zHhqxAOefLwSV/jQ7LtVzEysvc2vezwUQbRD/Z2yF
         JGBFN0ctj8GGhyC2DWmfTi2X490eNIhdnn2yjipEkJmqDhh3OXHhfBmfyaznOwU8fw+K
         8LWfNd0KOQrtR+kx+4irnOx8AzvA2PYbR1B3s1HprV6DHVBOwKgedZj9fUzN6TqpmGZz
         008A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728541248; x=1729146048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/5ZeQ+bZ+j/sfabBG6m03jeyZ0ILSqkZ0P6ySqgxhY=;
        b=cDQFrj2yppzb26dUr79JpuKAlMAk1soSIKuCngBoN6nAwQuLpLEWk7pK5/A+GjFRvk
         aXMaBQ10279weLTURC1cJL8E5CP/oHLGSctctQIC9KjOFAa0aGaYM2xMrFmmnasci2bC
         pF69Xuw1yo49SMeVjlgNaDX2BUKKqeldMZP15ZUTiSnIQeNfkkSb5C/aWAOy+RDmvJ2S
         v9jtgEGfhwvSbg7425/sSqpjvacB3G16vFAh3AVKny9F/x59r4B/9IMWohewX4T39Lmo
         vyZ0eqE4UKMkCD1vynIYX43M3EY+E5j9Sv7cezsqMHPClw7m72t1gadesCe0df/jzaRa
         AGEA==
X-Forwarded-Encrypted: i=1; AJvYcCVIuNdmkBAZhEb2IADBp7Lq34HlmiktIk7HO6EDsFbd5HOTOCXJnOPX+Oq0t4Dw+2rVAWGKz7w2Bp6tXrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxpklzi9FBjr5bXMKF3j1G3OWjsUSwkdB4PZMI9qUnMl4B3gb
	6LDtJ2oZY4J3u84yAijilltdlgr3VbS0EAxIiqtaV8ehqfki0sYetCPtCWSEyFRePBVfao2o6WE
	1WRSSzGhA8a81dXZ0rkgS0xmiHTU=
X-Google-Smtp-Source: AGHT+IEzS780FVWQwDu4l+vTRUKyhmAIG14rfawLmam+r4oN/lVVg1UTogBqanU0dme/6k2Xc9AWefXK8ei9md9hRsQ=
X-Received: by 2002:a2e:b889:0:b0:2f5:2e2:eadf with SMTP id
 38308e7fff4ca-2fb1872fe7amr32490661fa.10.1728541248153; Wed, 09 Oct 2024
 23:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004085257.10908-1-ubizjak@gmail.com> <bb91d63d-c61a-4063-bf14-4cbbb62bec12@igalia.com>
In-Reply-To: <bb91d63d-c61a-4063-bf14-4cbbb62bec12@igalia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 10 Oct 2024 08:20:36 +0200
Message-ID: <CAFULd4ZDKvo3pNGTMExNoh3n9DLixSYZk0d0sVCeaztyi1kKYg@mail.gmail.com>
Subject: Re: [PATCH v2] futex: Rewrite get_inode_sequence_number() to make
 code simpler
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:44=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Hi Uros,
>
> Em 04/10/2024 05:52, Uros Bizjak escreveu:
> > Rewrite get_inode_sequence_number() to make code simpler:
> >
> > a) Rewrite FOR loop to a DO-WHILE loop with returns moved
> > out of the loop.
> >
> > b) Use atomic64_inc_return() instead of atomic64_add_return().
> >
> > c) Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> > atomic64_cmpxchg_relaxed (*ptr, old, new) !=3D old.  x86 CMPXCHG
> > instruction returns success in ZF flag, so this change also saves
> > a compare instruction after CMPXCHG.
>
> Remember, it's easy to see in the diff that you replace the function,
> but might be not so clear why you did so. I think it would be better to
> understand if you write like:
>
> We are trying to set a value for the i_sequence, that we expect that is
> zero, but if we fail to do so, we are happy to use the current non-zero
> i_sequence value that we found. Instead of using
> atomic64_cmpxchg_relaxed(), use atomic64_try_cmpxchg_relaxed() which
> provides a better semantic for this situation.

I will abandon the rewrite part and for the core changes post a
two-part patch series with two almost mechanical one liner patches
that I already have a widely accepted changelog template for.

Rewriting the loop form is mostly cosmetic, and since it doesn't have
an effect on code generation, I'm not that much interested in it. I'll
leave this part to eventual future patch submitter.

>
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: "Andr=C3=A9 Almeida" <andrealmeid@igalia.com>
> > ---
> > v2: Explicitly initialize "old" to zero before the call to
> > atomic64_try_cmpxchg_relaxed(). Rewrite commit message to
> > state the motivation for the patch.
> > ---
> >   kernel/futex/core.c | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> > index 136768ae2637..ac650f7ed56c 100644
> > --- a/kernel/futex/core.c
> > +++ b/kernel/futex/core.c
> > @@ -173,23 +173,21 @@ futex_setup_timer(ktime_t *time, struct hrtimer_s=
leeper *timeout,
> >   static u64 get_inode_sequence_number(struct inode *inode)
> >   {
> >       static atomic64_t i_seq;
> > -     u64 old;
> > +     u64 old, new;
> >
> >       /* Does the inode already have a sequence number? */
> >       old =3D atomic64_read(&inode->i_sequence);
> >       if (likely(old))
> >               return old;
> >
> > -     for (;;) {
> > -             u64 new =3D atomic64_add_return(1, &i_seq);
> > -             if (WARN_ON_ONCE(!new))
> > -                     continue;
> > +     do {
> > +             new =3D atomic64_inc_return(&i_seq);
> > +     } while (WARN_ON_ONCE(!new));
> >
> > -             old =3D atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, n=
ew);
> > -             if (old)
> > -                     return old;
> > -             return new;
> > -     }
> > +     old =3D 0;
>
> Please initialize it in the variable declaration.

This is not possible, since we have an assignment from atomic64_read()
inbetween.

Thanks,
Uros.

