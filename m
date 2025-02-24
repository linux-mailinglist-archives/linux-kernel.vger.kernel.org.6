Return-Path: <linux-kernel+bounces-529883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E89A42C23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887AD16CD51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2124266B63;
	Mon, 24 Feb 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjbLZNQh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B06266577;
	Mon, 24 Feb 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423497; cv=none; b=tCdSSGx+stEEU7HbPhAw5Bua3m9pYEafhtsC+/rQn+BufVNX7lmdhnjDfPyYtE1AxqDGfIE9Rg40FButZDo+E6nRLClvwKjeuJAUX7dJa4FVVygLzzQILFAFTsVw5U+dMdPBUIN0+WlCHBcnNk+sx9axW17IirFkUJ/ohL+Po4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423497; c=relaxed/simple;
	bh=SvvwVkYase4DV+3hYhhZ9TkvoWn7Er4BeG+Lr15HTQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqkciCW+EJfhHnbUlAcZELtfPtVyeBtwRwhD1GcS7hx+z/vOFrLrUYF9lutquGCZ7epHtSfMqWjlCttbUKMICkZ1lH0HQhuY1cle0Sd9QLfyIMn8FDYBrl9jZzREi/MWe+huUQAtINc7POgDLwil5C8Obn2fkYuj2MITlCBc7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjbLZNQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E53C4CEDD;
	Mon, 24 Feb 2025 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423496;
	bh=SvvwVkYase4DV+3hYhhZ9TkvoWn7Er4BeG+Lr15HTQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VjbLZNQhXJQwpuTOtVf40rOG+/wnfaQF+2sxU9sRbr8PsuK2wds5PoVYCZubyp6Jl
	 leyJUlp+gDpgM74SJhtRro8T5JRB5GRMG2vXo8siZwIkCgsvnKKuu2IPqzdHj8Kx8I
	 sNI9p4F+f7kPzY/tMSL9wP6ISaMGTx6xmt4QfyXs8NiNGfaTXMwS3p/g0cp8D7GpYZ
	 yzYGkWZk8QmSxONArutUrHlOxss9bzceqnnHeFw6hvcD4xAEInDbYLFuk9LJX8PXzr
	 BVxWrl+mxY9IB5yQZLSBf9g8fEYO1bsSO3YaLKLtdlyHe6GJl4xnIgsl4O/uP7wAnR
	 dhFe+sr+DSRTw==
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
In-Reply-To: <Z7yl-LsSkVIDAfMF@Mac.home> (Boqun Feng's message of "Mon, 24 Feb
	2025 09:01:44 -0800")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<874j0j1nv2.fsf@kernel.org> <Z7yUTNEg6gMW0G7b@Mac.home>
	<CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
	<Z7ye0MsACNWe7Mbr@Mac.home>
	<CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
	<WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
	<Z7yl-LsSkVIDAfMF@Mac.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 19:58:04 +0100
Message-ID: <87msebyxtv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
>> On Mon, Feb 24, 2025 at 5:31=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>> >
>> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
>> > >
>> > > side -- Andreas and I discussed it the other day. The description of
>> > > the issue has some lines, but perhaps the commit message could
>> >
>> > Do you have a link to the issue?
>>
>> Sorry, I meant "description of the symbol", i.e. the description field
>> in the patch.
>>
>
> Oh, I see. Yes, the patch description should provide more information
> about what the kconfig means for hrtimer maintainers' development.

Right, I neglected to update the commit message. I will do that if we
have another version.

>
>> > I asked because hrtimer API is always available regardless of the
>> > configuration, and it's such a core API, so it should always be there
>> > (Rust or C).
>>
>> It may not make sense for something that is always built on the C
>> side, yeah. I think the intention here may be that one can easily
>> disable it while "developing" a change on the C side. I am not sure
>> what "developing" means here, though, and we need to be careful --
>> after all, Kconfig options are visible to users and they do not care
>> about that.
>>
>
> Personally, I don't think CONFIG_RUST_HRTIMER is necessarily because as
> you mentioned below, people can disable Rust entirely during
> "developing".
>
> And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
> config provides hrtimer maintainers a way that they could disable Rust
> hrtimer abstraction (while enabling other Rust component) when they're
> developing a change on the C side, right? If so, it's hrtimer
> maintainers' call, and this patch should provide more information on
> this.
>
> Back to my personal opinion, I don't think this is necessary ;-)
> Particularly because I can fix if something breaks Rust side, and I'm
> confident and happy to do so for hrtimer ;-)

As Miguel said, the idea for this came up in the past week in one of the
mega threads discussing rust in general. We had a lot of "what happens
if I change something in my subsystem and that breaks rust" kind of
discussions.

For subsystems where the people maintaining the C subsystem is not the
same people maintaining the Rust abstractions, this switch might be
valuable. It would allow making breaking changes to the C code of a
subsystem without refactoring the Rust code in the same sitting. Rather
than having to disable rust entirely - or going and commenting out lines
in the kernel crate - I think it is better to provide an option to just
disable building these particular bindings.

This has nothing to do with general policies related to breakage between
Rust and C code, and how to fix such breakage in a timely manner. It is
simply a useful switch for disabling part of the build so that people
can move on with their business, while someone else scrambles to fix
whatever needs fixing on the Rust side.

I am of course also available to fix anything that would eventually
break. In fact, I expect to be able to catch breakage most of the time
automatically and very early by means of automatically monitoring the
relevant trees. I do this for block, and it has worked really well since
rust code was merged in that subsystem.


Best regards,
Andreas Hindborg






