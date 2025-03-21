Return-Path: <linux-kernel+bounces-571162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC77A6B9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267253BC564
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6572236F6;
	Fri, 21 Mar 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOVQDZNI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5122256E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556496; cv=none; b=Lw0w9ue0bCUu9tVts8s/nDJKWgfE2OhMnjiJIVRSkX+mn8OBszEY/LMvk1a1+CMk2QqR6MByOAUTnckJQnLB2GIVfBfLuZuHksErJ7/TnYD0Q4CxV3YKQlcxLychyoGeCV+0wBgY9F1YZVkH2H+tAmngks0TYygMj6itMMqbntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556496; c=relaxed/simple;
	bh=b6O10MYA6vGuC0bipoTSc/pS0o+Ct4XAHQr+AYkCLio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVjXbiFbGdZKSyHf50sWNjMCtrCZiAw0JVda6PEKfdJCI1Sa/mQX+fk4z0WeIPSmXAnMyOV6mz1XT0tnPxWG4qBuUlhm3JG/Gg3nNwBS+zZFoKFv1eDiJualcwboDIyY6+tGQX5L+lSvXE+pm75etcbSLFt1nGkBKeUpkC7FalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOVQDZNI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+/o3ZZovn69lnNkwiyckvlWm9nS8xxkazVg7lWV4M7A=;
	b=cOVQDZNIOySUfnVNr3EuWAeN9soLb0HkRUC2ENJzghXdDkGxxNGkdFnwlv/4zELhw9E0HL
	y1vmQvKdRJzpLLupx+o/lukQHDUiuQMWVV+T8nIsWekJI2dKOhpgIeXT5i0rFFxZaH0n5E
	VgTUYlzOT27CB3/N+89aMdoHQUX9/fA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-o8S1bymjOxGSq7EKW5aZKg-1; Fri, 21 Mar 2025 07:28:11 -0400
X-MC-Unique: o8S1bymjOxGSq7EKW5aZKg-1
X-Mimecast-MFC-AGG-ID: o8S1bymjOxGSq7EKW5aZKg_1742556491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913f97d115so904012f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742556491; x=1743161291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/o3ZZovn69lnNkwiyckvlWm9nS8xxkazVg7lWV4M7A=;
        b=JCIOyB5L1ko6Um8FRW5WCqGBH8QO0JRHV67QAwSS75A6mEnncFYZQ5zNysO0z3OOX2
         On/udwKE1ouBNYtMQwZ9bIXBY/PgtIYoKjpJ6sR6kB7JMUSYU22+eh+bm+3QtY1f69FP
         dJgZUJZUauO8k47jiSiR7sA+G4qrV1Bt6uSsq7GtC6URlxzlu7kLRKoLF3WWEHK9k9TU
         KptpuHsXlJ99MZH9JaWGhN+FcxOs0K0zFUdWA4wQj1CoX7OJe6r1Nb0APa0ZpLyzh8/i
         z+pwePm5huv3hRot80xCyIG9YOZNjZ/S/tBPM97xyUMfK67ohHX9u5Jm4qGbhZO146lw
         TGOQ==
X-Gm-Message-State: AOJu0YxheRLPu5t+EzzRiot8815VUvOGgcGWytMS690C0U48WPe9kpcA
	fTyAeyVkLoH7MlvtmSwVxnsFKAaEPGe6k0yfrOyHy4v0aIofxtTngLBBGXVOnm3ccWZQmYZzdNc
	MhrkDJq1ocMxWu/6oY7vsItqXvxPM75IFmVNLprpJ0rTOD4i7RJZmJtAUx2qfnw==
X-Gm-Gg: ASbGncvnpoS7W+EMBj02gynvjcJ2llGgXbTIg5BAuQ3aTQaW1buNLn05wWDdZXTKxy1
	1aUDqDA90gmhyZNox03bIlGP/Ua/Lu48DuLD+FjZW3rEqeaO8x1yr2PLIsiVQ2rgID4ny7d3FrC
	4WLlW131O7Q6tU/GuHyTrT8H9d9ivkS5CSPjKoPJhS4HId5fOVcM0kt6Fat6UcUcdsbRUS0gPvb
	vveSoLQXEwschVca/yAFHw66i4UN8TRou1P/pTV6nUZ5gBl2NzWG/BeebzC3KAQyDjD3egzZ3fN
	ij+Kp2+ZiBuDPUHqFXC6f8Z8d3dFxM5pvlNKvp9ew68okcOXjOS0lvR/G11yTX25vy9VA8IxHcf
	lnMIo1xuDylLmz4cYCFcY2TUvsM9hMBn387AwB6W9paI=
X-Received: by 2002:a05:6000:4006:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-3997959ccd4mr7119757f8f.26.1742556490574;
        Fri, 21 Mar 2025 04:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC3StONR8mWibQqKgFRF97Pa4uvGcX7IgZDSet6F/Zqw7Ng5dS90Rejg0NE48fgzpL3XL+1Q==
X-Received: by 2002:a05:6000:4006:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-3997959ccd4mr7119727f8f.26.1742556490102;
        Fri, 21 Mar 2025 04:28:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b4ce9sm2146793f8f.53.2025.03.21.04.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:28:09 -0700 (PDT)
Message-ID: <805065c4-b396-43e7-8a9f-f934ec616b31@redhat.com>
Date: Fri, 21 Mar 2025 12:28:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Fix parameter passed to page_mapcount_is_type()
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, vbabka@suse.cz, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <20250321053148.1434076-2-gshan@redhat.com>
 <b6478ad2-7169-42be-b9ba-e703fdbbd553@redhat.com>
 <908c37d2-2da7-4892-bd07-4ec7ffb8fc3f@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <908c37d2-2da7-4892-bd07-4ec7ffb8fc3f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.03.25 12:26, Gavin Shan wrote:
> On 3/21/25 8:13 PM, David Hildenbrand wrote:
>> On 21.03.25 06:31, Gavin Shan wrote:
>>> As the comments of page_mapcount_is_type() indicate, the parameter
>>> passed to the function should be one more than page->__mapcount.
>>> However, page->__mapcount (equivalent to page->page_type) is passed to
>>> the function by commit 4ffca5a96678 ("mm: support only one page_type per
>>> page") where page_type_has_type() is replaced by page_mapcount_is_type(),
>>> but the parameter isn't adjusted.
>>>
>>> Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
>>> + 1).
>>>
>>> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
>>> Cc: stable@vger.kernel.org # v6.12+
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>    include/linux/page-flags.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 36d283552f80..ad87b4cf1f9a 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
>>>    static inline bool page_has_type(const struct page *page)
>>>    {
>>> -    return page_mapcount_is_type(data_race(page->page_type));
>>> +    return page_mapcount_is_type(data_race(page->page_type) + 1);
>>
>> Probably we should just call page_type_has_type() instead?
>>
> 
> Yes, page_type_has_type() is better. It will be used in v2.


Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


