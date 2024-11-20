Return-Path: <linux-kernel+bounces-415157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21C9D321A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BAC283FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112981E485;
	Wed, 20 Nov 2024 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVFp3ufX"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60727447
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068868; cv=none; b=KSdOjX3aJPRPaBkWQvDACISHZEhsImowLVf89Zre+6F1gsG2PRTyH77wUe5mbFZiryRCAbOoXicgbtNXLoX9h75e3liF3q9G++xTE1RMWe4bBk7m7ibtwIl2KLB2hKXW14zkDGArDjiZPHucr4VFqb7Vax0m/au0T1N2/eh3Mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068868; c=relaxed/simple;
	bh=Zpf7ID4DWt4Ihn9/JNAQsyosrVGQE8NmSLKdTOK1OKw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lsxX9Nr4bd7fWwgl0FYM4UK1y+xgxZZgU+fy9VTxW8of5OKuUrNvRIJ4Pk8C++f3xEvcbYgsNoeYdY+ZROTuPYOr6M3ZFWzxGhMu0FBGguvxRTrponJedp35wPVsXoRBqV7MAhjViIfvLhjgmdqF/pEVgluIHuEYLBbZ8yFzH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVFp3ufX; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732068860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZE9XS2nS1P9CSr00f4qjxs7S+FpZe2i+/rEGi6QgV8=;
	b=ZVFp3ufXSYcmcijvZx7n/JQU74JqYc0cBkoW1y+Me2Aq41VLQOOV9vgDjMQzLPPxgVbnau
	IQ+wezzWUH13AwVKHlkKdYbpWImeuEzAAOzcAhR+OeVSpBZejcmyNTZzuioEL6woK/u5QX
	euM28gjcSYwQxAachvsnoJH1XMkz+nY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] mm: pgtable: make ptep_clear() non-atomic
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
Date: Wed, 20 Nov 2024 10:13:21 +0800
Cc: pasha.tatashin@soleen.com,
 tongtiangen@huawei.com,
 jannh@google.com,
 lorenzo.stoakes@oracle.com,
 david@redhat.com,
 ryan.roberts@arm.com,
 peterx@redhat.com,
 jgg@ziepe.ca,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: 7bit
Message-Id: <A87F992C-F96C-44CB-A93B-E7ECA7B5BDB7@linux.dev>
References: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Nov 19, 2024, at 17:07, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> In the generic ptep_get_and_clear() implementation, it is just a simple
> combination of ptep_get() and pte_clear(). But for some architectures
> (such as x86 and arm64, etc), the hardware will modify the A/D bits of the
> page table entry, so the ptep_get_and_clear() needs to be overwritten
> and implemented as an atomic operation to avoid contention, which has a
> performance cost.
> 
> The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check") adds the ptep_clear() on the x86, and makes it call
> ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The page
> table check feature does not actually care about the A/D bits, so only
> ptep_get() + pte_clear() should be called. But considering that the page
> table check is a debug option, this should not have much of an impact.
> 
> But then the commit de8c8e52836d ("mm: page_table_check: add hooks to
> public helpers") changed ptep_clear() to unconditionally call
> ptep_get_and_clear(), so that the CONFIG_PAGE_TABLE_CHECK check can be
> put into the page table check stubs (in include/linux/page_table_check.h).
> This also cause performance loss to the kernel without
> CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.
> 
> Currently ptep_clear() is only used in debug code and in khugepaged
> collapse paths, which are fairly expensive. So the cost of an extra atomic
> RMW operation does not matter. But this may be used for other paths in the
> future. After all, for the present pte entry, we need to call ptep_clear()
> instead of pte_clear() to ensure that PAGE_TABLE_CHECK works properly.
> 
> So to be more precise, just calling ptep_get() and pte_clear() in the
> ptep_clear().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



