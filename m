Return-Path: <linux-kernel+bounces-276498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC094949A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328701F24F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD72772A;
	Tue,  6 Aug 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N4MeJLaT"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCCA1799B;
	Tue,  6 Aug 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958224; cv=none; b=dLcEPJE5afezhIWEPpzP7wwezRgP6MBjioq/ppsZf3EDBcLUtbVjocMkqzOpy8yEfIkbfYG9s25fOiQZwcsd5jFPeFiTdurCx/agKTDfpxpXnH6UhQL0YVbTRLJSC+p/ci5YXa6gOE7Uzu340rfbyT9GFHwNxQTLULoHuy9cgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958224; c=relaxed/simple;
	bh=9KwZswKDHSIqfb4IDWjdzBRMnavvpdhiXgph8Fg3pCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqSZyGCZVKt/WwZ+pQ0VCRqREqK7ShplweXdRcblCh2M/luiHJ4a9/Mub90mpKg404ppmJmMYhmiaX/gAl3wogBWKM7tiqyARX62DCUivkTW0m2wy2pQfJJzVnkrOQv3eraFT73KtFpIzbD4AWZWOTTg3Ug7LZMJYDeLlz7xVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N4MeJLaT; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722958219; x=1723217419;
	bh=TLvjKfVcTW42AfLMplbt4phBgcShf3YGxSw6QEFTr+c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N4MeJLaT2MBPlIodq90OkS0XpTphmBm6kzfGYi00tJu8SweulBHvWbjOOTYK+ZR7k
	 BJjugxDXsqCC4Q8s34iXruuOagw65XmC/RycGEN4Dvb8DWpctLHp+wridF3YkzM/s3
	 x/Hqwr+FkS0WqZFakr7JKkQvjgy3qE99FVEVp60D+yY5BcO9ztO0pvMB5o6MWksJ+z
	 vtg3gUfHxCX6yjZVBDhZ6/c2/dYuqyvEUQXrJ2M44A6aeYJscV9D+3L7JAi5DvQ/Qx
	 JeX+QcvmEqQAhDwBVF1jLEEdUUsWpK6zujW2mcDlagjQIMTQXSOxxDeFtHmz50Skg0
	 E6ReyKWn7CXYQ==
Date: Tue, 06 Aug 2024 14:30:22 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 03/10] rust: list: add tracking for ListArc
Message-ID: <99a469db-da0a-47fe-a69e-38aafebb6d24@proton.me>
In-Reply-To: <20240806-linked-list-v4-3-23efc510ec92@google.com>
References: <20240806-linked-list-v4-0-23efc510ec92@google.com> <20240806-linked-list-v4-3-23efc510ec92@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bf90d319c4fe775410ff47f6f89e37362e127176
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:58, Alice Ryhl wrote:
> Add the ability to track whether a ListArc exists for a given value,
> allowing for the creation of ListArcs without going through UniqueArc.
>=20
> The `impl_list_arc_safe!` macro is extended with a `tracked_by` strategy
> that defers the tracking of ListArcs to a field of the struct.
> Additionally, the AtomicListArcTracker type is introduced, which can
> track whether a ListArc exists using an atomic. By deferring the
> tracking to a field of type AtomicListArcTracker, structs gain the
> ability to create ListArcs without going through a UniqueArc.
>=20
> Rust Binder uses this for some objects where we want to be able to
> insert them into a linked list at any time. Using the
> AtomicListArcTracker, we are able to check whether an item is already in
> the list, and if not, we can create a `ListArc` and push it.
>=20
> The macro has the ability to defer the tracking of ListArcs to a field,
> using whatever strategy that field has. Since we don't add any
> strategies other than AtomicListArcTracker, another similar option would
> be to hard-code that the field should be an AtomicListArcTracker.
> However, Rust Binder has a case where the AtomicListArcTracker is not
> stored directly in the struct, but in a sub-struct. Furthermore, the
> outer struct is generic:
>=20
> struct Wrapper<T: ?Sized> {
>     links: ListLinks,
>     inner: T,
> }
>=20
> Here, the Wrapper struct implements ListArcSafe with `tracked_by inner`,
> and then the various types used with `inner` also uses the macro to
> implement ListArcSafe. Some of them use the untracked strategy, and some
> of them use tracked_by with an AtomicListArcTracker. This way, Wrapper
> just inherits whichever choice `inner` has made.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs     |   2 +-
>  rust/kernel/list/arc.rs | 171 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 170 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


