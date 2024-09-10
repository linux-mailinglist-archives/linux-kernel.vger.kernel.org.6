Return-Path: <linux-kernel+bounces-323121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFE973839
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09B528649C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C1191F9F;
	Tue, 10 Sep 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iFudpvHW"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64643C0C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973441; cv=none; b=He93jzgltIJoopKAqAd7TgZprr/tXkwdCqY+wKJMB/3oG+7N0JthsBpOP09qxJzw5p6lh3lNKdXy2FyqFjLGQXH7OJjFP5we9iIT5PbinvFSiYOHwQf2vnr5JjcYeUhG71PPFDZmFiCU4VEMGhLa2Eo32gSAkSltaQVYAGK7MnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973441; c=relaxed/simple;
	bh=x1o0G2D/DnKp2GiG1HSvTPWfErDt/cPj5ZiIWZe9ToM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuaqRadmTbGiHjxXVvaiUx6WbCYfGY9j38GXlqdcKhJTN2X3J1iIPeqYaWuG1qBglLFLa+9HiatAjLHJc5dsXF+wWVaf254bVMXP6D5VpskhYq3tU5L6SwSh/lIh2jpLAOwEsMQQXMdxjaI3ApyG7ZttDzLrnmRsE3ITbZhhzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iFudpvHW; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hw457d576rdmvabsgqk6my4jny.protonmail; t=1725973436; x=1726232636;
	bh=QL/xny+7YZ+HuSdSBDWfILutCZ1cQLnIIC+OF84XN2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iFudpvHWDUScSVTix+YcNVhOyw09PRzCHdSiyV7hMLU1erXMdLwPZvxTT2YVSB7Ox
	 GJ9cR68zOWbmrJLfx4CgpcDnxBoe2TAmAMAt+TgKAj2aUD0oDrAZtr2eiZ/BJP4ezh
	 7x49q374LYEY820SLi80fvRDKUw0Ze/PP8NoH86SzWqWMTfQwV/WeJFlMj0D5jWyWS
	 jNIqRmblXxHBZ5wRfRc95xrIQESyitdZpiNpRak9wbOSLxwJUBS/8il6RACtjZ0MyR
	 29DC9rE4D3pY45jGuV5SRFq1B2uAbIcZ9Q/UwtUcEuUGrUDhlsh9TfR9NorO/PJp0l
	 ownJjUGQNCAMg==
Date: Tue, 10 Sep 2024 13:03:48 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <d5761d8e-8e17-42a5-9793-92edb121428e@proton.me>
In-Reply-To: <Ztb5arBBX2LsrFKo@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-2-dakr@kernel.org> <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me> <ZtDuf0QGfhiy5X_I@pollux.localdomain> <44b80095-8b03-4558-967e-138ea712f780@proton.me> <Ztb5arBBX2LsrFKo@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 529a7b2793b9f2585f48e36eb06cf94ffed7918e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.09.24 13:56, Danilo Krummrich wrote:
> On Fri, Aug 30, 2024 at 01:06:00PM +0000, Benno Lossin wrote:
>> On 29.08.24 23:56, Danilo Krummrich wrote:
>>> On Thu, Aug 29, 2024 at 06:19:09PM +0000, Benno Lossin wrote:
>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>> Add a kernel specific `Allocator` trait, that in contrast to the one =
in
>>>>> Rust's core library doesn't require unstable features and supports GF=
P
>>>>> flags.
>>>>>
>>>>> Subsequent patches add the following trait implementors: `Kmalloc`,
>>>>> `Vmalloc` and `KVmalloc`.
>>>>>
>>>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>>
>>>> We discussed this in our weekly meeting (I think ~one week ago?). If y=
ou
>>>> give me a draft version of the comment that you plan to add regarding
>>>> the `old_layout` parameter, I can see if I am happy with it. If I am, =
I
>>>> would give you my RB.
>>>
>>> May I propose you let me know what you would like to see covered, rathe=
r than
>>> me trying to guess it. :-)
>>
>> I was hoping that we put that in our meeting notes, but I failed to find
>> them... I would put this in a normal comment, so it doesn't show up in t=
he
>> documentation. Preface it like implementation decision/detail:
>> - Why do `Allocator::{realloc,free}` not have an `old_layout` parameter
>>   like in the stdlib? (the reasons you had for that decision, like we
>>   don't need it etc.)
>=20
> Ok.
>=20
>> - Then something along the lines of "Note that no technical reason is
>>   listed above, so if you need/want to implement an allocator taking
>>   advantage of that, you can change it"
>=20
> I don't really want to set the conditions for this to change in the
> documentation. It really depends on whether it's actually needed or the
> advantage of having it is huge enough to leave the core kernel allocators=
 with
> unused arguments.
>=20
> This can really only be properly evaluated case by case in a discussion.

Agreed, but I don't want people to think that we have a reason against
doing it in the future. Do you have an idea how to convey this?

---
Cheers,
Benno


