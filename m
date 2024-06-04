Return-Path: <linux-kernel+bounces-200913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA78FB679
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FC11C2194B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85A13D523;
	Tue,  4 Jun 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcFyYteG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112051C3E;
	Tue,  4 Jun 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513356; cv=none; b=UKRTYUI76OTZXRFIB6DqQDIaSj2kLXWI6WRSHn+CCTcw45VcVP//u+4I9jlS1Olt3OmwbqWXaVByoJLSpTsZVZz6Tb8nJrk7vep3cHHn33w4hM3NN15ME/9MDmOAwVCVnvTmjsdFv18DBUqil64EQl26oTSpj1tZW11N8x//OdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513356; c=relaxed/simple;
	bh=xtJUyNxwB7M1j6qR9LAvxbMNOmZxHaugTMRR02cMN0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0HQKvPZoV2TroOOlgX9AvTFaaT39lKx5EbAQ4jRQtIL6FxLrzSfp6A9+cNbTwtzCi7WemwL4tms+gb4ZrokT9RSKoXnsG4j3kxtNgAgxL+VkN30g/ubAWy/66iQZf3VNTbFAVmf7cpZcIS4YzJqzb1aNUZM+Voo9p8QWQ/x9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcFyYteG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BD9C2BBFC;
	Tue,  4 Jun 2024 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513355;
	bh=xtJUyNxwB7M1j6qR9LAvxbMNOmZxHaugTMRR02cMN0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcFyYteGPx/DLK2FaeMM8zewZ/t0mDDBxMsBzBzhxtDLVgoapx658UcdzRfQ9xd8q
	 Fe8q8wddXOp4eBjWidUKbiB4xyPgrvn5Ibp8p6REqg2XtX/yAmhkLI8jGVuJKXB43e
	 aIWSCDddiK2YemWgtQ+VCuKqdcdoER9sYPiBv7ziIOKcPLdpB0fBpcfNgrcbIjK87i
	 AR2uG6QiuS0oZOgWOcyrurtPfWoUQetrTtOtkeyVgrsi+Te46ruuoBKTGLuBT52TRK
	 8QLogsZuUqOr1lZFpkG0nKIZ/TCwx2Enn+6TwYaR5/QM+qVYbc23ZG2QknvVuROtGN
	 YI7pW5PhSNevQ==
Date: Tue, 4 Jun 2024 16:02:28 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <20240604150228.GS491852@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
 <20240531191458.987345-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531191458.987345-4-kees@kernel.org>

On Fri, May 31, 2024 at 12:14:56PM -0700, Kees Cook wrote:

...

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b5c879fa66bc..f42a98d368a9 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -392,6 +392,82 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  }
>  EXPORT_SYMBOL(kmem_cache_create);
>  
> +static struct kmem_cache *kmem_buckets_cache __ro_after_init;
> +
> +kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
> +				  slab_flags_t flags,
> +				  unsigned int useroffset,
> +				  unsigned int usersize,
> +				  void (*ctor)(void *))
> +{
> +	kmem_buckets *b;
> +	int idx;
> +
> +	/*
> +	 * When the separate buckets API is not built in, just return
> +	 * a non-NULL value for the kmem_buckets pointer, which will be
> +	 * unused when performing allocations.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
> +		return ZERO_SIZE_PTR;
> +
> +	if (WARN_ON(!kmem_buckets_cache))
> +		return NULL;
> +
> +	b = kmem_cache_alloc(kmem_buckets_cache, GFP_KERNEL|__GFP_ZERO);
> +	if (WARN_ON(!b))
> +		return NULL;
> +
> +	flags |= SLAB_NO_MERGE;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> +		char *short_size, *cache_name;
> +		unsigned int cache_useroffset, cache_usersize;
> +		unsigned int size;
> +
> +		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
> +			continue;
> +
> +		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> +		if (!size)
> +			continue;
> +
> +		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
> +		if (WARN_ON(!short_size))
> +			goto fail;
> +
> +		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> +		if (WARN_ON(!cache_name))
> +			goto fail;
> +
> +		if (useroffset >= size) {
> +			cache_useroffset = 0;
> +			cache_usersize = 0;
> +		} else {
> +			cache_useroffset = useroffset;
> +			cache_usersize = min(size - cache_useroffset, usersize);
> +		}
> +		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> +					align, flags, cache_useroffset,
> +					cache_usersize, ctor);
> +		kfree(cache_name);
> +		if (WARN_ON(!(*b)[idx]))
> +			goto fail;
> +	}
> +
> +	return b;
> +
> +fail:
> +	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
> +		if ((*b)[idx])
> +			kmem_cache_destroy((*b)[idx]);

nit: I don't think it is necessary to guard this with a check for NULL.

> +	}
> +	kfree(b);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(kmem_buckets_create);

