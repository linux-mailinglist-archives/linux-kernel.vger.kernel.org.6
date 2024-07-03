Return-Path: <linux-kernel+bounces-239245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F243925876
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45381F22A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3159616F0FB;
	Wed,  3 Jul 2024 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhPgC6Id"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66616F0E6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002288; cv=none; b=dqDx7WygSYKUbjhswGMpi/QYtu3rQGSdjePwsxgm6DOj5w8yWF2AC9+/ZP65wu1vwJ78i826vRtbF2S2QHZ7hiJlo9HoWJXvpthctuXY4/6Kb60BvfzYXJ9FY6lwhFbt4ru9EHlPDMviZxvO4FWk5HBZt2kZoS33Q2Jh3/vlpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002288; c=relaxed/simple;
	bh=AVYGNZH+2betuffNYCKY1Ul6QSLIcRFMUYRo7rSbL2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUr8XxFmjXactjIPKHnDTZP6ewnqpW2Z5kKzlQPQeL3xtg2c5o/dNQ5L+51JAdCaalPDEgtUy/bQr5fuhNZZX8WJZux9yLPEn1h2lpeoHy8C5oKUZmyXX4iBhm0dG8MTWQpcC5QFGCRZKWdmfMKAEdAj5ONm9Mr+yakGRHvtwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhPgC6Id; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720002285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1XI0bCyw0Ess6YcQD74Wt1XFlFKMszy5OU57DGvuPbc=;
	b=WhPgC6IdwqXJXLg0qw2daq+k2nkgyBveFdPmcx1+N8NZCBN15YofmgvRE+JEpuUl1AxQFk
	KFhU6vwK0jouh+2pbOV54A2iR9vUkPCJRvzgtbbwC8eDnZJ4mfNxY5FAk+PkcgdE3edq2r
	kdVOI70S+Nhy01E2etDGbwOZUB+N/Pk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-PwyzGI7XMRSPXGJLuanDog-1; Wed, 03 Jul 2024 06:24:43 -0400
X-MC-Unique: PwyzGI7XMRSPXGJLuanDog-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52e765bc03bso5300126e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720002282; x=1720607082;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XI0bCyw0Ess6YcQD74Wt1XFlFKMszy5OU57DGvuPbc=;
        b=tZOla3e0basHVnUIEu5DjO7UrG7cK/x4WuDK/4GZbY1cbwfFNHtEtQyn3bOCjWJwGo
         1MlZiqXVI1JfaikCwH3fi4HuZOAcz2vNEvaNqIwLS4moznY1WeUb92iM2IVI/nMbUqS5
         1Ykqlx3nnadiJl4tw96PUsIDcf4zdOX2oL2Bnuf04+ppkJMKGuJsDxfg733aZkSrUy5s
         Cjir5EhgnwX34TJ3X74kOXLDGFDJ9N9baGT74TW1t8KCxXCkKTsJFkPUNolkPDOChnbS
         cT3aQLMnO/mLWlus53GohMTOCaK2SF/Q7v+T32V8QZahBWrBCalQbN9PY1b94uSYkbXt
         P9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdOVmL/SO5FEEJrgwIojRGiBi7cuwSVBvOVnx4iLRGgaAUVekS56LIKv0vW43MAaAezIZ5pA2Bffjb+riLCCoTHYb7if/ZscMd2/g2
X-Gm-Message-State: AOJu0YzivoQYAnidxob92sw7mOv2ZN941jiEWOnwF9S24ECUG2O+jhnI
	XMdpXWcNVYO6HSvtH3qp3PIMJB5XzzxIUz9LNK5iQD43q4S2OX0r+u+t/Bu9c+hmldchd6XqRD5
	XTFiSW2jJqJuQySdLbqG4XNoD1VoHmvjePx7t5357cOPKFhrevlDzrN+MooSAbQ==
X-Received: by 2002:a05:6512:1154:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-52e826feb8dmr7546290e87.51.1720002282466;
        Wed, 03 Jul 2024 03:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiZD2DbI9EXGNzgB3Co15zbpLQ2EaK+/TGFKXNCVLc6THVQYc2kmrtEmqxxFSBSAl/WRckww==
X-Received: by 2002:a05:6512:1154:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-52e826feb8dmr7546272e87.51.1720002281989;
        Wed, 03 Jul 2024 03:24:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3400:5126:3051:d630:92ee? (p200300cbc709340051263051d63092ee.dip0.t-ipconnect.de. [2003:cb:c709:3400:5126:3051:d630:92ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm238521675e9.41.2024.07.03.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:24:41 -0700 (PDT)
Message-ID: <cdc28193-5748-41a0-9308-6ef1f0be3690@redhat.com>
Date: Wed, 3 Jul 2024 12:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com> <fcf036e1-d65c-4a4b-9280-19024bb4da1b@redhat.com>
 <9dd065aa-f377-4b4c-893a-df69c9f67360@os.amperecomputing.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9dd065aa-f377-4b4c-893a-df69c9f67360@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.07.24 02:20, Yang Shi wrote:
> 
> 
> On 7/2/24 6:09 AM, David Hildenbrand wrote:
>> On 02.07.24 14:34, Catalin Marinas wrote:
>>> On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
>>>> MTE can be supported on ram based filesystem. It is supported on tmpfs.
>>>> There is use case to use MTE on hugetlbfs as well, adding MTE support.
>>>>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    fs/hugetlbfs/inode.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>>> index ecad73a4f713..c34faef62daf 100644
>>>> --- a/fs/hugetlbfs/inode.c
>>>> +++ b/fs/hugetlbfs/inode.c
>>>> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file
>>>> *file, struct vm_area_struct *vma)
>>>>         * way when do_mmap unwinds (may be important on powerpc
>>>>         * and ia64).
>>>>         */
>>>> -    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>>>> +    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>>>>        vma->vm_ops = &hugetlb_vm_ops;
>>>
>>> Last time I checked, about a year ago, this was not sufficient. One
>>> issue is that there's no arch_clear_hugetlb_flags() implemented by your
>>> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
>>> initially tried to do this only on the head page but this did not go
>>> well with the folio_copy() -> copy_highpage() which expects the
>>> PG_arch_* flags on each individual page. The alternative was for
>>> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
>>
>> This would likely also add a blocker for
>> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP on arm64 (no idea if there are now
>> ways to move forward with that now, or if we are still not sure if we
>> can actually add support), correct?
> 
> IIUC, it is not. We just need to guarantee each subpage has
> PG_mte_tagged flag and allocated tags. The HVO just maps the 7 vmemmap
> pages for sub pages to the first page, they still see the flag and the
> space for tag is not impacted, right? Did I miss something?

In the R/O vmemmap optimization we won't be able to modify the flags of 
the double-mapped vmemmap pages via the double mappings.

Of course, we could find HVO-specific ways to only modify the flags of 
the first vmemmap page, but it does sound wrong ...

Really, the question is if we can have a per-folio flag for hugetlb 
instead and avoid all that?

-- 
Cheers,

David / dhildenb


