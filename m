Return-Path: <linux-kernel+bounces-278817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BF94B545
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E47B23F37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234C29D1C;
	Thu,  8 Aug 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+9usZ4d"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C164EB2B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085986; cv=none; b=LURph+WS43tdMzPnaxzHVcPBUVTv0qIGzV0ZcyP3kuBvYBpDxzn1W2WJtwjsJU2hk0S6fimbHM9hbVyLtcwFMqhhrbUH8JFbB9qAWDS13fOJbqdUxchaAQNbKMkfda7qGssvAEZyXzacZ9a6QWVufPMX5d7YmNohMFdcqU8RAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085986; c=relaxed/simple;
	bh=eldFYU4clKYsLh3nmo7HUz88FpRDOI4Mr5SWZEIw7kc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QHz+bN6IslCkRZRxvPccsVyvfn6QVBI63Wd58uU+j1myjfJou2uXqwmH4ctVzqK9QUWRJ0UpVjcjGo1yIFx1IzMLOqx5IB0AWGE2bZuxSos8l3BE5VNntJFLS3+Ak71gZdhJYA72I7mwdsH6Bc7gcTk+z5MR+TF9IqR+6livTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+9usZ4d; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723085981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQSgNvuT9qgO3nurkKtt1v66Jlk8HpyzzUcogrlPyBs=;
	b=b+9usZ4dKqgLuDPM0DIdHcYG6XlXPaDoBPUBOV4V6UdsdhxF/XRgQ1faeTTU6RfTeHNCEv
	uj91aISMrBgVw32KbhWYV4AvP8ohHSPDaf2dRaORzNmVK5QWWo9l2BJoqBcdlYrt1pPYPM
	2cXDAW5/qVcLbNO4q19wfU7agqjxLLk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 3/3] mm: don't account memmap per node
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240807211929.3433304-4-pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 10:59:00 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 cerasuolodomenico@gmail.com,
 Johannes Weiner <hannes@cmpxchg.org>,
 Joel Granados <j.granados@samsung.com>,
 lizhijian@fujitsu.com,
 Nhat Pham <nphamcs@gmail.com>,
 David Rientjes <rientjes@google.com>,
 Mike Rapoport <rppt@kernel.org>,
 Sourav Panda <souravpanda@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E5F2A1F6-DD29-4FD8-B4AA-2CA917F6E89F@linux.dev>
References: <20240807211929.3433304-1-pasha.tatashin@soleen.com>
 <20240807211929.3433304-4-pasha.tatashin@soleen.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 8, 2024, at 05:19, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> Currently, when memory is hot-plugged or hot-removed the accounting is
> done based on the assumption that memmap is allocated from the same node
> as the hot-plugged/hot-removed memory, which is not always the case.
> 
> In addition, there are challenges with keeping the node id of the memory
> that is being remove to the time when memmap accounting is actually
> performed: since this is done after remove_pfn_range_from_zone(), and
> also after remove_memory_block_devices(). Meaning that we cannot use
> pgdat nor walking though memblocks to get the nid.
> 
> Given all of that, account the memmap overhead system wide instead.

Hi Pasha,

You've changed it to vm event mechanism. But I found a comment (below) say
"Counters should only be incremented". I do not know why it has such a rule
sice 2006. Now the rule should be changed, is there any effect to users of
/proc/vmstat?

/*
 * Light weight per cpu counter implementation.
 *
 * Counters should only be incremented and no critical kernel component
 * should rely on the counter values.
 *
 * Counters are handled completely inline. On many platforms the code
 * generated will simply be the increment of a global address.
 */

Muchun,
Thanks.


