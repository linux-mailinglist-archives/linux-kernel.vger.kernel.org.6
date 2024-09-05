Return-Path: <linux-kernel+bounces-316357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CA96CE67
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2951C1F24DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4715689A;
	Thu,  5 Sep 2024 05:20:54 +0000 (UTC)
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B54156256;
	Thu,  5 Sep 2024 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513653; cv=none; b=F4vo5y6/k3Dt0G3g9jSMOJHAN0Q3Rspw0ec9iEg4I2Jg0yZz/4UUgtQdbc8vnPTezTvidvmmuDvH2C07zCJ0L2pIRPBRF6aMawLpPvKY8VdfNw9saOEJkmJD7PvZcZhGitCbNMS+Scyw60dYyZByLHjvwgR82h88KJXY3xliVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513653; c=relaxed/simple;
	bh=EQcwm/zllP/nW9uFHAheM3MtUpsUsgD5LooMLUJVB9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ2hcBrgL/6IQ6FaTXv8lJUb9+a9v6J8P64jcSPoiVeMiezkcrm72HPBmWq7y15fgS3Z4ZPsJS95lMmAbhfgVsdZfS4ql6MyFumkGM9S6Qvl9XfPek4jJw7yzx62ISFFlNLICSjtVVfv9vmINXpj3HLc3KiZW82GwziJZOU2ZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl; spf=pass smtp.mailfrom=stappers.nl; arc=none smtp.client-ip=141.105.120.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stappers.nl
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id 4401B20203;
	Thu,  5 Sep 2024 05:20:48 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id 68C8C30417C; Thu,  5 Sep 2024 07:20:47 +0200 (CEST)
Date: Thu, 5 Sep 2024 07:20:46 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 12/19] rust: replace `clippy::dbg_macro` with
 `disallowed_macros`
Message-ID: <Ztk/rn+wztXYVTtd@gpm.stappers.nl>
References: <20240904204347.168520-1-ojeda@kernel.org>
 <20240904204347.168520-13-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904204347.168520-13-ojeda@kernel.org>

On Wed, Sep 04, 2024 at 10:43:40PM +0200, Miguel Ojeda wrote:
> diff --git a/.clippy.toml b/.clippy.toml
> index f66554cd5c45..ad9f804fb677 100644
> --- a/.clippy.toml
> +++ b/.clippy.toml
> @@ -1 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +disallowed-macros = [
> +    # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
> +    # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
> +    { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
> +]
> diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
> index 67bf9d37ddb5..085b23312c65 100644
> --- a/rust/kernel/std_vendor.rs
> +++ b/rust/kernel/std_vendor.rs
> @@ -14,7 +14,7 @@
> -/// # #[allow(clippy::dbg_macro)]
> +/// # #[allow(clippy::disallowed_macros)]
> @@ -52,7 +52,7 @@
> -/// # #[allow(clippy::dbg_macro)]
> +/// # #[allow(clippy::disallowed_macros)]
> @@ -71,7 +71,7 @@
> -/// # #[allow(clippy::dbg_macro)]
> +/// # #[allow(clippy::disallowed_macros)]
> @@ -118,7 +118,7 @@
>  /// a tuple (and return it, too):
>  ///
>  /// ```
> -/// # #[allow(clippy::dbg_macro)]
> +/// # #![allow(clippy::disallowed_macros)]
>  /// assert_eq!(dbg!(1usize, 2u32), (1, 2));
>  /// ```
>  ///

For what it is worth, the exclamation mark did surprise me.


> @@ -127,7 +127,7 @@
>  ///
>  /// ```
> -/// # #[allow(clippy::dbg_macro)]
> +/// # #[allow(clippy::disallowed_macros)]
>  /// # {
>  /// assert_eq!(1, dbg!(1u32,)); // trailing comma ignored
>  /// assert_eq!((1,), dbg!((1u32,))); // 1-tuple


Groeten
Geert Stappers
-- 
Silence is hard to parse

