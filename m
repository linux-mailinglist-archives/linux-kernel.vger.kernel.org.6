Return-Path: <linux-kernel+bounces-380622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694219AF3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEE21F23132
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF12010E5;
	Thu, 24 Oct 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5GcrrmU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F45198A30
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802362; cv=none; b=TK9KMdxBse0i6sDYdX+E7hymrzY3f+50C2942pOZ6ngJ0w55PdW+bx8mkREOBLi4D9DUrFXdKP/J9Lhv7qpFaSJ2Nk52Itx6exfYtoSL+I4y0ulNr5S9y3A1p/R3NCbbXEW87jsEMiXW1BoOhY8zIPWF8CbQZiZt2/SiTfDyXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802362; c=relaxed/simple;
	bh=GAAXYUjUhe2bquV6heoev4F+E4yMf3193cGGjfEJsRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7PEsCCnmtIoH1LXJZiQqwLD2VCMwjm1Ht2WyPG7EiyJI4vZ9wAeg3gp15pbPFo9N2o2lJWRknR2Mqv7ZL1F3spm2v602HO/7WDrWB4J4clIhUoydDouFkHPh+x/4cDnvjyKbWbnRVA/3H4afDGAWREZEYb7t0cgLbztNX7oE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5GcrrmU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729802358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VrDjFHWwFaSn2dPBGq1QzYfOoHbmmQfyo0DjojU8BO8=;
	b=b5GcrrmUfqHEDqwOaqhIZlKbg/VXkHTAYzZX2U6Ke2Nl8zr7pjCOqDPeNy1AWSLGg7nqO1
	IgqzvMdllRX8ySrWRdq7Te+DpE1L/2mWzkM0uOOnWBAfal6vbK1FpFi7U3cnGIAzRzeCDk
	qLMclTzqkcZYRSh19mTbHsDd+f35mn4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-QYu-8RumOLGxhjSLdZYjvA-1; Thu, 24 Oct 2024 16:39:17 -0400
X-MC-Unique: QYu-8RumOLGxhjSLdZYjvA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43164f21063so9411085e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802356; x=1730407156;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VrDjFHWwFaSn2dPBGq1QzYfOoHbmmQfyo0DjojU8BO8=;
        b=AjseUsRxtel5maAy643JjpoeK3sMYj8C56d6lH0oKOc4XIw0rrL5VuU4lio/HfqAZK
         oBSH2vvy0ihQbalThqrJ0RJX/xGhC2lI16nBnY0I262RbjW1OQG63ceZ7fj/kxzjA15G
         dxMhHcMBaroxVLIqzIohxZpZ4Ng1xCX63hVTo6yXqPwuzp/jUsaay0/rWekVJE9kcvSz
         7PvZOvEBCK6He+WQvR4gk2/q1/prRFUsPncI5YIZEF0u79p+IPA9dc39Ib1cY+/0c6gx
         kFFFnBIHs2In24HpRusviQQvl+TMxvgqNF1y5jrRt4GwZAH+FoVfLNleXcHSCLM8ByeS
         z76Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVO38UUXWm2IqW5iyBzrTiG8uk5y/+RB5Z4YqKV/UEDohWTfzWo5e8GyPxTEBbdbK0vc4kbNavKak02r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoTOzH3cvmOFCvCWScGiET/QofsJgE1EGkLA0uzA5WkyFwCxW
	StaBa7H0QiBKY+o8xQo0Yc1tDa7EEQjWCyxUIq3m3gp+s0ZV9oI4/7Iu6Wqq8j2D0rWp65NXW9+
	zaxwmFbHhuE568h5kBvOq7chvPeLBZDXY7I/HbU5NAjKoTA5uT/0CGI4Q/YBQJg==
X-Received: by 2002:a05:600c:18a3:b0:431:54a1:360e with SMTP id 5b1f17b1804b1-4318765ec30mr61303785e9.32.1729802356345;
        Thu, 24 Oct 2024 13:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkGCUUvdJvSqTARdB16G/AY48VuxTJa4KcS/JJZ/KlNJl6x0Ao6X4+WMff36AFY6z3ZNZqw==
X-Received: by 2002:a05:600c:18a3:b0:431:54a1:360e with SMTP id 5b1f17b1804b1-4318765ec30mr61303575e9.32.1729802355783;
        Thu, 24 Oct 2024 13:39:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4f00:9949:9757:8f9a:e10? (p200300cbc7044f00994997578f9a0e10.dip0.t-ipconnect.de. [2003:cb:c704:4f00:9949:9757:8f9a:e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b7dsm12083108f8f.24.2024.10.24.13.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:39:15 -0700 (PDT)
Message-ID: <2c41be28-190f-4f3e-a808-2d6405a9e7b8@redhat.com>
Date: Thu, 24 Oct 2024 22:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.24 06:10, Hugh Dickins wrote:
> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
> 
> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> I gave bad advice, it looks plausible since that's a local on-stack
> list, but the fact is that it can race with a third party freeing or
> migrating the preceding folio (properly unqueueing it with refcount 0
> while holding split_queue_lock), thereby corrupting the list linkage.
> 
> The obvious answer would be to take split_queue_lock there: but it has
> a long history of contention, so I'm reluctant to add to that. Instead,
> make sure that there is always one safe (raised refcount) folio before,
> by delaying its folio_put().  (And of course I was wrong to suggest
> updating split_queue_len without the lock: leave that until the splice.)
> 
> And remove two over-eager partially_mapped checks, restoring those tests
> to how they were before: if uncharge_folio() or free_tail_page_prepare()
> finds _deferred_list non-empty, it's in trouble whether or not that folio
> is partially_mapped (and the flag was already cleared in the latter case).
> 
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---

Challenging problem and elegant fix!

Reviewed-by: David Hildenbrand <david@redhat.com>

At some point you have to tell me your secrets, how you are able to 
trigger all these hard-to-trigger problems (6.8 stuff and no reports on 
the list) :)

-- 
Cheers,

David / dhildenb


