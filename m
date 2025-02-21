Return-Path: <linux-kernel+bounces-525832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A685FA3F600
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC05D189C94F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379920FA93;
	Fri, 21 Feb 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc8QROx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0020E319;
	Fri, 21 Feb 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144551; cv=none; b=AEc4qyCDNZbtaHYBuTMgkofLI7hhoMoLx0hOCU7p1LYkzEvnmqHUJrolp0wy1DQIYaHN7Y0laLV9D9Qe/maZwHDwKFF3VjWeFMyy5s55WgZGxXeUyH//qBte/sGDBHjHb905RV/tHP09DKTq+M17IzCPBef1FmmBcsPvtV0+BGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144551; c=relaxed/simple;
	bh=nxSpFXWj1K8bHTtDOvknUrF/otwEmVm0exiS2Owmm6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqcPSVmaIhA9KcEvtm48KJoUpSkM7WMCT98jHJvHPC99+IKhORtypoGCFuyxvFI/XzUcFHI36Sju+GJfRab3NK1Hv5yznfwT2YGERz4YetFb9tDDlYajGgR5rfibKg28h3bVfoSz1HXIoUgLsC8YDQ8WG5vGphmxAnH8fBOrgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc8QROx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B4C4CED6;
	Fri, 21 Feb 2025 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740144550;
	bh=nxSpFXWj1K8bHTtDOvknUrF/otwEmVm0exiS2Owmm6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Qc8QROx4pPhLuR6Z4UQenN2J0Jou6PpCN2kEtOYqKrPY3tCOTqQnxeM8uGtNXPd4w
	 T3Q3duZ/s+0J4HFWk+gIRXhhmRC5vdHENLw6H+2QkGlIfsm92X3HuUAHvw+eyCan6C
	 kpDwO0VEFEcDnCb8l5OJtmgIT3D9iO8q0Fps2RYrO9mNGYbUlxdWMV/YBQOuUjnIgz
	 CmNFPtS5W747Hk05KuK4Sr4xaiAdY0jxFfN3wph6yQRcNz3yFIkIXAB6G6DTrQhoUK
	 d6uQjWH9ZgVgscVw4o9KzTMUZ0fjZVHHQvSNL2QGcGWaaGylWWiAmlu07AGAqTQOxy
	 lxn0mcJNxPC9w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87ldtzhexi.fsf@kernel.org> (Andreas Hindborg's message of "Fri,
	21 Feb 2025 09:36:57 +0100")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
	<87wmdkgvr0.fsf@kernel.org>
	<djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
	<CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
	<87ldtzhexi.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 14:28:58 +0100
Message-ID: <87cyfbe89x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Tamir Duberstein" <tamird@gmail.com> writes:
>
>> On Thu, Feb 20, 2025 at 4:19=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>>
>>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>>
>>> > On Tue, Feb 18, 2025 at 8:29=E2=80=AFAM Andreas Hindborg <a.hindborg@=
kernel.org> wrote:

[...]

>>> >> +    /// Get a pointer to the contained `bindings::hrtimer`.
>>> >> +    ///
>>> >> +    /// # Safety
>>> >> +    ///
>>> >> +    /// `ptr` must point to a live allocation of at least the size =
of `Self`.
>>> >> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>>> >> +        // SAFETY: The field projection to `timer` does not go out =
of bounds,
>>> >> +        // because the caller of this function promises that `ptr` =
points to an
>>> >> +        // allocation of at least the size of `Self`.
>>> >> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer))=
 }
>>> >> +    }
>>> >
>>> > Can you help me understand why the various functions here operate on
>>> > *const Self? I understand the need to obtain a C pointer to interact
>>> > with bindings, but I don't understand why we're dealing in raw
>>> > pointers to the abstraction rather than references.
>>>
>>> We cannot reference the `bindings::hrtimer` without wrapping it in
>>> `Opaque`. This would be the primary reason. At other times, we cannot
>>> produce references because we might not be able to prove that we satisfy
>>> the safety requirements for turning a pointer into a reference. If we
>>> are just doing offset arithmetic anyway, we don't need a reference.
>>
>> Why do we have a pointer, rather than a reference, to Self in the
>> first place? I think this is the key thing I don't understand.
>
> Perhaps it makes more sense if you look at the context. One of the entry
> points to `HrTimer::raw_get` is via `<ArcHrTimerHandle as
> HrTimerHandle>::cancel`. This user facing method takes `&mut self`. The
> handle contains an arc to a type that contains a `Timer` and implements
> `HasHrTImer`. To get to the timer, we need to do pointer manipulation.
> We only know how to get the `Timer` field via the `OFFSET`. The natural
> return value from the offset operation is a raw pointer. Rather than
> convert back to a reference, we stay in pointer land when we call
> `HrTimer::raw_cancel`, because we need a pointer to the
> `bindings::hrtimer` anyway, not a reference.

I changed `HasHrTimer::start` to take a reference, and I think that
makes sense =F0=9F=91=8D Taking an `impl AsRef` does not work out when `Sel=
f` is
`Pin<&T>`. I'll go over the whole thing and see of other places could
benefit.

Best regards,
Andreas Hindborg



