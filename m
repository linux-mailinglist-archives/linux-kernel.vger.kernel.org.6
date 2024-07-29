Return-Path: <linux-kernel+bounces-265882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FA93F736
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C43B217E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6E14E2CC;
	Mon, 29 Jul 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITlZ4kKq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAF548F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261890; cv=none; b=U+2J3LWVeFIvad5yDJXHugEsghbr4vu4CRKuvfxKf6Z7XMkqptbMEFjxRP12K5wFyk5mWDMlXlMWYLZItc9dJUQ+zS2ZA3O3HV0KR01MSxLLvQ44pRxBSFeCkUNd5smkyuDSHT5G7ztCW5bgU7vWTgGQsQpHvn9cugXenySEAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261890; c=relaxed/simple;
	bh=ZVd1wLbIXQ8ZLPr5bbxQq6cA26XTlob5JnFq04gG5/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvJCboeHeLHmhSgEPM5QG1PrioKUtJFkZUh2HcPxkxB1wDQh87f1pSOQ13o3clKOyzI9cFF1AXFQZ1jR8jiUnmJzY4wHiwy3RthddsJz2nw0pBpDCFO3irf5cPbVfSMVLUML2dEIWZgAvdoRUbCiRJA5lpXn/e33HzMaai2hovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITlZ4kKq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722261887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=seITf6olqHoUMiJoGULrFR+dE+Vd4KusIJcWOZ1cpOc=;
	b=ITlZ4kKq5VsxcYHuKowXWw0ree1l/oD5zZDWXxH75yYS2Xi0T1Eh8n+s1uS+E6oqrQ5aix
	owH7Y+2yivo4EiqVLqiW9KqAIvtdQ4+WE3vYkYegKAetOi47K3AwIpqsMoFQl7UuEGUbCg
	ZoUCAZT+mSxw8R8oSPQltvftXReU+SE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-bakvqNqINs-edShe4RG92w-1; Mon, 29 Jul 2024 10:04:44 -0400
X-MC-Unique: bakvqNqINs-edShe4RG92w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f01b9ae749so33271901fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261883; x=1722866683;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=seITf6olqHoUMiJoGULrFR+dE+Vd4KusIJcWOZ1cpOc=;
        b=GUu/x3UBpoLH2Op8Bqu+ou8nVEQlOKAUOs7UyaGxwxZ9cCKJfTVWok4OyvQJOvhGdm
         wXJSr7asY6QcsxzMbWJzEK0kEwbc6roekVwYV0VA5pTkEY0vX2X+NTnrlpYNLjPU8Vry
         KVxeKTfPcfZLw6LRRsVSSZBPx2eKJgs80W6ZOYAmSY1YfSIiIJsbPxIJaGFaEbHPAupa
         25qrFXpOC0JNLG2TJS7ODQeNC1O/G2Xps0HrV3122qe6yJx5E4OxQSFPtu6b/fdCyD7o
         FT2cICbZHlaINDKQWUdqvwIzCrunZAlG+d6uhQKJK93sVMHiQ/oppD8obksA3C+YfBr/
         2SRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLwWZlNHOJ82946zFtx3eccUdFcdbTJ22VP6qYHwYok9DezYVDjqkpt3gkeW5+Wxd/RrvunH9vRqasTtqDUZi7WNmzCf4OGJMx6HIs
X-Gm-Message-State: AOJu0YzNmi/CnbIh5Z+Cp3bSF73xKyiFcyp0j5EHmf60pm/o2ea3h92D
	X7PqdvUbtAM3HNALF/3ylIdLUaWPbH+Q9OKSwpkOy5Hy582EEBt6dOrAZfDEhb+Lgwskgksgkb2
	hcpwG0Z0udkWy9GgALKyeF7yML0pbm02Jk4atc9kinNFJXwF/QRAvMI6i0Chlxw==
X-Received: by 2002:a2e:9953:0:b0:2ef:2d58:ec24 with SMTP id 38308e7fff4ca-2f12ecd30f5mr51524691fa.17.1722261882852;
        Mon, 29 Jul 2024 07:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyMeeB9M53Yzivgnz9CHhYXVGw9TozJ6xgxNvirs0R74PymTXNTcKBmv8+fRe64Owks2WqNg==
X-Received: by 2002:a2e:9953:0:b0:2ef:2d58:ec24 with SMTP id 38308e7fff4ca-2f12ecd30f5mr51519091fa.17.1722261870236;
        Mon, 29 Jul 2024 07:04:30 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm181131525e9.9.2024.07.29.07.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:04:29 -0700 (PDT)
Message-ID: <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
Date: Mon, 29 Jul 2024 16:04:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1719038884-1903-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.06.24 08:48, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
> ...) to pin memory.  Normally if a page is present and in CMA area,
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> area because of FOLL_LONGTERM flag. But the current code will cause the
> migration failure due to unexpected page refcounts, and eventually cause
> the virtual machine fail to start.
> 
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is not
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail.
> 
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page).
> Seems making the LRU flag of the page invisible a long time is no problem,
> because a new page is allocated from buddy and added to the lru batch,
> its LRU flag is also not visible for a long time.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index dc205bd..9caf6b0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>   	for (i = 0; i < folio_batch_count(fbatch); i++) {
>   		struct folio *folio = fbatch->folios[i];
>   
> -		/* block memcg migration while the folio moves between lru */
> -		if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
> -			continue;
> -
>   		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>   		move_fn(lruvec, folio);
>   
> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>   void folio_rotate_reclaimable(struct folio *folio)
>   {
>   	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
> -	    !folio_test_unevictable(folio) && folio_test_lru(folio)) {
> +	    !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   		unsigned long flags;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock_irqsave(&lru_rotate.lock, flags);
>   		fbatch = this_cpu_ptr(&lru_rotate.fbatch);
>   		folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>   
>   void folio_activate(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && !folio_test_active(folio) &&
> -	    !folio_test_unevictable(folio)) {
> +	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock(&cpu_fbatches.lock);
>   		fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>   		folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>   		return;
>   
>   	folio_get(folio);
> +	if (!folio_test_clear_lru(folio)) {
> +		folio_put(folio);
> +		return;
> +	}
> +
>   	local_lock(&cpu_fbatches.lock);
>   	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>   	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>    */
>   void folio_deactivate(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
> -	    (folio_test_active(folio) || lru_gen_enabled())) {
> +	if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
> +	    lru_gen_enabled())) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}
> +
>   		local_lock(&cpu_fbatches.lock);
>   		fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>   		folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>    */
>   void folio_mark_lazyfree(struct folio *folio)
>   {
> -	if (folio_test_lru(folio) && folio_test_anon(folio) &&
> -	    folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
> -	    !folio_test_unevictable(folio)) {
> +	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
>   		struct folio_batch *fbatch;
>   
>   		folio_get(folio);
> +		if (!folio_test_clear_lru(folio)) {
> +			folio_put(folio);
> +			return;
> +		}

Looking at this in more detail, I wonder if we can turn that to

if (!folio_test_clear_lru(folio))
	return;
folio_get(folio);

In all cases? The caller must hold a reference, so this should be fine.

-- 
Cheers,

David / dhildenb


