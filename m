Return-Path: <linux-kernel+bounces-413969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B29D2130
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609EFB22727
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE319755B;
	Tue, 19 Nov 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hU8GBw99"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D715530B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003356; cv=none; b=pz2cs1BqKpRE7G1wLbwJUCnG3cUuMLDxhGS3CttW4J/YA3E+HJ8WjK/Cq7v9OjipYSkrfaIh9BScFbk9QO7RsofMxfhEO23c4SYOXMl0+TskAufWIadoaK3tmx017ZbBE5vLPN59Ckmxss+WDAkyTd9IRzWdlve7hYXyUuucTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003356; c=relaxed/simple;
	bh=4i/v1omw9XCFSnndbS6nQVGvvXZ4mPwHAtyN5S2HS8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSoBCsnzdxX/ey7fvwkE6gwWpDH0qTpARRAOFUOZZtNJz7SaAX15Pnbm6zX5KdIAnjIHR8PI6vRyoY2eF7BPOmw9QtvJ10wAK8D1MbAVbp1CHrch/bgB1u7jcPTZmFeg7K0bxw2PDknkXhAuv+gy+jLK+tLTWXGdh44zoes1xUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hU8GBw99; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso2112966a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732003352; x=1732608152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ptxWOLhwY83i5UqA3Iw8IEjORQN26nE+qFNN5zhqLE=;
        b=hU8GBw99F15ikfK8rjt4AG2neP88svy+LSCemSKGSAg+bBh8k9Hy0hwSS8zJvyUEBa
         cwvvdonBEP2KDw2cqhTaxFJROtS/CLvyFXIEs6jcOqoZVU/QBX3s7pqK3S0j4iOO3CTl
         gyWlkyQQaGhUv1wRURgvGJbxoOTBROJZeCsW80SAvTHb2ZIQt2sINjXMAs6IzHpmsY5U
         CWvXnQZKBnIrF/89r8AK866U0ZtE9Dqs+AxUeP25JzBDVLUYevvVnoXIpVqLz/91iA/6
         QBX+8O3+j1anPrkLfesupKpK/Y2rD+fS69qPPePIYUdLjAL1dZalf7lF3gr0U/Mn9Ai8
         11iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732003352; x=1732608152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ptxWOLhwY83i5UqA3Iw8IEjORQN26nE+qFNN5zhqLE=;
        b=UhZvULb666POQ7gInCjTZcxmFrngBC7UePkjs1bUbdbFwYmbfl+s1w8YrCIc/o08/+
         yhWNr2SZYSLcd5hdtD+HcLpt35AC62R2pCZ9rmzNL40S8x/aQTPLJbywTm15pjd924eN
         gQwajy2OhVkBmUKSC8ZnF7jtdB168KOQKUCxoaREArESURxHS9y+VNyK84TlmKtyLs90
         r73OTaUNxd/FXBpoWhTD8keFZVtKr5huR3SO8ATCzUGElPJaG5P74O518vbnKRr0wCBr
         2yDzl7ngTzwsGCAfFLfJ5nY6y/NU21h0b6Rds+aWQPrEFO/1WgXKg5PpDQT5Zk5pr3qY
         onOw==
X-Forwarded-Encrypted: i=1; AJvYcCWb1uHXwz/1RMCtXdGhN0pB3nra6TiUlVq+7XQRog+MC/0cSNqOTu0PBGZgBf2VPh/keJ1oRI2BUBWzRqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjx5zpCenPbVzKZ7tmRrEEU9dYT3NpjWloKcApsUSs2vo94o2
	PgsKFEjY1vz6AZluKgFiJQAWjivHwKtdP8i4ePiiZM5bby7ZIcF1QLGOwd1XDBo=
X-Google-Smtp-Source: AGHT+IFSWv+2WRwnRxskSn9wpDBXbKF5P/y3Yv7eTYqxzDn6NDsCS5xMho5ZtmuTYi+6cJfHNobtnA==
X-Received: by 2002:a05:6a20:6a26:b0:1dc:6fed:6248 with SMTP id adf61e73a8af0-1dc90b47d0emr23645373637.22.1732003352420;
        Tue, 19 Nov 2024 00:02:32 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c04e3sm7696427b3a.102.2024.11.19.00.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 00:02:31 -0800 (PST)
Message-ID: <9c12aa68-47c5-4def-92ff-7f91502d85a5@bytedance.com>
Date: Tue, 19 Nov 2024 16:02:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/mm: add more warnings around page table access
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>,
 SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Rizzo <matteorizzo@google.com>
References: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
 <21195425-53d9-4007-a020-8106f94158dc@bytedance.com>
 <b915ff26-e90d-4151-ab2f-607f3c59f501@lucifer.local>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <b915ff26-e90d-4151-ab2f-607f3c59f501@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/19 15:48, Lorenzo Stoakes wrote:
> On Tue, Nov 19, 2024 at 02:53:52PM +0800, Qi Zheng wrote:
>>
>>
>> On 2024/11/19 00:47, Jann Horn wrote:
>>> Make it clearer that holding the mmap lock in read mode is not enough
>>> to traverse page tables, and that just having a stable VMA is not enough
>>> to read PTEs.
>>>
>>> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>
>> Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>>> +
>>> +* On 32-bit architectures, they may be in high memory (meaning they need to be
>>> +  mapped into kernel memory to be accessible).
>>> +* When empty, they can be unlinked and RCU-freed while holding an mmap lock or
>>> +  rmap lock for reading in combination with the PTE and PMD page table locks.
>>> +  In particular, this happens in :c:func:`!retract_page_tables` when handling
>>> +  :c:macro:`!MADV_COLLAPSE`.
>>> +  So accessing PTE-level page tables requires at least holding an RCU read lock;
>>> +  but that only suffices for readers that can tolerate racing with concurrent
>>> +  page table updates such that an empty PTE is observed (in a page table that
>>> +  has actually already been detached and marked for RCU freeing) while another
>>> +  new page table has been installed in the same location and filled with
>>> +  entries. Writers normally need to take the PTE lock and revalidate that the
>>> +  PMD entry still refers to the same PTE-level page table.
>>> +
>>
>> In practice, this also happens in the retract_page_tables(). Maybe can
>> add a note about this after my patch[1] is merged. ;)
>>
>> [1]. https://lore.kernel.org/lkml/e5b321ffc3ebfcc46e53830e917ad246f7d2825f.1731566457.git.zhengqi.arch@bytedance.com/
> 
> You could even queue the doc change up there? :>)

OK, I can add this note to my patch after this patch is merged.

> 
> I think one really nice thing with having docs in-tree like this is when we
> change things that alter the doc's accuracy we can queue them up with the
> patch so the doc always stays in sync.

Agree.

> 
> I feel you may have accidentally self-volunteered there ;)
> 
>>
>> Thanks!
>>
>>>

