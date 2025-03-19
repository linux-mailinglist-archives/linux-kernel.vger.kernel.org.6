Return-Path: <linux-kernel+bounces-568585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4AA69807
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD12189C74D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467B20B1E6;
	Wed, 19 Mar 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrhSdHZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93B1E5B63;
	Wed, 19 Mar 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408690; cv=none; b=baizFbuCakORbeBk1oIUjMSeBkiR9czYF0kJjoKcDZGodRxxTW47cT1+MALnVbRME4BcKoLnzOX3cN2pwTxvb4nXfegk1XyKT1wXQqDpphq6SrV/MvMMWL9LB/EztyX5ZvbuLyRsgzrEAvkbUez1aTl6VUK130M1QowOgjpFL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408690; c=relaxed/simple;
	bh=F3sdvUpiNzFI/SiTaFtPM6nmUNKR5jQhkoPu3GTYdM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAWSN9mcvH+noU5BqLBLl5t2Jf0IBiTG3QeNIRvVDBvn/K3PcPKZeulvvjS9VzRul0ygRAGQ4CIMXOtSy6Nag1URc7BDdTpnfiKQaGHMbjX0YHUtQBIgi00vyD7ZPpNTYBXunZz2XJ4wmu6UczeJPAu4j65gpkv1t4bOr8LBGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrhSdHZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9984BC4CEE4;
	Wed, 19 Mar 2025 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742408690;
	bh=F3sdvUpiNzFI/SiTaFtPM6nmUNKR5jQhkoPu3GTYdM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QrhSdHZ1OXBw8Jv/B04fkEwMJLZeoDhw3JoMXgIIItZazP70t74LKQHmigMV7o00N
	 UthJWQBK5av6Nsp9skmt5NOdgT9nGVohNF3ZAU9rp8gr5rDOpm2UH5YDasKaA0+y9j
	 OsqSm6i4re6WsUXww+ggMY04HgT3RbmpesAMp3/3vHJ968UYaTOW6Ue6nlKcyc3V8W
	 XVY1gJEA7XIes60Bcaz3y4E+u2QIytiXiZxBbYYgAdd1lmODmCa4xGz4UDFEngbni0
	 1RMB1wurruz5z21VNxM6uak/p3Ip/x+E3mzXEi+WQhC4U1TCIb0elPQGGSN4Ws6/Ow
	 RMivSySkvQxEA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
In-Reply-To: <2025031928-connected-confider-dda5@gregkh> (Greg Kroah-Hartman's
	message of "Wed, 19 Mar 2025 04:42:34 -0700")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<9pOFLtAJ1ScEHfLe7L2KqghIKBzL8sTupJttIVRB70ZmvdUpiEYrxCxIpJD_cBJVwv-TKxosDL-l6cq3qt563Q==@protonmail.internalid>
	<2025031140-saffron-kilobyte-bd2e@gregkh> <878qp2hx9o.fsf@kernel.org>
	<_faLZHT6mnujSjNGxKLz9hgfs7W4w_MLWjiFHHYughpAFkITeHHgVAqHUhc3-FvYC_rdOjygOzVQC3zXSDTEqg==@protonmail.internalid>
	<2025031804-eardrum-surplus-5ff9@gregkh> <87wmclgttg.fsf@kernel.org>
	<oh-co9UVC3VqmBa5gLwEBOLDlqJKfYVhRzy_0obFzjfVgs0q6Zw8TGa8EQcWa5R9G7E5OwEFSGMO_mfroI0GDg==@protonmail.internalid>
	<2025031928-connected-confider-dda5@gregkh>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 19:24:41 +0100
Message-ID: <87cyecho9i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:

> On Wed, Mar 19, 2025 at 12:10:03PM +0100, Andreas Hindborg wrote:
>> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
>>
>> > On Tue, Mar 18, 2025 at 09:57:55PM +0100, Andreas Hindborg wrote:
>> >> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
>> >>
>> >> > On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
>> >> >> This series adds support for the `struct iov_iter` type. This type
>> >> >> represents an IO buffer for reading or writing, and can be configured
>> >> >> for either direction of communication.
>> >> >>
>> >> >> In Rust, we define separate types for reading and writing. This will
>> >> >> ensure that you cannot mix them up and e.g. call copy_from_iter in a
>> >> >> read_iter syscall.
>> >> >>
>> >> >> To use the new abstractions, miscdevices are given new methods read_iter
>> >> >> and write_iter that can be used to implement the read/write syscalls on
>> >> >> a miscdevice. The miscdevice sample is updated to provide read/write
>> >> >> operations.
>> >> >
>> >> > Nice, this is good to have, but what's the odds of tieing in the
>> >> > "untrusted buffer" logic here so that all misc drivers HAVE to properly
>> >> > validate the data sent to them before they can touch it:
>> >> > 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
>> >> >
>> >> > I'd like to force drivers to do this, otherwise it's just going to force
>> >> > us to audit all paths from userspace->kernel that happen.
>> >> >
>> >>
>> >> I think that for user backed iterators (`user_backed_iter(iter) != 0`)
>> >> we will have the same problems as discussed in [1]. To validate, we
>> >> would have to copy the data to another buffer and then validate it
>> >> there, in a race free place. But the copying is apparently a problem.
>> >
>> > We already copy all data first, that's not an issue.  Validate it after
>> > it has been copied before you do something with it, just like we do
>> > today for normal ioctl C code.  Same goes for data coming from hardware,
>> > it's already been copied into a buffer that you can use, no need to copy
>> > it again, just "validate" it before using it.
>>
>> I guess that depends on the user of the `iov_iter`? At least when it is
>> used for direct IO, the operation is zero copy with pages mapped into
>> kernel and IO performed directly from those pages.
>
> Great, and then, before you actually do something with that data, you
> have to validate it that it is correct, right?  If this is just a
> "pass-through" then no need to do anything to it.  But if you have to
> inspect/act-on-it, then just inspect it in the verifier portion.
>
> I'm not trying to add any additional overhead here, as you normally
> would have to verify the data is correct before doing something with it,
> but rather just forcing that validation to be done in an obvious place
> where everyone can see that it is being done, or not being done.
>
> In other words, make it obvious to reviewers that this is happening,
> instead of forcing them to dig through code paths to hopefully find out
> where it happens.

I would agree.

Just to be clear, I am not objecting to validating data before
interpreting, that is the only sane thing to do. I'm just raising a
concern in relation to reading pages mapped from user space in Rust.
Because apparently it is undefined behavior, as discussed in the thread
I linked.


Best regards,
Andreas Hindborg



