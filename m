Return-Path: <linux-kernel+bounces-205800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF2900070
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11471F23D6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56715B986;
	Fri,  7 Jun 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L21YRJDU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7A4C61B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755203; cv=none; b=qWUIbaRK1ZqstYuwvDbzk2VDF9UoXLUGSCyCmXaqChJhSBE/6qDVaJ14IPZZtYOh6V5vgQNEyu+P7FBuxKX5XtFwUxMjwEmGvW9NN+kw9LATn+zXbuk6w62N//Zu1xr/Ws3/Szc/ycqsFgbH69nmByF5EgEHAjVAyzaMwDAedsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755203; c=relaxed/simple;
	bh=VvAK96elp1fhijCqg1ZtqWUzXtjZWXel3Bx3FY5irOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RCxODJCW72cNpzO5HDlkmQGOhyID8tHH61XIryMLSRaxa5L1FrwL4801O6NvF9993V8YT/CS595BriWDKuvH0Gz0j7KpUGPDS7fzuSIG6WqJDcu3mrSJrZQUGJQW7y5qrDJmtC3/m0fFAvnaTAcJeEYwmUoaLcgvke45p6RPorc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L21YRJDU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aiE315yb5LhYZq9scHgmLQ1ESDeksm/m+37tIZlY1sw=;
	b=L21YRJDUudQFiFDp5/aZ/QttkQKgp7+HXxgxeC5o6yFuahM7mgBvNsRqB0S56VUGqsiDaL
	XpXctiRq6/rvd+5ZRkRtaWQj5o62TcAvBENWazdntbWiRM1bHSS/6wTPxylXbrMLDmqpm9
	hToDwPVxPkg1DcngIwjhUQ1FlSO2/Qc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-BxwcJLe8MW2WVTnvKa9xPg-1; Fri, 07 Jun 2024 06:13:20 -0400
X-MC-Unique: BxwcJLe8MW2WVTnvKa9xPg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dcfb8ba61so1688879f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755199; x=1718359999;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiE315yb5LhYZq9scHgmLQ1ESDeksm/m+37tIZlY1sw=;
        b=eSgqAi7+Q1lV0MBp74YwqlzRTfuOvEEfx8tkyLioTjSCtqVjiD+3Akc57/Peqrx8u+
         l2RabXukgkAR1yu+adFnFBK/SODpV+apYzBK15DgPlRoYi1uilmo7Cq5uV8xlJvu+E6c
         K+Nvfqu2HNWlenuVfITlhf/teJJPgEt5EcddbKVYhbRpQSsug5TKS2Xj+toEqBf+JiSk
         BUn3U7+3JEd1qZLz3j3lsNNiCIOgXq7QiQP4Ekcsr3prLf/TmSqGqsCDwJLENnPa1s31
         BVasnaqoAyQA7MimNX/2emphgzz9xYMmQ8mybdCDgSFj5SW7A9v/IfQc7MLCqaxbS0DN
         9rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLqXpQP27+V/Rhtti9Udq1wOfgGwrczXgOS5CAD16neCJqRlkZJqZzTDSv8snNkwTk3S60D9ma40cmaZWnD6dnI/Z2hzy4bqSNOHSR
X-Gm-Message-State: AOJu0YyZdbEA2P0vEEYFbbe6MufSYB6yqTmkyhl+1yBvVR6zJJCgvVMx
	A/cV7rUzF++WHuJg/YuliRIoA9aXkKFFlgWwZ9WqUALBbIAIYYLWNhQCr9gngrDlPHFWp0kEygO
	ztruvjJMcBWmx/0DrtyqZn6OnYwYOZkNsjdEX4vPYPK0L9bFmbiybUtWaf+I7XA==
X-Received: by 2002:a5d:5092:0:b0:35e:f0e:1ba0 with SMTP id ffacd0b85a97d-35efed39cbamr2084727f8f.19.1717755198777;
        Fri, 07 Jun 2024 03:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSP+9P5EOVNH1xCiaehcpYZZKwXma8vCy6h69diiVUOPoDiXSRNiXWfqYATBkQwi1/HThJOQ==
X-Received: by 2002:a5d:5092:0:b0:35e:f0e:1ba0 with SMTP id ffacd0b85a97d-35efed39cbamr2084697f8f.19.1717755198282;
        Fri, 07 Jun 2024 03:13:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc31adsm3663430f8f.92.2024.06.07.03.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:13:17 -0700 (PDT)
Message-ID: <0bd0e529-2995-4699-875a-f6b529b7d322@redhat.com>
Date: Fri, 7 Jun 2024 12:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] mm/ksm: add anonymous check in find_mergeable_vma
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240605095304.66389-1-alexs@kernel.org>
 <353d4f6c-ed3d-4afe-82ab-8c0b22a0178f@redhat.com>
 <6b39db70-70ee-4370-acc3-86050562e343@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6b39db70-70ee-4370-acc3-86050562e343@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.06.24 11:33, Alex Shi wrote:
> 
> 
> On 6/5/24 5:56 PM, David Hildenbrand wrote:
>> On 05.06.24 11:53, alexs@kernel.org wrote:
>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>
>>> We do vma_set_anonyous in do_mmap(), and then vma_is_anonymous()
>>> checking workable, use it as a extra check since ksm only care anonymous
>>> pages.
>>>
>>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>>> ---
>>>    mm/ksm.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index f5138f43f0d2..088bce39cd33 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -742,7 +742,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>>>        if (ksm_test_exit(mm))
>>>            return NULL;
>>>        vma = vma_lookup(mm, addr);
>>> -    if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
>>> +    if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma ||
>>> +            !vma_is_anonymous(vma))
>>
>> Doesn't KSM also apply to COW'ed pages in !anon mappings? At least that's what I recall.
> I didn't a evidence for this. :(
> 
> In write_protect_page(), "PageAnonExclusive(&folio->page);" has a "VM_BUG_ON_PGFLAGS(!PageAnon(page), page);"
> So is this hints the vma also need to be anonymous one?


vma_is_anonymous(vma) is restricted to anonymous folios and the shared 
zeropage, but other VMAs (MAP_PRIVATE file-backed VMAs) can contain 
anonymous folios as well.

-- 
Cheers,

David / dhildenb


