Return-Path: <linux-kernel+bounces-556320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8500A5C403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2446E165F50
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D225CC63;
	Tue, 11 Mar 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYE/+KNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715061D514E;
	Tue, 11 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703879; cv=none; b=q2OuXdF9xOSfd1cIwz5B0JHYJCxCRDvD2FhbPAWeWSA6QuRdSwuznEyqsvl1tU+n0JIjN+7IJHwcG6jNJTUlQtoYgmIwGG3/IMmq64XqL06JbLLCkGGECBE+A7lZWwhQSeWOgWcrxD3OSdvzyuyF8iorbKhj4nq2aSMBRzrJF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703879; c=relaxed/simple;
	bh=4lpvvfvh6hEmkzgKd/iYgOgCrNqFGWnI/yWgvDil+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnM0exFzYulc6awivLeIFkM2Yds8/NGV80LBSRnd4khSpwYMCJI+EvF9Fb9fXVYF8WY9s3uJJluq7SzdJ6LpaiuGnpwCPmO96zfvurCQNmtMTlohokfeUlWd62QTPi4/DUjyy1Iqv5HL7IqiA0zNmdbq376SvmCK7dsyTXqyEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYE/+KNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF93C4CEE9;
	Tue, 11 Mar 2025 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741703878;
	bh=4lpvvfvh6hEmkzgKd/iYgOgCrNqFGWnI/yWgvDil+Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYE/+KNnj9EkOy7KYNpOYWIm9SIZH1BkNsniZ/azOQzux6kQ62foeAViEtBPIoSAb
	 54FQB7XJvPcdJzoDu3E65M+qagT1KEdm8taOKKI0YQTPWWm5oVW+yNqyvsN4AysMul
	 Bpi6CCFoxQ+Vl0eJt38dXinaVHmi5uTrCAO1BSMo=
Date: Tue, 11 Mar 2025 15:37:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
Message-ID: <2025031140-saffron-kilobyte-bd2e@gregkh>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>

On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
> This series adds support for the `struct iov_iter` type. This type
> represents an IO buffer for reading or writing, and can be configured
> for either direction of communication.
> 
> In Rust, we define separate types for reading and writing. This will
> ensure that you cannot mix them up and e.g. call copy_from_iter in a
> read_iter syscall.
> 
> To use the new abstractions, miscdevices are given new methods read_iter
> and write_iter that can be used to implement the read/write syscalls on
> a miscdevice. The miscdevice sample is updated to provide read/write
> operations.

Nice, this is good to have, but what's the odds of tieing in the
"untrusted buffer" logic here so that all misc drivers HAVE to properly
validate the data sent to them before they can touch it:
	https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.me

I'd like to force drivers to do this, otherwise it's just going to force
us to audit all paths from userspace->kernel that happen.

thanks,

greg k-h

