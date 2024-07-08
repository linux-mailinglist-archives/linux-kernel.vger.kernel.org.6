Return-Path: <linux-kernel+bounces-244892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963492AAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE891F22968
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805514EC5C;
	Mon,  8 Jul 2024 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj86IJEN"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766A12E75;
	Mon,  8 Jul 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473371; cv=none; b=TK1ba2slEjDx3L99L4KV6pdmDOblHqeX2H4LUs4vCnFoZFCRFLB7WcKYZCzCkosQ/CzFYGeR4zKlulDJ1q9BgigsO+WNRyJ+Lnuy0nhaLcu7dTvSMv/NgTbN8eUbDtHgQssfxFhNvngAqWK9f1HAuGh0EEjkK4g4s5JT/Ln7mi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473371; c=relaxed/simple;
	bh=VH8tKY8HIgy0R/VaatE6NX0uuriJv+k4IsFvPZEoIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5JZ8zTcOr53UsLif4HPwrQf3q3mT+89oZYkZt/bxVbFNBDXY0/Pkzo51F6Ru4bqMR3A4Jda0tv6jZc9oMRtyVUiNmOHJaUKL3vf16gv3S39pa49Dx1vO8s9cLw2UX49gF/8C0hYAaW5AS/OtIurZG/G8J6MAGZcrqHAfHBC6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj86IJEN; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447e2f35af4so9497241cf.0;
        Mon, 08 Jul 2024 14:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720473369; x=1721078169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpXpHV4wzuVc816SuKjPkuf7FlW2BEjL44243S4NidM=;
        b=jj86IJENC8EVh4XH6jbT87BY+DfndXbb13rLcyak0rtF/jZzSeHcixx0KQRvRP0+TT
         Npk2cvTrs6PPI7FEt0ShT4RjH1pxsovrnofsuylCDqVrE4r87+FOzjfOhv9xng/6MqbT
         6WFGc/iwNlpSDGEy8Xh8Thh2/mFGeClR6gPVN67TZfAJgO9UYQL9nz2iEI+gqC28vgwi
         NoOz0Wt/L+zORO/kScjW+HmeCSPwnIwVglwOzejKNDKacEjcQu5PbSBk8b8j52gzygl1
         wFWiB3fh0uyZr0A8qydMXDtE//BZYRZrFp1bm/5gvo+UHNdljd5ySiDnybdmsle4KV57
         4u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473369; x=1721078169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpXpHV4wzuVc816SuKjPkuf7FlW2BEjL44243S4NidM=;
        b=lZcIUil/C9oMkrtGPflK+kvcK5BqEkbskRfrI7ugQIODM/H7uq2Lom2L+ERt/BtpAl
         hUmxDk562956Y6hlepRfL/rdCmM7gNn6NrO9+deWVDGQ8A5gA1tOB6idcxhnyeHWWSyQ
         zAhQRrBOyZfNm7bSuRbzR0zsg4cWxJYQU1GU7vNFJ1Kw/vEEAfT36mpkyDKF//Erj0vh
         XW9Uo4bRu3HNYViDKxWvkp7bnA84ZoN+pziJ2VpV3GcfGlQ5jlkMD9279O9Gcbqlzgkj
         X7mWOQ/hGPXSEz5hUogH4Q76vG73pfyHcpLgkp0lTf2p5imtaBSVyqlfqCMRTltnuX/h
         oTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3BxULsZTXvM1Ivvm5QTh1gCnJZDtjYer28VnoPbOgDheOOTmUeTRQzX6rOSLhKtk/3lKWkRpQHgXXElbgk7gh6FSHSsFz+gczHL1CPtcBPCVK+MUVXxReMycqee/pXe5MbGTkZkyP+ChoxYY=
X-Gm-Message-State: AOJu0YzizQVkgYReujYWZcZ2QO0pxjseftK9Ncz6uXon3DcrEv3w6zLc
	IXuMpruN0ltdJiRLoLisePYBrECD6rLeq5kRDJGnd08KpekOlxQQ
X-Google-Smtp-Source: AGHT+IGh7YmOKTjpBvaBK1AGC/5oiF772oYJB8sAOU/Zlh+Uuf+FIRHXwIXOBVsYWryoPw0PjSD6KQ==
X-Received: by 2002:a05:622a:1995:b0:447:e58e:a881 with SMTP id d75a77b69052e-447fa8a6833mr10763051cf.30.1720473369217;
        Mon, 08 Jul 2024 14:16:09 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c9dsm3282771cf.14.2024.07.08.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:16:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E25011200085;
	Mon,  8 Jul 2024 17:16:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Jul 2024 17:16:07 -0400
X-ME-Sender: <xms:FleMZjLQkDZdJPL0m2xLNlh46qFskrb7jOzkQaCg9vpr9lLT767YgQ>
    <xme:FleMZnKtw-gsMBXn30_POEHRPabRFZCVFOuOmVqRaodq1GVcuAOOB7GWjj1akl280
    vXFMXWCIsr_b9UYDQ>
X-ME-Received: <xmr:FleMZrudnaHc2tfY8Nysn-T5kbkuWmMXEBKB_MZHwzgkboNXkoz4X9bS9d4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FleMZsaWGUPOwY0iUwtmN_tPs4Dvi0jdZSEn8_xh9kr5bp36N0VhVA>
    <xmx:FleMZqbaJn7LxDjXgZ7G1EqSrJdmZr-zxiIlMlNYTh81UXbjAgp06g>
    <xmx:FleMZgDZ6qQG44w8WFaRCWpqfNCIf27rcMRSRFzTkyJFxhPEUHsrLQ>
    <xmx:FleMZob2kbWYA9jZFJJKi0h6RqCQ3ilOK_o56QrLRi9GNEreMqAqkA>
    <xmx:F1eMZuon2_JJMV2aFPcJLmh1yce5GpjstY6fIaOllAPqWFs3xzEmxFB5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 17:16:06 -0400 (EDT)
Date: Mon, 8 Jul 2024 14:14:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <ZoxWyr3fL8GkyOAR@boqun-archlinux>
References: <20240708205325.1275473-1-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708205325.1275473-1-benno.lossin@proton.me>

On Mon, Jul 08, 2024 at 08:53:38PM +0000, Benno Lossin wrote:
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]
> ---
>  rust/kernel/alloc/box_ext.rs | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> index cdbb5ad166d9..6cf79f96d6c7 100644
> --- a/rust/kernel/alloc/box_ext.rs
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -5,6 +5,7 @@
>  use super::{AllocError, Flags};
>  use alloc::boxed::Box;
>  use core::mem::MaybeUninit;
> +use core::ptr;
>  use core::result::Result;
>  
>  /// Extensions to [`Box`].
> @@ -18,6 +19,18 @@ pub trait BoxExt<T>: Sized {
>      ///
>      /// The allocation may fail, in which case an error is returned.
>      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> +
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let value = Box::new([0; 32], flags::GFP_KERNEL)
> +    /// let value = value.drop_contents();
> +    /// // Now we can re-use `value`:
> +    /// Box::write(value, [1; 32]);
> +    /// ```
> +    fn drop_contents(self) -> Box<MaybeUninit<T>>;
>  }
>  
>  impl<T> BoxExt<T> for Box<T> {
> @@ -54,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
>          // zero-sized types, we use `NonNull::dangling`.
>          Ok(unsafe { Box::from_raw(ptr) })
>      }
> +
> +    fn drop_contents(self) -> Box<MaybeUninit<T>> {
> +        let ptr = Box::into_raw(self);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.

Maybe add

	// And `ptr.cast()` is a valid pointer to `MaybeUninit<T>`,
	// since `MaybeUninit<T>` and `T` has the same layout.

?

> +        unsafe { Box::from_raw(ptr.cast()) }
> +    }

With the above or similar:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>  }
> -- 
> 2.44.0
> 
> 

