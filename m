Return-Path: <linux-kernel+bounces-546541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AEFA4FBEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390033AAF39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66E2066CF;
	Wed,  5 Mar 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxx+8ERi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C568205ACB;
	Wed,  5 Mar 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170584; cv=none; b=Mhifcx89ZmLtXvpuu0lSwWlkvisZmh02EVWoaf6HyLkudnjnRohhuLs206L3Y9/hxWBt+Uy5hf5F2/ZXf7wz3LpP2yDpOHViU5n1yGy26EjIN4jJjiAJsrXdF3WNb4QKBi7hRgWUlrlyd+tF8rFlRTe5lCNGA4uqyhSpjDSMq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170584; c=relaxed/simple;
	bh=mnIJ3/kXGOV9yYEgNSUKTE3uzvCSYZEqqarrd3gQHkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8D+WCnpDjUGxKz5C0XuacM7rCd9CMfURjfLMxHMttV2iwCLDHKCNgTOBSnKasdMLBkmsTtEpqy8292Ndcz+ZcwvI44ZCgxV0YuJL/GvNyNoOVig48bLCKGBRv9j4OP6odncQM05nI+aDqU5iTMoO8A9LbkKjRKE9PWyM8hmzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxx+8ERi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B044C4CEE2;
	Wed,  5 Mar 2025 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741170583;
	bh=mnIJ3/kXGOV9yYEgNSUKTE3uzvCSYZEqqarrd3gQHkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mxx+8ERiSed0Epvc6XPD9WA5FtBXA94Ca0ZLzUUxy9j6zGjcLH2XTiW6g0Ec8Rfxa
	 qKqf2Qfn1g3W/Hb8y7D47Qm8izdFR9ejWTShXbBr3dialEnOwOkT+0Fr4ZF1wBV/E3
	 s4YWWxYW1C1w7VtyzYpKPvCiEV3qn/fPIsUJYe2N5ym9t4RAAFctBSLs51szqDZPrV
	 OZlM767NyK49PtZ6XE8JeW3PN+f6pooLnkMre7RB1KCLqxL+zlKDmY0sLVhynI6C6T
	 ssgBlO9lzs058EkUCvZJTPMULdZW/mHygV6B7TOgodiwXbE3srZ+InUpKiIZnf+fse
	 TjQnynfxx7EkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/22] rust: pin-init: move the default error behavior
 of `try_[pin_]init`
In-Reply-To: <20250304225245.2033120-8-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:54:07 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<1iRthWaE9p56aGqyNzaY-vh27mX2Tp1thOYCi8oBj6Qn6m6TxlSh-5-Ic4noCVTjVSXzw6GcviNXRtXbg6aw6A==@protonmail.internalid>
	<20250304225245.2033120-8-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 11:29:34 +0100
Message-ID: <87r03bepo1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> Move the ability to just write `try_pin_init!(Foo { a <- a_init })`
> (note the missing `? Error` at the end) into the kernel crate.
> Remove this notation from the pin-init crate, since the default when no
> error is specified is the kernel-internal `Error` type. Instead add two
> macros in the kernel crate that serve this default and are used instead
> of the ones from `pin-init`.
>
> This is done, because the `Error` type that is used as the default is
> from the kernel crate and it thus prevents making the pin-init crate
> standalone.
>
> In order to not cause a build error due to a name overlap, the macros in
> the pin-init crate are renamed, but this change is reverted in a future
> commit when it is a standalone crate.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

[...]

> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index dde2e0649790..4123d478c351 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -28,7 +28,8 @@
>  pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_in=
fo, dev_notice, dev_warn};
>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, =
pr_notice, pr_warn};
>
> -pub use super::{init, pin_init, try_init, try_pin_init};
> +pub use super::{init, pin_init};
> +pub use super::{try_init, try_pin_init};

Are you trying out a new scheme here - a balance between normalized and
line-by-line use declarations? =F0=9F=98=86


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



