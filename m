Return-Path: <linux-kernel+bounces-525781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE270A3F4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30950861522
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9520E00A;
	Fri, 21 Feb 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRV9Urao"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB112040BC;
	Fri, 21 Feb 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143120; cv=none; b=onUxaSWlnTcFNyIqB+oSQDQBPj9IEVfoUS9vx1aZ0w/jwmpAO3V9l2wyOeeNbBELL5fm906X3g3UOraPPncj6jy09VnWKP4NSc9mP8WQkzDewXWKspna0D1nkg/HaVjoUTyNfwFQhPXpYcP8vw8SRB2a3h3zlWWqKngQNfwlBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143120; c=relaxed/simple;
	bh=KvqjZwycFWe4zgqGbYVgM7gofjUv5SV8HYZomguZjso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqQcwVrX7fb7FF2UdZMPrVN35YqetSuDywVLsd76XoS2zeTr8JEhS6C9/bLXKqW1UYXAVkRs+sBXiyvdzfODx+DYkcmVhQdoe4hvWXK/d1g0//Em7rlolwpV0KEcthfEje1E09nzj66wP/gSLrhHKWn/vJhbEqnDu33ytrFDSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRV9Urao; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso24099661fa.0;
        Fri, 21 Feb 2025 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740143117; x=1740747917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAKJ4JhTAh9B3aTL+NpfdpPg1I51P/DDjZ6vx5RxIwA=;
        b=SRV9UraoE8vC1UUU+G0ebXNiguz59glglO1NRaDcNMgVuQMm6E0zVilQGPw1qfIGqw
         vP9TvMX/k+SxBle4xALL+w4LWmovO5c9XswSfEYnaha9y1ySepxUqhmHr8UGkTtlQiEC
         /1oCYrF3QwYEpRMOg3YG0fbu0swVciS21YYoCHkQujkR7sgxqCdYRLmwCH8RPy3qruaN
         qeZJ9U6Vwqu4Y9c24Tp60dNJB+IDmlhywg4d815lRc25Bjv/q77QH5nfapSJvD2ltpB2
         2cjTm8NtsnLwmd65hyE92bULVwBB37Ny2SEtixQEcH5s2slQL1Tufu8btVlbqJmhItnk
         d7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143117; x=1740747917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAKJ4JhTAh9B3aTL+NpfdpPg1I51P/DDjZ6vx5RxIwA=;
        b=X8gWs7Om7YMe5rlV1sJs6IpZ39lLT9IfbUl8HQuURq2JKpjqNlpZUytHDci39lnQ0r
         SJfci1D+/9sSg97PFzbs2MORzqKCP05ZsnxBu5B789chp9nJdq5uf5GeSmOuIKr8HyPl
         Z5htja/3eO8fUqqphZAyOS3lHVZTcNIFXqmFAzmGONcSsSZPs/6T45wYTG+Glo+Qs916
         hAp6QzeA0HuLcehin1SBB7Pd0y4Gv5c5rYLCKnd0uukPzzp9gBgLAj/TnEVLqAZWZUnx
         lxxxfuI/xYPpFi5XmxGzVZHse+WZ1LVbV2ULfqIP4vE5loUvkWZ54S+QHXSRS4jHPf6Q
         njRA==
X-Forwarded-Encrypted: i=1; AJvYcCWbGC9XRiPNpUi5sjQZgdXlHWL3wobgLVrv2akA6IoWOK/xJNlBO7ArvHEdtdAZXUEBkrW3e69YiH8oE7Lfh2c=@vger.kernel.org, AJvYcCXDh1QSL+OkZTr1Tc3IsjqIIPRM9Xm27tqOMnsKHGtdJni7LRQ9LrOiSthUFt0BIUfZBAP7rsr9gqrGauY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrMiqfjIvAQ7W+UKhBlda7JQlIWTQICP/8uuRhU0bT8ZunzuAD
	VqrMsdxhF0AE8Q6kqTG5ZD/M5GlM6UnXfBWDfzBLz/1CeBvCDjDWGrgme+uNx9Gm5qtQQHG2PII
	1RuoRBwNRbPXiPF9PoT6e79ZDod8=
X-Gm-Gg: ASbGncs7KL79XvpFIljSq7aNpuzVkT5+uzDEhGyuO7PA4Pi+5cGM76KmR1rG0vuNvgh
	bGDVBq7k6bNNpR2ndByu2NJyrJUAjMw27u3G+6CmKy/O02BSp32ntbxa9tvtk0mg3X0R5MNVzD4
	NlnJucoQMohL3Q3ftEkiGTV0NX78S90PRDTlzmbKmW
X-Google-Smtp-Source: AGHT+IFxD7UiNGfeIJfsrzxN13otJDm/MtOGQzeOn9Xhl1sAyZr50JSGNwuMGzyCCmS5EPfwACd04eUfcrBQIoGnyy8=
X-Received: by 2002:a2e:2a04:0:b0:309:31bf:ec17 with SMTP id
 38308e7fff4ca-30a506516aemr21380251fa.15.1740143116226; Fri, 21 Feb 2025
 05:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com> <87r03rhfpu.fsf@kernel.org>
In-Reply-To: <87r03rhfpu.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 08:04:40 -0500
X-Gm-Features: AWEUYZnrmn0YhMl1tGVtVHd3jHTam7fkVYX9JZeVZCh2csaisJTp8qQkgXg8o68
Message-ID: <CAJ-ks9mfe3JBVALO6RJPie6Ae1afH7jsE5jR1jWo_sK266_XPQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:20=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>
> [...]
>
> >> >> +pub unsafe trait HrTimerHandle {
> >> >> +    /// Cancel the timer, if it is running. If the timer handler i=
s running, block
> >> >> +    /// till the handler has finished.
> >> >> +    fn cancel(&mut self) -> bool;
> >> >> +}
> >> >> +
> >> >> +/// Implemented by structs that contain timer nodes.
> >> >> +///
> >> >> +/// Clients of the timer API would usually safely implement this t=
rait by using
> >> >> +/// the [`crate::impl_has_hr_timer`] macro.
> >> >> +///
> >> >> +/// # Safety
> >> >> +///
> >> >> +/// Implementers of this trait must ensure that the implementer ha=
s a [`HrTimer`]
> >> >> +/// field at the offset specified by `OFFSET` and that all trait m=
ethods are
> >> >> +/// implemented according to their documentation.
> >> >> +///
> >> >> +/// [`impl_has_timer`]: crate::impl_has_timer
> >> >> +pub unsafe trait HasHrTimer<T> {
> >> >> +    /// Offset of the [`HrTimer`] field within `Self`
> >> >> +    const OFFSET: usize;
> >> >
> >> > Does this need to be part of the trait? As an alternative the provid=
ed
> >> > methods could be generated in the macro below and reduce the
> >> > opportunity to implement this trait incorrectly.
> >>
> >> There is no risk of implementing the trait wrong, because it is usuall=
y
> >> derived by a macro.
> >
> > There's no risk when it's implemented by the macro, but you used the
> > word usually,  which means there is a risk.
> >
> >> We need at least one of the methods to be able to have the type system
> >> verify that the type for which we implement `HasHrTImer` actually has =
a
> >> field with the name we specify, and that this field has the right type=
.
> >> And to have that, we need the OFFSET.
> >
> > I don't follow this logic. OFFSET is calculated in the body of the
> > macro. I'm suggesting that the macro generate the method
> > implementations (which would no longer be provided). In effect I'm
> > saying: keep OFFSET private.
> >
> > I'm also noticing now that the macro generates an implementation of
> > raw_get_timer *in addition to* the provided implementation. Why are
> > both needed?
>
> HasHrTimer is unsafe, because it would be unsound to implement, if the
> type it is implemented on does not have a `Timer` at the specified
> offset.
>
> To be able to implement it safely with a macro, the macro must verify
> that the type we implement the trait on satisfies the safety
> requirement. That is, we have to have the macro verify that the type
> indeed has a field of type `Timer` with the given name. If that is the
> case, the macro can calculate OFFSET.
>
> The way we achieve this is we re-implement on of the trait methods in
> such a way that it only compiles if the type we reimplement trait
> on actually have the field of the right type.
>
> I want to generate as little code as possible in the macro, and I would
> rather rely on the default implementations given in the trait, than have
> the macro generate implementations for all the methods. Generated code
> are more difficult to reason about.

Again, I don't follow. The provided implementation of raw_get_timer is
either not used (in the presence of the macro) or it relies on the
implementer correctly setting OFFSET, which the compiler cannot check
and which can break at a distance.

Wouldn't it be simpler to just generate both functions that rely on
OFFSET? They're both one-liners that delegate to other existing
macros.

