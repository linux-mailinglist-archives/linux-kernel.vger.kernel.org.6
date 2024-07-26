Return-Path: <linux-kernel+bounces-263050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09D793D055
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3347D2811A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E6178370;
	Fri, 26 Jul 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTfJ0GH9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749086116
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985563; cv=none; b=eZSLbhZvHwE1srRX7SoHslaea2eVgLY/UNn7P1ol0ODGhWVpiUqZfLV89p+JP9FsY4hvrb8MAp/5STkgt+UfIIOGiIoIQbMxqaouVMnFreMQoF1V187lv7Dtxe7ltrjQPChSy7+SjOcJVGOIL2JXNV8Cmx8n4rgk4X4zwcdVP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985563; c=relaxed/simple;
	bh=GrJWO5DhLL5w4lfHh9wzpS6QchcXa2w8UZ7Q4qGFw9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWyUzFv0fQ5MKwKrYXEiU/UwX1W8fNihagFQ+YiAeu8aGE54iSTaoLw5b3KUhNembaIsM5BnMWUyoiX9aYot3O4oEv6GFcUg1Dd0B0RMkFbURdEprLLUW524l7YW859IuLdDPNRpVIw0p/3aU7oZd2B/s9AptQYCSdZ4BbMzQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTfJ0GH9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721985559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G0DkkIK3PSnUAyLdrY0sM7ojGwG6G8mQKTPJBTwsLP0=;
	b=FTfJ0GH9sAeEXEqBVEX7cvtyC3YSdSP1sUPseClDZ9rCFDX/uEsa6UTxPorQjxO0Ybyh1e
	7OuHV0s3X5xDRxvWAClNwCfa1GabxlhiPCC/cNHr3BJHK8vEiZxPdUOVHmlnV/8Weh5ols
	n2S8ZEiKX5ayzOK0KAApoVUxjkvr6jc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-gO1yMqj5OIaQp9mH2OikzQ-1; Fri, 26 Jul 2024 05:19:18 -0400
X-MC-Unique: gO1yMqj5OIaQp9mH2OikzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso10989475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721985557; x=1722590357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0DkkIK3PSnUAyLdrY0sM7ojGwG6G8mQKTPJBTwsLP0=;
        b=m1zP3RQwvt5rhD43GyJvjb1Sh5MfkhtKh3WrfP/N64Fp44RcbF9PlhYq8vC1z29fhT
         6rgq5txqlUbW9zn+K+Ks0VrJxsFmByPLUuMS7r+FlgxnayyPRBetG2eQ+7XF/Z3NtxnH
         Vy+cTwWUAjqe/dBjU4zBufSQ9Ey7v+GWWt8PC1gzWQZtiG05O5c1E3NgWZs33gxiSwEK
         x38yDN9MCWtlSCEBb9HOc3tBsg6QthmMM4DdtM9Bc/V+p437ycHTwzzMaLcPTddxapQm
         xyfMcdNtn7b0CUAI+sJQMjnyOjocnh1WZn5U7hTXBsEd5qzOaad1NLtrwYN/HS0AKvyE
         zIXg==
X-Gm-Message-State: AOJu0Ywh5Us1JrsH9t0ISSZuAi56OQZacilMYzeDmQ8mPelHEfIT5sA+
	X+CwL/RHBFzXz0McQkoHTEF1QaTwclYadIsSJ67mdfW3XrrVBwJiyFdYjE4f4ruwogoyMUwEt8I
	uxfMs18ypzzWupJHsXBgLuL+Z1+S4jVZEJeFfOdLmjHctbUAO7TmdhiyJoRGIIg==
X-Received: by 2002:a05:600c:1ca0:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-4280573b45amr35846615e9.29.1721985556855;
        Fri, 26 Jul 2024 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAQxegzcsGBbxhGNrCZAfeb7+WhfKfdbsPMTMY/zauZkvyIWuONfz3yMsjRSEJXO8btEK7gw==
X-Received: by 2002:a05:600c:1ca0:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-4280573b45amr35846485e9.29.1721985556370;
        Fri, 26 Jul 2024 02:19:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93592b6sm113534545e9.3.2024.07.26.02.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 02:19:15 -0700 (PDT)
Message-ID: <7d88ac63-46b9-4b2e-a46b-c78d8d1d9f0e@redhat.com>
Date: Fri, 26 Jul 2024 11:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725134129.fc9165ac6413c4f774b786c1@linux-foundation.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240725134129.fc9165ac6413c4f774b786c1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.24 22:41, Andrew Morton wrote:
> On Thu, 25 Jul 2024 20:39:53 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Working on another generic page table walker that tries to avoid
>> special-casing hugetlb, I found a page table locking issue with hugetlb
>> folios that are not mapped using a single PMD/PUD.
>>
>> For some hugetlb folio sizes, GUP will take different page table locks
>> when walking the page tables than hugetlb when modifying the page tables.
>>
>> I did not actually try reproducing an issue, but looking at
>> follow_pmd_mask() where we might be rereading a PMD value multiple times
>> it's rather clear that concurrent modifications are rather unpleasant.
>>
>> In follow_page_pte() we might be better in that regard -- ptep_get() does
>> a READ_ONCE() -- but who knows what else could happen concurrently in
>> some weird corner cases (e.g., hugetlb folio getting unmapped and freed).
>>
>> Did some basic sanity testing with various hugetlb sizes on x86-64 and
>> arm64. Maybe I'll find some time to actually write a simple reproducer in
>> the common weeks, so this wouldn't have to be all-theoretical for now.
> 
> When can we be confident that this change is merge-worthy?

I'm convinced that it is the right thing to do, but I don't think we 
have to rush this.

As Baolin notes, we fixed the same issue in the past, unfortunately also 
without a reproducer IIUC, so I'll try to reproduce the race, but I'm 
not 100% sure if I'll manage to do so..

So it's certainly merge-worthy after it had a bit of exposure to -next, 
but no need to rush this upstream.

Thanks!

-- 
Cheers,

David / dhildenb


