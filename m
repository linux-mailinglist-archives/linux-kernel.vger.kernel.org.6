Return-Path: <linux-kernel+bounces-267133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66421940D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED42228206A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2D194121;
	Tue, 30 Jul 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SU94Izkp"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F21946B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330613; cv=none; b=P/u5cm/SwFovRfcMpDCekP1D53Dgz+XxobjwpGSfEJn6NXGa130i9rGBZUl9BDKdK772KnFnBnaj4O1qNo+pT6+hif+PgFQwQLVITP2WqbxZZrCzcHEj42jWU8dfssJgQ/FBFQkI+4nKFKnoK+iHY/HHKABhV80WbzKwLrgAKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330613; c=relaxed/simple;
	bh=Qmy6jOBAgGUO438SRI4dEoA0I03EgO90+KvaYpIjXEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+AIvimt3S+Yjuohtij4CyHsHC2cSJ7FeYyQT9DX0MFNw5dV1PP5u0fown3ehempsAGae3IvHo3ltEqK+jhjV8/AN8H80Hy4s18Ube46e/PLpwnJftZp/UQjMJQCv1yNifLtXjOsuckHBYimlD1Y+WH6WzI3lJqwIl+7NckQaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SU94Izkp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d22b6dab0so274317b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722330611; x=1722935411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSclq4pThTSCwT9YqJqbII2VQ5xJ9oUgsdFqEmgr39M=;
        b=SU94Izkp9M0Bfl/iywhT2xOJPn3p2CsBLJ59HgNcXwHLE6sdNGf1CJ0PQqtQl8D0wz
         v8D13crPxM9zpJ2m7NAd14IHofalQhcXrE8sMdn8wK86LcN+Bzzh2rk/+Vb2EWSJsWZl
         SPA70LWx00uDw9tgavl8/2x49dztxKIda9cZrKqpsQuj5/OWKGJf54gAslc/Oy4ktcI3
         +XrNW9uG7QOKxHtN88NOXGL22ltd7mytMYvSUK5f0/YCuqrQybVOlODrSHNyFyV3oVdj
         PZxW8vHUAdPOFstrMwwBrxGjJ4zEenOTreN1RYkxOtJtPwEvy1U+3URbg7vOwwzQ9Vjq
         jr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722330611; x=1722935411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSclq4pThTSCwT9YqJqbII2VQ5xJ9oUgsdFqEmgr39M=;
        b=W97eFE8QoQmxg1pFDkrCA2ylGL+siGnNhTXiPxkwT6HINdy/bcxn5KLVq4nYpPd5Oo
         pdw4SNpugnb64J9YiQy6KURB7y0aCKDUEDYoVaThwrgjI0L+X1cn+/McmdCGSebg16iY
         5FDglW9MrUVLqvhe5CVnPUcXCyUzjM0ZaMRNGBHgJOGt+a4+WkpdYQ0lsW2haGEH9SRS
         uc3+07P0EDDcQUY4WcJWzUST2wUYtTB1a1Iz9t70JQhKIMYPmZFpj+DECSwkoHavL1Du
         /+AXVXKf/mPDYlYd6GvSFWjqt21SJ8sYAytkM66M0hDUjCNtXauntOkQtyv+lIt82FMN
         zS7w==
X-Forwarded-Encrypted: i=1; AJvYcCUqDk8m//HEXZg9CEZjLoxRnyfgS9sPY104hYYg97g9LveM8oD8GPbFFDt85SaTGtRoThVpzgOconJ+P/sXFqRvqob7pTWBayOvDCv3
X-Gm-Message-State: AOJu0YyqDHogz9hBmYoCZXyd/D7xNBAxwS7SGeeTCO5M4JccQRax5mcQ
	bYvPSCvfKYzYxD6Ctwn0YFrzymlOecKqD6EPIOqWPNyuZzX2s4+xhuB5wa9qD5nw+o2+ftS8d63
	Z
X-Google-Smtp-Source: AGHT+IH44yi8Et9gv9K/PUkEjphadp45oqr8JhJ+BDFwdfghMnYs0seqPjSnpcyasrI9OPdJ+JNyBw==
X-Received: by 2002:a05:6a20:43a2:b0:1c3:b15b:f86b with SMTP id adf61e73a8af0-1c476f37bfcmr13171480637.0.1722330610947;
        Tue, 30 Jul 2024 02:10:10 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e83b2sm12043744a91.46.2024.07.30.02.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 02:10:10 -0700 (PDT)
Message-ID: <a3206cfe-34c4-4b43-9399-40a715f5fbaa@bytedance.com>
Date: Tue, 30 Jul 2024 17:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com> <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com> <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
 <12bae4c3-5dda-4798-9f6a-3ac040111551@bytedance.com>
 <47fe3480-a4a4-465b-8972-c6507c7a76ee@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <47fe3480-a4a4-465b-8972-c6507c7a76ee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/7/30 16:40, David Hildenbrand wrote:
>>> ... also because I still want to understand why the PTL of the PMD table
>>> is required at all. What if we lock it first and somebody else wants to
>>> lock it after us while we already ripped it out? Sure there must be some
>>> reason for the lock, I just don't understand it yet :/.
>>
>> For pmd lock, I think this is needed to clear the pmd entry
>> (pmdp_collapse_flush()). For pte lock, there should be the following two
>> reasons:
>>
> 
> Thanks for the details.
> 
> My current understanding correct that removing *empty* page tables is
> currently only possible if we can guarantee that nothing would try 
> modifying the
> page tables after we drop the PTE page table lock, but we would be happy 
> if someone
> would walk an empty page table while we remove it as long as the access 
> is read-only.
> 
> In retract_page_tables() I thought that would be guaranteed as we 
> prevent refaults
> from the page cache and exclude any uffd + anon handling using the big 
> hammer
> (if any could be active, disallow zapping the page table).
> 
> What I am still not quite getting is what happens if someone would grab 
> the PTE page
> table lock after we released it -- and how that really protects us here.
> 
> 
> I assume it's the
> 
> spin_lock(ptl);
> if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> ...
> 
> handling in __pte_offset_map_lock() that guarantees that.

Yes.

> 
> 
> That indeed means that pte_offset_map_nolock() requires similar checks 
> after
> obtaining the PTL (for the cases where we are not holding the PMD table 
> lock
> and can be sure that we are the one ripping out that table right now).

Yes, if the PTE page will be freed concurrently, then the pmd entry
needs to be rechecked after acquiring the PTL. So I made
pte_offset_map_nolock() return pmdval in my patch[1], and then we
can do the following:

start_pte = pte_offset_map_nolock(mm, pmd, &pmdval, addr, &ptl);
spin_lock(ptl)
if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
...


[1]. 
https://lore.kernel.org/lkml/7f5233f9f612c7f58abf218852fb1042d764940b.1719570849.git.zhengqi.arch@bytedance.com/

> 
> 
>> 1. release it after clearing pmd entry, then we can capture the changed
>>      pmd in pte_offset_map_lock() etc after holding this pte lock.
>>      (This is also what I did in my patchset)
> 
> Yes, I get it now.
> 
>>
>> 2. As mentioned in the comments, we may be concurrent with
>>      userfaultfd_ioctl(), but we do not hold the read lock of mmap (or
>>      read lock of vma), so the VM_UFFD_WP may be set. Therefore, we need
>>      to hold the pte lock to check whether a new pte entry has been
>>      inserted.
>>      (See commit[1] for more details)
> 
> 
> Yes, I see we tried to document that magic and it is still absolutely 
> confusing :)
> 
> But at least now it's clearer to me why retract_page_tables() uses 
> slightly different
> locking than collapse_pte_mapped_thp().
> 
> Maybe we should look into letting collapse_pte_mapped_thp() use a 
> similar approach as
> retract_page_tables() to at least make it more consistent. That topic is 
> also touched
> in a98460494b16.

Agree, more consistency is better.

Thanks,
Qi

> 

