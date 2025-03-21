Return-Path: <linux-kernel+bounces-571528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41821A6BE65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2BA1748BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBCF1DEFD7;
	Fri, 21 Mar 2025 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnYtZuWh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A131D7E26
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571516; cv=none; b=rDrAVBuBgceDL8E2YlO8Tr7jb/I/ppDXvb03UuIPDapNxe3ErlASqCnVgYAi9LMQu1D0xFCbDJDPHZNR8t+/l6oYsZ6x5UtK/toDLYf4A02rUrWSA5t6QcYMBIdsX2ZSC+TETAvvFv4QQ+1I+McDpItOPRba97hipGtu6wQ1wZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571516; c=relaxed/simple;
	bh=rqsjJPMTZpu6sgXrFzH5ylQqPBEIrvyY65ZQRbbuNLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3VaKCA65eDlNgoZ8dmXvAw8So2jDuahDeMifZqi/SVW97VhIyDDqrtTHb9jIw3m2OeMRHwp3tl6UDG7bWA7YbYsxJsJ5Bn/wGZ2ElpPwiNortyZaPSJY2PxSGGBXCG3y6DkBI13MhkLSg40DzZnGiw0Mw0yHVFTtcwrDbZyDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnYtZuWh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742571514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/JTz4j8tKcSX3al0GAg/CwbyFd3xgMXdkL6OMZbKdfA=;
	b=fnYtZuWhGJvQ1FMap43Vn5YQzJOWkqluFrI5qiUBDv0Rv7br3FjbWTh2IQThwYimhdZNoR
	4ES+lWTsrFgaCQsC6AcfBXoH618/zPYEkiY34+5fn0l3ns6ufGQPoTrSjEsQR8O6kOezdU
	ns3YDAwFiItgLtpxxOLVD6QAXI1jxtQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-dDxSfWmUOOSWoA4WJR2ZKQ-1; Fri, 21 Mar 2025 11:38:32 -0400
X-MC-Unique: dDxSfWmUOOSWoA4WJR2ZKQ-1
X-Mimecast-MFC-AGG-ID: dDxSfWmUOOSWoA4WJR2ZKQ_1742571511
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391459c0395so1060388f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742571511; x=1743176311;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/JTz4j8tKcSX3al0GAg/CwbyFd3xgMXdkL6OMZbKdfA=;
        b=o2PETpYGkeySAMHXJhQWcozO0btZaCg7/WcVo7GGRazywEkhhrZqqcRSVfOCkFFmgR
         Hacr1B1SNeowgFjIEQ9BtAnwfdfwZSHHWJyGj9LmDOQOA1zW6SQiiZYXybHvp4Q7gWWR
         gW3b4+Tys+SJbvGohHgPL8vpwJ3ev3XQTS3/7O20sBZwO5f6sTqGiw+7rU2RD4laAZqH
         c2qF4GYAAhHpKLV4TNlL5YpBOFzYdmn6K8BfTE7RWxXbJOJ+fZn6m4WHiVgqfyIWFztu
         eiHZ44hYgXzZvrMVoJ/b75jqVEDRWR3aVu3tjHHx2ffjIoSpfDsZtSvYiarJD3cDGOyk
         YROg==
X-Gm-Message-State: AOJu0Yyyps9aaVTxPb1K20yinBuIWhW/SG0FINFr7AGtfnT756cIh8PR
	b1nqzSKmb9LtxTTRm8w170NyO5m/laWKZ2gG1ly7/7XT+QAj0H+iXG2FvhEcATCwDKCq8VVaExZ
	X5q8RwnC2hy2aYO6p1Sl9aq7t7qgczS4M3z5De0+f1va0Ro5uEbdQFuwz4pSIYg==
X-Gm-Gg: ASbGncvh5zOcthou+NsJcNeIJ6ei3cLjhHXQHSeZIIEC0exjpTSsTPM02rOJJ7ogsDM
	7YQQIfUQI5MW67AMOy01rV2X4dAIwOZzJirZ8CN7mmDcNXKzgEcNJCkHNcisW1mUumMSh8gf3cA
	GzAxuXa4iH0eaewqzvzvjBhtia7EC3p1UnG0I53ntlb0gRy6MlX9O6DtQ8xthY07J5xv1HQlIfA
	V7wcZQpqdwn8e1K2C6z8cp5ek0ITf4MxD5JFwhJpeDLkZ5RyBXLJBF0ZZQ557Ld+BRtBFGJ/hhz
	8oURo1syCLcrNI4Fj1l44T4na0qTsNsqV+6wbURWbf0cNAxooTJxiKTFPK6452S0RJqvy5xBN4f
	CJEqqtbnMuzZqx0laXjXG4BNZEPk9bvKJ7P7RfE/Iotk=
X-Received: by 2002:a05:6000:18a2:b0:391:3028:c779 with SMTP id ffacd0b85a97d-3997f95956cmr3933777f8f.45.1742571511261;
        Fri, 21 Mar 2025 08:38:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkXJDpaFiooyKJSo7RFfnisk8PUrmJLvPgXlc2rWYrQqTlzxQ6hTTD91hDZN50YiW7kRV9Uw==
X-Received: by 2002:a05:6000:18a2:b0:391:3028:c779 with SMTP id ffacd0b85a97d-3997f95956cmr3933743f8f.45.1742571510825;
        Fri, 21 Mar 2025 08:38:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:9100:23d2:3800:cdcc:90f0? (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3428sm2692106f8f.26.2025.03.21.08.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 08:38:30 -0700 (PDT)
Message-ID: <3e6040c1-81f4-4977-bbb7-70908104aa45@redhat.com>
Date: Fri, 21 Mar 2025 16:38:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/debug: Fix parameter passed to
 page_mapcount_is_type()
To: Vlastimil Babka <vbabka@suse.cz>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, linmiaohe@huawei.com, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321120222.1456770-1-gshan@redhat.com>
 <20250321120222.1456770-3-gshan@redhat.com>
 <809792d8-8717-41d9-8dd8-ca91a5b54a28@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <809792d8-8717-41d9-8dd8-ca91a5b54a28@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 16:19, Vlastimil Babka wrote:
> On 3/21/25 13:02, Gavin Shan wrote:
>> As the comments of page_mapcount_is_type() indicate, the parameter
>> passed to the function should be one more than page->_mapcount.
>> However, page->_mapcount is passed to the function by commit 4ffca5a96678
>> ("mm: support only one page_type per page") where page_type_has_type()
>> is replaced by page_mapcount_is_type(), but the parameter isn't adjusted.
>>
>> Fix the parameter for page_mapcount_is_type() to be (page->__mapcount
>> + 1). Note that the issue doesn't cause any visible impacts due to the
>> safety gap introduced by PGTY_mapcount_underflow limit.
>>
>> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
>> ---
>>   mm/debug.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 8d2acf432385..b6bd9555ec7b 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -71,10 +71,10 @@ static void __dump_folio(struct folio *folio, struct page *page,
>>   		unsigned long pfn, unsigned long idx)
>>   {
>>   	struct address_space *mapping = folio_mapping(folio);
>> -	int mapcount = atomic_read(&page->_mapcount);
>> +	int mapcount = atomic_read(&page->_mapcount) + 1;
>>   	char *type = "";
>>   
>> -	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount + 1;
>> +	mapcount = page_mapcount_is_type(mapcount) ? 0 : mapcount;
> 
> At this point it would be perhaps more obvious:
> 
> if (page_mapcount_is_type(mapcount))
> 	mapcount = 0;

Agreed, maybe Andrew can fix that up.

-- 
Cheers,

David / dhildenb


