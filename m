Return-Path: <linux-kernel+bounces-278683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA694B380
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21091F232B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8014E155725;
	Wed,  7 Aug 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKUwdXRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0056250EC;
	Wed,  7 Aug 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072592; cv=none; b=QBGdzBYybojpbd2XCy6R4cRaN9RJrB8X1mUDtm+eTtfmffpddHGdjbRTmakeNp35Jrv/upNf0/yGjLO7cmgRqCJvphYjh58HHYk7k9v8WvFCyhhHwIYXV272/LMfn9FX83n7wP/k2nja86eD9QD3s0b6bZ0RSYZSps04vUeKCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072592; c=relaxed/simple;
	bh=0e8i3yrU5eEM4KIlmo9+sD1Bswt/xzSmr+YS1e8TkuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjHo17zWJOiiUA4QyKZcEoMg9rzH0ItDZpPmadZ4wt+6VZv+vXdsB1uWEQoGij5Wr3ftLbJgmKz8rX0EGuTHip9uE+Nv3XfXY27XJoNRz8tZH5c0CElUaiQkhQ8pbZBjkOe7PcdDJzx3mYXtmK6wo2472O6cN7M0XL6vmgd7AoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKUwdXRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC52C32781;
	Wed,  7 Aug 2024 23:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723072592;
	bh=0e8i3yrU5eEM4KIlmo9+sD1Bswt/xzSmr+YS1e8TkuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKUwdXRfLsIl+eGYTR+1tp6fFtJsUuy43hU68qwmHBXaS2GVmQA3FdO18Y2XQDl2S
	 eBzFl5HW01HQvhbLIcqPKloNSMpNTafFMlR3pxitqoyUVJzSopWFqvbPV/UPbkJTC5
	 XtuuwWrqQJoLIHVDpSI29B0dQYcaueEw60jyeVP+J7EbV79JxCkyyZpnuwQWziGbFQ
	 +jL+JZZccIbN/Lfhqwbc+6AJCrtK/tnbbAse3kqWThhRaRZAkvtA30aJyr2tJPeTvF
	 0Le/5rjahUgAtS7001Tw51uiImlmreQD9s7UwW/NCRqdV4hWLUr2VeS1YdtiF6YP6P
	 9xAKLeQRJx9QQ==
Date: Thu, 8 Aug 2024 01:16:22 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 21/28] rust: alloc: remove `GlobalAlloc` and
 `krealloc_aligned`
Message-ID: <ZrQARho24sFfqlYM@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-22-dakr@kernel.org>
 <498e0141-8df5-46a7-b891-e1cb754f49e2@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498e0141-8df5-46a7-b891-e1cb754f49e2@proton.me>

On Wed, Aug 07, 2024 at 09:23:04PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
> > Now that we have all the `Allocator`s and the kernel `Box` and `Vec`
> > implementations in place, remove `GlobalAlloc` and `krealloc_aligned`.
> 
> When I try to compile this patch, then I get this error:
> 
>       UPD     include/generated/utsversion.h
>       CC      init/version-timestamp.o
>       KSYMS   .tmp_vmlinux0.kallsyms.S
>       AS      .tmp_vmlinux0.kallsyms.o
>       LD      .tmp_vmlinux1
>     ld.lld: error: undefined symbol: __rust_realloc
>     >>> referenced by usercopy_64.c
>     >>>               vmlinux.o:(alloc::raw_vec::finish_grow::<alloc::alloc::Global>)
>     
>     ld.lld: error: undefined symbol: __rust_alloc
>     >>> referenced by usercopy_64.c
>     >>>               vmlinux.o:(alloc::raw_vec::finish_grow::<alloc::alloc::Global>)
>     make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> 
> So maybe the `#[global_allocator]` needs to stay until we remove the
> `alloc` dependency?

Yes, I think so. I compile checked the single patches with `M=rust` and
`M=drivers`, which only compiles, but doesn't link things, so it didn't catch
it.

> 
> ---
> Cheers,
> Benno
> 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc/allocator.rs | 63 ++--------------------------------
> >  1 file changed, 2 insertions(+), 61 deletions(-)
> 

