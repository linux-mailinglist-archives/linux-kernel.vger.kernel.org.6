Return-Path: <linux-kernel+bounces-263467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AAB93D680
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCA41F248C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96117B434;
	Fri, 26 Jul 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIpoPOVY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE547494
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009744; cv=none; b=qUjXaKCvUnYT2PQ1J1X7myPc0DQrBuLPC4/vMH+gtdEMZX3/uzAkjMtXPj3hqRK7pgOG0PMLLY9jGO3tpW/KmKohVz5Kn/nBoQ1l5ojzLhRaIeMlwHzlfxaPc5HOQIXIZcgd5bSpjXSB88+IV7mz3E+LirC8e/JSl76M06fFmqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009744; c=relaxed/simple;
	bh=+OzqRqWG/hB6gtPFcc8VTWIF4g5JugVGhY6o3NkzDQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFsHntZcq3zv6Ry0gwjmUGpHhOorVUDlB8AWKasXX3pTzSbTZxFombpPPM5ala6U+0egL/0EO313ee7bMXRBseUGbDG9/xZn/Nu+44eZ5uVyaoDrQBYGVBdO3iQN+KrVah791Ww+cbsklfzBGXjXLcHeGhBiiN108YIjsV634RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIpoPOVY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722009741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7T1zmTBwVGz0bXrlRqWcRFYDeuwstSfgw5YyJGwg+80=;
	b=UIpoPOVYLF0DtLDbFPLgU6LIWMRGWWvWFUo35YgmfGcRb7+NNtgX/5YfGrukcSL+6MHoid
	OQzPWIyQnQ/YLHT8FZcXaDRZ1wgUSKhC7dNpcm2vZLUXHoRYt3dlW9Jn9Pjgbe+d/PYBDq
	t4Tgoeg230VqOw9ek7UhYqdB45M8pSY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-KePVtr3DMum42oQb5UCjtA-1; Fri, 26 Jul 2024 12:02:20 -0400
X-MC-Unique: KePVtr3DMum42oQb5UCjtA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso4029895e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722009739; x=1722614539;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T1zmTBwVGz0bXrlRqWcRFYDeuwstSfgw5YyJGwg+80=;
        b=Z5VYHO9nzbGbB85eK/3Dyggn2vs67OTafnj+QcyPURCea/IOKWLb4yLsP2gde/T1hm
         AV38EX5fFAOiy0DNS8meX+Qk7NebIFgIWXReGVB6PzFrUC2R5+QYL3ce1athDWScXCfG
         px5M0OQrwOwC4Z94lq4dH5CGxql4rzw9WxxnsHyr8ZzhLPfyAK9ZJfTdysBy24gnlsq3
         htdPoApyEJJDeFeIUiIRnyFpofiScQcRrrv6s1lGi1kXRqjMmWeJbGyAWzeo0bVBeCoV
         UW90dZDXFCm2EcdAthnrHgLaQbLjUZ84mrRa/46gWpCIQcj2y5UQbQnl3zlE+kL+MOqe
         NByg==
X-Gm-Message-State: AOJu0YzZL8Jhmy1uV/8tuKSyn+lnbLtLBy+hFluBDQut4920X9JLcD49
	8LYKIgB85HgmxW1tS5XWo8E/VBcRHAb+SiRwCiRJvVrH+NyPG9Eu29bE2Eh4055srpqJv1ZNRp3
	xHTRgaXu8cnKJ8eERK6piIMxbwX7IMgV1mR49a1aF9YNZ4xr7Mo0UpoZo5P9RRQ==
X-Received: by 2002:a05:600c:4443:b0:426:62df:bdf0 with SMTP id 5b1f17b1804b1-42811d89fa6mr377495e9.10.1722009738967;
        Fri, 26 Jul 2024 09:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvlQVmYtYSHV2w4oWaVeN6nu2eNw75aLgomatOHw1+wGrnRlzhOnJdwzl4yuZzH8UMhx/1yQ==
X-Received: by 2002:a05:600c:4443:b0:426:62df:bdf0 with SMTP id 5b1f17b1804b1-42811d89fa6mr377245e9.10.1722009738509;
        Fri, 26 Jul 2024 09:02:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573f935sm85232985e9.14.2024.07.26.09.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:02:18 -0700 (PDT)
Message-ID: <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>
Date: Fri, 26 Jul 2024 18:02:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com> <ZqPCjd35OdNRrcfl@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZqPCjd35OdNRrcfl@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 17:36, Peter Xu wrote:
> On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>> pointer.
>>
>> Let's change that. The two callers in pgtable-generic.c are easily
>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>> pte_offset_map_nolock() to obtain the lock, even though we won't actually
>> be traversing the page table.
>>
>> This makes the code more similar to the other variants and avoids other
>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>> reside now only in  pgtable-generic.c.
>>
>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>> the PTE table could have been removed in the meantime? At least it sounds
>> more future proof if we ever have other means of page table reclaim.
> 
> I think it can't change, because anyone who wants to race against this
> should try to take the pmd lock first (which was held already)?

That doesn't explain why it is safe for us to assume that after we took 
the PMD lock that the PMD actually still points at a completely empty 
page table. Likely it currently works by accident, because we only have 
a single such user that makes this assumption. It might certainly be a 
different once we asynchronously reclaim page tables.

But yes, the PMD cannot get modified while we hold the PMD lock, 
otherwise we'd be in trouble

> 
> I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" would be
> nicer here, but only if my understanding is correct.

I really don't like open-coding that. Fortunately we were able to limit 
the use of ptlock_ptr to a single user outside of arch/x86/xen/mmu_pv.c 
so far.

-- 
Cheers,

David / dhildenb


