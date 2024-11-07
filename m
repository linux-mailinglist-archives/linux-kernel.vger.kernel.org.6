Return-Path: <linux-kernel+bounces-399414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC49BFEA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8656C2846BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF7194C78;
	Thu,  7 Nov 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IGwfooxI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC056194089
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962053; cv=none; b=XlBoD/adb+Ji1j9tOXJ+JIzoUhfb3niL/Bn2TtRkdyoFkS5xcwAW1/g3B3c1qQHnDb7eMCqovPNV9+pOj5CM+mmbYVlymY6mHw2eZ6HsCB5+Co9HJjLd7QevIRhJ9NRzRZm4u1F7++fMXo+Tk+UAIazB1RnEL2skT36pPo9H20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962053; c=relaxed/simple;
	bh=ocy21hewhSAxDYmjcwPkCD/e6H5tK1tO/YDxSNJA5gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHjykJYqsxUfOkea7LsyJh9IPbaewO6raTMGqHlpvo/mW+qrsyjrUpsZuUmHl0MRwTJ70GbLyA/vEhLHXun5n28/KyRWZ3R3vDpkkM0j48owdj1B1tZQQMifgTVzmAmZbTovdEhl00bBfMg6R9828lFJiQ9B4sTl8d+zufGWQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IGwfooxI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso423877b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730962051; x=1731566851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4sYJYVbNn+8nZHewUYqHaSq6iJqGNPs8Z77SlmIpAU=;
        b=IGwfooxItxr2eZv0Z6GebPYXkNiKtZQTDa9+C3jDPMSvd/nreT/SlUrmCsqHMsEl8R
         7c75cPpXaqCny/fci5KFlGzHiAxNlUddAKefRPmnjedzIfmCk1p2PEHiYfIaLbUzJOEE
         1XiVsRDxPbSyelvE5M/qPlRwKw+/VsuqsXYsD6v0dtpSlS2HcwWMyokYhwzh3ND4moY/
         weS3OEE0Kji4mKge3Yid4t6k+jujD1MhNQag1LmNOtvWwV7vkjFxo2duEBf/FfyE4aTq
         0R75mpU43oVS4RNy2MD0iQWIp5PrZrO+03MAj6I8E25kd/fGADokFuecyqZ/xtp+EsHo
         cb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730962051; x=1731566851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4sYJYVbNn+8nZHewUYqHaSq6iJqGNPs8Z77SlmIpAU=;
        b=O4vV2gf8xC8qtbV9wXO9fzrnWyCJ9f7FziXFG/Xnv/t+c6tHmplT0Agq+AunmVuZqD
         0ZlHzv8J/8/t9zpE7kAfVqs7AX/BuNshBBWOmiEsdDFy5J84RMe0V9+tHH21dO0xlizK
         ph91bcRWUaMzcvBnOiFQr81gT2RDl6QZN4+cg/xaQJWGCQpv0GmbbXcAjKWZ7Whs+cDY
         Erw6/GBbPEaiGIbiNy4NFWpHsXP5Fh57TyvcQJvMPkiXCx8wMcyde15osL0daR+QxQpl
         de7CqkuC9l0rRt7AnnmPD4c2mWC2BO7jrcpEng4/euz3vtlCVjasGZBmPHQhWLbi3sQ6
         6/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3TnvdXp7Wee69eskpeH4a9XqkooTyEMaWkYiuncAJJKTGebgSaQrSRkEmrS69QfZ5VnWykWyurVkOJVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMjUzNrJ5pA8RZfoK2bKAeGHUvff/n42kTtpA2Mi2vIwL/GzT
	/hZspOuGGCntu5KFItJiaxMZiLhYakgss8WbAJUu1vTmDHxH3i5za+FfkxjIb6c=
X-Google-Smtp-Source: AGHT+IGp00cwnqhnTxAKDFFNKj94JDLmBpGJ7s9/Sh6DkVmQYzY5A32qRipE+c1ujUWd9JYadTCp2w==
X-Received: by 2002:a05:6a00:3917:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-720c9990c4amr28075226b3a.21.1730962051155;
        Wed, 06 Nov 2024 22:47:31 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078ce169sm722303b3a.86.2024.11.06.22.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 22:47:30 -0800 (PST)
Message-ID: <356ef11a-02aa-4661-b8af-4c72cef5c9b5@bytedance.com>
Date: Thu, 7 Nov 2024 14:47:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
 <5969f498-a515-4394-a2b6-5d3abe2872aa@bytedance.com>
 <ad882462-0ae9-4ca7-bbf7-7728de71c422@lucifer.local>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ad882462-0ae9-4ca7-bbf7-7728de71c422@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/6 19:28, Lorenzo Stoakes wrote:
> On Wed, Nov 06, 2024 at 10:56:29AM +0800, Qi Zheng wrote:
>>
>>
>> On 2024/11/5 00:42, Lorenzo Stoakes wrote:
>>> On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
>>>> On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes
>>
>> [...]
>>
>>>>> +
>>>>> +Page table locks
>>>>> +----------------
>>
>> Many thanks to Lorenzo for documenting page table locks! This is really
>> needed. And at a glance, I agree with Jann's additions.
> 
> Thanks!
> 
> Will be respinning with all comments taken into account relatively soon.
> 
>>
>>>>
>>>> (except last-level page tables: khugepaged already deletes those for
>>>> file mappings without using the mmap lock at all in
>>>> retract_page_tables(), and there is a pending series that will do the
>>>> same with page tables in other VMAs too, see
>>>> <https://lore.kernel.org/all/cover.1729157502.git.zhengqi.arch@bytedance.com/>)
>>
>> Thanks to Jann for mentioning this series, I just updated it to v2
>> recently:
>>
>> https://lore.kernel.org/lkml/cover.1730360798.git.zhengqi.arch@bytedance.com/
> 
> Yeah I need to read through a little bit as I was unaware of these paths (mm is
> a big and sprawling subsystem more so than one might expect... :)
> 
> Could you cc- me on any respin, as at least an interested observer? Thanks!

Sure, will cc- you in the next version. ;)

> 
>>
>>>
>>> Ugh wut OK haha. Will look into this.
>>
>> Thanks!
>>
> 
> :>)

