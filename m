Return-Path: <linux-kernel+bounces-284164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB8C94FDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E664E284677
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329B742077;
	Tue, 13 Aug 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ijkW4jmA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196363A28B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530295; cv=none; b=hPp9DwnVZNmYXz0SCo8Ey08YHpvfgJIMStUvP5Omzk1U4xGZEy5SZ0Qu36VB9QXZ8Gq6LsFo65/L5WOtBjn4esUq73e6z1tDP7kcsZgO4Y1PubrUB2mFuefucdfcFy1w1dn1NzYtt7FVvmJ/qPUdqzlMXjLormUZju+VCkabYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530295; c=relaxed/simple;
	bh=fFPDK9uODTdbP123Jk+JZHmmGHkJEY5S7b14fP2b+LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKkDGNJCXhUChyeunwnHZ/O19MtwVouJkHOFNVY72E0uaecwjfxVUShUB7nxP1BFe/zyO3lgsd9fWKtC/jmvxQtXTDyzwZNXLGQy5Fi9S3e9/Ut8NGdCsm6AU9mECQ2mxVbNrc+r7Y7EcW92kLBdCemXPGVvQqSwT2HyAAcz4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ijkW4jmA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc47aef524so2873525ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723530293; x=1724135093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vN9jGf+FzsTUtxDf0ZgtKIKQnEYaRw8xfXIl0VTvbOI=;
        b=ijkW4jmALYd0Y+GbPxLwcqpBY0U4is6lJSUxevIajJsSAlkU8ref31TgGcxHMu6Pv2
         5xjc3W5dMyZgVzmw7QCTAAay+FYYOrZmQz43qLpwiupESr6zLseY3KDRIuEseC7Hclnw
         6JGcoKOQScf1PSsy4Tjbo41v4TdBLabyHepOu+X+y1z5jHrev0OyOgozMvPxKyj62X45
         Y1S27wUBYmoZoViq3yaa5HqoTJAtz9re800mCWoKurj4TW+QniNjn5529TGZXHNSSmhs
         FcI7h61QiTos9wB17hJfVANWpr3URq0hkD3CZk8qKL9/8lmCJIkTHm32BlocKZ1Ta9Cp
         sw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530293; x=1724135093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vN9jGf+FzsTUtxDf0ZgtKIKQnEYaRw8xfXIl0VTvbOI=;
        b=EXM1RoUjp3TzHgL7j0N/LOZHXyc96qJUk11HrI4fBCCLs3ztPS+hMSLffkNXCPqbF7
         8azAgRpMBSa5vG5Vpg47cJkf8FjoybKd+aQipUEJDkUJsVDnNMSebFYXK/VY9kzichKw
         ZV5aJEzNloSS7meQQYXLJ9ZtndmwInHsjL6XVS17quq53BF+T1kLnFmh/pJmZGCQSRnu
         mAdJhAm+kHM5qbTVxqESPzQYSpCuzGcmX4bAplRSuMxvJ4kjO5vLDV/cmQX2iEckeisL
         DOZ72sArIoXxfg540h/7Nzr/wrMv6sbSHYoSZtoGBn42ng4NCXSvT+d3wJHWbZXEzb2F
         6yQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQWw49Z2iI9dkyk93qyV//SCzoxulPnbwYEFZPKo3JuOXw+rm7xVzycmLWQtCA18xkYHu22XEmEIedOkIo8ujtHOkManMNF7IuZhJe
X-Gm-Message-State: AOJu0YydxLRebIh8cAYQAWgYGtwSxy7JpmQp/QvZL2yCNMk3QN/+FEnO
	63ek8SMvxFX3RjFLPt0iyuxtorDGLuBrWL6mVsHDR/08QLkvQsvEN1YjO3dOf5o=
X-Google-Smtp-Source: AGHT+IGMaDQJcFaiMoUsAvyc0AB9V8jR85MFjaQIdtfZGEbu5FCnuEU1OAJjBP/S1GY+KHqszA20LQ==
X-Received: by 2002:a17:902:f212:b0:1fc:5b41:bac9 with SMTP id d9443c01a7336-201cdaf70a6mr8682985ad.7.1723530293345;
        Mon, 12 Aug 2024 23:24:53 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14d0a9sm6392935ad.116.2024.08.12.23.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 23:24:52 -0700 (PDT)
Message-ID: <2d8c7ddf-17be-4b09-ad99-98597d54bc3c@bytedance.com>
Date: Tue, 13 Aug 2024 14:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] userfaultfd: Don't BUG_ON() if khugepaged yanks our
 page table
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/13 00:42, Jann Horn wrote:
> Since khugepaged was changed to allow retracting page tables in file
> mappings without holding the mmap lock, these BUG_ON()s are wrong - get rid
> of them.
> 
> We could also remove the preceding "if (unlikely(...))" block, but then
> we could reach pte_offset_map_lock() with transhuge pages not just for file
> mappings but also for anonymous mappings - which would probably be fine but
> I think is not necessarily expected.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/userfaultfd.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ec3750467aa5..0dfa97db6feb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -806,9 +806,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>   			err = -EFAULT;
>   			break;
>   		}
> -
> -		BUG_ON(pmd_none(*dst_pmd));
> -		BUG_ON(pmd_trans_huge(*dst_pmd));
> +		/*
> +		 * For shmem mappings, khugepaged is allowed to remove page
> +		 * tables under us; pte_offset_map_lock() will deal with that.
> +		 */
>   
>   		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
>   				       src_addr, flags, &folio);
> 

