Return-Path: <linux-kernel+bounces-262220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96193C2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F301C20F85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDEE19AD72;
	Thu, 25 Jul 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5cLhsh5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E517557C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912859; cv=none; b=eC6TiDEBuTtse8bmMxvSZOfeCFiRqcBhEgo7CdsB8fpBo+lv2QKmFh9m1IoCJAvZ8flpt5Yil7bPj2YZeshEchJB2tg7qm7/BuUo+xOxNxqSxNC2x/6MZhDKGW3HdL01hQeSClC5PMN3Qs+SE6dud+0XMX4kD/MoiCZZBYaOSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912859; c=relaxed/simple;
	bh=v5FjqDVvTamk0srm2faB9slvRVcHie4xryseftv9uS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE10E+UiV4/AaGU6EzhU6JmQW/fnZNH1QgioqDLfEFfhefoIaKmUAEaXNg1pJsML0CU2yYWbZxyh71dcafTKZ1jAjy59cfK0sEAtPho6+Y3joF5sR08KBiXeQIhV6gX9dZCzrFLM/VgbZ94UfkxBiJwaqH4ifVaZx56/ofVrBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5cLhsh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721912856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NFOfnXod23eXLrrcZDgNCx1C4bEGvgqLi4FsG5UaOVw=;
	b=X5cLhsh5KtcdZvSGlI11+jwOx2sz+Bg66flyx9uZfcJMdabEji4DMa+rtV6jxdEKolEwfV
	8kbAmGLtyg2UVidDN+hU97xt6/hqaInYCKTp3nGmcQT4BxuYkUo8LX73+ZjI5LXf3h1/Ub
	yTs/5YYcngHRVEM7Mh3iJDmj+81z1fo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-qViX0_GTM_-38vgllPLdCw-1; Thu, 25 Jul 2024 09:07:35 -0400
X-MC-Unique: qViX0_GTM_-38vgllPLdCw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso4489335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912854; x=1722517654;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NFOfnXod23eXLrrcZDgNCx1C4bEGvgqLi4FsG5UaOVw=;
        b=eHjxMy90iWebTb4o9MM/R0cYoeoPhA6/O8k83FtiCpJ98CRY7a26CP0lcefnNndxU3
         f62PfjBO7E5qJQNi0Y257RYpmc7bxx6wat7BJvwsjvIQCrj7ovWPDlTNhCMTzuUplw8g
         Z0/U4ar74jpe/niBJIhCuEUfbobobFix9DcNHapwWdxetbebDCqA9bQrUjjj1VtwF3WP
         4Lh+XsRoKJ3Uyw12oo+b1RM1Q0jjeYIMcbNZabSlp+yCb4Fg8KltxpgxuiKiNcS470vK
         NKUtFIXDvFeJHOvggfdMg8KnzCAi/jqeXASdhT9HqEBYlr9cjtJd8f+QihpEh6jOyvaG
         i7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNCHJQact+BuPPeiZYrlyJZg7IcZbjg11dIiXW/NH5ag1i6aW8Z4DhuACIX7oTLNfgzr7X3iCL1m8okBE/onwKnhgKrn7keGel1VV
X-Gm-Message-State: AOJu0YwI8dAIhHGH5RxocrMt3ymIJRez5HZ+TEhgsaTRieZyWlSlyvTc
	QFfGXWexdv/NmqqzYdRiiNGxdd1so8oDYqeu30XXPSr8ECwW+HO4Dw1aK+yly6Zt62bi+Y9ON5V
	Xcn44SElcNq7Hsshx5UowQVVH5D6OlUZ6dPn7TDMTGHyNyx8RTBS0+VmnkJOFAg==
X-Received: by 2002:a05:600c:a4b:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42805711e0dmr15837275e9.19.1721912854243;
        Thu, 25 Jul 2024 06:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE4/40Ipsovkw8qmvQ3TpfowfqGoM/UQA10Uy+POeRRIv/gssEEbMYj4OAz/h1elI/71Kw5A==
X-Received: by 2002:a05:600c:a4b:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42805711e0dmr15837085e9.19.1721912853816;
        Thu, 25 Jul 2024 06:07:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2c00:5f6:3120:375a:3e4? (p200300cbc7062c0005f63120375a03e4.dip0.t-ipconnect.de. [2003:cb:c706:2c00:5f6:3120:375a:3e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b61sm2124670f8f.97.2024.07.25.06.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:07:33 -0700 (PDT)
Message-ID: <ceab7792-ae7a-4605-bd78-73353d71f87a@redhat.com>
Date: Thu, 25 Jul 2024 15:07:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: shmem: simplify the suitable huge orders
 validation for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ziy@nvidia.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720755678.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720755678.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.24 15:24, Baolin Wang wrote:
> Move the suitable huge orders validation into shmem_suitable_orders() for
> tmpfs, which can reuse some code to simplify the logic.
> 
> In addition, we don't have special handling for the error code -E2BIG when
> checking for conflicts with PMD sized THP in the pagecache for tmpfs, instead,
> it will just fallback to order-0 allocations like this patch does, so this
> simplification will not add functional changes.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


