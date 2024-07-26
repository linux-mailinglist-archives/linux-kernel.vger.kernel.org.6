Return-Path: <linux-kernel+bounces-263062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830E293D08F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5BB1F21D85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60DB178374;
	Fri, 26 Jul 2024 09:43:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE7175562
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987029; cv=none; b=f/xeanPevgch233NmqCnNarh+MZxo7Wx4u8gqbu/RNgY/QcG3/GsIKrfK0zfEeTHSxWhTuwGnNw9Rdo1kmoRS3qN82Rmt+Y0ZIezVC2hSwTK9ZgIhnQa+GRycBUal1nsfs6mdAJVPP+ql2eX3KF684yJ6L97EqhSUBZkkAm7QDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987029; c=relaxed/simple;
	bh=kWq3+eSbOZUbefB6zb83+JI7EkUKW8z3vwqpf2ZRQb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LX0ydXEd9jBUqmpvt1auyDV3rNtmvEAxWrWV0khXhCgLO+QuqD5FRzgy/0WcQaaVhNyKcJHoZKoXzbpSXeJXnDVNI0doTKuO/UukCICuiK4oEzkr7QfUnSoqqmIexpf8Qv4MTPWWCrboFHR9gJdjn36o0EuxiVdILRgseA6HGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E7D1476;
	Fri, 26 Jul 2024 02:44:12 -0700 (PDT)
Received: from [10.57.78.186] (unknown [10.57.78.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAA323F5A1;
	Fri, 26 Jul 2024 02:43:44 -0700 (PDT)
Message-ID: <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
Date: Fri, 26 Jul 2024 10:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD
 THP
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20240726082818.260008-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240726082818.260008-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 09:28, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> khugepaged will be automatically started when PMD-sized THP is enabled
> (either of the per-size anon control or the top-level control are set
> to "always" or "madvise"), and it'll be automatically shutdown when
> PMD-sized THP is disabled (when both the per-size anon control and the
> top-level control are "never").
> 
> It seems unnecessary to call start_stop_khugepaged() for non-PMD THP,
> as it would only waste CPU time.
> 
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 41460847988c..bd365e35acf7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobject *kobj,
>  	} else
>  		ret = -EINVAL;
>  
> -	if (ret > 0) {
> +	if (ret > 0 && order == HPAGE_PMD_ORDER) {
>  		int err;
>  
>  		err = start_stop_khugepaged();

Personally I see this as a bit of a layering violation; its
start_stop_khugepaged() that should decide the policy for when to start and stop
the daemon. thpsize_enabled_store() should just be calling
start_stop_khugepaged() to notify that something potentially pertinent to the a
policy decision has changed.

And I don't think this should be a hot path; I'd expect the global thp size
configuration to be set at boot and remain pretty static. Do you have evidence
to the contrary?

