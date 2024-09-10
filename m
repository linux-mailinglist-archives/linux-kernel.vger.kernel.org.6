Return-Path: <linux-kernel+bounces-323792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B3974388
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C281C257E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C6189BA4;
	Tue, 10 Sep 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LU47qAOQ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D0419A281;
	Tue, 10 Sep 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996834; cv=none; b=MFV813UcaQE4vUPhgpb3z+us0L+TEzZqGR+pbYQIpbBbHpsXp4NH8n4Bt6SfPw2OanRjHMSxWnQ1w63V5c1PXI2QLe0i8+Fci375vNzBBu2i7dJxUKbNRxvd3xiKRkvgUj05UeGa9rNUHdtemoR6aPftOBwLn5dKdD9tIqwrSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996834; c=relaxed/simple;
	bh=8q4/wnb4Lv1NM4jPA8ckOJ3dntAPwhBlRjBlOPdC5Zo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCvk6bOnUZ2MsZMZ72RVx/5eVnMYBelO9yC+AaEGUYM5sqwtF+LGeYP2Wz/2HIpoaKJVSpyE/WGiKeGVGRPXqaorwcmTHntlSf/zmmDHk1n6Kof4Tp4nDzyHj6xf4kmGuRvgxZTlt6Ise2meoxRtGS4yq0QpFzldXmnn6eHm7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LU47qAOQ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725996829; x=1726256029;
	bh=1zR0yVmyu4U5w/BJEg0lbfHBNngkB4Cm1AyZliMr5EY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LU47qAOQlTGa+rdFOwVCtI1ONH3/zT1aD/Ls7ZQo/McAhw32pWMUFttyILnk1is/5
	 DiwFvFTrJRqZLcXuIvxDTfXQaO1SruBCJkXIl3cy1oynZU2FdOOH2IY/8eO0tKL2OL
	 1aRcBGMBabuZ9jikVcOjMYA30In+u9q+xx/Kd4bO6xpjVw4mwiGTcAhAcpiKBqVvS7
	 9RODEGXEz2Szm6L0ss1pll69fPDVHqlPAo8wOxIfI0ktvm5Ulce/hvtpvtiKJZj5xy
	 ds9PItpfHvvEJVEWdqKEbS5l81C/hGIwthCaxntfTaKrXNIFaN4CE+yZQJuwgz02uI
	 yjEbU8PSuZHKw==
Date: Tue, 10 Sep 2024 19:33:43 +0000
To: Danilo Krummrich <dakr@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <367ca85d-3ed2-422a-bd90-2fc53fdf25b5@proton.me>
In-Reply-To: <ZuCPYq9p61_Q9YwC@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-14-dakr@kernel.org> <ZtdemCduZ1KqayXw@boqun-archlinux> <ZuCPYq9p61_Q9YwC@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 680bb1fe669484657728a20f8f8460c90b9f2dde
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.24 20:26, Danilo Krummrich wrote:
> On Tue, Sep 03, 2024 at 12:08:08PM -0700, Boqun Feng wrote:
>> On Fri, Aug 16, 2024 at 02:10:55AM +0200, Danilo Krummrich wrote:
>>> `Vec` provides a contiguous growable array type (such as `Vec`) with
>>> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
>>> `Vmalloc` or `KVmalloc`).
>>>
>>> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
>>> kernel's GFP flags for all appropriate functions, always reports
>>> allocation failures through `Result<_, AllocError>` and remains
>>> independent from unstable features.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>> [...]
>>> +
>>> +impl<T, A> Vec<T, A>
>>> +where
>>> +    A: Allocator,
>>> +{
>> [...]
>>> +    /// Forcefully sets `self.len` to `new_len`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// - `new_len` must be less than or equal to [`Self::capacity`].
>>> +    /// - If `new_len` is greater than `self.len`, all elements within=
 the interval
>>> +    ///   [`self.len`,`new_len`] must be initialized.
>>
>> Maybe use "[`self.len`, `new_len`)" to indicate `new_len` side is open?
>=20
> Agreed.

Alternatively just use the rust range operator `self.len..new_len`, it
is exclusive by default (for an inclusive range you can use `..=3D`).

>> Also `self.len` may confuse people whether it's the old length or new
>> length, could you use `old_len` and add note saying "`old_len` is the
>> length before `set_len()`?

I personally think this is not a big issue, since safety requirements
are preconditions to calling a function (so the function couldn't have
been called yet).

> What about:
>=20
>    /// - If `new_len` is greater than `self.len` (from before calling thi=
s function), all elements
>    ///   within the interval [`self.len`,`new_len`] must be initialized.

You will still apply the range fix, right?

---
Cheers,
Benno


