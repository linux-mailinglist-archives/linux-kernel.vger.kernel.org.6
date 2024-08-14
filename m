Return-Path: <linux-kernel+bounces-286405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA62951A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8501F234AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753761AED3C;
	Wed, 14 Aug 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ognMeWYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9D13D51D;
	Wed, 14 Aug 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637287; cv=none; b=ezJiRZY862z/EA4pqqN7Pyq2irOvhlpkPZhX3o4KZz07pkgYkKWddyUfAEVdzYhtNinEFxLDaiskWPTQ6esaLSWlom/zEC3VvpDJbQXFOT+rUXBbi84WAd3merMdaYMgQjBNyw5nQ88a4Vgsm3Gx61Kp1ihff9AnlzOArfU9tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637287; c=relaxed/simple;
	bh=NRLpSjB2blskWzdVEuxep7r6O7TWmeLLJ2opBFrnFXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CueIksgG1rDZcKm8kXNKMHUTw/Yq77Pry2HE7esyL/ywDZv5ROkeShDucpJghCmhM7KXhRi76a9NtRRGh8QTQ7T9OsRAriYRI0KCfHFQyna39LInqOm/RxPaW+khs6dqYdsvx+jFS5ZId1sDZ5DyQftMLB+zNvxtaoAImtG4Si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ognMeWYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9780C4AF0E;
	Wed, 14 Aug 2024 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723637287;
	bh=NRLpSjB2blskWzdVEuxep7r6O7TWmeLLJ2opBFrnFXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ognMeWYNbsL4Ndt/N31pW5AQ0q9LIvDwUJeJknGrwkDrZHNBoaSZmVAne8BbYc6WB
	 48NQI3du7WSrP2U/2M7lZ3k9XhoLRO+2m06aCKZqMZya6HPxQYBe2+ZypAcqeC+O11
	 UlxPJUCmXA2rH/xXm2uLLyjPXXOdX3yBkka8UpDqyoYu+I8jlRPtQf1q3ko6dT10su
	 9y6IvASp+/UKlyrEcpW9HJTKlVUFIo1lYVVDnqD967lmKHBunyQQ+5GffcbcT5c9zZ
	 G0EKiHfUQZjvfAujTQ2b1rr/lRbx1FKSMnrfQg9xmqtAIpHrNxT9X4W18xFbGm37Ht
	 jHfCGw/LVZLlw==
Message-ID: <0f6c4fb3-039a-4dc6-a07c-980ca06ecbeb@kernel.org>
Date: Wed, 14 Aug 2024 14:08:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/26] rust: alloc: remove `BoxExt` extension
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 akpm@linux-foundation.org, daniel.almeida@collabora.com,
 faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
 lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-12-dakr@kernel.org>
 <d83155b4-1c73-4191-85b6-55d1b904a926@de.bosch.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <d83155b4-1c73-4191-85b6-55d1b904a926@de.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dirk,

On 8/14/24 1:55 PM, Dirk Behme wrote:
> On 12.08.2024 20:22, Danilo Krummrich wrote:
>> Now that all existing `Box` users were moved to the kernel `Box` type,
>> remove the `BoxExt` extension and all other related extensions.
> I just noticed that in the recent 'rust-dev' branch we have a change which *adds* something to BoxExt:
> 
> rust: kernel: add drop_contents to BoxExt
> https://github.com/Rust-for-Linux/linux/commit/62c34da1da6c01a635ea2308cb42996d0571059e
> 
> I'm unclear how relevant that is. Just want to mention this in case it would make sense to include that directly in this patch series to avoid a future add-on patch ;)

Thanks for reporting. I'm aware of this patch, we expect it to land before this series.
I'll add `drop_contents` once I rebase onto it.

- Danilo

> 
> Thanks,
> 
> Dirk
> 
> P.S.: It looks like anything like this at least makes the compiler happy:
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index d67f975502246..e91d441835d54 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -9,6 +9,7 @@
>   use core::mem::MaybeUninit;
>   use core::ops::{Deref, DerefMut};
>   use core::pin::Pin;
> +use core::ptr;
>   use core::ptr::NonNull;
>   use core::result::Result;
> 
> @@ -270,6 +271,28 @@ pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
>           Ok(Box(ptr, PhantomData::<A>))
>       }
> 
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{Flags, KBox};
> +    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
> +    /// assert_eq!(*value, [0; 32]);
> +    /// let value = KBox::drop_contents(value);
> +    /// // Now we can re-use `value`:
> +    /// let value = KBox::write(value, [1; 32]);
> +    /// assert_eq!(*value, [1; 32]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> +        let ptr = Box::into_raw(this);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { Box::from_raw(ptr.cast()) }
> +    }
> +
>       /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
>       /// pinned in memory and can't be moved.
>       #[inline]

