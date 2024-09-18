Return-Path: <linux-kernel+bounces-332854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49C97BFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DB91F227A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC21C9DDA;
	Wed, 18 Sep 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XfD+ZxYP"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966EB1494B1;
	Wed, 18 Sep 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680828; cv=none; b=exxCVOFiAvxlZlDrdc1+bhm8RsuLtkxW7S/KbWPcmOysZvMpnIlGkFXfhYxx1z/3VlH6qW68r4JyES/CcZLtuoAsFckP4kEmDUh4n5q0eVO+oVQ0enX9AJ+70m3XeJKjRe3xebkQUX7t1K5Ea5DQXmFEVaH+/6CS83bJjQIA+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680828; c=relaxed/simple;
	bh=5XFFHTszz5MaS+jXnTT67ZY+TN8fRCd8aFfK8Nr7A9M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9PAis3NgI2PozUIz0hEWyJKpYjwVfQcMQF07eOwd5sQrblrQBXDiknF1EhogHtx7A3+pnueZmSUink5vCX6jKESFlLj1vK5zuYKRGk8TOz+hHfwJBZKJYIASjnM7uAC6me7JwPqzEqfQeWeKpzhhgAcPyJrpuCF7BcT8BM5ikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XfD+ZxYP; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726680818; x=1726940018;
	bh=noiDOwTcoSMsrbiWyGvF+quGT0FYDhIN9D6SxLv7reQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XfD+ZxYPjgkKujejFVMmaSmeaHgGPMvHd1LGpP/G9xHm6Ow+NeWQJqpHowNPEbDlA
	 L8Yc4q+m989WT0Ld6IljKs2ImsCbaFROuP/r4mdeVE954XvxhqoUjfFBYjBUEVYqwH
	 GP2wMHC9Rf0UwL6WYVzENvQYYbbUnk4xEd8R7/QDdD1QUoOmWM6NOBSc62Akth9lIY
	 0eX2vvtJ75jywnmpXrEhQbiDZdGuAXgeh35H+ILcHi4mmE+2F1IPdC2vsbYA98cHN3
	 rij+5iAkDk57FfxMQ8faBRPX/FYctnlN7GUpwy2YwwUk02sVQdxJbbGbE6qAQhuh/T
	 TzNSkfilsuZNQ==
Date: Wed, 18 Sep 2024 17:33:33 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <af028585-d253-4460-acdc-99b349f49d47@proton.me>
In-Reply-To: <2024091858-surrender-broadcast-e11f@gregkh>
References: <20240913112643.542914-1-benno.lossin@proton.me> <20240913112643.542914-2-benno.lossin@proton.me> <ZuRbSxwlz1xWT1pG@phenom.ffwll.local> <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me> <ZuhTdwCqz61bQEgq@phenom.ffwll.local> <26534d80-989d-4b77-9720-84575275890f@proton.me> <2024091858-surrender-broadcast-e11f@gregkh>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 50147382e8e26474ec809eec290575a95931595a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.09.24 19:09, Greg KH wrote:
> On Wed, Sep 18, 2024 at 03:40:54PM +0000, Benno Lossin wrote:
>>>> Yeah, we need more users of this to know the full way to express this
>>>> correctly. I would like to avoid huge refactorings in the future.
>>>
>>> I think adding it to the copy_*_user functions we already have in
>>> upstream, and then asking Alice to rebase binder should be a really sol=
id
>>> real-world testcase. And I think currently for the things in-flight
>>> copy*user is going to be the main source of untrusted data anyway, not =
so
>>> much page cache folios.
>>
>> Sure. I chose tarfs as the use-case, because Greg mentioned to me that
>> it would benefit from adding this API. (I have no prior linux kernel
>> experience, so you giving me some pointers where this will be useful is
>> very helpful!)
>=20
> I just had tarfs as an easy example where we were reading data off the
> disk and acting on it, in a way just like C where if the data is
> corrupted we can do "not normal" things.  Sorry it got tied up with

No worries! I was just under the impression that this would be common
(maybe it's common for filesystems?), so just having that clarification
now makes more sense.

> folios, that is not the normal way drivers work, they either get data
> from userspace through a char device node (ioctls) or from hardware
> (memory copies/reads/something) and for them the "untrusted data"
> abstraction should be much simpler than dealing with a folio.
>=20
> We don't really have any other good examples of drivers in rust yet that
> I could find other than maybe binder, but Alice has already posted her
> solution for how to handle untrusted data there (comes in through a char
> device node and/or a filesystem entry point) but it's much more complex
> and possibly harder to use as a simple example of the api ideas.

Yeah that's what I thought as well when you brought it up the first
time.

---
Cheers,
Benno


