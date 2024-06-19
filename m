Return-Path: <linux-kernel+bounces-220405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2090E14D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA221C20EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2BAD31;
	Wed, 19 Jun 2024 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yDN5ZTxX"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94046FB8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718760513; cv=none; b=pS6xc/Ha9gRr2V7hT6B8znrONg5BeVpxaoiFKBp6hjGinwLLyP8lh59R5aWCIXBv/s2dJmweySdKaB8Ce8O6JOUFrZCSqQci2WMq1Z5eXEwsDIYjzvBiyA6nEdZnqCyjCxCMlmXTqqgDUth7JH4HO3JfTSgozCS+WC9+K0iMV8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718760513; c=relaxed/simple;
	bh=eLeTuImU8yRsL9p8EySmF2W6w02nFurXLkrrTwqpZRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fpd0K6ggZ/JYVe7kibUGVUBWHO+9H7nCHRiAjVb2bbzB2PR1ug3YQ02SI8/F/V44JFfbMmIttW7NxrvewZGvTBxUdZ2RA/8UC46c6b9JoVYQ7H7iiG7RGvN4f78d2AHax2TZkJLCs2zr9Sc3efXEJZZc2hm9QDnE1bqk2fMO/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yDN5ZTxX; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718760502; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nZ70sjpZhE57gTXxQObxgtJeYg96sRDu2TZuTxxWL2g=;
	b=yDN5ZTxXTkblKB3tvDeA5Am6wUbVJCgtkpLxqymwT8URk9RISYIkznK7//XBdhd92uxMgwIp9apIktce/BszExU2hQdw0ozM6zSvCQEINAOTF3O0Dj8t2A7yNM/DqN7hJQXZw6T2INAcgzYeVjvvqukVqt1LIVm+gJg1pKygj/s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8lP5Gt_1718760499;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8lP5Gt_1718760499)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 09:28:20 +0800
Message-ID: <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
Date: Wed, 19 Jun 2024 09:28:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hughd@google.com, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/19 04:05, Andrew Morton wrote:
> On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> Shmem will support large folio allocation [1] [2] to get a better performance,
>> however, the memory reclaim still splits the precious large folios when trying
>> to swap-out shmem, which may lead to the memory fragmentation issue and can not
>> take advantage of the large folio for shmeme.
>>
>> Moreover, the swap code already supports for swapping out large folio without
>> split, and large folio swap-in[3] series is queued into mm-unstable branch.
>> Hence this patch set also supports the large folio swap-out and swap-in for
>> shmem.
> 
> I'll add this to mm-unstable for some exposure, but I wonder how much
> testing it will have recieved by the time the next merge window opens?

Thanks Andrew. I am fine with this series going to 6.12 if you are 
concerned about insufficient testing (and let's also wait for Hugh's 
comments). Since we (Daniel and I) have some follow-up patches that will 
rely on this swap series, hope this series can be tested as extensively 
as possible to ensure its stability in the mm branch.

