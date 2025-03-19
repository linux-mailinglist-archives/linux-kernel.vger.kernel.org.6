Return-Path: <linux-kernel+bounces-567855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EFA68B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7301164A40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCEB258CFB;
	Wed, 19 Mar 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sksC1cM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C4255235;
	Wed, 19 Mar 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382617; cv=none; b=iUiQ4+TdzuR6nM0CQKgBovGPHWzD9F9ITEeHOcomrgO2q7VC6ir2F0PuUn/ZFd6GG/wETSMFmL0h14H9fO/R9hyjDHLULoY3LHjo28/2+r/e4JV587ibwQPmoRLKXEYsyv21vSTqr8RKcDFfLdciX0a+KAP475a7V8/8wAHJUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382617; c=relaxed/simple;
	bh=CAoeZD1MgopoFeqxnSsaxsGHyeVVfnpt0CDKMF2W17k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oUwgD4JEj4UmE+RCUkhjbEY3dB+zI74VSRBu7lFjFcFSCSiJOIAjEkvxoWKKr6OlxdnKjuN8IOxSa1OZ4cbeKY5ZQToKlw9hvTTsv5o8gf+Q9pxhd5tMBgswTf2b6HzswizhCGFP/ahm1ixiat/sIY65I+DjHujWRTaDKpvlTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sksC1cM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A5C4CEEA;
	Wed, 19 Mar 2025 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742382614;
	bh=CAoeZD1MgopoFeqxnSsaxsGHyeVVfnpt0CDKMF2W17k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sksC1cM4ZWiL59p/FC5z+rufru5cjhEILZWNflhdY4SH+de0znts4kuSnPStVnLOi
	 Z216OYMZthBiyOJESdHneOtPnYuKH2TCppoXkYBVJezoniSFInqXh0vSPdlznXpXd3
	 XPBVrmXDEWngwfnqbgMRX9rSLrascyeUsmriH0ibJPUjqqY4KTznQOIaZ6vgfn7DaW
	 lKdO6+ysSMEr2fvc6w1VH3HwiYz9ZuJu8VTVtB9ymayxOumbM74GJB0gAFnSlsH9C9
	 z6JSkyilwDWmtHpYK81p3mzjb3HQSawPQCRNOkKo6ARr/P0TCAfg8FeKtrvrNtebLh
	 vBECD7F467X8g==
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
In-Reply-To: <2025031804-eardrum-surplus-5ff9@gregkh> (Greg Kroah-Hartman's
	message of "Tue, 18 Mar 2025 16:34:21 -0700")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<9pOFLtAJ1ScEHfLe7L2KqghIKBzL8sTupJttIVRB70ZmvdUpiEYrxCxIpJD_cBJVwv-TKxosDL-l6cq3qt563Q==@protonmail.internalid>
	<2025031140-saffron-kilobyte-bd2e@gregkh> <878qp2hx9o.fsf@kernel.org>
	<_faLZHT6mnujSjNGxKLz9hgfs7W4w_MLWjiFHHYughpAFkITeHHgVAqHUhc3-FvYC_rdOjygOzVQC3zXSDTEqg==@protonmail.internalid>
	<2025031804-eardrum-surplus-5ff9@gregkh>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 12:10:03 +0100
Message-ID: <87wmclgttg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:

> On Tue, Mar 18, 2025 at 09:57:55PM +0100, Andreas Hindborg wrote:
>> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
>>
>> > On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
>> >> This series adds support for the `struct iov_iter` type. This type
>> >> represents an IO buffer for reading or writing, and can be configured
>> >> for either direction of communication.
>> >>
>> >> In Rust, we define separate types for reading and writing. This will
>> >> ensure that you cannot mix them up and e.g. call copy_from_iter in a
>> >> read_iter syscall.
>> >>
>> >> To use the new abstractions, miscdevices are given new methods read_iter
>> >> and write_iter that can be used to implement the read/write syscalls on
>> >> a miscdevice. The miscdevice sample is updated to provide read/write
>> >> operations.
>> >
>> > Nice, this is good to have, but what's the odds of tieing in the
>> > "untrusted buffer" logic here so that all misc drivers HAVE to properly
>> > validate the data sent to them before they can touch it:
>> > 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
>> >
>> > I'd like to force drivers to do this, otherwise it's just going to force
>> > us to audit all paths from userspace->kernel that happen.
>> >
>>
>> I think that for user backed iterators (`user_backed_iter(iter) != 0`)
>> we will have the same problems as discussed in [1]. To validate, we
>> would have to copy the data to another buffer and then validate it
>> there, in a race free place. But the copying is apparently a problem.
>
> We already copy all data first, that's not an issue.  Validate it after
> it has been copied before you do something with it, just like we do
> today for normal ioctl C code.  Same goes for data coming from hardware,
> it's already been copied into a buffer that you can use, no need to copy
> it again, just "validate" it before using it.

I guess that depends on the user of the `iov_iter`? At least when it is
used for direct IO, the operation is zero copy with pages mapped into
kernel and IO performed directly from those pages.


Best regards,
Andreas Hindborg



