Return-Path: <linux-kernel+bounces-562652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47589A62FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316F83B884E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A3202F9A;
	Sat, 15 Mar 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5ov9XE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534571CD1F;
	Sat, 15 Mar 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053794; cv=none; b=CECHEllW8f2Yr2cSNfzV8A5Qwri9Age7EGiuQeemB5TfawpgyGCQ6eu51t30WojDGHNp2bHeRbBhcGU7Afp1D4q3HV6jPpQzc4Zh9lzuqvUaoafa0UJ7y9Zwv7rUcARM27TQr3Y6OSjzjeAd+W+CTSEHy7pkerEtO4VIFZZ08gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053794; c=relaxed/simple;
	bh=//VI9Ejxt3BysY3bBXysrBbAfxCY7XJI4CQgc51yUmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M33KCCJoBQfBNsPf/IDKWR5chPXDuysthl41R8rVtRdgPTJUw9gD9atL1NIGedXGwqh0e1ekRP5cjleu3+Fr/5Cjj/4IN21tuMR0UHu7o11pFdgThpt/NAueRPu+yxXdsNtdwwtRyygGx6UrASvTBQsdX23e4uFSMXVrNx68qYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5ov9XE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC78AC4CEE5;
	Sat, 15 Mar 2025 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742053793;
	bh=//VI9Ejxt3BysY3bBXysrBbAfxCY7XJI4CQgc51yUmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5ov9XE2YyrA++4prSzQ7wQsF4OyCJztO3HJFlvwrvgFKdEbYU+hRxDc/0gjFMi6D
	 ZSsc17tBd6HhqsJQUe+ymMjrT3aAnvhuriYVNsX/0KML/TfhemJUlx/mvHKfDDAiip
	 2dGgM00BWbcYjgnbPPX1hfkU2OMh18PX+JAyxpBzplAOEP3Oja994fpUcRQ+GM38M0
	 Ju38U18/eQp62jo93PzWM8TtRPAPtBx24r2UsoRZzXSAnDMmPcPZ/tMnV9lwY7fE+6
	 15ZK5b867+B/zIpyqmVUlHNPpgiUJhfqvjSoeqAIfr/y2IzqOD8Isq+SRADN2LE7ks
	 0dlyKpEl8xhWA==
Date: Sat, 15 Mar 2025 16:49:47 +0100
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
Subject: Re: [PATCH 1/3] rust: alloc: add Vec::truncate method
Message-ID: <Z9Whm43kUWaiTETX@cassiopeiae>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
 <20250315024235.5282-2-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315024235.5282-2-andrewjballance@gmail.com>

On Fri, Mar 14, 2025 at 09:42:33PM -0500, Andrew Ballance wrote:
> implements the equivalent to the std's Vec::truncate
> on the kernel's Vec type.
> 
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..75e9feebb81f 100644
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

Nit: Please also add an empty line here.

> +    /// # Examples
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
> +        // [new_len, len) is guaranteed to be valid because [0, len) is guaranteed to be valid

We typically use markdown for comments.

> +        let drop_range = len..self.len();
> +
> +        // SAFETY:
> +        // we can safely ignore the bounds check because we already did our own check
> +        let ptr: *mut [T] = unsafe { self.get_unchecked_mut(drop_range) };
> +
> +        // SAFETY:
> +        // it is safe to shrink the length because the new length is
> +        // guaranteed to be less than the old length
> +        unsafe { self.set_len(len) };

I just sent out a fix [1] for the safety requirements of set_len() in [1], which
I think would be good to consider.

[1] https://lore.kernel.org/rust-for-linux/20250315154436.65065-1-dakr@kernel.org/

