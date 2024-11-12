Return-Path: <linux-kernel+bounces-405005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD59C4BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3DEB258F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97397204940;
	Tue, 12 Nov 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TOyA0aSN"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D52038BA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374676; cv=none; b=k1PxeWuDdBDtzyzm4dQHUpEVlndNs0V1q3Ha07b7hphKKhKrCX8CDUsJEV0EHcVuEpS2ifNxw8l35KqcQzVNvSev8OsQhqiFhqD39StHwjq6shporWoBL6jYGWzAr9d08cUSUscaXAepBKsPZCxbZcSGTQAQ2GJgqW9zLPiYLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374676; c=relaxed/simple;
	bh=7IFpVcXjsDCnFj4hw6Eqop+q5BqmMEfYyniKPkEWT/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0pHlPVdRVZdW2QII/y4uux6Qcqz8Lzfkics1Zar+Qy5osGR8sU6ASZVBVIfF9cEGptHnME69NUpKt2Dya7AfG63TU97ABUD3Tl1exVwSPgjuUmTrwruWqYyakSQ5bdP9m4Gn4lI3PkJu7+I6F2QdmqW+3Xmfc4gEF7VB3woBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TOyA0aSN; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731374671; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FAh8i+btsDEtj/FoB55DOxNk/QmA0qDobXAPdZ9QGRM=;
	b=TOyA0aSNhmrIu3EbXwuZeii3E7+jlSE2MJfQSbEhKml76FfwrMDd8tjSkhsQMneAYtm87d+OFd/gjVzFSR78hO1YqSqPE51xw5mz9swqkBlnWihy6KDO5wgt3Qa0YszPLZODrB8nADEfCmXkoctitwmap28PtLqXG+Aqj80XSuE=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJEyE-C_1731374669 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:24:30 +0800
Message-ID: <055703d7-1434-42fb-8048-add21a9bd44c@linux.alibaba.com>
Date: Tue, 12 Nov 2024 09:24:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
To: Qiang Liu <liuq131@chinatelecom.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241102201621.95291-1-liuq131@chinatelecom.cn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241102201621.95291-1-liuq131@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/3 04:16, Qiang Liu wrote:
> If the last cycle reads bogus compound_order() and blockpfn > end_pfn occurs,

if blockpfn > end_pfn occurs, we will reset the blockpfn, right?

	/*
	 * Be careful to not go outside of the pageblock.
	 */
	if (unlikely(blockpfn > end_pfn))
		blockpfn = end_pfn;

So how this can happen?

> it is possible that total_isolated will be less than nr_scanned. In this case,
> strict mode should return 0, but the “if (strict && blockpfn < end_pfn)”
> statement cannot recognize this situation
> 
> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a2b16b08cbbf..6009f5d1021a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -699,7 +699,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   	 * pages requested were isolated. If there were any failures, 0 is
>   	 * returned and CMA will fail.
>   	 */
> -	if (strict && blockpfn < end_pfn)
> +	if (strict && (blockpfn < end_pfn || total_isolated != nr_scanned))
>   		total_isolated = 0;
>   
>   	cc->total_free_scanned += nr_scanned;

