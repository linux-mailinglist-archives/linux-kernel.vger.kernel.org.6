Return-Path: <linux-kernel+bounces-419257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7507A9D6B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A2C161EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8A19B59F;
	Sat, 23 Nov 2024 20:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOZ1ZFRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D3EADC;
	Sat, 23 Nov 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732392520; cv=none; b=i0TgB+PzhZ7HyKddXbWlr3iSsD9aDOlS7DcfOynsbjw2nv0ssZ2zIniZs9uvGlm8bw7LF+cVBNNKVUHTkX3wUxzQ9fE8r1edeLbQ++8eJ3fhqwWaZ5LPrbG08gAEVfeJ1UX4tq/vIa9UA5r/yVXa32/TP1O7sOqXsf9yMKEMLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732392520; c=relaxed/simple;
	bh=gfVpRsZjNItxoPS+78RWdge/qIyHkEylHh0Tg/HMZiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfzkjihbygr/expuH0sfFIMTkyCzytxgm1wz6GrJqgV8sQfh7xQ461IhYWyxnMmUXt3Dpb/SR5tJODYk5Shv+l0XBaIcl7kPzM+JuB7fApnLgOZN8Q5R/D0qlWZcLBedaVO53AqlhITzA5rq0HF6UTV5flUwo1JIwG4LryI8s8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOZ1ZFRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3656C4CECD;
	Sat, 23 Nov 2024 20:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732392519;
	bh=gfVpRsZjNItxoPS+78RWdge/qIyHkEylHh0Tg/HMZiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOZ1ZFRGuRdFs4lQ5AzhvMHaW+xaM2ETie691pW+7rAqjoUXLnHNiJGC8OeNZyoNm
	 uG4fg3Jptq6XkcTL7a60KYJHGJJrfqXSsmA4VsjelYZVWsD+lPvVV1u4oVs1yJdXYk
	 62SDqd/NxNpSzaCyRzK3TzEC6fv1fFoN1HKPXEL4ph2YaWXJ+RobZ/7Zt0K6t98iQa
	 MjiSXCDoizLE+VcZD1tPQoOFLyzfsXkXUAUlx7TzLzswseFw/H0jMTtht8f4Sz2LX1
	 ceweDBUEwD4Fu8m85OvTD0FChiSpUXHXpdYy6352t4Tg8zwExMUbVe4I192Vc4VhKi
	 SfgSpToXX2E0w==
Date: Sat, 23 Nov 2024 21:08:35 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Asahi Lina <lina@asahilina.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Janne Grunau <j@jannau.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
Message-ID: <Z0I2Q_vGErIQ0xdn@pollux.localdomain>
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>

On Sat, Nov 23, 2024 at 07:29:38PM +0900, Asahi Lina wrote:
> We were accidentally allocating a layout for the *square* of the object
> size due to a variable shadowing mishap.
> 
> Fixes memory bloat and page allocation failures in drm/asahi.
> 
> Reported-by: Janne Grunau <j@jannau.net>
> Fixes: 9e7bbfa18276 ("rust: alloc: introduce `ArrayLayout`")
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Good catch!

Acked-by: Danilo Krummrich <dakr@kernel.org>

(I'm just back from moving and just starting to catch up on what was going on
in the last few weeks.)

Is this related to the performance regression that has been observed by Andreas?
Or did it turn out to be a false positive?

- Danilo

> ---
>  rust/kernel/alloc/layout.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
> index 7e0c2f46157b772248450a77ff445091e17fdfd7..4b3cd7fdc816c158e63ac74014cbfc0794547e81 100644
> --- a/rust/kernel/alloc/layout.rs
> +++ b/rust/kernel/alloc/layout.rs
> @@ -45,7 +45,7 @@ pub const fn empty() -> Self {
>      /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
>      pub const fn new(len: usize) -> Result<Self, LayoutError> {
>          match len.checked_mul(core::mem::size_of::<T>()) {
> -            Some(len) if len <= ISIZE_MAX => {
> +            Some(size) if size <= ISIZE_MAX => {
>                  // INVARIANT: We checked above that `len * size_of::<T>() <= isize::MAX`.
>                  Ok(Self {
>                      len,
> 
> ---
> base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
> change-id: 20241123-rust-fix-arraylayout-0b1009d89fb7
> 
> Cheers,
> ~~ Lina
> 

