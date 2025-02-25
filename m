Return-Path: <linux-kernel+bounces-530609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD2A435BB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71477A8ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAF25A327;
	Tue, 25 Feb 2025 06:50:04 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD622580D3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466204; cv=none; b=IEK8D/S6urPKWXH9E+nNQB4AIf9qPaUQVGnvVR2M7lxaHr9LbU1Y8Ut5Cues4fBtVibaeZ+EKcBn77td+V8h94letApolIWvz7AOTDMPltx5TAWNtp/y2tOhmg7MwPdOgNiUvn4iNwnLCLYhgRqoswyKeSr5eJwR+VY2fpzifRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466204; c=relaxed/simple;
	bh=jbsg3TAULemB474RCuga6e3uLPTvoNoYPugdAEpE3zM=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m2CQoOSBDHQnsLCRqGjCm7/3w58tt/Why+64cjQgbeLLiO4AowFRBhN8k4FKETVP7vfdxDhRAA9xWPhqBN39AZAD/ad96ngcmfx9LlbLzN9wvqCELmW1aoq4pBMSPkssrN57sDsVJlLHkvMvvlnKAJofuKYzn1YYorCAD5f2MZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z27R665HCzJ1FT;
	Tue, 25 Feb 2025 14:45:54 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id A31D91401F3;
	Tue, 25 Feb 2025 14:49:57 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 14:49:56 +0800
Subject: Re: [PATCH v2] mm: make page_mapped_in_vma() hugetlb walk aware
To: Jane Chu <jane.chu@oracle.com>
References: <20250224211445.2663312-1-jane.chu@oracle.com>
CC: <willy@infradead.org>, <peterx@redhat.com>, <akpm@linux-foundation.org>,
	<kirill.shutemov@linux.intel.com>, <hughd@google.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3f3acf9f-f71d-77a3-ca61-5cc5c6c7f02b@huawei.com>
Date: Tue, 25 Feb 2025 14:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250224211445.2663312-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/25 5:14, Jane Chu wrote:
> When a process consumes a UE in a page, the memory failure handler
> attempts to collect information for a potential SIGBUS.
> If the page is an anonymous page, page_mapped_in_vma(page, vma) is
> invoked in order to
>   1. retrieve the vaddr from the process' address space,
>   2. verify that the vaddr is indeed mapped to the poisoned page,
> where 'page' is the precise small page with UE.
> 
> It's been observed that when injecting poison to a non-head subpage
> of an anonymous hugetlb page, no SIGBUS show up; while injecting to
> the head page produces a SIGBUS. The casue is that, though hugetlb_walk()
> returns a valid pmd entry (on x86), but check_pte() detects mismatch
> between the head page per the pmd and the input subpage. Thus the vaddr
> is considered not mapped to the subpage and the process is not collected
> for SIGBUS purpose.  This is the calling stack
>       collect_procs_anon
>         page_mapped_in_vma
>           page_vma_mapped_walk
>             hugetlb_walk
>               huge_pte_lock
>                 check_pte
> 
> check_pte() header says that it
> "check if [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) is mapped at the @pvmw->pte"
> but practically works only if pvmw->pfn is the head page pfn at pvmw->pte.
> Hindsight acknowledging that some pvmw->pte could point to a hugepage of
> some sort such that it makes sense to make check_pte() work for hugepage.

Thanks for your patch. This patch looks good to me.

> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Is a Fixes tag needed?

Thanks.
.

