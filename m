Return-Path: <linux-kernel+bounces-517150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE351A37CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC58518935B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E818DB28;
	Mon, 17 Feb 2025 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wVRwTHu+"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057C18DB23
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779572; cv=none; b=pMp+4USt7Jm87TsivGHjOHR7F3YJAIOeRwoC2rtUemgcZ23c6MNfLN9PROupYNLLJ1PykcHlwiZ/5CTx5iwO15RivXXqIkKxVklooLzU2J5ABlhYtEXdWuKOtk35BP2YYDkOy2JdBiUIrSrM1O/0Xo6iNjllhCiWs1yLaL4GVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779572; c=relaxed/simple;
	bh=vPMO9PqP4rX/Oy3q+jLqKiaClpW7niNkGlZcUNnvXRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uh8Oh0jCQNsAsBuLp6wXquxoUWIO9vbGWDLP91R7y/es2uaQ2TbUOQz15I5Wmb4waawvrTfiTxL4uGRrm5Timm71SSqgEACRdnVELtwQhEYZCjmDOwrbGRlOgmwoMryqElRCLIdwyx5WPGxEzUnnD32gzpV944avWEnEY3Hp4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wVRwTHu+; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739779566; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=sfNxgtmB0/jz3pq8TzZXhfYQ6DAYL0BO+1v9NrYYgkg=;
	b=wVRwTHu+FRVv4H8nQQW7aCKdtvCw/flOnjuASjmdsixqLcUIi6Jl9gvAXx82tWNYM+Irj6nx99sgaa9CbshpWRi5KLm/gUBIikSQpUKwa5e4V1ZdBCXEbZP420CPQD+RuUZQCjLisqk7KxtJjL+pgSW9KFQkI97A1W1ozVK9NzM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPc6v4i_1739779561 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 16:06:03 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bharata B Rao <bharata@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Raghavendra K T
 <raghavendra.kt@amd.com>,  linux-mm@kvack.org,  akpm@linux-foundation.org,
  lsf-pc@lists.linux-foundation.org,  gourry@gourry.net,
  nehagholkar@meta.com,  abhishekd@meta.com,  nphamcs@gmail.com,
  hannes@cmpxchg.org,  kbusch@meta.com,  Hasan.Maruf@amd.com,
  sj@kernel.org,  david@redhat.com,  willy@infradead.org,
  k.shutemov@gmail.com,  mgorman@techsingularity.net,  vbabka@suse.cz,
  hughd@google.com,  rientjes@google.com,  shy828301@gmail.com,
  liam.howlett@oracle.com,  peterz@infradead.org,  mingo@redhat.com,
  nadav.amit@gmail.com,  shivankg@amd.com,  ziy@nvidia.com,
  jhubbard@nvidia.com,  AneeshKumar.KizhakeVeetil@arm.com,
  linux-kernel@vger.kernel.org,  jon.grimm@amd.com,
  santosh.shukla@amd.com,  Michael.Day@amd.com,  riel@surriel.com,
  weixugc@google.com,  leesuyeon0506@gmail.com,  honggyu.kim@sk.com,
  leillc@google.com,  kmanaouil.dev@gmail.com,  rppt@kernel.org,
  dave.hansen@intel.com, feng.tang@linux.alibaba.com
Subject: Re: [LSF/MM/BPF TOPIC] Unifying sources of page temperature
 information - what info is actually wanted?
In-Reply-To: <f091e09a-1f39-48ee-8968-8f616d8102a6@amd.com> (Bharata B. Rao's
	message of "Mon, 17 Feb 2025 09:40:36 +0530")
References: <20250123105721.424117-1-raghavendra.kt@amd.com>
	<20250131122803.000031aa@huawei.com>
	<20250131130901.00000dd1@huawei.com> <87h64u2xkh.fsf@DESKTOP-5N7EMDA>
	<f091e09a-1f39-48ee-8968-8f616d8102a6@amd.com>
Date: Mon, 17 Feb 2025 16:06:01 +0800
Message-ID: <874j0t2dxy.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 16-Feb-25 12:19 PM, Huang, Ying wrote:
>>>>
>>>> 1) Give me up to X hotish pages from a slow tier (greater than a specific measure
>>>> of temperature)
>> Because the hot pages may be available upon page accessing (such
>> PROT_NONE
>> page fault), the interface may be "push" style instead of "pull" style,
>> e.g.,
>> int register_hot_page_handler(void (*handler)(struct page *hot_page,
>> int temperature));
>
> Yes, push model appears natural to me given that there are producers
> who are themselves consumers as well.
>
> Let's take an example of access being detected by PTE scan by DAMON
> first and LRU and hot page promotion subsystems have registered
> handlers for hot page info.
>
> Now if hot page promotion handler gets called first and if it promotes
> the page, calling LRU registered handler still makes sense? May be not
> I suppose.
>
> On the other hand if LRU subsystem handler gets first and it
> adjusts/modifies the hot page's list, it would still make sense to
> activate the hot page promotion handler to check for possible
> promotion.
>
> Is this how you are envisioning the different consumers of hot page
> access info could work/cooperate?

Sorry, I have no idea about what is the right behavior now.  It appears
hard to coordinate different consumers.

In theory, we can promote the hottest pages while activate (in LRU
lists) the warm pages.

---
Best Regards,
Huang, Ying

