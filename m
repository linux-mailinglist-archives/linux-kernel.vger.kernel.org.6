Return-Path: <linux-kernel+bounces-191951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A88D1683
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C74D1C2208A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA313D255;
	Tue, 28 May 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXfc3oeE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14513C82D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885723; cv=none; b=tI256crqPCoXR5YN8SE7WLky/Z+SGC1HA0SXJZgfrdyExNeDHJYKd6sSQ5rrX8Nq3X9U0ZgEwhk2Ri8P5y96jKclSZeWzjp7NR5LFZXcGmfqmxDNGtSX/G4Y2N9HT0n14fYdieyFIqCy4eKfYoee6Or1Vq/BEm6x84WiIOt51Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885723; c=relaxed/simple;
	bh=Si8uOwB+SR615T9o2vhzkyA4Se0BdaVJkkhBGHvnBRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5ZsANmQs/5QDi+3D9AioqtE7Wd+aXPt4eTsIOJN0Is8TSV+soaT6oOcPnJSwHHD0M/mfI1lsISkghx6UcRZWsWOG6kUkt21+7xIX9wIvPwI/ug2iIhORP2dgKj8EYD5GRD8G9QnMCC62svy1VApnmnzorUy43TULEUwM86XfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXfc3oeE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716885720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUUEi4NFq5/6ujzPIEhzepE5FYBnLSr5RCh2O1Q//wA=;
	b=XXfc3oeE9vJBnCrzzs3o8ECHrlP6DvqNEPEa8fp7vDD/K+SawM8GmmOsos2HAvRVLzJa+S
	DaP/k19+ImFRHXHmwwo8TRsE8QTxR3A3ieJPEfSxC26muzsB/vUNcYaYI0nALlIlO/JFDv
	MA3T+yNcyq+7vA5d8vNWrFkBmAwzFH0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-gWfmZXKdPqmlEjxtqB4FiQ-1; Tue, 28 May 2024 04:41:58 -0400
X-MC-Unique: gWfmZXKdPqmlEjxtqB4FiQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6265d3cb78so41804166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716885717; x=1717490517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUUEi4NFq5/6ujzPIEhzepE5FYBnLSr5RCh2O1Q//wA=;
        b=KauvZgaRJDhIuO9RvfDACQY50McooKYx1g2fbVKTdahNqI+SK84Jgu52gNLxm5UQ5Q
         znw7DMmBM+02pfNOBIFJLI6s0h+vHlPS2XLUIxCoOHKrVwRazM+pndmdknmNvy4NxoPh
         tlhcJim/IOr2dS5sMJU3fJDfDY141XSlc5V4IwVpmUfpdhC9BGr3NnbHZDb3l7OdPzLp
         G47H5KRQnABdV+JvKX5cXZXYNvbt+QtBqmwzHqkRMKjPTg5fYMVotXZif0pn4jlUp6yk
         7dmrne5F1wFq58675N4jC5I99N4B2A6h3kLU6z1J0t+/lQY64g3991ekZWAz7BahetVu
         3Xvw==
X-Forwarded-Encrypted: i=1; AJvYcCVuXxa2bxjBPGl3P0wwBXUTZsjr5kBmVjbDoOFz1KsxscVwMpAsz8Iz5w8XZNSjNjOu6Tm9LPzVX+E0a04To1F4KdNFMimwdHyeGqXa
X-Gm-Message-State: AOJu0YxrgrzW00lf0Yr8TkcU/ilc/iKQEJRRzgclzZZmnJWLBHdXWex4
	U1Z6JXj8i5yc9UR9sloA/C+cx1dwCjwM50O0Ie3Sx+OAsTARk/6g/OPUoJAPhDwT5+bsk15Je3y
	EWkxflxSMO3U/++bti3EDnb1qluq0wvOgg4Y9ReTQveNjQ1O2ULcVnm157lyF2w==
X-Received: by 2002:a17:906:d8d2:b0:a62:c02:425a with SMTP id a640c23a62f3a-a626525d448mr817030966b.74.1716885717519;
        Tue, 28 May 2024 01:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdFD9ql2/8w9cDbZsgKBm+WaL/wEXxkf8Jsu4WI1Wl5SGpzVoidZnRLsUUlVlZlyCzn7wrOA==
X-Received: by 2002:a17:906:d8d2:b0:a62:c02:425a with SMTP id a640c23a62f3a-a626525d448mr817028266b.74.1716885717007;
        Tue, 28 May 2024 01:41:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c860sm586492066b.168.2024.05.28.01.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 01:41:56 -0700 (PDT)
Message-ID: <07686f06-f1a8-4282-bb48-fc4a5b554552@redhat.com>
Date: Tue, 28 May 2024 10:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers over
 90%
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, ying.huang@intel.com,
 vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
 willy@infradead.org, peterz@infradead.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
References: <20240510065206.76078-1-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.05.24 um 08:51 schrieb Byungchul Park:
> Hi everyone,
> 
> While I'm working with a tiered memory system e.g. CXL memory, I have
> been facing migration overhead esp. tlb shootdown on promotion or
> demotion between different tiers.  Yeah..  most tlb shootdowns on
> migration through hinting fault can be avoided thanks to Huang Ying's
> work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> is inaccessible").  See the following link for more information:
> 
> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> 
> However, it's only for migration through hinting fault.  I thought it'd
> be much better if we have a general mechanism to reduce all the tlb
> numbers that we can apply to any unmap code, that we normally believe
> tlb flush should be followed.
> 
> I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
> until folios that have been unmapped and freed, eventually get allocated
> again.  It's safe for folios that had been mapped read-only and were
> unmapped, since the contents of the folios don't change while staying in
> pcp or buddy so we can still read the data through the stale tlb entries.
> 
> tlb flush can be defered when folios get unmapped as long as it
> guarantees to perform tlb flush needed, before the folios actually
> become used, of course, only if all the corresponding ptes don't have
> write permission.  Otherwise, the system will get messed up.
> 
> To achieve that:
> 
>     1. For the folios that map only to non-writable tlb entries, prevent
>        tlb flush during unmapping but perform it just before the folios
>        actually become used, out of buddy or pcp.

Trying to understand the impact: Effectively, a CPU could still read data from a 
page that has already been freed, until that page gets reallocated again.

The important part I can see is

1) PCP/buddy must not change page content (e.g., poison, init_on_free), 
otherwise an app might read wrong content.

2) If we mess up the flush-before-realloc, an app might observe data written by 
whoever allocated the page.

3) We must reliably detect+handle any read-only PTEs for which we didn't flush 
the TLB yet, otherwise an app could see its memory writes getting lost. I recall 
that at least uffd-wp might defer TLB flushes (see comment in do_wp_page()). Not 
sure about other pte_wrprotect() callers that flush the TLB after processing 
multiple page tables, whereby rmap code might succeed in unmapping a page before 
the TLB flush happened.

Any other possible issues you stumbled over that are worth mentioning?

-- 
Thanks,

David / dhildenb


