Return-Path: <linux-kernel+bounces-245900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345D92BAFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F481F2175D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3315B57A;
	Tue,  9 Jul 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJu15Kp0"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5049382
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531589; cv=none; b=EksL20FVyM7/WZAhbwF+s2B2wyaqIuPL8ouKL+wSyJZyDQOAC1jLsXhREbcw3ymxYkAeYEZVMqMunUREjlyPuMu5h/8tez9stG8aXYCbuM9RHMJSDohj4RGFthHGdubALJwjA3acM5O19uVM0G8sSoFWFuAgHi+ZlR1uEdDqGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531589; c=relaxed/simple;
	bh=6WKOe37mxUTkug8sK5724WFmpZAnjnbPNun28ZV3tSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qY2iX28Qj+ncDPf78GDBgXMgm5gPWbx7GguaIAzftRGDvAxDWmWN6gaZubmct6ToyaW42vTz/yiZk06YjFbw0NAXqg+2bbFRVDl/QnJCcatd5eDSXT/0T5e7smLT8bZ0k7quR+JOy8BK/3APviE/eZd663EVs6lpF4eb2QDAKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJu15Kp0; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: flintglass@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720531585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXJuI7uI1qCv8xGpT5wNFuY2vtyb8QTYfSJpVlZ43kY=;
	b=uJu15Kp0Gc3uZ5gTkAbUQdOALV9UDlVCIFe+aqLZ33fbq+d79F2WBUIylcKdM3M5dIMr9T
	SUItIfy9gyqmeWg5MmnuJbO3dYb11sw5Nz3ITLBAs5r/PnPH6UgjeXBAJU9ehyCuyGlI3T
	UbZqN6NB5P4bmntG0BFIzyF/UMuA+WU=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <cc5ba793-59a4-4904-a1b3-723ebaa3a93e@linux.dev>
Date: Tue, 9 Jul 2024 21:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
 <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com>
 <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
 <CAPpoddfySkGpD5hKgqUAAMgMp2vWcivg1AzcyYh_NP1-ZsGkug@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAPpoddfySkGpD5hKgqUAAMgMp2vWcivg1AzcyYh_NP1-ZsGkug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/8 21:44, Takero Funaki wrote:
> 2024年7月8日(月) 12:56 Chengming Zhou <chengming.zhou@linux.dev>:
> 
>>>        comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>>>        dlen = acomp_ctx->req->dlen;
>>> -     if (comp_ret)
>>> +
>>> +     /* coa_compress returns -EINVAL for errors including insufficient dlen */
>>> +     if (comp_ret && comp_ret != -EINVAL)
>>>                goto unlock;
>>
>> Seems we don't need to care about? "comp_ret" is useless anymore.
>>
>> Just:
>>
>> if (comp_ret || dlen > PAGE_SIZE - 64)
>>          dlen = PAGE_SIZE;
>>
>> And remove the checkings of comp_ret at the end.
>>
> 
>>
>> We actually don't need to hold mutex if we are just copying folio.
>>
>> Thanks.
>>
> 
> Thanks for reviewing.
> 
> For comp_ret, can we consolidate all possible error codes as
> incompressible data?

Maybe we still want these debug counters? I'm not sure.

With your proposal, I think we don't care about compression failures
anymore, in all cases it's just ok to fallback to just copy the folio.

> if we do not need to distinguish -EINVAL and the others, diff v2..v3
> can be like:
> 
> @@ -62,8 +62,6 @@ static u64 zswap_pool_limit_hit;
>   static u64 zswap_written_back_pages;
>   /* Store failed due to a reclaim failure after pool limit was reached */
>   static u64 zswap_reject_reclaim_fail;
> -/* Store failed due to compression algorithm failure */
> -static u64 zswap_reject_compress_fail;
>   /* Compressed page was too big for the allocator to (optimally) store */
>   static u64 zswap_reject_compress_poor;
>   /* Store failed because underlying allocator could not get memory */
> @@ -1043,10 +1041,6 @@ static bool zswap_compress(struct folio *folio,
> struct zswap_entry *entry)
>          comp_ret =
> crypto_wait_req(crypto_acomp_compress(acomp_ctx->req),
> &acomp_ctx->wait);
>          dlen = acomp_ctx->req->dlen;
> 
> -       /* coa_compress returns -EINVAL for errors including
> insufficient dlen */
> -       if (comp_ret && comp_ret != -EINVAL)
> -               goto unlock;
> -
>          /*
>           * If the data cannot be compressed well, store the data as-is.
>           * Switching by a threshold at
> @@ -1056,7 +1050,8 @@ static bool zswap_compress(struct folio *folio,
> struct zswap_entry *entry)
>           */
>          if (comp_ret || dlen > PAGE_SIZE - 64) {
>                  /* we do not use compressed result anymore */
> -               comp_ret = 0;
> +               mutex_unlock(&acomp_ctx->mutex);
> +               acomp_ctx = NULL;
>                  dlen = PAGE_SIZE;
>          }
>          zpool = zswap_find_zpool(entry);
> @@ -1083,12 +1078,11 @@ static bool zswap_compress(struct folio
> *folio, struct zswap_entry *entry)
>   unlock:
>          if (alloc_ret == -ENOSPC)
>                  zswap_reject_compress_poor++;
> -       else if (comp_ret)
> -               zswap_reject_compress_fail++;

If you want to keep these debug counters, you can move these forward.

>          else if (alloc_ret)
>                  zswap_reject_alloc_fail++;
> 
> -       mutex_unlock(&acomp_ctx->mutex);
> +       if (acomp_ctx)
> +               mutex_unlock(&acomp_ctx->mutex);
>          return comp_ret == 0 && alloc_ret == 0;

And here we don't care about comp_ret anymore.

Thanks.

>   }
> 
> @@ -1886,8 +1880,6 @@ static int zswap_debugfs_init(void)
>                             zswap_debugfs_root, &zswap_reject_alloc_fail);
>          debugfs_create_u64("reject_kmemcache_fail", 0444,
>                             zswap_debugfs_root, &zswap_reject_kmemcache_fail);
> -       debugfs_create_u64("reject_compress_fail", 0444,
> -                          zswap_debugfs_root, &zswap_reject_compress_fail);
>          debugfs_create_u64("reject_compress_poor", 0444,
>                             zswap_debugfs_root, &zswap_reject_compress_poor);
>          debugfs_create_u64("written_back_pages", 0444,

