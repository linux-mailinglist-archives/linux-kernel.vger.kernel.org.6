Return-Path: <linux-kernel+bounces-405124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2FF9C4D38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A04284D74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68844207A14;
	Tue, 12 Nov 2024 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q2E4YcB6"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BA205AD6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381603; cv=none; b=D5rmLzfWdkw7VREZuBVHPcY3PYJJjyXwqCVHmsduQpFzEiBoDe/rEj2B0r9y5v/nqcNT5DiNCFrrJi+jJ9ZRI/6/DkhWtapkYfnBgIMKEA+DT6HnOXqK7J1LS5j00DX203Y+duHsMkmYddxMvurm4gTgokgmxSL6BOXmP6/2WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381603; c=relaxed/simple;
	bh=H5MhTUzaqEvc7R5sYo+bar5EY0cg4c7zl0PllNDdkpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjf+ZxtQs61947APmasMqDv7LJcHtFuj5vA3qoUscnCh4cSomIAHEqJrfTIHjxxVXRbvfyjrXS+LxVMcjo1l2+U7dCSDYK4eE64xkfVOAg0gM6wfAFpIULg7GupmznNXeZpxcktt8lttJEaG7FzJ4gZtlPhvd3MPFB8NgGQNsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q2E4YcB6; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731381593; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vAs1rV77DkI2iKDI266dN+In2P7tHRg+caJMvkuicwo=;
	b=q2E4YcB6AFPKouqq5MU4YBdfnl+C1YwFciMChKeabH3YbejT0QaawoIiCGUZltU67GvLZX6x0PDUVWunqGGLbSbO+KUYod7FMgfwpGB4B75PXBmM7giJ8cILhIx4mVrisYHJJO9F8llFuZ3+CDr0bhyA8E1ut4ivzGjYVg1hNHA=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJFQ5jo_1731381590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 11:19:51 +0800
Message-ID: <87df7d30-6ef1-49d4-9a94-ce78e0ffc5af@linux.alibaba.com>
Date: Tue, 12 Nov 2024 11:19:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
 <3d49fbf8-866f-485b-b7fa-a89bbfb3cd7c@redhat.com>
 <fabfc6d6-6693-40ca-b2c6-769882b19178@linux.alibaba.com>
 <d9b23bde-f3c7-4991-8cbe-3915bb9279d0@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d9b23bde-f3c7-4991-8cbe-3915bb9279d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 03:47, David Hildenbrand wrote:
> On 09.11.24 08:12, Baolin Wang wrote:
>>
>>
>> On 2024/11/8 23:30, David Hildenbrand wrote:
>>> On 08.11.24 05:12, Baolin Wang wrote:
>>>> Traditionally, tmpfs only supported PMD-sized huge folios. However
>>>> nowadays
>>>> with other file systems supporting any sized large folios, and 
>>>> extending
>>>> anonymous to support mTHP, we should not restrict tmpfs to allocating
>>>> only
>>>> PMD-sized huge folios, making it more special. Instead, we should allow
>>>> tmpfs can allocate any sized large folios.
>>>>
>>>> Considering that tmpfs already has the 'huge=' option to control the 
>>>> huge
>>>> folios allocation, we can extend the 'huge=' option to allow any sized
>>>> huge
>>>> folios. The semantics of the 'huge=' mount option are:
>>>>
>>>> huge=never: no any sized huge folios
>>>> huge=always: any sized huge folios
>>>> huge=within_size: like 'always' but respect the i_size
>>>> huge=advise: like 'always' if requested with fadvise()/madvise()
>>>>
>>>> Note: for tmpfs mmap() faults, due to the lack of a write size hint,
>>>> still
>>>> allocate the PMD-sized huge folios if huge=always/within_size/advise
>>>> is set.
>>>
>>> So, no fallback to smaller sizes for now in case we fail to allocate a
>>> PMD one? Of course, this can be added later fairly easily.
>>
>> Right. I have no strong preference on this. If no one objects, I can add
>> a fallback to smaller large folios if the PMD sized allocation fails in
>> the next version.
> 
> I'm fine with a staged approach, to perform this change separately.

Sure.

>>>> Moreover, the 'deny' and 'force' testing options controlled by
>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the
>>>> same
>>>> semantics. The 'deny' can disable any sized large folios for tmpfs, 
>>>> while
>>>> the 'force' can enable PMD sized large folios for tmpfs.
>>>>
>>>> Any comments and suggestions are appreciated. Thanks.
>>>>
>>>> Hi David,
>>>> I did not add a new Kconfig option to control the default behavior of
>>>> 'huge='
>>>> in the current version. I have not changed the default behavior at this
>>>> time, and let's see if there is a need for this.
>>>
>>> Likely we want to change the default at some point so people might get a
>>> benefit in more scenarios automatically. But I did not investigate how
>>> /tmp is mapped as default by Fedora, for example.
>>
>> Personally, adding a cmdline to change the default value might be more
>> useful than the Kconfig. Anyway, I still want to investigate if there is
>> a real need.
> 
> Likely both will be reasonable to have.
> 
> FWIW, "systemctl cat tmp.mount" on a Fedora40 system tells me
> "Options=mode=1777,strictatime,nosuid,nodev,size=50%%,nr_inodes=1m"
> 
> To be precise:
> 
> $ grep tmpfs /etc/mtab
> vendorfw /usr/lib/firmware/vendor tmpfs rw,relatime,mode=755,inode64 0 0
> devtmpfs /dev devtmpfs 
> rw,nosuid,size=4096k,nr_inodes=4063361,mode=755,inode64 0 0
> tmpfs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0
> tmpfs /run tmpfs 
> rw,nosuid,nodev,size=6511156k,nr_inodes=819200,mode=755,inode64 0 0
> tmpfs /tmp tmpfs 
> rw,nosuid,nodev,size=16277892k,nr_inodes=1048576,inode64 0 0
> tmpfs /run/user/100813 tmpfs 
> rw,nosuid,nodev,relatime,size=3255576k,nr_inodes=813894,mode=700,uid=100813,gid=100813,inode64 0 0
> 
> 
> Having a way to change the default will likely be extremely helpful.

Thanks. I'd like to add a command line option like 
'transparent_hugepage_shmem' to control the default value.

