Return-Path: <linux-kernel+bounces-196983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2B8D6495
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6244B29808
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82993D0A4;
	Fri, 31 May 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8xANrCp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1739AE3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165933; cv=none; b=B63RVQPwlmjoQmfw2zHKfKhicHBwTKsZpH3bFcfb/I2BICPFR6Tpc8Hm6/JDYsx+Y093x2+yIU+D4XZBEMMNRD2o2S6cA5n1g1X3nke7I/zSpd36duA7zBpIeSd14RHTfYPQo6aiAhqdN/e2ifupPNfYpTQFecNFuUrJvwqk3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165933; c=relaxed/simple;
	bh=psrIQSBuxsSeVyol8DExfg5BylOVoECHrozoAuYqQLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks3NEUvjD+IaWeBN0uEDj4NlcgZ0BjDS/RZjagR/10Feub/kkhka27ZKLisLyad3fhYZBSvqR7Lm1YbXZHMNyPXkh+4n9eLeQwGVT0WJ0FeGhdMTcHSw5ZfBr73CvYwtgOE0Q46imJvs4rFVSgGRVkZXaaNJHhaXyyOcT/j9WO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8xANrCp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717165930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u5zwpZMHVR1bnt6TvY8B0GWABRR6+xaSJ8yqDctK8F4=;
	b=A8xANrCpHL4japjoFD8qznLYMhOqlYGMX8MIzHYo/PD8RwwIFXn/ofUDwAiYq7lrARzDdX
	KG4kqLtZMAcCKcvMy++1s8z1CH/GqgKQeSijE5hc1yT7XYCNuRB8YTNo/uiBYqy53msrf/
	rY/3cJmx4URFW52u7TGGD6dez+412PQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-WeBmpxGfOOaIiGz1q-GFeQ-1; Fri, 31 May 2024 10:32:07 -0400
X-MC-Unique: WeBmpxGfOOaIiGz1q-GFeQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35dbf83bb20so1248802f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165926; x=1717770726;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u5zwpZMHVR1bnt6TvY8B0GWABRR6+xaSJ8yqDctK8F4=;
        b=CGfTTJPxeDnrfKLTt5g6wlCLbHbY8mtxDyQ0ltpT593mJCj1Debz/8Mqgdn9smD3z/
         nHo7Sp0aYd0u7NLOLyBN3DKOOOSrVe39OAWj1TdYrNvi/8Hsv8ZdhrpwhbB01UqE28ci
         2gOTxFcwgbRzIgAV6I5ELei7EAT5hjMrAIzMiEVgeW611Hez+rVbWlzeRRSkegQMljlY
         EtbNPIX4yyEQ5cHYqp/Rc2nLi1KILxj+VQZjTjnkLMHzzKL7LUQT35dk8JikvibumA3f
         0JwQSeQXyIEdq5FvBrITgRiKBD2ThUT8el9at27KPjy9HMwRiZrXFpvij9qwdwlMMIDF
         xBMg==
X-Gm-Message-State: AOJu0YyAk77fqsHokkkPuvzeMagFGrzmgOd+dlhUNyYC4sb0v2ohB/RW
	fMagmkFu080Wr8a5dZmHPWPj86BxOvx9oG+A7gcnr2dOgoKrtsH7C4RFwVF9ZcuuswzGnBmdo3o
	JoyHZmf+WWOO9uZeNGLxS8gdZqwvh24am0+n4svWm/WfZ2x4gHFASFKNXuReIWg==
X-Received: by 2002:adf:cd82:0:b0:354:fa5b:62b3 with SMTP id ffacd0b85a97d-35e0f334af7mr1441325f8f.69.1717165926517;
        Fri, 31 May 2024 07:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU4MhpJ4tBHp5nKe5wHrvNO5oZatRbiwR9y+bBwwRZSYsG1Wfh8zlyem44TS2snuUzhpeHyw==
X-Received: by 2002:adf:cd82:0:b0:354:fa5b:62b3 with SMTP id ffacd0b85a97d-35e0f334af7mr1441301f8f.69.1717165926030;
        Fri, 31 May 2024 07:32:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064998bsm1977446f8f.91.2024.05.31.07.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:32:05 -0700 (PDT)
Message-ID: <345161ac-3b42-48aa-ab3d-3b183316479a@redhat.com>
Date: Fri, 31 May 2024 16:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
To: Matthew Wilcox <willy@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-4-david@redhat.com>
 <20240530050123.GA8400@google.com> <ZlnebQ0dRUvx2SgP@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZlnebQ0dRUvx2SgP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 16:27, Matthew Wilcox wrote:
> On Thu, May 30, 2024 at 02:01:23PM +0900, Sergey Senozhatsky wrote:
>> On (24/05/29 13:19), David Hildenbrand wrote:
>>> We won't be able to support 256 KiB base pages, which is acceptable.
>> [..]
>>> +config HAVE_ZSMALLOC
>>> +	def_bool y
>>> +	depends on MMU
>>> +	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64 KiB
>>
>> Can't really say that I'm happy with this, but if mm-folks are
>> fine then okay.
> 
> I have an idea ...
> 
> We use 6 of the bits in the top byte of the page_type to enumerate
> a type (ie value 0x80-0xbf) and then the remaining 24 bits are
> available.  It's actually more efficient:
> 
> $ ./scripts/bloat-o-meter prev.o .build-debian/mm/filemap.o
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-40 (-40)
> Function                                     old     new   delta
> __filemap_add_folio                         1102    1098      -4
> filemap_unaccount_folio                      455     446      -9
> replace_page_cache_folio                     474     447     -27
> Total: Before=41258, After=41218, chg -0.10%
> 
> (that's all from PG_hugetlb)
> 
> before:
>      1406:       8b 46 30                mov    0x30(%rsi),%eax
>                  mapcount = atomic_read(&folio->_mapcount) + 1;
>      1409:       83 c0 01                add    $0x1,%eax
>                  if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
>      140c:       83 f8 81                cmp    $0xffffff81,%eax
>      140f:       7d 6c                   jge    147d <filemap_unaccount_folio+0x8d>
>      1411:       8b 43 30                mov    0x30(%rbx),%eax
>      1414:       25 00 08 00 f0          and    $0xf0000800,%eax
>      1419:       3d 00 00 00 f0          cmp    $0xf0000000,%eax
>      141e:       74 4e                   je     146e <filemap_unaccount_folio+0x7e>
> 
> after:
>      1406:       8b 46 30                mov    0x30(%rsi),%eax
>                  mapcount = atomic_read(&folio->_mapcount) + 1;
>      1409:       83 c0 01                add    $0x1,%eax
>                  if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
>      140c:       83 f8 81                cmp    $0xffffff81,%eax
>      140f:       7d 63                   jge    1474 <filemap_unaccount_folio+0x8
> 4>
>          if (folio_test_hugetlb(folio))
>      1411:       80 7b 33 84             cmpb   $0x84,0x33(%rbx)
>      1415:       74 4e                   je     1465 <filemap_unaccount_folio+0x75>
> 
> so we go from "mov, and, cmp, je" to just "cmpb, je", which must surely
> be faster to execute as well as being more compact in the I$ (6 bytes vs 15).
> 
> Anyway, not tested but this is the patch I used to generate the above.
> More for comment than application.

Right, it's likely very similar to my previous proposal to use 8 bit 
(uint8_t) for the type.

https://lore.kernel.org/all/00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com/

I would prefer if we would do that separately; unless someone is able to 
raise why we care about zram + 256KiB that much right now. (claim: we don't)

> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5265b3434b9e..4129d04ac812 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -942,24 +942,24 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>    * mistaken for a page type value.
>    */
>   
> -#define PAGE_TYPE_BASE	0xf0000000
> -/* Reserve		0x0000007f to catch underflows of _mapcount */
> -#define PAGE_MAPCOUNT_RESERVE	-128
> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> -
> -#define PageType(page, flag)						\
> -	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> -#define folio_test_type(folio, flag)					\
> -	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> +/* Reserve             0x0000007f to catch underflows of _mapcount */
> +#define PAGE_MAPCOUNT_RESERVE  -128
> +
> +#define PG_buddy	0x80
> +#define PG_offline	0x81
> +#define PG_table	0x82
> +#define PG_guard	0x83
> +#define PG_hugetlb	0x84
> +#define PG_slab		0x85

Hoping we can stop calling that PG_ ...




-- 
Cheers,

David / dhildenb


