Return-Path: <linux-kernel+bounces-326151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044369763D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F8F1F24896
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8F18BC33;
	Thu, 12 Sep 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="C4CwBt63"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129C189BA5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128190; cv=none; b=a905LdShm/wNd/AJefP6NVKktjKgPdV6bNkK1jytbkMNeATBUxpzUrXQ5tUbv94kmDR1S9txtXEL7YB3fYN3bfrirYt5ksPQEwGIbcPxD2oQkyxmbTHbxIswke0mLGOoo2Oi25bBYFw+XY3blhsVw1eBD1IdxqLL7q3hT0u3+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128190; c=relaxed/simple;
	bh=Xq9/zJGImDodUK6APv8rmLUXRYQWoOSD8nL+qHMbnYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZfIEwNIL2hhFEZTaMBHOvZiFepMevBTDhNHBeboU/K6K8YbxBnktJLAHpDMxAkACXb4SMIlLVV2RO2D4S0vfwxIjy/2rt1yPl9p39e33KjLogNYpXfpceAZfjPS+QPCVZH/75TteHxL6WbG1g0y/Cc9K2DL2Z361KPArdi+tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=C4CwBt63; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726128184; x=1726387384;
	bh=Xq9/zJGImDodUK6APv8rmLUXRYQWoOSD8nL+qHMbnYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=C4CwBt63SnffFih3hoIpqHY1Ol+QUlLNiK1Q+9okWe+1BRA9KOKE8UeiPBL+XThbs
	 FL478P4CStuTWW52UhdZh7oN5WZQc5VoAZCjeaPOGgvIQdCaSdUEQonz5w1KqxD7zi
	 8CEc5LDTJq71hMOGRm4QpK+5gh+zINCc6D0U3SujD/knbVjTWFDRnfE68D0sghCyww
	 2RSnyJQp/Mt31JdvquLUCF2xjdVGNfMkjdupd4AfI7Yk16bUeXWE0ErHA5tdqrXLma
	 wyoY0PmWm2HcmMSPMZfSqrabiWWZCgjbzrZf+goJyruCVKuk0ouIiW+O3dcsX9KESC
	 4oq7ktDf9Z16w==
Date: Thu, 12 Sep 2024 08:03:00 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <58c81781-65b5-48ab-9c4c-b4f2dd014445@proton.me>
In-Reply-To: <ZuGuI7Ow0jJQBim6@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <ZuCEneJeXcRo5qs8@pollux> <19d81a27-9600-4990-867c-624104e3ad83@proton.me> <ZuDVekRzfeBkWmKz@pollux> <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me> <ZuF444VO8gK8l7UR@pollux> <b80cb238-5fcc-4bbb-8b03-42e173c28653@proton.me> <CAH5fLghwj-rD8zoPFgp3g1JYm8WrOhuiWnm7w=zStqOfRRZUJw@mail.gmail.com> <ZuGuI7Ow0jJQBim6@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e1b1c981f8d8dd5b13dddd8bb98baf557cdbfb28
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 16:50, Danilo Krummrich wrote:
> On Wed, Sep 11, 2024 at 03:27:57PM +0200, Alice Ryhl wrote:
>> On Wed, Sep 11, 2024 at 3:26=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>> On 11.09.24 13:02, Danilo Krummrich wrote:
>>>> On Wed, Sep 11, 2024 at 08:36:38AM +0000, Benno Lossin wrote:
>>>>> On 11.09.24 01:25, Danilo Krummrich wrote:
>>>>>> On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
>>>>>>> On 10.09.24 19:40, Danilo Krummrich wrote:
>>>>>>>> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
>>>>>>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>>>>>>> +///
>>>>>>>>>> +/// ```
>>>>>>>>>> +/// # use kernel::bindings;
>>>>>>>>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize +=
 1;
>>>>>>>>>> +/// struct Huge([u8; SIZE]);
>>>>>>>>>> +///
>>>>>>>>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
>>>>>>>>>> +/// ```
>>>>>>>>>
>>>>>>>>> Similarly, you could then say above this one "Instead use either =
`VBox`
>>>>>>>>> or `KVBox`:"
>>>>>>>>>
>>>>>>>>>> +///
>>>>>>>>>> +/// # Invariants
>>>>>>>>>> +///
>>>>>>>>>> +/// The [`Box`]' pointer is always properly aligned and either =
points to memory allocated with `A`
>>>>>>>>>
>>>>>>>>> Please use `self.0` instead of "[`Box`]'".
>>>>>>>>>
>>>>>>>>>> +/// or, for zero-sized types, is a dangling pointer.
>>>>>>>>>
>>>>>>>>> Probably "dangling, well aligned pointer.".
>>>>>>>>
>>>>>>>> Does this add any value? For ZSTs everything is "well aligned", is=
n't it?
>>>>>>>
>>>>>>> ZSTs can have alignment and then unaligned pointers do exist for th=
em
>>>>>>> (and dereferencing them is UB!):
>>>>>>
>>>>>> Where is this documented? The documentation says:
>>>>>>
>>>>>> "For operations of size zero, *every* pointer is valid, including th=
e null
>>>>>> pointer. The following points are only concerned with non-zero-sized=
 accesses."
>>>>>> [1]
>>>>>
>>>>> That's a good point, the documentation looks a bit outdated. I found
>>>>> this page in the nomicon: https://doc.rust-lang.org/nomicon/vec/vec-z=
sts.html
>>>>> The first iterator implementation has an alignment issue. (Neverthele=
ss,
>>>>> that chapter of the nomicon is probably useful to you, since it goes
>>>>> over implementing `Vec`, but maybe you already saw it)
>>>>>
>>>>>> [1] https://doc.rust-lang.org/std/ptr/index.html
>>>>>
>>>>> Might be a good idea to improve/complain about this at the rust proje=
ct.
>>>>
>>>> Well, my point is how do we know? There's no language specification an=
d the
>>>> documentation is (at least) ambiguous.
>>>
>>> So I went through the unsafe-coding-guidelines issues list and only
>>> found this one: https://github.com/rust-lang/unsafe-code-guidelines/iss=
ues/93
>>> Maybe I missed something. You could also try to ask at the rust zulip i=
n
>>> the t-opsem channel for further clarification.
>>>
>>> I think we should just be on the safe side and assume that ZSTs require
>>> alignment. But if you get a convincing answer and if they say that they
>>> will document it, then I don't mind removing the alignment requirement.
>=20
> I agree -- I also wrote this in a previous mail.
>=20
> I was just wondering why you are so sure about it, since the documentatio=
n
> doesn't seem to be clear about it.

As Alice found below, the documentation is actually clear about this. (I
think I read it at some point, but forgot exactly where it was)

Maybe it could be better documented that dereferencing has the same
requirements as `read` (or whatever they are).

>> Please see the section on alignment in the same page. Just because a
>> pointer is valid does not mean that it is properly aligned.
>>
>> From the page:
>>
>> Valid raw pointers as defined above are not necessarily properly
>> aligned (where =E2=80=9Cproper=E2=80=9D alignment is defined by the poin=
tee type,
>> i.e., *const T must be aligned to mem::align_of::<T>()). However, most
>> functions require their arguments to be properly aligned, and will
>> explicitly state this requirement in their documentation. Notable
>> exceptions to this are read_unaligned and write_unaligned.
>>
>> When a function requires proper alignment, it does so even if the
>> access has size 0, i.e., even if memory is not actually touched.
>> Consider using NonNull::dangling in such cases.
>=20
> Good point.
>=20
> It still sounds like it's only required for functions that explicitly sta=
te so.
>=20
> And as cited from nomicon "This is possibly needless pedantry because ptr=
::read
> is a noop for a ZST, [...]". But, no question, of course we have to honor=
 it
> anyways.

This sounds to me like an implementation detail note, not something that
a caller should consider. But that's my interpretation.

---
Cheers,
Benno


