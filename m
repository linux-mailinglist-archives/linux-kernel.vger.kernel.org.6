Return-Path: <linux-kernel+bounces-566926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924BA67E67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189167AB879
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD52139B5;
	Tue, 18 Mar 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHWT0pV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98A1EB5DB;
	Tue, 18 Mar 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331487; cv=none; b=eNE+Cc4Qz4Ec8WK9daCeLt6dlsXQScFCSv8Gm9SBgB9+t3zPaVlntaWhPsgEdjTLqQpwHgqhzkjmVDnXuOnVXtcx2kUT1F0d4y4VL+GBIYAF1tPB3NpCB1ACASxo8Vrr3C+K62lFT0IKHCVjhCZSppZkNSpGrBkYr3xvgcb40d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331487; c=relaxed/simple;
	bh=ORRl4Dl4BSdzJ8z4aLQ+6a+8EPxPXXkMtuRU3T9FXoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CstCS6G3Viq1UBE+3SM64NQZ34muozLaMuylQoqwPA6j8tFcQqHTR6Iwpp5E2BoRYmZOf4EWEhWvXuQrXV6iqiYqoUla/fDFeLVnG5BSOvMbgu8Gj5i+iVvh754QFhiBpFBq/DI7FDpIe7LM+FtllHgskrBh9MFE6exTqQmG/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHWT0pV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3555C4CEDD;
	Tue, 18 Mar 2025 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742331487;
	bh=ORRl4Dl4BSdzJ8z4aLQ+6a+8EPxPXXkMtuRU3T9FXoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FHWT0pV1hxbhwQSVgiqIrL2yA/fcDULD3ato3WE0QPD5C33P7E6wws0Iq9gbWSToh
	 JywAUv+3WK1CKX1u/Fe0AVUMr3IGuKt0adRb/e/LbmCMLaSJkf49R/3LAZvJU0/y7o
	 5s6VlLM+U4yE3iHcLxtVdgQqJqlpIJgZHVS1yBc1ZDn1/6BNejsnYEdIIr3jI4hHU9
	 ZowG3jRsd+Vud3ahdKSfCAzddPiae37J8WK8MpXCC5bGyqgDwNlx7FbX3OOkE0YmLa
	 cgehDGtiOQHIEZNol72UZ9Vm9w7IEBmcQBF04KRINcyuTnh6HpUEIXLq1Vj0RPOzvV
	 EVPD1Tz0pb3xQ==
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
In-Reply-To: <2025031140-saffron-kilobyte-bd2e@gregkh> (Greg Kroah-Hartman's
	message of "Tue, 11 Mar 2025 15:37:56 +0100")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<9pOFLtAJ1ScEHfLe7L2KqghIKBzL8sTupJttIVRB70ZmvdUpiEYrxCxIpJD_cBJVwv-TKxosDL-l6cq3qt563Q==@protonmail.internalid>
	<2025031140-saffron-kilobyte-bd2e@gregkh>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 21:57:55 +0100
Message-ID: <878qp2hx9o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:

> On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
>> This series adds support for the `struct iov_iter` type. This type
>> represents an IO buffer for reading or writing, and can be configured
>> for either direction of communication.
>>
>> In Rust, we define separate types for reading and writing. This will
>> ensure that you cannot mix them up and e.g. call copy_from_iter in a
>> read_iter syscall.
>>
>> To use the new abstractions, miscdevices are given new methods read_iter
>> and write_iter that can be used to implement the read/write syscalls on
>> a miscdevice. The miscdevice sample is updated to provide read/write
>> operations.
>
> Nice, this is good to have, but what's the odds of tieing in the
> "untrusted buffer" logic here so that all misc drivers HAVE to properly
> validate the data sent to them before they can touch it:
> 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
>
> I'd like to force drivers to do this, otherwise it's just going to force
> us to audit all paths from userspace->kernel that happen.
>

I think that for user backed iterators (`user_backed_iter(iter) != 0`)
we will have the same problems as discussed in [1]. To validate, we
would have to copy the data to another buffer and then validate it
there, in a race free place. But the copying is apparently a problem.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/ab8fd525-9a63-46e2-a443-b9d94eed6004@ralfj.de/


