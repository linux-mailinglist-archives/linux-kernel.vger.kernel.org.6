Return-Path: <linux-kernel+bounces-525869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE2A3F6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1B23B3606
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67820E70F;
	Fri, 21 Feb 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTOM8C5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4020B7F2;
	Fri, 21 Feb 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146213; cv=none; b=HqVNF018ehtjvTdK0Jnecj9o92+FcSaznJ9rvw0AfrWvHotbN+T0QjYxxStLbqNduzdY/Ozm5yYse2zfhKq68KlTOiAc/hmH27L9vp/soUA9q2lNX/8C8+ll93SwV/w1qjoXghPtIp037tWr7qV70sNuGOByV6dDZ9M+Q9vGlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146213; c=relaxed/simple;
	bh=i9BXbzfRoah/HM/Mo1NDFtIr5Uc6BXW+HSRXoywL0BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBsozJdeTx/dC1GfVOqOrKGHo+I6EQ4ZzOSL8xVMmVgCfvXIfgBzH8LpKxoVpN3RIbzE+REK10PJREBhx++6XniIrEQsAJCs7d38XEYh+ep5AMbVqNNNJ/LN4Nk0TqX+OJFzDwynHLjSXZezpVI0alDwBRr+2YJa1w6WSZWPNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTOM8C5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7062FC4CED6;
	Fri, 21 Feb 2025 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740146212;
	bh=i9BXbzfRoah/HM/Mo1NDFtIr5Uc6BXW+HSRXoywL0BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTOM8C5WqBDOJVUePzA0humzGjKGz2+n5EoMFqlUxVnNrDFXk6vJc74u5LwYIiOIi
	 A0LgMdpUq5PY1gFap5zbtxytJOjJ2Y+8oA4FO8bdXP7NwknFAHpqaE96M9lsslMaY7
	 XO+yDQWciLdsyHf5dpEUl4BEbOnRMyXQlJN5UEL3Zqaj8QXNTSokcF1ec/7gC7TlDV
	 /9rkq+hRnY2j+DbzC+ixx3LxMVX4e2ahRMA20eSwSSyjc5ZkG9OB4S3zggV0WGSoCd
	 Xw312lZ1sBym3Ck4JWQneqpKhhIF1V1UAeBD0UvElo+Vg1hpslA3aJ7P6nGHtxqOKU
	 WIWxsjXOSK/bQ==
Date: Fri, 21 Feb 2025 14:56:46 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Message-ID: <Z7iGHiQcqa-_AXli@pollux>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>

On Fri, Feb 21, 2025 at 12:03:39PM +0530, Viresh Kumar wrote:
> +/// A simple implementation of `struct clk` from the C code.
> +#[repr(transparent)]
> +pub struct Clk(*mut bindings::clk);

I remember that Stephen explained that NULL is valid value for struct clk. As a
consequence, all functions implemented for `Clk` have to consider this.

I wonder if it could make sense to have a transparent wrapper type
`MaybeNull<T>` (analogous to `NonNull<T>`) to make this fact more obvious for
cases like this?

> +
> +impl Clk {
> +    /// Creates `Clk` instance for a device and a connection id.
> +    pub fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> +        let con_id = if let Some(name) = name {
> +            name.as_ptr() as *const _
> +        } else {
> +            ptr::null()
> +        };
> +
> +        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
> +        // code.
> +        Ok(Self(from_err_ptr(unsafe {
> +            bindings::clk_get(dev.as_raw(), con_id)
> +        })?))
> +    }
> +
> +    /// Obtain the raw `struct clk *`.
> +    pub fn as_raw(&self) -> *mut bindings::clk {
> +        self.0
> +    }
> +
> +    /// Clock enable.
> +    pub fn enable(&self) -> Result<()> {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // use it now.

This is not true.

1. There is no type invariant documented for `Clk`.
2. The pointer contained in an instance of `Clk` may be NULL, hence `self` does
   not necessarily own a reference.

The same applies for all other functions in this implementation.

