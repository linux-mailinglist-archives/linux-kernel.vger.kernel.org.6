Return-Path: <linux-kernel+bounces-266941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7D940A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD88B21B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528C18FDB5;
	Tue, 30 Jul 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6gaTFJr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21BA1684AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325339; cv=none; b=OPhqJHAx5FCN5jpkb3spvYQUsquqwNq719Y4BRMIlvxYubShySaJ1kCHgeeIrEcNJXBec23kqP+kerHcutiDvcZvfRA30XjJLbzWycA8ZO+NOx/2lq/Q1S8CK+UUOZfdByqmwtOk608qwkGnsl7jhfMecdA0pR49D6jLX8BOdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325339; c=relaxed/simple;
	bh=SKvT7WNqfBGV1+rqDNJxmX69AIyqtZq0zLAu/BFrwWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZgUUkNQtyo16qbf45Yq8fDzvkSxS4DIMR77KMM0mmgQDHbNL4jXzKlxLOtRn2KM4KYPOHD8uSGFVLObrULOulspBzQ1oL6hzgBxSlpNfOCBazWOIMdtXvSa9qYuFPWYCHquR/oZ+Ls3oZ+mfmMakD6I1GdthE2LsXZiFi7VO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6gaTFJr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722325336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8RveV1uJTCfZnT37PuWrWtx5mKe8dhsCwpmqzn6Z14=;
	b=e6gaTFJrtwYm2sol6lA6NiKiVJrb8GaV/GLNJV1c3gg/rOb0RKbG/js4mx0U1/gjK3HR5E
	yd6IXOgNU6jOUi07w3Q6OEBbolB8cykED+ZPurmr3RH9zq7ukr4jUusDj+ACrA8y72U0kc
	gvZQTKEkAV5b2SEcq2U5Psi2nvsijFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-hj_gsc9iPT6DI72C8YDvqQ-1; Tue, 30 Jul 2024 03:42:14 -0400
X-MC-Unique: hj_gsc9iPT6DI72C8YDvqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36835f6ebdcso2574253f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325333; x=1722930133;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S8RveV1uJTCfZnT37PuWrWtx5mKe8dhsCwpmqzn6Z14=;
        b=NYq2quQnedOT5gOQ/PgXtTZR0Oqn0myQitJGSiyAe7VUbIVDJ1bABvbOjUWX9DG05A
         YnVbb5Br3cVrRKc+3QG15l6Htz1obNQkO6msmSr8Rwat4/OPQfVKlO7SnibygBMHoVEK
         mV6WlaQArXu7l3PPhjVt3YEaoE8afvT7VYHmr31nw5wvYuYXX2/1JLHf6G5UW1HOxV3m
         1cPscmjzqS74FaCWLAx9+btbqwBnIlI91tVqRYdcXkJJw3wzipb/Y9hBkqWbDVCrDIq6
         JHG45uxkyTs/2sUztlmOTU8GkrV11Bh7Gadiyk8HCJnMIbn0dubvJf6GptHCsllDJTkD
         PHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5gYnsi+OJLOCtH/ALiINCw2/+d1yq4ZajTKbr6/Pf8xJ3+A2Jm6WU/mfRo4IdXghhAkeaJs2v25wwh4ECtH2IWHjhh3side8b+fqU
X-Gm-Message-State: AOJu0YyMz7rwPvER2R203w5K1V4DxZT2pYzmv4j4GGQIHGY01VXbVENI
	Z7ZGC9dGN4WSPqIKv+z0DASPabGQtwZfg7h2Xb7+asHPQXqlmORSj4j6E5aPz5ZJKkIA6DAFhoZ
	KV1JR0PvQ7Gy/nu3GlzJKzZrdrL0C8Sm08B4gqO4y2KxOnMS0fOwe3NmN5xC7fQ==
X-Received: by 2002:a05:6000:1861:b0:368:3789:1b6 with SMTP id ffacd0b85a97d-36b5d073e6emr7399918f8f.47.1722325333143;
        Tue, 30 Jul 2024 00:42:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzDMPvQGrehooTlu8wRs1y4lwfZQWrVLYOvYzs+Hb5azjF/CxsHsDslP58+1IgunNhRbuTiQ==
X-Received: by 2002:a05:6000:1861:b0:368:3789:1b6 with SMTP id ffacd0b85a97d-36b5d073e6emr7399892f8f.47.1722325332633;
        Tue, 30 Jul 2024 00:42:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c093bsm14160573f8f.18.2024.07.30.00.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 00:42:12 -0700 (PDT)
Message-ID: <f7524eeb-7e94-48aa-a3f6-543ba6a8a5b6@redhat.com>
Date: Tue, 30 Jul 2024 09:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hannes@cmpxchg.org,
 hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com
References: <20240730071339.107447-1-21cnbao@gmail.com>
 <20240730071339.107447-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240730071339.107447-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 09:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Right now, swapcache_prepare() and swapcache_clear() supports one entry
> only, to support large folios, we need to handle multiple swap entries.
> 
> To optimize stack usage, we iterate twice in __swap_duplicate(): the
> first time to verify that all entries are valid, and the second time
> to apply the modifications to the entries.
> 
> Currently, we're using nr=1 for the existing users.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


