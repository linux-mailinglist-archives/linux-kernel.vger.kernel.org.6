Return-Path: <linux-kernel+bounces-268206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CF69421A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A5E286295
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3518CC00;
	Tue, 30 Jul 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LoKwtyZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346118C90B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371742; cv=none; b=KovpjI2A1cTd7QsJ/hv6d1GKT5JnNkODqJYqmImluRM3wQZYySKvwZtGLoU7ti9/0wAbDBBWz1j09Y9m3+f4kwaZpWPFYkdaLUE3BN4veaYd+Pw/gN+5dU+X91dQOw5dnnQb+8olq4mnjjrh6uKxg1chp3CdJ9sK3zrjejZo/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371742; c=relaxed/simple;
	bh=WZ48PPmVTj+kJ37rNAFT+iZMowNbWwVK6vyYDSGVsDI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O9aJXEQWRLIesUBsBqLzXMHRc7aK7cz4g8a50txJ1CPVCCfX/dga0w/QqCzETVf8BM0/4flv2GWVP3XFI+oWKWVPShN/h3vmImffZ6gSE/jMXHiUw1JI166mGCq+etiltwHn9Zz+/8xIBukfGk1lYEo5oigmMIkENPRClAjrGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LoKwtyZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6802DC32782;
	Tue, 30 Jul 2024 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722371741;
	bh=WZ48PPmVTj+kJ37rNAFT+iZMowNbWwVK6vyYDSGVsDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoKwtyZCWE2yjnIRT5ga53Sub0TuDnNiKxE56ul46UQs1lenSt7iHzfQn8VVmfrat
	 P2b8NUhXmehN7v0LCy3P6BGqT6Vz3qXppkaR3Q/taSqH2nPyi523OHKKOcORTiG8Yo
	 pUhiDHe/CkmVEyPc2vROrZVUusQX7uW6zY5qwsBk=
Date: Tue, 30 Jul 2024 13:35:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: krealloc: clarify valid usage of __GFP_ZERO
Message-Id: <20240730133540.66e215082a513509c0d8649c@linux-foundation.org>
In-Reply-To: <20240730194214.31483-2-dakr@kernel.org>
References: <20240730194214.31483-1-dakr@kernel.org>
	<20240730194214.31483-2-dakr@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 21:42:06 +0200 Danilo Krummrich <dakr@kernel.org> wrote:

> Properly document that if __GFP_ZERO logic is requested, callers must
> ensure that, starting with the initial memory allocation, every
> subsequent call to this API for the same memory allocation is flagged
> with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> honored by this API.
> 
> ...
>
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -733,6 +733,14 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
>   * @new_n: new number of elements to alloc
>   * @new_size: new size of a single member of the array
>   * @flags: the type of memory to allocate (see kmalloc)
> + *
> + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> + * initial memory allocation, every subsequent call to this API for the same
> + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> + * __GFP_ZERO is not fully honored by this API.
> + *
> + * In any case, the contents of the object pointed to are preserved up to the
> + * lesser of the new and old sizes.
>   */
>  static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
>  								       size_t new_n,
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cff602cedf8e..faa13f42b111 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1301,11 +1301,17 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>   * @new_size: how many bytes of memory are required.
>   * @flags: the type of memory to allocate.
>   *
> - * The contents of the object pointed to are preserved up to the
> - * lesser of the new and old sizes (__GFP_ZERO flag is effectively ignored).
>   * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
>   * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
>   *
> + * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
> + * initial memory allocation, every subsequent call to this API for the same
> + * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
> + * __GFP_ZERO is not fully honored by this API.
> + *
> + * In any case, the contents of the object pointed to are preserved up to the
> + * lesser of the new and old sizes.
> + *
>   * Return: pointer to the allocated memory or %NULL in case of error
>   */
>  void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)

In both cases, we're saying "callers should do X".  I think it would be
better to say "this implementation does A, hence callers should do X". 
Tell people what's going on.

eg, "if krealloc is expanding an existing allocation, the newly-added
memory will be uninitialized unless the caller used __GFP_ZERO".  Or
something like that.

I assume that if the caller actually touches the uninitialized memory,
KASAN will warn?

