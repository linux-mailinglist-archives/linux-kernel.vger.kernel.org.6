Return-Path: <linux-kernel+bounces-292633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E8957219
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42D8283911
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224717BED4;
	Mon, 19 Aug 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwwkeiHP"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27767176233;
	Mon, 19 Aug 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088336; cv=none; b=jEx3lOwV8HMsJ8lcQsshEJZDTuuOxtbtbOy4HrdvssFJYprNbP0Krr470ij0+OpdVnYxh15SLYDqKE8G4eiCoBJfYwjc7Yo2vdZr26Hf8stXX7So05jWhzKIb6UfUEJqHHEGwhjLJa+s9sfHYf2yTdfC96I/s8icSHstrZ96Z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088336; c=relaxed/simple;
	bh=ip02YYRktfoEruoD0II0udetDlc5rU9kWmXG7UGg9xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpUFfdRbdBbI/nx70W1DPMsBbuOsWTQuRFOxzZd1MV6LhUTB69+qds0H7KM9FlRYn9I2q8n7snAwqJpXWsq/xGwwszKWrqkf1N81jEf9qv75G8F94y6D5/GYaOqutT8qGVmrET2Oj3j2fBJp2U51nlszJNR9Ffk2J/uw6MgmEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwwkeiHP; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fff73f223so24123681cf.2;
        Mon, 19 Aug 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724088334; x=1724693134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0X8YvJp7L1oxPAYkj5REm5oJFCsN60kmLskKrGXb0E=;
        b=DwwkeiHPm/0ROL6DYlqaT7/gw0jSsaqE1aYBk7Wc0R9cKxKvWXYyjK2nSKvOZ2V3Iv
         uf/juRESKPCU7rlN1ARB3w9vhMGacJH5Z/vPcJyAtt2EcYrtECzD6npEA2Od1nNL/6bh
         k5pxkBNurCo3SMnLt5Q6ZPF99APFI2xVCGj/VEbojHHfJjC6dU+QpLk7kUKGEFLa8V0F
         Fi37/ljKzSdRPtCehKrlswZaNmltnzOEdRs1cDiquY7xlNG6hNOWmZOYpsESbmx7ocnB
         IbM7PTlcjjekPY62Tl0QHDXRTCZpsYhWWPQ7Q8Tu4h7ULIOXuslcwIKscx+DKGgvUHs0
         pdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088334; x=1724693134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0X8YvJp7L1oxPAYkj5REm5oJFCsN60kmLskKrGXb0E=;
        b=toRekMrWPvLRabhkAQqmelntUPCoCkx+eSpYhxSdAaWCy/wbu9NrNC8wm9G/dPfTKU
         8GOn6/XoBDSDcYcq2idzMhnuBHQkQse6q6a//5xbjFt1O6WkUTS0goILT+xttXL3Hzc+
         Va8pU9fLzpxrBxIjrW5UrryBWCwl7DGlvp3v6A3uFZRNlQ/WzSi3/SzvXPbrrkf63ZVJ
         wGrlHgxi8Wni74f/EDYxzfPoScOS0gQ2pNo+19CkTUduSDi3Kue0yxrUP1fJtDMhQNSD
         ZzvfesUkeLXeiPAsl20IiHoCp69rSzF+vb55hxG2zWw9o/gjUFOFKikKueGmHdPmFPp7
         ODpw==
X-Forwarded-Encrypted: i=1; AJvYcCWN7wJ5XL/6cukMiz1//FY8JUmSMPiX+QoaXz23h2jrRfMyl99sblrjgrvMTnSWXL/SBz+bk8rXBGrBw/L25kupv6622wc0dJ+knlFFf/xZZ8asg4zpPLhT0dpzUVMKl0zlq1K4Lj2a34wOaeo=
X-Gm-Message-State: AOJu0YyjNOScRabAZ4IV2piq1ALH0q3lJEa50ZgQZ7/TLYumKq8ilYV/
	NLiw+e2dPrUhc/xnB1dWWAeLzPmL8V1k26gSg0jVbdJ7EM/b7lVo
X-Google-Smtp-Source: AGHT+IFejDSu1XRSd2VQiQX7buvTiaeK1+774UmO52Snu68CdHS50Hs5YFmU4mkLZnggHtzw56w85A==
X-Received: by 2002:a05:622a:8cd:b0:450:9:a427 with SMTP id d75a77b69052e-453743a994bmr132700151cf.48.1724088333892;
        Mon, 19 Aug 2024 10:25:33 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff54ffsm42153231cf.36.2024.08.19.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:25:33 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3D0331200070;
	Mon, 19 Aug 2024 13:25:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Aug 2024 13:25:32 -0400
X-ME-Sender: <xms:DIDDZvkx-hNAKN92WFViIa_lO9xetekFFbO0O4I8QgYNOF8F0i4F4w>
    <xme:DIDDZi0Z75EUciBcqqAoM7EKDjg81iwMjyhVL_-GdfHpY8h8ska3XSxOT4ig4kYut
    dr2cY13311Vd0A8GA>
X-ME-Received: <xmr:DIDDZlp-SCZiYrXp02u7DUhLqSJS96apGBLGbvD3wLKZbed8s2QSEDSscJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehojhgv
    uggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusgho
    rhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DIDDZnkUPjqiUW0Kx_myPqAD7p28cw_QLrzUq98OppzRHIIdUPNGSw>
    <xmx:DIDDZt0xo5xZAO5wKiBUvQUkrGauVeGM78nDKWsLsfLAQ-gk6qJhbA>
    <xmx:DIDDZmtl624sEVJhB-u6PimyM0yr-neQO3-1LM_mJ2l5QeX_zu2E0A>
    <xmx:DIDDZhXimXKdbiVhzbLy0_L5L1bI3RJ5XoznmUv6Kp1zH3lgX19zow>
    <xmx:DIDDZs3tsLZKE5cIjhW-NBULD-N2of3l_obTUmEa9p61eptPxAuX-Bne>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 13:25:31 -0400 (EDT)
Date: Mon, 19 Aug 2024 10:23:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <ZsN_pbvd45Gij66O@boqun-archlinux>
References: <20240819112415.99810-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819112415.99810-1-benno.lossin@proton.me>

On Mon, Aug 19, 2024 at 11:24:35AM +0000, Benno Lossin wrote:
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]


Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/alloc/box_ext.rs | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> index 829cb1c1cf9e..b68ade26a42d 100644
> --- a/rust/kernel/alloc/box_ext.rs
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -4,7 +4,7 @@
>  
>  use super::{AllocError, Flags};
>  use alloc::boxed::Box;
> -use core::mem::MaybeUninit;
> +use core::{mem::MaybeUninit, ptr, result::Result};
>  
>  /// Extensions to [`Box`].
>  pub trait BoxExt<T>: Sized {
> @@ -17,6 +17,22 @@ pub trait BoxExt<T>: Sized {
>      ///
>      /// The allocation may fail, in which case an error is returned.
>      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> +
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{flags, box_ext::BoxExt};
> +    /// let value = Box::new([0; 32], flags::GFP_KERNEL)?;
> +    /// assert_eq!(*value, [0; 32]);
> +    /// let value = Box::drop_contents(value);
> +    /// // Now we can re-use `value`:
> +    /// let value = Box::write(value, [1; 32]);
> +    /// assert_eq!(*value, [1; 32]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
>  }
>  
>  impl<T> BoxExt<T> for Box<T> {
> @@ -53,4 +69,17 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
>          // zero-sized types, we use `NonNull::dangling`.
>          Ok(unsafe { Box::from_raw(ptr) })
>      }
> +
> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
> +        let ptr = Box::into_raw(this);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { ptr::drop_in_place(ptr) };
> +
> +        // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
> +        let ptr = ptr.cast::<MaybeUninit<T>>();
> +
> +        // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
> +        // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
> +        unsafe { Box::from_raw(ptr) }
> +    }
>  }
> 
> base-commit: c4d7f546dd9aa9780716cdb07416ca97264dce43
> -- 
> 2.45.2
> 
> 
> 

