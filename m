Return-Path: <linux-kernel+bounces-530526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1FAA434D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D43B50D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCE256C7D;
	Tue, 25 Feb 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcLSdeYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B7256C6A;
	Tue, 25 Feb 2025 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462618; cv=none; b=RyStwVwpVnzVdcHcQQXWyd/bjlqW+Mt09OaE3/e6R0Zm/jAVcL4qRmv714s352d8mc2Zkg56YsTzrlPsiz9OjdbublQMqEwTSM/rCSO5VCUkU1LK5itFjNQV2jaUBsHV5yvMG7JmgGg9jndrtT1MvqeH1bSGOIdEfDTORpCSKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462618; c=relaxed/simple;
	bh=t8sdQCeTTX8RFNuY4/UZFxd3x4bZVIhocjtE7FRwH4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uyhV95JaxDOdZRRP3bA5L/lOU6VuFlGGtZtZv8dOnKW73euKaqnjAmmfx92809vbAzIYVxtWR9OqvfW/42tnQ65o3OSyg4gICqkLoLtMakYHoqDyv8qkaEESnliMDjvoxjgKlDh3dIkqVX3zwXGc5Tv6YaCFCmd+jwGhAHYGWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcLSdeYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E389DC4CEDD;
	Tue, 25 Feb 2025 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740462617;
	bh=t8sdQCeTTX8RFNuY4/UZFxd3x4bZVIhocjtE7FRwH4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pcLSdeYF2uwgdKN18NTuJjZ8qapOh38MSQJpaWef4g5OKoGjcqOUHbVcwB4hcbs4x
	 1J9aY3PUWihYsyOAzFuHyyQuqOiPirQ6pzJmZ0lm0jMpvkSDeNb1QRavHmebGX4mcE
	 mPvpdDTa/WpJK5/9016U8JPThzqyrPDNzgXoKdZNVFQshtX6Prevy1n5IsdT8MWFHp
	 6fdC2qmh593yL67IMPMOpJUa7Ek4ZC9qZpRFaBwam0FrigKdfugu4A4T1Qfus8Gyom
	 p+K251bKoWgVYnBIxuzTjlrUA17DAZ+jDP+sx91/INOAGL9fhi2r74KvrIiDYA4cZz
	 gmEHPQ1Y0cA5Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <Z7zVE_CvmIVukkXB@boqun-archlinux> (Boqun Feng's message of "Mon,
	24 Feb 2025 12:22:43 -0800")
References: <Z7yUTNEg6gMW0G7b@Mac.home>
	<CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
	<Z7ye0MsACNWe7Mbr@Mac.home>
	<CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
	<WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
	<Z7yl-LsSkVIDAfMF@Mac.home> <87msebyxtv.fsf@kernel.org>
	<4UoaifxB7JgBVKsNQyFR_T8yc3Vtn5TLAEdxdXrojNmOzJSEncopauEyjDpnbqzr8Z74ZWjd_N-bB-BwBS-7aQ==@protonmail.internalid>
	<Z7zF8KF9qTCr_n4l@boqun-archlinux> <87bjuryvb0.fsf@kernel.org>
	<063qoO_vJBc-GBX1qwkecM_QHJE1_67s71TdEk7Nlc-sDOjDXhvV3FVKAt_81jGxJY6S-oCv5i-gLatkQPfj3Q==@protonmail.internalid>
	<Z7zVE_CvmIVukkXB@boqun-archlinux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 06:50:01 +0100
Message-ID: <875xkyzi7q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Mon, Feb 24, 2025 at 08:52:35PM +0100, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>>
>> > On Mon, Feb 24, 2025 at 07:58:04PM +0100, Andreas Hindborg wrote:
>> >> > On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
>> >> >> On Mon, Feb 24, 2025 at 5:31=E2=80=AFPM Boqun Feng <boqun.feng@gma=
il.com> wrote:
>> >> >> >
>> >> >> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
>> >> >> > >
>> >> >> > > side -- Andreas and I discussed it the other day. The descript=
ion of
>> >> >> > > the issue has some lines, but perhaps the commit message could
>> >> >> >
>> >> >> > Do you have a link to the issue?
>> >> >>
>> >> >> Sorry, I meant "description of the symbol", i.e. the description f=
ield
>> >> >> in the patch.
>> >> >>
>> >> >
>> >> > Oh, I see. Yes, the patch description should provide more informati=
on
>> >> > about what the kconfig means for hrtimer maintainers' development.
>> >>
>> >> Right, I neglected to update the commit message. I will do that if we
>> >> have another version.
>> >>
>> >> >
>> >> >> > I asked because hrtimer API is always available regardless of the
>> >> >> > configuration, and it's such a core API, so it should always be =
there
>> >> >> > (Rust or C).
>> >> >>
>> >> >> It may not make sense for something that is always built on the C
>> >> >> side, yeah. I think the intention here may be that one can easily
>> >> >> disable it while "developing" a change on the C side. I am not sure
>> >> >> what "developing" means here, though, and we need to be careful --
>> >> >> after all, Kconfig options are visible to users and they do not ca=
re
>> >> >> about that.
>> >> >>
>> >> >
>> >> > Personally, I don't think CONFIG_RUST_HRTIMER is necessarily becaus=
e as
>> >> > you mentioned below, people can disable Rust entirely during
>> >> > "developing".
>> >> >
>> >> > And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
>> >> > config provides hrtimer maintainers a way that they could disable R=
ust
>> >> > hrtimer abstraction (while enabling other Rust component) when they=
're
>> >> > developing a change on the C side, right? If so, it's hrtimer
>> >> > maintainers' call, and this patch should provide more information on
>> >> > this.
>> >> >
>> >> > Back to my personal opinion, I don't think this is necessary ;-)
>> >> > Particularly because I can fix if something breaks Rust side, and I=
'm
>> >> > confident and happy to do so for hrtimer ;-)
>> >>
>> >> As Miguel said, the idea for this came up in the past week in one of =
the
>> >> mega threads discussing rust in general. We had a lot of "what happens
>> >> if I change something in my subsystem and that breaks rust" kind of
>> >> discussions.
>> >>
>> >
>> > So far we haven't heard such a question from hrtimer maintainers, I
>> > would only add such a kconfig if explicitly requested.
>>
>> It gives flexibility and has no negative side effects. Of course, if it
>
> The negative side effects that I can think of:
>
> * It doubles the work for testing, it's a Kconfig after all, so every
>   reasonable test run will have to run at least one build with it and
>   one build without it combined with other configs.
>
> * It may compelicate other component. For example, if I would like
>   use hrtimer in a doc test of a lock component (the component itself
>   doesn't depend on hrtimer, so it exists with CONFIG_RUST_HRTIMER=3Dn),
>   because I would like to unlock something after a certain time. Now
>   since CONFIG_RUST_HRTIMER can be unset, how would I write the test?
>
>   #[cfg(CONFIG_RUST_HRTIMER)]
>   <use the Rust timer>
>   #[cfg(not(CONFIG_RUST_HRTIMER))]
>   <use the C timer? with unsafe??>
>
> A new kconfig is not something free. We will need to cope with it in
> multiple places.

Alright, those are valid arguments.

>
>> is unwanted, we can just remove it. But I would like to understand the
>> deeper rationale.
>>
>>
>> >
>> >> For subsystems where the people maintaining the C subsystem is not the
>> >> same people maintaining the Rust abstractions, this switch might be
>> >> valuable. It would allow making breaking changes to the C code of a
>> >> subsystem without refactoring the Rust code in the same sitting. Rath=
er
>> >
>> > That's why I asked Frederic to be a reviewer of Rust hrtimer API. In
>> > longer-term, more and more people will get more or less Rust knowledge,
>> > and I'd argue that's the direction we should head to. So my vision is a
>> > significant amount of core kernel developers would be able to make C a=
nd
>> > Rust changes at the same time. It's of course not mandatory, but it's
>> > better collaboration.
>>
>> Having this switch does not prevent longer term plans or change
>> directions of anything. It's simply a convenience feature made
>> available. I also expect the future you envision. But it is an
>> envisioned _future_. It is not the present reality.
>>
>
> The reality is: we haven't heard hrtimer maintainers ask for this,
> right? I know you're trying to do something nice, I do appreciate your
> intention, but if hrtimer maintainers haven't asked for this, maybe it
> implies that they can handle or trust that wouldn't be a problem?

Thanks for explaining.

For reference, we do not have this feature in block, and it was not a
problem yet.

Let's await hrtimer maintainers and follow their lead.



Best regards,
Andreas Hindborg



