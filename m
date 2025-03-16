Return-Path: <linux-kernel+bounces-563119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC8A6372E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87D9188E814
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA71E1E13;
	Sun, 16 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJdidqDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1B15F306;
	Sun, 16 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742152801; cv=none; b=IMdvVf8zZPanCYnfJsWN1kJZ4f7JCCFDZmXxnY6SSA4L7xS7Y4xj3PpXpz4Bkju1NRKy+DtfmQJpVWaHI3oUA9mTawhhI4eymAGUMF9z31Ta891GOuYLHXBvZq644mZxdgRmBMoqgcXk9uIB7xOMkyvOWONYkGoDp6qX14HibzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742152801; c=relaxed/simple;
	bh=Qs48kSaF/rFe+8NfU92PP5vQtEx0UzxhcUOSBSvxEDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh2PL+TjJxESBNC69FjHYu+tHmIw4WOHrPHJmK5P7dhnEQj4Bb4gbeYtSq7p9RZJ0GAw75F30De1w+1NWMkSAUn3OPXY1LAW9i4QSXK+fX/bm2cF+ArgBvC7MFPaMDIGl6XtcFY9bJHqsnYbQhwBAF4QgEVju1KJuHuHmzWpFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJdidqDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F366DC4CEDD;
	Sun, 16 Mar 2025 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742152801;
	bh=Qs48kSaF/rFe+8NfU92PP5vQtEx0UzxhcUOSBSvxEDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJdidqDDOv7uWe12OaeqnPPha7scvUBMk+l6gdylCwvV/zT9cMOQ6+xZ21CHNOIwn
	 aD9inRyiQDkSwzZYldkIG8H4qck6e4osY8jPmPNSlW8C5/Dk55/utuoRXn4GtsklGX
	 Y30RWzdQchRAFb+5LLJVGu1XzrNgME8tMt1c9eiJlSL7TeBVKBiz3oYTi37Ga0RGZ7
	 AG3GyNhmhQTW1zIsn2qip28yvN/AHvx7RWVMZcfBPIEjp7KsLG4kEQWtkS4npkhg9B
	 Atcczprp7hl05p4QBj8kX+Tbk8Ygg4cyWYOT+/SuCylYTPZuJbQn2A3+hVwfPc+9uT
	 b5UeyzqmBL+KA==
Date: Sun, 16 Mar 2025 20:19:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	acourbot@nvidia.com, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: alloc: add Vec::truncate method
Message-ID: <Z9ckWiW7X0hX5Wvt@pollux>
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-2-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316111644.154602-2-andrewjballance@gmail.com>

On Sun, Mar 16, 2025 at 06:16:42AM -0500, Andrew Ballance wrote:
> implement the equivalent to the std's Vec::truncate
> on the kernel's Vec type.
> 
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..18bcc59f0b38 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -452,6 +452,42 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
>  
>          Ok(())
>      }
> +
> +    /// Shortens the vector, setting the length to `len` and drops the removed values.
> +    /// If `len` is greater than or equal to the current length, this does nothing.
> +    ///
> +    /// This has no effect on the capacity and will not allocate.
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = kernel::kvec![1, 2, 3]?;
> +    /// v.truncate(1);
> +    /// assert_eq!(v.len(), 1);
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn truncate(&mut self, len: usize) {
> +        if len >= self.len() {
> +            return;
> +        }
> +
> +        let drop_range = len..self.len();
> +
> +        // SAFETY: `drop_range` is a subrange of `[0, len)` by the bounds check above.
> +        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
> +
> +        // SAFETY:
> +        // - this will always shrink the vector because of the above bounds check
> +        // - [`new_len`, `self.len`) will be dropped through the call to `drop_in_place` below

We've just figured out that this part is not needed after all, sorry for the
inconvenience. No need to resend for this though, I can remove this line when
applying the patch.

> +        unsafe { self.set_len(len) };
> +
> +        // SAFETY:
> +        // - the dropped values are valid `T`s by the type invariant
> +        // - we are allowed to invalidate [`new_len`, `old_len`) because we just changed the
> +        //   len, therefore we have exclusive access to [`new_len`, `old_len`)
> +        unsafe { ptr::drop_in_place(ptr) };
> +    }
>  }
>  
>  impl<T: Clone, A: Allocator> Vec<T, A> {
> -- 
> 2.48.1
> 

