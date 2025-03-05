Return-Path: <linux-kernel+bounces-547660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A5A50C16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC2D3A231D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265C254AEC;
	Wed,  5 Mar 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/yRMHxq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177B249E5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204789; cv=none; b=g15SnXMeCXPQZS9xffi+zM3CzioPKScb93wTrts8IoPiVSsUcVGKNR1reVFikaLq6yyw+3hE0kxwwpgUZwTuHUCxFtAj1wCaOxugtWbKAj3Y1L/V4e6Yv5cXlj4oIUShvBjOh/fC1F1NPDPmeYncKnNcztIYSYLqUBVCviZx5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204789; c=relaxed/simple;
	bh=Cl18BFbo6lj/75bKJk7SfXOMUA2ZWAWvvgo3LQyvdCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SFsRxTxPnz+nuQ2tqjgrPNPjsKasoHkbHecWF0WzLnDaC8DthnAxGLFl9k6vCDkp5N5Xg0cxOchx/PyQINwCAL0aB8g8iGRdwFIY4irpjB2O8bpRzUMZ8Pd3FQrkFviY0tETrqHCnWWp1nE525vnwsvT9NZMYiIR5SY+NQEPWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/yRMHxq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741204786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nZmZJbeQSrqRCdjQiNkr8QO8akLMmV/h+boSg4x+6iM=;
	b=O/yRMHxqybyy+vtbszGN9fFiRlsggqMzqGiPTdfmU+L9HGOFkoGqGHnDiVr3h9HKHSlMcm
	mvwaccQqzoYndFGQ2tZ3VPeEOip/AIP1Bg5csHrTzweE2K8RbBalgSXxCraKX5hQJoFmWb
	d0jPVbr7aYz5B6aJTsYAdnoi3O+poGI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-FwXL4JGXOXWFOlExfpvr0w-1; Wed, 05 Mar 2025 14:59:34 -0500
X-MC-Unique: FwXL4JGXOXWFOlExfpvr0w-1
X-Mimecast-MFC-AGG-ID: FwXL4JGXOXWFOlExfpvr0w_1741204773
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e89e910so38432635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204773; x=1741809573;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZmZJbeQSrqRCdjQiNkr8QO8akLMmV/h+boSg4x+6iM=;
        b=K3JkLg1FqzNsnXkkkleBGLdmaSvDIwz/sN9cxBA5ktlOijCtdHu+eM6ltoADPNPK3U
         hjPf2U0aJ2WaIUnePWJubFXfYnZfp5bT2cwOnctq3NKh3LhZjrecDABpX4CnoWXX5i2t
         WKmbCipvdnYuuP///ePxOf0Gj0XTmdWumaLYloPF5R+HCWb9o1OIpU5HntGETOwXr1Tp
         aZBAtAS45Xap/dvLuAmFGtR3zTsG0YQarEV2Ya5L5FWM/lDq6dOMRF5U2BPZvvX2rnZy
         sEloNrFMp9avSEw43z1z+ou1s1AWlYnCCoTESr3O6Rg4Jmzgkdgs0cY4z9fodG278Xfs
         GuHg==
X-Forwarded-Encrypted: i=1; AJvYcCWpeJ/pBVzI8XL/2z2lQNibY6f8/IGc20uPrrptRCDXVW8I/VYIytGQz7RXpMj6v4/O9hh+9idmDsEx6Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwduKVImrrsCormEweRIEkolWrwbxF2A46TIaAypWc7Cmi7PSt
	0PIvZDW4uoZl3tyilPr/HGqZrPRCOsQJMdwhW+iBmE+4m6ejeu6445Ga2aZqw1oSoynVegjXeSo
	S9U8Lc/SOcRPvdyVrwfIstjugAc2KCerc8M8fOYdV6m1kWeudldknciRLIjUVow==
X-Gm-Gg: ASbGncumiBa3UfYInBhTzGGXvFcw7sZL/GMWdvAXhi3qKrlBOLYrmfJJlTjccPLRMsg
	DG/gBR0mW7W4I5BwEtxtMfKP5vGw/q8zlXEaXBGZrUKryTVTCwJPhIvRDOlcxsWncPQcd7fqDn6
	kDYOA4cP1GG3eXTbZYe7iwJXe+vFiWnyHFkAsfig1ecNfWHufLRmqm9wbk/e9uGVcp4c1LE7AMl
	WjotNfu+6LlKJOc/dIvHogdowEsyVVwSJWWnmt8c8AxjNe7xX+nfIPNIa1vzrurSzWc98KIOUj0
	yFqTY9F1j6P5QVP4tQoYUFhWrTacmPFp4SXqj1bBEvb4NhU2qBott0bw8lWmbYHiB92OtPKz+Dy
	FRH8zGGMfCTo2KQOxmx2hNYKV7ciw/ZqZpxnr+nxmXY8=
X-Received: by 2002:a05:6000:178a:b0:391:13ef:1b0f with SMTP id ffacd0b85a97d-3911f7c3353mr4143941f8f.39.1741204773439;
        Wed, 05 Mar 2025 11:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1I+GEM5IEPN5/WQ69b5Iw3kXM57cQdPQPl9xA9chlh/tdslQRtsW67EGy18cq+cCHjacCqg==
X-Received: by 2002:a05:6000:178a:b0:391:13ef:1b0f with SMTP id ffacd0b85a97d-3911f7c3353mr4143922f8f.39.1741204773085;
        Wed, 05 Mar 2025 11:59:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844abbsm21789810f8f.70.2025.03.05.11.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:59:32 -0800 (PST)
Message-ID: <248ab74d-0f5c-4076-bfb2-a5eef8aca757@redhat.com>
Date: Wed, 5 Mar 2025 20:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Plain dereference and READ_ONCE() in fault handler
To: Dev Jain <dev.jain@arm.com>, willy@infradead.org, ziy@nvidia.com,
 hughd@google.com, ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250305102159.96420-1-dev.jain@arm.com>
 <8477d9ec-b9ce-4a3d-b61f-1bd44d3360a5@redhat.com>
 <3c3f3cfe-9fa7-41d7-9759-cc67306f13f5@arm.com>
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
In-Reply-To: <3c3f3cfe-9fa7-41d7-9759-cc67306f13f5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Oh I just looked at the arm64 definition and assumed ptep_get_lockless()
> == READ_ONCE() :) Now this makes sense. So I am guessing that we can
> still get away with a *vmf.pmd on 64-bit arches?
> 
> A separate question: When taking the create_huge_pmd() path with a read
> fault and after taking the pmd lock, why shouldn't we check with
> pmd_none(pmdp_get_lockless(vmf.pmd)) instead of plain *vmf.pmd...surely
> now we must load the actual correct value from memory since we are
> committing into mapping the huge zero folio?

So you mean we go via create_huge_pmd()->do_huge_pmd_anonymous_page(), 
to then end up in the path where we do the mm_get_huge_zero_folio().

If we hold the PMD lock, pmd_none() cannot change, so there is no need 
for the lockless variant?

So with the lock, you get the actual correct value that cannot change.

> And after looking somewhat more, why even is a pmd_none(*pmd) there in
> set_huge_zero_folio()...it should be the responsibility of the caller to
> verify this? Any caller will just assume that it got the huge zero folio
> mapped so this check should be redundant.

Yes, looks more like a VM_WARN_ON() scenario. So I agree that that one 
does not sound useful. (*maybe* the compiler is smart enough to optimize 
that check out)

-- 
Cheers,

David / dhildenb


