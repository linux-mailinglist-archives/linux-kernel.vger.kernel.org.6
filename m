Return-Path: <linux-kernel+bounces-333134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5997C461
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCCC283EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A918DF7C;
	Thu, 19 Sep 2024 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJrx8AGn"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2F1386D7
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728114; cv=none; b=o4WPeaa33+TGnJA7qB3zDiQGlC1jp51hBJB3jpegYCLo6FA9pyc/fZVdxWlt8mNBMK53zEyVbsLxSkYCocjRHlvjO20zmkdO/am0yL8Eu8q9oQi7+uhp357+WHlLx5/sXzM7+teyFtw71lnMaaYGN3/TMqQaak6aWXkrAzhPAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728114; c=relaxed/simple;
	bh=e4Nu5MGmGZequOr+3wn9e4KbQgdR2rd2ZaJgzM1jll8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQQvcJ5ekv7BT8iLyRO7AA1TvFIcCED0F9bDCYsXXmJK+6887jx9FrazR4PKebfyYlcDQWBcki+kDIbQrQnetW04J7UW306xY5pwGPCslWQQ2GaEeKbPyGqmpWC5fWMkQ0KBV5Zt6Ywhwa9wpUmXe6KCvZC2ANy0Q4qXVa6G61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJrx8AGn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso5430055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726728111; x=1727332911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWdqrGJZj3KqeR7dMvmtNPPn0JD8u6tlo67ak5aubqY=;
        b=dJrx8AGnuClOsCH7mxmHdkx6M1tlgJzOXE2gS8rkHkSIkYFJn/ti0rcgonrDhTdpdw
         KIFcZXV3Rb2BByHjtkEvmnsrR467HHyfIb6Jq+hIHqgMcMNjt5hNb03L8Tzhv830O727
         bsAxTUsWE2tZ2rwzsDV4lEWkpUbV9vpbJJPInOvGg+5UfS0/87c2CMKBUcx+LRlquG2Q
         nci9+1Hwb4dirRwWFdwPG0aqLIPqho7a7Thr/yTBDrYMp3vrG2Jmfe6e5JbR0jva60sN
         NA8GtyHI2+O2Z2fkAkKxfv17gpu0vSul6QBO+yWHiVJkUYdCo5lfL569CZ8bTIPRwwI8
         qF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726728111; x=1727332911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWdqrGJZj3KqeR7dMvmtNPPn0JD8u6tlo67ak5aubqY=;
        b=orxavw4aWD27KM0/cgNESTDXNtT8/bKJjXtxwfzcxUiwUZXZqTGE7TO3cd7gvDiq5p
         MMsI3Q44MkEF8ZQSj9aJtFbn72uEwsnfAJ3BQlPbSC4/98/ocCEYvsHlDl3CWkKUOP5E
         WVDTEMYR+V0jAQ+L9H6M4qIKBdxd84sLYPCmGezw0k0BxnWUAtK+Te0+rOUTg6W6MSa6
         FK09dBSdLLvMY4JSDfu/jUPyMoj9C71UIRC814ZJhOJk82EZ1nE6QBlZOGUZpeOeUBAk
         P4FE/IOTJuSKxXEykDCR1TsHM+pxBb+aZkoh3tvtiJX9HRn4DxFSJsBrxtJ8bwhFTrip
         GElw==
X-Forwarded-Encrypted: i=1; AJvYcCVYL+aewQUZFEs7vuCYk+J6XMsIHVUsre1Wwalbipej3lc8ZkhpTqON9eY+Wvh7xW3nNaE45mBWsUsb7Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TzO6/eXZWltmg1pwsOC7Xb/rucrY4sOwbL5xNrO9OS8aysPa
	qNhyn3vJ4PRtn6uiJ+UPTr22HnuOxNrA7B/GMbuCdUsKZz+B1f4H6i8Hdz4ZV5qdGlcy5uBYKAw
	5A/7tM322PuTYsKTjNxnJdLEoi98eYSu1epQI
X-Google-Smtp-Source: AGHT+IEAY6SNMgMRXWCLfhmIRUzjKDV0SG60S0x4zyYpYl2/gWmxNOGZKQIUMkh2I62LrYx87ycjwgfX01cHn2EFbf4=
X-Received: by 2002:adf:e546:0:b0:374:ba2b:4d1c with SMTP id
 ffacd0b85a97d-378d61f09cfmr17330821f8f.31.1726728110548; Wed, 18 Sep 2024
 23:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <20240917222739.1298275-5-a.hindborg@kernel.org> <uQyhqKNsbshVFUyAbdqOai1BfuYEl6ygcM8T-tTRf2rvmh6yIVNKqODmQavLegAedRUKVZ8JZoe7O-obhoz3Uw==@protonmail.internalid>
 <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me> <874j6cjiip.fsf@kernel.org> <87v7ysi2sd.fsf@kernel.org>
In-Reply-To: <87v7ysi2sd.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Sep 2024 08:41:37 +0200
Message-ID: <CAH5fLgjLf4nqH2m_VkB4kXzhuuN21wDF1BOd49qYLMR2R_E=kA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
> > "Benno Lossin" <benno.lossin@proton.me> writes:
> >
> >> On 18.09.24 00:27, Andreas Hindborg wrote:
> >>> Add a method to clone an arc from a pointer to the data managed by th=
e
> >>> `Arc`.
> >>>
> >>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >>> ---
> >>>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
> >>>  1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> >>> index a57ea3e2b44c..2c95712d12a2 100644
> >>> --- a/rust/kernel/sync/arc.rs
> >>> +++ b/rust/kernel/sync/arc.rs
> >>> @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
> >>>          unsafe { Self::from_inner(ptr) }
> >>>      }
> >>>
> >>> +    /// Clones an [`Arc`] instance from a pointer to the contained d=
ata.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must point to an allocation that is contained within a=
 live [`Arc<T>`].
> >>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
> >>> +        // SAFETY: The caller promises that this pointer points to d=
ata
> >>> +        // contained in an `Arc` that is still valid.
> >>> +        let inner =3D unsafe { ArcInner::container_of(ptr).as_ref() =
};
> >>> +
> >>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it=
 cannot
> >>> +        // overflow to zero. SAFETY: By the function safety requirem=
ent, there
> >>> +        // is necessarily a reference to the object, so it is safe t=
o increment
> >>> +        // the refcount.
> >>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
> >>> +
> >>> +        // SAFETY: We just incremented the refcount. This increment =
is now owned by the new `Arc`.
> >>> +        unsafe { Self::from_inner(inner.into()) }
> >>
> >> The implementation of this function looks a bit strange to me, how abo=
ut
> >> this?:
> >>
> >>     // SAFETY: this function has the same safety requirements as `from=
_raw`.
> >>     let arc =3D unsafe { Self::from_raw(ptr) };
> >>     let clone =3D arc.clone();
> >>     // Prevent decrementing the refcount.
> >>     mem::forget(arc);
> >>     clone
> >>
> >
> > We do not own
> > a refcount on the Arc. For a short duration you will have a wrong
> > refcount. If you have two Arcs and the refcount is 1, the ArcInner migh=
t
> > be dropped after the first line of this suggestion, before you do clone=
,
> > and then this is not sound.
>
> Well, disregard that. This is why one should not reply to emails before
> coffee in the morning.
>
> Of course, a precondition for calling this function is that the arc
> containing the data pointed to by `ptr` is live for the duration. So
> what you wrote would work. But I still do not like having two `Arc`s in
> existence with the wrong refcount.

Doing it this way has been pretty standard with std for a long time,
until the Arc::increment_strong_count and similar methods were added.
I think it's fine, though I would have used ManuallyDrop instead of
mem::forget.

Of course, in this particular case, using `ArcBorrow` is even better.

Alice

