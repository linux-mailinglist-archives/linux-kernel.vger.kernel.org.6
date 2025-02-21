Return-Path: <linux-kernel+bounces-525898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA061A3F70A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A0C424FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D720F09A;
	Fri, 21 Feb 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSt2iKVG"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3920F07C;
	Fri, 21 Feb 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147595; cv=none; b=fpMUjDvQvw4i+HEgElxuYlvZbPoT3iHk3ps5W/QNaLMpJyE4OV6fWLMcyIG8vnQPbMZlaTMvIX4sFi8Kx3zdBWigIiMSTDCE00eK2MVFopAv/zSofN2ayB5MK0XVaRMc9tC7C5U7DsiEZl5iqvDLuQSRbQNXl9fZLE3GuMP64wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147595; c=relaxed/simple;
	bh=/FPue+W8pYp4zo9g8cxyH68F9XCko5YVnlu6UClRU7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBz1QEZJYhhBUWEpFgjAbpQFyiGlc6HpOQjFJqgKPXEetpC21ONe3xx2/i+jdj++O8Hm0J8neL3AOGP/krVOZObpKmttolxMx4waqmA4M5BlTRA9IDFaA8OS2ve6S4pUCk0F385JqhzpZpINyxBNz0/jC2IadlR/o31odaj/f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSt2iKVG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30737db1aa9so20699111fa.1;
        Fri, 21 Feb 2025 06:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740147592; x=1740752392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Birrd+3gPFpNagYjlEO10/s2HIO1cCg043jKV8DRXcw=;
        b=eSt2iKVGJYziYs/glvO4xW7Gax9oMOqzufkHqPiJZmfeqXn4homWDs+itDDJ5tnouo
         RtJO48ElHTT2tyMuj2v6Znl7oU5EYfPHMrXmE6mi/iMDpfMPmatb9Sv5Rg9Ewm3hdPu2
         SnsSMs/OllYXp/xjIW1qwoMuFM0GXGZiY8Z3gqnWkiQyj3CqDfWL0ivPcfljpt/0Yex8
         c+BbeWj4QWwGCSHtrwuE98847Ga+qcIpB6W+9mdhaVFcHMbteGKkbBJ7lECvebnhW8bQ
         syfCY+C9Kbyhm74AneS/ZlR2uViJWMNPJK+0dTR9+sEXJlktQGAWZPcLxdE9nSYRXFzh
         oCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147592; x=1740752392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Birrd+3gPFpNagYjlEO10/s2HIO1cCg043jKV8DRXcw=;
        b=uHs1hhALoq0byrG5y04T3xdzxTPScfhsqMoAbPBHNc34YOutAE3Kys1JO/hAXm5aRA
         vAg4X3ZwsdTMOq860dWJTJykQB1N0tXfI3HR+pUvAQxTKzMvj94DeifmP5sOnbpTIh2D
         jfvOrO2/iqrjSHBhy/RHmFMgKGIhkju6pVuXcLL6Y9xkvtIgsF4IIuloM1J99QUqZmmH
         rMbivtVFj72KGmXe4pYl6gvd2cLANQZ/a839itjLL8uAK6gJKY/NRpNLKDcr41P30H7F
         j1bzq8C4LhqimR7DSqYN8wa/dXYac9iuOaWvF7dcNQEvyX+an+zwkrzD/efTGskEQib5
         P9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUhpMh9LLDMHXmTgRWUXd4vS9S/lrUO69dZwHynALuiLhvLKgkecLoqkMg2UDeYMCHctzi3Am9v6FZOKbds3Zw=@vger.kernel.org, AJvYcCW2RjTeG8GlLl9zKv0iHFkA6Oiml6eRS7JsZE29j3klBQ8mX9Cwjhlh/mIoHZREWq8Li+/MuD7S5vhAH6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+ZUsNXFx4OGGt+cAmuCt+g855VAe3+1m1YWolcax6AdlQJyI
	34KRtthADUa9po7zt89/auB30Gtr1zcomCaiR4GE2LnbXZDRMPTj/9dlG71sUvxaHAqZ2oCt2Io
	cfvtjlT1qJFUgvM6m6ur6Z3/kpBY=
X-Gm-Gg: ASbGncvDmO+yY9QULF3jyLZpDZnmHI5xwwqiSwySVgt7zCqsqLF0Qbxfc7iQ7+3FjLu
	QrlLKbWiIhRADq2yzNVq0RRm30hK9G0TBYHtYwkmMfGtTaM4VOboT1BeIW7DWFAVgp7PMfyow1N
	/ctnzeRkqujzlT1wODuxmcnbALnOGKlUiZlIXfjTSefA==
X-Google-Smtp-Source: AGHT+IECYvMffRe/CwTv3YbcNqtmr67OzVDLF9WvXZS6URmgxiPIh+4hFJC0vFX/0uVp/lK8TYj+vQbKp55C9EXBl/Q=
X-Received: by 2002:a2e:7a02:0:b0:308:f827:f8e4 with SMTP id
 38308e7fff4ca-30a5985d90bmr9587741fa.7.1740147591733; Fri, 21 Feb 2025
 06:19:51 -0800 (PST)
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
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87r03rhfpu.fsf@kernel.org> <mEsEoJuiP_lEKsnf8nfVaquySinIsovqCT5_TxJD_22KTGqOgH7NO9jKYy1W-q95uiGd50brnTE13ydtRZgioA==@protonmail.internalid>
 <CAJ-ks9mfe3JBVALO6RJPie6Ae1afH7jsE5jR1jWo_sK266_XPQ@mail.gmail.com> <87ikp3e8t6.fsf@kernel.org>
In-Reply-To: <87ikp3e8t6.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 09:19:14 -0500
X-Gm-Features: AWEUYZnvhlW14fwAn-9GPsDeMTMCqxb1MLWuh8E7wlTF06MAzMCQN7YTkQyHvNY
Message-ID: <CAJ-ks9=P2W9+qk216N5HnTvW+yvfPfGbJf87cFjhv8SuayyW6w@mail.gmail.com>
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

On Fri, Feb 21, 2025 at 8:17=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > On Fri, Feb 21, 2025 at 3:20=E2=80=AFAM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>
> >> > On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg=
@kernel.org> wrote:
> >>
> >> [...]
> >>
> >> >> >> +pub unsafe trait HrTimerHandle {
> >> >> >> +    /// Cancel the timer, if it is running. If the timer handle=
r is running, block
> >> >> >> +    /// till the handler has finished.
> >> >> >> +    fn cancel(&mut self) -> bool;
> >> >> >> +}
> >> >> >> +
> >> >> >> +/// Implemented by structs that contain timer nodes.
> >> >> >> +///
> >> >> >> +/// Clients of the timer API would usually safely implement thi=
s trait by using
> >> >> >> +/// the [`crate::impl_has_hr_timer`] macro.
> >> >> >> +///
> >> >> >> +/// # Safety
> >> >> >> +///
> >> >> >> +/// Implementers of this trait must ensure that the implementer=
 has a [`HrTimer`]
> >> >> >> +/// field at the offset specified by `OFFSET` and that all trai=
t methods are
> >> >> >> +/// implemented according to their documentation.
> >> >> >> +///
> >> >> >> +/// [`impl_has_timer`]: crate::impl_has_timer
> >> >> >> +pub unsafe trait HasHrTimer<T> {
> >> >> >> +    /// Offset of the [`HrTimer`] field within `Self`
> >> >> >> +    const OFFSET: usize;
> >> >> >
> >> >> > Does this need to be part of the trait? As an alternative the pro=
vided
> >> >> > methods could be generated in the macro below and reduce the
> >> >> > opportunity to implement this trait incorrectly.
> >> >>
> >> >> There is no risk of implementing the trait wrong, because it is usu=
ally
> >> >> derived by a macro.
> >> >
> >> > There's no risk when it's implemented by the macro, but you used the
> >> > word usually,  which means there is a risk.
> >> >
> >> >> We need at least one of the methods to be able to have the type sys=
tem
> >> >> verify that the type for which we implement `HasHrTImer` actually h=
as a
> >> >> field with the name we specify, and that this field has the right t=
ype.
> >> >> And to have that, we need the OFFSET.
> >> >
> >> > I don't follow this logic. OFFSET is calculated in the body of the
> >> > macro. I'm suggesting that the macro generate the method
> >> > implementations (which would no longer be provided). In effect I'm
> >> > saying: keep OFFSET private.
> >> >
> >> > I'm also noticing now that the macro generates an implementation of
> >> > raw_get_timer *in addition to* the provided implementation. Why are
> >> > both needed?
> >>
> >> HasHrTimer is unsafe, because it would be unsound to implement, if the
> >> type it is implemented on does not have a `Timer` at the specified
> >> offset.
> >>
> >> To be able to implement it safely with a macro, the macro must verify
> >> that the type we implement the trait on satisfies the safety
> >> requirement. That is, we have to have the macro verify that the type
> >> indeed has a field of type `Timer` with the given name. If that is the
> >> case, the macro can calculate OFFSET.
> >>
> >> The way we achieve this is we re-implement on of the trait methods in
> >> such a way that it only compiles if the type we reimplement trait
> >> on actually have the field of the right type.
> >>
> >> I want to generate as little code as possible in the macro, and I woul=
d
> >> rather rely on the default implementations given in the trait, than ha=
ve
> >> the macro generate implementations for all the methods. Generated code
> >> are more difficult to reason about.
> >
> > Again, I don't follow. The provided implementation of raw_get_timer is
> > either not used (in the presence of the macro) or it relies on the
> > implementer correctly setting OFFSET, which the compiler cannot check
> > and which can break at a distance.
> >
> > Wouldn't it be simpler to just generate both functions that rely on
> > OFFSET? They're both one-liners that delegate to other existing
> > macros.
>
> No, I would rather generate as little code as possible. The only reason
> I am generating `raw_get_timer` is to be able to type check that the
> field name given to the macro has the right type.

At a minimum this code is inconsistent because it includes a provided
implementation which is never used.

But I continue to disagree that generating OFFSET and then doing raw
pointer manipulation is better than just generating a one-line method.
Perhaps someone else could weigh in.

