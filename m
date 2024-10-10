Return-Path: <linux-kernel+bounces-358187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E45997B31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D8F2820C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211F18DF76;
	Thu, 10 Oct 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOoK8An/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E48139D07
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530573; cv=none; b=YOFNXA7ZhCAxv26Nij9Rpm1yfBru4DwlL/zw4B3SJiaQjjmit1556ZGiXEOO5BvfnDmbS6N1F4yrNaO1KyXfqiqmeu2wuP4BBrN38EXVvaOaj454NHSxGym4lgHxYA3sRh6bM9q9VwWQUdGRm8P04ZHlSONKvkMRGadKHnDy9Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530573; c=relaxed/simple;
	bh=d2TwhEqGF+kG+LqcPfs5fjAoaj49eTRwEEuDpR/HcHA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=li7WDF6tvgeS5YGsZEzvmwLDaJMxVSkW8FGV8RB610/6slBxyHlyUDGnHyfUHE4vI+YfwJsqxcJoFCNBRcvuS4HIUYDtn8RHADG3XAo253Z0TGEY+3jVu3GBz3voOP3eBB1rShZS/q3og7CX7v52VrBmEIuLOcDvTIoDgWeqrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOoK8An/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71df2b0a2f7so435369b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728530571; x=1729135371; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMGHgPkDyEzZscZF6jcbqFePhT4l3FTSkWuwbpzJ1+w=;
        b=eOoK8An/l4u8pjW9eSur4mJb8IL4yvZU45dvvS7tYYPfGC2u8ACvALv9BJcwajCCy1
         TJWuq7nY9f10f1nXCEGW4G8FXNjZHbYgxwmxgrWF95s24eD8+y69oyvSNnAGuAvN+eC4
         x1q6Jf/G5XnVoLEBT5blEHVxRoYdnVhQ/Gyegcbx3bSXnfCpTSw1ch484QMt0KUugnoC
         hTuAJ1eZO4jn3dCgxQkdYgvE/4GA4aaDKkIUVCo8yjuXka2/5TUNfNV7nP15TbaoHJnQ
         j+C3k9K18QnjS3xRM84kAJKi3MukOJsdSz2SV7A64XBdovpF2DSvjqxvqIc9OjAn+J1N
         Cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728530571; x=1729135371;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMGHgPkDyEzZscZF6jcbqFePhT4l3FTSkWuwbpzJ1+w=;
        b=COhvTTwR3nWpXV9uifRTGLB6IuGqckp75FqzZwKruU/aI/+pKyxP7+rKoz0ZLSNmQX
         5VBH0gqFJ5BX1hZLBkX0D+X5HywZ6tlrsEsHFcSAL1jBT0pIsN5+Eys87Yb1LJ7vGMtq
         tffoJuFwmJzqJfViTg1oT9xV1ceFgnONXf+Oaq5VmlnaQClgM8JmqEpKIef5Wqdabz6n
         igPDH9JV07AcjUtn9/eG2eAwj+bfqXhdohZCRnLx939ocXZEx/9ELJDwVLFQRyv9aiwB
         ujRDNirheMe1RT+kVoCmsrc788Va6j+3rmOsSkN3tad9QG9XYvafAeZQK64q1Dw+pBeP
         I8BA==
X-Forwarded-Encrypted: i=1; AJvYcCXHh9xwgqT0UhPVnkXIWFXoaz9Pv4ufT5JQGlgBFAd28fLWlJnyfLXW9TsksrIOdyp9RYWeFURdp9VdUmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcMHNY4LcbzInwb9gT5CIOSySDDDO2JH17z4xhuS1Mrty8UIQN
	FntOvp8KgcL6lcjSWRR4kOoY4c9CaTTY5qVUnGc/WGAsWMgbR428AXq06g==
X-Google-Smtp-Source: AGHT+IHbBrqfu0Zcv35UYFiQjcDYlwOYSZxjVbr4xyKtGlQh0hDzWB/1JzAP7WH7yyIXJjNQGa33AQ==
X-Received: by 2002:a05:6a00:2292:b0:717:87af:fca0 with SMTP id d2e1a72fcca58-71e1daadf11mr7065478b3a.0.1728530571070;
        Wed, 09 Oct 2024 20:22:51 -0700 (PDT)
Received: from dw-tp ([171.76.87.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f54b4sm157141b3a.73.2024.10.09.20.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:22:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC 1/2] cma: Fix CMA_MIN_ALIGNMENT_BYTES during early_init
In-Reply-To: <83eb128e-4f06-4725-a843-a4563f246a44@redhat.com>
Date: Thu, 10 Oct 2024 08:49:20 +0530
Message-ID: <871q0ofxvr.fsf@gmail.com>
References: <c1e66d3e69c8d90988c02b84c79db5d9dd93f053.1728386179.git.ritesh.list@gmail.com> <83eb128e-4f06-4725-a843-a4563f246a44@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

David Hildenbrand <david@redhat.com> writes:

> On 08.10.24 15:27, Ritesh Harjani (IBM) wrote:
>> During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
>> since pageblock_order is still zero and it gets initialized
>> later during paging_init() e.g.
>> paging_init() -> free_area_init() -> set_pageblock_order().
>> 
>> One such use case is -
>> early_setup() -> early_init_devtree() -> fadump_reserve_mem()
>> 
>> This causes CMA memory alignment check to be bypassed in
>> cma_init_reserved_mem(). Then later cma_activate_area() can hit
>> a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
>> area was not pageblock_order aligned.
>> 
>> Instead of fixing it locally for fadump case on PowerPC, I believe
>> this should be fixed for CMA_MIN_ALIGNMENT_BYTES.
>
> I think we should add a way to catch the usage of 
> CMA_MIN_ALIGNMENT_BYTES before it actually has meaning (before 
> pageblock_order was set)

Maybe by enforcing that the pageblock_order should not be zero where we
do the alignment check then?

i.e. in cma_init_reserved_mem() 

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..36d753e7a0bf 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
        if (!size || !memblock_is_region_reserved(base, size))
                return -EINVAL;

+       /*
+        * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
+        * needs pageblock_order to be initialized. Let's enforce it.
+        */
+       if (!pageblock_order) {
+               pr_err("pageblock_order not yet initialized. Called during early boot?\n");
+               return -EINVAL;
+       }
+
        /* ensure minimal alignment required by mm core */
        if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
                return -EINVAL;


> and fix the PowerPC usage by reshuffling the 
> code accordingly.

Ok. I will submit a v2 with the above patch incldued.

Thanks for the review!
-ritesh

