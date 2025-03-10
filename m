Return-Path: <linux-kernel+bounces-553980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62344A5917A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AC188C112
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67EF226CF5;
	Mon, 10 Mar 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iaZXe8j8"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B316D9C2;
	Mon, 10 Mar 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603456; cv=none; b=WqbW0qNHvpdF+A+4sAx485r7xVlZY3aMAmPWANa7Q1+DPmKDUM6DMTs8q/WNHCfYRw9sKaAnjSN7eLasGm5g/kiGFQ9st/zqEVhU3Lon5fqKFBPl+h1J1IHb8pugMkln457amMhQlaoqFT4mGeTHbqMaV151OGODhj0jnItLuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603456; c=relaxed/simple;
	bh=4qHSKOga5mjVyUfSwBW+q4s1PCN2DyYcvcl/t+VgA4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dna4ur4fKJQDyM27efOeTc9JAqnGSZK/7H4xiGd4D79yA65+Qcbl56o/tBQvnsi6crKUDvwChQHTmzjBWqSWjLBydqUaE9DuLpySbBRtwkjO/V0mKi1Xpup7KmfyV8PWt+dibQFRmVBxC4l1kjDORZXnqvyavGJsnxAxPmrj7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iaZXe8j8; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741603452; x=1741862652;
	bh=4qHSKOga5mjVyUfSwBW+q4s1PCN2DyYcvcl/t+VgA4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iaZXe8j8+WeK2iSRmHAS7EXtOdepiIsmYFr2BXCSU4HtH7W3B1gbMV9GoyltufluU
	 HsMzUIh3x0B5Pt5kJvpKpqiILtOwWHECie5S7EC9UUvMFTc/XZ+s+cX6v475Sl+SJr
	 GYQmyQDNhlaGWjSLLRpjmBa3x5ixxFxIkhT4i7ScJ3SbWUQ4IRnBSH9rbHFVnvYA8d
	 uVKzm7rVPYevPw/+0iU/1qVLcppXU11eZAHAA0mHo8UmzOcmTcSE4+yK1x5C5T0pSp
	 tMzhrxjuWFDDynQXyhUA0akL2gi0g8qj4E0gT8sSEaXe4M2Xu9S258ba/8VaeyRdbl
	 nMxhT2HdJOx2w==
Date: Mon, 10 Mar 2025 10:44:06 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] rust: make Owned::into_raw() and Owned::from_raw() public
Message-ID: <Z87CcFyveuvmkQxw@mango>
In-Reply-To: <d9072bc5-7dc9-400f-8115-970887fafaa0@kernel.org>
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me> <20250310-unique-ref-v6-2-1ff53558617e@pm.me> <Z8618XEgG1yNvppk@google.com> <Z864IGPJ-v8Ttt51@mango> <d9072bc5-7dc9-400f-8115-970887fafaa0@kernel.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 048c9b95574551f30040f4c261ed51d2fdb8aaeb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250310 1132, Danilo Krummrich wrote:
> On 3/10/25 11:00 AM, Oliver Mangold wrote:
> > On 250310 0950, Alice Ryhl wrote:
> >> I would probably just fold this into the previous patch.
> >
> > That is okay with different authors? Just leave that authorship with
> > Asahi Lina, then, I assume?
>=20
> There is a 'Co-developed-by:' tag, please see [1].
>=20
> [1]
> https://docs.kernel.org/process/submitting-patches.html#developer-s-certi=
ficate-of-origin-1-1

Ah, okay. Thanks.

Best regards,

Oliver


