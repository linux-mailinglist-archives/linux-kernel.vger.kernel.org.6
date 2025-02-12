Return-Path: <linux-kernel+bounces-511437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E7A32B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCBE164492
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03422744D;
	Wed, 12 Feb 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBFyOMRB"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443E1B21AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376110; cv=none; b=oUM6/ILOn9ysZik3mk+SHSQ7LPr42HC60CPyJwfIjibED5ZYffFFzx8WaRMmcfEzqxQeIfz9nOgyYJ7h7e6nT6C1i5MflPRgQ7iNo2iZkAvpVDHJr4k3bFRWMlbS2DLNYEx9lDeLTYXI87/dcPbS9FsugIpXOOsvp7c1jOF0j1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376110; c=relaxed/simple;
	bh=O3xP3Kv4ue9SRZO9yoN0LhLQzJPAvXKalm0H21fLOcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im8MbtN5Bccebidu+a1BTDWrwSYJg/0RDcAJZUaAEpozaqYw+ZAAEWe2e7cZ0tv7surHnkEbSYiXBW7nD448OvytD1TKgSLFSCMJtCqTidwL8RjU8bd34fBNR8x8P/mzu8qAut/uJ9b3Ilk1fGrjTRhYxNXjuag8e1E1frBljvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBFyOMRB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Feb 2025 16:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739376106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4Nj4mEHCXAl1eKShLrxkBx5V4PjtNl3cv+kh46Bl/g=;
	b=kBFyOMRBYL+85+B/9XOMAECNpb9WXs453vaiFN50Gwpx/7q1XBlM188t7RXg0zP5QzTEa9
	E+rSCavAHMpFGgnjQBFUbfEuzWGOzDpFdjyatMYA8cw62QtqKlLtSMNNZcqZHXSYldWtcV
	KGGco0GAPlpcANByEU76P7o8ieZ/w5c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] zram: permit preemption with active compression
 stream
Message-ID: <Z6zF5QvTQwVoAhMP@google.com>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-3-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212063153.179231-3-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 12, 2025 at 03:27:00PM +0900, Sergey Senozhatsky wrote:
> Currently, per-CPU stream access is done from a non-preemptible
> (atomic) section, which imposes the same atomicity requirements on
> compression backends as entry spin-lock, and makes it impossible
> to use algorithms that can schedule/wait/sleep during compression
> and decompression.
> 
> Switch to preemptible per-CPU model, similar to the one used
> in zswap.  Instead of a per-CPU local lock, each stream carries
> a mutex which is locked throughout entire time zram uses it
> for compression or decompression, so that cpu-dead event waits
> for zram to stop using a particular per-CPU stream and release
> it.
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zcomp.c    | 36 +++++++++++++++++++++++++----------
>  drivers/block/zram/zcomp.h    |  6 +++---
>  drivers/block/zram/zram_drv.c | 20 +++++++++----------
>  3 files changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index bb514403e305..e83dd9a80a81 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -7,6 +7,7 @@
>  #include <linux/wait.h>
>  #include <linux/sched.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>

What code changes prompt this?

>  #include <linux/crypto.h>
>  #include <linux/vmalloc.h>
>  
> @@ -54,6 +55,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
>  {
>  	int ret;
>  
> +	mutex_init(&zstrm->lock);

I don't think we can initialize the mutex in the hotplug callback. I
think the following scenario is possible:

CPU #1					CPU #2
zcomp_stream_get()
  zstrm = raw_cpu_ptr()
/* task migrated to CPU 2 */

CPU goes offline
  zcomp_cpu_dead()
    mutex_lock()
    ..
    mutex_unlock()
					/* migrated task continues */
					zcomp_stream_get()
					  mutex_lock()
CPU goes online
  mutex_init()
  					  mutex_unlock() /* problem */
					
In this case we'll end up initializing the mutex on CPU #1 while CPU #2
has it locked. When we unlocked it on CPU #2 we will corrupt it AFAICT.

This is why I moved the mutex initialization out of the hotplug callback
in zswap. I suspect to do something similar for zram we'd need to do it
in zcomp_init()?

>  	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
>  	if (ret)
>  		return ret;
> @@ -109,13 +111,29 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
>  
>  struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
>  {
> -	local_lock(&comp->stream->lock);
> -	return this_cpu_ptr(comp->stream);
> +	for (;;) {
> +		struct zcomp_strm *zstrm = raw_cpu_ptr(comp->stream);
> +
> +		/*
> +		 * Inspired by zswap
> +		 *
> +		 * stream is returned with ->mutex locked which prevents
> +		 * cpu_dead() from releasing this stream under us, however
> +		 * there is still a race window between raw_cpu_ptr() and
> +		 * mutex_lock(), during which we could have been migrated
> +		 * to a CPU that has already destroyed its stream.  If so

"we could have been migrated from** a CPU that has already destroyed its
stream"? Right?

> +		 * then unlock and re-try on the current CPU.
> +		 */
> +		mutex_lock(&zstrm->lock);
> +		if (likely(zstrm->buffer))
> +			return zstrm;
> +		mutex_unlock(&zstrm->lock);
> +	}
>  }
>  
> -void zcomp_stream_put(struct zcomp *comp)
> +void zcomp_stream_put(struct zcomp_strm *zstrm)
>  {
> -	local_unlock(&comp->stream->lock);
> +	mutex_unlock(&zstrm->lock);
>  }
>  
>  int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
> @@ -151,12 +169,9 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
>  int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
> -	struct zcomp_strm *zstrm;
> +	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
>  	int ret;
>  
> -	zstrm = per_cpu_ptr(comp->stream, cpu);
> -	local_lock_init(&zstrm->lock);
> -
>  	ret = zcomp_strm_init(comp, zstrm);
>  	if (ret)
>  		pr_err("Can't allocate a compression stream\n");
> @@ -166,10 +181,11 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
>  int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
> -	struct zcomp_strm *zstrm;
> +	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
>  
> -	zstrm = per_cpu_ptr(comp->stream, cpu);
> +	mutex_lock(&zstrm->lock);
>  	zcomp_strm_free(comp, zstrm);
> +	mutex_unlock(&zstrm->lock);
>  	return 0;
>  }
>  
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index ad5762813842..23b8236b9090 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -3,7 +3,7 @@
>  #ifndef _ZCOMP_H_
>  #define _ZCOMP_H_
>  
> -#include <linux/local_lock.h>
> +#include <linux/mutex.h>
>  
>  #define ZCOMP_PARAM_NO_LEVEL	INT_MIN
>  
> @@ -31,7 +31,7 @@ struct zcomp_ctx {
>  };
>  
>  struct zcomp_strm {
> -	local_lock_t lock;
> +	struct mutex lock;
>  	/* compression buffer */
>  	void *buffer;
>  	struct zcomp_ctx ctx;
> @@ -77,7 +77,7 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
>  void zcomp_destroy(struct zcomp *comp);
>  
>  struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
> -void zcomp_stream_put(struct zcomp *comp);
> +void zcomp_stream_put(struct zcomp_strm *zstrm);
>  
>  int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
>  		   const void *src, unsigned int *dst_len);
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3708436f1d1f..43f460a45e3e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1608,7 +1608,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
>  	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
>  	kunmap_local(dst);
>  	zs_unmap_object(zram->mem_pool, handle);
> -	zcomp_stream_put(zram->comps[prio]);
> +	zcomp_stream_put(zstrm);
>  
>  	return ret;
>  }
> @@ -1769,14 +1769,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	kunmap_local(mem);
>  
>  	if (unlikely(ret)) {
> -		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> +		zcomp_stream_put(zstrm);
>  		pr_err("Compression failed! err=%d\n", ret);
>  		zs_free(zram->mem_pool, handle);
>  		return ret;
>  	}
>  
>  	if (comp_len >= huge_class_size) {
> -		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> +		zcomp_stream_put(zstrm);
>  		return write_incompressible_page(zram, page, index);
>  	}
>  
> @@ -1800,7 +1800,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  				   __GFP_HIGHMEM |
>  				   __GFP_MOVABLE);
>  	if (IS_ERR_VALUE(handle)) {
> -		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> +		zcomp_stream_put(zstrm);
>  		atomic64_inc(&zram->stats.writestall);
>  		handle = zs_malloc(zram->mem_pool, comp_len,
>  				   GFP_NOIO | __GFP_HIGHMEM |
> @@ -1812,7 +1812,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	}
>  
>  	if (!zram_can_store_page(zram)) {
> -		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> +		zcomp_stream_put(zstrm);
>  		zs_free(zram->mem_pool, handle);
>  		return -ENOMEM;
>  	}
> @@ -1820,7 +1820,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
>  
>  	memcpy(dst, zstrm->buffer, comp_len);
> -	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
> +	zcomp_stream_put(zstrm);
>  	zs_unmap_object(zram->mem_pool, handle);
>  
>  	zram_slot_lock(zram, index);
> @@ -1979,7 +1979,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>  		kunmap_local(src);
>  
>  		if (ret) {
> -			zcomp_stream_put(zram->comps[prio]);
> +			zcomp_stream_put(zstrm);
>  			return ret;
>  		}
>  
> @@ -1989,7 +1989,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>  		/* Continue until we make progress */
>  		if (class_index_new >= class_index_old ||
>  		    (threshold && comp_len_new >= threshold)) {
> -			zcomp_stream_put(zram->comps[prio]);
> +			zcomp_stream_put(zstrm);
>  			continue;
>  		}
>  
> @@ -2047,13 +2047,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>  			       __GFP_HIGHMEM |
>  			       __GFP_MOVABLE);
>  	if (IS_ERR_VALUE(handle_new)) {
> -		zcomp_stream_put(zram->comps[prio]);
> +		zcomp_stream_put(zstrm);
>  		return PTR_ERR((void *)handle_new);
>  	}
>  
>  	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
>  	memcpy(dst, zstrm->buffer, comp_len_new);
> -	zcomp_stream_put(zram->comps[prio]);
> +	zcomp_stream_put(zstrm);
>  
>  	zs_unmap_object(zram->mem_pool, handle_new);
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

