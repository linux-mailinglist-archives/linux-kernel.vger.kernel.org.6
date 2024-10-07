Return-Path: <linux-kernel+bounces-353525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02B3992F09
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B079A284411
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E41D798E;
	Mon,  7 Oct 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d80rBEkU"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B31D61A2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311084; cv=none; b=G4yFDSxLvEO6FGXeuCktnIUAIi4TwYQ23az0Mk58kCQE/bYwd4UP63N6FD3AE3HJzLEUul7OYGv3MPRoFEPy31O7HBvfxOMiePVZG7a5T79rLO3eBA6WujONIAMafC5Kfn12xvSB5YrBq6oc2wlUwaoNwjI6PDPsTrE544bppoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311084; c=relaxed/simple;
	bh=M/ln/IfRG23UW65hQDx2sPi2M1oZ1ULBSaWU8tBPOQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smLJqIRSB/SKI2opExIGrSOK7esOjEUCrmk8PfRUmfdK+z5exCIx20XNMK/HrTZsB2h8ZFHHyOh7I6pop1aO8t5VoNHTOKoqSG4mpcvNR5u+CflBXj58WWtfnUt97A0C3C+zMnQauJ3r7ZrWXHJhaPu2+bbVbG/Is8TbQmINL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d80rBEkU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db908c9c83so2805228a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728311082; x=1728915882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMzHKJcLgL4mw0mj0q3+1HsZsdarzSx1Vg2HXSvY4Sk=;
        b=d80rBEkUzhDsi5lz1SwK7HDvpLitxX7Ntn8CG5K7XwOl2Nrz23NXVs+7EVOAO2tgIG
         aZReRkULwcbABT4p8T8HUphRUE3rKmgmG16V7do2uJ2eJcRGpsY+ph/teyPrNz6p9ADh
         B6C378f4XkUGRY2mo/opqE6kOlGddUPQOy2O63+3jx8RZUr3lr1AtYpnIZHsf8Aj0Jz9
         SlAfQqOH6tx8yxJBnyt+UjnauLQYhAC+vi6KrZ+PoZgsSvlWiXwmWC687IcBAmg/aNoK
         rCIaEZ0zX1gndXDenp9PIHMUwnw9DMD20xoCR6OFOdqZT31i552UOcn0raqiabDTal09
         Yqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311082; x=1728915882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMzHKJcLgL4mw0mj0q3+1HsZsdarzSx1Vg2HXSvY4Sk=;
        b=VMdR+RVgcKXRTBBynG/LZVH4Af012o3Gas7TvwbmmEWTUmxj8JCnoYIaxEcBET5uD0
         oWHdk8HU+vAup4jZvJvu7X+ePYeGvVOo4v5XjmGdYO9wFQhPTWbmKWPPT7zTfu9qznKN
         mqB/5Q86SvR4XV78TwYWdU1fXUYguoOZC+Su57XaKvpcSeh0bIEFMiqMgoJo6dzDaQgm
         y5SVSjJjqiwblPbxvmtU3mtiGuZ8PwyEL3o7sk8Qb0LuW2RAI74A3ItySmliSDRF9kf6
         CdqmE5yAN8MPNUvcR9nyNcM0hH/Un35JPy2KbiBQEphzkyVf0SnP1cPqTYWnNB1AzbPS
         v4MA==
X-Forwarded-Encrypted: i=1; AJvYcCUVuoyPrB9j8XfZQMvbZ3BrktCRJXbm0Fpmh20D5LMNSyDFg8L1kpiyCXIcDCBX+soYqphWQ21QoTyhCK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTXKvlZpwEAYqjZFxoJoZqO/EfuA/d1Mw6F7/YycmAGuI86NK
	gpnW2JHCrD9w1CDijEeIpv3tkrcHpYlDx/SFOhGbJR8sHzG5Ry/hpjknzEjVp3POD3JM6xea7z4
	4XVdKa6zWgfdfQUywBGf78NLTsHhssbfM+MQc
X-Google-Smtp-Source: AGHT+IFw6uM5+6C7SMH67mk+Hc1sAMfXhD2yPqK2binLtdR+dEflXw9OzVkLv56wMCTjpeR0STCBxEH2wN1oY363ons=
X-Received: by 2002:a05:6a20:d81a:b0:1d3:5202:f9a8 with SMTP id
 adf61e73a8af0-1d6dfa3b32bmr18029273637.15.1728311082348; Mon, 07 Oct 2024
 07:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-4-fujita.tomonori@gmail.com> <CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
 <20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
In-Reply-To: <20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:24:28 +0200
Message-ID: <CAH5fLghps=Aa69Aye5PCGu6LuoHomMcQYEN1USTd5JiBkLdJLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:17=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Sat, 5 Oct 2024 20:36:44 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
> > On Sat, Oct 5, 2024 at 2:26=E2=80=AFPM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> >>
> >> +    fn add(self, delta: Delta) -> Ktime {
> >> +        // SAFETY: FFI call.
> >> +        let t =3D unsafe { bindings::ktime_add_ns(self.inner, delta.a=
s_nanos() as u64) };
> >> +        Ktime::from_raw(t)
> >> +    }
> >
> > I wonder if we want to use the `ktime` macros/operations for this type
> > or not (even if we still promise it is the same type underneath). It
> > means having to define helpers, adding `unsafe` code and `SAFETY`
> > comments, a call penalty in non-LTO, losing overflow checking (if we
> > want it for these types), and so on.
>
> Yeah, if we are allowed to touch ktime_t directly instead of using the
> accessors, it's great for the rust side.
>
> The timers maintainers, what do you think?

We already do that in the existing code. The Ktime::sub method touches
the ktime_t directly and performs a subtraction using the - operator
rather than call a ktime_ method for it.

Alice

