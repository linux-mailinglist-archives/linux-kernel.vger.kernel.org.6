Return-Path: <linux-kernel+bounces-273717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA867946CD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13B9281B02
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2928414277;
	Sun,  4 Aug 2024 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlwPgQ3Z"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EE524F;
	Sun,  4 Aug 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753959; cv=none; b=J+/0daVzvp+MuTJwEhexT+rvDkf7nOSy17KitU7/eoHPLGDdI1OZnLs63SvHgf5J7GWylfvqg/52S+qNihckBkInL33mT1+/pf4tbwGS9WzXBE7Ar0TWlonX6Qq/D5t52B32+Qc9orD1mpmeW3rekdKcVqy7uT63Nbwin2JbkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753959; c=relaxed/simple;
	bh=Ww+TB37F+nuqILMHgYK7ZdIccsMUAijxT2HYOkH+Uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhSNLIt7egqz6kf049o47wdAtmw8arODAPLQGMJiu5L+vi1J8bXqyFTZ2oV7FKoyuJrgM4M2TY5TgWrPT0qH8/YwuhE0W1C+83tHDbByNWJUwAizqJQdOz530vkD23ERbKDEbUHTEWGRQzg3W/ow24F3RVfGtlRHEu+Ht8RUows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlwPgQ3Z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d0ad7113so635400385a.2;
        Sat, 03 Aug 2024 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722753956; x=1723358756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQQRD11//H4yepKu/hFAoZLTm/n2T2rx/vysOHXwMa4=;
        b=SlwPgQ3ZhkIJ5vq4WEQaopl0+zxMaayg/WFdg+b/fbHlDP9pKXUhCGYj5HrIIEpwfm
         p1eKbMkXXbJKnHH9eQXiK41voiwF4scm6FWTv82XuY8TQs8Bm/MvTwdhRyqDs5j/C8C3
         pzRX2qBthwhCvhDpDvr/PmqsSu2j4w2CXSlaKoXeAl3CfFhWRulurRqZaEP4QNKeJ8cm
         28SOZH4eH0ia9UrK1HBstjfg0V7IsI4ui4fLXKaEcc12f3brIY72lIvY3Te96yei9618
         DRGRN2wBzO5FGe5p2BJWZPOMJBZHKrM8HAkh/QUl/EXbNyRIhYqSKtKy4vlL5iweeP36
         6akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722753956; x=1723358756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQQRD11//H4yepKu/hFAoZLTm/n2T2rx/vysOHXwMa4=;
        b=PbMoKc1XuMU2RyjBvIKwcwCuCZaUi2v7dYUp8LTA+lCxjuGevEJE6YYXLXI+vbE2c0
         TkgarFmd6OWT1yS36zD3V7vDVvVO6Y87QDVYmavh+31GV3k81ZF2FuZkpKuzDpb1W5Yo
         KqrGizSB2XoPwo5eu8lFdpX+FHRpD+iT62vqlbBLi0yuZjNkt5ghmlrzV96jkXx7KgZC
         G1rLVD0QAeBadbdPr7EHxx5SGHpobNUQT49gLaiF8queYB8F5/O6sRIxojiRLFMnawkI
         JSljuTsQOKc2k9TmbRYh3WrsoCKnkMXIGuljTKkUAzfbKYHVEtpa8RpA5nnaNBVoqVJQ
         YhSA==
X-Forwarded-Encrypted: i=1; AJvYcCV42rF+19EDLNA8KRRoyrUVN3X3g3gtu7bP9kjvqm2QltlDqg1W7QrFJK0nKh6TakXKfuz7wdAPhWZUCoTGKMYwg7TJG/pkbq2ZlKoRFRKLlx94Lo1yzkJxhqz8+Ujfq4OPbpVM/rq78BlpDw4=
X-Gm-Message-State: AOJu0Yxptghnnrvr5jbqDqtMkDRnpHHnxNH4VQi0rklIEFsXWfQDMbJL
	yUFjwrE8Dro2oLbkGvbc/qQ/b8Z5dKBnmfi352J+mz0N5rFcQgkG
X-Google-Smtp-Source: AGHT+IHIrtETtSeKsazHoIi9a78Yu5TG3S9mO/0JOW+BHR5KdBXRpjaAFZ3zhY2sknVtKmqeFbR3kA==
X-Received: by 2002:a05:620a:4448:b0:79f:6bc:d98 with SMTP id af79cd13be357-7a34ef53e9bmr1075535885a.36.1722753956382;
        Sat, 03 Aug 2024 23:45:56 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6f8463sm230633685a.53.2024.08.03.23.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:45:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2F999120006A;
	Sun,  4 Aug 2024 02:45:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 04 Aug 2024 02:45:55 -0400
X-ME-Sender: <xms:oyOvZl_uxaC6AAx3S5fWVb0Ul-YzFWRs0cLnLmIXEpxbqK_WPyCvYw>
    <xme:oyOvZpv0-bFtu5G_1Ob87N0xriJTAv7CZ1VpxaD7o3XGLSLUIJYNFe37teQ6WKAeM
    SvLOYJ9mpxF82kBEQ>
X-ME-Received: <xmr:oyOvZjDAdDkkgpx5Qoy-tt1F9VgbcQvaU4J-FVwvnXYMnJkQTaBJeICQKb7IDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeefgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:oyOvZpdghGxdViMIMawIS_AYfSGcHibe5QxxDLPYnOCR8QBL23rp1g>
    <xmx:oyOvZqOOnFyaqG_LGmhr0pRhce39YceHjQiQqkdb6HOynPzsR9tttQ>
    <xmx:oyOvZrnJ-W9wqI7nmSmaG6hRDxyLn3W7A2Qog-NPZvTBzj-y_FGeTw>
    <xmx:oyOvZkurwO-fC_tadoGd5hFGSJdXRRI9_KhdA_kp9Z6pli0hxjMEBw>
    <xmx:oyOvZssdwyrMzD-MkXkF2S9JufMTZ6iyHjY9bOOzIYKiB6jJz6w34w38>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 02:45:54 -0400 (EDT)
Date: Sat, 3 Aug 2024 23:44:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
Message-ID: <Zq8jamaDSKWmj_-4@boqun-archlinux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-7-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801000641.1882-7-dakr@kernel.org>

On Thu, Aug 01, 2024 at 02:02:05AM +0200, Danilo Krummrich wrote:
> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> allocator, typically used for larger objects, (much) larger than page
> size.
> 
> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers.c                      |  8 ++++++++
>  rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 33 insertions(+)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 92d3c03ae1bd..4c628986f0c9 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -33,6 +33,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/vmalloc.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> @@ -200,6 +201,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>  
> +void * __must_check __realloc_size(2)
> +rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> +{
> +	return vrealloc(p, size, flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
>   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 397ae5bcc043..e9a3d0694f41 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -16,6 +16,12 @@
>  /// `bindings::krealloc`.
>  pub struct Kmalloc;
>  
> +/// The virtually contiguous kernel allocator.
> +///
> +/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
> +/// contiguous kernel virtual space.
> +pub struct Vmalloc;
> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> @@ -58,6 +64,10 @@ fn krealloc() -> Self {
>          Self(bindings::krealloc)
>      }
>  
> +    fn vrealloc() -> Self {
> +        Self(bindings::vrealloc)
> +    }
> +
>      // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
>      unsafe fn call(
>          &self,
> @@ -136,6 +146,20 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
>      }
>  }
>  
> +unsafe impl Allocator for Vmalloc {
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let realloc = ReallocFunc::vrealloc();
> +

IIUC, vrealloc() calls __vmalloc_noprof() in allocation case, that is
calling __vmalloc_node_noprof() with align=1. In such a case, how would
vmalloc() guarantee the allocated memory is aligned to layout.align()?

[Cc Vlastimil]

Regards,
Boqun

> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { realloc.call(ptr, layout, flags) }
> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc = Kmalloc;
>  
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> index 4785efc474a7..e7bf2982f68f 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -7,6 +7,7 @@
>  use core::ptr::NonNull;
>  
>  pub struct Kmalloc;
> +pub type Vmalloc = Kmalloc;
>  
>  unsafe impl Allocator for Kmalloc {
>      unsafe fn realloc(
> -- 
> 2.45.2
> 

