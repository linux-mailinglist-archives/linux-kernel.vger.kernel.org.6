Return-Path: <linux-kernel+bounces-188379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE28CE14C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A21282848
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A872128374;
	Fri, 24 May 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTGsz5+z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CC36D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534295; cv=none; b=odgpWiEe3SzkWiNqG7yP07KDVhvyYoVj/WRQKRCtB20Sd3nGrV1PVEXCgfJh030wOk3CKIotsa6xistlGDg8JUghN3HY77fMQv0zkirbB4Dh+jqpYrxY/unD+mMkCMmBCrasLEpXLT0A1TkpxG8GI+oyXO9iyzPxtz4iXmd3Zv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534295; c=relaxed/simple;
	bh=e3BXT1PablyFvLf+qJm5pKwAzypSU5WiAQpdoJQOyXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAblMVU7JvEeQo9YtrL1aBWr3nBrOQ8T5r0P+M25HaZByNjGRA/J/Y7YbCA9d8UxOEba+9P7eVzHaPFMvtfidfMsVLbTiL9ykEoc++SbYe0PHHMFpAXiq0N0jpg8wMJTBLNa6dL0FZxqj+dtAn05ZRmlOKF2sPJ5rWlXCYzMOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTGsz5+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716534292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NkZj75EFLaQBFYfelEFxSPNdCTwZcFmz5ibsjes1oxM=;
	b=PTGsz5+zz/QE8tWh/sJ9AkBew/XLUFJrWpQYaOojm/lartyXnxOZCzKGNme+FHUASaCWMl
	VjWDpnWs7oCeHHEBCZ4JlBaFPDSTVKiH4MsuxEUqx2xk6ZvvCZ3nyxRFmjndL2cbYi4pNi
	fBhfC8n27WFHtK0hAH1oLAfWZgN9wAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HhmvlThzNW-x_ekMswRuDw-1; Fri, 24 May 2024 03:04:51 -0400
X-MC-Unique: HhmvlThzNW-x_ekMswRuDw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41ff6049fdbso81024035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716534290; x=1717139090;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NkZj75EFLaQBFYfelEFxSPNdCTwZcFmz5ibsjes1oxM=;
        b=m7mEXnbNZz89xMKDqjx1A0xFFdrWw+HRXz3SH/qDY+bJlM9y+6k07n33MDqgznrxJ6
         piwTy0lC7zX2aZj9T3/tQ/wh4QGRRKm0CDEGUeBqfFDGtWM4Nez60B6z2ZnoewNGpc5v
         ywWCqb5hhUxOhv019/mwcgBtNWa0YQ/HsL78TflIGumWA/jG5lrEjt24DC2nhEmVqvxt
         UFWA/xQr1wgjHvO4c2cs1552HzrBX+sClhR75+bhvBqHScBy8S0HKUynuOst/1KiNvvE
         2O6N6zoBYePyZwl+mcV91zKKjE4ig2YTlft/nk4W4shQAQ4KOQNx0REgy+h0s/v1Yk3N
         RGiw==
X-Forwarded-Encrypted: i=1; AJvYcCW+uSN5Ff/YWudt+l5pVQZER1pC+uzTX2m/X71gowPlgUGyIaNCI8BcXjLZ2ajs3XLomE8AAzd9/Rloy0QJdJvOYrXatRzyCzyGq/UZ
X-Gm-Message-State: AOJu0YwCGs0JSiDBvcfKzW/KxVNo+H4BUEzR42nk2IkVLbwhckNAMTEM
	bUt7LBvgCZBbhRBHY7oHekqwQAsswx7p9I9L6sSQWjPuYRvYrMZbyXFgpIRmix73uRMTRBUP4QQ
	QEAxM6zg9odRA5gF9KGGCz89lfch/ZTDp8EW4U7Tdyk5g9lL0h/2d9DjuH2+i0hOejUR9zQ==
X-Received: by 2002:a05:600c:2187:b0:41a:9fc2:a6b1 with SMTP id 5b1f17b1804b1-421089d4473mr11403885e9.22.1716534289481;
        Fri, 24 May 2024 00:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbANVVttmPhRy5gHlbyox8+DZJn76ujulbq5P67qrxVc/eZb82/ecPtVBcBLTUTWyIKsHvgg==
X-Received: by 2002:a05:600c:2187:b0:41a:9fc2:a6b1 with SMTP id 5b1f17b1804b1-421089d4473mr11403675e9.22.1716534289058;
        Fri, 24 May 2024 00:04:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:bc00:e919:27a8:d431:782a? (p200300cbc724bc00e91927a8d431782a.dip0.t-ipconnect.de. [2003:cb:c724:bc00:e919:27a8:d431:782a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccb10sm12101655e9.44.2024.05.24.00.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 00:04:48 -0700 (PDT)
Message-ID: <d9ed9876-db41-461e-9fb4-8932cc53331c@redhat.com>
Date: Fri, 24 May 2024 09:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in
 contpte_clear_young_dirty_ptes
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Jeff Xie <xiehuan09@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
 Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Zach O'Keefe <zokeefe@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240524005444.135417-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240524005444.135417-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 02:54, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We are passing a huge nr to __clear_young_dirty_ptes() right
> now. While we should pass the number of pages, we are actually
> passing CONT_PTE_SIZE. This is causing lots of crashes of
> MADV_FREE, panic oops could vary everytime.
> 
> Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jeff Xie <xiehuan09@gmail.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---

LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


