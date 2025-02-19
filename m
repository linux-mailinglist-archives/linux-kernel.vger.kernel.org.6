Return-Path: <linux-kernel+bounces-521134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A92A3B4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DAC3B6F53
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB781EA7EB;
	Wed, 19 Feb 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbUXL5i8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848901EB184;
	Wed, 19 Feb 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954291; cv=none; b=dUgkR+fu29MAjjfYAeXFHBwT5W7qf7iygXrRo+x+sE1z57Z0FkX47BIHkCo7LdIrLO+yv7l1x+BeZVqL0j+qS8D4DFavLtHhX290ecfplZFAWFhaTQLyaqU1P1mUsgW43a5gy7dPfL8xVDyHIedf2ANq49E94bK7shK6hShA9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954291; c=relaxed/simple;
	bh=T2SBPUWU4o/SY8lo2Y5pA5+O8iQ5YR23jNTvXLpfg0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewpDEn5hg03aZLC2b33rAf6njeO8YRCOFoU/8e0nxLAHb7tGTiqpUKAcEuuLl9MPVZCxbItQSIHQ03YhObB8vMyokCWkO9Nm7SVYga4Vu4TrJP+5TXvMnwpBonWVpX1sdu8RG0DqUe2uCe709bVKT1KCzIXZXzUNd5M+otBoObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbUXL5i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE2C4CED1;
	Wed, 19 Feb 2025 08:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739954291;
	bh=T2SBPUWU4o/SY8lo2Y5pA5+O8iQ5YR23jNTvXLpfg0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qbUXL5i83JlMGiSf0xuUuxX4szW1wRCnJvB6H1elLLBnc0kTKxRvS341YhOjtb6KB
	 xC9li10LcSMbfx0OtNl4XwJ9UjYMh0sMXoBit/MvGdveWIvc2TQWu3mDzkKVcaVmS0
	 ejw05U9O2uFGe6u11N3o7R6ADUZrJ9xKhHLS78Ztj/J0NOyuJrbIdBKB4yQsv+p2hN
	 uJZCEs2zi7y5WFLNKCu7QRz3tF02JeYZkA/tuQJ+rfyn0PVEQVXtZZuyjqX+q4Bh0F
	 Dx1renbf1P4BKCgcIu4hAczAK44TSFlq185ibGMFs5A5CV5PlZfm9O2IO0Qw5Nb+HJ
	 0KgRWcHZkhNIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 1/6] rust: types: Add Ownable/Owned types
In-Reply-To: <585deb4e-3d05-488b-80dd-df64a6983d85@asahilina.net> (Asahi
	Lina's message of "Tue, 04 Feb 2025 04:17:38 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net>
	<CAH5fLggscATtCgQwCYSms77oSFOMkjTscRDqAOZsSgoHsOoPQw@mail.gmail.com>
	<def0ac4e-6ec3-4f91-a3e6-02ce931c46f3@asahilina.net>
	<CAH5fLggcT0_e3EsBppxsGfxaqvs6rTkbbRvrFEHthEff5s1x0g@mail.gmail.com>
	<epYXIaMPQfDvHAMtHHM30t7ZTjCOuiBgyZgD8hdHQD2VcWM0LTxvSL9p-VJCQK7B8vG6uEww-U-ESTuHHyEhzA==@protonmail.internalid>
	<585deb4e-3d05-488b-80dd-df64a6983d85@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:34:54 +0100
Message-ID: <87mseie3ip.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Asahi Lina" <lina@asahilina.net> writes:

> On 2/4/25 3:17 AM, Alice Ryhl wrote:
>> On Mon, Feb 3, 2025 at 3:17=E2=80=AFPM Asahi Lina <lina@asahilina.net> w=
rote:
>>>
>>>
>>>
>>> On 2/3/25 6:13 PM, Alice Ryhl wrote:
>>>> On Sun, Feb 2, 2025 at 2:06=E2=80=AFPM Asahi Lina <lina@asahilina.net>=
 wrote:
>>>>> +    /// Consumes the `Owned`, returning a raw pointer.
>>>>> +    ///
>>>>> +    /// This function does not actually relinquish ownership of the =
object.
>>>>> +    /// After calling this function, the caller is responsible for o=
wnership previously managed
>>>>> +    /// by the `Owned`.
>>>>> +    #[allow(dead_code)]
>>>>> +    pub(crate) fn into_raw(me: Self) -> NonNull<T> {
>>>>
>>>> I would just make these methods public, like the ARef ones. Then you
>>>> can drop the #[allow(dead_code)] annotation.
>>>
>>> Does it make sense to ever have drivers doing this? I feel like these
>>> methods should be limited to the kernel crate.
>>
>> Not having drivers use this is the ideal, but I don't think we should
>> always expect it to be possible. The Binder driver has a C component
>> for the binderfs component, and it also has some code that's
>> essentially an abstraction inside the driver that I was asked to move
>> into Binder because it's so specific to Binder that it's not useful
>> for anyone else.
>
> That's fair, I'll make it pub.

Also, the kernel crate will split at some point. We might as well have
them public now and avoid the churn.


Best regards,
Andreas Hindborg




