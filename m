Return-Path: <linux-kernel+bounces-206895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23122900F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989EF2839C3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8DDDDA;
	Sat,  8 Jun 2024 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP4gR9F/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856654C65
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717819723; cv=none; b=pVBFAP6snpGnENlOaAcY0Umb7UC0MEe+S+G/XEfBgxwfcrwV4NZsMK1YlKDSi1uMvPeS/54RSQKd+BIbj9XdzuJ+7ycKwM2ocgRMP8PH4zbGHp9ParWzPSE9dD03NwBk6Hgw5czyaMN6Hk5hwDEEu9uM0sImds4dILqdo2nYyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717819723; c=relaxed/simple;
	bh=rhdyfV0lj9KExec2QDEAF5SwzBkbHNhhbde9hVK9i5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poGSoOf4UO2tXX7I5ZwrWA4GlvD/CMHqzsoRAnmjwCt5lEs1wjAqC1Hv0L+ZM1l7w/hhRRZNYhk6ENw34F4eFDpZrzQTHvfpIMCReYVTG5aHNvCxIl5HBe9hPbzfk1a8RyxLGBmipRCY1JIpbzCxbakDcyvxkEVVqD0FX4vCqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP4gR9F/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717819720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTizEaaqhSpnwMjwXtrrvGrCeV6DhFjXTqgmOLq3eUA=;
	b=MP4gR9F/oNYgrOXuU9jgd8Uy/OaXTKGrpFlRr1Z+ZOETrQVIZtkucco51BUs5ffy2ASBWE
	rfdKEvydhYQz7X0R90yJDHNzZgyM0CzAvkjnSW46qb2laY8weU9hMlfMRLKUUjAOVDOIqN
	t3ZT2kvvWaTgwEIzVaJvR2K8R6uVilI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-hWOn0VnOP_qe4KrWtQM5Rg-1; Sat, 08 Jun 2024 00:08:38 -0400
X-MC-Unique: hWOn0VnOP_qe4KrWtQM5Rg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c7fca52f8so62596e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 21:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717819717; x=1718424517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTizEaaqhSpnwMjwXtrrvGrCeV6DhFjXTqgmOLq3eUA=;
        b=OA1Sl7OsAQ/8UdJREMwS14ZJzPA43IzHJkPiDwNKr6u8kVw9B4HdwUKrq9J04RN9uM
         H4zb42Jv1iCCK9PK30k3y3Wuyp6T7te5g6Sho+TJpA1LiUlNjZHMHxXgHcj+rx7lz66n
         uad0QFCk+SkYiqDl3U0juGPft5WOZJmEF6x3V5Gs9gxTBsQ3TI5naa25parXue2Ouolj
         wU6NQKApPNOMUwg1OP97O5kpB3yG/XP17zGPmDL10shkCucp3Vz2KYxz98rUS2mq+USf
         zusphwUQXwVKbu2Nc+ifwDwRFUnwtkhTypHkqLIwb43/EAs/I/YUtI6Qp/uDI7CIGibx
         bbIg==
X-Forwarded-Encrypted: i=1; AJvYcCUdu1zECocD2PqBcz85NsTL41a9A9Nkr9t3ugy5RYWTvDkoQyzWZU6ri6wA97ZlZsx8XqgeKfugD8n0nkGg5NBarE/QboQZ3HoStHn5
X-Gm-Message-State: AOJu0YwYKOdgm0+Xq5wjHxb+zKTbjAGLU4+gjmr8Qa1G1hdNF1yVrV0L
	k4ipfviEhMGiUHSuoshAWV9hTygK52qR5HQiIiUxrr2PmbTkH7Cgi99pGr0ditB1cWlvdv8u1eO
	a6G/ZWWp6Mpcqo+vfgr2yOx3jmHA6+Oomp3eUVyomafmcmflu45jkksErRg3F
X-Received: by 2002:ac2:5042:0:b0:52b:c140:5d5 with SMTP id 2adb3069b0e04-52bc1400742mr777369e87.2.1717819717330;
        Fri, 07 Jun 2024 21:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFN5pkegTgaO4mm1YT1IXKdAFuULGC+9wRXdHWSA1Ql/+m5SjGH+cIPu1UQIm6nkKulEcOYw==
X-Received: by 2002:ac2:5042:0:b0:52b:c140:5d5 with SMTP id 2adb3069b0e04-52bc1400742mr777352e87.2.1717819716843;
        Fri, 07 Jun 2024 21:08:36 -0700 (PDT)
Received: from [192.168.1.86] (85-23-17-83.bb.dnainternet.fi. [85.23.17.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41dd2e2sm6969941fa.133.2024.06.07.21.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 21:08:36 -0700 (PDT)
Message-ID: <2821278f-bc94-c147-d0fe-8cc52dbdccb1@redhat.com>
Date: Sat, 8 Jun 2024 07:08:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large
 folios
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240608023654.3513385-1-yosryahmed@google.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20240608023654.3513385-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/24 05:36, Yosry Ahmed wrote:
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9be..ebb878d3e7865 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  
> +	/*
> +	 * Large folios should not be swapped in while zswap is being used, as
> +	 * they are not properly handled. Zswap does not properly load large
> +	 * folios, and a large folio may only be partially in zswap.
> +	 *
> +	 * If any of the subpages are in zswap, reading from disk would result
> +	 * in data corruption, so return true without marking the folio uptodate
> +	 * so that an IO error is emitted (e.g. do_swap_page() will sigfault).
> +	 *
> +	 * Otherwise, return false and read the folio from disk.
> +	 */
> +	if (folio_test_large(folio)) {
> +		if (xa_find(tree, &offset,
> +			    offset + folio_nr_pages(folio) - 1, XA_PRESENT)) {
> +			WARN_ON_ONCE(1);
> +			return true;
> +		}

How does that work? Should it be xa_find_after() to not always find
current entry?

And does it still mean those subsequent entries map to same folio?


--Mika



