Return-Path: <linux-kernel+bounces-200291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 186058FAE26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7061F27D52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF49142E82;
	Tue,  4 Jun 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W1llwgMs"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C2142900
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491380; cv=none; b=Pt8B0j6Iamvxr0x9u/CqS1IdhRMPWvYWwGiwZnVurgS44WJihWt3OrPkCypmFfEpivKnwv6j3scQsqig1Oq4yOyM0KDi9DJLAt8UEppnZ+oziIIBV0q1tZZGlr627rGdSKIOKvG3uvKOAMj48eNtmvMnfcLExler3RCE3o5tIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491380; c=relaxed/simple;
	bh=8cknAkmefqkx+qv8NvnS0Os0vDp4UwIBi3e26OJQHVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/Y0s1/ilxM2WK2Fzhsc05XD/1A19vszac0REEnGJYRBvd42Ve4bwhLWEYR3FOIBq2Z4OtL32xhFEPqk4nSAoXK286vZNkqCwhV7Pf6KASf0b89LAUzxOM3VVAXXVcTcIygCelXMdK6cL2dXl/SG5YHp2v0ImJg6oxzn6+mU+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W1llwgMs; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717491369; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EgfUmXsqgmNwj+rMaReGgCA4wiQq2XPkVYnu/r4iAGA=;
	b=W1llwgMsY1DsrMJp5C+UGXmPpWlqOhOH5AD/tmz1+p8sMAXnC8m5vXAuAzIeaTCYe2iFQVjhHcZXis+jpPiZaHrkqPXALL/sxeEw3QOdO2QB6cOFLEiLbiPtWijDnOjhwjEdf4+Ov+SVDslnTWmjRM6YeVden0LNleM5p7MtwBY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7qIn4D_1717491368;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qIn4D_1717491368)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 16:56:09 +0800
Message-ID: <89bd659b-a85f-48f2-98ce-f7522cdb95da@linux.alibaba.com>
Date: Tue, 4 Jun 2024 16:56:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717488551-18053-1-git-send-email-yangge1116@126.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <1717488551-18053-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/4 16:09, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> If a page is added in pagevec, its ref count increases one, remove
> the page from pagevec decreases one. Page migration requires the
> page is not referrened by others except page mapping. Before
> migrating a page, we should try to drain the page from pagevec in
> case the page is in it, however, folio_test_lru() is not sufficient
> to tell whether the page is in pagevec or not, if the page is in
> pagevec, the migration will fail.
> 
> Remove the condition and drain lru once to ensure the page is not
> referrenced by pagevec.

This looks sane to me and seems a simple way to fix.

> Signed-off-by: yangge <yangge1116@126.com>
> ---
>   mm/gup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ca0f5ce..890dcbc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2411,7 +2411,7 @@ static unsigned long collect_longterm_unpinnable_pages(
>   			continue;
>   		}
>   
> -		if (!folio_test_lru(folio) && drain_allow) {
> +		if (drain_allow) {
>   			lru_add_drain_all();
>   			drain_allow = false;
>   		}

You should rebase your code on the latest mm-unstable branch, as 
collect_longterm_unpinnable_pages() in the upstream has been replaced 
with collect_longterm_unpinnable_folios().

