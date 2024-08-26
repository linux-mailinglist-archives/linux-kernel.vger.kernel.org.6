Return-Path: <linux-kernel+bounces-300851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027495E943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E681C208C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA0D82C8E;
	Mon, 26 Aug 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLWYx579"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027C757F8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655203; cv=none; b=atKBGYJOUA5t7INTM1ALTU93ggSMK4eTQUB3WNymKzu6PXAMJL68bS9JNvB69xaEozUR7iJM64L9X2rvuuVfgtULua354pP0L0IPSs6zlrtEPVQdgwEunLYNksSJvelXvAZVYnnDLLfeNVJ0DPQu8DKuVyca0qdQfBVK5vpEB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655203; c=relaxed/simple;
	bh=hfo6+2wvYXFSgfhtpiV1YNx+6sZXY1IgV4NUpwIJqP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF4jwWV2BKK6XBuoaF1WJjXvh1FUQig4MgMm8mG3znHOdG+OWqHaRSwIzk3agueDZHovYudv7+kOGHyl/pyg0cVs+6CyoQlNssFQYcFGVaOH7D1U3jjppU+ZHasA+am/+T3zX3mOgLlMcAS1b+gEYof5YObRE5rOSy6aIf8hShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLWYx579; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724655200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CQhslgluUq3LHMEZ/sF0r1OhpzBhuv0NK+tJbY/cbh0=;
	b=WLWYx579Sqgk+PxkU4BnPfEZWR/lL/x+wh/5ikyK7QTsdthuOHlbpi8nSS3stYJMmPQDwA
	aGpQW/Ioc9fH/BJC7GBeXb/SC9BEzCt289ZtYeUIh6hMFolliTeiQdtg5l5vDVmPKYXcDB
	IbeIkUnnGWFQkEnZR0W1nh04ymDfthQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-gSgeOg-qOfOguJ5mAYAHwg-1; Mon, 26 Aug 2024 02:53:19 -0400
X-MC-Unique: gSgeOg-qOfOguJ5mAYAHwg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42aa70df35eso44943855e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655198; x=1725259998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CQhslgluUq3LHMEZ/sF0r1OhpzBhuv0NK+tJbY/cbh0=;
        b=DgeQ2p20wGhZdcgXRpIjbiRvC7K9vy7W3V5K5jFX5TqSqoelIpvQ60rG83/2TMMg7n
         m9Hb6RnmBWX93X7tq+9VA23OLfBKvLaYwdUZH1b/fmCECUU52FxBVuy/HMKSbZsdhKHG
         M1w6vnRnxg+PPjz/kB2fWseTM0Y7PDnnBfrUgYim4mHeAQZDk/GFebt/5B/i1Qx1+tgY
         FvT0/uNO9jQ8Zdk+SNpH1hVHaNgxXjpxdbumDaWU2vdpXuVNac5bikUo4OpXg0d7ew+4
         /VDXq47xNl3e2I2RJfyctx/5wsjDFCqvmcmemrBSw0yuUdYbWaZhZ9q18nWhpnQRKgDZ
         sNoA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxA8G2SUgUTi0/Fup8B3CZUc4G9or0dl+n7lKsKWExPC6PD1se+YMYuCyLQneBUs2lNm1qqvP19xsCxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZap74WogjND5DlFhlfHYQnM6Lz23Sw65RoFSv3RJF3TnBrlZn
	tUCqBpxXhjiVVC+KFVwY/yuMeesalyKdGmE8qSE4R5oCRmZCVpaA7rEjqZ+hVvKOoR4ef/bOEzC
	m2WXPBEK/+xHHghz3qmTMY1yIgAVG0R+SwTyFcFlDCwXfMeXuFv1CdEwcAhYO0A==
X-Received: by 2002:a05:600c:3ba6:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-42acd54244fmr71814675e9.6.1724655197923;
        Sun, 25 Aug 2024 23:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoZIe0MhVQEy41Kz+UcBG5/XZJkJY9wU3iWb9DLIsE0Jysvy/aoncCZtXw/9HGx7oN3JdrDA==
X-Received: by 2002:a05:600c:3ba6:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-42acd54244fmr71814415e9.6.1724655196923;
        Sun, 25 Aug 2024 23:53:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:c800:cf71:2042:6051:e26? (p200300d82f12c800cf71204260510e26.dip0.t-ipconnect.de. [2003:d8:2f12:c800:cf71:2042:6051:e26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b633sm9903661f8f.52.2024.08.25.23.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:53:16 -0700 (PDT)
Message-ID: <0b36595c-db50-4e8b-96db-2d4ceeaa1908@redhat.com>
Date: Mon, 26 Aug 2024 08:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: extend shmem_unused_huge_shrink() to all sizes
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <d8c40850-6774-7a93-1e2c-8d941683b260@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d8c40850-6774-7a93-1e2c-8d941683b260@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.24 01:25, Hugh Dickins wrote:
> Although shmem_get_folio_gfp() is correctly putting inodes on the
> shrinklist according to the folio size, shmem_unused_huge_shrink()
> was still dealing with that shrinklist in terms of HPAGE_PMD_SIZE.
> 
> Generalize that; and to handle the mixture of sizes more sensibly,
> shmem_alloc_and_add_folio() give it a number of pages to be freed
> (approximate: no need to minimize that with an exact calculation)
> instead of a number of inodes to split.

That might be worth a comment in the code.

> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> This patch would most naturally go into mm-unstable as 10/9 over
> Baolin's "support large folio swap-out and swap-in for shmem" series.
> 
>   mm/shmem.c | 45 ++++++++++++++++++++-------------------------
>   1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4dd0570962fa..4c9921c234b7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -636,15 +636,14 @@ static const char *shmem_format_huge(int huge)
>   #endif
>   
>   static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
> -		struct shrink_control *sc, unsigned long nr_to_split)
> +		struct shrink_control *sc, unsigned long nr_to_free)
>   {
>   	LIST_HEAD(list), *pos, *next;
> -	LIST_HEAD(to_remove);
>   	struct inode *inode;
>   	struct shmem_inode_info *info;
>   	struct folio *folio;
>   	unsigned long batch = sc ? sc->nr_to_scan : 128;
> -	int split = 0;
> +	unsigned long split = 0, freed = 0;
>   
>   	if (list_empty(&sbinfo->shrinklist))
>   		return SHRINK_STOP;
> @@ -662,13 +661,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>   			goto next;
>   		}
>   
> -		/* Check if there's anything to gain */
> -		if (round_up(inode->i_size, PAGE_SIZE) ==
> -				round_up(inode->i_size, HPAGE_PMD_SIZE)) {
> -			list_move(&info->shrinklist, &to_remove);
> -			goto next;
> -		}
> -
>   		list_move(&info->shrinklist, &list);
>   next:
>   		sbinfo->shrinklist_len--;
> @@ -677,34 +669,36 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>   	}
>   	spin_unlock(&sbinfo->shrinklist_lock);
>   
> -	list_for_each_safe(pos, next, &to_remove) {
> -		info = list_entry(pos, struct shmem_inode_info, shrinklist);
> -		inode = &info->vfs_inode;
> -		list_del_init(&info->shrinklist);
> -		iput(inode);
> -	}
> -
>   	list_for_each_safe(pos, next, &list) {
> +		pgoff_t next, end;
> +		loff_t i_size;
>   		int ret;
> -		pgoff_t index;
>   
>   		info = list_entry(pos, struct shmem_inode_info, shrinklist);
>   		inode = &info->vfs_inode;
>   
> -		if (nr_to_split && split >= nr_to_split)
> +		if (nr_to_free && freed >= nr_to_free)
>   			goto move_back;
>   
> -		index = (inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT;
> -		folio = filemap_get_folio(inode->i_mapping, index);
> -		if (IS_ERR(folio))
> +		i_size = i_size_read(inode);
> +		folio = filemap_get_entry(inode->i_mapping, i_size / PAGE_SIZE);
> +		if (!folio || xa_is_value(folio))
>   			goto drop;
>   
> -		/* No huge page at the end of the file: nothing to split */
> +		/* No large page at the end of the file: nothing to split */


s/large page/large folio/

Or simply "Nothing to split."

>   		if (!folio_test_large(folio)) {
>   			folio_put(folio);
>   			goto drop;
>   		}
>   
> +		/* Check if there is anything to gain from splitting */
> +		next = folio_next_index(folio);
> +		end = shmem_fallocend(inode, DIV_ROUND_UP(i_size, PAGE_SIZE));
> +		if (end <= folio->index || end >= next) {
> +			folio_put(folio);
> +			goto drop;
> +		}
> +


Looks sensible to me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


