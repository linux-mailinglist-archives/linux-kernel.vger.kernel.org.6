Return-Path: <linux-kernel+bounces-277436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FE294A16F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BCB286F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA51C3F35;
	Wed,  7 Aug 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jm0tOSVx"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74421C3F39
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014868; cv=none; b=gdvdZZcb8k6REnUyjH4OrmUYvszm4wygHaP0norKfIRj/4vuNGC/ZSZmC7NA7aN5RGMXBqxij0WnZq0xOUFQ96g35QyxuArbAvF4Z/FD5S9j7lRZzMbW4v8NMasWq0ARx7YYXy8JLZ81jEbRKQ+RBnDAHk84UMdbuIl66zNlspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014868; c=relaxed/simple;
	bh=xih6GR50rJWypbMwLc660R9WLnXV+9gp3dCmm7pao4I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsv+tiftmvOD4xmEhKFRfdzZCiZKd7TqFVS3fTqrkWoVjXXgq7zzJ6eYeKO5t4jiovxbxxnvOc3HV0fMp4/2h02PeadRxkO76uoScFcll9gtxCIC11Pz+vn4zrShbxrd/fArtFmm2gCfAf5pF7dVzrArv80B15/81pBWL/qi3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jm0tOSVx; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723014858; x=1723274058;
	bh=IwhjyLorLJBDg7VEB2UYYLDQnYdc84/Oq97BKUHGqvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jm0tOSVxXABoxzb2krBXFRVA7HjplKhC75MyOwddvtxGKrmOA/yiaVgFJb5e4wv+G
	 p3MKMoAH6wxkZI0WO8JX+kIMqnkyPp3ORe5SnrVRZ8IptLMMtOdjM8JRDT7plCTAjA
	 xGP/kqMVw0Pe7g2zpHn0ueCUPq1Cn0m53fByhUSiWcFS1eJ0c+Vl9iFPJGcwIPEULL
	 ksW6gvQJg73jKDkce61eOz/KB7vFJOXoiGuYbORXG/FuQhl2nbY9cTe3wAeYqDu5v2
	 GvtAbrQG72170TROd+pKaSjfDvbwidCHJ6ibM2SvReOMTLqkr1mTFG6vnAGq/iDLtN
	 GhX2lG43gOqFw==
Date: Wed, 07 Aug 2024 07:14:13 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me>
In-Reply-To: <ZrJxkwF2Y59xln1e@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-5-dakr@kernel.org> <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me> <ZrJxkwF2Y59xln1e@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bf48ef3fed571d9e2a500dc56bbce2145c250d69
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 20:55, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 04:51:28PM +0000, Benno Lossin wrote:
>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>> +        let raw_ptr =3D unsafe {
>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behin=
d the pointer is freed.
>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>> +        };
>>> +
>>> +        let ptr =3D if size =3D=3D 0 {
>>> +            NonNull::dangling()
>>
>> If we call `realloc(Some(ptr), <layout with size =3D 0>, ...)`, then thi=
s
>> leaks the pointer returned by the call to `self.0` above. I don't know
>> what the return value of the different functions are that can appear in
>> `self.0`, do they return NULL?
>=20
> That is fine, we don't care about the return value. All `ReallocFunc` fre=
e the
> memory behind `ptr` if called with a size of zero. But to answer the ques=
tion,
> they return either NULL or ZERO_SIZE_PTR.

I see, then it's fine. I think it would help if we know the exact
behavior of `kmalloc` & friends (either add a link to C docs or write it
down on `ReallocFunc`).

>> What about the following sequence:
>>
>>     let ptr =3D realloc(None, <layout with size =3D 0>, ...);
>>     let ptr =3D realloc(Some(ptr), <layout with size =3D 0>, ...);
>>
>> Then the above call to `self.0` is done with a dangling pointer, can the
>> functions that appear in `self.0` handle that?
>=20
> This would be incorrect.
>=20
> Calling `realloc(Some(ptr), <layout with size =3D 0>, ...)` frees the mem=
ory
> behind `ptr`. This is guranteed behavior for all `ReallocFunc`s, i.e.
> krealloc(), vrealloc(), kvrealloc().

Note that I don't use `ptr` afterwards, the code snippet above is
equivalent to this:

    let ptr =3D Kmalloc::alloc(<layout with size =3D 0>, ...);
    unsafe { Kmalloc::free(ptr) };

internally exactly the realloc calls that I put above should be called.

---
Cheers,
Benno


