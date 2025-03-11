Return-Path: <linux-kernel+bounces-556328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B05AA5C41A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFA33B1A54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4925C71F;
	Tue, 11 Mar 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vry1M+yC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAF25C70F;
	Tue, 11 Mar 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704058; cv=none; b=p+N0GpkYhlWJ2CI7bt6kJSl0EEYzFrePSuxxdKcv5GVgF32aL+EjhTUpG4C1NI4lS/YoI1WqMFQ1K4hwvOqAKrftt+ppRYi928PmZ4AkLhK68mDfFuTLjVd/PbYxldL3sZe+m4EH9AMb0BBWoWv0CBJD6ajoy92OlmstffXCJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704058; c=relaxed/simple;
	bh=Tpt83+gXb7HOqzKNAOY3oeFPiR8tf68C5Ztj6otWbOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG3BntR84YaiN8UF51i3sei6vPooDbnBJ0B1vajLSKqOHdpLhhyzku6aOBGt2NFU28DQCkoKi8dTtb1CRSjyai1XhtJFVOb2+nTHGfFBJ9yeNJyDpANg286hhppzvfm5YcVbjrM2tJINlgalEH2FtL5v0WZ9avvIuX29/ICY+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vry1M+yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A40C4CEEA;
	Tue, 11 Mar 2025 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741704057;
	bh=Tpt83+gXb7HOqzKNAOY3oeFPiR8tf68C5Ztj6otWbOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vry1M+yCaX08QI4CJhnozlvQo4q2qEMkXUS5WyZwVCWhomuN9efAIYL3oZ+OnjuMB
	 3mkEN7mxWWzV99JfCa33eWxla/BsufF4Y2H3fzfFVXjQ3rseV+9EcperCxdqCJA8ug
	 SpD7GNOktl77BrF/YQeobPnJ/UnEG4eUECwm6NbGw/m7rbIHgBRy5oHz/8DSZuRL6E
	 cTNr13DNtPCv7D5/i0Qf4nUog+Bss9xPciOG+SwD1GCiPmQc7wA8UmDcb3DFvzahec
	 cCE+Jxsd/M1NomXtJm0Bf1IT6qyVkYSY/YgVUDbnp9l+alj7KF5MSvRLPs042uNj/2
	 gjdVrPlbA+b7g==
Date: Tue, 11 Mar 2025 15:40:51 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::clear
Message-ID: <Z9BLc7P2FKiJAo2p@cassiopeiae>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <20250311-iov-iter-v1-4-f6c9134ea824@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-iov-iter-v1-4-f6c9134ea824@google.com>

On Tue, Mar 11, 2025 at 02:25:15PM +0000, Alice Ryhl wrote:
> Our custom Vec type is missing the stdlib method `clear`, thus add it.
> It will be used in the miscdevice sample.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/alloc/kvec.rs | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741cedbb34bed0be0c20cc75472aa53be..2d213ede2873cef87116a5527e8e24008c970a58 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -395,6 +395,33 @@ pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
>          (ptr, len, capacity)
>      }
>  
> +    /// Clears the vector, removing all values.
> +    ///
> +    /// Note that this method has no effect on the allocated capacity
> +    /// of the vector.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v = kernel::kvec![1, 2, 3]?;
> +    ///
> +    /// v.clear();
> +    ///
> +    /// assert!(v.is_empty());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn clear(&mut self) {
> +        let elems: *mut [T] = self.as_mut_slice();
> +
> +        // INVARIANT: This call changes the number of elements to zero.
> +        self.len = 0;

Please use self.set_len() instead, such that we have to cover all safety
requirements enforced by self.set_len().

With that,

	Acked-by: Danilo Krummrich <dakr@kernel.org> # for char-misc

in case you want to take it through the char-misc tree.

Ironically, self.set_len() lacks your invariant comment and corresponding safety
requirement, I will send a patch to fix this up, unless you want to. :-)

> +
> +        // SAFETY: The values being dropped are valid values of type `T` by the type invariants.
> +        // It's okay to invalidate them as we just changed the length to zero.
> +        unsafe { ptr::drop_in_place(elems) };
> +    }
> +
>      /// Ensures that the capacity exceeds the length by at least `additional` elements.
>      ///
>      /// # Examples
> 
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 

