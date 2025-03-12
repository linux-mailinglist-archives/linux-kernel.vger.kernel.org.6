Return-Path: <linux-kernel+bounces-557287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B433A5D689
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2317A9CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8D1E5B89;
	Wed, 12 Mar 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlK6CN5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D441BDCF;
	Wed, 12 Mar 2025 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762116; cv=none; b=gqtTcLSdGxGXEuK2BGaggTzHqO7frNEAOcVT17QxeWmrcLrMJq3SiJeKW1VU3UC+d0Qg+JZMLCpFW0A+O1HkcMrxgDsayZO+Fc1hMfWT6x11Hz8JYK+uRTcUGtjst+fkosFqH2m2E6rZJg2y1W93NBSE9fKxKXUmrhzH2P9qpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762116; c=relaxed/simple;
	bh=qvSssY0YTW6KFKTY265DJVLR19ytPSMNXDuxARLY6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF2Jj9r/5BwEAv/6Jq8i1xKz0hp1nGddRrhOxpWi0ezjCzyLVCMyvTqI7QH4/ILUExl70RPysiVgpfzJRmKTMTzgAALD3lmfeYGjPZjNtDXTXfzpaLAYhfwiiXEwaat20KtWKVnsD+mYmWt19EThJdruGNDagYjyRM1BqTI/qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlK6CN5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D0CC4CEED;
	Wed, 12 Mar 2025 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741762116;
	bh=qvSssY0YTW6KFKTY265DJVLR19ytPSMNXDuxARLY6no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlK6CN5Aa6voo7NV81ZOlNAyEP/SRyfHWgjHjeRHt9IGXyyBtusTW9n6+08Znn1i3
	 7nmRCfNQJV92rOUNaxDJ9yWUzKDrSSBvrNIejkfF3jgTnxVMiS7DwRPl0N22sgfw01
	 /q5zmNoIxaHLcDD8DdlsnRQwo5klYTwU6LvsXMzo=
Date: Wed, 12 Mar 2025 07:47:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
Message-ID: <2025031236-motivator-tactless-a899@gregkh>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <2025031140-saffron-kilobyte-bd2e@gregkh>
 <D8DXCTL4756M.LQL5WA0TONAF@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8DXCTL4756M.LQL5WA0TONAF@proton.me>

On Wed, Mar 12, 2025 at 02:16:43AM +0000, Benno Lossin wrote:
> On Tue Mar 11, 2025 at 3:37 PM CET, Greg Kroah-Hartman wrote:
> > On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
> >> This series adds support for the `struct iov_iter` type. This type
> >> represents an IO buffer for reading or writing, and can be configured
> >> for either direction of communication.
> >> 
> >> In Rust, we define separate types for reading and writing. This will
> >> ensure that you cannot mix them up and e.g. call copy_from_iter in a
> >> read_iter syscall.
> >> 
> >> To use the new abstractions, miscdevices are given new methods read_iter
> >> and write_iter that can be used to implement the read/write syscalls on
> >> a miscdevice. The miscdevice sample is updated to provide read/write
> >> operations.
> >
> > Nice, this is good to have, but what's the odds of tieing in the
> > "untrusted buffer" logic here so that all misc drivers HAVE to properly
> > validate the data sent to them before they can touch it:
> > 	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me
> 
> I have started to work on that again, just needed to get through several
> things in my backlog...
> 
> Are there any drivers or abstractions in mainline that I can use for
> creating the interface? Or are those still out of tree? I don't think
> that I can use tarfs for that as I did back when I started with this
> patch set, as it will probably be hopelessly out of date.

You can use the misc device api as a start, bindings for it are in the
tree, and this series here has an example that would need it directly.

thanks,

greg k-h

