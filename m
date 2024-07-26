Return-Path: <linux-kernel+bounces-262805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EF93CCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E7D1F2211F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8D2262B;
	Fri, 26 Jul 2024 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NBa2KAzd"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2A80B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964097; cv=none; b=EkMygwQjYqILjeOhIt9ZWsgSWdO/8KrYieozvCWXgPocHSbJz1pUf+eZYAAG7dPbzGlUN0XeRxeKbz6LjniS/1gBdEgMulJ8bRFnahRihnMFKlBeEsQ7nhr4VAAPhZkn0rIvZirGnP6+WbGxkMmPGtr+wNU4XjIZaF2irm2wmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964097; c=relaxed/simple;
	bh=lh76yuWtNxWwaediHnh0/2tC7QHuOXC6lXoJyi39cUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNbJQDobzwOZ3BBSWEiQnr0pSQwggR9wRZ79A/0hTbsf7ABUc87STGf/A5Ec+ZvoIasOR8xPs5jxZkg2zXi1HGXQPitdk/VNANNDOkENzniUDl7eC+h81OHQlYZ67zOS/FYU17JufxEGrovLJbu98/CLwNzs0+i9GuyVmzxW6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NBa2KAzd; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ac88791-54e2-4f7c-9171-5a1d44e01657@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721964092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DzQcvsVu423D9gDp/sw1eetVDLB1O9SBjw/8CnRb34=;
	b=NBa2KAzdfVwyCEfL+ExoNbhrTYMLE61UWRwpn1jNTAa16ONCwEj+FqDvDFhJreH2DB2v3Y
	b0ahqXH0lkUx4AiH3r7Pd9LdkTOX6xNfrL9ewVWtk/QkUi25VTeSMwBFx7HU9fvoAQ3ieQ
	zH5yqdj5U0z6g5pFURWqT4P9q+lHf3U=
Date: Fri, 26 Jul 2024 11:21:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling
 logic
To: Takero Funaki <flintglass@gmail.com>, Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed
 <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240720044127.508042-1-flintglass@gmail.com>
 <20240720044127.508042-3-flintglass@gmail.com>
 <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
 <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/24 00:44, Takero Funaki wrote:
> 2024年7月23日(火) 6:51 Nhat Pham <nphamcs@gmail.com>:
>>
>> On Fri, Jul 19, 2024 at 9:41 PM Takero Funaki <flintglass@gmail.com> wrote:
>>>
>>> This patch fixes zswap global shrinker that did not shrink zpool as
>>> expected.
>>>
>>> The issue it addresses is that `shrink_worker()` did not distinguish
>>> between unexpected errors and expected error codes that should be
>>> skipped, such as when there is no stored page in a memcg. This led to
>>> the shrinking process being aborted on the expected error codes.
>>
>> The code itself seems reasonable to me, but may I ask you to document
>> (as a comment) all the expected v.s unexpected cases? i.e when do we
>> increment (or not increment) the failure counter?
>>
> 
> In addition to changes in the commit log suggested by Yosry,
> adding some comments specifying what memcg is (not) candidates for
> writeback, and what should be a failure.
> 
> -       /* global reclaim will select cgroup in a round-robin fashion.
> +       /*
> +        * Global reclaim will select cgroup in a round-robin fashion from all
> +        * online memcgs, but memcgs that have no pages in zswap and
> +        * writeback-disabled memcgs (memory.zswap.writeback=0) are not
> +        * candidates for shrinking.
> +        *
> +        * Shrinking will be aborted if we encounter the following
> +        * MAX_RECLAIM_RETRIES times:
> +        * - No writeback-candidate memcgs found in a memcg tree walk.
> +        * - Shrinking a writeback-candidate memcg failed.
>           *
>           * We save iteration cursor memcg into zswap_next_shrink,
>           * which can be modified by the offline memcg cleaner
> 
> and, the reasons to (not) increment the progress:
> 
> @@ -1387,10 +1407,20 @@ static void shrink_worker(struct work_struct *w)
>                  /* drop the extra reference */
>                  mem_cgroup_put(memcg);
> 
> -               if (ret == -EINVAL)
> -                       break;
> +               /*
> +                * There are no writeback-candidate pages in the memcg.
> +                * This is not an issue as long as we can find another memcg
> +                * with pages in zswap. Skip this without incrementing progress
> +                * and failures.
> +                */
> +               if (ret == -ENOENT)
> +                       continue;
> +
>                  if (ret && ++failures == MAX_RECLAIM_RETRIES)
>                          break;
> +
> +               /* completed writeback or incremented failures */
> +               ++progress;

Maybe the name "progress" is a little confusing here? "progress" sounds 
to me that we have some writeback completed.

But actually it just means we have encountered some candidates, right?

Thanks.


>   resched:
> 
> 
>> My understanding is, we only increment the failure counter if we fail
>> to reclaim from a selected memcg that is non-empty and
>> writeback-enabled, or if we go a full tree walk without making any
>> progress. Is this correct?
>>
> 
> Yes, that's the expected behavior.
> Please let me know if there is more appropriate wording.
> 
> Thanks.

