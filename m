Return-Path: <linux-kernel+bounces-271507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB336944F33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FA21F26769
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8B1A4F30;
	Thu,  1 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="id/m5uFl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C19F48D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526173; cv=none; b=coK6HJa540qKELDdtjTPeJIheP6rjTgjqBOFR3HAdZmh6wAoguALIOgH6HwxLneT64rapr+fNbaOWSGYvSscNFOhJKqrwuuuKFjCNAiE+4WnZ+QpvnQ5CaSZLA6YaIt5FhpY05oNUQDJRCF3Q6SyokhfX+GBdyWtjo7kFaGNfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526173; c=relaxed/simple;
	bh=HCOnPqaXJWD5QUVRR2HlizPpmXk4B0IZp//1F4LRrEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjPJKQKD64Wr01CmFML2AKDJnFCqp3yvfYfLalcNVKotWMib4zF2Y2vEckH8Y+RmzBF9YH7QPOQWpAYXkZ/zFci3FYhxBxYANc53EzfqQtJ2D15rw7du2qcqSPeK7mR+5zpYczdWZc9vgB5m6I9NXUUKd51lBFafCHzhhrUxyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=id/m5uFl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722526169; x=1722785369;
	bh=HCOnPqaXJWD5QUVRR2HlizPpmXk4B0IZp//1F4LRrEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=id/m5uFlPUW/5b4qXUPL3jqUvhlDA1dFqyEHKZkgiVw32HfZ0icpiK4lCnLZyq9tA
	 mGmnrzVzkvsjJr6pXiSDIujeXxZ7IiPkcEuRm9csm+OofirV1t/BaOjryYebTuxkM9
	 t0E908OaTvZV9SOknG6xCMy+XGivrSQmST2sNpsjkCe9hDRQWBmTB8P+LzL3eCMwq8
	 /ztstmxvSLG9M/3Qg1YUw9RS/RzuMNWgIt9t//EVxdfVIhfaQcx4wefCCKOrX3XfHO
	 iCScpmrUN9FNFfg2Pz08HRwZ9e9FPO7M267T0l1S3OjdCvGKIBOMo/yzk9w1aJvGzV
	 FQKmk3CF45qqg==
Date: Thu, 01 Aug 2024 15:29:15 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <79ce2394-25af-469f-88f1-5de31b9f48f6@proton.me>
In-Reply-To: <CAH5fLgi__fgLnifj3ON9iNyugnUzm82VWWduO3Ds6Hz54H1ZWQ@mail.gmail.com>
References: <20240801-vma-v3-1-db6c1c0afda9@google.com> <82e4816c-cada-46f3-bebf-882ae8ded118@proton.me> <CAH5fLgi__fgLnifj3ON9iNyugnUzm82VWWduO3Ds6Hz54H1ZWQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1f9acde3ca9b22fbb275d5a0943a3b4977e57bd5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 16:37, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 4:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 01.08.24 14:58, Alice Ryhl wrote:
>>> +/// A wrapper for the kernel's `struct mm_struct`.
>>> +///
>>> +/// This type is identical to `MmWithUser` except that it uses `mmput_=
async` when dropping a
>>> +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>=
` is safe to call in atomic
>>> +/// context.
>>
>> Missing Invariants.
>=20
> Hmm. Structs will inherit invariants from their fields, no?

No, usually the fields handle their invariants on their own, eg NonNull
can only be constructed if the pointer is not null. But Refcounted
structs are somewhat special in this regard, since you cannot construct
them by-value. Thus if you build a new struct that contains them, then
that also needs to be refcounted and have its own invariant to guarantee
that the field still is refcounted.

---
Cheers,
Benno


