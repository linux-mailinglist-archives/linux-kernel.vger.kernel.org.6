Return-Path: <linux-kernel+bounces-411580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C49CFC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23ECEB28506
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206921917FD;
	Sat, 16 Nov 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XAIaaf1e"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39019149F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726028; cv=none; b=CYxII3qvsbt4EKwduFwoSAkbzHdGgeFy7dQxLb9fmNENd1HqxRJGXkCY3Vwh+UNqp2xnLCiwCmSGfoppQDLLRUNGtViyNAx1a769yyCN6yufRwbDSpmSXdYlHrHRXHUu2jJyEF6dT7/y+vJb21LnZR0OasANHOHHJ8Yku30+UKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726028; c=relaxed/simple;
	bh=J5GVRExHd/Wx/FAq8nwXYA2tkBV+HZyUXupAHROGjZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVJP0HdHazwgLRypapUrvDrzeWXQVMTnUKXzphd5wq1xwy33a3sziAf2Aze5CQjClJWJzgswSu4FwE8TiKFAhdfarjlJ+9EfbRQzjDBlduPLP3x4IA8xHyr2kii4ZGZEU7y/wTxlToUahDlLBc2FgjfIYc/UBIFV1I0SDZh2zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XAIaaf1e; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731726017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H9UBLlphCdhVZDzQqhowJ1Buh+3zpa4QHzk+DvFyodM=;
	b=XAIaaf1emIxD+lvlH1za0WyPob0p61F3qgflwWkN2WguMDkDGIRr29eTIRJdoOaSD8kp45xweGWKzwcxl//CYS1mhtVklD8ONNn8jA7zYynKTePNEQpV1HNRFYlT4+y8fcOLy/MwDJq+gNIqCmnO5R7CHE/s+a1zdb9yLZzvceQ=
Received: from 30.121.23.212(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJVKSl3_1731726014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 16 Nov 2024 11:00:15 +0800
Message-ID: <13bfe4a4-193d-4e8e-a520-7e261b9d6131@linux.alibaba.com>
Date: Sat, 16 Nov 2024 11:00:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: shmem: add a kernel command line to change the
 default huge policy for tmpfs
To: David Hildenbrand <david@redhat.com>, Daniel Gomez
 <da.gomez@samsung.com>, akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <64091a3d5a8c5edb0461fae203cfcf6f302a19ce.1731397290.git.baolin.wang@linux.alibaba.com>
 <CGME20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4@eucas1p2.samsung.com>
 <D5MT3TF12PO7.1A65Y7SMUHI7N@samsung.com>
 <d6dfe598-f7c2-4c3d-b7a3-71b1e928cb04@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d6dfe598-f7c2-4c3d-b7a3-71b1e928cb04@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/15 22:54, David Hildenbrand wrote:
> On 15.11.24 15:02, Daniel Gomez wrote:
>> On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
>>> Now the tmpfs can allow to allocate any sized large folios, and the 
>>> default
>>> huge policy is still 'never'. Thus adding a new command line to change
>>> the default huge policy will be helpful to use the large folios for 
>>> tmpfs,
>>> which is similar to the 'transparent_hugepage_shmem' cmdline for shmem.
>>
>>
>> I think it would be good to include a summary of why tmpfs is not
>> enabling large folios by default as the other fs. David has been
>> pretty good at repeating the reasons over and over and it would be very
>> valuable to have them included here.


OK. I'd like to directly quote David's previous comments. So hope Andew 
can help include the updated commit message:

=====
Now the tmpfs can allow to allocate any sized large folios, and the 
default huge policy is still prefered to be 'never'. Due to tmpfs not 
behaving like other file systems in some cases as previously explained 
by David[1]:

"
I think I raised this in the past, but tmpfs/shmem is just like any
other file system .. except it sometimes really isn't and behaves much
more like (swappable) anonymous memory. (or mlocked files)

There are many systems out there that run without swap enabled, or with
extremely minimal swap (IIRC until recently kubernetes was completely
incompatible with swapping). Swap can even be disabled today for shmem
using a mount option.

That's a big difference to all other file systems where you are
guaranteed to have backend storage where you can simply evict under
memory pressure (might temporarily fail, of course).

I *think* that's the reason why we have the "huge=" parameter that also
controls the THP allocations during page faults (IOW possible memory
over-allocation). Maybe also because it was a new feature, and we only
had a single THP size.
"

Thus adding a new command line to change the default huge policy will be 
helpful to use the large folios for tmpfs, which is similar to the 
'transparent_hugepage_shmem' cmdline for shmem.

[1] 
https://lore.kernel.org/all/cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com/

> Yes. We also discussed in v4 the idea of having a Kconfig option to just 
> change the default policy to "always". We could mention that here as well.

