Return-Path: <linux-kernel+bounces-306715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B340964272
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F94F1F279CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8D18D65D;
	Thu, 29 Aug 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N3hQbj4y"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402422097
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929171; cv=none; b=DIfpiiQk9i9NpsxToP0di9QjKpqoWAGltnA2Py1bAbANEY/r8UXg17D5mLiTycpkwOBa0AzN06UbLMt7zTUaSN3EzymKTBWya0M1aG/EGSWAEGXuRrxU/W/zwjpusQwz5nR1mqA6NmJcE/Nk0OlNUbOMGSmmYCmmhABNFttmOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929171; c=relaxed/simple;
	bh=pM8MlOwBVDeyA2pELZikv9WoKwga8Ga2A8XpAqnMHKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiiP45xeRTNtK0WWG6ED7aYrTT1RVv1cXettdxd2czRg2whlrc1wDL98kTOIXhwdBTrBh3KEM82QuZPyc0kx5zrsgYeqDKxEDkBvmLEr9tBNQvD8C77cf7C7fqPpVDKnJ1n2EGnVNfO4sPKtFfkqpxHhj0GO0p4kaZk+RyK+Bhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N3hQbj4y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso447109b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724929169; x=1725533969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkCs8X+rOG2k0a+0P5TyFf8pKHMHEP/2u//VabkdfQg=;
        b=N3hQbj4yGRxGmtAfX2ZLss8j76AVmshPccQPp9G4MzIXFYl0Vw0rJ01SG1MOmGtQra
         ZLYYGjyeTwQptDnA/b2eN2eVq25BucoKKNktJkTCqxEnvjEK2HRb9OyjZKbICqwIUZMc
         FbEPENA/nJ9SY7pGgn/oLV9RL4+CWCgBS5C1+YIDt1/60LfalRIEX7bg2vhxpGZdHdvz
         lQJo7agQeSBKE44IY9tsjzsfBUyCO2vXQWYjmdithJLpFO1jylH/Q0mt2KLuuv9IN//D
         eUnZJCgHCLETZLBrCThHVJLKQihiqiKuCEOzVdE/toxX585LtYEGCrc/o6hwBG1hj5L+
         342A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929169; x=1725533969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkCs8X+rOG2k0a+0P5TyFf8pKHMHEP/2u//VabkdfQg=;
        b=lVR/gobp6F7ZPZwVZ4ads2s3Oi9HX/v8LBBr3TwgLgEfi4OfSoXzD4VK7neskFs0DQ
         YyOezWgMcC6nUJs6mvO9npta/So7PzZFVRry7U1Rlv3/Pjx3Rax8iOOj3LRqgOnMMe7Y
         FQJRxnOS/OUggOkaY0yUNCNgHmTRT2E//IsopyR1uSWHQ43z1NnnSYS2+eu2ynxz+mDz
         +olPab/vcbf8jHDk0mjT8+UYlhHm83/e5oTj9qSAjiAo/RtD6z3nlLub2IPAFAXwUIHI
         WNjtzPPnJ1lxqnXt67NlMaqi90Djk3YYXbauQZRX6+X8pjVYu+w1KguG8dXGfeOOsXEV
         +6mw==
X-Forwarded-Encrypted: i=1; AJvYcCXm2oSL9XYjl6dRQa9dpGI5g+XmpwsMIFrepaX9eKxz5kceUvkxmwpC+q/PvVp8OPcYVbXTJC6k4vAU0QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePzz+Su/zDYgwU+x7b6RElp4cxGBWV1zf2/6nCrseMueDv0b7
	A3WwgEIYZ1e4K5/JVjMKoFrdgowoQbJBcBzMk9BT5k4mSTGNMuayZwpymXo+5ac=
X-Google-Smtp-Source: AGHT+IHFavp3iD65n8I4MxM7X0z+O7YmVJGdY6pd4itbZCENaYUbQg/MTJWkKQgP47jm0Y5MTqQ9gg==
X-Received: by 2002:a05:6a20:6f08:b0:1c6:ae03:6607 with SMTP id adf61e73a8af0-1cce0feac29mr2109334637.6.1724929169241;
        Thu, 29 Aug 2024 03:59:29 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e57629f4sm881857b3a.205.2024.08.29.03.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:59:28 -0700 (PDT)
Message-ID: <63ef0611-50c2-49b5-ba3f-c6ea81f9fbce@bytedance.com>
Date: Thu, 29 Aug 2024 18:59:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, muchun.song@linux.dev
Cc: hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
 <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
 <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
 <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/28 18:48, David Hildenbrand wrote:
> On 27.08.24 06:33, Qi Zheng wrote:

[...]

>> sufficient AFAIUK.
> 
> Drop the "AFAIUK" :)
> 
> "For R/O access this is sufficient."
> 
>>
>> pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
>> pte_offset_map_ro_nolock(); but when successful, it also outputs the
>> pdmval. For R/W access, the callers can not accept that the page table
>> it sees has been unmapped and is about to get freed. The pmdval can help
>> callers to recheck pmd_same() to identify this case once the spinlock is
>> taken. For some cases where exclusivity is already guaranteed, such as
>> holding the write lock of mmap_lock, or in cases where checking is
>> sufficient, such as a !pte_none() pte will be rechecked after the
>> spinlock is taken, there is no need to recheck pdmval.
> 
> Right, using pte_same() one can achieve a similar result, assuming that 
> the freed page table gets all ptes set to pte_none().
> 
> page_table_check_pte_clear_range() before pte_free_defer() in 
> retract_page_tables/collapse_pte_mapped_thp() sanity checks that I think.

Since commit 1d65b771bc08, retract_page_tables() only holds the
i_mmap_lock_read(mapping) but not mmap_lock, so it seems that
holding the write lock of mmap_lock cannot guarantee the stability
of the PTE page.

IIUC, I will also perform a pmd_same() check on the case where the
write lock of mmap_lock is held in v3. Or do I miss something?

> 
> In collapse_huge_page() that is not the case. But here, we also 
> currently grab all heavily locks, to prevent any concurrent page table 
> walker.
> 
>>
>> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
>> will be RO/RW protected.
> 
> 
> Good. Please also incorporate the feedback from Muchun.
> 

