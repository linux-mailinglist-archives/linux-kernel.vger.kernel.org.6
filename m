Return-Path: <linux-kernel+bounces-213084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E313906AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351E3286FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267214373B;
	Thu, 13 Jun 2024 11:21:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555513C9DE;
	Thu, 13 Jun 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277680; cv=none; b=tS0oDMkorD+7gWq6UIdcxF2FwDP8xjxJZFPD37PtNq9X1nDeq67Dy0MYpE8VkXoWjVbUDIrzwlLM3AfeEh6z9ByaqIIWUsaO1OM1W+laOayZA1kkDlRPZaKV1eoyvR5Vztqk4hKvTfNsje6ndCxW5gNQZUhRSQQlwZbM27K0Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277680; c=relaxed/simple;
	bh=w65NFWvHF3S6KGS/xWduamOYfaVv2mSB1xd6evgSKds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nsYV8CSGKhPeKXk6jJZ5KY+zhMMjI5LChrnC4/oVVKvnfhvsvz6IuTaFJk6js6AUSrzrw1rAIdSB8oApTHbz3kvcVIabyLGdOHzG7qvuwd3zI++9o3q/hX/qgOxfDPAyxctZYx4L4UBTlSWPTNvBBKNi/uwuicZ68IBlzEVkkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0Kgl4JCVzdcJD;
	Thu, 13 Jun 2024 19:19:47 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 7283A140416;
	Thu, 13 Jun 2024 19:21:15 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 19:21:14 +0800
Message-ID: <362b1e1b-dcdb-4801-a9fc-18d019e7c775@huawei.com>
Date: Thu, 13 Jun 2024 19:21:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-36966: erofs: reliably distinguish block based and
 fscache mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <cve@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cve-announce@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Baokun Li
	<libaokun@huaweicloud.com>, =?UTF-8?B?5p2o5LqM5Z2k?= <yangerkun@huawei.com>
References: <2024060804-CVE-2024-36966-8bbb@gregkh>
 <686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/6/13 17:38, Gao Xiang wrote:
> Hi,
>
> (+Cc Baokun Li)
>
> On 2024/6/8 20:53, Greg Kroah-Hartman wrote:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> erofs: reliably distinguish block based and fscache mode
>>
>> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
>> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
>> it will be mistaken for fscache mode, and then attempt to free an 
>> anon_dev
>> that has never been allocated, triggering the following warning:
>>
>> ============================================
>> ida_free called for id=0 which is not allocated.
>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>> Modules linked in:
>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>> RIP: 0010:ida_free+0x134/0x140
>> Call Trace:
>>   <TASK>
>>   erofs_kill_sb+0x81/0x90
>>   deactivate_locked_super+0x35/0x80
>>   get_tree_bdev+0x136/0x1e0
>>   vfs_get_tree+0x2c/0xf0
>>   do_new_mount+0x190/0x2f0
>>   [...]
>> ============================================
>>
>> Now when erofs_kill_sb() is called, erofs_sb_info must have been
>> initialised, so use sbi->fsid to distinguish between the two modes.
>>
>> The Linux kernel CVE team has assigned CVE-2024-36966 to this issue.
>>
>>
>> Affected and fixed versions
>> ===========================
>>
>>     Fixed in 6.6.32 with commit f9b877a7ee31
>>     Fixed in 6.8.11 with commit dcdd49701e42
>>     Fixed in 6.9 with commit 7af2ae1b1531
>
> For reference, this issue doesn't affect Linux kernel below 6.6.
>
> This behavior ("s_bdev may not be initialized in erofs_kill_sb()")
> is introduced due to commit aca740cecbe5 ("fs: open block device after
> superblock creation").
>
> In other words, previously .kill_sb() was called only after
> fill_super failed and problematic erofs_kill_sb() called due to
> setup_bdev_super() failure can only happen since Linux 6.6.
>
> Thanks,
> Gao Xiang

Exactly! I'm so sorry I forgot to add the Fixes tag.


Thanks,
Baokun
>
>>
>> Please see https://www.kernel.org for a full list of currently supported
>> kernel versions by the kernel community.
>>
>> Unaffected versions might change over time as fixes are backported to
>> older supported kernel versions.  The official CVE entry at
>>     https://cve.org/CVERecord/?id=CVE-2024-36966
>> will be updated if fixes are backported, please check that for the most
>> up to date information about this issue.
>>
>>
>> Affected files
>> ==============
>>
>> The file(s) affected by this issue are:
>>     fs/erofs/super.c
>>
>>
>> Mitigation
>> ==========
>>
>> The Linux kernel CVE team recommends that you update to the latest
>> stable kernel version for this, and many other bugfixes. Individual
>> changes are never tested alone, but rather are part of a larger kernel
>> release.  Cherry-picking individual commits is not recommended or
>> supported by the Linux kernel community at all.  If however, updating to
>> the latest release is impossible, the individual changes to resolve this
>> issue can be found at these commits:
>>     https://git.kernel.org/stable/c/f9b877a7ee312ec8ce17598a7ef85cb820d7c371 
>>
>>     https://git.kernel.org/stable/c/dcdd49701e429c55b3644fd70fc58d85745f8cfe 
>>
>>     https://git.kernel.org/stable/c/7af2ae1b1531feab5d38ec9c8f472dc6cceb4606 
>>
>>

