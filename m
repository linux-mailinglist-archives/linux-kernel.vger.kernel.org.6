Return-Path: <linux-kernel+bounces-562625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D6A62ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF723BC5C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB792040B2;
	Sat, 15 Mar 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThWrk6DE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E22040B3;
	Sat, 15 Mar 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050718; cv=none; b=nqceFQveh2job0vF4FcIl6Xw4I15KNzVgSnmxp11DIptgnBO2gZIHVcTn+nDHmEGs7J/um/9US4tU+M4O3k/OAG+6G8NcYCiAJsfqXue5FSoPE7ITdppcVZs8gXNvKY+pyl87FLTGxWzIKEYFORWzrurm4XhxAnSR7Zjk5TXnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050718; c=relaxed/simple;
	bh=RAeAVhJmU92U3yF+8U1vMhCGpToAH8k8bD3rXfIhF4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIRjLgR37plCu90HO4cjkJMDtuv9GIuH+a5R3bb/MwH1xbQGEO7l8nLd+tv23QVfYP0ChWtQWgpEy9RnnM9G160/vdeoGr8tgmOnFCNvLvP1HskeKa7Iek6c4TBy93zolZ9hxJiObHmmWYHbf93OtXuKc6sflDKJKKMMzUtEHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThWrk6DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B560C4CEE5;
	Sat, 15 Mar 2025 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742050718;
	bh=RAeAVhJmU92U3yF+8U1vMhCGpToAH8k8bD3rXfIhF4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThWrk6DExab+UNESD77yz99cy3ckjADVyJxnz2jMAh9lALCsgIHqc0F/d+TFWvRxA
	 1OfEtqMhMnNpdSDd455c3xHLHgxc4jLVNlrhw0jwa9gMWgwx6J5U8G/9pTI17iIP8h
	 AYZZZbz38Z+aNWxtJKmdPAcappLSA9xZx2Xvj3JnmJ50VlqRO371Uz8EK8StzoI6D9
	 EN7PL8h059EjEFYBnAy28eTaFnk/LJxAhMNoEhDB0F8KaKyzMRVLuaJnBaCZkMfmJp
	 YrS1pvMjuTpyxtsG747d5BjAP4FdeTnBWSvA8tsXbtYAMYKir5crpPBVdiIj2tYQSl
	 FYO+CkdJqmqJw==
Date: Sat, 15 Mar 2025 15:58:31 +0100
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
Subject: Re: [PATCH 2/3] rust: alloc: add Vec::resize method
Message-ID: <Z9WVl9ExWznVAhtY@cassiopeiae>
References: <20250315024235.5282-1-andrewjballance@gmail.com>
 <20250315024235.5282-3-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315024235.5282-3-andrewjballance@gmail.com>

On Fri, Mar 14, 2025 at 09:42:34PM -0500, Andrew Ballance wrote:
> implemnts the equivalent of the rust std's Vec::resize
> on the kernel's Vec type.

Nit: It is preferred to use the imperative form, i.e. "Implement the equivalent
[...]".

> 
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 75e9feebb81f..cbfef2e56f9c 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -554,6 +554,31 @@ pub fn from_elem(value: T, n: usize, flags: Flags) -> Result<Self, AllocError> {
>  
>          Ok(v)
>      }
> +
> +    /// Resizes the [`Vec`] so that `len` is equal to `new_len`.
> +    ///
> +    /// If `new_len` is smaller than `len`, the `Vec` is [`Vec::truncate`]d.
> +    /// If `new_len` is larger, each new slot is filled with clones of `value`.
> +    ///
> +    /// # Example

Nit: Please add an empty line after the heading.

> +    /// ```
> +    /// let mut v = kernel::kvec![1, 2, 3]?;
> +    /// v.resize(1, 42, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// v.resize(3, 42, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 42, 42]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) -> Result<(), AllocError> {
> +        if new_len > self.len() {
> +            self.extend_with(new_len - self.len(), value, flags)
> +        } else {
> +            self.truncate(new_len);
> +            Ok(())
> +        }
> +    }
>  }
>  
>  impl<T, A> Drop for Vec<T, A>
> -- 
> 2.48.1
> 

