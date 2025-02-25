Return-Path: <linux-kernel+bounces-530822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E3AA438F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7935E1887B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F72641D4;
	Tue, 25 Feb 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f07vn4vY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9A263C7C;
	Tue, 25 Feb 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474309; cv=none; b=c7oJL+pFI7f7XQomHXYJ+Z5qFbGhNvZWOJ+6s1da190NAFyXGM8xEvv5UdwtRHNyj9foIrDjUHxVM/alZpx6Dq81ywCR1wDZHusrqAgbco9DBcE4/KLM7zXzwwAZDgPwBiTcm2BHHnuUFb9pZ4rEBPvW/gx1wUaz0mtUjXjv/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474309; c=relaxed/simple;
	bh=NyHEQgvLE7O2czGyw9kOf6jBpywmIwe7uLlUw5iQ80o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJU6fBRHEibQ27SuXyeNpVsc62rmdh23zopNXguOj85gvdPZtwXS9/ZJuZCK5LKoTLD6xYTc0EDrOtVQgDpoO7qpdtzaryHgxsEg0wtG2zaE1ee3g+mfrkcQ8bxKx2PINlQZrB3HMVCh3DCbjGcZYDtnpfNTQg/rAwJS507A9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f07vn4vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B8CC4CEE2;
	Tue, 25 Feb 2025 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474309;
	bh=NyHEQgvLE7O2czGyw9kOf6jBpywmIwe7uLlUw5iQ80o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f07vn4vYD8d7AzBvbbenYgA/Cadt0cKhjZQ6uzelHZppMYtXwMDS7HGng6nwZJvQu
	 USHF09zJQfF8KllYEkRpoQNbhPMUkLGtuLFB2TEaVKnUx4SUIbjC6BZxH4RJC2lK7L
	 FlmNgjHcgPcayoz+vys4FRG6sQqTZtoktCYKglW/OLtcEu2DfTg0Hcir0WOF4r3MBF
	 e+0OgUKYSRT4lvvBmfscJLGzdjsEvKuSCBsH3FkSg/DVW96wGYwRLHQP1tPjWB4Sir
	 XJeZ50r+f7kESgiXQw9pfkfaFcKehKUXxVJFg8OhA71nuAzi64z1H/jYqjvl8r0wcZ
	 VF3sOVk4kaymg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 07/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&T>`
In-Reply-To: <832fbd60f5c3d78955bd77fce8539423d7669a39.camel@redhat.com>
	(Lyude Paul's message of "Mon, 24 Feb 2025 18:32:11 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-7-5bd3bf0ce6cc@kernel.org>
	<YFJT5Me9IKOD3qR_oRWAcCpIdCw26VdTrqopzgm67j4y9hJzdvN3aljtIlJkO6fQV4FI-mnA2_SpjNVa6Fj3uA==@protonmail.internalid>
	<832fbd60f5c3d78955bd77fce8539423d7669a39.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 10:01:37 +0100
Message-ID: <871pvmxury.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Mon, 2025-02-24 at 13:03 +0100, Andreas Hindborg wrote:
>> Allow pinned references to structs that contain a `HrTimer` node to be
>> scheduled with the `hrtimer` subsystem.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs     |  2 +
>>  rust/kernel/time/hrtimer/pin.rs | 99 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 101 insertions(+)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index 64b769ad59cc..52a3dd1c3984 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -428,3 +428,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
>>
>>  mod arc;
>>  pub use arc::ArcHrTimerHandle;
>> +mod pin;
>> +pub use pin::PinHrTimerHandle;
>> diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
>> new file mode 100644
>> index 000000000000..6c9f2190f8e1
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/pin.rs
>> @@ -0,0 +1,99 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasHrTimer;
>> +use super::HrTimer;
>> +use super::HrTimerCallback;
>> +use super::HrTimerHandle;
>> +use super::RawHrTimerCallback;
>> +use super::UnsafeHrTimerPointer;
>> +use crate::time::Ktime;
>> +use core::pin::Pin;
>> +
>> +/// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
>> +/// running.
>> +pub struct PinHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: Pin<&'a T>,
>> +}
>
> Any reason this isn't just:
>
> pub struct PinHrTimerHandle<'a, T: HasHrTimer<T>>(Pin<&'a T>)
> where
>      T: HasHrTimer<T>;
>
> With that nit (feel free to take it or leave it) resolved:

I had review comments in the past asking me to not use tuple structs.
The rationale being that the name carries context/intent. In this
particular case, I don't think the name helps a lot, but I also don't
mind having it there.

>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks you!


Best regards,
Andreas Hindborg



