Return-Path: <linux-kernel+bounces-412635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8249D0BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD78CB24550
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1311925BF;
	Mon, 18 Nov 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PH0E8x/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B518B47E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922166; cv=none; b=AoMZSUKn9VXlVpufavTyU23bjB2Ttj/ip4lS8JASc3KiW3xaTKrZomb5bv37qa3XkXRQ0YO3hsxXGwX8DmcaM0CZZYsmpF2J2Oxp26hRw3c0dKKF2PBLJ+qg/JUM9pmlRD0yNyw/OjXi0u1cJ3b9sGY2auN0Z3Q+YTkVTjWohrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922166; c=relaxed/simple;
	bh=jDOi9PB4YOZniTDA7TZz/l76hNDnneq3oWJ3Lmd54gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjiXWSw7cDNgZkKiM+y4Gg/fQcULQVza8b+dub4eHe5lO++NDHSGvBOqF7bjGAzrZ/O+0fdzAlwDBHUzzaZOEU37aSSHYclwJZCPaVn3Aw0e8yIX4y/jwo0n+hBKZbbSatnm0vF+CBfi1PIAt0b99Y5jDL9VIL6ixowPJ3eMjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PH0E8x/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731922163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A7c7/LIfODvj0VK+Yyod+0u7VqZ/LEMd2lf12FCZQ04=;
	b=PH0E8x/kHkr0E3ndT0V6YXon2AOdfXQGmSynG8v8ATuHlmRDC8TKQaZ9zcuYKsICl9+jeT
	fRliJYnI08LVW/+QIsYk4mU+qzFC85Sb+083/Yta0WZze+p39dNxh2YV2REwGlv8udtRHs
	B5HKOtVZrga2ZXJlMdxSuDYEAK8jzy0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-aKmCuL3fPzWSCZiWhqCGnw-1; Mon, 18 Nov 2024 04:29:22 -0500
X-MC-Unique: aKmCuL3fPzWSCZiWhqCGnw-1
X-Mimecast-MFC-AGG-ID: aKmCuL3fPzWSCZiWhqCGnw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3823527eb9dso1040104f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922161; x=1732526961;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7c7/LIfODvj0VK+Yyod+0u7VqZ/LEMd2lf12FCZQ04=;
        b=sST7TGi4+DMbwvduHiJOwxlBvMFXadSsGHVpLdWn0EX/UOIuB5oQmN1vzeUBUzRhht
         V4YMdk7kMpRaHTjswN72hZ3ImOSHYHLhLJFux8SEnjLfXSmVJ46vAJor1SjFMYMG9q59
         y30TE6gRvPAgK4nIyQYLk9KRfDSCwKdvgQQAl4caBiMASnGmJYj7nIhNdHz3aUokYi5u
         Wj5c3J5sPl6zJJ7/96HJEWTmub5w3VuPPWCgUBlODub8SAui09SHE+poZbI9npifAMLw
         xwpnQK4cRH8cZ1/vb0+LjLmG6Xkks1Ebmf38ogjZf1ylCTcUHuuBk2yRNHpB3fKUBsb3
         mAXw==
X-Forwarded-Encrypted: i=1; AJvYcCX6wi0nf9Dqdat24YYB6Jv5glvO903SK2R+aGU3olErmBionYLEDegv7LVP2lF+7VzNJubCtixXGLzkYW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKObeIGR39w+/JRsLFjKo8sj//Bvfe4YionRanDQQXSacO9nFA
	MfZirALiLelE/ivNwaiHpWLWMRKsxCgJbG3nvNAkDfG+97DQde1Y4mexmXxAbYrEkXYZ2ugSLnW
	VXOSlPdRspVVZoGdnxf3ijUFYkTZae5dyRXsB7EZFlYXwFamTU3yRoiPDgKHLpg==
X-Received: by 2002:a05:6000:4026:b0:382:30a5:c38e with SMTP id ffacd0b85a97d-38230a5c6b9mr6829443f8f.31.1731922160796;
        Mon, 18 Nov 2024 01:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1/kiOGCjHHcyFquW56QsyPqelrWxTJJtvLTBZBjTZ/D2nKkaQB2IX71YBJPVgmUiolXKJ0A==
X-Received: by 2002:a05:6000:4026:b0:382:30a5:c38e with SMTP id ffacd0b85a97d-38230a5c6b9mr6829423f8f.31.1731922160354;
        Mon, 18 Nov 2024 01:29:20 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38237441ccesm6532660f8f.51.2024.11.18.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 01:29:19 -0800 (PST)
Message-ID: <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
Date: Mon, 18 Nov 2024 10:29:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.11.24 04:35, Qi Zheng wrote:
> 
> 
> On 2024/11/15 22:59, David Hildenbrand wrote:
>> On 15.11.24 15:41, Qi Zheng wrote:
>>>
>>>
>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>> *nr_skip = nr;
>>>>>>>
>>>>>>> and then:
>>>>>>>
>>>>>>> zap_pte_range
>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>> &skip_nr,
>>>>>>>                             rss, &force_flush, &force_break);
>>>>>>>          if (can_reclaim_pt) {
>>>>>>>              none_nr += count_pte_none(pte, nr);
>>>>>>>              none_nr += nr_skip;
>>>>>>>          }
>>>>>>>
>>>>>>> Right?
>>>>>>
>>>>>> Yes. I did not look closely at the patch that adds the counting of
>>>>>
>>>>> Got it.
>>>>>
>>>>>> pte_none though (to digest why it is required :) ).
>>>>>
>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>> empty PTE page.
>>>>
>>>> Okay, so the problem is that "nr" would be "all processed entries" but
>>>> there are cases where we "process an entry but not zap it".
>>>>
>>>> What you really only want to know is "was any entry not zapped", which
>>>> could be a simple input boolean variable passed into do_zap_pte_range?
>>>>
>>>> Because as soon as any entry was processed but  no zapped, you can
>>>> immediately give up on reclaiming that table.
>>>
>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>> found in count_pte_none().
>>
>> I'm not sure if well need cont_pte_none(), but I'll have to take a look
>> at your new patch to see how this fits together with doing the pte_none
>> detection+skipping in do_zap_pte_range().
>>
>> I was wondering if you cannot simply avoid the additional scanning and
>> simply set "can_reclaim_pt" if you skip a zap.
> 
> Maybe we can return the information whether the zap was skipped from
> zap_present_ptes() and zap_nonpresent_ptes() through parameters like I
> did in [PATCH v1 3/7] and [PATCH v1 4/7].
> 
> In theory, we can detect empty PTE pages in the following two ways:
> 
> 1) If no zap is skipped, it means that all pte entries have been
>      zap, and the PTE page must be empty.
> 2) If all pte entries are detected to be none, then the PTE page is
>      empty.
> 
> In the error case, 1) may cause non-empty PTE pages to be reclaimed
> (which is unacceptable), while the 2) will at most cause empty PTE pages
> to not be reclaimed.
> 
> So the most reliable and efficient method may be:
> 
> a. If there is a zap that is skipped, stop scanning and do not reclaim
>      the PTE page;
> b. Otherwise, as now, detect the empty PTE page through count_pte_none()

Is there a need for count_pte_none() that I am missing?

Assume we have

nr = do_zap_pte_range(&any_skipped)


If "nr" is the number of processed entries (including pte_none()), and
"any_skipped" is set whenever we skipped to zap a !pte_none entry, we 
can detect what we need, no?

If any_skipped == false after the call, we now have "nr" pte_none() 
entries. -> We can continue trying to reclaim

If any_skipped == true, we have at least one !pte_none() entry among the 
"nr" entries. -> We cannot and must not reclaim.

-- 
Cheers,

David / dhildenb


