Return-Path: <linux-kernel+bounces-523341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF1A3D53D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2E17A3A48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C61F03FE;
	Thu, 20 Feb 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mukw7rEL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DD1F03E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044822; cv=none; b=AnkVp+NBrtB72QkHyaeH6Iu3u6b/lH6qzZWnWL3FHKxShxBj67VihfnYzYLaZs8Kg7hYDvF+YYhytnJgGUIdibDhPSLn1Jr1QJlxP802SHg44TStFPviY75GCH1a9yUpmcX/9lAmrd5K6t30WRTYZ2lv9aSXCJDNA+Lenj4FZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044822; c=relaxed/simple;
	bh=kkVteqQ6jBOv0vAADwoo5K/CUAU2/E8vAYFZqRS/wjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=md781CwCQJ0s/qJH7yNhnSOtfHvJK3xV02aR3xqWgrHbtu5jVy6GeUG9lqnjPi2Rj1H6NOyWjae8Z/wZsuv+tgBvTMqBbrfvB5OkCVbpJNsitAatt/pOfle/D/1PHMo8Bd63aonwlxvW9ECAoTOoVHjyrCg8/CHIqbCVEIILwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mukw7rEL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740044819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PX22VEXfQDXd+bwnNlrTtmX8mtS/mt0KdUlITs6VwOo=;
	b=Mukw7rEL9wL5ysYeSVrt8BKY91lbEA94AyaOg5AmVIZ2TGm95ZxpPxsphGprQ2dV6SaXDC
	8Ih8LHJvV9Mr/EbivY9zdrXo8b8QyTEI3PilgL2l7tdO0X38MfzwdE4bAlvH/D3SVNHr2+
	q/20akD8Xauooznd79td5r0YND4GpPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-lfUiiq92N0exIZAGSptNFw-1; Thu, 20 Feb 2025 04:46:57 -0500
X-MC-Unique: lfUiiq92N0exIZAGSptNFw-1
X-Mimecast-MFC-AGG-ID: lfUiiq92N0exIZAGSptNFw_1740044816
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so3541735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044816; x=1740649616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PX22VEXfQDXd+bwnNlrTtmX8mtS/mt0KdUlITs6VwOo=;
        b=KH39Ys5N4X9iZx2VI7NhTZeQHEgHY6y1BZKd8my3TFA1FoSZIghpT+8TYe2f/RNl4L
         5Yv7lfzfepusQmfYOkMNMKsH6WFog3z73Jct1wQ9y86XmOfC9U3i377BwB1I+EoJma6H
         y476tmr3ypl5W2kpbuyuduY7pcdrpzBXFLu2GIZjTX9XUDiiJeARi6UElaa/NwunGOzJ
         JVbIzJ+P85AvjH9NUOUzU/08yuULLBDjTvKoSEdL5EOPeIgOiBRE1KKheNj6ZrM7cbBi
         Xvg6nNfLcu++MVRb/ZFB0RVB4wTfKUOR9/6T8gjt1wr5mGHJNwGlz7bLRxMd55fUneiF
         jldQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWnPqoQDZm5cCG/mlpanjA0e4GpLMbUwJzcbL5mAxS1dxAIzDh1LIzkT/rPmP2FWEUHiSP0Gi/syYkyeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtmbiDKY0EPW4cj3w5Os5yktn1WQIKOKB3v0U7pNmXcppBSbO
	FaF4PC27MuZvucD1sCyVCNjS2uYyZ93avkbEHJB1VinkZi0CRKNnysS6RkMVgeBG8dXplPOroea
	m/mSKF0Pdb6mk29j3+gHG+bPQ0wc7AGpxTfZMBwvb1F9kr75YRrMbFDvNvLR6GA==
X-Gm-Gg: ASbGnct1mo1R37A9qGBPS17oZzOYOzIqhYTBmnm1kx7cz3FmsEQxBH6K/rcRmwHtCbU
	mbL69FcDUxq95nxAffrfYpkzJLB2e/z01pjP2SLhCafu9o7UtUl1ALfi8H9tULWbSEnAjcnh8ZN
	byc2WZCqntZvahGGVx+Pj/bkHlzZ6FtLbGI0ONAV27wytNnObcKMgoTMrwd/yvNshbJqQimUluL
	Z77JyM43UGTgPr3oaW0wyc/0vmnm8uEqbMQfyShI9c2DoFtd9/65j3B/UUD6gy68v4fHznJl9Go
	GiMPBFnE+ZNO2kaNkToEvki5U235axw8f+7teUy2yW/Rt7fXVGumkhmSjRY6uJopbTwyw4Abh8c
	Q4y/jdtFpMakbK0y7CT9OAFIpTOOu9Q==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-4399828c66fmr77074405e9.23.1740044815921;
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2lnBXjzmd2luEL2KmwPE7DBRRL11fu5mryKSuYWczGhlzvE+nz+8CZ6DwwD2xPJQGQpOxWw==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-4399828c66fmr77074175e9.23.1740044815564;
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399558f8d1sm69276755e9.19.2025.02.20.01.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:46:55 -0800 (PST)
Message-ID: <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
Date: Thu, 20 Feb 2025 10:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to
 huge_ptep_get_and_clear()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-2-ryan.roberts@arm.com>
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
In-Reply-To: <20250217140419.1702389-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 15:04, Ryan Roberts wrote:
> In order to fix a bug, arm64 needs to be told the size of the huge page
> for which the huge_pte is being set in huge_ptep_get_and_clear().

s/set/cleared/ ?

> Provide for this by adding an `unsigned long sz` parameter to the
> function. This follows the same pattern as huge_pte_clear() and
> set_huge_pte_at().
> 
> This commit makes the required interface modifications to the core mm as
> well as all arches that implement this function (arm64, loongarch, mips,
> parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
> in a separate commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


