Return-Path: <linux-kernel+bounces-238409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCAA924A08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB381C228FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C9205E0F;
	Tue,  2 Jul 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbb7qiKF"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103E1CD5DA;
	Tue,  2 Jul 2024 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956534; cv=none; b=YH+tGOG/Y8aWpidXVXBMHu4y6V8UAYxPy1EE2fXEuXp7TQJdT99zVn/uKEJ4AOyyb0JLG15b0rfqrxV0jc+davyTZlAX+7Eci8X2oqX0N4BvFttGfNVTiKBIOgn4pPe+OXZF7IueenxHC3OwVhcKH521CMkastXsrdlGMLyIGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956534; c=relaxed/simple;
	bh=0L7pcPBtAXPj0S/S+3MgLSoRSkxPBc3fu178Utq2xHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJoyNljjSZ/y6s9T0TBrej6z0JUo321Qb/0anJlyHxtMm1vagt+KezQBNLcd9bM7xs5FzWtps/7mnSmvJQLhkVAza8ZvkgAKpLdP1NP6+++ZNjNPpTOdfu6+abldnOrqOobxr9elOoOZd/ThI/urqg3A4DTP+tjug0ylEerdm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbb7qiKF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e039fdd0d13so1236929276.1;
        Tue, 02 Jul 2024 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719956531; x=1720561331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJQj9aBGbbKul4hCpDKi82UeY7RwXMGhGVaVDyW0wOk=;
        b=Sbb7qiKF1W7KUfjKuAMl+rLr+J3a719UGODd7NeIMcyQBuLblaafjUqkHv1HlwdrhA
         DRbi/So9mPNAhCJfnKhCY00yejfMPGTouAYam02g8l2GOgaUij0pQiqdoJVbB0UByhiU
         6g7RoMdWY0Zp2B6SIhh5KwblZ2Y21K6nPYh/8pFdjor2YMd3TdMyLTccOw3n4/KhZW1j
         PXNHCBrQFvx4ETQY9ZXIAX0EdOSAp/LPPx5tGwgF3OIA7pBlxMrnZ1ZWjkRz0tbTjSOP
         C6n+fbmj9mooOOKYqo0TJjsXohPk1H2wD0Wu1wMcvTu/hGfYqBWXZTRBLCQkKjD6MMzb
         nhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719956531; x=1720561331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJQj9aBGbbKul4hCpDKi82UeY7RwXMGhGVaVDyW0wOk=;
        b=BNUnvPEpcPfTgjfNLTzTwOdPW+x5K2GIQ6brdyU4IZwVt2gROToy5Lh0DRiTlI4akB
         Q+rY+wHi1/V4lsfZRSy80WN37ae9ci4tojVkSFcrZLdq3dxXZHAbQFdEVzoV3dIpJFRl
         nIaDk3Fx6j0O3IZiCeZSBssBOJ7zgVQ37EEW3V04rFO5RU4nwlwDwAQUTz2dlGMwNWhQ
         4Mk7EQX4mWOcTwwYFcZrMgfJI33L+4f7XGjgLmlFQBKFnAOeIaHOvfWY5/6j0Dxj9oXT
         k32x52k9xYJdDv3gJMMD2s96cGqtTPQ4BWb35PKiDq1LaDSE5N5YSWCscY4EtaqGuce9
         /sTA==
X-Forwarded-Encrypted: i=1; AJvYcCXMNwIGvLGosjKnv9sUbUHBmr4mDDqzCp4KE37ojmjVcmvomsliXuf/iWdprXXPYHC0PPIwflLJ3bpkYcfWCI+LBU3Y8Tef6sw2MDx7/FVU+88+khvxODThzea1wVj6nVnzlSAuOPlbILsTsyE=
X-Gm-Message-State: AOJu0Yy8Eby9+fhjSPiJZVK0CCEJxkkBsBhngUbngzzdaThV1bb2CWDb
	ydTwqr5aumaDkVRqPuJDJ6+3v73Q0ST6GOzYblGup3S6xqtBHsD2
X-Google-Smtp-Source: AGHT+IH1O8QzAcBaZC3Iu5DWMawGK4UuV/285H1s7NP0rmqg1WqoLOmUjwLDaVwNlrwR4zcAGkYHmA==
X-Received: by 2002:a5b:f09:0:b0:e02:c70d:d292 with SMTP id 3f1490d57ef6-e036eb6e1b9mr10684186276.33.1719956531633;
        Tue, 02 Jul 2024 14:42:11 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e6228b7sm47620306d6.126.2024.07.02.14.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:42:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 984251200043;
	Tue,  2 Jul 2024 17:42:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Jul 2024 17:42:10 -0400
X-ME-Sender: <xms:MnSEZvN0sPtNAnYIf9YbO8j7mSY3p9VSa86TKISGAOmC-Z6B4oKQSg>
    <xme:MnSEZp85LoVbZ1qGQDZ9MPiEBdqsX8HN4-nq5JvGf2O9GpfPOfNekB8_863GG4UIu
    JI8BxeUn5XM6VjfIQ>
X-ME-Received: <xmr:MnSEZuS6ZzTnDee-lcfKCXqGcYJctGGiP1QxD-IcrcDL0S0DmvshU-MCJR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefhgfegleef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgv
X-ME-Proxy: <xmx:MnSEZjvXJslJ44UG8IywgIjlo4sk6T-wUqhUAZ8uwEixr-mtvMgTTQ>
    <xmx:MnSEZndqkFt7Px6mAgyBrmh-psaI42RTfyjwdRqcgBJxrSxEu2939A>
    <xmx:MnSEZv3avpRhxKs9NwPuo9y3wfyZCATSDhuVC7Kq7WuUv5jIqS7euw>
    <xmx:MnSEZj8d3IdRWACMmogPlj7_iYr2yE2e3JkD28-s27pGGBmCm6lCHg>
    <xmx:MnSEZq_awzvPDd_sJbg0WrnCIv-ULBpheWX4-6lPZOWOh16uDZ1KGQ_j>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 17:42:10 -0400 (EDT)
Date: Tue, 2 Jul 2024 14:41:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-mm@kvack.org,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <keescook@chromium.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] mm, slab: extend kmalloc() alignment for non
 power-of-two sizes
Message-ID: <ZoRz9yEy5wQAu9R9@boqun-archlinux>
References: <20240702155800.166503-2-vbabka@suse.cz>
 <CAH5fLgj=uOktnNCEm+npBh8LLbYUEO8uO30YUBsLS-iK+BKQJQ@mail.gmail.com>
 <c8061293-8457-4d2b-85c2-7c631c00245a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8061293-8457-4d2b-85c2-7c631c00245a@suse.cz>

On Tue, Jul 02, 2024 at 11:18:36PM +0200, Vlastimil Babka wrote:
> On 7/2/24 6:40 PM, Alice Ryhl wrote:
> > On Tue, Jul 2, 2024 at 5:58 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > Thanks!
> > 
> > Since this change is motivated by Rust, why not also include the Rust
> > change in this patch? You would need to remove the if inside
> > krealloc_aligned in rust/kernel/alloc/allocator.rs and update the
> > comments.
> 
> Right, thanks. Does this look ok? (not tested as I don't have the
> environment working)
> 

Thanks! This overall looks good to me.

> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 229642960cd1..c619acb8b285 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -18,23 +18,16 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
>      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
>      let layout = new_layout.pad_to_align();
>  
> +    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
> +    // which together with the slab guarantee means the `krealloc` will return a properly aligned
> +    // object (see comments in `kmalloc()` for more information).
>      let mut size = layout.size();

The `mut` needs to be removed since no need to modify `size` afterwards.

>  
> -    if layout.align() > bindings::ARCH_SLAB_MINALIGN {
> -        // The alignment requirement exceeds the slab guarantee, thus try to enlarge the size
> -        // to use the "power-of-two" size/alignment guarantee (see comments in `kmalloc()` for
> -        // more information).
> -        //
> -        // Note that `layout.size()` (after padding) is guaranteed to be a multiple of
> -        // `layout.align()`, so `next_power_of_two` gives enough alignment guarantee.
> -        size = size.next_power_of_two();
> -    }
> -
>      // SAFETY:
>      // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
>      //   function safety requirement.
>      // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
> -    //   according to the function safety requirement) or a result from `next_power_of_two()`.
> +    //   according to the function safety requirement)

The word "either" needs to be removed as well.

With these changes,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
>  }
>  
> 

