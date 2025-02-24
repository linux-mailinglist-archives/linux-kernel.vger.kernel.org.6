Return-Path: <linux-kernel+bounces-529969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2621A42D16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD03A9326
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43E2054FD;
	Mon, 24 Feb 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGAf9T9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923492571B6;
	Mon, 24 Feb 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426766; cv=none; b=bUUqmdsFum1cS0gQA8k3tOziXRCq8wI52Gw1bQFVj9W5uPiVbgIisRJXXUf+HOmD4An2emLd9SCZzOCRngAfLsk53JXQo6xsYtWJJxu7cVFVWfFrWtIJ2TeXvXSPOhEiYZOMchILITFmdWjkFrxPRcpbxlR+7NLo8ShJOazzCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426766; c=relaxed/simple;
	bh=ESaC73OJFkk3emPXACNhcE07hs+BVKCVvXKDChGH58o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHqepgKVLKshR+9H4yCSY1gHWOf2z/z6ntivprkhwuCVKLHKemk/xu/qiipgoovz7BQqPXFQKlTBm6kn5lXLVfUjQ6Y1F/kj5K/fA3TGsWS3tJTxKdrrfitFsFA82D42fYja3Uc95SO0hta94cqeU8FxuZk2/jpA9QWU4Sg9blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGAf9T9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F725C4CEE7;
	Mon, 24 Feb 2025 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426766;
	bh=ESaC73OJFkk3emPXACNhcE07hs+BVKCVvXKDChGH58o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OGAf9T9pHc1dJy+mMMbdQQCj+s4KjN8bUS4dB5Gfj1Ah1rsVeRKrexkY7bumFs62V
	 Fm7Hq6ywpZqY1+OqhyHsiW8QzFhTgNbyVgAmkNOqMpPPA4Dsnk3Y0lSXZFP6QwXimH
	 O9R8WNVVeAWOG1KEtYnvsQeOn3YV9ch5lJPNMO/0n7Iexc/5Gu8yFviDKXocIxqFGj
	 esmAvJ5xLYTvFMSbfqUQsuWpz2g7UeP1Q8cK2TKNtHC2HQVjxRUhhOFEHq0u84jbB+
	 f7rBWsYcB+tilv0xf4p8HcpuWIh0H5f+Ht4dTK/QmDQ4AQLGvVQbcL855vAO/O+4VL
	 dq5DABAnXoTxQ==
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
In-Reply-To: <Z7zF8KF9qTCr_n4l@boqun-archlinux> (Boqun Feng's message of "Mon,
	24 Feb 2025 11:18:08 -0800")
References: <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<874j0j1nv2.fsf@kernel.org> <Z7yUTNEg6gMW0G7b@Mac.home>
	<CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
	<Z7ye0MsACNWe7Mbr@Mac.home>
	<CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
	<WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
	<Z7yl-LsSkVIDAfMF@Mac.home> <87msebyxtv.fsf@kernel.org>
	<4UoaifxB7JgBVKsNQyFR_T8yc3Vtn5TLAEdxdXrojNmOzJSEncopauEyjDpnbqzr8Z74ZWjd_N-bB-BwBS-7aQ==@protonmail.internalid>
	<Z7zF8KF9qTCr_n4l@boqun-archlinux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 20:52:35 +0100
Message-ID: <87bjuryvb0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Mon, Feb 24, 2025 at 07:58:04PM +0100, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>>
>> > On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
>> >> On Mon, Feb 24, 2025 at 5:31=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
>> >> >
>> >> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
>> >> > >
>> >> > > side -- Andreas and I discussed it the other day. The description=
 of
>> >> > > the issue has some lines, but perhaps the commit message could
>> >> >
>> >> > Do you have a link to the issue?
>> >>
>> >> Sorry, I meant "description of the symbol", i.e. the description field
>> >> in the patch.
>> >>
>> >
>> > Oh, I see. Yes, the patch description should provide more information
>> > about what the kconfig means for hrtimer maintainers' development.
>>
>> Right, I neglected to update the commit message. I will do that if we
>> have another version.
>>
>> >
>> >> > I asked because hrtimer API is always available regardless of the
>> >> > configuration, and it's such a core API, so it should always be the=
re
>> >> > (Rust or C).
>> >>
>> >> It may not make sense for something that is always built on the C
>> >> side, yeah. I think the intention here may be that one can easily
>> >> disable it while "developing" a change on the C side. I am not sure
>> >> what "developing" means here, though, and we need to be careful --
>> >> after all, Kconfig options are visible to users and they do not care
>> >> about that.
>> >>
>> >
>> > Personally, I don't think CONFIG_RUST_HRTIMER is necessarily because as
>> > you mentioned below, people can disable Rust entirely during
>> > "developing".
>> >
>> > And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
>> > config provides hrtimer maintainers a way that they could disable Rust
>> > hrtimer abstraction (while enabling other Rust component) when they're
>> > developing a change on the C side, right? If so, it's hrtimer
>> > maintainers' call, and this patch should provide more information on
>> > this.
>> >
>> > Back to my personal opinion, I don't think this is necessary ;-)
>> > Particularly because I can fix if something breaks Rust side, and I'm
>> > confident and happy to do so for hrtimer ;-)
>>
>> As Miguel said, the idea for this came up in the past week in one of the
>> mega threads discussing rust in general. We had a lot of "what happens
>> if I change something in my subsystem and that breaks rust" kind of
>> discussions.
>>
>
> So far we haven't heard such a question from hrtimer maintainers, I
> would only add such a kconfig if explicitly requested.

It gives flexibility and has no negative side effects. Of course, if it
is unwanted, we can just remove it. But I would like to understand the
deeper rationale.


>
>> For subsystems where the people maintaining the C subsystem is not the
>> same people maintaining the Rust abstractions, this switch might be
>> valuable. It would allow making breaking changes to the C code of a
>> subsystem without refactoring the Rust code in the same sitting. Rather
>
> That's why I asked Frederic to be a reviewer of Rust hrtimer API. In
> longer-term, more and more people will get more or less Rust knowledge,
> and I'd argue that's the direction we should head to. So my vision is a
> significant amount of core kernel developers would be able to make C and
> Rust changes at the same time. It's of course not mandatory, but it's
> better collaboration.

Having this switch does not prevent longer term plans or change
directions of anything. It's simply a convenience feature made
available. I also expect the future you envision. But it is an
envisioned _future_. It is not the present reality.

>
>> than having to disable rust entirely - or going and commenting out lines
>> in the kernel crate - I think it is better to provide an option to just
>> disable building these particular bindings.
>>
>> This has nothing to do with general policies related to breakage between
>> Rust and C code, and how to fix such breakage in a timely manner. It is
>> simply a useful switch for disabling part of the build so that people
>> can move on with their business, while someone else scrambles to fix
>> whatever needs fixing on the Rust side.
>>
>
> It's of course up to hrtimer maintainers. But I personally nack this
> kconfig, because it's not necessary, and hrtimer API has been stable for
> a while.

Having the switch is fine for me, removing it is fine as well. It's just
an added convenience that might come in handy. But having this kconfig
very close to zero overhead, so I do not really understand your
objection. I would like to better understand your reasoning.


Best regards,
Andreas Hindborg



