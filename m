Return-Path: <linux-kernel+bounces-170896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA518BDD80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CBE1F230C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31814D44E;
	Tue,  7 May 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv4lXBaL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097614D433
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071954; cv=none; b=lQnHvJHAA4164W7UZyyk+gK9MtiGAnKv+ryuSMv+++y1ZzLTcp+sYfFlCBx7VxvM2DWJA1/M7ozaAnIZ3I07MfvY9pdh6IY8jQo06hK3LHhKJ5exFsWfKQXwo/VUNQZt0id/PF7lPyBql1DVPmzL4Gl3XOzFz4nfMB0JOhZ9Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071954; c=relaxed/simple;
	bh=Apm61FvGNhu/YiFAZ4orMFvY+QlygaYrb1ktoO4PSPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBya9fTtQJ2o3L4lwie7Or3+L5iMKrvl4wUk3POh5uYkAquX8G4zIToPLeZD8CxoUVIOqta/a9n4a4B0exny/3qgZksItHxdjJGL7TmRbN8Dmej6yRrjyYzAjZkBiEnBTCIauz4AeGbRZFveoMIfXxKNsZoKXPL86hnKcpKpqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv4lXBaL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715071950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MK6aj3aSpgSSn5l04HwBB6yJSIhIeVDoBBZtPLH9n6s=;
	b=Uv4lXBaLHFIXWmeT/qBTyOjItfGSBuSRf5DgraVtY17Kby79HeViA4F6kDfvK6iAfw5Zkn
	fbSWb4vqt7CWOVy/260NpREh3+g26u4sxG1/rXOJaxVaqtuJ/RMo1ODHeUvZRS66uEyRpW
	z5VYWIazmnm7to8rm2mBw4WY2CRL9Eo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ody7ZaXdPW-d1qQChd7lfQ-1; Tue, 07 May 2024 04:52:28 -0400
X-MC-Unique: ody7ZaXdPW-d1qQChd7lfQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-418a673c191so11296715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715071947; x=1715676747;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK6aj3aSpgSSn5l04HwBB6yJSIhIeVDoBBZtPLH9n6s=;
        b=QI/NErY13W+1nimt5be2zuWw31WyJdRrLYaXTra8FnYtJXFCGbewJVdovHVcgjr8yF
         Ec4iHfNVTShIXUTJJCcYGXGkFqkE0ExlW48N5LP4Rc7MCmYUiu3m2el+3EI9yzy1yro3
         xlMmq2IR2m3AQRav3u/I/+NWb26j8FAJLntIaMHDD9YJK+l+H1U2nRbxMQiA39qOWx1r
         FSzuB12y785MMOBR1uKXIxhxmlb4mwqIevVuxPO9bru/tvFeErJhErZPc0ADVzntChiY
         GxEk3+DVkqdDpDnkPFRSQxlBFG0EJx9Lw5/wU1MjK8dtVYM/VlVi+C0sp1x+K59cEDdG
         PwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ94UfHCIKgAIJ9JJaU/te7BHvJkFWEEwB+oeV44Bgy7PURiq9pbClxAQYPHn+gIBs2XQJPDfxWMf51DTYmg3z/oxs+8Ej1wE+hawn
X-Gm-Message-State: AOJu0YwIODFerdn3sGvLqW9do5l/chVTYwyMT6mc9ojGGAr4fy+Tu2lC
	Urfh4WRC1PDsFdFIans7MYtXq/atTvZwF+QbmhbcJ1M5WxFd2HB8Q/eRrZCjyPndg1hR/IXsrJd
	RpHPyoiT2NYSf6kNNeqHzS3//xIUY0w0P7LwpFkRActV615wXWQzRPbaStilKkw==
X-Received: by 2002:a05:600c:1f95:b0:41b:ab72:3f4d with SMTP id je21-20020a05600c1f9500b0041bab723f4dmr8770734wmb.1.1715071947143;
        Tue, 07 May 2024 01:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhqVxalsOEOZwFZPa1U9kQ8dAXhs2d7ARfNRDnEwXbCAgTyJ2WLapsCKZvxftOsnH2rtv3Ig==
X-Received: by 2002:a05:600c:1f95:b0:41b:ab72:3f4d with SMTP id je21-20020a05600c1f9500b0041bab723f4dmr8770714wmb.1.1715071946609;
        Tue, 07 May 2024 01:52:26 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b0041bf87e702asm19018296wms.10.2024.05.07.01.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:52:26 -0700 (PDT)
Message-ID: <1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com>
Date: Tue, 7 May 2024 10:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] mm: rmap: abstract updating per-node and
 per-memcg stats
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240506211333.346605-1-yosryahmed@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240506211333.346605-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.05.24 23:13, Yosry Ahmed wrote:
> A lot of intricacies go into updating the stats when adding or removing
> mappings: which stat index to use and which function. Abstract this away
> into a new static helper in rmap.c, __folio_mod_stat().
> 
> This adds an unnecessary call to folio_test_anon() in
> __folio_add_anon_rmap() and __folio_add_file_rmap(). However, the folio
> struct should already be in the cache at this point, so it shouldn't
> cause any noticeable overhead.

Depending on the inlining, we might have more branches that could be avoided
(especially in folio_add_new_anon_rmap()).

[the rmap code is more performance-sensitive and relevant than you might think]

> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> 
> This applies on top of "mm: do not update memcg stats for
> NR_{FILE/SHMEM}_PMDMAPPED":
> https://lore.kernel.org/lkml/20240506192924.271999-1-yosryahmed@google.com/
> 
> David, I was on the fence about adding a Suggested-by here. You did
> suggest adding a helper, but the one with the extra folio_test_anon()
> was my idea and I didn't want to blame it on you. So I'll leave this up
> to you :)

:) fair enough! It's a clear improvement to readability.

[...]
>   
> -	if (nr_pmdmapped) {
> -		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
> -		if (folio_test_anon(folio))
> -			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
> -		else
> -			__mod_node_page_state(pgdat,
> -					folio_test_swapbacked(folio) ?
> -					NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
> -					-nr_pmdmapped);
> -	}
>   	if (nr) {
> -		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
> -		__lruvec_stat_mod_folio(folio, idx, -nr);
> -


We can now even do:

diff --git a/mm/rmap.c b/mm/rmap.c
index 9ed995da4709..7a147195e512 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1555,18 +1555,17 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
                 break;
         }
  
-       if (nr) {
-               /*
-                * Queue anon large folio for deferred split if at least one
-                * page of the folio is unmapped and at least one page
-                * is still mapped.
-                *
-                * Check partially_mapped first to ensure it is a large folio.
-                */
-               if (folio_test_anon(folio) && partially_mapped &&
-                   list_empty(&folio->_deferred_list))
-                       deferred_split_folio(folio);
-       }
+       /*
+        * Queue anon large folio for deferred split if at least one
+        * page of the folio is unmapped and at least one page
+        * is still mapped.
+        *
+        * Check partially_mapped first to ensure it is a large folio.
+        */
+       if (folio_test_anon(folio) && partially_mapped &&
+           list_empty(&folio->_deferred_list))
+               deferred_split_folio(folio);
+
         __folio_mod_stat(folio, nr, nr_pmdmapped);
  
         /*


Which will help some of my upcoming patches.

Feel free to include that in a v2, otherwise I'll include it in an upcoming
patch series.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


