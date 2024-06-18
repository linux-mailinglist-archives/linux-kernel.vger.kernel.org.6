Return-Path: <linux-kernel+bounces-218784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFC90C602
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D11F2292C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4E757F0;
	Tue, 18 Jun 2024 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JekiHeof"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F4745C0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696254; cv=none; b=CROPqJPbkJwQ0USflTiSMQRn3+RVRzCKQA1YYNRulAxwhJ1FYu7VUkGkiGzgjbiyoFHBhY5lR0oc7GUkZMWoxa3yULCodRnQfsbXmPbHQ1sUsnQ7i5W3SdFq685Ydqy7I5wN+hSQLmk+QRm5lMUDCAoc4OqysZ6iQVVrUovrcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696254; c=relaxed/simple;
	bh=uvVLziiyMiGFpjopXmDs48T5glxhlHbZxzgTrEwKQ5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzAaHNZTOhv2VED0cfsohRjaSwS/R9vbMq4UMmQZI4DYeMrDgI3esSvfKNvoW9Op/USJkFCKaSxuL0K5DhA7rsrOVAYntdw1RVYqxq4tWO6NvFVO0bmDjJZ1P1rtlXAGkmybtL0Cd2geyxj5mBMOA3xuVFyRa8Wica+5qMI+m7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JekiHeof; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718696251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K8FGdsJkQW+byEQkX1yS33c/wIMs4hmfFSLxQwVoRiY=;
	b=JekiHeofLytkIuzCTtHV1Ft7Zrfl2CeArcnbIXg4ac2B5UyDFtlODZA8SriADsTecYKrS2
	4T1XYW67DGaBF1vGsJgs3bpMHv43bSKNuAVsIq3+XYTFtUlamjBoC1FOpm+WpJTqPkUD02
	d+XynEhZ71ZGJbtuBC1lME2f2knP8/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-EKRwSf2nPQugL0-wDIstPQ-1; Tue, 18 Jun 2024 03:37:29 -0400
X-MC-Unique: EKRwSf2nPQugL0-wDIstPQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-423034c6119so29815455e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696249; x=1719301049;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8FGdsJkQW+byEQkX1yS33c/wIMs4hmfFSLxQwVoRiY=;
        b=RSV9btmFCYlLk58OOmu7R+j7rYFWNYIWUii6xKf/b/wNSUM134gAInnZUa+SqYguzR
         dSpE5O+8aPR2RXenz+LqMspwydiX21SYfjD+7ZRQZ4k6VCKIMwZPYZGTEwxkPOLG5Hfs
         ouzdnq/D3hcXNHESwl8TPxIl6SFvpMy/S7y37VMN48c2bD0eXsUfRVTslT+t/5Am9VMS
         nlErAS4HzuyJH31dGAE+uZJ4pSelgJoSe8n+3aS1737yrkoTa3SO1HUKFSwVXyrgcNMp
         pVhV7nlABT9KGL7I/bi8Nvl99hBHz3Pu/aP7e0Ex+4mBUN2DnVefgKqLd3O8EXZuNkjG
         NFCw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0WxYLw9BfImMuyoaug94d6HF9YqRp3nmuPeyYfRXnA1j4o3ALLu0a91F3Ys61dDHsH+xU3T/aKSCcQs36QYULZszVA8/Rc38IzQk
X-Gm-Message-State: AOJu0YxXA/hMn99r/w2KCmpSZmmSYA7VNoBt+RxijET7sxVybMSF2B7C
	qfAu37Lub/F3J4jEyhv25NrX68LlGhvzNwv+rhTHw5yu8qOrmiapuHl2QI0QRCcwMugtpkANiET
	UWC4XduNqsXD01eQ8VaoZs2B3O05Lkyq9ze3cNxU5GS5Y8cxa6VM29IVQ22MrablHVe6pKw==
X-Received: by 2002:a05:600c:4b16:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-423bc08c155mr51871705e9.0.1718696248845;
        Tue, 18 Jun 2024 00:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfgclri3NxDFiUz/oariusZFRsh1RRo8IZxCVzJtH92orM3Jg4zKGg5HrECllAq8yhBp8d5Q==
X-Received: by 2002:a05:600c:4b16:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-423bc08c155mr51871585e9.0.1718696248428;
        Tue, 18 Jun 2024 00:37:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f8be0c69sm182381445e9.33.2024.06.18.00.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:37:28 -0700 (PDT)
Message-ID: <030ba6a5-d3ff-429b-8672-59b7f7d44208@redhat.com>
Date: Tue, 18 Jun 2024 09:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] khugepaged: Simplify the allocation of slab caches
To: Hongfu Li <lihongfu@kylinos.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240618014517.25954-1-lihongfu@kylinos.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240618014517.25954-1-lihongfu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.24 03:45, Hongfu Li wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
>   mm/khugepaged.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 774a97e6e2da..f8d08b49420c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -385,10 +385,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
>   
>   int __init khugepaged_init(void)
>   {
> -	mm_slot_cache = kmem_cache_create("khugepaged_mm_slot",
> -					  sizeof(struct khugepaged_mm_slot),
> -					  __alignof__(struct khugepaged_mm_slot),
> -					  0, NULL);
> +	mm_slot_cache = KMEM_CACHE(khugepaged_mm_slot, 0);
>   	if (!mm_slot_cache)
>   		return -ENOMEM;
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


