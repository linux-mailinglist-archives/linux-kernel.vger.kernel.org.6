Return-Path: <linux-kernel+bounces-443247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F99EE931
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FD7188C3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC6222D5C;
	Thu, 12 Dec 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdUdehga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2821579F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014385; cv=none; b=ZE589xdODsvVMaO1EU2Ve7bIqVS6lj6iSRIq/AgsBZFmFGS71l5PbXL0umcSKQzi9nPeE65iUZZBNoV2g3CYuVU0M/MaRJsW0X1WR4GTWEe1FDC2xO+Q0lA3MZiFKi3hSwsQPTlYFhxPYwwNCPKlNfTwvlt0oW4K2+f9GdNZWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014385; c=relaxed/simple;
	bh=B7bt1Rb11HZ8//GvaVEf+QJRWqGXeUUaOUfEDoer22g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGynHAleayC0ADFsN59VjzqxyPGGIRcWy14I3ZQP8k6PEVptWqplzuYQDw1jGDgX1jyc6lzO57VoisYnYhusxnMxX+nqb+81pw+6TWQfZlAVypqjZDLiFdxPsZyObMIW4MP37mPnbqzasoaSRQqNQXvJb6uXdTa5QF2YdYPpWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdUdehga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734014382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UwNw+blZMVrOtfhFIMSMQGiRfXt0yk9wU2iYrCdxIZA=;
	b=IdUdehgaw0k/bUU3ppj8H1Us8Dxak8AW1glvEEVuQIaUsUfK5WRUOnXtCwGZqgmFdVogkT
	idm0MWqAPtxTg8JZybqSXQHzN0zuGJm+zz9ZkRjJxYzT0S0IYvq2R4+lFgekfCYCuq2Ny5
	6p5G4ckbiRM2cWk56aD4DufetsZfK3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-KcR4h_ZkN8OC1qf2iWFuIw-1; Thu, 12 Dec 2024 09:39:41 -0500
X-MC-Unique: KcR4h_ZkN8OC1qf2iWFuIw-1
X-Mimecast-MFC-AGG-ID: KcR4h_ZkN8OC1qf2iWFuIw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d6ee042eso480066f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734014380; x=1734619180;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwNw+blZMVrOtfhFIMSMQGiRfXt0yk9wU2iYrCdxIZA=;
        b=nBABOzBizxMAVL+Du1XQqZ0IK3TQfXX1oVkyZ22FeN2/UMEL/v5FmetjH/us4DGGOo
         64XVr2WIq/ey0TG+iSQNAO1UxBskXWM4daPPYY9N1J3W3qS19OT5i5IEG3CqgFs6HlYL
         iIwbed/09Sf1bJhd1rHV/cv640Lh5HatpBKicTgq4gdrjM07mRzSXUYWy+BrfEJD0hYh
         FqYjFnUMKdkrcfYZrQ8w79Yf6D67Sdj+y4SBJwveyQkLzoFan1bFoVHFh8/Fx26vWAvt
         cFlxW1lcBeuCwB5PyLIuw2qfNw7tBM0dioqeg20sokterzqN80PqPQwsi2GZEm1XabG4
         GMsg==
X-Forwarded-Encrypted: i=1; AJvYcCUB+nVOctMY2xs4jYaAsXKFBRKhibk6NfgMTHDxoC89/wzNyofcsYbLNEr7fOW6RIDFURznW11S2nnwrso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbY3KRiJ8HIw+Io0NXfYZPIbJ+TO3kkpN44sVYh562ZhIBns5B
	Tx6idakKL10J+umsmYqQbE7IGgL3VbtFL+eWljvWo/fBSXAiVPBkhEHmTZe8hSGYDzThRkYGvzP
	jy6psA2cQ1J7N90WPoT2O8jN+LEPI88T9jTrIotECECSR/LytF1ZV9iMiQb146w==
X-Gm-Gg: ASbGncsgHhOBUJiCGtCKiHWpffevrGxqSclO5Fw+pUqid+T6xs+0iHH39qKAhLehF1w
	OQ9BVvH+gzBIuY9DsE3wyKafLVDblC11i0llUJRmI27/VlVvv17wn+rjAm28iUjOuUPo8lmXG2z
	clBNsTp3XSMBnggFpTBGRxMiZQybES6Cc1dsvewVZMBIxYoVF8cRQoXhZoel2bQVa4j+HJgn2gH
	LrandRHmTWdynf0SrsxCJVhNP+dO27wA+g37zGWAtcfzPPtlBYQjKT7bRSmulSvrteOCbGXlUm3
	cD8hojiGyzZwAtbLbuHgHO7orKlZjfJD9qoTa/bwO8GTC7MiB+Z7jEystxFFPW/7C696HuGLGt2
	2cd4x+iyJ
X-Received: by 2002:a5d:64ad:0:b0:386:4a0d:bb23 with SMTP id ffacd0b85a97d-387876850a3mr3389906f8f.11.1734014379835;
        Thu, 12 Dec 2024 06:39:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSNh/7nmI+6pdEypbS0GeYd+DayjGYUFksoeQEIN3pORa6nII/NZE607Pw0OIRioJw8I/tDw==
X-Received: by 2002:a5d:64ad:0:b0:386:4a0d:bb23 with SMTP id ffacd0b85a97d-387876850a3mr3389885f8f.11.1734014379483;
        Thu, 12 Dec 2024 06:39:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c716:2b00:720b:42a1:ba95:a3db? (p200300cbc7162b00720b42a1ba95a3db.dip0.t-ipconnect.de. [2003:cb:c716:2b00:720b:42a1:ba95:a3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514e6asm4233799f8f.79.2024.12.12.06.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:39:38 -0800 (PST)
Message-ID: <a7e4a425-6006-43bb-b311-f1c547606425@redhat.com>
Date: Thu, 12 Dec 2024 15:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: convert partially_mapped set/clear operations to be
 atomic
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, npache@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20241212135447.3530047-1-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241212135447.3530047-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.12.24 14:54, Usama Arif wrote:
> Other page flags in the 2nd page, like PG_hwpoison and
> PG_anon_exclusive can get modified concurrently. Hence,
> partially_mapped flags need to be changed atomically.
> 
> Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Fortunately we have the test-before-set checks already in place.

Acked-by: David Hildenbrand <david@redhat.com>

> ---
>   include/linux/page-flags.h | 12 ++----------
>   mm/huge_memory.c           |  8 ++++----
>   2 files changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index cf46ac720802..691506bdf2c5 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -862,18 +862,10 @@ static inline void ClearPageCompound(struct page *page)
>   	ClearPageHead(page);
>   }
>   FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
> -FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> -/*
> - * PG_partially_mapped is protected by deferred_split split_queue_lock,
> - * so its safe to use non-atomic set/clear.
> - */
> -__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> -__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
> +FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
>   #else
>   FOLIO_FLAG_FALSE(large_rmappable)
> -FOLIO_TEST_FLAG_FALSE(partially_mapped)
> -__FOLIO_SET_FLAG_NOOP(partially_mapped)
> -__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
> +FOLIO_FLAG_FALSE(partially_mapped)
>   #endif
>   
>   #define PG_head_mask ((1UL << PG_head))
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2da5520bfe24..120cd2cdc614 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3583,7 +3583,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		    !list_empty(&folio->_deferred_list)) {
>   			ds_queue->split_queue_len--;
>   			if (folio_test_partially_mapped(folio)) {
> -				__folio_clear_partially_mapped(folio);
> +				folio_clear_partially_mapped(folio);
>   				mod_mthp_stat(folio_order(folio),
>   					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   			}
> @@ -3695,7 +3695,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
>   	if (!list_empty(&folio->_deferred_list)) {
>   		ds_queue->split_queue_len--;
>   		if (folio_test_partially_mapped(folio)) {
> -			__folio_clear_partially_mapped(folio);
> +			folio_clear_partially_mapped(folio);
>   			mod_mthp_stat(folio_order(folio),
>   				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   		}
> @@ -3739,7 +3739,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>   	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>   	if (partially_mapped) {
>   		if (!folio_test_partially_mapped(folio)) {
> -			__folio_set_partially_mapped(folio);
> +			folio_set_partially_mapped(folio);
>   			if (folio_test_pmd_mappable(folio))
>   				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>   			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
> @@ -3832,7 +3832,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   		} else {
>   			/* We lost race with folio_put() */
>   			if (folio_test_partially_mapped(folio)) {
> -				__folio_clear_partially_mapped(folio);
> +				folio_clear_partially_mapped(folio);
>   				mod_mthp_stat(folio_order(folio),
>   					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>   			}


-- 
Cheers,

David / dhildenb


