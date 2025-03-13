Return-Path: <linux-kernel+bounces-560143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F572A5FE93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA771766B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCFF1EEA34;
	Thu, 13 Mar 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WamOBYPo"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F41EB1B8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888250; cv=none; b=uuL1424x7Xx/KaPI8UfXcYhSZfvXfqN+o8ZohrfGUK6ToUxY2L1I9eAR6oOo7yddXQUS2HmpLoWNofqe+EfyfVNNRSTuF7M27wwlpSqZQhsvYSQ+APjAkMZbHGsjetPwZIOWF6H2KFbWiODgoflc7mVxQdc6VTtTr3GvekhR324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888250; c=relaxed/simple;
	bh=hH2M0L8GugWIjL/IH69cL2k2SDu29U8ksydcjEDakFQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2BKa2CQ7RHU0P2kCiAwghcLkP1hcdJ4ZEP1CEVFavk/7kJNFKlYz0He867R9cB9QTYOxGNbV22SBNMdQVdxBkekqWagYcpw2oaKApLi+vbEeLoTNmLlN309VWqj4dJgTRkq+QEi8cTfSMfFrFY3eO/uKme20ApJKW2tEV5EqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WamOBYPo; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741888246; x=1742147446;
	bh=yWSTgNLE8+/y0F/wD0wigkqck+4QhaXuow7VuEL2rP0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=WamOBYPoWTC+oHDvFY4Psc29v1aXbWvf6/cqWmexcjvTGlOSRt75qNBOU2mQfJOMn
	 +Irluf37gIUo3UoNocD3rTvEwiOB25FNUe6jMKDbjlr3Zr1QcRSo12HKL8Mk6KC8D9
	 n++9yNvc9exrjZURDLiiq2+5OovwSF5OwLq4JKboXhpOWBHKQKkZPRISBBXynaIgsL
	 n3k2CxBu5PiFlbwPhB6OazeCu1z/ciCJZ8oAE1YUnw5pYy+a/0y5dgJ8v+020lo8fq
	 wyfib5WyBJgFjgadlpinwu0oueBl2CQxchKBXPg5umEzATcYNqKEWS3DBCC2SP1ebD
	 xiGUK7Q7lWYDA==
Date: Thu, 13 Mar 2025 17:50:40 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
In-Reply-To: <Z9L-Z4Aw64Hi5Lj8@pollux>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com> <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me> <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com> <D8F91L51P2EA.2FBHGJYSV06HY@proton.me> <Z9L-Z4Aw64Hi5Lj8@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c4f6d763d9be7a997f3e4bf9bf7b8294942129be
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 4:48 PM CET, Danilo Krummrich wrote:
> On Thu, Mar 13, 2025 at 03:38:55PM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
>> > On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
>> >> Would it make sense to not use `Result` here and continue with `Optio=
n`?
>> >
>> > We would have to return an Option<Result<R>> in this case. The current
>> > code folds the closure's Result into the one of the guard's acquisitio=
n
>> > for convenience.
>> >
>> > Actually, I don't think I have ever used try_access() a single time
>> > without converting its returned Option into a Result. Wouldn't it make
>> > sense to do the opposite, i.e. make try_access() return Err(ENXIO) whe=
n
>> > the guard cannot be acquired and document this behavior?
>>=20
>> Sure, if you're always doing
>>=20
>>     let guard =3D rev.try_access().ok_or(ENXIO)?;
>>=20
>> Then it makes sense from my view, maybe Danilo has some other argument
>> for why `Option` is better.
>
> Most of the time I think we indeed want to derive an Err() if try_access(=
)
> fails, but not with a specific error code. The error code depends on the =
context
> of where the revocable is used (e.g. for I/O mappings), but it also depen=
ds on
> the driver semantics.

In that case a single function with this signature would make sense:

    fn access_with<R>(&self, f: impl FnOnce(&T) -> R) -> Option<R>;

If there are common usages that always return the same error code, then
we could add them as functions with `Result`.

---
Cheers,
Benno


