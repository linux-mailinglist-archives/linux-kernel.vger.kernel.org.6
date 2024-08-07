Return-Path: <linux-kernel+bounces-277656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D836E94A459
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DC8B2A7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D211D173E;
	Wed,  7 Aug 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSn8+Fux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EA1CCB46
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023124; cv=none; b=S4fEGgbKAVo6WY2JY6hm3/cbJBFS9fhgFR8uQ67RrAstOLFXI4QIbefBP+aOgzS9NAUCqsoIhcYFJq9AEuut3CrOucv/m/OoLopnaSzC9Rmc+iCXitZoszpI0OT1SZ5AGjdB18NmFolmfEGpmdF9r9jl/e6zp6dV6OEzKTgwzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023124; c=relaxed/simple;
	bh=4OBonYVoKaYqooOH9w78gRoOT5dfAjXqwCMdj0E+AQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3C0vnIFtm5tLsBIyjcoIKgKnYuAgPjJDINeYURlm3nHgb6OxIu2jL47Oc77wq45tA3r766/vqQwTKHhDyv60N/jGLo9M4AGg7hbQIruOoozSz+H2nTAAiRH7kzrUTSCcuN355zg8LULZ1jCkRpNSy/r109E5+X9ktQgObP6eI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSn8+Fux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723023122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R31s1qlwd1wGwYZAVE+1E/NOM2YyN5bXLjbMgPRj0Hg=;
	b=bSn8+FuxZl46GPEWRIitBLTyDr7/NwZe/aaK3lv5XghVmPlZyiKo9w1rAT11dQ+IxulCpH
	XRmxHqxPtQUOFZZFSxmUYAL1J6ZbBjJodYwp6GVmjDBvi++LyZH4Wg4QmDb/eHp2O9PS3B
	YK1KlZ9Q8lyroYVXo5Im1JVvEGjQW/E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-YUxSLMX5Pmu_Z9n8Aef0fA-1; Wed, 07 Aug 2024 05:31:59 -0400
X-MC-Unique: YUxSLMX5Pmu_Z9n8Aef0fA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52f02f1773fso1779603e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723023118; x=1723627918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R31s1qlwd1wGwYZAVE+1E/NOM2YyN5bXLjbMgPRj0Hg=;
        b=cwx3Iqy27RcIG4uCjV7hrgVIy5MDov8S3Vlavi6eMas1H5eU0j2gPdf5+uIilyO1Hi
         D9tNhUD6EbPs1wpgt1QLwx7xIdC7MZJ1mRFIEyXfvSfQnN1mGeeQfMX/Nf6Y/D6W9skN
         IAgSvUz8ZueGWc4Q/iqIYP3Kq+Ymfsu9do8LJd9n75fg4v+LHQVpbdDaityZ8kCogvEB
         d8krH8JGHVFhE5cK+MP3YqBtYJ86+ZffSLDHIb1xZ6pzxCUh19BjIjndEBIXSuRTDfuY
         qx9/9/5m9ch290pcY9Ja3rOdcXROVpGCxijfWSTRTPRXsIbZyUk5SQxtSIB3iaxG8Rao
         6Zjg==
X-Gm-Message-State: AOJu0YzbVzMF3cvi0GTDJ7dF9X/OzivQulv6Px5HWocW/gqpWUhebD5p
	MDAp37fs6bUgscz3QyjflSMcNT6IwWq+19Yj+3FXVfnpMY9peBo8e9gkZdHYE7fQviwpWJp8rro
	9DsbzsCMspQWNSlrQSfxJbn/M0ygkuEHgg4hI9ybZzZ1zdZ7Z42QX2fymvD29/w==
X-Received: by 2002:a05:6512:b08:b0:52e:9694:3f98 with SMTP id 2adb3069b0e04-530bb3a05c4mr11745166e87.27.1723023118268;
        Wed, 07 Aug 2024 02:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSNeodwOIRVjf8BygI5G8mPHdm5QLJ8t/mFmXovDM4n7VsdwJ4Sdm5FWvkPbp2t0Sutbf0w==
X-Received: by 2002:a05:6512:b08:b0:52e:9694:3f98 with SMTP id 2adb3069b0e04-530bb3a05c4mr11745147e87.27.1723023117621;
        Wed, 07 Aug 2024 02:31:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290566729dsm11335695e9.0.2024.08.07.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 02:31:57 -0700 (PDT)
Message-ID: <3230697b-55ea-4776-a5f8-5116366741ad@redhat.com>
Date: Wed, 7 Aug 2024 11:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] mm/pagewalk: introduce folio_walk_start() +
 folio_walk_end()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-3-david@redhat.com>
 <20240807111754.2148d27e@p-imbrenda.boeblingen.de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807111754.2148d27e@p-imbrenda.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 11:17, Claudio Imbrenda wrote:
> On Fri,  2 Aug 2024 17:55:15 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We want to get rid of follow_page(), and have a more reasonable way to
>> just lookup a folio mapped at a certain address, perform some checks while
>> still under PTL, and then only conditionally grab a folio reference if
>> really required.
>>
>> Further, we might want to get rid of some walk_page_range*() users that
>> really only want to temporarily lookup a single folio at a single address.
>>
>> So let's add a new page table walker that does exactly that, similarly
>> to GUP also being able to walk hugetlb VMAs.
>>
>> Add folio_walk_end() as a macro for now: the compiler is not easy to
>> please with the pte_unmap()->kunmap_local().
>>
>> Note that one difference between follow_page() and get_user_pages(1) is
>> that follow_page() will not trigger faults to get something mapped. So
>> folio_walk is at least currently not a replacement for get_user_pages(1),
>> but could likely be extended/reused to achieve something similar in the
>> future.
> 

[...]

>> +pmd_table:
>> +	VM_WARN_ON_ONCE(pud_leaf(*pudp));
> 

Thanks for the review!

> is this warning necessary? can this actually happen?
> and if it can happen, wouldn't it be more reasonable to return NULL?

The we have to turn this into an unconditional WARN_ON_ONCE() that 
cannot be compiled out.

It's something that should be found early during testing (like I had a 
bug where I misspelled "CONFIG_PGTABLE_HAS_HUGE_LEAVES" above that took 
me 2h to debug, so I added it ;) ), and shouldn't need runtime checks.

Same for the other one.

Thanks!

-- 
Cheers,

David / dhildenb


