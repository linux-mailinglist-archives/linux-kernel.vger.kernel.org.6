Return-Path: <linux-kernel+bounces-241304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E992798B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09251C22361
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C01B1435;
	Thu,  4 Jul 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky9wpNW3"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0F1AE0A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105530; cv=none; b=ZB3xj4rw6u8NpBy5NfgncwI+aGN9PdMuQt3J9VANyLHBcNhHdS5E2psWNA8TQ0N4P5Zn73D7n3wYbw4eolN5PmBwAi1+7NeJwzVWQn9sDSdt2yQHJl7wyLav/CI1ne/tojSrXrOJQLJc4slCZTwh61LpKw63v4z5zpSgsN4TzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105530; c=relaxed/simple;
	bh=ScxkmeorW1UmrQPB2P0nskUxabP3wA1GK+wAmRNFA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGKnJAFiAFafs7YY6TQDHc4VvnFFYd3wNSDD42re/6QRNT5TMs0IqjgXFhLxHhBdFArc3vjl6bjHTuhcppiiR9/WXANdS7mdXQIm6h2Qi8s7nJKcT9llnzJM79oWb3sflsfjBtZupWTNcLMbPvlHcY8nz0eVaR+X4yw+uRbjzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky9wpNW3; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fa9f540f45so4183465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105528; x=1720710328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+OTuZquSA9qrGdQN6N14g3XlBX1TTYhuNAN0KMl3/I=;
        b=Ky9wpNW3/wdRmg/uYet+8SXr4s60OQmT6Hq/cZYZfJktwKyz8s45mRiJ4RFMhEJ4ux
         XMjORd2fS1KGP5sXwMxcxeivXRX270XLKRpNYL1XtG8gwn8AY9TjoU9HsW01cvUeN/fK
         0a36e22xnj+W9Bx+sp61xV/OTBjheWCWdNDUd7aFc0KUtTuJB0JzU91FkmYtrwlIwSBC
         NgAl4yFfoM8Q7AAoJJVxKkm7GwYDSK09XZRPBlrkFEYQkGfNzQ1EtTn75L7gLsEGSDv5
         JyqsdJ4gvR/VB/oc+fI+4yJsnLbF8prTO1ChV/6JMGi8WgHSYMEjWq+yMKzJ6R0zuAKv
         KjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105528; x=1720710328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+OTuZquSA9qrGdQN6N14g3XlBX1TTYhuNAN0KMl3/I=;
        b=lNzvK+dsXpxZQcR8bdAAnCqMIfh75w5j/TWJ5DLQpju2Z6zopwCp98oWplWAJiV/7F
         sEhJhIApok6pTwVlvF8GsSRdNMpAoGhx6MAEQaAt5Vwj5p2w/sMFkOUNPH327HtLJWX7
         0eLjaYX6F1wspdjiW1KyZUCcJsWVJmTEtO3v1Zpk4CyoN0/jEReAYhADBzBHpj/qCJVd
         IO34GuayYxxoK+iM38YZHYA5naG0Ic6199JnE+X+KAV9nMRSqZ5HGifUgztj8ZVwC6/Y
         J24zCpzzImLEmelD/4+5B1YBzzg/8ssMvKcDRypFtQhfx3VzHJsdyc3oXFscvdBlmlNC
         rhow==
X-Forwarded-Encrypted: i=1; AJvYcCW1M4iJBq7W5GWLuud8qDM/rbCPbuf30QVZVd/XBN1SFLAuC7IwExmINPb4D6dLLL2Y/BmEqdz2zPkiu4oZcnGqdQ61sLE33DmRQfKX
X-Gm-Message-State: AOJu0YwoKMYlY2bQnKTyOyhT1HrEhd+BVlCbl0BYHXF8jG+yotRfzWXo
	QTHiAimucHMVa8ktUF7rzCBALKenPtiSRuHqaauWDIRA8xycd/vh
X-Google-Smtp-Source: AGHT+IGWUzqZUnL38Qwc3q7M06Ls27MzM+otabS6SLOrNiwPOQUVdfSYcIlCaikvEZPP3rp8iBSa4w==
X-Received: by 2002:a17:902:ea0c:b0:1f9:f217:85c with SMTP id d9443c01a7336-1fb33ef60c3mr15860425ad.52.1720105528182;
        Thu, 04 Jul 2024 08:05:28 -0700 (PDT)
Received: from [192.168.3.24] ([36.24.57.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15789b7sm123694745ad.239.2024.07.04.08.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 08:05:27 -0700 (PDT)
Message-ID: <33d04365-c129-453e-b3b3-0691cfecd36e@gmail.com>
Date: Thu, 4 Jul 2024 23:05:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
Content-Language: en-US
From: Bang Li <libang.linux@gmail.com>
In-Reply-To: <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Ryan,

On 2024/7/4 21:58, Ryan Roberts wrote:
>>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
>>> PMD-size control for decisions.
>>>
>>> I'm also really struggling with the concept of shmem_is_huge() existing along
>>> side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
>>> shmem_allowable_huge_orders()?
>> I understood. But now they serve different purposes: shmem_is_huge() will be
>> used to check the huge orders for the top level, for*tmpfs*  and anon shmem;
>> whereas shmem_allowable_huge_orders() will only be used to check the per-size
>> huge orders for anon shmem (excluding tmpfs now). However, as I plan to add mTHP
>> support for tmpfs, I think we can perform some cleanups.
>>
>>>> +    /* Allow mTHP that will be fully within i_size. */
>>>> +    order = highest_order(within_size_orders);
>>>> +    while (within_size_orders) {
>>>> +        index = round_up(index + 1, order);
>>>> +        i_size = round_up(i_size_read(inode), PAGE_SIZE);
>>>> +        if (i_size >> PAGE_SHIFT >= index) {
>>>> +            mask |= within_size_orders;
>>>> +            break;
>>>> +        }
>>>> +
>>>> +        order = next_order(&within_size_orders, order);
>>>> +    }
>>>> +
>>>> +    if (vm_flags & VM_HUGEPAGE)
>>>> +        mask |= READ_ONCE(huge_shmem_orders_madvise);
>>>> +
>>>> +    if (global_huge)
>>> Perhaps I've misunderstood global_huge, but I think its just the return value
>>> from shmem_is_huge()? But you're also using shmem_huge directly in this
>> Yes.
>>
>>> function. I find it all rather confusing.
>> I think I have explained why need these logics as above. Since mTHP support for
>> shmem has just started (tmpfs is still in progress). I will make it more clear
>> in the following patches.
> OK as long as you have a plan for the clean up, that's good enough for me.

Can I continue to push the following patch [1]? When other types of 
shmem mTHP
are supported, we will perform cleanups uniformly.

[1] 
https://lore.kernel.org/linux-mm/20240702023401.41553-1-libang.li@antgroup.com/

Thanks,
Bang

