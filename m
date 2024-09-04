Return-Path: <linux-kernel+bounces-314347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C396B21E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7987287362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4088A145B35;
	Wed,  4 Sep 2024 06:49:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FD4DA13
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432567; cv=none; b=F8vJV2BOcGHmET8TRI4WPkRXX4rk6bj+mxmN4hJ6IMs783GB5lT+52ssmJCfWzMWpGJYi7cmVkt7mHihoz8KLNO0F6bfjesROyyIKwVltQRp3Y2OHaBw/a+0UEb0z8fvKAf/LhIwfU6TRZTtKbCNipjutabK5hach7SpcLlujjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432567; c=relaxed/simple;
	bh=Q16vZrCD4ZoQPOeWawkRHhgAmtEnvP3sdLqXDbpGLFo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HQY5+FLyAabesTz/3cuFRzQ7xTty7WFFdYC3afn0vJDBUoIKC0h6jSDo/fxCqgq/tyKHQEdp1/oD+J170PIBrlrWC+fVdyPe8S5d+YRbS9dqS54a5XlL3M8O0gzoDVEPH0BYcwXN863Ii1kqjxjPZc417ZYF9gL0d/8cYMa3PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzCjF44HyzpV38;
	Wed,  4 Sep 2024 14:47:29 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id EBFBF180105;
	Wed,  4 Sep 2024 14:49:21 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 14:49:21 +0800
Message-ID: <ed533d8b-40b7-447f-8453-e03b291340fa@huawei.com>
Date: Wed, 4 Sep 2024 14:49:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <ying.huang@intel.com>,
	<akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
	<dmaluka@chromium.org>, <liushixin2@huawei.com>,
	<wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, proc: collect percpu free pages into the free pages
Content-Language: en-US
To: <mhocko@suse.com>
References: <20240830014453.3070909-1-mawupeng1@huawei.com>
 <87a5guh2fb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ee7cb17-9003-482c-9741-f1f51f61ab4b@huawei.com>
 <871q22hmga.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <193da117-30b8-425a-b095-6fd8aca1c987@huawei.com>
 <ZtbERGm8CJsOwx73@tiehlicka>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <ZtbERGm8CJsOwx73@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/9/3 16:09, Michal Hocko wrote:
> On Tue 03-09-24 09:50:48, mawupeng wrote:
>>> Drain remote PCP may be not that expensive now after commit 4b23a68f9536
>>> ("mm/page_alloc: protect PCP lists with a spinlock").  No IPI is needed
>>> to drain the remote PCP.
>>
>> This looks really great, we can think a way to drop pcp before goto slowpath
>> before swap.
> 
> We currently drain after first unsuccessful direct reclaim run. Is that
> insufficient? 

The reason i said the drain of pcp is insufficient or expensive is based
on you comment[1] :-）. Since IPIs is not requiered since commit 4b23a68f9536
("mm/page_alloc: protect PCP lists with a spinlock"). This could be much
better.

[1]: https://lore.kernel.org/linux-mm/ZWRYZmulV0B-Jv3k@tiehlicka/

> Should we do a less aggressive draining sooner? Ideally
> restricted to cpus on the same NUMA node maybe? Do you have any specific
> workloads that would benefit from this?

Current the problem is amount the pcp, which can increase to 4.6%(24644M)
of the total 512G memory.


