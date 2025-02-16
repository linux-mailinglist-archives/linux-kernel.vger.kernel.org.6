Return-Path: <linux-kernel+bounces-516603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AEA3748D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB5C7A3699
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E090192B9D;
	Sun, 16 Feb 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WGPMJf1e"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449918DB08
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739712637; cv=none; b=h1CS+NjIoHgk6Ljx8LdSsfJsxjCmvkxPKN5iU4lCu8HFChIL5btQe5klSwXYUEn0yaIJXmGOIALb9AfF2tpVYaeJLQ4sSv0BNAjI9LHmkL6pKnB2FkNV7Z/vq0ABaR2KbZge3w890YZAVjQtGKCY6ntQKIAk1ll0YY/dERk2yqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739712637; c=relaxed/simple;
	bh=M3Fgli14JlCJs5eqzyoYg+4kju/5yYUjMV00kDWAkH4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnG+xrtMQmeAcuUYSLEvJ4ePMUSNzU7tapQ7PGQmVN1ilxQZsbuhM1tYDGGKU9+eSJ+vuJr1algGUUhuD0OAzzua47TKqgbFLZMNUXq83ggXBNvRAcwvXUf5bLxTW9w8f0Tryz5RQ3EYGGdgf7Ffzz4z8VYyZK4zVBtSOusVOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WGPMJf1e; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=acymz7xonff2xkvpqhdhftspy4.protonmail; t=1739712626; x=1739971826;
	bh=M3Fgli14JlCJs5eqzyoYg+4kju/5yYUjMV00kDWAkH4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=WGPMJf1eXCkYn2nNaPX9Myvgbf0hX1tWuvQ6qQx3SnlN1f6A3GVaYJj/XC/YNPtQb
	 2tJuCs/BZfNC7lCs9lEl4zQK6Az9yxtwD95C4ODpiB0enJnHZRbwcLO1NKER3tThjw
	 zkWQH5ZjT+ijoUF+xrzJgI1i8i5eZS2hZaAGXHLZ3bbhZOruFiKm0LorHWoWkB7+I/
	 vE0OER/iGREZ8s/2U3RpMOHAhAe+MZCp5ckjr5r5nvndl772BC1aGit2r4bMgJWPz0
	 zSNLbq0LBvcnZC9zVl2piUrqm2UiRPu+izNjjggFgEmoXTiixvjuxHV9x6BzVORE77
	 Ekrif1D2gn6PQ==
Date: Sun, 16 Feb 2025 13:30:21 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
Message-ID: <10c0a50e-14de-4da3-a592-dc65753cec1b@proton.me>
In-Reply-To: <CANiq72myMWv87Me2C6Nmse-p=4YL=J+ZTEHe2hu7AhbpfZhgyw@mail.gmail.com>
References: <20250215223106.2346285-1-benno.lossin@proton.me> <m21pvy927w.fsf@posteo.net> <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me> <CANiq72myMWv87Me2C6Nmse-p=4YL=J+ZTEHe2hu7AhbpfZhgyw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c4662db2bf6c4829825f058e06453e0b1f3576c3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.02.25 13:40, Miguel Ojeda wrote:
> On Sun, Feb 16, 2025 at 1:18=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> I have done some more digging and bisected my Rust version. It turns out
>> I was on a rather old nightly from last September. I also don't get the
>> error on a newer compiler version. My bisection identified that the
>> error last occurs in nightly 2024-10-18, so from 2024-10-19 onwards it
>> compiles without the error.
>=20
> Thanks Benno, that is very useful and saved me some work.

My pleasure :)

>> So probably `-Wclippy::all` implied the `too_long_first_doc_paragraph`
>> lint in that version. That is probably because of [1]. It changes the
>> lint from style to nursery.
>>
>> [1]: https://github.com/rust-lang/rust-clippy/pull/13551
>=20
> Yeah, sometimes that happens when working regularly with nightly over tim=
e.
>=20
> There is an upside, trying to look at it positively, which is that it
> gives us something to look into from time to time (i.e. the new lint)
> and give feedback, and sometimes we can clean it up anyway, even if
> the lint is broken and we cannot enable it just yet :)

Yeah that is true.

>> So we don't need this patch, as it seems this never hit stable. However,
>> there is already a patch fixing what this lint reports: 2f390cc58943
>> ("rust: provide proper code documentation titles").
>>
>> I think it's a good lint, so maybe we should turn it on?
>=20
> Agreed, we should -- it is something we tell people from time to time
> to fix in review, so hopefully it will make patches better before the
> review phase.
>=20
> ...well, assuming it works well enough, given it was moved to nursery,
> e.g. in the linked Zulip thread in your link above they point to
> https://github.com/rust-lang/rust-clippy/issues/13315 and

I don't think that this one is bad. Of course it would be nice if only
the rendered form would be considered, but there might also be people
reading it directly in the code, so it could actually be a good idea to
also keep the raw text short.
In the case of long links, one can easily work around it by just not
using an inline link. (so having [text with link] and then after the
paragraph `[text with link]: link`.)

> https://github.com/rust-lang/rust-clippy/issues/13538, which we may or
> may not care about.

This one just seems like a nice-to-have, but not a deal breaker.

IMO we can enable the lint (since the instance fixed in this patch is
the only error I get with that lint) and just see how it behaves.

---
Cheers,
Benno


