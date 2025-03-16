Return-Path: <linux-kernel+bounces-563170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28CA637BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13EB7A5E88
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9751DB13A;
	Sun, 16 Mar 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTVc0Zg2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333A440C;
	Sun, 16 Mar 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164920; cv=none; b=KzvXCsL1tWdKGv6BIKMhQYGHI0S66VDFKAmoh0xnbkORe0aHrbFOdTklAvqsaCO/PKwxi/V//iYflkjCtPFzMUGzFg1tFrQKxA5OfZxlqApSrAtkOKBreW7tXMrsPlRlJW4Rbj2MrzC85OHoHEwRkn7vuAXLc8VQpOG7CT6HcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164920; c=relaxed/simple;
	bh=SyJn0VV3hdTB4MzyZtiLwnmoNW2jWsEMpKEyL8b2yjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUsoEnOToTUww8a1dMsRaeZKmnaCdC7xdOd4HXMjR08ox+KdTR36PD4JiU4+j5lAXGQbQQo/gZc491FYcxQeb0DnjNbiUTCwCDVEnkw7zItGSHTLISYtL9aNqiCqcsxh9KyEml6Pywmu/k6KC8esmB7k61o0G/jlhvox3R323Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTVc0Zg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33848C4CEDD;
	Sun, 16 Mar 2025 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742164919;
	bh=SyJn0VV3hdTB4MzyZtiLwnmoNW2jWsEMpKEyL8b2yjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTVc0Zg25rsyZG+fAdP8gbGUr+m2hjjK0y/tgV11r2FY+zEcy2O2Kzoj6RlACpgm9
	 ZdLl+VkL223XDys22cwG09nyEfP9XK8D1aGCbro03r3gZx1+8cT9TYWvMcJVO0Da5n
	 3CxbcHIRlHxzVPzem6L6eB0nCWRf/S1s349/VQNKjRBfFM6RjxUtbX/TTaFzC3bIHy
	 LopOvC7G0/f28N165FXjcwHDG0JlRkknqHp/n5Uai+fETImrhKGWiOPC5JuJFKezm8
	 sPK/JUeW4oC7K5clcILLjKWyxN4WQUE1W0IJZvCeL+c8Axuy57nmz//e/w9F3YWrz6
	 zpC/G8oeoyHZA==
Date: Sun, 16 Mar 2025 23:41:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <Z9dTspva0aJRWG3Y@pollux>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>

On Sun, Mar 16, 2025 at 06:32:01PM -0400, Tamir Duberstein wrote:
> Add `Vec::dec_len` that reduces the length of the receiver. This method
> is intended to be used from methods that remove elements from `Vec` such
> as `truncate`, `pop`, `remove`, and others. This method is intentionally
> not `pub`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index d43a1d609434..5d604e04b9a5 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize) {
>          self.len += additional;
>      }
>  
> +    /// Decreases `self.len` by `count`.
> +    ///
> +    /// Returns a mutable reference to the removed elements.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `count` must be less than or equal to `self.len`.

Why? We can catch this, no?

We can keep the debug_assert!(), but use self.len.saturating_sub(count) instead.

> +    unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
> +        debug_assert!(count <= self.len());
> +        self.len -= count;
> +        // SAFETY: The memory between `self.len` and `self.len + count` is guaranteed to contain
> +        // `self.len` initialized elements of type `T`.
> +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len), count) }
> +    }
> +
>      /// Returns a slice of the entire vector.
>      #[inline]
>      pub fn as_slice(&self) -> &[T] {
> 
> -- 
> 2.48.1
> 

