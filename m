Return-Path: <linux-kernel+bounces-185959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8A28CBD65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CF5281098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE17E572;
	Wed, 22 May 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbqRrEUi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AA7F470
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368320; cv=none; b=SMPtPMfc1/EEp7GNZdPTUblig1vJiCUVQrB+gYlm/+cYuDXcHR0gISevfMLbfPKokVjCNGm1wihz90GvgC82CSWiczIZktZ/tLW47WYYq7j3wW13HImb1eq+PaQ1UWO1g6MPaxQHr7mrddlR18dSSd+JYN8NzQJDX3/rDH0bzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368320; c=relaxed/simple;
	bh=0t+jErpFdIBTM781wHlW4O4Fsv4R199FdseVPvqOhWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JipLnu0PYGkPuzmJfpO3EwaNMFsh6SjVF10+aG7uK7o9pJIaBih3wYcNbcHHIkP4ywWgSUo3wPPYx4kE4ApO+Uz7ebK30DqVNYtkX3irkygRJ7ZB/tkfQHnU+IVq6iBHYZ2fUbKXUL9Feoa4e+oQxqsccQBVlhfUq/7ItjHwPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbqRrEUi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716368317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JWXBle4PzoiYWSr82I9b7CduX+AMcmmmk6ap/tc/tP4=;
	b=VbqRrEUiNUPpfdFik3oaRpmMQznoeeSjX/kMBkVed5c6Q96X5Dti/vIAzYamhs67Gy1IWb
	iLjPeepV+fEruc0tMXwgulegTOc/qFCZKSM6BSx5zKOymqKIyTjehIgfa6Qec7qJBEVfVA
	PzCqfyoTSo10x4RL5g4ulxYvRaNLDYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-En6xm0CBNHaVc7qOFzySgA-1; Wed, 22 May 2024 04:58:35 -0400
X-MC-Unique: En6xm0CBNHaVc7qOFzySgA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41fd5cad55cso67227755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368314; x=1716973114;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JWXBle4PzoiYWSr82I9b7CduX+AMcmmmk6ap/tc/tP4=;
        b=qXzbfeI0ddc4jvUVPzAZnKp6KWCJAeFQZ6a/erqvcMSXJCdYwzpswvIanXgzPqRI2+
         pvQb2jZqfjV/TVGz9TNg9f6ZUPcG/UJKN34lL8crmIEInx4Hm+SCPutvCIPUORKRE313
         HTIRkYbBe3GjIBeHx9feF5R970EiMG0XaOYyOYuFDE/nW61aw7ylN1jEBPDVaIrnGyFo
         xNEz9eNDgOzvOgezUFzOHwyqeF23ikMlyh06w/HSfwbFc3gIDkxMD9qb5JF4CkeMqWDY
         Y+JmQeulQ84Thv17WZnLmhIMOfBaBTMbWkuuG4x/5r0rwnflmXv+ltkbCFh09TaDjtX/
         i1sg==
X-Forwarded-Encrypted: i=1; AJvYcCWtBEACC+4pd8LNeWA4D3WjUJlLjIMDQF/bBfzfo0tnr4RaOXdK5iNAk9XLoNdCd+p14x7BSFv4T+BA5stDK1TQtw2ZSFVUd0twdWH5
X-Gm-Message-State: AOJu0YyvuZvs2CGCmdaeIAIR8hUDTPzKjofFHYd2mH8RdhELAPNkKuH+
	4bB83kgQSFOGBo+817+lsplf7CVCJmYCIIkQbiwXwhd7DZGtBomROntkSJ+lyK/k1r1a0ajIspV
	li9CViqZ2E/HyS/kMoI/kFnCEst1nKl5dNv6LSZPEytWb3b6LNfgTrGx4j0XF2A==
X-Received: by 2002:a05:600c:3b0a:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-420fd2d7decmr10393965e9.8.1716368314424;
        Wed, 22 May 2024 01:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH69KTp81r6/711UeCtrrXbjS3MT/e3ebteAZTbjBxL+NVWYEGbmdGAhORSjyYWSkFmNZHXJg==
X-Received: by 2002:a05:600c:3b0a:b0:41d:7d76:ffd4 with SMTP id 5b1f17b1804b1-420fd2d7decmr10393805e9.8.1716368314001;
        Wed, 22 May 2024 01:58:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d500:4044:6d4c:f060:f677? (p200300cbc709d50040446d4cf060f677.dip0.t-ipconnect.de. [2003:cb:c709:d500:4044:6d4c:f060:f677])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f9bsm493024395e9.6.2024.05.22.01.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 01:58:33 -0700 (PDT)
Message-ID: <22ac01a3-ddbb-4114-88cd-ad1a31982dad@redhat.com>
Date: Wed, 22 May 2024 10:58:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: drop the 'anon_' prefix for swap-out mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <0e2a6f232e7579a2e4407ecf075531980d97f286.1716367360.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 10:51, Baolin Wang wrote:
> The mTHP swap related counters: 'anon_swpout' and 'anon_swpout_fallback' are
> confusing with an 'anon_' prefix, since the shmem can swap out non-anonymous
> pages. So drop the 'anon_' prefix to keep consistent with the old swap counter
> names.
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Am I daydreaming or did we add the anon_ for a reason and discussed the 
interaction with shmem? At least I remember some discussion around that.

-- 
Cheers,

David / dhildenb


