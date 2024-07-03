Return-Path: <linux-kernel+bounces-239848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC7926609
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DF2B20C14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34615191F6F;
	Wed,  3 Jul 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgcl9TmP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE3191F75
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023693; cv=none; b=USLlNCkQRkBAG9P5c1LFUQtcw0D3dmqFgGk0FPMF/aJySHiKK3OprBDvn8CxcVnR2Ic/h91E6lazbPBOf1OKmAUvHo6++kb8zGnsTiElMrENFP0/9OF0JdjBsXPj+we17T5waw4MDqOmbVDBDdl279GXIYL5qEhprdpJj+Aq6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023693; c=relaxed/simple;
	bh=7Fr/8AXH10fwWtfuzbGDZzWL7YfdXQvhw0zhlDhQqps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JunsGdYS895DxVs/vRnQWI5aM9EplHt1+DIo60xX4pXO02pNRueLOE9A5Q8SZTlbD/WcpP7HRbeiSi4V4j/n1z5zpbTvNav/PtvxXXWfopi93dJtb/1N4hcBBaW1AJpgZ+cpgnNf5BnLhdPyW0IDi9qO7Q1908TJ8W5w+6XWZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgcl9TmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2TqXwLn9OXaIYIeKMDadbnKhFrbWHwcgxCj/8R0iL64=;
	b=fgcl9TmPuzwdMqPkfKeuUZixMHNTyIhU4Phew/hzntwZhkQUliOMaqPSBMKeUMK0ZXhbnk
	eT4UYLqdyXof0mHa+3Rq8xYexX1gkCYFcdxrwOROjH8KU8tMi9rMu9setVoorCrNb9UndD
	E5HzSHCtvjB3SbKJNU4E9Rkx8/BuWMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-dvdq6MosMF-tQota_IQWGA-1; Wed, 03 Jul 2024 12:21:27 -0400
X-MC-Unique: dvdq6MosMF-tQota_IQWGA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3678f832c75so1077207f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023686; x=1720628486;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TqXwLn9OXaIYIeKMDadbnKhFrbWHwcgxCj/8R0iL64=;
        b=RxEGweJijDzECNZynmn/L46BfEg1wngh9urm41ztwujzGRNoxUEVt7AqSHPV3DKDgR
         5HQd3RJzgon1dxJ2rq9/phf7Q14rQtFbxrHAoeTH6cGWbN2OHFXO3+U7NUYGA1wCQIEh
         zH5O6gunluQNZ/k08R7qwUdubLroYDmcdYw18HjI5ZAPnAxdun8r05N6dUSCmx5jT4Mr
         W24ufjW2s37GQcvgMG0rKjIfcsWW7zj3SVd/Sum/8o+Yqyk85zaoFOgRzXKMkmoJXaac
         sQ2Ookbalvx9NuPuGOvR/A1IJwmrwwCPNVEErUmc/dcI2a6dY7hlAB/Ud7H7A3ax0g4o
         wJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDab/KXNGOF+Z54snkyirqbbhfKdCH1ZoFUVML1Gx3JewBf26XRbD7RjaX/dF8jowAFjC0PWEO5Lgr2ZYrXqHow5tm+HEa7UgCrSmH
X-Gm-Message-State: AOJu0YwPVbAvWvKhc0kPr2gYtjQyRcnHyctWq2mrAWnLA7m/mDyQyoLZ
	SP1uWHt/8ZaxgVgHO+hhi5R9+zJJdSEbLEtMaVCwCRL/rG40W7DEMYjXxu62mA5Gu5sAPCCYF1u
	F4jeqyGhGQ/AdZytp+Qd7/sNLKzam4yUfaoV//WphiggRkLDmqCejL2K8Ce+8EA==
X-Received: by 2002:a5d:598a:0:b0:367:434f:cab8 with SMTP id ffacd0b85a97d-36775724938mr12134988f8f.43.1720023685976;
        Wed, 03 Jul 2024 09:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2z3Fw+9jy3Pmlw93VTfgKjZ54NgKbcbujJ1QQzQjar0O4FIbIqDsVY2lvaA0V/bfUwdh/Ew==
X-Received: by 2002:a5d:598a:0:b0:367:434f:cab8 with SMTP id ffacd0b85a97d-36775724938mr12134966f8f.43.1720023685469;
        Wed, 03 Jul 2024 09:21:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3400:5126:3051:d630:92ee? (p200300cbc709340051263051d63092ee.dip0.t-ipconnect.de. [2003:cb:c709:3400:5126:3051:d630:92ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc412sm16339957f8f.70.2024.07.03.09.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:21:25 -0700 (PDT)
Message-ID: <bcc75496-3222-4093-a8d5-f8d529e0771b@redhat.com>
Date: Wed, 3 Jul 2024 18:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
To: Zi Yan <ziy@nvidia.com>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>,
 Yang Shi <shy828301@gmail.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
 <B6E5E92E-DCA0-47E8-9217-DCE843BAC122@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <B6E5E92E-DCA0-47E8-9217-DCE843BAC122@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.24 16:30, Zi Yan wrote:
> On 2 Jul 2024, at 3:40, Hugh Dickins wrote:
> 
>> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
>> flags when freeing, yet the flags shown are not bad: PG_locked had been
>> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
>> deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
>> symptoms implying double free by deferred split and large folio migration.
>>
>> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
>> folio migration") was right to fix the memcg-dependent locking broken in
>> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
>> but missed a subtlety of deferred_split_scan(): it moves folios to its own
>> local list to work on them without split_queue_lock, during which time
>> folio->_deferred_list is not empty, but even the "right" lock does nothing
>> to secure the folio and the list it is on.
>>
>> Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
>> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
>> while the old folio's reference count is temporarily frozen to 0 - adding
>> such a freeze in the !mapping case too (originally, folio lock and
>> unmapping and no swap cache left an anon folio unreachable, so no freezing
>> was needed there: but the deferred split queue offers a way to reach it).
>>
>> Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> Cc: stable@vger.kernel.org
>> ---
>> This patch against 6.10-rc6: Kefeng has commits in the mm-tree which
>> which will need adjustment to go over this, but we can both check the
>> result.  I have wondered whether just reverting 85ce2c517ade and its
>> subsequent fixups would be better: but that would be a bigger job,
>> and probably not the right choice.
>>
>>   mm/memcontrol.c | 11 -----------
>>   mm/migrate.c    | 13 +++++++++++++
>>   2 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 71fe2a95b8bd..8f2f1bb18c9c 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
>>
>>   	/* Transfer the charge and the css ref */
>>   	commit_charge(new, memcg);
>> -	/*
>> -	 * If the old folio is a large folio and is in the split queue, it needs
>> -	 * to be removed from the split queue now, in case getting an incorrect
>> -	 * split queue in destroy_large_folio() after the memcg of the old folio
>> -	 * is cleared.
>> -	 *
>> -	 * In addition, the old folio is about to be freed after migration, so
>> -	 * removing from the split queue a bit earlier seems reasonable.
>> -	 */
>> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
>> -		folio_undo_large_rmappable(old);
>>   	old->memcg_data = 0;
>>   }
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 20cb9f5f7446..a8c6f466e33a 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address_space *mapping,
>>   		if (folio_ref_count(folio) != expected_count)
>>   			return -EAGAIN;
>>
>> +		/* Take off deferred split queue while frozen and memcg set */
>> +		if (folio_test_large(folio) &&
>> +		    folio_test_large_rmappable(folio)) {
>> +			if (!folio_ref_freeze(folio, expected_count))
>> +				return -EAGAIN;
>> +			folio_undo_large_rmappable(folio);
>> +			folio_ref_unfreeze(folio, expected_count);
>> +		}
>> +
> 
> I wonder if the patch below would make the code look better by using
> the same freeze/unfreeze pattern like file-backed path. After
> reading the emails between you and Baolin and checking the code,
> I think the patch looks good to me. Feel free to add
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> BTW, this subtlety is very error prone, as Matthew, Ryan, and I all
> encountered errors because of this[1][2]. Matthew has a good summary
> of the subtlety:
> 
> "the (undocumented) logic in deferred_split_scan() that a folio
> with a positive refcount will not be removed from the list."
> 
> [1] https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
> [2] https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a8c6f466e33a..afcc0653dcb7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -412,17 +412,15 @@ int folio_migrate_mapping(struct address_space *mapping,
> 
>          if (!mapping) {
>                  /* Anonymous page without mapping */
> -               if (folio_ref_count(folio) != expected_count)
> +               if (!folio_ref_freeze(folio, expected_count))
>                          return -EAGAIN;
> 
>                  /* Take off deferred split queue while frozen and memcg set */
>                  if (folio_test_large(folio) &&
> -                   folio_test_large_rmappable(folio)) {
> -                       if (!folio_ref_freeze(folio, expected_count))
> -                               return -EAGAIN;
> +                   folio_test_large_rmappable(folio))
>                          folio_undo_large_rmappable(folio);
> -                       folio_ref_unfreeze(folio, expected_count);
> -               }
> +
> +               folio_ref_unfreeze(folio, expected_count);
> 

The downside is freezing order-0, where we don't need to freeze, right?

-- 
Cheers,

David / dhildenb


