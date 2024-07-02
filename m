Return-Path: <linux-kernel+bounces-237504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0829E9239DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A8C2828E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D6152782;
	Tue,  2 Jul 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fgI7nkmx"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59464A06
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912326; cv=none; b=k9ZmKnWlqOAnRkcP4nMg0T1z/59xiCZcCpNqUZoZr+InT/GZzAAeak/bUUHVhzkvVQoBUvLWhziCUwm5FB5t9vcjLejCAfGk045NjjTxfNWmm/VZZF8N4R35NdlEBSRb25zBRbs3f7ieim7yuGGJByoCbXxlok1cXgGkcZJv8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912326; c=relaxed/simple;
	bh=Nvxisu21jPsb8LbI1c7CKoN6IL1eScA7epWq8jN4Ld4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1Kw6oGZO2mM0fQypl2qkvTcchCQ8pWf5jA2mEpbqq0WnnQQSvkSWPeLV9M/OGJgBZR7VvPRXE8U6YUOtnm0zDRDwZlBDKp4nSiepePIVnLpWXYhfCA1F0eemnSEKUbEVjSxJaNf8ieYTCTRE/VYeCvpATVatZ/7Rta8V78IdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fgI7nkmx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719912316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=88FhrTdAAOLnVCcdXcU1cjyLM244d5Y30iTtfNaAcY0=;
	b=fgI7nkmxV24TEHMqdRlkiqnYp3hux1NDzQNHy+ZhQNz4x5lq8WMRC6losy21K30dPOYQ3YiluVZ77Ey6PCdFV0w8TtzjZjrcPX/27XpVbqpc7q7fTVmqAmjgwWO6pEmdmTfx9zDH4g14jSZp0xqi/FMOhbLxtqNSVrlkjkBFj/k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W9iE.E5_1719912314;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9iE.E5_1719912314)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 17:25:14 +0800
Message-ID: <da6bad97-18b8-4cd0-9dcc-b60fb20b7a84@linux.alibaba.com>
Date: Tue, 2 Jul 2024 17:25:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/2 15:40, Hugh Dickins wrote:
> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
> flags when freeing, yet the flags shown are not bad: PG_locked had been
> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
> deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
> symptoms implying double free by deferred split and large folio migration.
> 
> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
> folio migration") was right to fix the memcg-dependent locking broken in
> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
> but missed a subtlety of deferred_split_scan(): it moves folios to its own
> local list to work on them without split_queue_lock, during which time
> folio->_deferred_list is not empty, but even the "right" lock does nothing
> to secure the folio and the list it is on.
> 
> Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
> while the old folio's reference count is temporarily frozen to 0 - adding
> such a freeze in the !mapping case too (originally, folio lock and
> unmapping and no swap cache left an anon folio unreachable, so no freezing
> was needed there: but the deferred split queue offers a way to reach it).

Thanks Hugh.

But after reading your analysis, I am concerned that the 
folio_undo_large_rmappable() and deferred_split_scan() may still 
encounter a race condition with the local list, even with your patch.

Suppose folio A has already been queued into the local list in 
deferred_split_scan() by thread A, but fails to 'folio_trylock' and then 
releases the reference count. At the same time, folio A can be frozen by 
another thread B in folio_migrate_mapping(). In such a case, 
folio_undo_large_rmappable() would remove folio A from the local list 
without *any* lock protection, creating a race condition with the local 
list iteration in deferred_split_scan().

Anyway, I think this patch can still fix some possible races. Feel free 
to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org
> ---
> This patch against 6.10-rc6: Kefeng has commits in the mm-tree which
> which will need adjustment to go over this, but we can both check the
> result.  I have wondered whether just reverting 85ce2c517ade and its
> subsequent fixups would be better: but that would be a bigger job,
> and probably not the right choice.
> 
>   mm/memcontrol.c | 11 -----------
>   mm/migrate.c    | 13 +++++++++++++
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 71fe2a95b8bd..8f2f1bb18c9c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
>   
>   	/* Transfer the charge and the css ref */
>   	commit_charge(new, memcg);
> -	/*
> -	 * If the old folio is a large folio and is in the split queue, it needs
> -	 * to be removed from the split queue now, in case getting an incorrect
> -	 * split queue in destroy_large_folio() after the memcg of the old folio
> -	 * is cleared.
> -	 *
> -	 * In addition, the old folio is about to be freed after migration, so
> -	 * removing from the split queue a bit earlier seems reasonable.
> -	 */
> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
> -		folio_undo_large_rmappable(old);
>   	old->memcg_data = 0;
>   }
>   
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 20cb9f5f7446..a8c6f466e33a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>   		if (folio_ref_count(folio) != expected_count)
>   			return -EAGAIN;
>   
> +		/* Take off deferred split queue while frozen and memcg set */
> +		if (folio_test_large(folio) &&
> +		    folio_test_large_rmappable(folio)) {
> +			if (!folio_ref_freeze(folio, expected_count))
> +				return -EAGAIN;
> +			folio_undo_large_rmappable(folio);
> +			folio_ref_unfreeze(folio, expected_count);
> +		}
> +
>   		/* No turning back from here */
>   		newfolio->index = folio->index;
>   		newfolio->mapping = folio->mapping;
> @@ -433,6 +442,10 @@ int folio_migrate_mapping(struct address_space *mapping,
>   		return -EAGAIN;
>   	}
>   
> +	/* Take off deferred split queue while frozen and memcg set */
> +	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
> +		folio_undo_large_rmappable(folio);
> +
>   	/*
>   	 * Now we know that no one else is looking at the folio:
>   	 * no turning back from here.

