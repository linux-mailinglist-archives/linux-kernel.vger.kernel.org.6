Return-Path: <linux-kernel+bounces-559729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F2A5F89B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E81E164A19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FFF269803;
	Thu, 13 Mar 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnfMx7e/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88393267F46;
	Thu, 13 Mar 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876649; cv=none; b=bWgHfrQb6uqUBo76sA2A+1JYBtbrNg6DfksmnXot91BG70g3Eyu4D8ZyFDAD6lg+jVrTF5qWuNy/ezLXgUlHw5y3A7fC01EYpCE9+vymP+AdxLhLTAaCejdW9JQPHNYSrpdpY/keVETHBeFm38y7TxLe5vaucriavqQJgaOn8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876649; c=relaxed/simple;
	bh=LhFMU6K6jQihr1xX62MfXoMmTy9dTr3t2WHAnyeflgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHaP0wSJDVL0ygt/M4YVddCQGfqtfWs7WIgDvYwbbJYd3LixNwjQFA5wHiXTdiysgQpuDv49pOH23rduJxCm++TsmtFAe9xTegTjBs2z0SK4BDOaTLy+SM+1JrlAuKTVAUYgU/w0iuR25Bw/9VwMDY+2Sx0mVdxdC66mIowlGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnfMx7e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7289BC4CEEA;
	Thu, 13 Mar 2025 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876649;
	bh=LhFMU6K6jQihr1xX62MfXoMmTy9dTr3t2WHAnyeflgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnfMx7e/Vy0pmVhTtC4kVHNB7nOpLFnTz5tZpq5x3X0hcFojJVrubvEAcKyfNsWcb
	 1o2LgujMWRoo56m4lkgzgU1fSYXRe6lLndUtT/xx4zyjhkF3gkM1tneA99mwrcNT0Z
	 yexApPbWx+0iNePTIOJP3pQQDQ/hQlCtFRT4sAyRI7+JSp/dBpN49CG87IIsWE2PgO
	 TPzcYvdCX2D+s2WXGaUR5cPRM0zWf5T3FJESE/1ZyFQgHzOaAQfwx6eyA9olspu+ND
	 lRQxzVQ5b+eGJyDsUjMgBnZOe25U5ZpwQABgZQvWPOhz/JS2eWJwJukA1e1EowBkRA
	 yzWca552DlJxw==
Date: Thu, 13 Mar 2025 15:37:23 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <Z9Lto6tbWS0kR6gK@pollux>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>

Hi Alex,

Thanks for looking into this!

On Thu, Mar 13, 2025 at 09:40:59PM +0900, Alexandre Courbot wrote:
> Revocable::try_access() returns a guard through which the wrapped object
> can be accessed. Code that can sleep is not allowed while the guard is
> held ; thus, it is common that the caller will explicitly need to drop
> it before running sleepable code, e.g:
> 
>     let b = bar.try_access()?;
>     let reg = b.readl(...);
> 
>     // Don't forget this or things could go wrong!
>     drop(b);
> 
>     something_that_might_sleep();
> 
>     let b = bar.try_access()?;
>     let reg2 = b.readl(...);

Ideally, we get klint to protect us against those kind of mistakes too.

> This is arguably error-prone. try_with() and try_with_ok() provides an
> arguably safer alternative, by taking a closure that is run while the
> guard is held, and by dropping the guard automatically after the closure
> completes. This way, code can be organized more clearly around the
> critical sections and the risk is forgetting to release the guard when
> needed is considerably reduced:
> 
>     let reg = bar.try_with_ok(|b| b.readl(...))?;
> 
>     something_that_might_sleep();
> 
>     let reg2 = bar.try_with_ok(|b| b.readl(...))?;

However, that's much more convenient and a great improvement.

Feel free to add

	Acked-by: Danilo Krummrich <dakr@kernel.org>

> 
> Unlike try_access() which returns an Option, try_with() and
> try_with_ok() return Err(ENXIO) if the object cannot be acquired. The
> Option returned by try_access() is typically converted to an error in
> practice, so this saves one step for the caller.
> 
> try_with() requires the callback itself to return a Result that is
> passed to the caller. try_with_ok() accepts a callback that never fails.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Since I proposed something like that in one of the nova threads (and in Zulip),
feel free to also add

	Suggested-by: Danilo Krummrich <dakr@kernel.org>

> ---
> This is a feature I found useful to have while writing Nova driver code
> that accessed registers alongside other operations. I would find myself
> quite confused about whether the guard was held or dropped at a given
> point of the code, and it felt like walking through a minefield ; this
> pattern makes things safer and easier to read IMHO.
> ---
>  rust/kernel/revocable.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> index 1e5a9d25c21b279b01f90b02997492aa4880d84f..0157b20373b5b2892cb618b46958bfe095e428b6 100644
> --- a/rust/kernel/revocable.rs
> +++ b/rust/kernel/revocable.rs
> @@ -105,6 +105,28 @@ pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
>          }
>      }
>  
> +    /// Tries to access the wrapped object and run the closure `f` on it with the guard held.
> +    ///
> +    /// This is a convenience method to run short non-sleepable code blocks while ensuring the
> +    /// guard is dropped afterwards. [`Self::try_access`] carries the risk that the caller
> +    /// will forget to explicitly drop that returned guard before calling sleepable code ; this
> +    /// method adds an extra safety to make sure it doesn't happen.
> +    ///
> +    /// Returns `Err(ENXIO)` if the wrapped object has been revoked, or the result of `f` after it
> +    /// has been run.
> +    pub fn try_with<R, F: Fn(&T) -> Result<R>>(&self, f: F) -> Result<R> {
> +        self.try_access().ok_or(ENXIO).and_then(|t| f(&*t))
> +    }
> +
> +    /// Tries to access the wrapped object and run the closure `f` on it with the guard held.
> +    ///
> +    /// This is the same as [`Self::try_with`], with the exception that `f` is expected to
> +    /// always succeed and thus does not need to return a `Result`. Thus the only error case is if
> +    /// the wrapped object has been revoked.
> +    pub fn try_with_ok<R, F: Fn(&T) -> R>(&self, f: F) -> Result<R> {
> +        self.try_with(|t| Ok(f(t)))
> +    }
> +
>      /// Tries to access the revocable wrapped object.
>      ///
>      /// Returns `None` if the object has been revoked and is therefore no longer accessible.
> 
> ---
> base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
> change-id: 20250313-try_with-cc9f91dd3b60
> 
> Best regards,
> -- 
> Alexandre Courbot <acourbot@nvidia.com>
> 

