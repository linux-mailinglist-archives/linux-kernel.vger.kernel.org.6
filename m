Return-Path: <linux-kernel+bounces-363713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E5399C609
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16B8B23BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B0156C72;
	Mon, 14 Oct 2024 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYhVoF1t"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196015667B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898745; cv=none; b=DnNj7eHdUgqoSWk0aHx8sPnBv/CnNj2rOkwDut8GxuYX87n7gAvOF5ggA9TWvCW1ByxVs1BnEB7gS9aAciNTLPo35WftYnXfS/VlUx60tbaUbFcqRLpvQ743feMPaZhV7PbNNHlRdyD1YwZm27chY3Xwy1osYi57q2xOEqI9jVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898745; c=relaxed/simple;
	bh=atf9cxxXJhH217cnmDapxD/aBntumO7oqHV2osJfBM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gysTpgk9qbfCujik46eNe6kZiEBE4fkmJd5B40FjEec52jf5xbuuZEte9UCU0A1lLOYRA5Ng4ryKggIVOugfIgDVyAI+eHYOjgnk0b1uu1E7IUnHtXXJGWSA+DAiv2ofUnboCo6XoaodKerOAkGQMLf4mD4c9MIp0zzAfGtcOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYhVoF1t; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so766813f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728898741; x=1729503541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b001oiV/UzZqPLybgR/FM6soHDX3/9WwSoJrMQ060j0=;
        b=rYhVoF1tnh1RXYZZVuOwlpCh/W9U47yXXbuLuea+jBzp7pZqGQa4utDqpxW5Bc8sw1
         QDJDiLb7D4pDDXsAJgR3WbZxz8u31dhkb8OvFYHA8r/E49fIcPu7PbM/bJv8bW4asfFS
         CPlg0TGszZixrX5N4QJt6FGdEt86zuUfSEmR8jDXQUq0lJffdbTWHG3oYmbGBCitTd8h
         OExMp1RHStJu//jlRbZF2tJ0v+fHr4kzfTk4/6CTaUmuZtR5aHL4k8O0U20PsVQRk10V
         CDjyrs2HkeVn0xEUvS+sCQoJNHnqydp5JYfqbxo1uN5SzYOUI92qW+fZcPdQZ9E9JonD
         Jztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898741; x=1729503541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b001oiV/UzZqPLybgR/FM6soHDX3/9WwSoJrMQ060j0=;
        b=nlhnLfrdgaBRbcj/VOwHI6bkse/5ek+RKHMdB1EhEIWwP7q4e0ONSAbIOd1jk2i86K
         4AGOuQPGPWVcrw5K4Qk9KOzrY6LN/1m2+hKD9dfk1iH26rbGHJkrFOQ+cto4RynMKm1Z
         osyYSeV7XDLqhoVBwfEKw70GQsX937FmaeQflv25diNGY/UaIIZhOzKCTJg40IVmgKrk
         5gzZLcsh2L+k0IrvjiY5R6pvXNhSmOsIAvBTTf6goSFEhiXIVOA6VtAAakHyTZZKTL6g
         eAvFDgwHqQPJgCutjuv0jh/9hDazPjpsjjIiiNk8Re8cKHmVhIEQZDwUMc3FuuyUVtjJ
         8/gg==
X-Forwarded-Encrypted: i=1; AJvYcCVZmr5plifukn/lbK/FhORRzNs9anvEIGevEl/v2nhoQ2EtsiNtVmH4u7CUkXlECW8pXFC4ln+ugK00HR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznyiYjqybS7Hi1jS+jjetIucHUs5MR/fSrQtldTBSKbF9Sy7YE
	MSNkdQMmQEUe+Oe2G0g7hnONxwaUj0yilJxlNz9qnK87+Wv3H+2bO9XZ2G7qglhmPOHzOKLlkZ7
	NHog5ZBsOLyH5b8m43OoTPGDvM96F4nSEYwYn
X-Google-Smtp-Source: AGHT+IE3eJL/hR0/vEuuq6MwdpcQ3awsduVnI1XTTUpTPwx5QABtwxoL6EMVsQSmoSkQ4WGLyCRynnFRwfJnPVZkxYM=
X-Received: by 2002:a05:6000:11ce:b0:37d:4e20:9be0 with SMTP id
 ffacd0b85a97d-37d600c91ecmr4669904f8f.51.1728898741238; Mon, 14 Oct 2024
 02:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux> <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com> <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com> <ZwooHrqIiirl1so7@boqun-archlinux>
 <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com> <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
 <c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com> <Zww2Vhsl9sutNm0s@Boquns-Mac-mini.local>
 <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com>
In-Reply-To: <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 11:38:49 +0200
Message-ID: <CAH5fLgierGcZ7SycTspdOrFofWGmM_UOKHUmfNQ0VjSzMtMB5g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 8:58=E2=80=AFAM Dirk Behme <dirk.behme@gmail.com> w=
rote:
>
> On 13.10.24 23:06, Boqun Feng wrote:
> > On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
> >> On 13.10.24 00:26, Boqun Feng wrote:
> >>> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
> >>>> On 12.10.24 09:41, Boqun Feng wrote:
> >>>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
> >>>>>> On 12.10.24 01:21, Boqun Feng wrote:
> >>>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> >>>>>>>> Hi Andreas,
> >>>>>>>>
> >>>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> >>>>>>>>>
> >>>>>>>>> Dirk, thanks for reporting!
> >>>>>>>>
> >>>>>>>> :)
> >>>>>>>>
> >>>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
> >>>>>>>>>
> >>>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> >>>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
> >>>>>>>>>>>> Hi!
> >>>>>>>>>>>>
> >>>>>>>>>>>> This series adds support for using the `hrtimer` subsystem f=
rom Rust code.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I tried breaking up the code in some smaller patches, hopefu=
lly that will
> >>>>>>>>>>>> ease the review process a bit.
> >>>>>>>>>>>
> >>>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the firs=
t (doctest)
> >>>>>>>>>>> Example from hrtimer.rs.
> >>>>>>>>>>>
> >>>>>>>>>>> This is from lockdep:
> >>>>>>>>>>>
> >>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/kernel/locking/lockdep.c#n4785
> >>>>>>>>>>>
> >>>>>>>>>>> Having just a quick look I'm not sure what the root cause is.=
 Maybe mutex in
> >>>>>>>>>>> interrupt context? Or a more subtle one?
> >>>>>>>>>>
> >>>>>>>>>> I think it's calling mutex inside an interrupt context as show=
n by the
> >>>>>>>>>> callstack:
> >>>>>>>>>>
> >>>>>>>>>> ]  __mutex_lock+0xa0/0xa4
> >>>>>>>>>> ] ...
> >>>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
> >>>>>>>>>>
> >>>>>>>>>> , it is because:
> >>>>>>>>>>
> >>>>>>>>>> +//! struct ArcIntrusiveTimer {
> >>>>>>>>>> +//!     #[pin]
> >>>>>>>>>> +//!     timer: Timer<Self>,
> >>>>>>>>>> +//!     #[pin]
> >>>>>>>>>> +//!     flag: Mutex<bool>,
> >>>>>>>>>> +//!     #[pin]
> >>>>>>>>>> +//!     cond: CondVar,
> >>>>>>>>>> +//! }
> >>>>>>>>>>
> >>>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1].=
 Note that
> >>>>>>>>>> irq-off is needed for the lock, because otherwise we will hit =
a self
> >>>>>>>>>> deadlock due to interrupts:
> >>>>>>>>>>
> >>>>>>>>>>      spin_lock(&a);
> >>>>>>>>>>      > timer interrupt
> >>>>>>>>>>        spin_lock(&a);
> >>>>>>>>>>
> >>>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply creat=
ed by
> >>>>>>>>>> ::new(), because irq contexts should guarantee interrupt disab=
led (i.e.
> >>>>>>>>>> we don't support nested interrupts*).
> >>>>>>>>>
> >>>>>>>>> I updated the example based on the work in [1]. I think we need=
 to
> >>>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
> >>>>>>>>
> >>>>>>>> Yes, I agree. This answers one of the open questions I had in th=
e discussion
> >>>>>>>> with Boqun :)
> >>>>>>>>
> >>>>>>>> What do you think regarding the other open question: In this *sp=
ecial* case
> >>>>>>>> here, what do you think to go *without* any lock? I mean the 'wh=
ile *guard
> >>>>>>>> !=3D 5' loop in the main thread is read only regarding guard. So=
 it doesn't
> >>>>>>>> matter if it *reads* the old or the new value. And the read/modi=
fy/write of
> >>>>>>>> guard in the callback is done with interrupts disabled anyhow as=
 it runs in
> >>>>>>>> interrupt context. And with this can't be interrupted (excluding=
 nested
> >>>>>>>> interrupts). So this modification of guard doesn't need to be pr=
otected from
> >>>>>>>> being interrupted by a lock if there is no modifcation of guard =
"outside"
> >>>>>>>> the interupt locked context.
> >>>>>>>>
> >>>>>>>> What do you think?
> >>>>>>>>
> >>>>>>>
> >>>>>>> Reading while there is another CPU is writing is data-race, which=
 is UB.
> >>>>>>
> >>>>>> Could you help to understand where exactly you see UB in Andreas' =
'while
> >>>>>> *guard !=3D 5' loop in case no locking is used? As mentioned I'm u=
nder the
> >>>>>
> >>>>> Sure, but could you provide the code of what you mean exactly, if y=
ou
> >>>>> don't use a lock here, you cannot have a guard. I need to the exact=
 code
> >>>>> to point out where the compiler may "mis-compile" (a result of bein=
g
> > [...]
> >>>> I thought we are talking about anything like
> >>>>
> >>>> #[pin_data]
> >>>> struct ArcIntrusiveTimer {
> >>>>         #[pin]
> >>>>         timer: Timer<Self>,
> >>>>         #[pin]
> >>>> -      flag: SpinLockIrq<u64>,
> >>>> +      flag: u64,
> >>>>         #[pin]
> >>>>         cond: CondVar,
> >>>> }
> >>>>
> >>>> ?
> >>>>
> >>>
> >>> Yes, but have you tried to actually use that for the example from
> >>> Andreas? I think you will find that you cannot write to `flag` inside
> >>> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, =
so
> >>> not mutable reference for `ArcIntrusiveTimer`. You can of course use
> >>> unsafe to create a mutable reference to `flag`, but it won't be sound=
,
> >>> since you are getting a mutable reference from an immutable reference=
.
> >>
> >> Yes, of course. But, hmm, wouldn't that unsoundness be independent on =
the
> >> topic we discuss here? I mean we are talking about getting the compile=
r to
> >
> > What do you mean? If the code is unsound, you won't want to use it in a=
n
> > example, right?
>
> Yes, sure. But ;)
>
> In a first step I just wanted to answer the question if we do need a
> lock at all in this special example. And that we could do even with
> unsound read/modify/write I would guess. And then, in a second step,
> if the answer would be "we don't need the lock", then we could think
> about how to make the flag handling sound. So I'm talking just about
> answering that question, not about the final example code. Step by step :=
)
>
>
> >> read/modify/write 'flag' in the TimerCallback. *How* we tell him to do=
 so
> >> should be independent on the result what we want to look at regarding =
the
> >> locking requirements of 'flag'?
> >>
> >> Anyhow, my root motivation was to simplify Andreas example to not use =
a lock
> >> where not strictly required. And with this make Andreas example indepe=
ndent
> >
> > Well, if you don't want to use a lock then you need to use atomics,
> > otherwise it's likely a UB,
>
> And here we are back to the initial question :) Why would it be UB
> without lock (and atomics)?
>
> Some (pseudo) assembly:
>
> Lets start with the main thread:
>
> ldr x1, [x0]
> <work with x1>
>
> x0 and x1 are registers. x0 contains the address of flag in the main
> memory. I.e. that instruction reads (ldr =3D=3D load) the content of that
> memory location (flag) into x1. x1 then contains flag which can be
> used then. This is what I mean with "the main thread is read only". If
> flag, i.e. x1, does contain the old or new flag value doesn't matter.
> I.e. for the read only operation it doesn't matter if it is protected
> by a lock as the load (ldr) can't be interrupted.

If the compiler generates a single load, then sure. But for an
unsynchronized load, the compiler may generate two separate load
instructions and assume that both loads read the same value.

Alice

