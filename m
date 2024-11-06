Return-Path: <linux-kernel+bounces-398948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203019BF85C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFE1F2357F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D820CCD2;
	Wed,  6 Nov 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVfXH9X8"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DE20C48F;
	Wed,  6 Nov 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927610; cv=none; b=F8FXVqsmNvsoiNumlho5jA3chEZqldk7WplNM2XXLufgOgXNEFuJGtO9aU9nQU1A8lZyTyTTtDIBDc6OHCa0IwIhQhPWaOuyfGvE2OCSN4Rq8A9XknAmwUT0LK4YJoQoS1IM4K6yO7bcU50jPDmz6z0seqR2JWT6Lgck/RcGxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927610; c=relaxed/simple;
	bh=aw/1bL2DwtttbhVJ08SlbCjaTV5c0VyebzhIOHNUI/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpQqvK5tEazSwgk+ZNQcf2QQ6SqGAIghPB/bZccUkgoiMYxhXYrQI1MGE0PRqopNaWG4U/vTWhtOPLKflfIztmyTKl7G6CRYQlLqF7EezmxfltVD0tmvNYjcazn9n5QFarNRveMEmQloSMTaocD0T9dSGsEOdEn3V7UsJw702ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVfXH9X8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb599aac99so2779171fa.1;
        Wed, 06 Nov 2024 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730927606; x=1731532406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsYJGwvO6VkzAVm8XqZ2K44Ra++gS4vKFljaS06g2ug=;
        b=cVfXH9X8YCYqY+1II6UFTWD9EXsTA91ObehoyXA4AQeYKKz3IEiOAyq/hIAypb16Pa
         LQntTI8rNwiMHjAsNm/W5FcOmov57AIV6mFJGLrO0FECf8iWoe5+TDYn2TxJizOCdkFx
         BXtxUjj4+ax7+kGYO1xBHKa5CPRKBJ9PGZ87FTn0hM7XtC4XnnTPupjfPEW0NHxjLwRL
         YRNJACrTaFkXEMlF5O56aSYP2ykLhI+lSoM04ZAPKYxsXpn3UMccwkIXLII0/Kd0frma
         eSIPsanNXZYAUybnC62DTyznZn9ctdtfgNOC1Zmpwg83xfU1ma/vM0THfnllMjLBmYoy
         4r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730927606; x=1731532406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsYJGwvO6VkzAVm8XqZ2K44Ra++gS4vKFljaS06g2ug=;
        b=WpPeBocFTv9JRraguB1vs65y+tCpVC5/7IxjJd68yvcMusmYOZ8BwUz7IZRR+JY8u9
         I2WkJ6kUQe41i7tXp26TjAku/O7rdJc8QEEEoaaLJZeZeBa0FKItg6FYe/9K7gd38dE1
         0zUfcgKqf1Wy1v6TjHb34LE8bNN3b27qs1o8hrPxYQF+b+2u740tnpMHaOdgUGVw5Noj
         sZFaFoP5nlscdjUSys+X5rLFJIy2uYU4PQpderGp21plWW+oAAxkUOC17DuDWsfERToY
         1tpqT2wTZYfMzVIk7NtVIW5HOw+H1EvtAXuJ2a8MQ0WDzcFF1yr6ByMXWC47QwiTjEOt
         aNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUgPW3b1EmazfSI0wdDfQUTVDMmCYVVmnRJdbkpkUZ/lx3skGaubUya2muMlEYdogszVfnJ7wj1vdaKFpaIa4I=@vger.kernel.org, AJvYcCVJeQVvBEMuVPzAuIZnMZGgsAs9z17gjsfqDWSY0uwrAPZptO+vzdo+4F149j8WNgM3foT3mYsW7EjorPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrjfhrV5Dbs8cHPnj2Xjr89TuIoeRk5CU8qyuSWocS4eEkvE+
	8HUXXRO5ZIqjFo//uKb9PYNcZL3AvLmkwVpqxKcQRVxdGd7L0VBvmiArgnNRDe9Zepzg8fMp21r
	tB1CMDz6L0lSFsmdP8zvyenFH0sY=
X-Google-Smtp-Source: AGHT+IEVHUueED3H0LZYCLxsBtdMM5mvWjPn69K9qC9IeFXPGqNi0WhEz5WFWdoJTg/GO2mNqOViwU0aRm8vxduYYyw=
X-Received: by 2002:a2e:a589:0:b0:2fb:7f9f:7f50 with SMTP id
 38308e7fff4ca-2fedb7a28c0mr100127011fa.13.1730927606160; Wed, 06 Nov 2024
 13:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CANiq72=9XiYOMQ9ttDrgqTt=mPZnWJuCL0EgQBjFObfqVmr1UA@mail.gmail.com>
 <CAJ-ks9kNmH2t2Lo2PdLuH5rwSC3UQRGWd-cTAX9-Q2FE6oGHiQ@mail.gmail.com> <CANiq72k3AJgMq_US7MYGpzKRqOXZQKpOkBXAd8DwBKyE+Bz3Jg@mail.gmail.com>
In-Reply-To: <CANiq72k3AJgMq_US7MYGpzKRqOXZQKpOkBXAd8DwBKyE+Bz3Jg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 6 Nov 2024 17:12:48 -0400
Message-ID: <CAJ-ks9kKtGkBmjQCfM-idP6uYas_wOqMq7q-oPxZ=+MkS8XVqg@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 6, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > I would be happy to add the relevant details to the commit message but
> > this is one citation that I haven't been able to locate. The closest
> > mention I could find[0] only vaguely mentions that this change was
> > made, but does not reference a commit (and certainly not an RFC).
>
> In Boqun's first link, there is a reference to the nomicon with
> details, and the section:
>
>     https://doc.rust-lang.org/nomicon/phantom-data.html#generic-parameter=
s-and-drop-checking
>
> explains the change, including:
>
>     "But ever since RFC 1238, this is no longer true nor necessary."
>
> There was another RFC (1327) after that, for a finer-grained approach
> (`may_dangle`). The name of the feature gate was also changed.
>
> Anyway, I don't think we need to add any of that to the commit message
> though. Perhaps linking the latest RFC is good for context, so if you
> think it is a good idea, of course please go for it -- but in case you
> are referring to what I said, I didn't say that we should add the RFC
> bits into the commit message.
>
> Cheers,
> Miguel

Thanks a lot for all the hand-holding here. I think the sensible thing
to do here is to add a comment rather than remove the PhantomData.
I'll send that as v2 shortly if no-one objects.

