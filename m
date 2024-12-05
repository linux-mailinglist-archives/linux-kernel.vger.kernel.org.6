Return-Path: <linux-kernel+bounces-432614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674489E4DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4734B162F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781319A2B0;
	Thu,  5 Dec 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="ilzxkfe0"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBBC17C208;
	Thu,  5 Dec 2024 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381394; cv=none; b=pXvLiL9j140eFEP4eb7ZutkzOzyRqcHsvNySrPfDa6/wdz487lvzyZnzxxJiw2IDWOL05btk+kgITzXtYoOPfFbtyyC5Z38vxhOgEHN4kM4n3QBfL+GcyCV5qTEzACDxKo6q3gEJ8x3cECZ9c9hUhm5mZywXW3eLHtWo25h3V68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381394; c=relaxed/simple;
	bh=/KEzlMk4IU5eGuWjmmLymhjUh2JFoOGWscJv77GKBAw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PGnjFl3+gq8aU5scEYWU3AzHgR5fXHqPtri8N9o+3+RA5k4ejkYUw3eO8W+2uuIJnkIUsfyDdxXymI+OyNEXuW1RMbJxItqvqvCimTk3mWBwu01lar488CgKXG55rpSM7oOSmFa/jEtyVKJWSWO7EjWZ45PvR1tlYoirhFgNpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=ilzxkfe0; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id A475F42F2D3F;
	Thu,  5 Dec 2024 07:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733381390;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=/KEzlMk4IU5eGuWjmmLymhjUh2JFoOGWscJv77GKBAw=;
	b=ilzxkfe0mxcmrl2aUq1FJ1/LWFfhNdUXbDkFD70uq/+O0x8WnyIN68c++H3up5uk
	E8GAIMq78HAe+ukA3lbzK+PBoNZ7ewidhfaLI7fh16osUkkmy3/Z6ubVwHD8rh+XO4D
	+8E79O13B7Pre6+cPFDlmn4LmCEsDEl7jTl6bKWNFHu3jyxYipKZlJtdHLWzWiizdks
	wLn/QdhM+t2g+GRgmvCP5Nuh/fuH6nw0LVo5OdoTKrnOvkAO+MEpkXzLy5MiTx/qeGZ
	Sm344FFadr9RfJJUmkk1X0USBK4QHFiZVsM8n1edP6p2oP1fS6CHvmm/DgbQa1DeiOj
	mO4FNWPl6Q==
Date: Thu, 5 Dec 2024 07:49:50 +0100 (CET)
From: jens.korinth@tuta.io
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <ODK_F29--F-9@tuta.io>
In-Reply-To: <CAH5fLgj2qHjYj=heYi55qWz7=LxyHeUPyhbgVe0QLjzH0S34bw@mail.gmail.com>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io> <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com> <OCjFF0---F-9@tuta.io> <CAH5fLgj2qHjYj=heYi55qWz7=LxyHeUPyhbgVe0QLjzH0S34bw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm afraid you lost me. You wrote:

> Using a Once type for this seems like a good idea to me.

and

> One advantage of using a Once type is that we can use core::sync::atomic
> until we have working LKMM atomics and then we just swap out the Once
> type without having to modify the warn_once abstractions.

That made sense to me, so I started in this direction. `std::sync::Once`
has `is_completed` [1], which made particular sense to implement in my
mind to increase the utility of `OnceLite`.

[1]: https://doc.rust-lang.org/std/sync/struct.Once.html#method.is_complete=
d

> The purpose is to use this for printing once, and printing doesn't need
> `is_completed`. We can have another helper for other purposes.

Why have `OnceLite` then at all, instead of the hidden Rust macro that was
proposed initially?=C2=A0

Jens

