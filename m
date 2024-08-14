Return-Path: <linux-kernel+bounces-287085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD29522BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973451C21C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99E1BF301;
	Wed, 14 Aug 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUHG8hUN"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFA1BE842;
	Wed, 14 Aug 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723664481; cv=none; b=aYeU+0euoqwe8zUIu3jjeEaYGqSX7BLWv6SwugRfFphcWWqJzQxYIcY7rr3T99/ZV2G1Kt+j3TxT6wEnvmML9e6WmpaxUotcX7EusSMBiG4D6gJC8tDGFpCgVPVdcsyXTDygvpQOvm1Y/SNz6mnwIAnYwxfkxWuuBuMfItweTHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723664481; c=relaxed/simple;
	bh=SKw2XZUR7W7bDNlsbaYvABmOzH9rYAGAhE8uywbt8pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGnTxpJdnXjh9iKI1brx2KnEDkqlLFi5lwXeEXgguX3FlCTHVu+h0egU0AW3faW4S+tAd+ZRHykyAFGoB3V16evCirnWJ4RRck4fU+KK+WFHaNCP8139+7OAhxLWh66l6sxN0zN+YjpnebZ4r7RlSSGvDYPQfERMIRy5Jf4Ux7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUHG8hUN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe6672297so1317501cf.1;
        Wed, 14 Aug 2024 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723664479; x=1724269279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7nxP/0wlxFkVaeXCvOut63mGk6zyQ8GTLenWGDTFAU=;
        b=iUHG8hUNN5xAu5W1YP0Vmv6eYs/g91sq9XxYcJBw8SfwsWkIxdG8rnEM+etJ87Sd8U
         k5VkOKz5P4uUHVyr/yJACNGqs4UJkdRgGdG+yD8x8IEjkh7I2GtIAxc+HWk7uCA4O2Y8
         FK4BAolWy30+Fl2enOLQ9GJhczzfOvxrl0fZGYf9G4zSpADEL7nS0RdJEnA5tFyrTsE1
         ZhBWPVaaliXxqsxJ53qMwNCjud+jV/k91mmBH6BllGUO8KMJNqAVEtH+FdYHmaBqcipO
         rodGysBH/siJ60LbQ2rtGdUzlwV4fEKmkEWt//1MRDjJM2mDw1BiM5S4tWC7/xcRFEX8
         Eidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723664479; x=1724269279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7nxP/0wlxFkVaeXCvOut63mGk6zyQ8GTLenWGDTFAU=;
        b=rtvFIjj2VYA09lALHZKYVvWx1SdRAZpKZzE5fdgS5IK6ln11pfrOvkjupukGyntCrN
         vcZ/t+gFLY+EgcFOCru99lArbp19p2GSah6KqNQCItdRyakwSdCszGxvwsSZHm6t3lw/
         LUgsTLXHW/u0WNilliHs3c14wR1Dkl1SgdxaSYueB8uwjgtH2QhNpAmuPeCHh5MhOMCb
         bgQxJXBZLO6yIfmBp176LNCX4wRyqXztVlt3YD0NhF/pNTVbXAXFvAye+gglKkuAAtAe
         EsxPLBmF3gutDWyxuZYVXlWH+zVEBKD+d3yWggNJsAfBKA13zddpyWZEcklwXvLOUf30
         6Fkw==
X-Forwarded-Encrypted: i=1; AJvYcCVtC0IYy/HCx8ecuTLyHYGg5QbjbVq0GxbZ5eLPq2ikhJTFWJonFfRkauViEug0w6j79JJZmSMDD9ZwN91ei+/ZDZ0ja8ZoWxVy23H1ETCgyRSlsXytDxlWce+M6xKzhjMow23D3vr55hkm78k=
X-Gm-Message-State: AOJu0YwvdXdLEbRgZP7OJHXHKEcHE8gXAUD6fBJ7bTS5j3V3pYFVYnSu
	IgcYdR/7j7FcAgzA5xIQIvBRCVy/DJ69baVNB3XkCl5bYuPkL3qL
X-Google-Smtp-Source: AGHT+IG43s6HRKXNmIoIQMez0b4aDhVLwvUOvUZXa56lx5CPR6BaSlukxg+NEqSky6No4rxSBs7Hyw==
X-Received: by 2002:a05:622a:5a8a:b0:44f:f118:d875 with SMTP id d75a77b69052e-4535bb649aemr44940161cf.36.1723664478705;
        Wed, 14 Aug 2024 12:41:18 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7f12sm44629801cf.20.2024.08.14.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:41:18 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E088A120008C;
	Wed, 14 Aug 2024 15:33:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 15:33:43 -0400
X-ME-Sender: <xms:lwa9ZjEHnwkM3-0dwSWDJtmILlk4QkSiYMdcwoWAGFc7UZDM0UplCQ>
    <xme:lwa9ZgUyTmDuBlhvW1mZlj1ffSYIOnH2pTqyl6DCBDTSfr38yFhHQALc9xk9ZDVpA
    ceUNE7C54haSkB-gg>
X-ME-Received: <xmr:lwa9ZlIiOKwQwgbE0BxlHxofRUsmobhriM5MGrdEh-5Ur1sZkIZKatArGMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprh
    hothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhr
    ohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrghesshgrmhhsuhhnghdrtg
    homhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:lwa9ZhG1N8emzyFNaJqhBj2XetKPlOIy7uom0GRpeGTJSgatsjyPSg>
    <xmx:lwa9ZpUiVcUwnLDLR33nslFOqzrXxXALspMUua16n1qawyAB5WXGzA>
    <xmx:lwa9ZsMzlBqq_ytZOytRK4l0FDmR2OJbLNPZhk-7YYbHO3xTqnQoIA>
    <xmx:lwa9Zo3N_LuZXYrzRMbsrTYjNqEhxwUoTxEmzO9cH98wlFXdFZ9J1g>
    <xmx:lwa9ZuX__PdUNQIu_Z-WuWkLhzwiIiYMfvQ3Y6Txj0RL5OqoEA52JbPe>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 15:33:43 -0400 (EDT)
Date: Wed, 14 Aug 2024 12:32:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr0GP0OXliPRqx4C@boqun-archlinux>
References: <20240812182355.11641-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>

Hi Danilo,

On Mon, Aug 12, 2024 at 08:22:46PM +0200, Danilo Krummrich wrote:
> Hi,
> 
> This patch series adds generic kernel allocator support for Rust, which so far
> is limited to `kmalloc` allocations.
> 
> In order to abstain from (re-)adding unstable Rust features to the kernel, this
> patch series does not extend the `Allocator` trait from Rust's `alloc` crate,
> nor does it extend the `BoxExt` and `VecExt` extensions.
> 
> Instead, this series introduces a kernel specific `Allocator` trait, which is
> implemented by the `Kmalloc`, `Vmalloc` and `KVmalloc` allocators, also
> implemented in the context of this series.
> 
> As a consequence we need our own kernel `Box<T, A>` and `Vec<T, A>` types.
> Additionally, this series adds the following type aliases:
> 
> ```
> pub type KBox<T> = Box<T, Kmalloc>;
> pub type VBox<T> = Box<T, Vmalloc>;
> pub type KVBox<T> = Box<T, KVmalloc>;
> 
> 
> pub type KVec<T> = Vec<T, Kmalloc>;
> pub type VVec<T> = Vec<T, Vmalloc>;
> pub type KVVec<T> = Vec<T, KVmalloc>;
> ```
> 
> With that, we can start using the kernel `Box` and `Vec` types throughout the
> tree and remove the now obolete extensions `BoxExt` and `VecExt`.
> 
> For a final cleanup, this series removes the last minor dependencies to Rust's
> `alloc` crate and removes it from the entire kernel build.
> 
> The series ensures not to break the `rusttest` make target by implementing the
> `allocator_test` module providing a stub implementation for all kernel
> `Allocator`s.
> 
> This patch series passes all KUnit tests, including the ones added by this
> series. Additionally, the tests were run with `kmemleak` and `KASAN` enabled,
> without any issues.
> 
> This series is based on [1], which hit -mm/mm-unstable, and is also available
> in [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
> 
> Changes in v5:
>  - (safety) comment / documentation fixes suggested by Alice, Benno and Gary
>  - remove `Unique<T>` and implement `Send` and `Sync` for `Box` and `Vec`
>  - use `KMALLOC_MAX_SIZE` for `KVmalloc` test and add a `Kmalloc` test that
>    expects to fail for `KMALLOC_MAX_SIZE`
>  - create use constants `KREALLOC`, `VREALLOC` and `KVREALLOC` for
>    `ReallocFuncs`
>  - drop `Box::drop_contents` for now, will add it again, once I actually rebase
>    on the original patch that introduces it

I'm trying to put your series on rust-dev, but I hit a few conflicts due
to the conflict with `Box::drop_contents`, which has been in rust-dev
for a while. And the conflict is not that trivial for me to resolve.
So just a head-up, that's a requirement for me to put it on rust-dev for
more tests from my end ;-)

Regards,
Boqun

>  - improve usage of `size_of_val` in `Box`
>  - move `InPlaceInit` and `ForeignOwnable` impls into kbox.rs
>  - fix missing `Box` conversions in rnull.rs
>  - reworked `Cmalloc` to keep track of the size of memory allocations itself
>  - remove `GlobalAlloc` together with the `alloc` crate to avoid a linker error
>  - remove `alloc` from scripts/generate_rust_analyzer.py
> 
[...]

