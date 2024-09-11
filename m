Return-Path: <linux-kernel+bounces-325044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20927975432
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452521C20AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837819343E;
	Wed, 11 Sep 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cJl6WIRo"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD181885B0;
	Wed, 11 Sep 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061561; cv=none; b=E/mhRdQrEW9/aTvWZZn7h6U3XQJJ05xrH454epBbXoR1Prv3XR3GJfmiRKW7vdr2oyxg8leYVEti24qPi9JPMP0mUydggc5JIxFDVUyptp0hRur+p3CoHUMYWLdVzQxnzK+x2rPejdaA9VnxHhSUam+1WKNoBdlXmUeNPtbxGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061561; c=relaxed/simple;
	bh=ybheBVV603FTYOdWMtIr5GfQRMd5Q2wUV16BArMqNVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG7KU2r7IRATJdlT9PBUxFxkzjhcq9KZB+vKCUcB/6g7nD5or9DNUSKVGjQIfGCJN21KeYA3ertMcLWIEj9Fbbzr2QAWRVq5m2GVlfsdHUo2Y5wzj7aan7sRxAuTmhoT04+Xu/Es+PSUjSNi3bK8wNI4rGTe0SJubL8sdhwg0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cJl6WIRo; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726061557; x=1726320757;
	bh=Aw/QVQINynoS1n4l+50LTXZgDbgxxENr3OB8jCOzqlE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cJl6WIRoFO3p9/rUyKgmNd+yxgh0Ra24LWdX7Iq1RoxrJKhtGh7FtmdBPiJ1l4p15
	 4a1LY9h6sXrGzdpiX+eTUdvsKQEQAvYJVhY9Hr/V7jQc/uTy5kP8jNoccNcpfL185t
	 TOKBF6V78gsXPX3amf/PEATMLRYwKu6NehM5ftEy9c7vR8Cy00K1VBiYe+ZRcrhZLq
	 QVQOZ56w9hiIIMbkIJLr50QsadIWEq4hAqx97SE1iPoZLOumDNaeEuE8gDPxIA03Xc
	 qkIPuy1gXKB42GugN0L9UwSVAhFk8En+0dLvoJv9mw9kt5RnxFwkZ1oZsiXIoleCRm
	 NW3Lk+lzIGxEA==
Date: Wed, 11 Sep 2024 13:32:31 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <bf158e23-4123-419b-a2ce-a27c4ea51219@proton.me>
In-Reply-To: <ZuGNlFluwAmTG19R@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-23-dakr@kernel.org> <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me> <ZtD1TsGm0swi7gyv@pollux.localdomain> <ZuGNlFluwAmTG19R@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 90b55a6673420a147a5498f65a28e7d0f52158e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 14:31, Danilo Krummrich wrote:
> On Fri, Aug 30, 2024 at 12:25:27AM +0200, Danilo Krummrich wrote:
>> On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
>>> On 16.08.24 02:11, Danilo Krummrich wrote:
>>>> +
>>>> +        if layout.size() =3D=3D 0 {
>>>> +            // SAFETY: `src` has been created by `Self::alloc_store_d=
ata`.
>>>
>>> This is not true, consider:
>>>
>>>     let ptr =3D alloc(size =3D 0);
>>>     free(ptr)
>>>
>>> Alloc will return a dangling pointer due to the first if statement and
>>> then this function will pass it to `free_read_data`, even though it
>>> wasn't created by `alloc_store_data`.
>>> This isn't forbidden by the `Allocator` trait function's safety
>>> requirements.
>>>
>>>> +            unsafe { Self::free_read_data(src) };
>>>> +
>>>> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling=
(), 0));
>>>> +        }
>>>> +
>>>> +        let dst =3D Self::alloc(layout, flags)?;
>>>> +
>>>> +        // SAFETY: `src` has been created by `Self::alloc_store_data`=
.
>>>> +        let data =3D unsafe { Self::data(src) };
>>>
>>> Same issue here, if the allocation passed in is zero size. I think you
>>> have no other choice than to allocate even for zero size requests...
>>> Otherwise how would you know that they are zero-sized.
>>
>> Good catch - gonna fix it.
>=20
> Almost got me. :) I think the code is fine, callers are not allowed to pa=
ss
> pointers to `realloc` and `free`, which haven't been allocated with the s=
ame
> corresponding allocator or are dangling.

But what about the example above (ie the `alloc(size =3D 0)` and then
`free`)? I guess this all depends on how one interprets the term
"existing, valid memory allocation". To me that describes anything an
`Allocator` returns via `alloc` and `realloc`, including zero-sized
allocations.
But if you argue that those are not valid allocations from that
allocator, then that is not properly documented in the safety
requirements of `Allocator`.=20

---
Cheers,
Benno


