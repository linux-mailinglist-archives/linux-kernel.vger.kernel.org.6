Return-Path: <linux-kernel+bounces-315039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D356096BD08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F77B21C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BC1D9D8A;
	Wed,  4 Sep 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="T8GSrFev"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E391CF7DE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454304; cv=none; b=tlwI4UuSMGKwBfkTsegGp3RAh8cJk0Gme+MfW5YM0PEacdtzK1y7AaQWLGayItOgt5COZmsQ2wTKnn9vQg17Ywq9UYXq+aOlJ5Opa+KrUeyXLQWMwZqmbjne2BTHevuF04gx3eoLxhZfFoBTI//me/Cr1Ke1dsiTP6w5yKvSR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454304; c=relaxed/simple;
	bh=thxfD2kD1tOWBjtIAnVI6+Pvmvmfq8a7pP7fgnpw8bQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ071HOAcrGXOR634zI6H8cCisnkE/kbz4edRtIzs+rYMZ3Q7ly3m1kV7mF1anAcHtXHZDGRnFQeKmfXGwMT1pQA15gSGE/rWP1OHpu7XDg6c2MhAmrkqumubNZsj112+arGdjmYNSikGo8QghQjgnpNiDwl9IvhzRJmX7MbJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=T8GSrFev; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725454299; x=1725713499;
	bh=voz4VMO865umrIo+/xwbZzmtiW6/dsJIvL+hf3RV/9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T8GSrFeveBkMx/IfTb2YmowW1UtIDy7Bh9ETE+0RZPHduqnfemt60jvUO2FiNLpq5
	 1L5Z7CUAAtCiHC2asVY8y1jn0A/v+WBB9sTrgkgYZlarYwWsugJrpZ/Kpd+0UDkzpl
	 gthuoDPDojLMGZdocrFF6yRw+6vEQg7/2fVSjD1EBAGph3mn0a9E2CIb8tM8iUX8Eh
	 5OsSO76EPZ4MMxu2bHh4xsIR6PdnftjPDm8TkCIRUElb30CxUMQtB6yEGFZngZooWt
	 IGsXN3IVGh120TLCuCIEi6a5uc+Uh0hygJ30G0tpsmkcCYfjCOVXBEbw4+Cnjtas7o
	 Lt09Hcf0/UDXA==
Date: Wed, 04 Sep 2024 12:51:34 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Message-ID: <f99d8d3a-5b56-4555-a1fc-bd7685dcea40@proton.me>
In-Reply-To: <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-27-dakr@kernel.org> <20240831135712.0d7366b6.gary@garyguo.net> <Ztb6_XW3ccnHQDmw@pollux> <CAH5fLgjbnGstjzsudjavzt5+UwK_r8n8X3LPdw29QSkBzaygxQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f972371d54d6a12121c7fd4b03cdf10f90623e27
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.24 12:15, Alice Ryhl wrote:
> On Tue, Sep 3, 2024 at 2:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>
>> On Sat, Aug 31, 2024 at 01:57:12PM +0100, Gary Guo wrote:
>>> On Fri, 16 Aug 2024 02:11:08 +0200
>>> Danilo Krummrich <dakr@kernel.org> wrote:
>>>
>>>> Add maintainers entry for the Rust `alloc` module.
>>>>
>>>> Currently, this includes the `Allocator` API itself, `Allocator`
>>>> implementations, such as `Kmalloc` or `Vmalloc`, as well as the kernel=
's
>>>> implementation of the primary memory allocation data structures, `Box`
>>>> and `Vec`.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>> ---
>>>>  MAINTAINERS | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 42decde38320..560516b3aaf4 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -19925,6 +19925,13 @@ F: scripts/*rust*
>>>>  F: tools/testing/selftests/rust/
>>>>  K: \b(?i:rust)\b
>>>>
>>>> +RUST [ALLOC]
>>>> +M: Danilo Krummrich <dakr@kernel.org>
>>>> +L: rust-for-linux@vger.kernel.org
>>>> +S: Maintained
>>>> +F: rust/kernel/alloc.rs
>>>> +F: rust/kernel/alloc/
>>>
>>> It feels like we should use `mod.rs`.
>>
>> The same would be true for:
>>
>> - rust/kernel/sync.rs
>> - rust/kernel/net.rs
>> - rust/kernel/init.rs
>> - rust/kernel/fs.rs
>> - ...
>>
>> Do you propose to change it for all of them?
>=20
> I do actually think `mod.rs` is superior in general, but it's probably
> not worth changing it right now.

I forgot the reason for not using it, does anyone remember?

---
Cheers,
Benno


