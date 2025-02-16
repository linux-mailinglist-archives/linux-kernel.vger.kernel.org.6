Return-Path: <linux-kernel+bounces-516566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF31A37417
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0F18913D1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9E118E351;
	Sun, 16 Feb 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LpVGCd9n"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D01758B;
	Sun, 16 Feb 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739708285; cv=none; b=jImhMoSF/jCyvyGZ6G3URdSY1HX7svBszemqtrH1P7Vf5UncishcSH4iJpfBah1c5QG4MIS2lM02kQbs9JmnA3Uf3z0O2Ned3uXj9eX0xLqQlpNWt90bOI7RXNcg/iIp1Awjy43c/LB266Cad2p3z/gxH+qKyg8CEQR7OI0g8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739708285; c=relaxed/simple;
	bh=wvY2DcCPZ25/Vt0hvWxQl7zoSVOoK8EChyJ1dvXABMU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZnVrCPDPBjGvgiDrbM6ddh8TSOebBzU0zTw/BrrnugzpDPDKMrfCuoTGKZgtS+OmEazZq86zPqMjHmjxQJ7D9F0AXHlRXH7wWMlbcsVszjQvybjNE6NXxVzXgveAY4qyYXjw4T0XVw71YjtsPs/jRwhk6yXpl96SWTgJtJWgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LpVGCd9n; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dlnwgd7xtrdr7p5gw3bsenad6a.protonmail; t=1739708274; x=1739967474;
	bh=rG/s99JWc6anEYh4vsWNfFJpXnVNfqyCI+3kc8cpkA0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LpVGCd9nFeikKgMb6I4ajHqRnZpr6LBDQlLTOg500PZrPmh94pNUFPoQ5soRN5dZD
	 Oy/i//usgAEkVMYsyxfX2Pp3i068CThVSFyfX47L6YdPpPXvlWEPhxlbGRXgnnA+DG
	 LVIbtHOwjpc+GFUoZYhOAZmPDydCJt2vUAfUTV+dW5fBaaU8I8O5nptE+nDwzTmlnC
	 6pKX3MjpVB2ZFmI8nHL+BovpsCVkfVyyaimYAj7SrD9iSfJyou6sZRQAj52jJzj9G8
	 yNa4NfoY5YO/CUyNHpOaKujUtSuq5v4V1S1Jy51l0Y5iv4qLZMhfR2t/jKE0ZXqv4g
	 wTwWMDJoWy6Fw==
Date: Sun, 16 Feb 2025 12:17:49 +0000
To: Charalampos Mitrodimas <charmitro@posteo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
Message-ID: <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
In-Reply-To: <m21pvy927w.fsf@posteo.net>
References: <20250215223106.2346285-1-benno.lossin@proton.me> <m21pvy927w.fsf@posteo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a04d14d4d8c45140406d799145d620c701914e55
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.02.25 01:12, Charalampos Mitrodimas wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> When running `make LLVM=3D1 CLIPPY=3D1` on my machine, I get this error:
>>
>>     error: first doc comment paragraph is too long
>>       --> rust/kernel/driver.rs:13:1
>>        |
>>     13 | / /// The [`RegistrationOps`] trait serves as generic interface=
 for subsystems (e.g., PCI, Platform,
>>     14 | | /// Amba, etc.) to provide the corresponding subsystem specif=
ic implementation to register /
>>     15 | | /// unregister a driver of the particular type (`RegType`).
>>     16 | | ///
>>     17 | | /// For instance, the PCI subsystem would set `RegType` to `b=
indings::pci_driver` and call
>>        | |_
>>        |
>>        =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#too_long_first_doc_paragraph
>>        =3D note: `-D clippy::too-long-first-doc-paragraph` implied by `-=
D warnings`
>>        =3D help: to override `-D warnings` add `#[allow(clippy::too_long=
_first_doc_paragraph)]`
>>
>> Thus add a short one-line description.
>>
>> Fixes: ea7e18289f44 ("rust: implement generic driver registration")
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>> The error also occurs in v6.14-rc1, so it must have slipped through our
>> testing, which I find a bit strange. Also nobody reported it for rc1, so
>> maybe this is only something that I encountered?
>> ---
>>  rust/kernel/driver.rs | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
>> index 2a16d5e64e6c..65c9c1776556 100644
>> --- a/rust/kernel/driver.rs
>> +++ b/rust/kernel/driver.rs
>> @@ -10,6 +10,8 @@
>>  use core::pin::Pin;
>>  use macros::{pin_data, pinned_drop};
>>
>> +/// Generic interface for subsystem driver registrations.
>> +///
>>  /// The [`RegistrationOps`] trait serves as generic interface for subsy=
stems (e.g., PCI, Platform,
>>  /// Amba, etc.) to provide the corresponding subsystem specific impleme=
ntation to register /
>>  /// unregister a driver of the particular type (`RegType`).
>>
>> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
>=20
> Hi,
>=20
> I cannot reproduce this as-is, but adding
> "-Wclippy::too_long_first_doc_paragraph" to the "rust_common_flags" in
> the Makefile reproduces it. Maybe try adding it there in your patch?

I have done some more digging and bisected my Rust version. It turns out
I was on a rather old nightly from last September. I also don't get the
error on a newer compiler version. My bisection identified that the
error last occurs in nightly 2024-10-18, so from 2024-10-19 onwards it
compiles without the error.
So probably `-Wclippy::all` implied the `too_long_first_doc_paragraph`
lint in that version. That is probably because of [1]. It changes the
lint from style to nursery.

[1]: https://github.com/rust-lang/rust-clippy/pull/13551

So we don't need this patch, as it seems this never hit stable. However,
there is already a patch fixing what this lint reports: 2f390cc58943
("rust: provide proper code documentation titles").

I think it's a good lint, so maybe we should turn it on?

---
Cheers,
Benno

>=20
> diff --git a/Makefile b/Makefile
> index 89628e354..e1b14fb68 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -486,6 +486,7 @@ export rust_common_flags :=3D --edition=3D2021 \
>  =09=09=09    -Wclippy::undocumented_unsafe_blocks \
>  =09=09=09    -Wclippy::unnecessary_safety_comment \
>  =09=09=09    -Wclippy::unnecessary_safety_doc \
> +=09=09=09    -Wclippy::too_long_first_doc_paragraph \
>  =09=09=09    -Wrustdoc::missing_crate_level_docs \
>  =09=09=09    -Wrustdoc::unescaped_backticks
>=20


