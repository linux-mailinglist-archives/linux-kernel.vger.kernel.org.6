Return-Path: <linux-kernel+bounces-548557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7FA5466B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6BE1895840
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54620967A;
	Thu,  6 Mar 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvdOKZr6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C141DA634
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253677; cv=none; b=QEmsvYOlO0YtHq4RvYamEMSfjRlpt/4f/cY8wCRpH1vOQoi2mouCyaVZMmpUy6Ud06tRou12vcT452KRheGiadort4w9vERQ5VZDrXheWy/M9RdQIT190UkZkNIwG+BR2MoQehtSeyjaYhaKDfuXgc0BvcEQSh+hF9glU9lfw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253677; c=relaxed/simple;
	bh=Fe6UbuIosZEojIJBItys7pxoaTtlXX7n6Q1kUptuAT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfOXb4jcZsVm8aoiZ4S4iGIIUo/3TvIdlLOvOAu0OxCH7kpxv5v4P8TvvevXVRZWUeY/gZsH1dVAtxNaNrP2gnov2A2PcfMXgNeihA0DJs6sil+lWVCfDd8C4fKWvmdTE/Na2uCz0vDBT9GuzGf/QbEEN0f30Hjlabx/RRGhL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvdOKZr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZqCkyjz1OlMe+qw/kRDJYRT1lbnf8jOcemKypLfKPiM=;
	b=MvdOKZr6RFm1rGmcx6WKxzEbi+GisA+XJLCpfgDeSEmJk48Y3EZPNbBSz4v7hS5akFdW3V
	agLEM4rch4ab2ROS7V1HXB3ZzOYaTejhkx9ChwIsy7ARGtxPFqouBLmfCOiSxV6GXOqJ7u
	emZ0J3EcNfXjXi2K9UlIfooCema0HQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-ULO1ADjiPWStKooiGtn_pA-1; Thu, 06 Mar 2025 04:34:23 -0500
X-MC-Unique: ULO1ADjiPWStKooiGtn_pA-1
X-Mimecast-MFC-AGG-ID: ULO1ADjiPWStKooiGtn_pA_1741253662
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fc9861cso18270f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253662; x=1741858462;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZqCkyjz1OlMe+qw/kRDJYRT1lbnf8jOcemKypLfKPiM=;
        b=vJyd8w7IDJW7TrVaPaI70RMZ3bdI/Tj8LRd9XT8BeKsaSM4lgzABwlnrHDxpR0U7xF
         BKL/68+xFthzLnLI7ZnSDc3pp6vl65quSvcTq1utfNeByxF2nYQVfwyEeDnjgPNE2YxK
         cMlbCiIlICtP+6gjhF5z0/L8QvjCPYWdSITlg8/Svb9a2seq6OZS4LOST/UgVZntEUnd
         PWpjhYsymW9bOJozXUzW0XpjgRm0HV4LqNpIbAITe110lzMh/SuARyTs8R71+fSWsQZo
         p322zdfMWGx9LQ6RpTButLnx31nKBNZ+dMr3T0P0XOL3RSEB7t4/sT7bTnicv0IRlolV
         I3sw==
X-Forwarded-Encrypted: i=1; AJvYcCWFkSr9ZAuckZS6cYq6SA4WJWcL+1RLj5aOVpYHtQuOtQJLcbkwHhSRRCMb1wXnmTB0ner8cJjRVnn+gVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5w18CYVGjZ4/54j3u+1zuy8U/eC9EeZVTPMEXLcPCVPF/LI3
	BcoaaThnjkMPD1g6oByjiuMLrlprnKmXcS458Sk9dw5qmPhmfBp33gp/NAsUMy1Fg4AXtP+tHF4
	WlPlbM6x3LhPzYJMeiKKeazIWMh4MQ6kohcHpSUrBj5M5HGMM9g/hJ5vG4Prz0Q==
X-Gm-Gg: ASbGncudvXpCTIKBVFsdlAtiMEC09Wuww5D4XSNG1V9NXdKONRYigribsKil/xZt+EB
	tTe6U9jHuMwylV8Ey0+AfCYdgw7viW+uiBlIGvzuDmUHTdIaO/Prhiyt/0I9mXRfc1qXp50vSi1
	LxosnOCLCuuz/cBjSrzHz6dY9Zir2uVT3grSYd+wNZBTT2gLL9NShymNylvKG7VmMHKOmCs0VWH
	GG5rziuS1SvQdQtSxpixEwor2Ooeyc3bn28vMeIByVADvg1sRhvsSpqS1AT5lc40BZoEWXlqG1N
	ouspgWycxvkRp7oNVObI8NFrcHt09DO8WwbWC0tMv1zoZTj3pViElTddPULzEvZQiq1qTIW1fJv
	eHWt/gcO9W/605KqL8cRaqrip3LdChtno/FSQoEfJv3U=
X-Received: by 2002:a5d:59ac:0:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3911f7a9568mr6605741f8f.35.1741253662372;
        Thu, 06 Mar 2025 01:34:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEdssV16m28QlGvjts6KPm6IS/YZ9DRQCSJFu22wgj2GXjDRoqtu57e6vr6hvQlvK6nb8u+Q==
X-Received: by 2002:a5d:59ac:0:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3911f7a9568mr6605709f8f.35.1741253661996;
        Thu, 06 Mar 2025 01:34:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:4400:2f98:9b35:6822:ce54? (p200300cbc74d44002f989b356822ce54.dip0.t-ipconnect.de. [2003:cb:c74d:4400:2f98:9b35:6822:ce54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8dbb4csm14143855e9.23.2025.03.06.01.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:34:21 -0800 (PST)
Message-ID: <88d8d030-c37d-433f-82f7-aed4f3a0fe4a@redhat.com>
Date: Thu, 6 Mar 2025 10:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] selftests/mm: Report errno when things fail in
 gup_longterm
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-1-958e3b6f0203@google.com>
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
In-Reply-To: <20250228-mm-selftests-v3-1-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
>   		/*
>   		 * TODO: if the kernel ever supports long-term R/W pinning on
> @@ -202,7 +204,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   		/* Skip on errors, as we might just lack kernel support. */
>   		ret = io_uring_queue_init(1, &ring, 0);
>   		if (ret < 0) {
> -			ksft_test_result_skip("io_uring_queue_init() failed\n");
> +			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
> +					      strerror(errno));

This function is documented to return -errno. I'm not sure if errno is 
guaranteed to be left unmodified (not clearly documented in the man 
page). So you might just want to use strerror(-ret) here.

Same applies to the other io_uring functions.

-- 
Cheers,

David / dhildenb


