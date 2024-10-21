Return-Path: <linux-kernel+bounces-374172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEC9A660A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD761C21ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB561E47C1;
	Mon, 21 Oct 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcH3jfFK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D81E47A1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509156; cv=none; b=hIh18bdFG/Rh9GDUK/648kI9C6uym9RJx/C0T+NOJcNLejeBh6DuuJWHIDjFRMTOIe4Wa0ZKPzKXM4d7zDFUH+6X1mecOtq4YfXqSR15FYcoimibWFsMIV22U0+zFQD3YnbuxFZGeVhtTylxDn5yIxrTJ8OOTs4onzKCeX+qET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509156; c=relaxed/simple;
	bh=pUN1oDTgXpxMIKsHHSGG0fFYnRsnYumXx+HYjZo8ZD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNnu9Op9BOY9ZEeUt7Vqx8rA4OrGum1cNGtjPPcZxY1r6jz6JkZdqp+xxXqmXWUXQ9EEKKcU67l/4hSHy2y250tmi9fRAaAZFhZKKJmtwamOd5h4A7L5xMRLbVwZd9dXgzpME2FhgkbdUOdrro+z0KkmRkXm05jETofV0dOFKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcH3jfFK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729509153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbws/WxUwNejDptwzJqGW+4L+Nq8J7RK8+TX0K4g9ys=;
	b=PcH3jfFKDL3S2xjMEx3Ho3VyU8/Zw9J5MQ/Pu9eh9XHFG5d3LA37Lsnb8NlbqBQxQZLvim
	YxqbGbor7sVLw/xRKIUqqOB7Z12KGzZc64Id380vfMX0doZsUYYlmd8jMuLqSpzcLoQDpL
	Q/pMPmvqcG0mooByQWFGOAJxb10hUXg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-EH2FX9_yMWyL8pYNSLF-yg-1; Mon, 21 Oct 2024 07:12:32 -0400
X-MC-Unique: EH2FX9_yMWyL8pYNSLF-yg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b155e23851so599822485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729509152; x=1730113952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbws/WxUwNejDptwzJqGW+4L+Nq8J7RK8+TX0K4g9ys=;
        b=Px15JLbcGOPUFBK/ZR5Q/nCEg/o4U6tGLvDL3yF7Oq6m2A6ZjOjEHLYgjazNPjjHRU
         5RDF7krAsSeR+G4UqSikVAjdmyp6QWvwdJpbeePvKR9Lzzx3WmmYnseLWx9yINmudHjn
         1tw4pRYRt1xqQmY6B8QgarySuBLQJjUahOdN8Kx3NuiaDaNu3VmexAG79Auj1dVspxYO
         mmGaShj3P0ZH8pYVfVc8W556lCuXL5uCisHdK5A/vHIFPp6QTv93nX6dZvPL3zPPP9YI
         H/Ci5WUv/meM0HUbnDfyoiAv3QOCflmDmsuucKdPnW85W9/Gdn6n2p166mZ9ipsMvkIG
         rFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXzljXGw8cQYVyy7UnSOCHZH38d+hH2n6CMuv+KK1DZbGOZo4oz/8S9h5dTyjUNp6Pd4tIJmcv8iEbVx+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNKQh6urMRIHLY+/6UPNNp8BCbUWu/Jnq0O0KyzyZxZN8NbaF
	5XdkYAIbvgO3Sc1YxU+0AJ66VxIb1otn5K8dmQ8N6nf8A1HAsTjSZVGyv/3m8mRxOdUEAg9EkSF
	YmgaAQw88uibSX07tfeiVhkc1/0fHxTjvBwTsncITMMX8AtRuKImKX+iHugDVYQ==
X-Received: by 2002:ad4:410a:0:b0:6cc:2bff:59ef with SMTP id 6a1803df08f44-6cde159f200mr128252926d6.32.1729509151706;
        Mon, 21 Oct 2024 04:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Myrk7JQKGKcX2DwyI+RFEzwP7PtOkGIb/F7m2G4o82Hac+RLHvXfLdMtzCiV+zSpAtATcw==
X-Received: by 2002:ad4:410a:0:b0:6cc:2bff:59ef with SMTP id 6a1803df08f44-6cde159f200mr128252616d6.32.1729509151376;
        Mon, 21 Oct 2024 04:12:31 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009dd27fsm16042386d6.109.2024.10.21.04.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 04:12:30 -0700 (PDT)
Message-ID: <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
Date: Mon, 21 Oct 2024 13:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
 haibo1.xu@intel.com, dave.jiang@intel.com
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20241016192445.3118-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 16.10.24 um 21:24 schrieb Gregory Price:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) [new] hotplug advise: lesser of advise value or memory alignment
> 4) Max block size if system is bare-metal
> 5) Largest size that aligns to end of memory.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   arch/x86/mm/init_64.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..b72923b12d99 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
>   {
>   	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
>   	unsigned long bz;
> +	int order;
>   
>   	/* If memory block size has been set, then use it */
>   	bz = set_memory_block_size;
> @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
>   		goto done;
>   	}
>   
> +	/* Consider hotplug advisement value (if set) */
> +	order = memblock_probe_size_order();

"size_order" is a very weird name. Just return a size?

memory_block_advised_max_size()

or sth like that?

> +	bz = order > 0 ? (1UL << order) : 0;
> +	if (bz) {
> +		/* Align down to max and up to min supported */
> +		bz = 
> +		/* Use lesser of advisement and end of memory alignment */
> +		for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> +			if (IS_ALIGNED(boot_mem_end, bz))
> +				goto done;

This looks like duplicate code wit the loop below.

Could we refactored it into something like:

advised_max_size = memory_block_advised_max_size();
if (!advised_max_size) {
	bz = MAX_BLOCK_SIZE;
	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)
		goto done,
} else {
	bz = max(min(advised_max_size, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
}

for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
	if (IS_ALIGNED(boot_mem_end, bz))
		break;



-- 
Cheers,

David / dhildenb


