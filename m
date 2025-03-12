Return-Path: <linux-kernel+bounces-557158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340ADA5D455
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A84C189D06E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBA15539A;
	Wed, 12 Mar 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KbZSVC2h"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B151519A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745815; cv=none; b=XWPFs+y8KywiWYG3WzsdSEn2PhQnXgDILRImkluO+6YFJWsBT4eEl3BrZ7S0iWaDvHEhRb25N5BPalT5fXbUxCd3/nj6AXWnbz2FaCuL9Xrq4jLiTKuv23X9Oi78IbzSkzVtxd6CHpdXT9SD4xRT6zf03soXiExpVIKQ6YDMeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745815; c=relaxed/simple;
	bh=FbZ8OYjuzGtpPLQekwjpz+JMy6rKltWZfsuizzl/zF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtL3zX9OIz/iT3q9fuST4fwByJdyRl1BhG6cQpW789z/y4QkyohiNybdY2c4WkTAA9as5oSYYzbFlW5MbARMU3BZCgr+KIlwo0VAl4sK0kLoLolPVspjASnzWfGubDQa9Yk0PQJE5jN2w9sC9qA07uWaz8erzRBO/aOGp634PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KbZSVC2h; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741745810; x=1742005010;
	bh=FbZ8OYjuzGtpPLQekwjpz+JMy6rKltWZfsuizzl/zF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KbZSVC2hrz0+QknMcnn0LE6BSRgKfLTgxDZ+WgiuUp0uaYAy5cxJacPRwr2KR/ZRq
	 +5/fx1cZWqGu13wHnq2AZOylp4VArpbgcOPp6J4k8+Sst92bCFsR+kHSi5mbhfkzms
	 15CkU/7T+bpN/HWQ1A5rRbtssIc+4OaE5ZlORcyWsyMdI/b7r2zdzyzGr8LbTRqcJ6
	 F+nBDdgb4v14NFpPv5dPJUWRYa0JBfSgpQCm3HkzLow4kVQzYWHyq9eR7+69+S8Y/U
	 x+skwbZIv5x761j34WggGa57toDnUXJ7xQPivPAuQ5jOt0Gjg2p09DmWLrJPOFJk4e
	 oZMrFQhdWDHTw==
Date: Wed, 12 Mar 2025 02:16:43 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Rust support for `struct iov_iter`
Message-ID: <D8DXCTL4756M.LQL5WA0TONAF@proton.me>
In-Reply-To: <2025031140-saffron-kilobyte-bd2e@gregkh>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com> <2025031140-saffron-kilobyte-bd2e@gregkh>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9393f529b82df52634aea87eebb9736bdb20dba0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 11, 2025 at 3:37 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Mar 11, 2025 at 02:25:11PM +0000, Alice Ryhl wrote:
>> This series adds support for the `struct iov_iter` type. This type
>> represents an IO buffer for reading or writing, and can be configured
>> for either direction of communication.
>>=20
>> In Rust, we define separate types for reading and writing. This will
>> ensure that you cannot mix them up and e.g. call copy_from_iter in a
>> read_iter syscall.
>>=20
>> To use the new abstractions, miscdevices are given new methods read_iter
>> and write_iter that can be used to implement the read/write syscalls on
>> a miscdevice. The miscdevice sample is updated to provide read/write
>> operations.
>
> Nice, this is good to have, but what's the odds of tieing in the
> "untrusted buffer" logic here so that all misc drivers HAVE to properly
> validate the data sent to them before they can touch it:
> =09https://lore.kernel.org/r/20240925205244.873020-1-benno.lossin@proton.=
me

I have started to work on that again, just needed to get through several
things in my backlog...

Are there any drivers or abstractions in mainline that I can use for
creating the interface? Or are those still out of tree? I don't think
that I can use tarfs for that as I did back when I started with this
patch set, as it will probably be hopelessly out of date.

---
Cheers,
Benno

> I'd like to force drivers to do this, otherwise it's just going to force
> us to audit all paths from userspace->kernel that happen.
>
> thanks,
>
> greg k-h



