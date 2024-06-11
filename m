Return-Path: <linux-kernel+bounces-209776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B94903A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AADB22E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3117C20D;
	Tue, 11 Jun 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F585devi"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026617C200
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105985; cv=none; b=S5Qbm+3xTlGPUpCeNwAu7XdKiWHk8dSGQRY2hEkxO8yLXy2cAoT3d8lBII/17uQWweIIz3J7/tYE3ZJUct2P/NVgd4/lY2W9Bv7iHesb3UB3uQamkB9q/4EBeomvnoECeRWZ5IoYafMsouTohtLqUt9bdmZYxq5RhkHreuPlMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105985; c=relaxed/simple;
	bh=KqONxeNIMsezUH/vByN9ckLxEs1MQv3fWFXbHJsEV9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBWDstQd1vGRjIuq+4mrbgspQV4g8nPC1C282MDyn70zjYQ+fFf3YVXoymBlIotW4+nzGW1RPKsWCIXrz37b5FprQYAykv78xJWYBSk8pkSuJ+dDrCrwA9bVPqAkrGTowtkuyJmmmvCHMBYWDPv+lg2CgH7mtH/HVFNuRSJWohc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F585devi; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718105980; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OVUFDlMITzMq7x7Jd4SoAFKf9m70eZxH5vbvcK8ja40=;
	b=F585devi7FVEzp3LiNVPfTmfHgjbtciynQ6JNBshzvDj97w0iFEGbY9T7+NgY6IS6HwJfzq1Kg8o7hYRASS6rIqYRhHl5ohApWVRuu7Z2uwQc3mMNJ9EPRPNsal9CJVdy/Mn4WVXZop5Oeqrb9PXMnKhPoBvw6u10txcjzfB7KE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GL.6F_1718105977;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8GL.6F_1718105977)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:39:38 +0800
Message-ID: <80a05784-21dd-4f20-b441-1e2a2be0e0ff@linux.alibaba.com>
Date: Tue, 11 Jun 2024 19:39:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline
 6.10.rc3
To: David Hildenbrand <david@redhat.com>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <baohua@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com>
 <e8c10a52-61f9-4b46-bc50-e2c267b1aa56@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <e8c10a52-61f9-4b46-bc50-e2c267b1aa56@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/11 18:32, David Hildenbrand wrote:
> On 11.06.24 12:14, Naresh Kamboju wrote:
>> The kernel panic was noticed while running LTP syscalls fork13 (long 
>> running) on
>> the mainline master 6.10.rc3 kernel on arm64 rk3399-rock-pi-4 device.
>>
>> Please find detailed logs in the links,
>>
>> As you know fork13 is a stress test case trying to generate a maximum 
>> number
>> of PID's in a 100,000 loop.
>>
>> This device is running via NFS mounted filesystem.
>>
>> I have tried to reproduce this problem in a loop but failed to 
>> reproduce the
>> crash.
>>
>>
>> Crash flow:
>> ------
>> fork13 run started
>> BUG: Bad page map in process fork13
>> BUG: Bad rss-counter state mm:
>> Unable to handle kernel paging request at virtual address
>> Internal error: Oops: 0000000096000046
>> run for 800 secs ( 13 minutes) and more.
>> fork14 run started and completed
>>
>> fpathconf01 run started and completed
>> sugov:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address
>>
>> Insufficient stack space to handle exception!
>> end Kernel panic - not syncing: kernel stack overflow
>>
>> I have tried to decode stack dump by not being useful [1].
>> [1] https://people.linaro.org/~naresh.kamboju/output-rk3399.txt
>>
>> Test log :
>> --------
>> tst_test.c:1733: TINFO: LTP version: 20240524
>> tst_test.c:1617: TINFO: Timeout per run is 0h 15m 00s
>> [  904.280569] BUG: Bad page map in process fork13  pte:2000000019ffc3
>> pmd:80000000df55003
>> [  904.281397] page: refcount:1 mapcount:-1 mapping:0000000000000000
>> index:0x0 pfn:0x19f
> 
> Mapcount underflow on a small folio (head: not printed).
> 
> [...]
> 
>> [  904.294564] BUG: Bad page map in process fork13  pte:200000002e4fc3
>> pmd:80000000df55003
>> [  904.295275] page: refcount:2 mapcount:-1 mapping:000000007885152f
>> index:0x6 pfn:0x2e4
> 
> Another mapcount underflow on a small folio (head: not printed).
> 
> 
>> [  904.309309] BUG: Bad page map in process fork13  pte:20000000cc6fc3
>> pmd:80000000df55003
>> [  904.310031] page: refcount:1 mapcount:-1 mapping:0000000000000000
>> index:0x6 pfn:0xcc6
>> [  904.310728] head: order:3 mapcount:-1 entire_mapcount:0
>> nr_pages_mapped:8388607 pincount:0
> 
> Mapcount underflow on a large folio.
> 
> ...
> 
>> [  904.326666] BUG: Bad page map in process fork13  pte:20000000268fc3
>> pmd:80000000df55003
>> [  904.327390] page: refcount:1 mapcount:-1 mapping:00000000f0624181
>> index:0x1b pfn:0x268
> 
> Another mapcount underflow on a small folio (head: not printed).
> 
>> [  904.328094] memcg:ffff0000016b4000
>> [  904.328401] aops:nfs_file_aops ino:8526e6 dentry
>> name:"libgpg-error.so.0.36.0"
>> [  904.329051] flags:
>> 0x3fffe000000002c(referenced|uptodate|lru|node=0|zone=0|lastcpupid=0x1ffff)
>> [  904.329878] raw: 03fffe000000002c fffffdffc0009a48 fffffdffc022f3c8
>> ffff00000688bd60
>> [  904.330561] raw: 000000000000001b 0000000000000000 00000001fffffffe
>> ffff0000016b4000
>> [  904.331240] page dumped because: bad pte
>> [  904.331590] addr:0000aaaad9afe000 vm_flags:00000075
>> anon_vma:0000000000000000 mapping:ffff0000300d4188 index:2e
>> [  904.332476] file:fork13 fault:filemap_fault mmap:nfs_file_mmap
>> read_folio:nfs_read_folio
>> [  904.333245] CPU: 5 PID: 22685 Comm: fork13 Tainted: G    B
> 
> 
> Are these maybe side-effects due to
> 
> https://lkml.kernel.org/r/20240607103241.1298388-1-wangkefeng.wang@huawei.com

IIUC, the rk3399-rock-pi-4b device has no NUMA nodes (6 arm64 cores), so 
I don't think the numa balancing will cause this issue.

Anyway, I will run fork13 test case on my arm64 server to try.

