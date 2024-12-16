Return-Path: <linux-kernel+bounces-446861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06289F2A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486721885657
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF491CCB4A;
	Mon, 16 Dec 2024 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HLDYxIwS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093BF9D6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331198; cv=none; b=GaeIkK5Zh2DQHU1uMO6GEAhqPHx95eN0lgN4DXUWz2iA8rXZoB2pL41n81TY9Hg5skaN73Y4j0i6uQjKlm1toMepUz9i1zW8YHGCzsti1lnfdHcFwV4qw8uKEKTYJBxsLIJ5tEAEST05IkzUVR8bWDr54xcu5yDGqzfQIWaunog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331198; c=relaxed/simple;
	bh=NXtoY8k8H7Fak8g6CcIeNbiVBDIB+m47R8QChEJcEeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAo8Knzj+m8QBKxNX1bMFLiBeY64AAbzxxaxN/4+0Q/bjn0QhD88WtfgPZxRENpIiSojk5w7Gb8WkN++9LAtmu2eeLIu3Lk9qcVg08tiFRAUJKwcK7EdPV8nxCUc+mJSmxfcDIokX9ENZmQfdB/OhokO+sIGbCojUp+sUNO7ECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HLDYxIwS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so29769265ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734331196; x=1734935996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsUfWbTNDQ4yaFPn/TYgtrpZhI+saD19RlS+nNZ0YD4=;
        b=HLDYxIwSOnEh72zNpflvuizKu/koJUFJ4rlcLpRWVudkyqZn2MnuyY0Hh3fcyDjJpf
         zaWrDze8cSQVYl6UuGKv5N3/SwY8lR0Il5jA0ZxmtO+PCkIhR84y4kYQCcb2jrpdKRAg
         681W+3tBD55el2DmXdc/NC5H59vIkXHlMFadWx6MW2QxnIfs24XgsYs8SLFsae08PaJ3
         R4+YUV7nRUhxc8rYQmZ5V1yqgnplflxLAo6SZZOclTdHJxAUt2iatDAotyV9J6uOSWv8
         9aZqHs1zYP810exfyLOM/czjPpo+lmCGzVn12S28j10GqCLE3C76hdxNORhWhVbj9BFl
         UMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734331196; x=1734935996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsUfWbTNDQ4yaFPn/TYgtrpZhI+saD19RlS+nNZ0YD4=;
        b=YJYOE52DzFgrOtzrkLJOv3A1MCdBypjcI5UeEyjyq35YPcjT00n+lXmyxg7mKbKTsy
         KEwhAJEzkB0Pl32LXv6DvBI3bY91wCWZTs6x6Dy7txkaq33vQgxVa0e0Ee6kGc8UhUCP
         tmGhk41jBRQz6Dn9nIYdq0F/K7SJtwLSxjy7QpWJwRnld8IlhsT6ojRUVkCAN7DpT4p+
         xxjgEwuZp7J+EfeT2pZkcGqOS/N7b4a/P+BlTr+q/EhMuKOi+tEYSHsGgGlvkHAiQX97
         quFxSrpN4z9FtneSRiKDSwsKmFRfUP/74OsTYHEaI9urGWZDAI96t7m6bzUimdXRR3qA
         nAyg==
X-Forwarded-Encrypted: i=1; AJvYcCUkMLqqQvlcrlKtOk8tur+huoe6SGZ8CEjGhG8ojKAjNSCeLCg72DTWKgyAxJgDXb+r/ByoruhjjpgSbGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvpUgLxRfcgvAuL7ohsc4tVIFSIlm0+X2Aypi2NAR2CzPUJNf
	N+VVerUN2tTVx5738jhcGWAo7+FtMzUFOYtvy5lrZEbI0g/9fwlzTcWfW92x52s=
X-Gm-Gg: ASbGnctcChqJjnPWUN/K+f5kYwCvbLWH3Du1QHn8LA3X123v8ZUDxA7tk1WX01sDzOk
	j8924kRGJAOyk1LyjvwMEXmQWxnpoyKCjQuU/g4Ayz0weZyfJDzCHiM1qy1JA5Cywf6JBvIFWoT
	JKd1Yb6nM8vSCWF4eiK8t78E4YtM10pTGryuFkxk+LP5BiRIggEqLH55gsRkk3c4DJPdaO1K+zf
	dZVN44swBbuL0O/itJSIavX++tGMvGDdYqFc1Bk0Rwqj7UoRcKjRf5rPxOjs7rVgABmUe2wFiiU
	zi8ZoA==
X-Google-Smtp-Source: AGHT+IFK8tHks1060uI+RlBcJzj+l+NfvGE63CRO3BmWHumrkl7Xwy7dLiLBN2q3bFaz9ROllDdddA==
X-Received: by 2002:a17:902:d4d0:b0:216:5448:22c3 with SMTP id d9443c01a7336-2178c7b66d1mr185878685ad.6.1734331195774;
        Sun, 15 Dec 2024 22:39:55 -0800 (PST)
Received: from [10.4.194.102] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d7c5sm35569345ad.199.2024.12.15.22.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 22:39:55 -0800 (PST)
Message-ID: <6584dc86-dadf-4a30-9da0-15eef253ce22@bytedance.com>
Date: Mon, 16 Dec 2024 14:39:48 +0800
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
 <eef6abd4-327b-4f7c-8b3f-b2552fa78952@bytedance.com>
 <20241215223542.2b8e45a7d68f6ebc71b5ce3a@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241215223542.2b8e45a7d68f6ebc71b5ce3a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/16 14:35, Andrew Morton wrote:
> On Mon, 16 Dec 2024 14:15:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> Hi Andrew,
>>
>> On 2024/12/16 14:10, Andrew Morton wrote:
>>> On Sun, 15 Dec 2024 14:29:38 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>>>
>>>>> Acked-by: Yu Zhao <yuzhao@google.com>
>>>>
>>>> Thanks! Once the review of this patch series is completed, we can simply
>>>> drop "mm: pgtable: make ptlock be freed by RCU" from mm tree.
>>>
>>> Can we drop it now and does the remainder of the series "synchronously
>>> scan and reclaim empty user PTE pages v4" remain valid and useful?
>>
>> The "mm: pgtable: make ptlock be freed by RCU" fixes the UAF issue [1]
>> reported by syzbot. If it is dropped now and this patch series is not
>> merged, the UAF issue will reappear.
>>
>> [1].
>> https://lore.kernel.org/lkml/67548279.050a0220.a30f1.015b.GAE@google.com/
> 
> OK, so as I understand it,
> 
> - the series "synchronously scan and reclaim empty user PTE pages v4"
>    exposes a use-after-free bug, and fixes that bug with the patch "mm:
>    pgtable: make ptlock be freed by RCU".
> 
> - The series "move pagetable_*_dtor() to __tlb_remove_table()" fixes
>    that bug in a more desirable way.
> 
> - So when the series "move pagetable_*_dtor() to
>    __tlb_remove_table()" is merged into mm-unstable, I drop the patch
>    "mm: pgtable: make ptlock be freed by RCU".
> 
> Correct?

Right!


