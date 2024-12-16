Return-Path: <linux-kernel+bounces-446847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A89F29E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C81668C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9821BC063;
	Mon, 16 Dec 2024 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OnddH8uZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823E1509A0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329749; cv=none; b=XQuUFkQ87NqaD9SxLx5l93lo+qEAl+38m+88tRjhEd3lKKsssNRkXtsE5WIMFVx/wtXAYq8ygfQbZQJGG2Iq2MSE07k1J7qkpycBDKc+dC+19VMbfqKiecx3viSY0xySp+jcNpSM7AoC+hfv0LzziRW9eKuhN8Qe+BrAL1Miv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329749; c=relaxed/simple;
	bh=vWo2nWJsn0/ajJbFmsgqTT69XyxdXRdQTRh0q2t1QHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UceoAqcGbhJ3Q+qoxz+Ueim+xQtLSr/bNZ3MrXl8yHBoOn7x6jGAAiQwPk4nNiXuTooAnx2EvJbROoGbnBIR9hMtWFDOAroKc1PekC24gg0mbjWgRh/M2Wqao9f46ADtm1+5kAMHlBC/sN72pr1DmCjiUZ3GAQrLVC2ghPigKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OnddH8uZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165cb60719so27598495ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734329742; x=1734934542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZHaFcgg8WCbQrkJczkX7Ejju7rkX2+k4W+KrDwNd7c=;
        b=OnddH8uZMlc3pm8W9uKxPdxuhIwtsm6wLGqbSyTGIlKtgOKCodemxc+CWfZV7MbVo2
         eAOE602ktG9oIltzZeHduVNxeMWMqxubZ73AyseZHVreEpiyftOpnERnLY4B7V9OTeSk
         wo5B9aSe19qqhT65L2CrMBChaBpTXDSCba9hnWNsTxbI5cDmOUhb7Mq6LzwxCzc63sH1
         T9O5e2+M3OnPkPPuG8LZ9jV2mwwAOF5oE5w9WAHQrAZN3jzty0DToHaRSWn2qNsBMiWV
         +vR7jlnZXPJvIYmzvdgXeZJZBVl37p1AeYF5Cgs/X14/W/eQs8aRxDJzsKxWMzlMh2No
         DYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329742; x=1734934542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZHaFcgg8WCbQrkJczkX7Ejju7rkX2+k4W+KrDwNd7c=;
        b=o6EY2c/1E4QgDTL7W+L4zJn5PADDYyCX+IqNzgFQ5t9p4RImC2fL+07D3FbWVyQm8b
         zHwHgzON8Powdkb95T/1xlMosHkyj6rkhgI7LgEWV4khEvaWTuJ1vaZy2vAw0cWHQEFH
         orRsKRvxxsYhkuDrpfhYlqDZx+xAJccWtKQ47gS3ju2ZSBBKw1P7pCXKeOkGDrTdyam4
         gcohIfnXXfeKqhZRo/P8Es+JRMwP+zD8Rkx3XFiQp/CRjy4jWUl/mNoxpA0EgX5qv+Ne
         eFeNB+pO7eAkT75EAfQt0FTTWZfUeWDu6MkzzPccH1SKGmIgXKBszlmGUQ+Jq0D3q10G
         KOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRuZr106qEBC/nW0l7DSG+ZqDAtLJYjipsoh0mJhxQ9Pi1HDFqvv5np45UFw0D2+zftivMPYFAihurBXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpcS9JFlEZbmzGnQXChxffQB1OR/10iuQQrQSG+k1FVmDnx1K
	FIBi+p1pfTtBXAAdnjatlP4gvU+jncieHnMYjfaxhN2Plt0gVsACEt83jOMd8mk=
X-Gm-Gg: ASbGncush4DebDYMffeFb9HLiGjvZ0rKLRmOdP3Gim5WTfY4L1T2+3JEUx0+z84Jpub
	tk84PjPEWrdpnykiq6WQUFHgXcC8cgpQrw1dGo76nbz8k60Dm+66v+YUBzZpdjdkIkmHeHk2Z9T
	2r9EOMsE+PIbwHXB817C45e9W7/f3V1F3fyfcwhaSPIkVx5g5VFC7EZkfdT/xUoCdsJdN9Bv02S
	8csHTsJG89OCp/Fz4NOEonZp630yjcKF2jSW8ujViy9akpUOC7mJmw+d3e3WFoypsGAr4uvlnL9
	E2o0Uw==
X-Google-Smtp-Source: AGHT+IGJmsI4675HfabTnwXVm7wgMwOIm1F4iLV8R4afvBaIcPOm2BL4Rk6INvpy0mI66c/FntNYrw==
X-Received: by 2002:a17:902:c948:b0:212:6187:6a76 with SMTP id d9443c01a7336-218929a2107mr137924505ad.14.1734329742651;
        Sun, 15 Dec 2024 22:15:42 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc7c1sm35414455ad.93.2024.12.15.22.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 22:15:42 -0800 (PST)
Message-ID: <eef6abd4-327b-4f7c-8b3f-b2552fa78952@bytedance.com>
Date: Mon, 16 Dec 2024 14:15:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>, peterz@infradead.org, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 rientjes@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
 <CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
 <18bc52f4-ab02-495f-8f8f-87f69ea5b914@bytedance.com>
 <20241215221015.a567dbf38c9a98d672aecd3e@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241215221015.a567dbf38c9a98d672aecd3e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/12/16 14:10, Andrew Morton wrote:
> On Sun, 15 Dec 2024 14:29:38 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>>
>>> Acked-by: Yu Zhao <yuzhao@google.com>
>>
>> Thanks! Once the review of this patch series is completed, we can simply
>> drop "mm: pgtable: make ptlock be freed by RCU" from mm tree.
> 
> Can we drop it now and does the remainder of the series "synchronously
> scan and reclaim empty user PTE pages v4" remain valid and useful?

The "mm: pgtable: make ptlock be freed by RCU" fixes the UAF issue [1]
reported by syzbot. If it is dropped now and this patch series is not
merged, the UAF issue will reappear.

[1]. 
https://lore.kernel.org/lkml/67548279.050a0220.a30f1.015b.GAE@google.com/

Thanks,
Qi

> 

