Return-Path: <linux-kernel+bounces-212426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596C906046
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662431C2125B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00659B664;
	Thu, 13 Jun 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CavwT/PL"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD19E8F62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240931; cv=none; b=EcSRRGthPunD3a6w1yYTFVdkgxCVWJ+UDQoGLYTxBB/bItu7Zuf9CafcpRwChhen+5ZRlgYmAs7nhm5wdQsWKpIUXEmhK9GKlDtrI/eHxd3Fn9Ak3eh/KOArqOXDKs3cRblUdAP1/QcKxC91broGaVq0p+4pGyOoxf6ABfb8i10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240931; c=relaxed/simple;
	bh=vQy2E1LRcS1YLhFfzyvBITScg58VETb76RUverloGLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6l557A3judLFyxFJ9yu8TLzdnbg9akJjf1myU5Htjv0WToiihxIsQPxrebsZVAhGS0CMrL7yk/C2aaQb22V3rq0giOWIb42UurAWxY43H/wXvusfqXdy8uovQdpo35Zu0sVVGhMRdBjXDeEyXez8EhVWPOO1QOzkSgo4Z2rDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CavwT/PL; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718240920; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=frrlRZLq7WnZ116ncXcEtLFOrq8M38OfqlEQUKfVJM0=;
	b=CavwT/PL0HSehRlaxyo9xds9ChWff+1VXVPiZpH1DjlJmsQyAhUPYIQkAkLuGgJ+3zxE8imakQx4r235A01iR0sCKV3CPtWoKnzmf9k8zQGpLXF+zEriWHkjq0/YBjPlkREfyrXnEk66mPyENf8HhlVhDp1YnjPM0RptWV9wnTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8M6-yY_1718240918;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8M6-yY_1718240918)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 09:08:39 +0800
Message-ID: <d86e2e7f-4141-432b-b2ba-c6691f36ef0b@linux.alibaba.com>
Date: Thu, 13 Jun 2024 09:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
 <CAK1f24k0bYk2zGAj3znkkT=XnweTxF64XhLP9Xg_HUHeNtrAXA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24k0bYk2zGAj3znkkT=XnweTxF64XhLP9Xg_HUHeNtrAXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/12 22:18, Lance Yang wrote:
> On Tue, Jun 11, 2024 at 6:11 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add mTHP counters for anonymous shmem.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> LGTM. Feel free to add:
> Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks.

> 
> Just a friendly reminder: We also need to update the documentation
> for the counters in transhuge.rst.

Indeed.

Andrew, could you help to fold following changes into this patch? Thanks.

diff --git a/Documentation/admin-guide/mm/transhuge.rst 
b/Documentation/admin-guide/mm/transhuge.rst
index e7232b46fe14..8f6ffbfc4b16 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -501,6 +501,19 @@ swpout_fallback
         Usually because failed to allocate some continuous swap space
         for the huge page.

+file_alloc
+        is incremented every time a file huge page is successfully
+        allocated.
+
+file_fallback
+        is incremented if a file huge page is attempted to be allocated
+        but fails and instead falls back to using small pages.
+
+file_fallback_charge
+        is incremented if a file huge page cannot be charged and instead
+        falls back to using small pages even though the allocation was
+        successful.
+
  As the system ages, allocating huge pages may be expensive as the
  system uses memory compaction to copy data around memory to free a
  huge page for use. There are some counters in ``/proc/vmstat`` to help

