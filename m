Return-Path: <linux-kernel+bounces-235810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E491D9F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B912281F6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F880BF8;
	Mon,  1 Jul 2024 08:31:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25002C6BB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822717; cv=none; b=ucUm+rDcM1gt55QnXyvlaOEj/mdjYrnIPEC139TqNOKokslFkOX1pwYkyjDTH4fJMVhqH4sxX7wMShhQnVJHlRFlPqTVtCN622Ln6MBUmkhCa6Q+FbhVNJ6McH6Fg5RspuUqj2hzLMOI4Cf/0CT6MaJyu5kDGozAhtDvxVb1q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822717; c=relaxed/simple;
	bh=9fMBl3IiR9pAJFqq60EQ0JGDl+5vTAPK9ubUsBFBqfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDtYkSxBgEpGlIkUQA4ODQic4Tvvnz6/c27EfiGBCOpBLut7k1eZjJsTQ8d14iTscmRWLTgu2uQqZXZJd/cV1wJQu43LdeXa7b+2AyllgoAu9/PdJv0NsmbAG3rYteAC/WMrNGv0ShkGVfEQY+DAYHsoHTPw8O/69su0noc9gPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DBF339;
	Mon,  1 Jul 2024 01:32:19 -0700 (PDT)
Received: from [10.57.72.41] (unknown [10.57.72.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F4103F766;
	Mon,  1 Jul 2024 01:31:52 -0700 (PDT)
Message-ID: <13dcf4be-8c5f-4697-adc1-b68c3da82d78@arm.com>
Date: Mon, 1 Jul 2024 09:31:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: add docs for per-order mTHP split counters
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, david@redhat.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240628130750.73097-1-ioworker0@gmail.com>
 <20240628130750.73097-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240628130750.73097-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 14:07, Lance Yang wrote:
> This commit introduces documentation for mTHP split counters in
> transhuge.rst.
> 
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 1f72b00af5d3..709fe10b60f4 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -514,6 +514,22 @@ file_fallback_charge
>  	falls back to using small pages even though the allocation was
>  	successful.


I note at the top of this section there is a note:

Monitoring usage
================

.. note::
   Currently the below counters only record events relating to
   PMD-sized THP. Events relating to other THP sizes are not included.

Which is out of date, now that we support mTHP stats. Perhaps it should be removed?

>  
> +split
> +	is incremented every time a huge page is successfully split into
> +	base pages. This can happen for a variety of reasons but a common
> +	reason is that a huge page is old and is being reclaimed.
> +	This action implies splitting any block mappings into PTEs.

Now that I'm reading this, I'm reminded that Yang Shi suggested at LSFMM that a
potential aid so solving the swap-out fragmentation problem is to split high
orders to lower (but not 0) orders. I don't know if we would take that route,
but in principle it sounds like splitting mTHP to smaller mTHP might be
something we want some day. I wonder if we should spec this counter to also
include splits to smaller orders and not just splits to base pages?

Actually looking at the code, I think split_huge_page_to_list_to_order(order>0)
would already increment this counter without actually splitting to base pages.
So the documantation should probably just reflect that.

> +
> +split_failed
> +	is incremented if kernel fails to split huge
> +	page. This can happen if the page was pinned by somebody.
> +
> +split_deferred
> +	is incremented when a huge page is put onto split
> +	queue. This happens when a huge page is partially unmapped and
> +	splitting it would free up some memory. Pages on split queue are
> +	going to be split under memory pressure.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help


