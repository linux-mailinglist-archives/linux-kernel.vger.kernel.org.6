Return-Path: <linux-kernel+bounces-364321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFB99D267
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8508128372E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B61ABEB7;
	Mon, 14 Oct 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ2+DuKt"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156541798C;
	Mon, 14 Oct 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919447; cv=none; b=BekN+8XESn4w+foyrT5dys2dmGJOVn/XXJ3N2uYdnr41dT026aXqpvayX3S9U5wVXD5efKE9IDZe4Z5fl2Dk70OrBgvZcHAxJv5GCrmxv54VdvycW2wLJp54CEfuXMXuQTjbEFoB9Ztr31LH46F52KQygR1szkzBxIhT+s0sDT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919447; c=relaxed/simple;
	bh=G5ZrKGIRI8jpSI4onC1QIQhQnKaRDPX3qJmXQVJ7oF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2JLBX/0E6UjNA4HfQhrvMWqzyh51rYxFidnUjJHLd+2a/jbUSlyyuXutUAmRW89Wc7IN6onnabYPIyvencKeLBruJ3P72n+GaQJ7xWagiaL4Ez+lkC3ehfK1xZa9rp/J87ev1FX9AWEdi+f7h1AckuPCgdrOFQUEEmnO1dqUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ2+DuKt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf50e2d0so212167585a.3;
        Mon, 14 Oct 2024 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919445; x=1729524245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYH5z0L7usj3TEY2UJNHIBexzgzf90/DN2Wq22O70vU=;
        b=XQ2+DuKtJBo3lV6jEbZHnPYUYz65QowPVXYoZpefuzSGaw5oDwp7CNXiqE7cjMd613
         x8o930cyrKj8cmSOmjr4BcWICSFXJoUuNrXfFTlFBVY63fTZtNk6hmZEyihx5OTCHdkd
         OBv8xs46UcEkBpTlRgljPED9F8u5SSZJcdj8+rcv+gPgDwK7oDb196fqLZRIxiXGcQ2x
         TCgsLtvM8hbJ4v5Hz/ZIXraJAMl/WF8vbFInBwEoaQTipFJlFQbBqEnQ2058ShLWUYEa
         74YBizyRRIBTx3dA2Py/zTZT8XjY7TJVzXDsdsuaBBfNrNWr2hz5JadchwkoMNES95bm
         mcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919445; x=1729524245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYH5z0L7usj3TEY2UJNHIBexzgzf90/DN2Wq22O70vU=;
        b=tc+1bOF84pb6TIKNUuKvayW5D6+eWjFKcouisZbR0eW/N0AI45YWXaMQ1y5/dAneiu
         C6vr/Opv2ADrAaG+Yt7qNlrrL2XKO+0GFcZQm/4Hdwo7ItUsK6oQ/ua/AYWz/Vi+Zezc
         LPqIlzP8wk9St8hkb0sRfBnnQbrQrZblWue0u8BN1nrvi8zJ5Zq2ZEHtloxyeCimSq3H
         2Qdq3uaW2tPlS5DRgp6mFca/q/wsF700ml6tDmBhVzDp79V3G9vpbxy5oncaj2HOdiev
         lUuxDI7Ymw1uvhWYkCak+pNQNXbEBD1tUM2W34hBjTC+YJo4UEsquLZu/sx+gfEl2ygu
         15pw==
X-Forwarded-Encrypted: i=1; AJvYcCWz2ZyZ8WuMUNoogdj9/dOhdvpbQ7fpjkr0cPKBGo/+G4A0Jf/BpSQtGuWKdPKq0tB+v6drYqQNgc1TyYOxZcg=@vger.kernel.org, AJvYcCXz9KTea0dGJ8qm/pkXHN5SYhN59F6cEfMhMUZKmeh2AMyedUrc+LocSIpix6fXAWgIZReApv/SUOMZj0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXuZDCI4PkKoVZWJF9XY4K+kH++6DAuJfI8ztHx+BdGtVHbJc
	Z3oJZX3ag45qZBypNNNU/N38lIAtb/cLNsT3O2l9ytJ4n7fUoqwG55owMA==
X-Google-Smtp-Source: AGHT+IGeVC6/AXqBMx7WwHuZEWV0DZhQpv+Rz3dY/BO6jy+iUKkEL02ulpAZg+YJXL+ZeGXbnxsWeA==
X-Received: by 2002:a05:620a:2685:b0:7ae:6e4a:c43a with SMTP id af79cd13be357-7b11a34f0c7mr2341634685a.6.1728919444771;
        Mon, 14 Oct 2024 08:24:04 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c70c5sm430760685a.15.2024.10.14.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:04 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC9291200043;
	Mon, 14 Oct 2024 11:24:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 11:24:03 -0400
X-ME-Sender: <xms:kzcNZxfv7gQfqMDWaQmFQc_RthET2LKzP6N0f4Cbmr3UkvsxmLKXRg>
    <xme:kzcNZ_OStGfaPT_ATmIF_B_W0WN1DV_vVkgRCbjlNgiUCaRN3AFK38oLP6_P49rlW
    8M1mDDWIi0Uu1Hz8A>
X-ME-Received: <xmr:kzcNZ6g7TY2gX0ps4GKm9C2QBEvOIwirWFgikKPME2SxKog9pqRFz85XZFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeif
    ihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrsh
    htohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhs
    vgdrtgiipdhrtghpthhtohepjhhhuhgssggrrhgusehnvhhiughirgdrtghomhdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgrh
    gvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:kzcNZ6_CPoGDCN8zWmR236T-9I54AetUYPH7byuzaWdykae2TepgHw>
    <xmx:kzcNZ9viOeKfrx8vim8WY1FKfLRbA4STKdhxLTFqgCML2vZJ3LytKw>
    <xmx:kzcNZ5H1QOHzxc7Y2sALIO2lgk8FLdop7XywGl43i_Oymbg40sM2lQ>
    <xmx:kzcNZ0Nmkte1dhYld4PhgfYm46LXt9Jspqa6K4QwLa0IOT4xygRJqA>
    <xmx:kzcNZ2OJqrnQFZkYVdIhAQW4cPbsNOBuhlzZdsCckatzTf4XXar-MdJf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 11:24:03 -0400 (EDT)
Date: Mon, 14 Oct 2024 08:24:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v7 2/2] rust: miscdevice: add mmap support
Message-ID: <Zw03kpgOYA1GbvAD@Boquns-Mac-mini.local>
References: <20241014-vma-v7-0-01e32f861195@google.com>
 <20241014-vma-v7-2-01e32f861195@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-vma-v7-2-01e32f861195@google.com>

On Mon, Oct 14, 2024 at 09:29:52AM +0000, Alice Ryhl wrote:
> Using the vma support introduced by the previous commit, introduce mmap
> support for miscdevices. The mmap call is given a vma that is undergoing
> initial setup, so the VmAreaNew type is used.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/miscdevice.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index cbd5249b5b45..c9428a6154e3 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -11,6 +11,7 @@
>  use crate::{
>      bindings,
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    mm::virt::VmAreaNew,
>      prelude::*,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
> @@ -110,6 +111,11 @@ fn release(device: Self::Ptr) {
>          drop(device);
>      }
>  
> +    /// Handle for mmap.
> +    fn mmap(_device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>, _vma: &VmAreaNew) -> Result {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +
>      /// Handler for ioctls.
>      ///
>      /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
> @@ -156,6 +162,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>          const VTABLE: bindings::file_operations = bindings::file_operations {
>              open: Some(fops_open::<T>),
>              release: Some(fops_release::<T>),
> +            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
>              unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
>              #[cfg(CONFIG_COMPAT)]
>              compat_ioctl: if T::HAS_COMPAT_IOCTL {
> @@ -207,6 +214,23 @@ impl<T: MiscDevice> VtableHelper<T> {
>      0
>  }
>  
> +unsafe extern "C" fn fops_mmap<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    vma: *mut bindings::vm_area_struct,
> +) -> c_int {
> +    // SAFETY: The mmap call of a file can access the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Mmap calls can borrow the private data of the file.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
> +    let area = unsafe { kernel::mm::virt::VmAreaNew::from_raw(vma) };
> +
> +    match T::mmap(device, area) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno() as c_int,
> +    }
> +}
> +
>  unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
>      file: *mut bindings::file,
>      cmd: c_uint,
> 
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

