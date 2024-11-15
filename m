Return-Path: <linux-kernel+bounces-410508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072879CDC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3832DB2856B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5E1B532F;
	Fri, 15 Nov 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8YKgFl+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DE18D622
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666160; cv=none; b=grEEdnbncLiK8mBfWa73f4W4WHv/4puE0UQ9WjZBv45mCOH9ZBbUdZAJ/RjgMTh1j4rVaBmKbBjYUIU8wOkJrKyCSsqyIa8ANdQq3kpujf8bugkoaf4byKwlRFH0GES3IgzzaEnqMqJHuBeeyrgGG7dwZZYEaC061TdUMmT+JIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666160; c=relaxed/simple;
	bh=yMmlRPJl+t0sQZdClVT4kzqVHXkOjUz6wagEi3wh+Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWx4ASvIR8zeIS0jaQgWrD65z5Pch6j8Y/pRc5KeDU2QANogXYuIXsFMfz2OBmn+ExpmvhUP6fJE6GGLgbwSdJDLfFpXKXHZ5P+NW5gXl0TMcD/u1Rgrp9Z+eobEcKsbQZhpRrCU4irLgC77K8dCO6Jmk2QJPye/ObQK4d/3lE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8YKgFl+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731666157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ux7KUG5UT6eJm+EXbw9S/7qAW94cl3j4C9FIsNNOYAE=;
	b=I8YKgFl+CyqaZ2A3kPVCub1FfdUnqBO3Nubvt3731bsdt19Y0Bj73uRpKygHi597fjwYkQ
	UnIKN4jnDh66RsmQzqA/cQHZc3IlstXTBW5Dh3LP1dmXr5mojCWqVAUIXZZCH4lSy7W502
	quO3kS9PRv+FFTmOLgTdVycOZtw+Eqk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-3U0U2wKEMB2g6kyW-vm2aA-1; Fri, 15 Nov 2024 05:22:35 -0500
X-MC-Unique: 3U0U2wKEMB2g6kyW-vm2aA-1
X-Mimecast-MFC-AGG-ID: 3U0U2wKEMB2g6kyW-vm2aA
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539e03bfd4aso1025483e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731666154; x=1732270954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ux7KUG5UT6eJm+EXbw9S/7qAW94cl3j4C9FIsNNOYAE=;
        b=mjiWgjQ2RBlRVgFOnss4QRDDbIjVcywKse7msp2WD1uGpb8ezugsCIM4jIJczQ9RCd
         uVI758dSKktb6jw+a1nbPoHZXt3nEyANDZ0k0vZjvIL3pOgA+4QO6o48kFTZw5NYd3o7
         sW/Z5ag15rrPRX2wbOQT0N3S/30Rvz4+Tj8eHorit80Jlu/Kw75j/BkYxfyoZ4cbn+tT
         H5LoOmvP09qb2217dyZ5YsHMcwTcok2wsfm6ve2/L90iZdO3Dlubh5pXAtuARN2vVCO9
         lav7eRhjfiJlrlNKp36P1jlSwgzZ7sManfF3m8ZNp7mu6N2J//ewe7g3zBlRNey7vwh3
         UBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWLqwzVnWAed8PXdC0vmdtPluiw9sX6W/dqU6wD+zfByTZ0iangZmtJ+hLwn/2JPE0tna1ZcGlwV9dEGf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQLUA/bQHd6mLLMNOf4DcJeYKIIjE2VqO7BbifOzeLBDAe5lx
	pdAd6b+z0aWv4x9Sy7EJCe5Fac9/FySOgE0edm1zAkqoFWadNv2OqP1HCmfYJW+gDoDvhH1vFnD
	DPOqdlEWJDm7hqcuL4gnU04RTTXDnAYJsR9gaq/njRrVMKcOesKxrQ5q8S++0Sg==
X-Received: by 2002:a05:6512:234e:b0:539:ebb6:7b36 with SMTP id 2adb3069b0e04-53dab2a6db0mr905230e87.25.1731666153903;
        Fri, 15 Nov 2024 02:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmWfNxMU2GmqMPJhZmTOwAqEOBEK9vtajVo0kJjvdAeE/448JXp3Alm5jIsmFy66CR8ptcKw==
X-Received: by 2002:a05:6512:234e:b0:539:ebb6:7b36 with SMTP id 2adb3069b0e04-53dab2a6db0mr905208e87.25.1731666153501;
        Fri, 15 Nov 2024 02:22:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38221679dbdsm2907816f8f.64.2024.11.15.02.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:22:32 -0800 (PST)
Message-ID: <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
Date: Fri, 15 Nov 2024 11:22:31 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> *nr_skip = nr;
>>>
>>> and then:
>>>
>>> zap_pte_range
>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
>>>                           rss, &force_flush, &force_break);
>>>        if (can_reclaim_pt) {
>>>            none_nr += count_pte_none(pte, nr);
>>>            none_nr += nr_skip;
>>>        }
>>>
>>> Right?
>>
>> Yes. I did not look closely at the patch that adds the counting of
> 
> Got it.
> 
>> pte_none though (to digest why it is required :) ).
> 
> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
> empty PTE page.

Okay, so the problem is that "nr" would be "all processed entries" but 
there are cases where we "process an entry but not zap it".

What you really only want to know is "was any entry not zapped", which 
could be a simple input boolean variable passed into do_zap_pte_range?

Because as soon as any entry was processed but  no zapped, you can 
immediately give up on reclaiming that table.

> 
> Looking forward to your more review feedback on this series.

Thanks for all your hard work on this, I'm only able to make slow 
progress because I keep getting distracted by all different kinds of 
things :(

-- 
Cheers,

David / dhildenb


