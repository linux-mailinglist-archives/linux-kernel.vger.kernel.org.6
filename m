Return-Path: <linux-kernel+bounces-569685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F6A6A61D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA71188CD54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60864221D8F;
	Thu, 20 Mar 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BFI6bOJU"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFD1C5F18;
	Thu, 20 Mar 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473013; cv=none; b=F+Aa9a9mgoYkjDI+1gkV4/0SZddycjj9WBiuAwiG9HDM5b8lCc4C6K2imS6GlEzxMOEiTYgZNJSE2Ya/aAGgyoRfmPPcMqpxS+7r417dRq/WqJSBwX/u3fGEeC1+4RUKrwavu696QdOrwHg2KfVVE2AO11CU96/d/U4cmgcEnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473013; c=relaxed/simple;
	bh=ZvuqjknG7yAxkL1CzWawxgQk1+VvmW9sjcfknkdESO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBbAJ5evIFSQiZLr6lmGMLDt71/9TJXtlXz/ZGfKGjftSaBrTw8Ab1E1ptWq1gyTAqX50HFXKjjnvfL81k01Q8Ap1WLs2c3grHqxRFr+Nz5msLIw80K4gekQZK6MtH8FARM1+LQ51ab4cB8WiWH1uGEQzzdxNXRIFx0n4sVdYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BFI6bOJU; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742473002; x=1742732202;
	bh=MFgPk8/BSkbocZYmBFnZkvxSg25u6ztS27j5I4vVS8o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BFI6bOJUrmKJIPfkOnUeuQV56wXkX8mBA8nxP5uiUR1n75jIqR0+tlbu1IvVv1ycH
	 sGgSxOa3C9vntEmQAQZrZjvq/4t2biiRWa7HACPXkgmR/1xL67lxFZUqYFeOFX9uxQ
	 PQwoN7nF4KlIl9fVeELORvFOAjmlfXaDlItO34luvl3WL/bxfr1aJQluo3cVcAMAYF
	 wH0G07TL7OK3Zgze9oQaVxp4qsf0tZMRftJc2yt6xi6L8SsGFYFzTRkjI1qlRhC8TL
	 mVVD0mcBhmHOqGWLutVv/r29Cf5XFXdRPwOvqeW12z/jNskSzUee006sD2ePt4CJ0j
	 kSslT6Hr8dgRQ==
Date: Thu, 20 Mar 2025 12:16:36 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
Message-ID: <D8L34IUZGXWX.D2LSS2S2NAN7@proton.me>
In-Reply-To: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dca386c56fc7854e653ff3cd7336d87160bda96c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:35 AM CET, Tamir Duberstein wrote:
> Replace the `#[path]` attribute with a symlink to work around a
> limitation in rust-analyzer that requires all modules to belong to the
> same "source root". This allows code navigation from `pin_init_internal`
> to `quote` to work properly.
>
> Link: https://github.com/rust-lang/rust-analyzer/issues/3898
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/pin-init/internal/src/lib.rs   | 1 -
>  rust/pin-init/internal/src/quote.rs | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/s=
rc/lib.rs
> index babe5e878550..fdd95afe3864 100644
> --- a/rust/pin-init/internal/src/lib.rs
> +++ b/rust/pin-init/internal/src/lib.rs
> @@ -20,7 +20,6 @@
>  use proc_macro::TokenStream;
> =20
>  #[cfg(kernel)]
> -#[path =3D "../../../macros/quote.rs"]
>  #[macro_use]
>  mod quote;
>  #[cfg(not(kernel))]
> diff --git a/rust/pin-init/internal/src/quote.rs b/rust/pin-init/internal=
/src/quote.rs
> new file mode 120000
> index 000000000000..27a213d1a6ba
> --- /dev/null
> +++ b/rust/pin-init/internal/src/quote.rs
> @@ -0,0 +1 @@
> +../../../macros/quote.rs
> \ No newline at end of file
>
> ---
> base-commit: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> change-id: 20250319-pin-init-internal-quote-b7e15e9e8233
>
> Best regards,

I'd rather not have this change, since this will introduce a dangling
symlink upstream [1].

[1]: https://github.com/rust-for-Linux/pin-init

---
Cheers,
Benno


