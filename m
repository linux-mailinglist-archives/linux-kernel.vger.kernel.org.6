Return-Path: <linux-kernel+bounces-555422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C501AA5B727
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEED7A6F29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71721E9B06;
	Tue, 11 Mar 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i51NPrzw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B661EEE9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662900; cv=none; b=mAG/W5TvM09GXvYB/xICM9QerBE9Q8jPUHZSyp/1apt4RuysuXxDxMQ3XXfk169F6HoTqFF30qZNUVqF0sOxmD5SIlxQgfh1vf0Z1fGdlwxRmbeJUyMLDV6i4burxCBFsWN/Nh5LIR7lq+jw8YIIrPUyvaPsE3sQeLyRwW9sGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662900; c=relaxed/simple;
	bh=5mIE7lS8AyPyy7uaL63XdXT8AAfNeiZUVuClajiuviU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P77r4cKP9V2oBF+FZl2qwKSawF7cpyMHYN6pvB9yeCO9fUo/pNrGR6AVlb0O21XimnX33Bd8auP2fj5okjrHPauJ83RSVdQcnUGBc6CVBM9cRkt5eF9sH9oqs2wshNVWdf1vm7qaRJ4VRdDVgNEgtMCKRVzkuRf1TVdYofH33HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i51NPrzw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22334203781so106322435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741662897; x=1742267697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wDXyh3P+UpPlg6mVwHIWa2aSvvn5//xRxBhxTz/PLk=;
        b=i51NPrzwuK1Kl+kDeETc6BVVCAh/c0JwGI9+ujCoVp0MZ11T8jiJZSCyXTClZFvzwt
         GQWeqNOQFV/RYxGjHSsvKQb5wtjnUD7NuE3A/mVJfVU1oXwGALbvmrwh5WYKUtdJZwQP
         Vp5WKkp1w2f04ZPyTlOV2sAuI1PN78QXuEz8pVrXpoITxNVUTAGIFl+Kpg21w+iPd3fW
         BVPaYtBNqpGjUpHSENNTpPjFU02+VjK57UkcjhcdneFAUO/3V5WMtfcwQv5YwjCujSu4
         ihNBjPfExBu6vZ5NDMEH/i3oEQ2uC71ILcPFSKH1aMo0JtRTNychoLPT+XETCJQk2Nh4
         5gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741662897; x=1742267697;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wDXyh3P+UpPlg6mVwHIWa2aSvvn5//xRxBhxTz/PLk=;
        b=H5l2R17DuprDaEzaEFvjt8kfbVfQSjVr5cDAcmoRcE9yts0aSAi75XZmmtJ7bcpmGA
         LTNn9l4XYSQ7li42O3xlzeiMxdQeunzY2ve3X5aJL7ffwlC/OSGFtoiecEspXd5NXFMY
         oInrN6Inp19DWVGQfCyNFKiy+YcwbIBxTPs+kyCjKBMtPmGHY9jgYLCmBNPkKo4HrNGD
         Qn3WaL5Tv8JJL2e99xCvjhZGzgNC0cNI1smsYy1od9PhistmcntjIgTtsGjhEFX7AO/l
         L0F1eJ5I1aQtJfRAZJhUEKFuLQwZn+Nls2ZW9S0M6k9ExfGVSJBnNh1MQ/W5eOdfqsQZ
         5oNA==
X-Forwarded-Encrypted: i=1; AJvYcCUH8yrze3gkCWCxO9h8Z95AQ4AzpQ9eNKKWmpczX72hLOuXzoXXfewd4j2/JB8iSOOoScSp1vHAKPgfBRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruOmg0yTfwazU8qRXlWd2XhDtjRLE2GvSW/H6lvUcM0gNhAkg
	clh4cTpS9MeuzwP6UgaxoTtrQVSQ0irrE+v9WGkS++pKeMf3cvcdnEa4Z40BEbQ=
X-Gm-Gg: ASbGncvLJ4cWwHTc5Jm3ybCDQ//o+Tz7ZOF7iXZZK8b5tLY5wCM+W19Y1cHA5m8C8nI
	zSxQGLi4Mv8EB7aGIShJ8BbswEc9/AmynS+cgs8wW2cOcopSCEjX+s3zQIuvu/4FRRIXOgBscJT
	pSS2ft6zEAArlcgZsirkIQfHflqGrwRZqO529GTa8EXi+X9O724xw61gftgPQ+J5l6gyXfoI89a
	/wmbpQQhPPN1zIX2IXeQlvODDhOWhhbwKXlm9tjtsR4A51o+S4b6PWYxgvxL+vi3pxsDdBjfdMh
	q9Wzao+wvaQ42+lG8UxA7+8XR6GjMx4n+zHkeLw4XNuewQ53Z9QG52/p8mdivhJWn2v1s5Ohbmv
	Yx//q
X-Google-Smtp-Source: AGHT+IE4Q9xs4CVOgVWo6Vf9pcwvQqCaczrVmCXXwXlvnRH9+b8LB0gV2jtbH11midnws0hi1J+7zg==
X-Received: by 2002:a05:6a21:6e92:b0:1f3:2e7a:7320 with SMTP id adf61e73a8af0-1f58d7569ebmr2268420637.19.1741662897537;
        Mon, 10 Mar 2025 20:14:57 -0700 (PDT)
Received: from [10.68.122.90] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af50aa116dcsm6478484a12.16.2025.03.10.20.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 20:14:57 -0700 (PDT)
Message-ID: <491f272c-c626-4664-b35f-05ad12d65314@bytedance.com>
Date: Tue, 11 Mar 2025 11:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: use ptep_get() instead of directly dereferencing
 pte_t*
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250310140418.1737409-1-ryan.roberts@arm.com>
 <f0d9986d-b3f0-42db-8fb6-d6087dd77f7d@bytedance.com>
 <661898ee-c1f9-4f51-a73d-b70fe2eccd84@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <661898ee-c1f9-4f51-a73d-b70fe2eccd84@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/11/25 12:31 AM, Ryan Roberts wrote:
> On 10/03/2025 15:51, Qi Zheng wrote:
>> Hi Ryan,
>>
>> On 3/10/25 10:04 PM, Ryan Roberts wrote:
>>> It is best practice for all pte accesses to go via the arch helpers, to
>>> ensure non-torn values and to allow the arch to intervene where needed
>>> (contpte for arm64 for example). While in this case it was probably safe
>>> to directly dereference, let's tidy it up for consistency.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    mm/migrate.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This looks good to me. So
>>
>> Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Thanks!
> 
>>
>> BTW, there are many other places in the kernel that directly
>> dereference pmd_t* and pud_t*, etc.
> 
> It's all a little bit murky. For now, from arm64's perspective at least, there
> is only a hard requirement for ptes to be accessed through the arch helper. This
> is because arm64's contpte layer may apply a transform when reading the pte.
> 
> In general there are also potential issues with tearing, if you don't at least
> read with READ_ONCE(). But often to consumer of the value is tolerant to tearing
> (e.g. pmd_none(), etc). Also, in practice on arm64 the compiler will emit
> instructions that ensure single-copy-atomicity for direct dereferences, so it
> all works out.
> 
> That said, Anshuman (cc'ed) has been looking at supporting FEAT_D128 (128 bit
> page table descriptors) on arm64. The compiler does not emit single-copy-atomic
> loads for direct dereferences of 128 bit data, so he has been working on
> converting the other levels to use the accessors for that reason.
> 
> But that has some potentially problematic interactions with level folding that
> need to be solved. Some arches rely on the compiler optimizing away the direct
> dereferences when folded. But it can't do that for a READ_ONCE().
> 
> I believe Anshuman is aiming to post a series to do this at some point in the
> future.

Got it. Thanks!



