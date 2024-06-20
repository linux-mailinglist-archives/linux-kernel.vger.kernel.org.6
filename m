Return-Path: <linux-kernel+bounces-222119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C271290FD19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6BAB24375
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079E4084C;
	Thu, 20 Jun 2024 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvRjX2im"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE943FB2C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866385; cv=none; b=WN+yjiUZE18yZqDdHRv35msH6CFILB11jpiEY5n16kK54RWIDB79FoGVrvU530HBi+ZNYr1EBTP+Vg3tPjzFXI0J14h/LfypYQOMl1j7C7D+EUwjAC49qZXJ7/3/uFiWleoj79sj+JqLlNHtmxQcW4YBGjHgDDq+nVxlWcZgcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866385; c=relaxed/simple;
	bh=UodZb/6+ceT6GHseBwkHdIiMfVQW4wYCosGYLEuvrxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KK/5UBmXl0NzjjYxzj66q7VfaIuHBaa2rGASHVAPZTcyIICoRWU5iKqT45Afcf8XCAR164Hi3egAqb/cVrZ5VeJuT+ZQ5mZ9Ycx3tVR0cCFa2DoxhCTsPJ/sivP6AilhZzXP5jSEtwtuTm/V6Y9MNjN2wzFcD/41krkOziqT2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvRjX2im; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718866382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8q9uyGXxD8RxqMATN/X7eohxJuILH6WNN4PzPgsy+tw=;
	b=bvRjX2imL8SSxjwmhVAWojLEudsSgSmUlB1nuvenYM2FkSNWUnWbmHSgyI/UzzfI5Am4+J
	pkMOnFaVDlEvzLu7UlO3oLVpxgGnDw+tOiGmMGTO3qUNV3IdLam0Wd5giiy60QJt553sfc
	pQpuGJHy7kuS4GAOMJ9Daa4UiZkffCk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-7YAM6IHCPJW4mN4CnpDDCw-1; Thu, 20 Jun 2024 02:53:00 -0400
X-MC-Unique: 7YAM6IHCPJW4mN4CnpDDCw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c6f37cc97so348753e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718866379; x=1719471179;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8q9uyGXxD8RxqMATN/X7eohxJuILH6WNN4PzPgsy+tw=;
        b=BcU8X5Za5/Yi/KmyC17QXUq/zyJDKT6VEmkYOBnGPtOyCq7tFgn8ANiALp3aJtcRL+
         FK03ZVv8SmmAz8VLAtf1JL3S9aO7kWxhioTjWbAjGWkp5oNIdCNCi57KaUyl+WzgNEr6
         v00Wnqkw8jHJ8nd9ro8Vy2FlWCo4mUq2KiYq6mZDzJLNtwAb/ode6E+BOxaVJaGuX/tT
         VSJG5vXuRiOAWtfNo7lIIAf/ycjb2tdjanDcMo3Lc23okGlc3K7CzgYTV1GN2V+YdQJg
         QCB4RbbrIQIZY8zACUk0s1JafhlQqaOzZ4NmrQoKydEOBiibJ2Yzrm6Si8DhI1VtDSq5
         XbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRwjw9VPywrBsQ7U0KacYhTwtN67KVZ14C9Cuow//C7EjTk+ndHt900pWxD0V1HZHPIEsIUpUffUGm6QoNAbiAs4gM9K6M6OaZe6gq
X-Gm-Message-State: AOJu0Yyx/Zaw8CtMYaMV/7Ucs0/o5jElwgmzbs0Dtfw1LQdezF1Xu/mq
	Ws4Xsi2KfkZ6etivA5oXci2pqwfo1VH3wpEy2C4VaVYi7V1svw0I0TwdbNkDOsQM35EUfDQ/NVT
	xIW4zoNoXBBBlL+7gJmNgNqHtwSki0c0cjZvTFdZUBDKIyenBxMJbamY4sfxVzg==
X-Received: by 2002:a05:6512:1182:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52ccaa2d4a3mr2297120e87.13.1718866379199;
        Wed, 19 Jun 2024 23:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ7bg4GQyDxFHVg0JAoQPEBvO7tbQldLgkKbePsQ8RVxPEajwa50ZWo49ZPR72dwWHf2PniQ==
X-Received: by 2002:a05:6512:1182:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52ccaa2d4a3mr2297098e87.13.1718866378748;
        Wed, 19 Jun 2024 23:52:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54besm14060185e9.25.2024.06.19.23.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:52:58 -0700 (PDT)
Message-ID: <2a358ff4-4219-4262-9225-d9aab14445f6@redhat.com>
Date: Thu, 20 Jun 2024 08:52:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
To: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
 <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
 <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> (I do have doubts about Barry's: the "_new" in folio_add_new_anon_rmap()
> was all about optimizing a known-exclusive case, so it surprises me
> to see it being extended to non-exclusive; and I worry over how its
> atomic_set(&page->_mapcount, 0)s can be safe when non-exclusive (but
> I've never caught up with David's exclusive changes, I'm out of date).

We discussed that a while ago: if we wouldn't be holding the folio lock 
in the "folio == swapcache" at that point (which we do for both 
do_swap_page() and unuse_pte()) things would already be pretty broken.

That's I added a while ago:

if (unlikely(!folio_test_anon(folio))) {
	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
	/*
	 * For a PTE-mapped large folio, we only know that the single
	 * PTE is exclusive. Further, __folio_set_anon() might not get
	 * folio->index right when not given the address of the head
	 * page.
	 */
	...

We should probably move that VM_WARN_ON_FOLIO() to 
folio_add_new_anon_rmap() and document that it's required in the 
non-exclusive case.

> 
> But even if those are wrong, I'd expect them to tend towards a mapped
> page becoming unreclaimable, then "Bad page map" when munmapped,
> not to any of the double-free symptoms I've actually seen.)

What's the first known-good commit?

-- 
Cheers,

David / dhildenb


