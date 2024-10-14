Return-Path: <linux-kernel+bounces-363998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F6F99C99A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA59283146
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28213C67C;
	Mon, 14 Oct 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPEH5U1U"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505519E7E3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907145; cv=none; b=C1PrYwVmOeh87Y1HwnuY2RtVEce1tg5EYLfIHHURaH5A5oYDNQ/ioRCQkJOGLMx9cNktpAScgaEjaria+9NR5+wBItXhAARa0ESzAeKuKDb0+Ht9X1q7T7vEGS9g7KuO4BXNbUTaAZ9f+0BWzLwvqeZvxnlib9wxlhb63yTmm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907145; c=relaxed/simple;
	bh=BU4LuWW0oAx31KI6rZVb4JgW71lmTZOhPAB12k2kvWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiIAx4P+V6PP/V0iMcxfJI+zpRR58BlSUOIw54qt2gC/LEJMW57OROMBSsIG5NEWAPgQ1sDeBFblbDSeaJ4vA0e3hTt66vrxRc3Ndrpst/wPCcrbWukKmFH1PNRFaPpF8E45O1knKO9mWpXMhkxnKfpx3FCFPprozw/Z8gUVn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPEH5U1U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso929977f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728907142; x=1729511942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG+DsEAwPZHX55VViwHZ6XgB+yt50xPmhEaOfSNCdes=;
        b=xPEH5U1UnNqbODFpq++fQCDNhUQKVW/UwDMByrEg64j/NPNNQtsH6sL1n3vyq0DZdR
         +FCGd/WSOBiGHvrsRDBCKgWriw0PPI/h0XlGNXKND7T8Ml5fjg3mIEqEJbgVj7eKSUhH
         rXCoXX7J4YWIT7Seu3p3IZ9jsS2R5eQX05hLi0tQfrbkgyMDDRmt83w0hPla5bXrK0G7
         0waP9fuN/bTyb0FQJfpsSI7MjG0rbKiDJDkwGC+c7Q2PASQ3ycWQozeAnjufOpdemILh
         Jmo+L23Yz/D2DaN2j9AIMTB51X1FPolSSgn8Z0s2x9rhlrjURaB6Monz/TFZ3Rxaqri9
         BKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907142; x=1729511942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG+DsEAwPZHX55VViwHZ6XgB+yt50xPmhEaOfSNCdes=;
        b=vf6blQ+HJU/YI8PGR89+m0OS+WMQ+Mbzeslu7qqXaygeXolWpP1Zscm1bOJq0iPJvp
         adbHDXJZj27Y5UWgTqVzcQKdvwl7eCgelMmA/0MrJ9wB+YdCCuVwoUji4njtetjI8tw8
         UOJeSmTIeOQRChcravBsqDCSlvb2VHtHRyHYcKjfIXEbTqSlQB+1lD4pzxskpGJ2EIn5
         IzDwuP9iybJ8WwGjFHSPSl3YqIJAgtpxtMm1pYt6x9Yu7uE+Fh0ssuDZxOBrpCkxCf1k
         /Ps/cys4PHC3yYeAVZEqZI14M1W/TOiobcXl0rB8lDYg43lEDxNEKOzv/MfOv2qieX/i
         X9cg==
X-Forwarded-Encrypted: i=1; AJvYcCWc6pGIZrF52Ege2Pq64JTxFBK0F/a4b2aMAONe6DwKXDim+oLyAs0WoIej+qBLmIvET0uOv23/qXeU/rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXE6IO+lpI4+7h96rxYEb5FPAPQ6v9AExuAOKACRcw13/7D8+
	m0QynCEx5gcG4nyAfEPJjZRXDpcCU71+nm+Zmak7O8GrV72JvgxpFpSb7NF0VXhYSViNG0ttpgI
	WtkyVwysV0ioFZ12eBEw1GnVEx/K0196oJJh6
X-Google-Smtp-Source: AGHT+IHwFm01HJ/5Cy6fcO7IqlxywRdv+OxgNH/YSSYKW0kjqpPl+K7IcKEuOnrGinPiGVscbEewnvawE/AqrNfLzcQ=
X-Received: by 2002:adf:e88b:0:b0:37d:452b:478f with SMTP id
 ffacd0b85a97d-37d551aab7amr6721889f8f.4.1728907141844; Mon, 14 Oct 2024
 04:59:01 -0700 (PDT)
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
 <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com> <CAH5fLgierGcZ7SycTspdOrFofWGmM_UOKHUmfNQ0VjSzMtMB5g@mail.gmail.com>
 <2c895c91-1309-4727-9d70-2a7d49d2dfb7@gmail.com>
In-Reply-To: <2c895c91-1309-4727-9d70-2a7d49d2dfb7@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 13:58:49 +0200
Message-ID: <CAH5fLgiYZU+m9x=aGxB8eHatatvqBVHbjhtJegY6tzBStSp57w@mail.gmail.com>
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

On Mon, Oct 14, 2024 at 1:53=E2=80=AFPM Dirk Behme <dirk.behme@gmail.com> w=
rote:
>
> Hi Alice,
>
> On 14.10.24 11:38, Alice Ryhl wrote:
> > On Mon, Oct 14, 2024 at 8:58=E2=80=AFAM Dirk Behme <dirk.behme@gmail.co=
m> wrote:
> >>
> >> On 13.10.24 23:06, Boqun Feng wrote:
> >>> On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
> >>>> On 13.10.24 00:26, Boqun Feng wrote:
> >>>>> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
> >>>>>> On 12.10.24 09:41, Boqun Feng wrote:
> >>>>>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
> >>>>>>>> On 12.10.24 01:21, Boqun Feng wrote:
> >>>>>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> >>>>>>>>>> Hi Andreas,
> >>>>>>>>>>
> >>>>>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> >>>>>>>>>>>
> >>>>>>>>>>> Dirk, thanks for reporting!
> >>>>>>>>>>
> >>>>>>>>>> :)
> >>>>>>>>>>
> >>>>>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
> >>>>>>>>>>>
> >>>>>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> >>>>>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
> >>>>>>>>>>>>>> Hi!
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> This series adds support for using the `hrtimer` subsystem=
 from Rust code.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I tried breaking up the code in some smaller patches, hope=
fully that will
> >>>>>>>>>>>>>> ease the review process a bit.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the fi=
rst (doctest)
> >>>>>>>>>>>>> Example from hrtimer.rs.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> This is from lockdep:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/tree/kernel/locking/lockdep.c#n4785
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Having just a quick look I'm not sure what the root cause i=
s. Maybe mutex in
> >>>>>>>>>>>>> interrupt context? Or a more subtle one?
> >>>>>>>>>>>>
> >>>>>>>>>>>> I think it's calling mutex inside an interrupt context as sh=
own by the
> >>>>>>>>>>>> callstack:
> >>>>>>>>>>>>
> >>>>>>>>>>>> ]  __mutex_lock+0xa0/0xa4
> >>>>>>>>>>>> ] ...
> >>>>>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
> >>>>>>>>>>>>
> >>>>>>>>>>>> , it is because:
> >>>>>>>>>>>>
> >>>>>>>>>>>> +//! struct ArcIntrusiveTimer {
> >>>>>>>>>>>> +//!     #[pin]
> >>>>>>>>>>>> +//!     timer: Timer<Self>,
> >>>>>>>>>>>> +//!     #[pin]
> >>>>>>>>>>>> +//!     flag: Mutex<bool>,
> >>>>>>>>>>>> +//!     #[pin]
> >>>>>>>>>>>> +//!     cond: CondVar,
> >>>>>>>>>>>> +//! }
> >>>>>>>>>>>>
> >>>>>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1=
]. Note that
> >>>>>>>>>>>> irq-off is needed for the lock, because otherwise we will hi=
t a self
> >>>>>>>>>>>> deadlock due to interrupts:
> >>>>>>>>>>>>
> >>>>>>>>>>>>       spin_lock(&a);
> >>>>>>>>>>>>       > timer interrupt
> >>>>>>>>>>>>         spin_lock(&a);
> >>>>>>>>>>>>
> >>>>>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply cre=
ated by
> >>>>>>>>>>>> ::new(), because irq contexts should guarantee interrupt dis=
abled (i.e.
> >>>>>>>>>>>> we don't support nested interrupts*).
> >>>>>>>>>>>
> >>>>>>>>>>> I updated the example based on the work in [1]. I think we ne=
ed to
> >>>>>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
> >>>>>>>>>>
> >>>>>>>>>> Yes, I agree. This answers one of the open questions I had in =
the discussion
> >>>>>>>>>> with Boqun :)
> >>>>>>>>>>
> >>>>>>>>>> What do you think regarding the other open question: In this *=
special* case
> >>>>>>>>>> here, what do you think to go *without* any lock? I mean the '=
while *guard
> >>>>>>>>>> !=3D 5' loop in the main thread is read only regarding guard. =
So it doesn't
> >>>>>>>>>> matter if it *reads* the old or the new value. And the read/mo=
dify/write of
> >>>>>>>>>> guard in the callback is done with interrupts disabled anyhow =
as it runs in
> >>>>>>>>>> interrupt context. And with this can't be interrupted (excludi=
ng nested
> >>>>>>>>>> interrupts). So this modification of guard doesn't need to be =
protected from
> >>>>>>>>>> being interrupted by a lock if there is no modifcation of guar=
d "outside"
> >>>>>>>>>> the interupt locked context.
> >>>>>>>>>>
> >>>>>>>>>> What do you think?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Reading while there is another CPU is writing is data-race, whi=
ch is UB.
> >>>>>>>>
> >>>>>>>> Could you help to understand where exactly you see UB in Andreas=
' 'while
> >>>>>>>> *guard !=3D 5' loop in case no locking is used? As mentioned I'm=
 under the
> >>>>>>>
> >>>>>>> Sure, but could you provide the code of what you mean exactly, if=
 you
> >>>>>>> don't use a lock here, you cannot have a guard. I need to the exa=
ct code
> >>>>>>> to point out where the compiler may "mis-compile" (a result of be=
ing
> >>> [...]
> >>>>>> I thought we are talking about anything like
> >>>>>>
> >>>>>> #[pin_data]
> >>>>>> struct ArcIntrusiveTimer {
> >>>>>>          #[pin]
> >>>>>>          timer: Timer<Self>,
> >>>>>>          #[pin]
> >>>>>> -      flag: SpinLockIrq<u64>,
> >>>>>> +      flag: u64,
> >>>>>>          #[pin]
> >>>>>>          cond: CondVar,
> >>>>>> }
> >>>>>>
> >>>>>> ?
> >>>>>>
> >>>>>
> >>>>> Yes, but have you tried to actually use that for the example from
> >>>>> Andreas? I think you will find that you cannot write to `flag` insi=
de
> >>>>> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`=
, so
> >>>>> not mutable reference for `ArcIntrusiveTimer`. You can of course us=
e
> >>>>> unsafe to create a mutable reference to `flag`, but it won't be sou=
nd,
> >>>>> since you are getting a mutable reference from an immutable referen=
ce.
> >>>>
> >>>> Yes, of course. But, hmm, wouldn't that unsoundness be independent o=
n the
> >>>> topic we discuss here? I mean we are talking about getting the compi=
ler to
> >>>
> >>> What do you mean? If the code is unsound, you won't want to use it in=
 an
> >>> example, right?
> >>
> >> Yes, sure. But ;)
> >>
> >> In a first step I just wanted to answer the question if we do need a
> >> lock at all in this special example. And that we could do even with
> >> unsound read/modify/write I would guess. And then, in a second step,
> >> if the answer would be "we don't need the lock", then we could think
> >> about how to make the flag handling sound. So I'm talking just about
> >> answering that question, not about the final example code. Step by ste=
p :)
> >>
> >>
> >>>> read/modify/write 'flag' in the TimerCallback. *How* we tell him to =
do so
> >>>> should be independent on the result what we want to look at regardin=
g the
> >>>> locking requirements of 'flag'?
> >>>>
> >>>> Anyhow, my root motivation was to simplify Andreas example to not us=
e a lock
> >>>> where not strictly required. And with this make Andreas example inde=
pendent
> >>>
> >>> Well, if you don't want to use a lock then you need to use atomics,
> >>> otherwise it's likely a UB,
> >>
> >> And here we are back to the initial question :) Why would it be UB
> >> without lock (and atomics)?
> >>
> >> Some (pseudo) assembly:
> >>
> >> Lets start with the main thread:
> >>
> >> ldr x1, [x0]
> >> <work with x1>
> >>
> >> x0 and x1 are registers. x0 contains the address of flag in the main
> >> memory. I.e. that instruction reads (ldr =3D=3D load) the content of t=
hat
> >> memory location (flag) into x1. x1 then contains flag which can be
> >> used then. This is what I mean with "the main thread is read only". If
> >> flag, i.e. x1, does contain the old or new flag value doesn't matter.
> >> I.e. for the read only operation it doesn't matter if it is protected
> >> by a lock as the load (ldr) can't be interrupted.
> >
> > If the compiler generates a single load, then sure.
>
> Yes :)
>
> > But for an
> > unsynchronized load, the compiler may generate two separate load
> > instructions and assume that both loads read the same value.
>
> Ok, yes, if we get this from the compiler I agree that we need the
> lock, even if its just for the read. If I get the chance the next time
> I will try to have a look to the compiler's result to get a better
> idea of this.

Usually I would say that for cases like this, the correct approach is
to use relaxed atomic loads and stores. That compiles down to ordinary
load/store instructions as desired without letting the compiler split
the load.

Alice

