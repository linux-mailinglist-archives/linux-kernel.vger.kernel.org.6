Return-Path: <linux-kernel+bounces-290885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52797955A80
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7829A1C20B04
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38814414;
	Sun, 18 Aug 2024 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htbVu+nO"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3A2F44;
	Sun, 18 Aug 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723942155; cv=none; b=YJHbhOH2BxvvjtZN+nSEJntIDnq3rWM0uT3sj966NGBF0dSSDG7SpjrcVGYq2FMzKfsiB8VkZEUM1B51orPa1hVJrOp85PGdPzh3Hl785ZSF5yBPnVMtmAxL5Uz3Ew9qSdRay0PGNoapmR3aJZwtj2wBgHvVb4f2gIw5FWwaALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723942155; c=relaxed/simple;
	bh=7+NXyQb8Fysd9z9wmrmo1oznSPbwO5vYEkUYlb+oWM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6xvucY7z322X8paJG1hSBLTEKmM+0WLBhjWUl/L29rXXPEuOq+zkqUyz55iAG7OQ9BrmzUrip3SraQ1mhEO+quW+InKWpKIgv7DAxTcQmDpWLaiDQO7wmcQvoJKQJnrQcv16rhfIcAr96TuTPJn+226DDj9RGcW/AaBe3Iq92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htbVu+nO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b59a67ba12so5355467b3.1;
        Sat, 17 Aug 2024 17:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723942152; x=1724546952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EdgDELz7JA0v3poIoeswIteQ3r02vVslwS/blpZfEo=;
        b=htbVu+nOrEc0yaEDqBy2n+5k0p428aESkbt2mnJ/gahoHAM8HKqSBsj1+QunpFl07z
         rYzIuq+j7BAchNdoBUsW8uATZ0icYO6xLwJxDFb6OMOXLymgHB65gKXes3W1awXemzb7
         EI0v1XTke0a27103HWi9mQU9WYtcNXocFCrwZIaXiJfEr39nAZnn0WiX69a5ReLAEehn
         jx8V7Y1AxXxX9Ij2M51UXKiFqgqpVJusZIiA0qbS//vskSz04+lf3b5FWnSt6ILCFKEl
         7YKeal9bGwhyKkhFbWPnNax7vGLibMtX5jucZbgvy+JQY1rYxrlh14nUcecp4Z4JbzFT
         fTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723942152; x=1724546952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EdgDELz7JA0v3poIoeswIteQ3r02vVslwS/blpZfEo=;
        b=VD29j0U1pW+lXQRwGdnOzFfbqpqPkB5R0ZJ8Zkal5rvlVU6SjYQ2aOgfaLUGjF/Gzs
         u4eqHtypgJbytyKw5wxhMP2U/w4TzuctQuozOcN5TlycqC9lY7vdBvlFBZJliW/K0P4g
         RcE1iRbfJHi7VjwQ+YfCSVNHPHuGNKRuNIVTunEmZA6Ebg/gDxcH5XZ8hO0+Dp/RnSTf
         ZSHG0cwWQzxgjvbSMXwXc0ddyMVh3XKH2K+ZHle+1wT+GhI/cyBZtM7hpK9q1gwiSazO
         D0MS0u2qcR5yuESsWuW/K/CepfmO/LUQbMIyj5VkD5/LWKcQDhdoL15xeYnBKL1niXoz
         S2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPaQf/N0s6+rlE4Xvin0hKhGH/fP6ZgLv8iSxhvrvaaGweIcto3CUqtlhYAhJzoejJiAOHquWiXbcmIioG8oEE/4RpSUn/01wGmGmImzdXXKHqlWht8ltb42saItehIbz21aaNvwlAxTLbUj4=
X-Gm-Message-State: AOJu0YzRwhbTQq48Xb3RlTkCMzocTngjsamaPNGlyj47mf1bC9OohxiI
	9HQnK4CUiH3PZs924AEA3eDsfU26nd+gZz49C8NUolL87wDnFfq+
X-Google-Smtp-Source: AGHT+IF4EjIETNDWgss5CrMF9RFM6YdzjkQiXQpqrXHkRFOwCxRn51xDFXG5LfpDrFrAeC3u9uNiPQ==
X-Received: by 2002:a05:690c:4f01:b0:64a:b33a:d954 with SMTP id 00721157ae682-6b1b8de07bfmr62156787b3.23.1723942152451;
        Sat, 17 Aug 2024 17:49:12 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0fbef4sm308887185a.110.2024.08.17.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 17:49:11 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 74346120006B;
	Sat, 17 Aug 2024 20:49:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 17 Aug 2024 20:49:11 -0400
X-ME-Sender: <xms:B0XBZiJ0VZxU5YtGUWdGjQjvYMGNCFPHIVkeuPVoIe0RTrTJ39mRhA>
    <xme:B0XBZqIaByopmRk9h2p--fFZFhvDQiYcW3Dj8oZ5ZyTCBCGuX1RBnOU-YTMF-16m_
    g534_Hjq7IRjpwnlg>
X-ME-Received: <xmr:B0XBZis7rEdh4K9TYCBseDyUrOH9K9NC6zCpqEKUwzY4TZL5Gm99-QmT8ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduuddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopegs
    jhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnh
    hordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhr
    ghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopeguihhrkhdrsggvhhhmvgesuggvrdgsohhstghhrdgt
    ohhm
X-ME-Proxy: <xmx:B0XBZnY_BVyYqvcnFQzUczSx7Oxcmv0IZ0SlYkOR2I3BP6fRrybTDA>
    <xmx:B0XBZpbNS_biLSPCNKYxVNKU_Nm05wZpIlWTniGsqL9bOsqNLzETug>
    <xmx:B0XBZjDpKRT1QtCT62jT6dVR4S6wiB511D5tnntvsVcbFL5OnQtQJQ>
    <xmx:B0XBZvb6NkiQKm-DDXn7TVie1QQafVcAPamVKu5c2MDu6ajxPOCufA>
    <xmx:B0XBZpqrWtwkO0-IpPtxo0NG6-oHF0RDkETb1McUVEOX6KZCc-tJWtmM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Aug 2024 20:49:11 -0400 (EDT)
Date: Sat, 17 Aug 2024 17:47:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
Message-ID: <ZsFEpjvE9osKDb3b@boqun-archlinux>
References: <20240817165302.3852499-1-gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817165302.3852499-1-gary@garyguo.net>

On Sat, Aug 17, 2024 at 05:51:32PM +0100, Gary Guo wrote:
> This removes the need for explicit exporting all symbols.
> 
> Generate helper exports similar to what's currently done for Rust
> crates. These helpers are exclusively called from within Rust code
> and therefore can be treated similar as other Rust symbols.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

This also passed my test script (x86, arm64 and riscv build and kunit
tests). 

Miguel, I think it makes more sense if we take this one and the
helpers.c split one as early as possible, given they are treewide
changes ;-)

Regards,
Boqun

> ---
> 
> Notes:
>     Changes in v2:
>     - Split from the helper inline RFC [1]
>     - Rebased on Andreas' split helper patch [2]
>     - Moved comments about helper export to Makefile
>     
>     [1]: https://lore.kernel.org/rust-for-linux/20240529202817.3641974-2-gary@garyguo.net/
>     [2]: https://lore.kernel.org/rust-for-linux/20240815103016.2771842-1-nmi@metaspace.dk/
> 
>  rust/Makefile            | 16 ++++++++++++++--
>  rust/exports.c           |  1 +
>  rust/helpers/README.md   | 12 ------------
>  rust/helpers/blk.c       |  2 --
>  rust/helpers/bug.c       |  1 -
>  rust/helpers/build_bug.c |  1 -
>  rust/helpers/err.c       |  3 ---
>  rust/helpers/kunit.c     |  1 -
>  rust/helpers/mutex.c     |  1 -
>  rust/helpers/page.c      |  5 -----
>  rust/helpers/refcount.c  |  3 ---
>  rust/helpers/signal.c    |  1 -
>  rust/helpers/slab.c      |  1 -
>  rust/helpers/spinlock.c  |  3 ---
>  rust/helpers/task.c      |  3 ---
>  rust/helpers/uaccess.c   |  2 --
>  rust/helpers/wait.c      |  1 -
>  rust/helpers/workqueue.c |  1 -
>  18 files changed, 15 insertions(+), 43 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 967da95ba8b0..3171a9021494 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -16,8 +16,8 @@ no-clean-files += libmacros.so
>  
>  always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
>  obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
> -always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
> -    exports_kernel_generated.h
> +always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
> +    exports_bindings_generated.h exports_kernel_generated.h
>  
>  always-$(CONFIG_RUST) += uapi/uapi_generated.rs
>  obj-$(CONFIG_RUST) += uapi.o
> @@ -313,6 +313,18 @@ $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
>  $(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
>  	$(call if_changed,exports)
>  
> +# Even though Rust kernel modules should never use the bindings directly,
> +# symbols from bindings crate and the C helpers need to be exported because
> +# Rust generics and inlined functions may not get their code generated in the
> +# crate where they are defined. Other helpers, called from non-inline
> +# functions, may not be exported, in principle. However, in general, the Rust
> +# compiler does not guarantee codegen will be performed for a non-inline
> +# function either. Therefore, we export all symbols from helpers and bindings.
> +# In the future, this may be revisited to reduce the number of exports after
> +# the compiler is informed about the places codegen is required.
> +$(obj)/exports_helpers_generated.h: $(obj)/helpers.o FORCE
> +	$(call if_changed,exports)
> +
>  $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
>  	$(call if_changed,exports)
>  
> diff --git a/rust/exports.c b/rust/exports.c
> index 3803c21d1403..e5695f3b45b7 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -17,6 +17,7 @@
>  
>  #include "exports_core_generated.h"
>  #include "exports_alloc_generated.h"
> +#include "exports_helpers_generated.h"
>  #include "exports_bindings_generated.h"
>  #include "exports_kernel_generated.h"
>  
> diff --git a/rust/helpers/README.md b/rust/helpers/README.md
> index 940b24bb552d..f2be545ef946 100644
> --- a/rust/helpers/README.md
> +++ b/rust/helpers/README.md
> @@ -3,15 +3,3 @@
>  Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
>  cannot be called either. The files in this directory explicitly create functions
>  ("helpers") that wrap those so that they can be called from Rust.
> -
> -Even though Rust kernel modules should never use the bindings directly, some of
> -these helpers need to be exported because Rust generics and inlined functions
> -may not get their code generated in the crate where they are defined. Other
> -helpers, called from non-inline functions, may not be exported, in principle.
> -However, in general, the Rust compiler does not guarantee codegen will be
> -performed for a non-inline function either. Therefore, this file exports all the
> -helpers. In the future, this may be revisited to reduce the number of exports
> -after the compiler is informed about the places codegen is required.
> -
> -All symbols are exported as GPL-only to guarantee no GPL-only feature is
> -accidentally exposed.
> diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
> index d99c965eb59b..cc9f4e6a2d23 100644
> --- a/rust/helpers/blk.c
> +++ b/rust/helpers/blk.c
> @@ -7,10 +7,8 @@ void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
>  {
>  	return blk_mq_rq_to_pdu(rq);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
>  
>  struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
>  {
>  	return blk_mq_rq_from_pdu(pdu);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
> diff --git a/rust/helpers/bug.c b/rust/helpers/bug.c
> index e2afbad23dcd..e2d13babc737 100644
> --- a/rust/helpers/bug.c
> +++ b/rust/helpers/bug.c
> @@ -6,4 +6,3 @@ __noreturn void rust_helper_BUG(void)
>  {
>  	BUG();
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_BUG);
> diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
> index f3106f248485..e994f7b5928c 100644
> --- a/rust/helpers/build_bug.c
> +++ b/rust/helpers/build_bug.c
> @@ -7,4 +7,3 @@ const char *rust_helper_errname(int err)
>  {
>  	return errname(err);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_errname);
> diff --git a/rust/helpers/err.c b/rust/helpers/err.c
> index fba4e0be64f5..be3d45ef78a2 100644
> --- a/rust/helpers/err.c
> +++ b/rust/helpers/err.c
> @@ -7,16 +7,13 @@ __force void *rust_helper_ERR_PTR(long err)
>  {
>  	return ERR_PTR(err);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
>  
>  bool rust_helper_IS_ERR(__force const void *ptr)
>  {
>  	return IS_ERR(ptr);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
>  
>  long rust_helper_PTR_ERR(__force const void *ptr)
>  {
>  	return PTR_ERR(ptr);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> index 905e4ff4424a..9d725067eb3b 100644
> --- a/rust/helpers/kunit.c
> +++ b/rust/helpers/kunit.c
> @@ -7,4 +7,3 @@ struct kunit *rust_helper_kunit_get_current_test(void)
>  {
>  	return kunit_get_current_test();
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index 29fd141c387d..200db7e6279f 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -7,4 +7,3 @@ void rust_helper_mutex_lock(struct mutex *lock)
>  {
>  	mutex_lock(lock);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> diff --git a/rust/helpers/page.c b/rust/helpers/page.c
> index b3280c80b283..b3f2b8fbf87f 100644
> --- a/rust/helpers/page.c
> +++ b/rust/helpers/page.c
> @@ -7,18 +7,13 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
>  {
>  	return alloc_pages(gfp_mask, order);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
>  
>  void *rust_helper_kmap_local_page(struct page *page)
>  {
>  	return kmap_local_page(page);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
>  
>  void rust_helper_kunmap_local(const void *addr)
>  {
>  	kunmap_local(addr);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
> -
> -
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index 13ab64805f77..f47afc148ec3 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -7,16 +7,13 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
>  
>  void rust_helper_refcount_inc(refcount_t *r)
>  {
>  	refcount_inc(r);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
>  
>  bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  {
>  	return refcount_dec_and_test(r);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
> index d44e8096b8a9..63c407f80c26 100644
> --- a/rust/helpers/signal.c
> +++ b/rust/helpers/signal.c
> @@ -7,4 +7,3 @@ int rust_helper_signal_pending(struct task_struct *t)
>  {
>  	return signal_pending(t);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
> index 3e0a1a173d8a..f043e087f9d6 100644
> --- a/rust/helpers/slab.c
> +++ b/rust/helpers/slab.c
> @@ -7,4 +7,3 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>  {
>  	return krealloc(objp, new_size, flags);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_krealloc);
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index 04fd8ddb4986..acc1376b833c 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -12,16 +12,13 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
>  	spin_lock_init(lock);
>  #endif
>  }
> -EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
>  
>  void rust_helper_spin_lock(spinlock_t *lock)
>  {
>  	spin_lock(lock);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
>  
>  void rust_helper_spin_unlock(spinlock_t *lock)
>  {
>  	spin_unlock(lock);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> index b176c347f0d4..7ac789232d11 100644
> --- a/rust/helpers/task.c
> +++ b/rust/helpers/task.c
> @@ -7,16 +7,13 @@ struct task_struct *rust_helper_get_current(void)
>  {
>  	return current;
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_get_current);
>  
>  void rust_helper_get_task_struct(struct task_struct *t)
>  {
>  	get_task_struct(t);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
>  
>  void rust_helper_put_task_struct(struct task_struct *t)
>  {
>  	put_task_struct(t);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 3d004ac1c180..f49076f813cd 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -7,11 +7,9 @@ unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
>  {
>  	return copy_from_user(to, from, n);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
>  
>  unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
>  				       unsigned long n)
>  {
>  	return copy_to_user(to, from, n);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
> diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
> index bf361f40c7cb..c7336bbf2750 100644
> --- a/rust/helpers/wait.c
> +++ b/rust/helpers/wait.c
> @@ -7,4 +7,3 @@ void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
>  {
>  	init_wait(wq_entry);
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_init_wait);
> diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
> index 12e2ee66aa4f..f59427acc323 100644
> --- a/rust/helpers/workqueue.c
> +++ b/rust/helpers/workqueue.c
> @@ -13,4 +13,3 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
>  	INIT_LIST_HEAD(&work->entry);
>  	work->func = func;
>  }
> -EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> 
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> prerequisite-patch-id: 97916a5ce500a204e6e5b4c5726691f080d6fbcc
> -- 
> 2.44.1
> 

