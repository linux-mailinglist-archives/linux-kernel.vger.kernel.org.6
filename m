Return-Path: <linux-kernel+bounces-337003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D1D984400
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3109E1C22D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680C1A3A9A;
	Tue, 24 Sep 2024 10:50:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3F158538
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175020; cv=none; b=ebqhL+HBDidHvFgs1jf6Iw3IGN0bpJkLwYrEAO6p9lL2QPzeFuHWVB5kAu89/JoLwpXxcgVI9oiE9itoqGCWKwqhmTe4cKZWkwEazfq7y0AtI+31LHso5UVHa+UmaO88dYeF7ANiNejSsvpzH1V2NFiLOZnGqOozN61nKilHUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175020; c=relaxed/simple;
	bh=84eavi6gbHEDYMv/1Ntg1zLnJaypCt4R7XFJ2bLFqmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3Ee0LHVar5qnKnu9ef1NhxI6BQWv3eZZu7STAa09u5yA84M31Fu4oLbJ/5nTQMiozJwEp88YtIJv6rClDJMAH/HCT8F7RUP4iq01CTmX9Wf67XlwA0DOxJiI24VebXtCsKmqah/9PZ0fih0VASnAfLOx1rS1MUWM6nJMf8COZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07105DA7;
	Tue, 24 Sep 2024 03:50:48 -0700 (PDT)
Received: from [10.163.37.113] (unknown [10.163.37.113])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA4A3F528;
	Tue, 24 Sep 2024 03:50:16 -0700 (PDT)
Message-ID: <42545fc6-8c91-4f20-9959-2416b9e112c2@arm.com>
Date: Tue, 24 Sep 2024 16:20:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: Print the correct pfn in
 do_migrate_range()
To: Li Zhijian <lizhijian@fujitsu.com>, linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240924101555.327091-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240924101555.327091-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/24 15:45, Li Zhijian wrote:
> The pfn value needs to be retrieved correctly when PageTransHuge(page)
 
Where the pfn could have been modified with

pfn = page_to_pfn(head) + compound_nr(head) - 1

So retrieving from page will get the original pfn value ?

> is true. Fix it by replacing the usage of 'pfn' with 'page_to_pfn(page)'
> to ensure the correct pfn is printed in warning messages when isolation
> fails.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 26790c8d5b43..000430406a9e 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1829,7 +1829,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		} else {
>  			if (__ratelimit(&migrate_rs)) {
> -				pr_warn("failed to isolate pfn %lx\n", pfn);
> +				pr_warn("failed to isolate pfn %lx\n", page_to_pfn(page));
>  				dump_page(page, "isolation failed");
>  			}
>  		}

