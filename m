Return-Path: <linux-kernel+bounces-173387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D08BFFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B29289A94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3C8529D;
	Wed,  8 May 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B/H8Btgk"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511984FC4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177627; cv=none; b=GFoDcHXrqxHp9Wcx6MrqD3Y5IQ0Dg0AghrLEI5oBdAxoEoYos6aaNE0pGtTA862v8pDFu3LCVGCgWwxBXDAdwTGYryoQZaFdRG0SI+3Eo46S1Ds3sw9iXGXc9LAt7uHBu1dadAnjTsDXj1mJ+mcNrQyNNfOicJCehfoIK6rO5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177627; c=relaxed/simple;
	bh=rrwlIaYZbtV52TlODyJZHB6ZbMr+R9trpJlCJpTFGak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=if8sf+owkbf2AJj96D1dhjv9QbWjPw/DcXs51Q7cQZy1Y/JWOp49ON79kD1kATAOjQCGzSItzitTQ1AIa24BeSz8T24O3Fb72UZ9S/mjK0L1AclxtvbBI0MRTe5B0j7fQbWLXkFxLHfh3lJvCsKUbOu7xPSUhik1jq09v/GFXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B/H8Btgk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715177621; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=TfbSiMaoKWe2Hf6m9L+WRZhC/TYEwUM1p2i1xR65WtE=;
	b=B/H8Btgk3tuUJUIFGkATsMqTQp4XZs13weeLg0EacyS+I4JV8rlNd2iMauC0QVaGCgRDOY9a7A1+tfGjENxJx3xjsihWnUXtOsai/e4Rm/VLjd74TJkSLuNXXh483CaHfq3nloc7wSecepErY+4AzPKlQTtVaTop8xIYzTozvnc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W63uUr3_1715177617;
Received: from 30.27.69.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W63uUr3_1715177617)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 22:13:40 +0800
Message-ID: <35ab69e7-97cf-4409-b73f-05b00e110ed7@linux.alibaba.com>
Date: Wed, 8 May 2024 22:13:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: hailong.liu@oppo.com, akpm@linux-foundation.org,
 Michal Hocko <mhocko@suse.com>
Cc: urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
 21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
In-Reply-To: <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/8 21:41, Gao Xiang wrote:
> 
> +Cc Michal,
> 
> On 2024/5/8 20:58, hailong.liu@oppo.com wrote:
>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>
>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>> includes support for __GFP_NOFAIL, but it presents a conflict with
>> commit dd544141b9eb ("vmalloc: back off when the current task is
>> OOM-killed"). A possible scenario is as belows:
>>
>> process-a
>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>      __vmalloc_node_range()
>>     __vmalloc_area_node()
>>         vm_area_alloc_pages()
>>              --> oom-killer send SIGKILL to process-a
>>              if (fatal_signal_pending(current)) break;
>> --> return NULL;
>>
>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>> if __GFP_NOFAIL set.
>>
>> Reported-by: Oven <liyangouwen1@oppo.com>
>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> 
> Why taging this as RFC here?  It seems a corner-case fix of
> commit a421ef303008

BTW, I guess maybe commit e9c3cda4d86e ("mm, vmalloc: fix high order
__GFP_NOFAIL allocations") misses fatal_signal_pending() handling
anyway..

> 
> Thanks,
> Gao Xiang
>

