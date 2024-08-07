Return-Path: <linux-kernel+bounces-277618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF194A3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF61C2174D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E61D1F42;
	Wed,  7 Aug 2024 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US1HdwMq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7751D1759
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021901; cv=none; b=IRsOZmAekxNPUnGV7bCyqp5DnKQc95hR/W3eiwfAt/S7ZbitcVV+40XXhkg7hEsI0b7NdeR/7aawSLnJdx5Q4iDnewlLMb1Y+9fNfGoV67Kog5800aiJ8Z/e2GOOuOl/ntFNIaOQ3etWzvQNoQqVPcWO/unc2zEoeJkn0VnHVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021901; c=relaxed/simple;
	bh=xATV63RAmcQX1se7dr51flrYwkYLQVXkCzNhT8uqD7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGFGdkK/2iXRyA79liLlyJELxHWS/I4Py/J4OFCUIyF/CDt1au2zZGxQaqQU32Jg6U3eUAireFCw1cEvlEVglWCsBteBMmqIxm83s9AO0cTcV9/GJgUHY3/iN4NS3WKIORaK2sztGla9y2LcB1oTsHDa3J2+p3zTGBm1GcFPrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US1HdwMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723021898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jy8NFDr7oCr7NdriNBKSH/zxxQ1qfP2jazl/I41U91c=;
	b=US1HdwMqzWXagsJwvDOesg/VhvuUtBAcprq2um4plM16RR4v7OHTEaM48Xbng238RDf5Tg
	/1nm2ELktX6Afo2uLpISmYp5WPosTpjHnVC01y2ejL2YJv6pUQ5audcnEOqT27NxdXA7Hm
	q4zk8YKmoTMEbnk6BY1NzJi840YVMjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-p0BLBfvKPCuJQiC2PiSUTg-1; Wed, 07 Aug 2024 05:11:36 -0400
X-MC-Unique: p0BLBfvKPCuJQiC2PiSUTg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso3228445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021895; x=1723626695;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jy8NFDr7oCr7NdriNBKSH/zxxQ1qfP2jazl/I41U91c=;
        b=QnLTDIOV+IkuMd1XKg8tCLG7YlkRGEMC321AulwSrxHwRyChBn1Qr9Y+AMZGacIkHs
         IkSSe7WDaqem5321sGU9jafge8A03xqh1tvBRFtbPKP0lrkamthYuvsESk9buemBYzo/
         jk9U01TuHHszFrX5uVC5/qXg30rndehNYtSThkPOVAFDks1AU1XQnlSvMm2UalGyScCO
         RCejWNK7qUWK84HVwI8/Id/RRV1vpIGAYhJY85LyiBiY3083Jxh/kO3uPxDbgapvfQgw
         MCBTs0gV0vmETDKy5009SIf+EbsuRF3DF93Qf5ejciduvCksK3T9GUUDTy0YWbBu7tOO
         kMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtrn37uPSUlQe07QGPHw8orxuFTwPlTcZV408pRNgUhEZ2zsd8b9rww+FuC4DSM8syd0KR95v+oBlih9eLHNOc6BmKr6iyDRm3OTfr
X-Gm-Message-State: AOJu0YxK4FNnGxYSmVN0LTiWrNmM6wug6Lor/Lo34vI8b0acauJYVq1Y
	zUIM6VJvYSs/b2Ijo/N/PlzfG+sTOJ8+QuXTMTKlmhAUGS4IgkOzpq+KWk+U+qtirgsMBmWo4d1
	tZ6yvQZfX3gYrA2Lh1ta8V7HjsBQVM1/QQO1J49dBh/91GrTrtaA5B7eF80HT5Q==
X-Received: by 2002:a05:6000:1546:b0:366:e308:f9a1 with SMTP id ffacd0b85a97d-36bf0ee9c18mr1588432f8f.23.1723021895549;
        Wed, 07 Aug 2024 02:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbf7CmA2OY2FT6kzrLmaIaAM9ScJxGy0CjT98npFBFSEC4eiukIi3bAE/MiBPVJxyFZTtjSw==
X-Received: by 2002:a05:6000:1546:b0:366:e308:f9a1 with SMTP id ffacd0b85a97d-36bf0ee9c18mr1588394f8f.23.1723021895069;
        Wed, 07 Aug 2024 02:11:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1dcdesm15235571f8f.35.2024.08.07.02.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 02:11:34 -0700 (PDT)
Message-ID: <d3f1ab88-b9b5-4a35-93c8-9257782a2517@redhat.com>
Date: Wed, 7 Aug 2024 11:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: rename instances of swap_info_struct to
 meaningful 'si'
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: justinjiang@vivo.com, chrisl@kernel.org, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, ying.huang@intel.com
References: <20240807082508.358322-1-21cnbao@gmail.com>
 <20240807082508.358322-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807082508.358322-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 10:25, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> "P" means "pointer to something", rename it to a more meaningful
> identifier - "si".
> We also have a case with the name "sis", rename it to "si" as
> well.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/swapfile.c | 334 +++++++++++++++++++++++++-------------------------
>   1 file changed, 167 insertions(+), 167 deletions(-)

It's a bit of churn but all straight forward. No opinion against it from 
my side.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


