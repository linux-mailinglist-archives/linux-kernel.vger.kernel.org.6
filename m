Return-Path: <linux-kernel+bounces-408546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8659C804B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E28284688
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F871E3DF1;
	Thu, 14 Nov 2024 01:55:28 +0000 (UTC)
Received: from chinatelecom.cn (smtpnm6-03.21cn.com [182.42.153.190])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E31E412A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.153.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549327; cv=none; b=HNiQ01PandTX3U0pGC67kZeH1cOTZg6/UEZkumnUEW0c4ZoP8u1SsFwFuQHTZNTUvVwxUbubLZpOMKujFfN+/ODFp7CLybB59nOZOyN1qkF6LF105a3N2LFXDL9AR4QxoaHIGSmWKOCAUrFeb4Xs5TNPAldG/CUbmcpvsv5yWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549327; c=relaxed/simple;
	bh=1U7OT1nOQriNFpHjTmuc93sTspRdTnD6m4uhj7X3oh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dclu4YgPg5QtCL1IKUrNSlSaNMcnKF9Xyus4aZx9D5ZrCdj8qt6fT5eKVcrSFu6S3T72fTWnHdkocoP19z5xQiTzica90XkAjwrXwtWNrX2oLLnRHVOpVF6ubnjVctD4Smq/Bf/uE+TdFqmSb3UlgGWkK/VcZccupwIIvhrEPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=115.124.30.133; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=182.42.153.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.137.232:0.1629231873
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.137.232])
	by chinatelecom.cn (HERMES) with SMTP id 4AB348F745;
	Thu, 14 Nov 2024 09:55:20 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
	by gateway-ssl-dep-6977f57994-b9pvf with ESMTP id 41ed51c2698643488f6bbb440fe0d5bd for liuq131@chinatelecom.cn;
	Thu, 14 Nov 2024 09:55:22 CST
X-Transaction-ID: 41ed51c2698643488f6bbb440fe0d5bd
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From: Qiang Liu <liuq131@chinatelecom.cn>
To: liuq131@chinatelecom.cn,
	akpm <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
Date: Thu, 14 Nov 2024 09:55:17 +0800
Message-Id: <2503b955-79a9-4d21-9a25-34a6c33e688d@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <2024111210165296529720@chinatelecom.cn>
References: <20241102201621.95291-1-liuq131@chinatelecom.cn> <055703d7-1434-42fb-8048-add21a9bd44c@linux.alibaba.com> <2024111210165296529720@chinatelecom.cn>
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835B20CCDC for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGy4ng_1731404822 cluster:ay36) by smtp.aliyun-inc.com; Tue, 12 Nov 2024 17:47:03 +0800
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>



On 2024/11/12 10:16, liuq131@chinatelecom.cn wrote:
> "We assume that the block we are currently processing is distributed as follows:
> 0   1   2                                                            511
> --------------------------------------------------
> |    |    |                                                              |
> ---------------------------------------------------
> Index 0 and 1 are both pages with an order of 0.
> Index 2 has a bogus order (let's assume the order is 9).
> When the for loop reaches index 2, it will enter the following code:
> /*
>   * For compound pages such as THP and hugetlbfs, we can save
>   * potentially a lot of iterations if we skip them at once.
>   * The check is racy, but we can consider only valid values
>   * and the only danger is skipping too much.
>   */
> if (PageCompound(page)) {
>      const unsigned int order = compound_order(page);
>      if (blockpfn + (1UL << order) <= end_pfn) {
>          blockpfn += (1UL << order) - 1;
>          page += (1UL << order) - 1;
>          nr_scanned += (1UL << order) - 1;
>      }
>      goto isolate_fail;
> }
> 
> After exiting the for loop:
> blockpfn =basepfn+ 2+2^9 = basepfn+514
> endpfn  = basepfn +512
> total_isolated = 2
> nr_scanned = 514

In your case, the 'blockpfn' will not be updated to 'basepfn+514', 
because 'blockpfn + (1UL << order) > end_pfn', right? And remember the 
'end_pfn' is the end of the pageblock.

So I'm still confused about your case. Is this from code inspection?

> /*
> * Be careful to not go outside of the pageblock.
> */
> if (unlikely(blockpfn > end_pfn))
> blockpfn = end_pfn;
>   
> So this can happen
> 
> /*
>   * If strict isolation is requested by CMA then check that all the
>   * pages requested were isolated. If there were any failures, 0 is
>   * returned and CMA will fail.
>   */
> if (strict && blockpfn < end_pfn)
> total_isolated = 0;
> 
> If processed according to the old code, it will not enter the if statement to reset total_isolated, but the correct handling is to reset total_isolated to 0.

Please do not top-posting:

"
- Use interleaved ("inline") replies, which makes your response easier 
to read. (i.e. avoid top-posting -- the practice of putting your answer 
above the quoted text you are responding to.) For more details, see
   :ref:`Documentation/process/submitting-patches.rst 
<interleaved_replies>`.
"


