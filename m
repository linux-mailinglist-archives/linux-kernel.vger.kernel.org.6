Return-Path: <linux-kernel+bounces-380904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CE9AF797
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ADA1F22CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBB818A93F;
	Fri, 25 Oct 2024 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A4w7vVqz"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC83158DB9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824238; cv=none; b=b3nkvdnuHVoL0jJY0ygDzD4BOw3lw9YO+cu/WXyOX+yQKyMFCLfq1AzJHv9vIGf95xz0dhV5OIguk75kSi/OHr+RBBz++NPgdQsjl8L5Wh7YV2Gp3C3rGm0oRmPX7nykiqWYuYrHUYq9oA2KffRw+Mih6CitVyHihy/noyJITjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824238; c=relaxed/simple;
	bh=ZSeNXSxDZsbW+heVdlAUkFpDFHDGfVxgxGCCfl/iRI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD2DMqFy+Tle0ZYagINas3IeiqyMrUER1TEaifDb+rNsxpflf48CiJaGLoT3VY5hBVmZFVdMqTweHJys7Oa6SebXn4LgSDSF9PHon8jSn5urKO8RXdRAj2BzCSzu0y11Mt5EDj3uIyCxwT7vOT4Brd8RxWo2X2ZUtCzRPapkC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A4w7vVqz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c9978a221so15344695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729824235; x=1730429035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NS8TN/FyHs7Xg5AbwP+wxkRyw/n6EluIDzhX1W904yE=;
        b=A4w7vVqzs8RDws8H2BG9A9uazpuPUH8HGIqJGhTx/51dag6ky9BNclfhZ8Xv8LIE1D
         /Cu1dnmG/Da9ADMxPhtyARekD9KjNnTZO4lWymC5Br6Wk3S4OfC2m1Hq8JiHPXCk79R8
         ON+BSi38uZGb8T4nnZqHUDjfejB2ZqvNmwQR0Ry73PoXdVnGTCLLuWq27un4VxDxyQr4
         6CIBB8mUMUq5nSmO8THz5ZJYrU/UQxkxOKJtLc044CubyO4Kty/7AZevz0n3aOGf573+
         zx2edgvaDfzHXusMyaV0VrBw6E3L4m2DfdfzwaB9dsSer9Y7CcuerOFxuQ19xb4/K4oi
         rY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729824235; x=1730429035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS8TN/FyHs7Xg5AbwP+wxkRyw/n6EluIDzhX1W904yE=;
        b=fuXNjRbCgiajxkx/SKP1fxWvR+ldKRnkT1OTUEkRDThd0yUYrqXpR+8tu3/657Yboq
         +QK2hjV7KzGKBiJpipdlVAGQHAjLWTxXqUthMGL9HctE9xsV3YveylEAQC162rwH852I
         Qxptjcxz6qBR44VW0kcaTH5/w9NArf/fOUFTmp/gwMY2rWzam7HKIjLv86obDaetPWbl
         Lc7PRQdfslB2oViaiqRnyhwrfSfJb8iG6SRK5lyJOgPAbTXVOtEkO9+3iFnQDpWkva0K
         QBzOtuN4X70tKaeY8OpXzBS/+tOivinuJlxtgkSXyT2DdKsp5NqGoWpYuGyy8vrGO07M
         hT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2nHbrpS6BAjb+3ytOnOv6xU09B1AIPIP+5yRRXj5IgKtzddfz4TiVQCmx10AfT+7CP3mIVAmdZOWcy+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjiogGX2W5AGE+CEB5ZmWVOF8eR9eNflRcLeOnXSOgplz88xs
	GyWG/+cYWmkUKUV1BmamWgt3Cxv/TyFO7Yeq1b77J1hKI2zxD+jHryRly7/dX1g=
X-Google-Smtp-Source: AGHT+IFNqnHChyBRrv8DZcRHKNKvmuEqDjs3FD7U8maZSSNy9k8Qf2nm2fSTpENkFBRXGrHZ0Nflqw==
X-Received: by 2002:a17:902:e5c7:b0:20c:be0e:d47e with SMTP id d9443c01a7336-20fb9a75cafmr60398045ad.56.1729824235385;
        Thu, 24 Oct 2024 19:43:55 -0700 (PDT)
Received: from [10.84.149.95] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0445a3sm1188145ad.237.2024.10.24.19.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 19:43:54 -0700 (PDT)
Message-ID: <f18d39a9-9d81-4435-b4bc-b2dc3b6a74b1@bytedance.com>
Date: Fri, 25 Oct 2024 10:43:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
To: Will Deacon <will@kernel.org>
Cc: Jann Horn <jannh@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
 <6c7fe15b0434a08a287c400869f9ba434e1a8fa3.1729157502.git.zhengqi.arch@bytedance.com>
 <CAG48ez3MLMXZvkbPGZ4He2+tnOSHYxA68Sa1Hd_70-3a8K++=A@mail.gmail.com>
 <20241024132101.GJ30704@willie-the-truck>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20241024132101.GJ30704@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Will,

On 2024/10/24 21:21, Will Deacon wrote:
> On Thu, Oct 17, 2024 at 08:43:43PM +0200, Jann Horn wrote:
>> +arm64 maintainers in case they have opinions on the break-before-make aspects
> 
> Thanks, Jann.
> 
>> On Thu, Oct 17, 2024 at 11:48 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>> +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
>>> +                    struct mmu_gather *tlb)
>>> +{
>>> +       pmd_t pmdval;
>>> +       spinlock_t *pml, *ptl;
>>> +       pte_t *start_pte, *pte;
>>> +       int i;
>>> +
>>> +       start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
>>> +       if (!start_pte)
>>> +               return;
>>> +
>>> +       pml = pmd_lock(mm, pmd);
>>> +       if (ptl != pml)
>>> +               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>> +
>>> +       if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
>>> +               goto out_ptl;
>>> +
>>> +       /* Check if it is empty PTE page */
>>> +       for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
>>> +               if (!pte_none(ptep_get(pte)))
>>> +                       goto out_ptl;
>>> +       }
>>> +       pte_unmap(start_pte);
>>> +
>>> +       pmd_clear(pmd);
>>> +
>>> +       if (ptl != pml)
>>> +               spin_unlock(ptl);
>>> +       spin_unlock(pml);
>>
>> At this point, you have cleared the PMD and dropped the locks
>> protecting against concurrency, but have not yet done a TLB flush. If
>> another thread concurrently repopulates the PMD at this point, can we
>> get incoherent TLB state in a way that violates the arm64
>> break-before-make rule?
> 
> Sounds like it, yes, unless there's something that constrains the new
> PMD value to be some function of what it was in the first place?

Thank you for taking a look at this! I have tried to detect this case
and flush TLB in page fault. For details, please refer to this RFC
patch:

https://lore.kernel.org/lkml/20240815120715.14516-1-zhengqi.arch@bytedance.com/

And more context here: 
https://lore.kernel.org/lkml/6f38cb19-9847-4f70-bbe7-06881bb016be@bytedance.com/

If necessary, I can rebase the RFC patch and resend it.

Thanks!

> 
> Will

