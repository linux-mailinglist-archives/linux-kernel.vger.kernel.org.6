Return-Path: <linux-kernel+bounces-571158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D79A6B9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0707AA9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B4223321;
	Fri, 21 Mar 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IICDbxJq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2A2AE6A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556420; cv=none; b=rMofAcZFxMVktvwIeZlhOVRE3unnpspD/EqJtuVK/ZwT8kGcc5FqarR0aGYw99cFDxmCODKht3EyNwECfvzfGKGb0x1g2gcOucgar5R/iYM4w1H6hvmcluOugmpiTEIILOHAiI2xXYYJSAMqJOFwwDevouqTrBKlMo3W2W6SSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556420; c=relaxed/simple;
	bh=gtthISrvBPw0sjJCds5ZqQdMnJ86N0JwsKFyL0bEjL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRBeG/tdy2IcHbusv+CuYDoNjvag7RCxIJVaWdF8LST+PkDFqToZZV9y0IdeVfVl7gUeMqUCApxCuL0y1kglZQWAbA94w5r7QY9HykcOh4rZ0BAddAcOP54ccbFcnaHcsYgKqdGdFAmwpH0Ou64UMGG9ShMjfhGta+5jF+BTH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IICDbxJq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742556416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5t8CTXBvozjSkWsfr5HjhmrPtSRHXh5qZc7tXOfsijk=;
	b=IICDbxJqN39PtYXhVcHkUMOvdJWzKwekNs6Ag1e5m/upEek47EGbcZyJCryf4FDPy+D5on
	uS7PyrwDmx0rbBBTHI80mA0BoTzF542xXM5YasBdrw9Abs3pZyV2lBpgUEHrtldnFk2lYU
	2DlEH0ZfK0yCL/SEHS2hLAFhIxDGwnE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477--vDPTs5HMMWLj-wtmPWNfw-1; Fri, 21 Mar 2025 07:26:54 -0400
X-MC-Unique: -vDPTs5HMMWLj-wtmPWNfw-1
X-Mimecast-MFC-AGG-ID: -vDPTs5HMMWLj-wtmPWNfw_1742556413
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241e7e3addso27620935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742556413; x=1743161213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t8CTXBvozjSkWsfr5HjhmrPtSRHXh5qZc7tXOfsijk=;
        b=jD6PQ28g7xGv3gIXZAxl1UIy6pVORADLXvA6SDJAML312S4ddM+X1oqXcuhsgnfuX0
         knxJWAkCOcVgB6Gnx2wsbgAn1LdOvj9jKWQMVtbWzPYpHp7kTdfA4gCZLX4SxAvywzB8
         jEBFUKgAsTmHnNeyJ3ga042/nM6Bfvdvdhd1vQGJnsN3toBLEMMPFw3P3QZmOU5V6Qwz
         oH0ZmqegF4h35wsouM0/TLA9fjc+qzcNrX3Ea91XifmPh55LJfBhfqwCIL0YHIWbcJNr
         cWuaPHlyI3v2EPFn7V+J0Bo8EQeErm5TX3K0QAaPNCosgs2eiDZX7IXzXJQzXluhf+DU
         bB3A==
X-Gm-Message-State: AOJu0YxZUWp7lCvY1sqnvvTsmI811peTYMmdNvNrCWcYOwr5xCH4jFPt
	2WBKJ0ry+pCkQfYSURmT4pHgZq5KEajUfxwVilujIdh/ZrrGqls5w2yPH9Mf2oAYdwPZyTfDJY2
	bcStPRnAMFtdEJDD59BSoyp4t9Ck4kYMYB1PcuaN41UoWkPt6BCAkAdNg6yR/gA==
X-Gm-Gg: ASbGncu1JygIQNkyptm17ssjaPSPDwiw7NK0GgkPr9e1GJhQB9B7oToWgo+7GD3NwZ8
	ylFLEexcq1bqdbjsNWDTUBPj9bJUU0a2oK1Uxk16bHvWAzNim1xVnqKPRk4Ut3PmG8TqGODV7Au
	Wqefp7T38izWoxkZHqiLwxGkodTZ2Y+MjIjbmmWZijMd1zMOhTPiqNp5gt6fsNreLhvXeAudPGx
	rRdCfdCufs9mPrreBe44mXTPU5x1q4AxyrXoMWZ4W1TLqByPPihuSr/d/7zj3jwa47/dAgpSTgw
	9aYQ+Xuo77wMLuNnoA==
X-Received: by 2002:a05:6a00:4fd1:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73905a253aamr5091501b3a.23.1742556413127;
        Fri, 21 Mar 2025 04:26:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Qqfyr6B8bsLxXxeQh/Wo7JYQY4tOPbEFYCnCV92lF5CSImpeVqV3WqCvsyiNvSwQwA8gIQ==
X-Received: by 2002:a05:6a00:4fd1:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73905a253aamr5091461b3a.23.1742556412745;
        Fri, 21 Mar 2025 04:26:52 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739061592c4sm1582987b3a.154.2025.03.21.04.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:26:52 -0700 (PDT)
Message-ID: <908c37d2-2da7-4892-bd07-4ec7ffb8fc3f@redhat.com>
Date: Fri, 21 Mar 2025 21:26:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Fix parameter passed to page_mapcount_is_type()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, vbabka@suse.cz, osalvador@suse.de, gehao@kylinos.cn,
 shan.gavin@gmail.com
References: <20250321053148.1434076-1-gshan@redhat.com>
 <20250321053148.1434076-2-gshan@redhat.com>
 <b6478ad2-7169-42be-b9ba-e703fdbbd553@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <b6478ad2-7169-42be-b9ba-e703fdbbd553@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/25 8:13 PM, David Hildenbrand wrote:
> On 21.03.25 06:31, Gavin Shan wrote:
>> As the comments of page_mapcount_is_type() indicate, the parameter
>> passed to the function should be one more than page->__mapcount.
>> However, page->__mapcount (equivalent to page->page_type) is passed to
>> the function by commit 4ffca5a96678 ("mm: support only one page_type per
>> page") where page_type_has_type() is replaced by page_mapcount_is_type(),
>> but the parameter isn't adjusted.
>>
>> Fix the parameter passed to page_mapcount_is_type() to be (page->__mapcount
>> + 1).
>>
>> Fixes: 4ffca5a96678 ("mm: support only one page_type per page")
>> Cc: stable@vger.kernel.org # v6.12+
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   include/linux/page-flags.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 36d283552f80..ad87b4cf1f9a 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -950,7 +950,7 @@ static inline bool page_mapcount_is_type(unsigned int mapcount)
>>   static inline bool page_has_type(const struct page *page)
>>   {
>> -    return page_mapcount_is_type(data_race(page->page_type));
>> +    return page_mapcount_is_type(data_race(page->page_type) + 1);
> 
> Probably we should just call page_type_has_type() instead?
> 

Yes, page_type_has_type() is better. It will be used in v2.

Thanks,
Gavin


