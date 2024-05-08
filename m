Return-Path: <linux-kernel+bounces-172711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6848BF5B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF97B245F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34317BA7;
	Wed,  8 May 2024 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qOHyCnLz"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD81756A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147161; cv=none; b=UR3FoPAkWV8sD3l2ZTYJElKoJlH+3hIrTO4TyEMTKNyPLYN5pvUWGahFQhql9bN4ur+zjqT3i9TZEVf1PMFc6ZliDhBmsoWZcaLLG7e6DI8eVXhpmLM8wGaNfv0EoyIhBPSUkcngtcBg9+P8iAfg4s4AtzCqBnI+/9v3TA0rBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147161; c=relaxed/simple;
	bh=J21Eo2tKBXr5KMuTKsw0F3/e2fy1RaUgXCNjUlYRb7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdkXkpdE+cP2QP3gj+7lkRWvTwYpbjCYzw80UlO413odjR37DL+peH5EkmtB3wJI5+x4N47/nZi567TT4Ym/Q+CtldI+Iq3T7OZ0xS9kjPBbRv+FSjOp1j4lDEplc7c+Q6DHCBfCNnDNTIr6+lmsz5PH64lc2JrEm8W8dihvOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qOHyCnLz; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715147152; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OzZltckyuroXeYNzcs/5r87Nh20cbeVKjeOhmTiFlQc=;
	b=qOHyCnLzNHCk1K1DmBY9BaxlaEUIBAfg7Jh4RlWMPPdDR+HW0inxWz0FG2vbneIcGMtEsIYAIHuofHvzEKhCOVpByI4CUwXlJ5XiBzHdtfG4kqM3R1gGf5osqADicxRb7nzcRkJbyfmmslgWgat7U1ErGHk7DRY5GiDvcUQ+UYk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W62Fj9e_1715147148;
Received: from 30.97.56.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W62Fj9e_1715147148)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 13:45:50 +0800
Message-ID: <e1e6867f-ed97-49f0-8272-8cdc0f6463b0@linux.alibaba.com>
Date: Wed, 8 May 2024 13:45:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <d887b469-312f-433b-b7a1-a290a381d4d5@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d887b469-312f-433b-b7a1-a290a381d4d5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/7 18:20, Ryan Roberts wrote:
> On 06/05/2024 09:46, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>> through commit 19eaf44954df, that can allow THP to be configured through the
>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Many implement anonymous page sharing through
>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>> also including the anonymous shared pages, in order to enjoy the benefits of
>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have all the same values as the top-level
> 
> Didn't we agree that "force" would not be supported for now, and would return an
> error when attempting to set for a non-PMD-size hugepage-XXkb/shmem_enabled (or
> indirectly through inheritance)?

Yes. Sorry, I did not explain it in detail in the cover letter. Please 
see patch 5 you already commented.

