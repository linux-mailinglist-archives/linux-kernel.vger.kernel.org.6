Return-Path: <linux-kernel+bounces-275642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0F9487EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DB51C21E70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265AC41AAC;
	Tue,  6 Aug 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q1iF9viv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE85184D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915094; cv=none; b=atWkqdkCJgPfBqR44WXZnvcd/+W4Z4YExRWhqZVkTSCu4RGwZ1WeMZc79tjKuv94EZN0vdgQoVX1j1ENv7G7vcychfpVmimVnYLzFTxhTtrWJM16fVflGPf4Lf4ypyNpBdNqudtCSWWSa+OQA/HIUVurqCbLAslPTXO5AzrNS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915094; c=relaxed/simple;
	bh=SvuoSmChBOHGdTLubBOmex8R46e7cVvpPusA8rmgPfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDS9Gi07ZzwG+CJlkOnzi957heHOj3crBArWPTcw5OMT6xbtggzwQYSbxmvNy5TjhV+oUuqavWK0w5SzPv9/8zBbQswAZ1+m9rfChNhTrMWy1DgrwUa/o4TIRm7A5aSKVa7BrlhS5gKGr6UUGLgcwVkA1oQf0xK0f7bipgAaHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q1iF9viv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2879bfb0so64635b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 20:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722915092; x=1723519892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2JoVlyDoUX2ysalhvEPxZpeuSvjk1cVm0vV/c3XfoY=;
        b=Q1iF9vivFCERseQEBSHD0Y/P1NHdjGNFqIZ4vtEdna2nBs98PiXU0I/A4WwtqnEGGY
         eoF0PFybLnD/EZiu0spPcn9pQY/UfjgGEGbc8unRbpSXISWZV8IQSdWJziT/ycQbaoKy
         e/rZZwsGABtZWQq8/0ChnfZwxOdRNuRXKNmZotJKpdfdc5Y5ELWXmIBAoG+jG0GXQsXW
         m4bMUBG7/bl1zv32Ili7UQEGWK6YPp2n9LMc68MMavqSnhY0mCQObvNA6ChS3lPwI3+p
         Zd6HR9kGqnBNtUz7Rgg9zc5vYvd7N8jkAewJdiuy6FBxI2veC7e1CQTLLmiucsRIb3il
         scNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722915092; x=1723519892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2JoVlyDoUX2ysalhvEPxZpeuSvjk1cVm0vV/c3XfoY=;
        b=bq8HbYhygpBai6T8QqF1MezAtiI7zW8XPMZpHrXLk6Z9bx0+jDqPq15qKVP5eKJk9T
         kbeI7HHG05nhOZIjhumv8IP1B7+zZvJwdk76RKb8HqFuTqhS16oStXQ8m+zEw7+4/7d/
         9ZY/3BtHoUM7IxScmGUsFKiljx8QfdjZkLyrkIJn4MGR+wsdBxq7dw38aq4WqH6PUq0V
         vLqBxaWDXMN8GeUFn9/WR48kr43/n3NGwgk9/rBLbbZRtIjQ0kjx+dmmW+VMNrq50jfd
         NEJL7YP7bqdg5kIHJVKVsYI1JZVvr/AE2cmwGcfQcyJl7sbQZfFDSbFpuX75k2uTTxrD
         sy4A==
X-Forwarded-Encrypted: i=1; AJvYcCVWSR9sKRpWVrCkP/Hn1V9Qkpg8GeZAK41ct6F5eZoBRuy1Grfm6rF5m3k5vv42zNuXQXMJgziY8zqecw2N6yejiHvhxfJLGFz3wmPH
X-Gm-Message-State: AOJu0Yxf/iw6ZHRd3aG7UpVJ+bSIhafLQmslx1Qc1oMMXLrx3W3Yfwbl
	VzL0eiHlFCQhWZHIB/3CZz0F+tP/OvZXQ+pDVqcKLBeR5XMPpIwJyM/oQ1jlWVc=
X-Google-Smtp-Source: AGHT+IHjB6AScazUkHn0BP4teSXOlloTlQqOI/0QMlJZDjNnp/apIsyvye9E1r70/giw8p0Wt63YyA==
X-Received: by 2002:a05:6a00:3993:b0:70d:1048:d4eb with SMTP id d2e1a72fcca58-7106d07ea82mr10721161b3a.3.1722915091824;
        Mon, 05 Aug 2024 20:31:31 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed0d462sm6330616b3a.174.2024.08.05.20.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:31:31 -0700 (PDT)
Message-ID: <bf9f79df-4821-4053-a1e9-f054f2ca5734@bytedance.com>
Date: Tue, 6 Aug 2024 11:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] synchronously scan and reclaim empty user PTE
 pages
Content-Language: en-US
To: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 2024/8/5 20:55, Qi Zheng wrote:

[...]

> 
> 2. When we use mmu_gather to batch flush tlb and free PTE pages, the TLB is not
>     flushed before pmd lock is unlocked. This may result in the following two
>     situations:
> 
>     1) Userland can trigger page fault and fill a huge page, which will cause
>        the existence of small size TLB and huge TLB for the same address.
> 
>     2) Userland can also trigger page fault and fill a PTE page, which will
>        cause the existence of two small size TLBs, but the PTE page they map
>        are different.
> 
>     For case 1), according to Intel's TLB Application note (317080), some CPUs of
>     x86 do not allow it:
> 
>     ```
>     If software modifies the paging structures so that the page size used for a
>     4-KByte range of linear addresses changes, the TLBs may subsequently contain
>     both ordinary and large-page translations for the address range.12 A reference
>     to a linear address in the address range may use either translation. Which of
>     the two translations is used may vary from one execution to another and the
>     choice may be implementation-specific.
> 
>     Software wishing to prevent this uncertainty should not write to a paging-
>     structure entry in a way that would change, for any linear address, both the
>     page size and either the page frame or attributes. It can instead use the
>     following algorithm: first mark the relevant paging-structure entry (e.g.,
>     PDE) not present; then invalidate any translations for the affected linear
>     addresses (see Section 5.2); and then modify the relevant paging-structure
>     entry to mark it present and establish translation(s) for the new page size.
>     ```
> 
>     We can also learn more information from the comments above pmdp_invalidate()
>     in __split_huge_pmd_locked().
> 
>     For case 2), we can see from the comments above ptep_clear_flush() in
>     wp_page_copy() that this situation is also not allowed. Even without
>     this patch series, madvise(MADV_DONTNEED) can also cause this situation:
> 
>             CPU 0                         CPU 1
> 
>     madvise (MADV_DONTNEED)
>     -->  clear pte entry
>          pte_unmap_unlock
>                                        touch and tlb miss
> 				      --> set pte entry
>          mmu_gather flush tlb
> 
>     But strangely, I didn't see any relevant fix code, maybe I missed something,
>     or is this guaranteed by userland?

I'm still quite confused about this, is there anyone who is familiar
with this part?

Thanks,
Qi

> 
>     Anyway, this series defines the following two functions to be implemented by
>     the architecture. If the architecture does not allow the above two situations,
>     then define these two functions to flush the tlb before set_pmd_at().
> 
>     - arch_flush_tlb_before_set_huge_page
>     - arch_flush_tlb_before_set_pte_page
> 

[...]

> 

