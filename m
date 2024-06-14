Return-Path: <linux-kernel+bounces-214864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAB908B42
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48937288223
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79985195FE5;
	Fri, 14 Jun 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kucfFyQm"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A782195F0D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366878; cv=none; b=DfLLELCycn0WQEE1HifwGz020VSC9s/8H2qigZ71F+8zBjs0Uoc6ThRjXBwuHj0qYWZJCh7M5YCqZi9iHTJz/1vnyBOglVS3dAyjM+9NiFmKkGqDVaCzlJoQVGi00jNu4LnvU947R7cmCUP2KGgsCbUDNboExbrMYQJuxtGICUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366878; c=relaxed/simple;
	bh=lcFtH23e9Rt5eW1X9f2TiDWQqZjY+r2KCNmf9AiRlI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj1XO0UqNW8//66/BeqKQ36JYvdqLMz1SASo6N9J4/dNJVROvJwxLN7SV6zNmG6Ql+arH8M5RPc6SQhswUdlOOzYCFexnyS5hFjqd1ZsQ8r3HX5wc1FpUnwS7/j9v1a0DQbuiBQf/hqfWWm03EFDRhpac+4Fubg5J0jtCVGLXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kucfFyQm; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: usamaarif642@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718366874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peu4HYA3Smy92EmNKG1/7ckvk78sjW9rJi3oNPg4ZUo=;
	b=kucfFyQmn6AtisEDi9oL9J/EEUkUwEDe1iYX6QGTVV4LtG5BwKBsQZiYHUteBMNWJYdbAT
	AgXU5y2Gefqn8NKIbsluwNMhvBHGy7TXurwbuOnpaochqFRlqZt5meEyu5ObJDxYntchub
	2Ft5EVjMO50Q7jllRRqnPBVhxnrvK5E=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: david@redhat.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: hughd@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Message-ID: <0e17c634-842b-40f6-b3bd-e4b98ed1dc8f@linux.dev>
Date: Fri, 14 Jun 2024 20:07:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] mm: remove code to handle same filled pages
Content-Language: en-US
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
 <20240614100902.3469724-3-usamaarif642@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240614100902.3469724-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/14 18:07, Usama Arif wrote:
> With an earlier commit to handle zero-filled pages in swap directly,
> and with only 1% of the same-filled pages being non-zero, zswap no
> longer needs to handle same-filled pages and can just work on compressed
> pages.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Looks good to me, thanks.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  mm/zswap.c | 86 +++++-------------------------------------------------
>  1 file changed, 8 insertions(+), 78 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a546c01602aa..e25a6808c2ed 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -44,8 +44,6 @@
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
>  atomic_t zswap_stored_pages = ATOMIC_INIT(0);
> -/* The number of same-value filled pages currently stored in zswap */
> -static atomic_t zswap_same_filled_pages = ATOMIC_INIT(0);
>  
>  /*
>   * The statistics below are not protected from concurrent access for
> @@ -188,11 +186,9 @@ static struct shrinker *zswap_shrinker;
>   *
>   * swpentry - associated swap entry, the offset indexes into the red-black tree
>   * length - the length in bytes of the compressed page data.  Needed during
> - *          decompression. For a same value filled page length is 0, and both
> - *          pool and lru are invalid and must be ignored.
> + *          decompression.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */
> @@ -200,10 +196,7 @@ struct zswap_entry {
>  	swp_entry_t swpentry;
>  	unsigned int length;
>  	struct zswap_pool *pool;
> -	union {
> -		unsigned long handle;
> -		unsigned long value;
> -	};
> +	unsigned long handle;
>  	struct obj_cgroup *objcg;
>  	struct list_head lru;
>  };
> @@ -820,13 +813,9 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>   */
>  static void zswap_entry_free(struct zswap_entry *entry)
>  {
> -	if (!entry->length)
> -		atomic_dec(&zswap_same_filled_pages);
> -	else {
> -		zswap_lru_del(&zswap_list_lru, entry);
> -		zpool_free(zswap_find_zpool(entry), entry->handle);
> -		zswap_pool_put(entry->pool);
> -	}
> +	zswap_lru_del(&zswap_list_lru, entry);
> +	zpool_free(zswap_find_zpool(entry), entry->handle);
> +	zswap_pool_put(entry->pool);
>  	if (entry->objcg) {
>  		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>  		obj_cgroup_put(entry->objcg);
> @@ -1268,11 +1257,6 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
>  	 * This ensures that the better zswap compresses memory, the fewer
>  	 * pages we will evict to swap (as it will otherwise incur IO for
>  	 * relatively small memory saving).
> -	 *
> -	 * The memory saving factor calculated here takes same-filled pages into
> -	 * account, but those are not freeable since they almost occupy no
> -	 * space. Hence, we may scale nr_freeable down a little bit more than we
> -	 * should if we have a lot of same-filled pages.
>  	 */
>  	return mult_frac(nr_freeable, nr_backing, nr_stored);
>  }
> @@ -1376,42 +1360,6 @@ static void shrink_worker(struct work_struct *w)
>  	} while (zswap_total_pages() > thr);
>  }
>  
> -/*********************************
> -* same-filled functions
> -**********************************/
> -static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
> -{
> -	unsigned long *data;
> -	unsigned long val;
> -	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
> -	bool ret = false;
> -
> -	data = kmap_local_folio(folio, 0);
> -	val = data[0];
> -
> -	if (val != data[last_pos])
> -		goto out;
> -
> -	for (pos = 1; pos < last_pos; pos++) {
> -		if (val != data[pos])
> -			goto out;
> -	}
> -
> -	*value = val;
> -	ret = true;
> -out:
> -	kunmap_local(data);
> -	return ret;
> -}
> -
> -static void zswap_fill_folio(struct folio *folio, unsigned long value)
> -{
> -	unsigned long *data = kmap_local_folio(folio, 0);
> -
> -	memset_l(data, value, PAGE_SIZE / sizeof(unsigned long));
> -	kunmap_local(data);
> -}
> -
>  /*********************************
>  * main API
>  **********************************/
> @@ -1423,7 +1371,6 @@ bool zswap_store(struct folio *folio)
>  	struct zswap_entry *entry, *old;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> -	unsigned long value;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1456,13 +1403,6 @@ bool zswap_store(struct folio *folio)
>  		goto reject;
>  	}
>  
> -	if (zswap_is_folio_same_filled(folio, &value)) {
> -		entry->length = 0;
> -		entry->value = value;
> -		atomic_inc(&zswap_same_filled_pages);
> -		goto store_entry;
> -	}
> -
>  	/* if entry is successfully added, it keeps the reference */
>  	entry->pool = zswap_pool_current_get();
>  	if (!entry->pool)
> @@ -1480,7 +1420,6 @@ bool zswap_store(struct folio *folio)
>  	if (!zswap_compress(folio, entry))
>  		goto put_pool;
>  
> -store_entry:
>  	entry->swpentry = swp;
>  	entry->objcg = objcg;
>  
> @@ -1528,13 +1467,9 @@ bool zswap_store(struct folio *folio)
>  	return true;
>  
>  store_failed:
> -	if (!entry->length)
> -		atomic_dec(&zswap_same_filled_pages);
> -	else {
> -		zpool_free(zswap_find_zpool(entry), entry->handle);
> +	zpool_free(zswap_find_zpool(entry), entry->handle);
>  put_pool:
> -		zswap_pool_put(entry->pool);
> -	}
> +	zswap_pool_put(entry->pool);
>  freepage:
>  	zswap_entry_cache_free(entry);
>  reject:
> @@ -1597,10 +1532,7 @@ bool zswap_load(struct folio *folio)
>  	if (!entry)
>  		return false;
>  
> -	if (entry->length)
> -		zswap_decompress(entry, folio);
> -	else
> -		zswap_fill_folio(folio, entry->value);
> +	zswap_decompress(entry, folio);
>  
>  	count_vm_event(ZSWPIN);
>  	if (entry->objcg)
> @@ -1703,8 +1635,6 @@ static int zswap_debugfs_init(void)
>  			    zswap_debugfs_root, NULL, &total_size_fops);
>  	debugfs_create_atomic_t("stored_pages", 0444,
>  				zswap_debugfs_root, &zswap_stored_pages);
> -	debugfs_create_atomic_t("same_filled_pages", 0444,
> -				zswap_debugfs_root, &zswap_same_filled_pages);
>  
>  	return 0;
>  }

