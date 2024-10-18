Return-Path: <linux-kernel+bounces-372238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002369A460B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A829B283D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAA20408A;
	Fri, 18 Oct 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyjUPa1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30A202F71
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276949; cv=none; b=YuAhsmC7EmiQIi+QqHZq9hUT9SVN+Dcr8nGRL8DXY1MFnWwnzKgpLEugzgrt0wxdvtyT6EoX+Pnhq14KkE6MKHVptLB7NM4dSlm2GqrOS8BKt0cwLiLMPjhLl3124Pw1pQ2v6a8z/YovL7Zhb1T41hSgzjZzBb838fmkEDdTMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276949; c=relaxed/simple;
	bh=GEpcWi5C9Asj2k8N3KxrwrVkRKmU8iOKRFBZC2L4BdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuXwJzZyaj0x5jCG0fwU0ZHSYOhTNyD4NKarOg1cCAq9gSYb+VZ7ckKCokoZl0l4ocG4XEsma/IpqVPB2rlCMRhH++tn3CCfbF27OH2XJIKJEZAiAdF1TflM+B9DBOMDmETdjr/tjO1MAj2a9dtpzLof7hLuA3bKk1ta5RH2x2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyjUPa1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729276946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kEHREo/6vx6EwxGigHZxuVZ7HO5/M0dBIlZFq7rjQb0=;
	b=KyjUPa1m2QP0qNAVaGK4/jb4/LzUIqTRwoXN4NG5lB07KHFkA/X9B5PLw+K8EFtqRsaSDY
	fQROZDnNbMvujmMG5pfzxK0u58kIzLdRDqHoUPS+zEvwOJtrall1woysbsBIml62CyABwH
	hlNk4NOnZ2tuyzusOVmzGXVj3gyfX2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-rmJBylLRPU6Gh63Kx7xzaQ-1; Fri, 18 Oct 2024 14:42:25 -0400
X-MC-Unique: rmJBylLRPU6Gh63Kx7xzaQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so1262549f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729276944; x=1729881744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEHREo/6vx6EwxGigHZxuVZ7HO5/M0dBIlZFq7rjQb0=;
        b=YqVxeBMW5NsAfLjyS6w0sDZU5raSQcT/BoQwTZA7RGXVWQG9Qi6R/uc8GaDsp+LmhN
         qj5KAjReQB6ZpjUHZfVzbRfSfhPFkzqnz3iMlBOjuVYDhvm6cy2xuBRbKZA/Kwf+6nFY
         us1xBSnxU0pzFJOhOlwA8tNHNR8yS6rCUq8hhWiG1Y6bTy0/yOOF5CChJeLdhUMvac/D
         72Kn7Bsq8FQnbjJQJz3g7ggxblsusbPQ4wGIt5wENKX5kLcSQYF8Nn5X5U0fssshIMdl
         EjFHrw0lnFma9Lrn4R1wBOc4qsV4BW7VhmYTTxBYX/80JPSCQVpxjMG6lBWeikSh8uz0
         DN2A==
X-Forwarded-Encrypted: i=1; AJvYcCU9klu9Z9BKk/7ydSV4/vMDR0xjL1/6r1tlSW0+qVCzDSuiYwRLo0uuIctuT6BigpYICMiCvXmy3KsvmRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkIS6UANM+JGVaA0HbTgz3QTnwR9VFGFiYaYaWTSlyj6z947a
	8P03uqXwjjzgn4S1OtxODHXTMrA1h0uuHsWMHlLQ34QBRpGuoyjlaQylgXyuduPn4xhUeuKfNUc
	RfjWmqOMED6T7EUhFIfTP4psM9D/pchWHm6OPfhKKvmytDU4sjwXwRC26Qbc7Sg==
X-Received: by 2002:adf:e386:0:b0:37d:37e4:f904 with SMTP id ffacd0b85a97d-37eab4ed7e0mr2570224f8f.36.1729276944589;
        Fri, 18 Oct 2024 11:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9b4bKozbt5gskGcurGdfWU61xhk7EoXHvIi0Z8cD8zTi2F1HrAUG4WNiw/qg92Ad+yl3YDw==
X-Received: by 2002:adf:e386:0:b0:37d:37e4:f904 with SMTP id ffacd0b85a97d-37eab4ed7e0mr2570208f8f.36.1729276944206;
        Fri, 18 Oct 2024 11:42:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027e31sm2557761f8f.12.2024.10.18.11.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:42:23 -0700 (PDT)
Message-ID: <7ec81ff8-5645-42a1-a048-c8700aff07fa@redhat.com>
Date: Fri, 18 Oct 2024 20:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
References: <20241008223748.555845-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241008223748.555845-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.24 00:37, Zi Yan wrote:
> Hi all,

Hi!

> 
> Matthew and I have discussed about a different way of splitting large
> folios. Instead of split one folio uniformly into the same order smaller
> ones, doing buddy allocator like split can reduce the total number of
> resulting folios, the amount of memory needed for multi-index xarray
> split, and keep more large folios after a split. In addition, both
> Hugh[1] and Ryan[2] had similar suggestions before.
> 
> The patch is an initial implementation. It passes simple order-9 to
> lower order split tests for anonymous folios and pagecache folios.
> There are still a lot of TODOs to make it upstream. But I would like to gather
> feedbacks before that.

Interesting, but I don't see any actual users besides the debug/test 
interface wired up.

I assume ftruncate() / fallocate(PUNCH_HOLE) might be good use cases? 
For example, when punching 1M of a 2M folio, we can just leave a 1M 
folio in the pagecache.

Any other obvious users you have in mind?

-- 
Cheers,

David / dhildenb


