Return-Path: <linux-kernel+bounces-228281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D261F915D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCE41C21554
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B213BACB;
	Tue, 25 Jun 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRWEk8ny"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2121A0C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719289885; cv=none; b=QFwRkm9a4xBQQ9YWjXFxzU1oH7tdlETlZnaZe32GkOo5+dIUergdjtaAkYA1Sz1OJU6tq1aJvzjAVUTYpcPSE+gXUoy8PmelD6VR7GOr5xVtr/q5ph6zzYJYNRj+Sn5G/NIUat70OquPtbzbjWydTmb97tsuzqwzEeKyA+aEwds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719289885; c=relaxed/simple;
	bh=wXZZfsJLLaIY+OUuNRqqk/vx4cdx2ts4YaSdAuOJmUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGPdLvTeNdcG/g/Jx5Rj/RosmSzLFB/oPK/4HkGvuApovnPGx3DlHfnPDWwjMCTlTbXBvSYQuxbBaeRHm6b7NyKG+SmsDey52wFvm3ZucUyRnK8slacq7d1CkeDJZlkKWELfR6GCA2Dvd9Mwsbi+1zprWvt9p93VK4Vzv6hiDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bRWEk8ny; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719289879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+STWZO5CMAxCSj0NI0Jy02Uub6PHOuwZTkIl4GXzvo=;
	b=bRWEk8ny/nPkkgTobgWE7Mu5yfIn4JCuCEnOfRALQCLQLRxJAhHWfPByga7LNU7KMfh81C
	c4R/uTYvuge0v34MgjJB1OtD2ibgyylNfWCP5+VNdcMOaFtTNVVU0onc8/JynTp1tbkKks
	1+Gmjx4d4dGEeyzUy7aKpiE5tMaWKV0=
X-Envelope-To: minchan@kernel.org
X-Envelope-To: senozhatsky@chromium.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: yuzhao@google.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <f52f007c-5418-4e01-99ed-f34892059a7b@linux.dev>
Date: Tue, 25 Jun 2024 12:31:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm/zswap: use only one pool in zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Takero Funaki <flintglass@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev>
 <20240621-zsmalloc-lock-mm-everything-v2-2-d30e9cd2b793@linux.dev>
 <CAJD7tkYUuAdwhSbq+m9KTtC2T8db7tiaKYjfS0M4LOA1yBtCkA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkYUuAdwhSbq+m9KTtC2T8db7tiaKYjfS0M4LOA1yBtCkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/24 20:14, Yosry Ahmed wrote:
> On Fri, Jun 21, 2024 at 12:15 AM Chengming Zhou
> <chengming.zhou@linux.dev> wrote:
>>
>> Zswap uses 32 pools to workaround the locking scalability problem in
>> zswap backends (mainly zsmalloc nowadays), which brings its own problems
>> like memory waste and more memory fragmentation.
>>
>> Testing results show that we can have near performance with only one
>> pool in zswap after changing zsmalloc to use per-size_class lock instead
>> of pool spinlock.
>>
>> Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB,
>> and zswap shrinker enabled with 10GB swapfile on ext4.
>>
>>                                  real    user    sys
>> 6.10.0-rc3                      138.18  1241.38 1452.73
>> 6.10.0-rc3-onepool              149.45  1240.45 1844.69
>> 6.10.0-rc3-onepool-perclass     138.23  1242.37 1469.71
>>
>> And do the same testing using zbud, which shows a little worse performance
>> as expected since we don't do any locking optimization for zbud. I think
>> it's acceptable since zsmalloc became a lot more popular than other
>> backends, and we may want to support only zsmalloc in the future.
>>
>>                                  real    user    sys
>> 6.10.0-rc3-zbud                 138.23  1239.58 1430.09
>> 6.10.0-rc3-onepool-zbud         139.64  1241.37 1516.59
>>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
>> ---
>>   mm/zswap.c | 60 +++++++++++++++++++-----------------------------------------
>>   1 file changed, 19 insertions(+), 41 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index e25a6808c2ed..7925a3d0903e 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -122,9 +122,6 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
>>   module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
>>                     uint, 0644);
>>
>> -/* Number of zpools in zswap_pool (empirically determined for scalability) */
>> -#define ZSWAP_NR_ZPOOLS 32
>> -
>>   /* Enable/disable memory pressure-based shrinker. */
>>   static bool zswap_shrinker_enabled = IS_ENABLED(
>>                  CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>> @@ -160,7 +157,7 @@ struct crypto_acomp_ctx {
>>    * needs to be verified that it's still valid in the tree.
>>    */
>>   struct zswap_pool {
>> -       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>> +       struct zpool *zpool;
>>          struct crypto_acomp_ctx __percpu *acomp_ctx;
>>          struct percpu_ref ref;
>>          struct list_head list;
>> @@ -237,7 +234,7 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>>
>>   #define zswap_pool_debug(msg, p)                               \
>>          pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>> -                zpool_get_type((p)->zpools[0]))
>> +                zpool_get_type((p)->zpool))
>>
>>   /*********************************
>>   * pool functions
>> @@ -246,7 +243,6 @@ static void __zswap_pool_empty(struct percpu_ref *ref);
>>
>>   static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>   {
>> -       int i;
>>          struct zswap_pool *pool;
>>          char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>>          gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>> @@ -267,18 +263,14 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>          if (!pool)
>>                  return NULL;
>>
>> -       for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
>> -               /* unique name for each pool specifically required by zsmalloc */
>> -               snprintf(name, 38, "zswap%x",
>> -                        atomic_inc_return(&zswap_pools_count));
>> -
>> -               pool->zpools[i] = zpool_create_pool(type, name, gfp);
>> -               if (!pool->zpools[i]) {
>> -                       pr_err("%s zpool not available\n", type);
>> -                       goto error;
>> -               }
>> +       /* unique name for each pool specifically required by zsmalloc */
>> +       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
>> +       pool->zpool = zpool_create_pool(type, name, gfp);
>> +       if (!pool->zpool) {
>> +               pr_err("%s zpool not available\n", type);
>> +               return NULL;
> 
> We need to goto error here to free the pool.
> 
>>          }
>> -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
>> +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
>>
>>          strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
>>
>> @@ -311,8 +303,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>>   error:
>>          if (pool->acomp_ctx)
>>                  free_percpu(pool->acomp_ctx);
>> -       while (i--)
>> -               zpool_destroy_pool(pool->zpools[i]);
>> +       zpool_destroy_pool(pool->zpool);
> 
> .. and then we will need a NULL check needed here.

Oops, my bad, will fix in the next version.

Thanks!

