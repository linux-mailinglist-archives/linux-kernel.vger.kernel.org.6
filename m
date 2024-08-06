Return-Path: <linux-kernel+bounces-276381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F489492B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056971C215E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7917ADE3;
	Tue,  6 Aug 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Nw93WDo7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957818D635
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953499; cv=none; b=mLvTF9ti0qkuZKSYve7I349TNV52J6znhQFoZ1rnCqYC49rLsKP1zn2+QJy7TdbXw8LP1e7dcUafxNzLXZY53yrEoqNIvmPSf9iBmQmb8SBx/8nEJmHReD8POvKV/A5wE5vBHcUUZHpjyrXV+FwqdtipGjeyZHadxzFD9wQ+dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953499; c=relaxed/simple;
	bh=epdSBWYsFtSGCN/sAFMpeTs3Vq1++V7uVSBtRlfKs/U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWUO9XCKmGuP/G4KDF8qPs6T+SM8IORTIWTFTjhwCsngJiBURYDTQmJB2Ip6acXrHxefyLU9BBb7DMnrs1k7szYBZqVqF57EW3IY/ZUN8FZ7xpdBY8xIA20Mbzo5O0ezRkiXqiQsmrB/aLuVW+UTx7yisGt/iM6EebjBt4hCTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Nw93WDo7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722953496; x=1723212696;
	bh=Wn9ajIuhXlmQGQC4Z3aaXlblA2FS/BHrUmpEPNRSJMs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Nw93WDo7bbs2e0F/WSGYDF7vlAbvzoxpQrtLpUY7cEAHTu0mUoY3NB4dTjVip0nY9
	 fk4C/qNULelaYbwrVxhMcUgXmZ+QphpvFaNyuDeVdlAjhcOwVBHsph6G/ec8ROaWzX
	 TKvzVN10DeMem7SvnhMfgQMZDFvXr76Yx6q7I1nL5B2BFHSc8QojgABmOwXnl0Qejb
	 ImFnsSVszODD42P0LCOF8bFRQ5zJSTB5fx6Pl7FJYqCJBgP8LZnHfnjEN6q8n6Su4o
	 bavLa7BYDIIFjM9leM2sHpboP6NOVb9EnU68L+trMOd11v0fY7X4xV9e22RfUcONiC
	 4G/cfzKe1gYGA==
Date: Tue, 06 Aug 2024 14:11:30 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 02/10] rust: list: add ListArc
Message-ID: <62158f09-2882-475e-9df5-6d5f26d788ff@proton.me>
In-Reply-To: <CAH5fLgj3VNyw054Bw9OrPp3QLKTv+k8+_LWCdQTuCPxV2Vg6Rw@mail.gmail.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-2-89db92c7dbf4@google.com> <037f16f4-e959-4801-90b2-aafb7afcfdb6@proton.me> <CAH5fLgj3VNyw054Bw9OrPp3QLKTv+k8+_LWCdQTuCPxV2Vg6Rw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fe7f3057b63d16835113d52422aaecd277e99b60
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:16, Alice Ryhl wrote:
> On Wed, Jul 31, 2024 at 6:47=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On 23.07.24 10:22, Alice Ryhl wrote:
>>> +        // INVARIANT: By the safety requirements, the invariants on `L=
istArc` are satisfied.
>>> +        Self { arc }
>>> +    }
>>> +
>>> +    /// Transmutes a `ListArc` into an [`Arc`] without updating the tr=
acking inside `T`.
>>> +    ///
>>> +    /// After this call, the tracking inside `T` will still think that=
 there is a `ListArc`
>>> +    /// reference.
>>> +    #[inline]
>>> +    fn transmute_to_arc(self) -> Arc<T> {
>>
>> Maybe also change this then to be consistent, since the name `transmute`
>> carries a "dangerous" feel to it, but this is actually totally safe.
>=20
> I want it to carry a dangerous feel! Yes, it's safe to leak the
> ListArc, but you don't want people to think it's a generic ListArc ->
> Arc conversion function.

For me `to_arc_unchecked` would also "feel" dangerous, transmute is just
more dangerous :)
Since this is not public I don't mind keeping `transmute`, I just find
it a bit strange.

---
Cheers,
Benno


