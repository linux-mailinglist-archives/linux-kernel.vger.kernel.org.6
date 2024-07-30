Return-Path: <linux-kernel+bounces-267060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFA940BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C4E28702E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEEA193087;
	Tue, 30 Jul 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePL6XFMJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9107156C4B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328810; cv=none; b=c/OS6bjbfxtl1R0xMoMYtRQ9K0H9S4Z5skYTVHwqg7YW1TaMcotDCvTf94GbMlMm2ZXyUumbeMmpGpS8xx1OvrKknzBkmz8zxaJkadQksbHZl/tyh2WB+Hfug2tZuS+AGUhhJDx2B6RzOnOfHgGHPIZ1MmfIfMPEwWT2l/c4wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328810; c=relaxed/simple;
	bh=NGZTfcDIkt504PlnPC9GVq42FjdsjEOxS77ZG3YvA2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oog1fG0mTY7+mM6ZKHWn/VLHG/IHrbyg9XTl3Ex23iKOVkLcLJKb4lACFKSecFj6r84sJAHeEWAsjV3MY+XvzFZWncCZLYK72nBoy82o6uKjX2Zh8l2oGOulgLv22uXlhzz79tynzCOJLs+Qvfd1qayzXdRm47kXf1B1V6ScPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePL6XFMJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722328807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fK4x0arZ+5YauyehRPI0eZhno5tLBSj2Ghx8XLr1ySg=;
	b=ePL6XFMJ+kxVM6Qndl1WiXDqSvCeBjIW6NSp+esURjanl0NWgOPk8JeYUtpjcLT9lFbymG
	bdp64raNudNQPd7iDuS6HkUSfrTLNqYjtoVE2PcdQlprtYVlSDI2jkkuaRm0/7ao8ZSG7/
	+OUt9FpdqAJhf5LprRcIOC59eHoop/A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-6BhzLykUN0eYnQtFKy22Lw-1; Tue, 30 Jul 2024 04:40:05 -0400
X-MC-Unique: 6BhzLykUN0eYnQtFKy22Lw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280b4a34c8so25442405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328804; x=1722933604;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fK4x0arZ+5YauyehRPI0eZhno5tLBSj2Ghx8XLr1ySg=;
        b=gCVapwAjrTkywfawz8vO+RdGdAVxSt1CbzzNMQjGRiPXQbjLWAV65E6LUaQt8seRIG
         v1lZPF+lyM5pmeWP4KMO1yqh55yavP2PK+d6cKOUEPlqrVVoOMamaXOQe/vKoo7GE6Ym
         YqaMPefV+FRWRnRNqbJGm8a5moiVOGPnfsn1REC5hkf++gMdcVxwGZHaPYaLgoUmx4Kd
         7HB9hkGAZRCNT8OP5LabISny6mv/+6o79fc2iormZM7kge/yFGERzPsJ3qzLcazpG28I
         BsN3n+8L8QKXsMidCl8JaGtwDdifyEfL5cKdCwDK2OK7uC3FyjYONL1ivJ8OMvSXanNM
         bfMg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDujspKVQaVED7Wzb8vbaAIvgFWKQybc1hQF9WTRg7LQmtRrqJWxhJiwbfVgyw6bMFVP1fH9q7C3WjWjKKql5DIM2sC/UBIpJlPMZ
X-Gm-Message-State: AOJu0YzCmUM3BRSnWuOd0HIWtpNg7VyWIL0MXyxW+Z+0TbG3sohW1548
	7LNXrmyC3mEqbJhFYTqwXOjX+OHVEw3kDt8J6M/6QJoMcwMnzf/s8k6oFIsCf0Co6cUqun8EjRd
	bSNL3hE2+mYbW8skGE7sMHPRV2XpqAIERsLPJ3za+eDiRauwMceABZT13qnYLrQTz5cGVpw==
X-Received: by 2002:a05:600c:3541:b0:428:314:f08e with SMTP id 5b1f17b1804b1-42811d736f4mr64822035e9.5.1722328804526;
        Tue, 30 Jul 2024 01:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRnrwtF9jVWc4rdhVvg0daLyUQZWvU9LZ4am4GRq7T1Ti2yXlgf04o7fDSk/yBvnl5kl6dBQ==
X-Received: by 2002:a05:600c:3541:b0:428:314:f08e with SMTP id 5b1f17b1804b1-42811d736f4mr64821765e9.5.1722328803948;
        Tue, 30 Jul 2024 01:40:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805749f46sm205546385e9.22.2024.07.30.01.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:40:03 -0700 (PDT)
Message-ID: <47fe3480-a4a4-465b-8972-c6507c7a76ee@redhat.com>
Date: Tue, 30 Jul 2024 10:40:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com> <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com> <ZqQVDwv4RM-wIW7S@x1n>
 <9e671388-a5c6-4de1-8c85-b7af8aee7f44@redhat.com>
 <12bae4c3-5dda-4798-9f6a-3ac040111551@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <12bae4c3-5dda-4798-9f6a-3ac040111551@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> ... also because I still want to understand why the PTL of the PMD table
>> is required at all. What if we lock it first and somebody else wants to
>> lock it after us while we already ripped it out? Sure there must be some
>> reason for the lock, I just don't understand it yet :/.
> 
> For pmd lock, I think this is needed to clear the pmd entry
> (pmdp_collapse_flush()). For pte lock, there should be the following two
> reasons:
> 

Thanks for the details.

My current understanding correct that removing *empty* page tables is
currently only possible if we can guarantee that nothing would try modifying the
page tables after we drop the PTE page table lock, but we would be happy if someone
would walk an empty page table while we remove it as long as the access is read-only.

In retract_page_tables() I thought that would be guaranteed as we prevent refaults
from the page cache and exclude any uffd + anon handling using the big hammer
(if any could be active, disallow zapping the page table).

What I am still not quite getting is what happens if someone would grab the PTE page
table lock after we released it -- and how that really protects us here.


I assume it's the

spin_lock(ptl);
if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
...

handling in __pte_offset_map_lock() that guarantees that.


That indeed means that pte_offset_map_nolock() requires similar checks after
obtaining the PTL (for the cases where we are not holding the PMD table lock
and can be sure that we are the one ripping out that table right now).


> 1. release it after clearing pmd entry, then we can capture the changed
>      pmd in pte_offset_map_lock() etc after holding this pte lock.
>      (This is also what I did in my patchset)

Yes, I get it now.

> 
> 2. As mentioned in the comments, we may be concurrent with
>      userfaultfd_ioctl(), but we do not hold the read lock of mmap (or
>      read lock of vma), so the VM_UFFD_WP may be set. Therefore, we need
>      to hold the pte lock to check whether a new pte entry has been
>      inserted.
>      (See commit[1] for more details)


Yes, I see we tried to document that magic and it is still absolutely confusing :)

But at least now it's clearer to me why retract_page_tables() uses slightly different
locking than collapse_pte_mapped_thp().

Maybe we should look into letting collapse_pte_mapped_thp() use a similar approach as
retract_page_tables() to at least make it more consistent. That topic is also touched
in a98460494b16.

-- 
Cheers,

David / dhildenb


