Return-Path: <linux-kernel+bounces-432610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AED9E4DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07DF168E25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97119645D;
	Thu,  5 Dec 2024 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="sMDuR0s5"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65E391;
	Thu,  5 Dec 2024 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380631; cv=none; b=esE6KRvJ+/KCGBIs/9F20YSGCZDbU6jlbmVFCAhZ9nNWQhkkdNJDGZ23fr+V0ZeFsGQmltCYhYfQnEKh+qvP7vZCOzav1GKM0oieS4NiK+7YZHDiyLkfZ2E2pTUi/rtvCC+V9cxaEaxrpaXie6wPZ6AEtlZOEnnV6+urcnTVwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380631; c=relaxed/simple;
	bh=DBRaBwC0qfIVOFBwDu7E8RPRvWxjPlnglRMlshS4CL8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GQ2fkBhNCaglQtevaehaAQxnuaJWkaeMMTIV18zdUYBrrmAEtydi1VQaK0+0BmBdmIPQxQsbXEGLkyiZmDjgO/6AhqSM474GAfNUbnKSVDQ/q7hnJFCF5jhzR2M3zwsbpe+WM6KZ6uGrNlEDM975NcN63swpO5FhkHOOqQDcUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=sMDuR0s5; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 0E5D942F1BE5;
	Thu,  5 Dec 2024 07:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733380221;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=DBRaBwC0qfIVOFBwDu7E8RPRvWxjPlnglRMlshS4CL8=;
	b=sMDuR0s5fGzqmBsK57IDUHI8BSZslLgde+wjeNOy1BlwlaMytl4+BQlqotBCaMQu
	hOCPY9A4tnTm7bgKefFxMSiTyzKQn7z5UUeeWm5Xnd76gK2NyKzpjHait94f1x9Dmb8
	Ilz2ArxgwWeLim9ARVJBK5P7oHYa8k+pbQvFOozNPmsY+JANwmZ1PFL5BoEffqHK/xx
	+4a1NV02nlhyEWD51O5fvIwv18gWIJlQB83S4mT2qR1vW0zR8gc6/KlwuCuI2dgqbws
	LcriSSa6KSoYbSic0XBuUOs1mCZRo/CTM+BG/9z09SF/4s1p1SoWOH+Lk7UsF5JTOHH
	8Y/unkylrg==
Date: Thu, 5 Dec 2024 07:30:21 +0100 (CET)
From: jens.korinth@tuta.io
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rust For Linux <rust-for-linux@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <ODKVmiV--F-9@tuta.io>
In-Reply-To: <CANiq72=A9=uzSt9DOZBvw3sHwf4vqX2+6MBDKO5FokZUyt1V3A@mail.gmail.com>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io> <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io> <CANiq72m-dY0b7UiBiWOg8g1SFPqLxuhkDdWwNh8g8OBk-Tjz=w@mail.gmail.com> <OCjLJ1h--F-9@tuta.io> <CANiq72=A9=uzSt9DOZBvw3sHwf4vqX2+6MBDKO5FokZUyt1V3A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry for the late response, the usual madness at the end of the year is
setting in.

> Do you mean removing the function altogether? i.e. migrating all
> callers to `try_from_errno`?

I think it should be `TryFrom`. The `std::From` doc [1] says:

=C2=A0=C2=A0=C2=A0 Note: This trait must not fail. The From trait is intend=
ed for perfect
=C2=A0=C2=A0=C2=A0 conversions. If the conversion can fail or is not perfec=
t, use TryFrom.

[1]: https://doc.rust-lang.org/std/convert/trait.From.html

Jens

