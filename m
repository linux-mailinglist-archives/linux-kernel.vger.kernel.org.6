Return-Path: <linux-kernel+bounces-567927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE2A68C14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6153BD8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E6254AFF;
	Wed, 19 Mar 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWZdbnt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30101E552;
	Wed, 19 Mar 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384634; cv=none; b=TN+8mino3BEzPG5K4UEO7juZ8+j6hGlZi2XxvoUVzqq43DVeYAHc5oOL+/mSw/URaFbHBe7UqkMUvIKUafs0vsSTZTuvRNqOrGHb5iN9/fHZz3otkaCvjL3QX5oTIF0qz8gqDHdBuM72H47tPgS9PvI2jySxKkNM/HZBVBQSbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384634; c=relaxed/simple;
	bh=7i5D1sAvsoAyDCSr+yej00GhTIQ3HpL2Z2y/15DFzn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYKqo51BCcj7A2zdf9KABPoqCDodRru71nnMYkku6+9QLj4qTnem9/5M69E1M/x8TFh0a6+Ps9+6U7gUesbgb0cY9TX3HweG7G/c6myPpY3R9sGD1vTMdJD6Jgf52WZiln5UPtts2f9SdMoGxG/0Q/8HeR3yS0ZB64GYaLeGuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWZdbnt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D17C4CEE9;
	Wed, 19 Mar 2025 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742384633;
	bh=7i5D1sAvsoAyDCSr+yej00GhTIQ3HpL2Z2y/15DFzn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWZdbnt67y1TxiLpMEMB28gdq4SnclJw1Gocufia7Qy7iHeLhbItj+MSXsjxul2fS
	 C2FHvAu+No3k2RjtBkMYTTSZZbqeoU3P+FSLcNTpZE7Vg+WraKAcsk9h2cg+p/tgK0
	 /DVizZwU1ck/lZ6WRzEyoWVgZJ6vF3HMBx3yWIf4=
Date: Wed, 19 Mar 2025 04:42:34 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
Message-ID: <2025031928-connected-confider-dda5@gregkh>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <9pOFLtAJ1ScEHfLe7L2KqghIKBzL8sTupJttIVRB70ZmvdUpiEYrxCxIpJD_cBJVwv-TKxosDL-l6cq3qt563Q==@protonmail.internalid>
 <2025031140-saffron-kilobyte-bd2e@gregkh>
 <878qp2hx9o.fsf@kernel.org>
 <_faLZHT6mnujSjNGxKLz9hgfs7W4w_MLWjiFHHYughpAFkITeHHgVAqHUhc3-FvYC_rdOjygOzVQC3zXSDTEqg==@protonmail.internalid>
 <2025031804-eardrum-surplus-5ff9@gregkh>
 <87wmclgttg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmclgttg.fsf@kernel.org>

On Wed, Mar 19, 2025 at 12:10:03PM +0100, Andreas Hindborg wrote:
> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Mar 18, 2025 at 09:57:55PM +0100, Andreas Hindborg wrote:
> >> "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> writes:
> >>
> >> > On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
> >> >> This series adds support for the `struct iov_iter` type. This type
> >> >> represents an IO buffer for reading or writing, and can be configured
> >> >> for either direction of communication.
> >> >>
> >> >> In Rust, we define separate types for reading and writing. This will
> >> >> ensure that you cannot mix them up and e.g. call copy_from_iter in a
> >> >> read_iter syscall.
> >> >>
> >> >> To use the new abstractions, miscdevices are given new methods read_iter
> >> >> and write_iter that can be used to implement the read/write syscalls on
> >> >> a miscdevice. The miscdevice sample is updated to provide read/write
> >> >> operations.
> >> >
> >> > Nice, this is good to have, but what's the odds of tieing in the
> >> > "untrusted buffer" logic here so that all misc drivers HAVE to properly
> >> > validate the data sent to them before they can touch it:
> >> > 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
> >> >
> >> > I'd like to force drivers to do this, otherwise it's just going to force
> >> > us to audit all paths from userspace->kernel that happen.
> >> >
> >>
> >> I think that for user backed iterators (`user_backed_iter(iter) != 0`)
> >> we will have the same problems as discussed in [1]. To validate, we
> >> would have to copy the data to another buffer and then validate it
> >> there, in a race free place. But the copying is apparently a problem.
> >
> > We already copy all data first, that's not an issue.  Validate it after
> > it has been copied before you do something with it, just like we do
> > today for normal ioctl C code.  Same goes for data coming from hardware,
> > it's already been copied into a buffer that you can use, no need to copy
> > it again, just "validate" it before using it.
> 
> I guess that depends on the user of the `iov_iter`? At least when it is
> used for direct IO, the operation is zero copy with pages mapped into
> kernel and IO performed directly from those pages.

Great, and then, before you actually do something with that data, you
have to validate it that it is correct, right?  If this is just a
"pass-through" then no need to do anything to it.  But if you have to
inspect/act-on-it, then just inspect it in the verifier portion.

I'm not trying to add any additional overhead here, as you normally
would have to verify the data is correct before doing something with it,
but rather just forcing that validation to be done in an obvious place
where everyone can see that it is being done, or not being done.

In other words, make it obvious to reviewers that this is happening,
instead of forcing them to dig through code paths to hopefully find out
where it happens.

thanks,

greg k-h

