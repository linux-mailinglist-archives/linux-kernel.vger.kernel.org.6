Return-Path: <linux-kernel+bounces-284163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51094FDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9991228471E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81145364A4;
	Tue, 13 Aug 2024 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fEc+60W3"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54864206A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529953; cv=none; b=n7+S09VrdygfD7OM09WuKw6Z7n6qrevvGqMDNzuMfe8ezup5ZvT/IihOcn4Il1knl+tLXIblabnOjlXGepPgglBpGzS6gQOPIdMZFyEj2dkHJ/Jv3JGkOsK/8ISTfroUDwSnbWe66cM8y1qhvUoZT9JezS5Ekw3IJJqhfgQdkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529953; c=relaxed/simple;
	bh=r5fTpr76zvhVkX7Maf/chSQx966AEmRYTENMUBVUsKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhnMEn9vkFmBquR18MMSTSlAfTRXYSZHdLBELOR+E6bzdudpb2j5A5wlfSIb0OhUHd0TI3h87WQkX7rY9NgLPV1duUQf5VacRzDc1sn/7crAVrd4OtHO1pU8Hf4v1FGteIoV3COFlVIejk/AqRbaa4p3NOGiAkvhkryO41u6jS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fEc+60W3; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db165f8211so462012b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723529950; x=1724134750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+o8W6KPeD+G2pxc/u4nbSNGQ5xQMtPGfIV7k0oCYAhI=;
        b=fEc+60W3gVai8wbM3w89gsITBYBTVBIMdQNyabzeCDQqxo8Z81lDlUOAa/oiScCfbE
         CaO9VGK3M99a2vcucO3SakAy53i5YFXY9CG0SoX3WBcQuoTeDiOBBh+8//S7cJpiKgcc
         EHw0ODf5dOgCUIfraYwOfWmg5A5vkjKe2WAgStOsJj6azMUgihVUOJjxCh1lF9CuDT3v
         y38ik/Y4ydOhvhFiNPMWkSB5pTnPMtFsQSbrWASU8lvKnhJSjGdN1B8l03y3RMhoAi5B
         w9DAqZE/yfsWd2YevHH7NMLb1Ztd5RSQGf6yGLJZkHXuZAjh7Va/PSKHqgsIaas1JWTX
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529950; x=1724134750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+o8W6KPeD+G2pxc/u4nbSNGQ5xQMtPGfIV7k0oCYAhI=;
        b=S/999NQBkhr0BCiGQX2LllsTgm1iAKBF4jBHq8LDo5BW/QNBJN5F73M6R+SUZQRQnW
         DHpkkTyPwfewh6pW9zx5ahqDaM3VdmNSV6RWdw5inQrW9qB0PwYQs4sKRAQCXjLvH5sW
         Z/KCd25/EHuoVXmQj5NmYtVv7V+vUgPoNC3GuB4+FI7ayQElJKN4DkO7ZxmHYclbvoc4
         Z6fnF67c+8m3OyyQL100tyTevfnzPkdAvee75hyGder2zwixV8JJ9YBb/3tVg5Z9FEAR
         Khvdj9/uUBHB03phFSBhwtVFwN5tCjlxa8VQq5f7OEk9nr4QFAZlGdkn8oBJ5GKcehkE
         Z5HA==
X-Forwarded-Encrypted: i=1; AJvYcCXChGdSiJcf0MCsdehNlUQ+55FVlbIwtCYIEtZoKd1ib+q5QBODMwq3bt9Y7+h3rOLk8LDBt7sYmoQltSrQB7uXzBlMzNZNIKgY9M/j
X-Gm-Message-State: AOJu0Yxla/dX1KUYjZrxm3kxm+YGV0Z35kYGikPmqOOxyZ48u40hYr3n
	1lO5EshK0HTnWgbhAviXWNSQRxNGYDS2Lln29wNcNO8hPkYshmffg4HDLdCettE=
X-Google-Smtp-Source: AGHT+IHGJ1A9lPbrXqyoEtuy+hO00+nCxFh6Lqpl29dwj8QJ4q9buu50xBdbJQRHjMyls0g/qp3ZqQ==
X-Received: by 2002:a05:6808:981:b0:3db:15b9:f29b with SMTP id 5614622812f47-3dd22ce96bfmr672305b6e.5.1723529949825;
        Mon, 12 Aug 2024 23:19:09 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a6c6e4sm691042a12.80.2024.08.12.23.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 23:19:09 -0700 (PDT)
Message-ID: <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
Date: Tue, 13 Aug 2024 14:19:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jann,

On 2024/8/13 00:42, Jann Horn wrote:
> The following race can occur:
> 
>    mfill_atomic                other thread
>    ============                ============
>                                <zap PMD>
>    pmdp_get_lockless() [reads none pmd]
>    <bail if trans_huge>
>    <if none:>
>                                <pagefault creates transhuge zeropage>
>      __pte_alloc [no-op]
>                                <zap PMD>
>    <bail if pmd_trans_huge(*dst_pmd)>
>    BUG_ON(pmd_none(*dst_pmd))
> 
> I have experimentally verified this in a kernel with extra mdelay() calls;
> the BUG_ON(pmd_none(*dst_pmd)) triggers.
> 
> On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
> pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
> a BUG_ON(), since the page table access helpers are actually designed to
> deal with page tables concurrently disappearing; but on older kernels
> (<=6.4), I think we could probably theoretically race past the two BUG_ON()
> checks and end up treating a hugepage as a page table.
> 
> Cc: stable@vger.kernel.org
> Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/userfaultfd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e54e5c8907fa..ec3750467aa5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>   			break;
>   		}
>   		/* If an huge pmd materialized from under us fail */
> -		if (unlikely(pmd_trans_huge(*dst_pmd))) {
> +		dst_pmdval = pmdp_get_lockless(dst_pmd);
> +		if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {

Before commit 0d940a9b270b, should we also check for
is_pmd_migration_entry(), pmd_devmap() and pmd_bad() here?

Thanks,
Qi

>   			err = -EFAULT;
>   			break;
>   		}
> 

