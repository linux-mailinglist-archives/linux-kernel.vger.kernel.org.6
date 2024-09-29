Return-Path: <linux-kernel+bounces-343035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDD989614
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AEC1C21146
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F02417C213;
	Sun, 29 Sep 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSvZqq8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D541465B8;
	Sun, 29 Sep 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727622858; cv=none; b=i4Qc6amN1VFuy8Wpfa+8TsHsy8s5Odl9Jgpt9Zos8O16DTZ/BCP0jk8lM8Fk2As04BZAKc9eMvehboiEKGZsmIGdOJzjCuVTZT16t++pXndh7xO9hkYSeBl0yP1/eqQDUxdDp0H4qN/l99U1fCoT/D+6ivdxcQ/HJ2ZCKQ23EKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727622858; c=relaxed/simple;
	bh=oaEjX3/xGXdgWu1xJM0CQYYIlbcXuyVjwzYezEaTK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCnznTZA8PihswA6/HfFiGSX5gZGB0J9eG3zUn3s5JgKK4WbslhKayKVX1b8u1fM6tnv9TMxFHI3j9XskfnpFL6ZoT2fwGqvAIjaLf4wr0HJQrKE/GJk9+tk3MOroFHGH/C+ofsvr1vQvjojkVDnVvFLSZv7Rmwki0B49GjO30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSvZqq8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43A2C4CEC5;
	Sun, 29 Sep 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727622857;
	bh=oaEjX3/xGXdgWu1xJM0CQYYIlbcXuyVjwzYezEaTK2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSvZqq8xyU7vmkvUjAT5SUzXcgvhtaPJ7/R/T4WWUhExlPsjWCZsClCgIqlwnJPJO
	 AgwnZ8tnn2qCEaYhzeGP0rEQXLLgXDVpYvJiK8IiwJhGwwfVpA6s5xF+o3z/RoNaPe
	 zXuOoumeZwQ9EAYPdpqT9E20zatm8dG3MFREr8h22TJrZuX7Lk8/W/TU3XeVmKr/hc
	 JiQ+ECx1ShPAeTrqsPoHMC0r/KvSuzsenAFnwsz/GjLYXdkRoBStI/VuHdrWeFEziN
	 8lA7mDU0c7Bhxos0OhBforeSi98kPMJf4yGHaZiMIhrzlQV59g8g7OP5IlGI7lIPop
	 p4BQgAafAcrOA==
Date: Sun, 29 Sep 2024 17:14:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 22/26] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZvluwEpbkLT4LP6Q@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-23-dakr@kernel.org>
 <20240928203552.4d490ca0.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928203552.4d490ca0.gary@garyguo.net>

On Sat, Sep 28, 2024 at 08:35:52PM +0100, Gary Guo wrote:
> On Thu, 12 Sep 2024 00:52:58 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > So far the kernel's `Box` and `Vec` types can't be used by userspace
> > test cases, since all users of those types (e.g. `CString`) use kernel
> > allocators for instantiation.
> > 
> > In order to allow userspace test cases to make use of such types as
> > well, implement the `Cmalloc` allocator within the allocator_test module
> > and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> > allocator uses libc's realloc() function as allocator backend.
> 
> I think this needs an explaination of why it needs a complex
> implementation instead of just using aligned_alloc and free.

The reason basically is that there's no `aligned_realloc` in libc. Anyways, it's
gonna simplified by the introduction of `old_layout`.

> 
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc/allocator_test.rs | 193 +++++++++++++++++++++++++++-
> >  1 file changed, 186 insertions(+), 7 deletions(-)
> 

