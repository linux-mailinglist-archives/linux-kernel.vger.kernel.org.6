Return-Path: <linux-kernel+bounces-198132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D38D73D9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9361BB210F0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019B12E7F;
	Sun,  2 Jun 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Iy+44CIj"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DA10949
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717302995; cv=none; b=Pvrgg/2LJpuNkWvd9wq9XJCimxE4jVAvNaRQEP0TwepHieWrHISHpYQtIi5DUQHWPM9Xv6a2K7poKOb3L59EJqZKDGfDBLnujQe60b061M1lUIyrYh6zS050syRuqOgoJEjuYAgWUsnuPtHGAIBvhwo95Jcd0KFKY9cW2+LX+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717302995; c=relaxed/simple;
	bh=CWXF1V2TMTYlmotkfVH7GZLwf8hR5Ue0QdIpQrJnBW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9NcscaMNA9eywP/BhCnW5p/5Up1y+FVoTzcmQwGTEITCG53uo5G6L9hWAGVzSR4cjIKDh/sni0/1UAkXRtV6J8n6EBjkR31jhi4OKIZA7mqvnthy0SMUSlBczcn/6n/EyjcgtGWnSlih5ll6JscW1EFwu3p5A5TtF8oXXXABQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Iy+44CIj; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717302983; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZNZ5EiYzI8ePykWRaBhiaORawPDBRtocLTQhbcC0T/w=;
	b=Iy+44CIjpJqHXC6FGQ0XuphIq3jIy4srnfIvCHG2EltzZcQ1H/UnE8WZBToQlI8ooLCMFCQz83HeBiDfUNUbJhq902WU0KzpgbAKlZmFlO3HcxoayHCbTI6buRLW3vkcZrVSG46Zj1ykxjN1apTyL6mqFDLeFnoo1qjR/qYo86k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7dxKvB_1717302980;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7dxKvB_1717302980)
          by smtp.aliyun-inc.com;
          Sun, 02 Jun 2024 12:36:21 +0800
Message-ID: <bba3ab3d-6e9c-4c62-9c85-3a3d338d9230@linux.alibaba.com>
Date: Sun, 2 Jun 2024 12:36:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
To: wang wei <a929244872@163.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <716c515156e8c891766d8fd3f1df231d289b2a37.1717033868.git.baolin.wang@linux.alibaba.com>
 <4e918c74.1262.18fd1d870d6.Coremail.a929244872@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <4e918c74.1262.18fd1d870d6.Coremail.a929244872@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/1 11:29, wang wei wrote:
> At 2024-05-30 10:04:14, "Baolin Wang" <baolin.wang@linux.alibaba.com> wrote:
> 
>>To support the use of mTHP with anonymous shmem, add a new sysfs interface
>>'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>>directory for each mTHP to control whether shmem is enabled for that mTHP,
>>with a value similar to the top level 'shmem_enabled', which can be set to:
>>"always", "inherit (to inherit the top level setting)", "within_size", "advise",
>>"never", "deny", "force". These values follow the same semantics as the top
>>level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
>>to 'always' to keep compatibility.
>>
>>By default, PMD-sized hugepages have enabled="inherit" and all other hugepage
>>sizes have enabled="never" for '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/shmem_enabled'.
>>
>>In addition, if top level value is 'force', then only PMD-sized hugepages
>>have enabled="inherit", otherwise configuration will be failed and vice versa.
>>That means now we will avoid using non-PMD sized THP to override the global
>>huge allocation.
>>
>>Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>---
>> Documentation/admin-guide/mm/transhuge.rst | 29 +++++++
>> include/linux/huge_mm.h                    | 10 +++
>> mm/huge_memory.c                           | 11 +--
>> mm/shmem.c                                 | 96 ++++++++++++++++++++++
>> 4 files changed, 138 insertions(+), 8 deletions(-)
>>
>>diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>index d414d3f5592a..659459374032 100644
>>--- a/Documentation/admin-guide/mm/transhuge.rst
>>+++ b/Documentation/admin-guide/mm/transhuge.rst
>>@@ -332,6 +332,35 @@ deny
>> force
>>     Force the huge option on for all - very useful for testing;
>> 
>>+Anonymous shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob
>>+to control mTHP allocation: /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled.
>>+Its value for each mTHP is essentially consistent with the global setting, except
>>+for the addition of 'inherit' to ensure compatibility with the global settings.
>>+always
>>+    Attempt to allocate <size> huge pages every time we need a new page;
>>+
>>+inherit
>>+    Inherit the top-level "shmem_enabled" value. By default, PMD-sized hugepages
>>+    have enabled="inherit" and all other hugepage sizes have enabled="never";
>>+
>>+never
>>+    Do not allocate <size> huge pages;
>>+
>>+within_size
>>+    Only allocate <size> huge page if it will be fully within i_size.
>>+    Also respect fadvise()/madvise() hints;
>>+
>>+advise
>>+    Only allocate <size> huge pages if requested with fadvise()/madvise();
>>+
>>+deny
>>+    Has the same semantics as 'never', now mTHP allocation policy is only
>>+    used for anonymous shmem and no not override tmpfs.
>>+
>>+force
>>+    Has the same semantics as 'always', now mTHP allocation policy is only
>>+    used for anonymous shmem and no not override tmpfs.
>  >+
> 
> I just briefly reviewed the discussion about the value of 
> hugepages-<size>kB/shmem_enabled
> in V1 [PATCH 5/8]. Is there a conclusion now? Maybe I left out some 
> important information.

You can refer to the this patch's commit message and documentation, 
which are based on the conclusions of previous discussions.

In addition, you can also read more discussions from the last bi-weekly 
MM meeting[1], summarized by David.

[1] 
https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com/#t

