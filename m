Return-Path: <linux-kernel+bounces-170900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B68BDD99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06601F2577C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5814D45A;
	Tue,  7 May 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKQcSR4f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592114D458
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072348; cv=none; b=XI9/rVR9it50m+JZjstm0S8ba07upptGNE2Kf/GuMrTgZefHH9oMN1S7r1yuuO4Mt+yG5QxPZ3bisCo7qGGym8Xhy2hUxHLpKTNNg7na62rIUyZ1U78FHvdtCABZAw2D0q86xUBwoiujIlJTgBeK9m00OPv2Yu5NXvEEBkOgmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072348; c=relaxed/simple;
	bh=FZsO2skHxmUrODtTzu1m6gXkPhXiNngWnFnbrc0g+bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAhDtk1RFF6nADTfzFyWsae1lr8EwHFhn1wghYkk2O9cYw8XFRgpjm/TYSuaS0KM3BObyaGuTWH58wuU7i6rev9bwmXJ+ykIqqUqKoJErxSvC0iIlaXHNPDjklwv20YWf2AAtnyJ1lJ3BM+AlptV+KHtHILphqA3Rn9x7V9qwDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKQcSR4f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715072345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x/XzJP7tLMCGyHUQX3sqk1tvaXIMKZPxWOYS7id2UHo=;
	b=RKQcSR4f2t6TRP8PvJzD1W8uGQM6qxibHf6uGx2pDT26JDyjGrrHQ5vWDWStQvSOet1/c5
	R0cKDcXxCAinwbQZ7uYNUrPWOrsTgiLQDN7c8CC3jeARgd1wQPGXnBs8nc5sHrbNC1ycl2
	tWy7khEUEvzcrLLPj/5+zH9OsxFx4BQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-UJ2E8RYxPWqq4G61GoZfDg-1; Tue, 07 May 2024 04:59:04 -0400
X-MC-Unique: UJ2E8RYxPWqq4G61GoZfDg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34e0836d91eso2159411f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715072343; x=1715677143;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/XzJP7tLMCGyHUQX3sqk1tvaXIMKZPxWOYS7id2UHo=;
        b=sXQ1QqrgeztnUCwqKMg2sNauP4HwhcsZ4a9IDYa00JvuNfpfYwtJDNHs1DzJeeJqXb
         cw6IzJRGuSbxd+TS568Wv6HQRcj/TG8AVJcBJq6nGPJTU9uy5b6AaA+7RL3XdwfSypqM
         I7UwvDYXn4ggGk/maN7YeHsOGdLzCfVqJN+SLWE4RlKhvukscGNATSqYkJPBgpAWJ5a6
         HunntWMwnauJCVtTV2451dLYHn8/9JoYYfFWsHZYbkY1P3P31xKku2hphJ1MP5wsIl3I
         cuCvpjFqM8FSvix77ZRZ5u2sh7ogTFEutPoG60uCWPBaI5OsRtydbfBuTqaXy0mJC1mI
         Rffg==
X-Forwarded-Encrypted: i=1; AJvYcCXeEZl7TTlUrNaF1bm60K3lVMh11InbkDzzmcftQc5EpSjrRZ9zn33XRT4fOzz726db+EwwCBAo/KPfqXAui+XrFjdZrvtgKSckeriN
X-Gm-Message-State: AOJu0YyPZjmXZQkKISLEWhLpZ6JCEg3GSJlJcTgnJHDgBY1ttMoxLBs+
	1JaTeC3yrcDogYk4yM44Tl1OapgqTdicZrifRmfDrXntN5Y+R5xpPiKsTg6FlbNIs8mdawrC5TG
	EJoCwaFFwhGzTOco/Q785ljAYarS00TXfU0xnzjxJKs41YVLnx5eNfAT84VxNtA==
X-Received: by 2002:a5d:45cb:0:b0:34c:9383:844f with SMTP id b11-20020a5d45cb000000b0034c9383844fmr8350953wrs.57.1715072343029;
        Tue, 07 May 2024 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdZNH5ovZui23voWnrBmxS5DSjZGf8+niBkuVqcAC8kKSrn7nbOXza1MGkwBPH73nNpNQ0Mg==
X-Received: by 2002:a5d:45cb:0:b0:34c:9383:844f with SMTP id b11-20020a5d45cb000000b0034c9383844fmr8350932wrs.57.1715072342607;
        Tue, 07 May 2024 01:59:02 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6287000000b0034f3f756293sm3812174wru.6.2024.05.07.01.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 01:59:02 -0700 (PDT)
Message-ID: <099a2c9e-f85e-4fe7-99dd-81b61115935c@redhat.com>
Date: Tue, 7 May 2024 10:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
 <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com>
 <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com>
 <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
 <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com>
 <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Let's assume a single subpage of a large folio is no longer mapped.
>> Then, we'd have:
>>
>> nr_pages == folio_nr_pages(folio) - 1.
>>
>> You could simply map+reuse most of the folio without COWing.
> 
> yes. This is good but the pte which is no longer mapped could be
> anyone within the nr_pages PTEs. so it could be quite tricky for
> set_ptes.

The swap batching logic should take care of that, otherwise it would be 
buggy.

> 
>>
>> Once we support COW reuse of PTE-mapped THP we'd do the same. Here, it's
>> just easy to detect that the folio is exclusive (folio_ref_count(folio)
>> == 1 before mapping anything).
>>
>> If you really want to mimic what do_wp_page() currently does, you should
>> have:
>>
>> exclusive || (folio_ref_count(folio) == 1 && !folio_test_large(folio))
> 
> I actually dislike the part that do_wp_page() handles the reuse of a large
> folio which is entirely mapped. For example, A forks B, B exit, we write
> A's large folio, we get nr_pages CoW of small folios. Ideally, we can
> reuse the whole folios for writing.

Yes, see the link I shared to what I am working on. There isn't really a 
question if what we do right now needs to be improved and all these 
scenarios are pretty obvious clear.

> 
>>
>> Personally, I think we should keep it simple here and use:
>>
>> exclusive || folio_ref_count(folio) == 1
> 
> I feel this is still better than
> exclusive || (folio_ref_count(folio) == 1 && !folio_test_large(folio))
> as we reuse the whole large folio. the do_wp_page() behaviour
> doesn't have this.

Yes, but there is the comment "Same logic as in do_wp_page();". We 
already ran into issues having different COW reuse logic all over the 
place. For this case here, I don't care if we leave it as

"exclusive || folio_ref_count(folio) == 1"

But let's not try inventing new stuff here.

-- 
Cheers,

David / dhildenb


