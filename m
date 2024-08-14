Return-Path: <linux-kernel+bounces-287195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF1B95247E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933D31C22278
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76521C8222;
	Wed, 14 Aug 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Pxr28h/P"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C9210FB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669827; cv=none; b=Q9zGQhVIUp3Gt9fhRRLvjwzJjU7Ocmajz3rBmQJ+o2LS1oy6Dj0ccHldVxSkIQdEILqjryat2mf7dc7BS63YVP7NVi8y9nKjlm3NsE935Qu8ncCvoAQ0Npf776XtqnhQR7ORS0Q1aXtOogLbySRVSE/ZuV4bRdM33eD138eBDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669827; c=relaxed/simple;
	bh=BUOPubvBNvWiovsd836uznv4khRkwVqGpe5OVPT0LDk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYOyDKU5OZm49NLkm1w8pK3jYPLF2L37Ar6OVhRg8NepVH6RMRCWCcVTX9EgaS4B66Tn76QlaE4MWgJYiCZVXEpmQzcE2sRSvkxkmOlefdSRQI1zrotHMqBGeDQvj6Zz+KZ1oEwLMB2Fpojew0t5VLxJsPl8sxrOsH7SzwNMHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Pxr28h/P; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723669822; x=1723929022;
	bh=BUOPubvBNvWiovsd836uznv4khRkwVqGpe5OVPT0LDk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Pxr28h/P48Z7GbVpx1FH+zG9d1e2JToTdmQtRy103y9JnIzGnDZHnCAEeFlqGkAwA
	 wotaHSeHwRWcvrKJPKmh/rYIRz4/DPAu6yig16iT1MEseRXszTJquArdFRGaVg4DrH
	 BWOeFjVkJPxBwQhfhNIfWO6vZzS4g523YBn/Gyd0q2ZlOXV4uMxDGBrLqAd8xhMpR8
	 tcQY0Z+nX68hNajYmarAzyTQ+nd1/LZI6UJvriqIv5nDDEwoNPCwDbVnHwrapmpQZp
	 mWQD5MSHVnEw3HXpF0zVKYtFc+AECMATlUnyvTKecoX0bnLQw3uubwWaD6HlojDJsl
	 Odt6dH3y+9C2g==
Date: Wed, 14 Aug 2024 21:10:19 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ba769013-b6ef-49f4-93ad-68f3b7c8116e@proton.me>
In-Reply-To: <ZrzlqFuZ63QJT8Cx@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org> <04b0fd96-c91c-4f38-90e9-8acee31e8445@proton.me> <ZrzlqFuZ63QJT8Cx@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 73eec96c4b72b2b0ae127de1c0a689aa229f6d5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 19:13, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 04:28:04PM +0000, Benno Lossin wrote:
>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>> +unsafe impl Allocator for Kmalloc {
>>
>> There is a missing SAFETY comment here (and also for Vmalloc, probably
>> also for VKmalloc then).
>=20
> Any suggestion on what to write here?
>=20
> I'd probably come up with something like:
>=20
> --
> Memory returned from `Kmalloc` remains valid until explicitly freed.
>=20
> It is valid to pass any pointer to an allocated memory buffer obtained wi=
th any
> function of `Kmalloc` to any other function of `Kmalloc`.
>=20
> If `Kmalloc::realloc` is called with a size of zero, the given memory
> allocation, if any, is freed.
>=20
> If `Kmalloc::realloc` is called with `None` it behaves like `Kmalloc::all=
oc`,
> i.e. a new memory allocation is created.
> --
>=20
> and repeat that for `Vmalloc` and `KVmalloc`.
>=20
> I'm not sure how useful that is though.

Ideally you would write down how the guarantees are satisfied in
addition to the invariants. But I guess this is only guaranteed by the
`ReallocFunc::call`, since that handles the ZSTs... Maybe this is a bit
excessive. If I come up with something better I will let you know.

---
Cheers,
Benno


