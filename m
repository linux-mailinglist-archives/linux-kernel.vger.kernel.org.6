Return-Path: <linux-kernel+bounces-310968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7017968369
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132F51C222A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0491D1F6B;
	Mon,  2 Sep 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ivRxZIKP"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D400179654
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269803; cv=none; b=ttsStKa9vT1EFYmLn+Fqrv/Zo91FdCy8mi1ywK1MAwfPDw6V2EScwafGmUZHeCETCu+dHgyi1PoWuQ2t8XtAIpfZQb1pyJd0ahVtKfjsKEjolxYUwHMfn2yUihKXLM19IsEwbmeFCFHVuYVX9QpM8S8oPwM0QaVnA3ix1qOmm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269803; c=relaxed/simple;
	bh=4Uc95Up5EPHLOZHOhrukaU4Z0lHX7dRAuCNVi60dbfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbXCH0O66SaEEoFDNvsPlAyjyOekil+SDRzMeVt5bQxAbTvlL50Ynu0hZJnxoqEyO7dArTJpfvZJjDvkKMpjmi7poXR11EE8EHUm9Nk26cHIoVmmo52biZ2jKW5XKkZPTGJysWdLp4ClbbBKKRsIL/Ew3QHEpvuQEAXi9bncU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ivRxZIKP; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725269799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=g9V99G/fQuvajLco/VpGaPuxaTwxa+LXYCFJSoYupVA=;
	b=ivRxZIKPmUaf5a+IZxbJ4JIFIfydV7bFr7MFRm8Y9rUISZTHR2RhY0DjjL7aNORB3iru1S5URECneKTfhJDQV6u5GkeUyyH4eXuApHhUPt00nc7thmU7zSvSCvOIFeFQH53hluJCFkScDNd3wiZrK5I+WKFbSTCBCXXdq1+W/+A=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WE74Bmk_1725269797)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 17:36:38 +0800
Message-ID: <2cfb4e1a-d9be-47ab-b92d-94cd65bfec43@linux.alibaba.com>
Date: Mon, 2 Sep 2024 17:36:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: control mthp per process/cgroup
To: Nanyong Sun <sunnanyong@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: hughd@google.com, akpm@linux-foundation.org, david@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240816091327.54183-1-sunnanyong@huawei.com>
 <Zr-XVn1ExJ7_LSLS@casper.infradead.org>
 <3ac1e404-a531-a380-7a2f-6adae4640da6@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3ac1e404-a531-a380-7a2f-6adae4640da6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/19 13:58, Nanyong Sun wrote:
> On 2024/8/17 2:15, Matthew Wilcox wrote:
> 
>> On Fri, Aug 16, 2024 at 05:13:27PM +0800, Nanyong Sun wrote:
>>> Now the large folio control interfaces is system wide and tend to be
>>> default on: file systems use large folio by default if supported,
>>> mTHP is tend to default enable when boot [1].
>>> When large folio enabled, some workloads have performance benefit,
>>> but some may not and some side effects can happen: the memory usage
>>> may increase, direct reclaim maybe more frequently because of more
>>> large order allocations, result in cpu usage also increases. We observed
>>> this on a product environment which run nginx, the pgscan_direct count
>>> increased a lot than before, can reach to 3000 times per second, and
>>> disable file large folio can fix this.
>> Can you share any details of your nginx workload that shows a regression?
>> The heuristics for allocating large folios are completely untuned, so
>> having data for a workload which performs better with small folios is
>> very valuable.
>>
>> .
> The RPS(/Requests per second/) which is the performance metric of nginx 
> workload has no
> regression(also no improvement)，we just observed that  pgscan_direct 
> rate is much higher
> with large folio.
> So far, we have tested some workloads' benchmark, some did not have 
> performance improvement
> but also did not have regression.
> In a production environment, different workloads may be deployed on a 
> machine. Therefore,
> do we need to add a process/cgroup level control to prevent workloads 
> that will not have
> performance improvement from using mTHP? In this way, the memory 
> overhead and direct reclaim
> caused by mTHP can be avoided for those process/cgroup.

OK. So no regression with mTHP, seems just some theoretical analysis.

IMHO, it would be better to evaluate your 'per-cgroup mTHP control' idea 
on some real workloads, and gather some data to evaluation, which can be 
more convincing.

Just my 2 cents:)

