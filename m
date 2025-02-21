Return-Path: <linux-kernel+bounces-525901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86760A3F716
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B43319C5106
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E720F09A;
	Fri, 21 Feb 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrhLm364"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01120F07C;
	Fri, 21 Feb 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147714; cv=none; b=HGE0s2c6kBCAih65Y1JsZvebcehcd1mW2bet95ba48JpjVcqDUnXtCoMg1NQt0DqcgV3dmOU7x9GBfXn4G0RiOAiPy7ehppr2ampYbv/hWsU31LkKfFm7Et1Prx/GbI7LI740aJwpu8LBWeiV8tCJ1qkO2JGWLBH9MWF45sFBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147714; c=relaxed/simple;
	bh=KH2LSxp5HiskMIEy8B2KMY95P7tOmxPEnEzALdzM8H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtSM/EmQA35LLjbRZ5F83h5iKyJNXKMPsnMmL/Rbxlywh40w4ClCoBe1K1AyMqDdgxu0G9bptdL58AFzZ5BtFwjUGjQbkiiDQaQfSL+pfAy/bsbm4GzYT6mpC7q4T6PdEtVqG9IMK+tt1Ku6t9RUw+mq0dtFBQ6g1TpVr2VDHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrhLm364; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30761be8fcfso19644971fa.0;
        Fri, 21 Feb 2025 06:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740147711; x=1740752511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZCJvRxi0/Mr6eA3W6ftvDTnj6qidWIEoe/AxCuI3i4=;
        b=QrhLm364o2UCsqNnfLllW7sJdT8rz9GdbuTLrKz4HRVHKu33/WY3v1WXC60M67Zqvh
         E6c9Ch8AwXv8HOhl6TgGO5LPVsQeX6prXqMHEPANlQkEArlVzG6fDAYcpfWDDWsvkRAS
         rHst6gPD5xinLPAoClJHLwLgmoCkarHWCBjl5uiUIGVGClQKhsq82JY9lS8C2PJUg4T0
         fS2kXwO36mMlLTZxcpgsTqeQ9P4Hzqt3pE+jDkuaNGb5G3ErjgED41S7NN7aAtew1PbQ
         HeG4Ea5TeCQKgveOosKh0I+pXJqgNC1jnlIO2UB/1xeu9rIrjmS+goz+U7qtX9STsD7w
         nhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147711; x=1740752511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZCJvRxi0/Mr6eA3W6ftvDTnj6qidWIEoe/AxCuI3i4=;
        b=ou1raNICMMOcUyaVWdKaIS/g0ztap2I0adSB1gGTQNmKMi3+nvn/9Xp5asXZBxUqUM
         GcfPt49OgTHfyD1YWQ5gS6fGZfV7kBZS5pJ8cPXh1ieGOTNbREZKVyNnFahIYaeOv+/n
         sPWyilAABlkZdxCGnAMGwH2dwoFpQ9hchZxtaJJIrNbd2N0kPACXvM14xQU5W39wXMLV
         neEkr22tkRx/2iNdjw7o5YyuhEtiC1F/zEBvzm+VZ0EBhG6EXHMivUIOZUsYCD24wLov
         PUMIsPQB2K+PDWkU3jM0fppSBARFAgBEpcgb9SM4+B4U0QgtFtWqwip2HFp/EedYbJPM
         mZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVNMOhMJSdjk+ISqI92x+GnxLEDHT9HwgaI6EouUJiJ8IySlQIL+SN2nSwBbOMueMO32HBxgW4funQsIuh5Buk=@vger.kernel.org, AJvYcCX+bSM7a1jVGwQiCIo73q2YxsoJ4khmBYaqK50olhdWlrR7cQqmFrhpZQvIlYmrM61J7X90Cg40R9fbLE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4qJ7gHnEDv6ZmOFvZjo8JQyrKVEpiKDDH8eDglOp9LqdQ2BC
	nAHI7hG1nJXbpZLBx6ghTf6BhNoPJ1f3p1zVIgN7f9Y38ozwURzaK6KlrmHlZyrjwZtAiQD/Yyp
	nEmGVcZ6e5u9qC90E2haCAoSTrmk=
X-Gm-Gg: ASbGncsgyUtmfXx3KwT65LHhjTUHPMWbqTLkMQkc3wHMVDrQcM8NN865dC76tMGsc2E
	s76yCJL+QpUlpzLh7z1fXB5IkJUdYe681INSYWwqa6Py2IXm1ELS+tUttNbbLNk4qhVGimMRaJR
	dcV9oZEMl5H5I/rHYGNI+V77B9Pi+44UVE1ur+uF9Nig==
X-Google-Smtp-Source: AGHT+IFqP7xajTtZNtfZfejub1Ng/e8qr2zLLbAwq8N/lJl9rRWBeUk52pbuAomwIloFgGZ0pI3sGoO2oVqDFEywaHE=
X-Received: by 2002:a2e:3516:0:b0:306:1524:4a65 with SMTP id
 38308e7fff4ca-30a598e59f5mr10809971fa.20.1740147710726; Fri, 21 Feb 2025
 06:21:50 -0800 (PST)
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
 <87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org>
In-Reply-To: <87cyfbe89x.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 09:21:14 -0500
X-Gm-Features: AWEUYZkNiPFPPOYhdALIzKHcQSsexL6ZJWm5YYY9rkDBZjc4PJ9zmsqmRRpvGYQ
Message-ID: <CAJ-ks9kLZ7LCTW+W4jhUqmF1ypJ7i56oSizdFV-1Ks5DiCoKsA@mail.gmail.com>
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

On Fri, Feb 21, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
> > "Tamir Duberstein" <tamird@gmail.com> writes:
> >
> >> On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
> >>>
> >>> "Tamir Duberstein" <tamird@gmail.com> writes:
> >>>
> >>> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindbor=
g@kernel.org> wrote:
>
> [...]
>
> >>> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
> >>> >> +    ///
> >>> >> +    /// # Safety
> >>> >> +    ///
> >>> >> +    /// `ptr` must point to a live allocation of at least the siz=
e of `Self`.
> >>> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer=
 {
> >>> >> +        // SAFETY: The field projection to `timer` does not go ou=
t of bounds,
> >>> >> +        // because the caller of this function promises that `ptr=
` points to an
> >>> >> +        // allocation of at least the size of `Self`.
> >>> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer=
)) }
> >>> >> +    }
> >>> >
> >>> > Can you help me understand why the various functions here operate o=
n
> >>> > *const Self? I understand the need to obtain a C pointer to interac=
t
> >>> > with bindings, but I don't understand why we're dealing in raw
> >>> > pointers to the abstraction rather than references.
> >>>
> >>> We cannot reference the `bindings::hrtimer` without wrapping it in
> >>> `Opaque`. This would be the primary reason. At other times, we cannot
> >>> produce references because we might not be able to prove that we sati=
sfy
> >>> the safety requirements for turning a pointer into a reference. If we
> >>> are just doing offset arithmetic anyway, we don't need a reference.
> >>
> >> Why do we have a pointer, rather than a reference, to Self in the
> >> first place? I think this is the key thing I don't understand.
> >
> > Perhaps it makes more sense if you look at the context. One of the entr=
y
> > points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
> > HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
> > handle contains an arc to a type that contains a `Timer` and implements
> > `HasHrTImer`. To get to the timer, we need to do pointer manipulation.
> > We only know how to get the `Timer` field via the `OFFSET`. The natural
> > return value from the offset operation is a raw pointer. Rather than
> > convert back to a reference, we stay in pointer land when we call
> > `HrTimer::raw_cancel`, because we need a pointer to the
> > `bindings::hrtimer` anyway, not a reference.
>
> I changed `HasHrTimer::start` to take a reference, and I think that
> makes sense =F0=9F=91=8D Taking an `impl AsRef` does not work out when `S=
elf` is
> `Pin<&T>`. I'll go over the whole thing and see of other places could
> benefit.

Can you elaborate please? Pin<&T>::get_ref returns &T, which gets you
to the AsRef you need, no?

