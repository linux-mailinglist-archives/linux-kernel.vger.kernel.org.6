Return-Path: <linux-kernel+bounces-276200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A557948FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7DB1C221A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC61C5785;
	Tue,  6 Aug 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqKbUsiO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51F1BF311
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949328; cv=none; b=tqskRBrvTk6M0tzT7DuSPYJJX915rHewB/bbRhm1pyc3rbY14W3E4Qbu4phW8OlmlV2KWsWMrWcOLdnDk6LlZ+VEtBkcSNU+SUGOLXBUb3KNEsBBm6bsdE5vRdiGW8jMksXVcljzQaCLr7gz0Cb7ljWbtN1DsCz9ohlff2BxYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949328; c=relaxed/simple;
	bh=0IFhwUzKw1+XIVn2krwoHTO54VDP4V4ipVQKuqt24Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryvaVMr6myLnCd6ymvrseYC0kSv9Kfm1/lRdd60N2HUcmN8HCoL8nwFPQqo8DzLOn8QNq+R4Mx/UInxmoMjsb3bmK2BhQNkGMsyrJoKULKOc9iyDeks+McZ+v956IoXAQScct4nYKIZJrVyJxCNBwQCOhGJyWpoHkqtnYalx65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqKbUsiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722949326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8bydtEU8dpvIeQ2V0I0gbNTbGq+ZFreMIhNnwB6nrP8=;
	b=fqKbUsiOG0UsT9avSyTEBG1SwvG606UUKcyCmZUeKtPynfnE0z19MquAN0fi3024o7HhkK
	tSzw5222DQ4hbmRDZKqOtyAOE/9Iy6qXv4ZDF3ZQ+zFV9D5plzVOqbnyizbNE1/Y59aLlt
	yJ9LTJFtia9H+3R/BH+CEmfuLFVwFA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-mz1VzXVeNsWtyU0YcFe5ew-1; Tue, 06 Aug 2024 09:02:04 -0400
X-MC-Unique: mz1VzXVeNsWtyU0YcFe5ew-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816096cb8so7329845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949323; x=1723554123;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bydtEU8dpvIeQ2V0I0gbNTbGq+ZFreMIhNnwB6nrP8=;
        b=Ve5QHX0N104yJrvnhuYn7X+zLYSdi47Ne7gpTVJNhveXQkT1P5CiAJxlA6MElgRw5y
         Fq/l3luM+lI69XPWhBQvtRGfcvXQQUKT7CTN4fd9ZlPmb8AIohJNf/rNMuw6qe/f44po
         RHXYQSqkQlm3sWKlQKC0Y84td550EVm3JcEbZgZDX/bxhVmWcrq2Ks3BTUatR5FFaDWh
         VqrEIWqNg79WpI134FtjlvY75UDRxXmo5OVulKWhdpKvZL2PM7L4d+3nr3MwBReCA8D2
         DuaRP2ss870IjyvLqYpdB/LuKm8OJk5Z0o0EW4+chTceBSRfRt6SRVh0Svb/8MjmtC8A
         uoSg==
X-Forwarded-Encrypted: i=1; AJvYcCVb3uG/Hx/W3QNoTTy9D7N3XeqfeOHmsRiQWmkhWBK+AGqEilKJksCkuK9B4031+1T+wbX/Q7bFhEaXKwsUXkl4496Oib56LzIClGEG
X-Gm-Message-State: AOJu0YxD9XkAHv9Q9oOMUKpwJymNBpP2kAZX7eOF1vRqjEI5TwSKF3hQ
	gppUk3zQA1lw6xb8RmCdLAkWAQcuHM9IrpmbQHF99uj2bv7MaApt+ZhIROoLMjGqiKTs53rTeRH
	JOab2gj2uAGgsjta2GrhwWIyTYLYfRGtUkmP1MG25AArIJt/UR7XLiZWlsguXcQ==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428e6b0274emr120097365e9.11.1722949323372;
        Tue, 06 Aug 2024 06:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRwjjANscg8+b9Kv9y6U+t1I48VOP6ZN/WR8pMZTv9tWk4uh7ippB+DqqreWBWrJFzurQ+lQ==
X-Received: by 2002:a05:600c:4752:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428e6b0274emr120096965e9.11.1722949322849;
        Tue, 06 Aug 2024 06:02:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d1fcsm178027965e9.42.2024.08.06.06.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:02:02 -0700 (PDT)
Message-ID: <054324a3-bc77-426f-a751-06700aad394e@redhat.com>
Date: Tue, 6 Aug 2024 15:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Oscar Salvador <osalvador@suse.de>, Mel Gorman
 <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huang Ying <ying.huang@intel.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Hugh Dickins <hughd@google.com>, x86@kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Alex Thorlton <athorlton@sgi.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-3-peterx@redhat.com>
 <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com> <Zq-Y3qs5_PZW04bt@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zq-Y3qs5_PZW04bt@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Right.
> 
> I don't have a reason to change numa_pte_updates semantics yet so far, but
> here there's the problem where numa_huge_pte_updates can be ambiguous when
> there is even PUD involved.
> 
> In general, I don't know how I should treat this counter in PUD path even
> if NUMA isn't involved in dax yet; it can be soon involved if we move on
> with using this same path for hugetlb, or when 1G thp can be possible (with
> Yu Zhao's TAO?).

We shouldn't bother about it in the PUD path at all I think. Especially 
as long as NUMA hinting doesn't apply to any of what we would handle on 
the PUD path :)

> 
> One other thing I can do is I drop this patch, ignore NUMA_HUGE_PTE_UPDATES
> in PUD dax processing for now.  It'll work for this series, but it'll still
> be a problem later.  I figured maybe we should simply drop it from now.

It probably shouldn't block your other fixes and we should likely 
discuss that separately.

I agree that we should look into dropping that PMD counter completely.

-- 
Cheers,

David / dhildenb


