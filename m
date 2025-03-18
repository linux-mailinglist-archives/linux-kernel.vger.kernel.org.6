Return-Path: <linux-kernel+bounces-565274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D5A66500
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053F0179027
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3581A140E30;
	Tue, 18 Mar 2025 01:29:21 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AAC2C8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261360; cv=none; b=ZjMxVJcNEV90iFOJIzdHMs0ieAxwXCBkZTCtX4YgMacCAa9mc86kPWg5YnbsdyzQ9lkISf9vFW0RhvK+0E6anH5JhMWPkWOcwFQ8XPgXbclEBfuo81hrrWF7Wvz1PNjFT9eQUWGJ4nTCLu8emWRDuDxLRDtrhOvGgTmAIlD64f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261360; c=relaxed/simple;
	bh=DyKI/vbVVhloLg7uPsw2UGOwH4e66OZ5Nnr2XxdXSU0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PShRQ2cgvGd71TqxXpRgVvPqY/W2HiO6IH56c8Vuy/GSyQT6/AsHHXKXojZs+ucj7og/GDzHBtnHHpJAoakIH8bsGbdGcvz2afs4EYkGIWpELau1KkW0C/CPpKebsQf6pC2YjJNBXhfYN3hfJaIUwaPPNJye7T0RxKcRihz0gI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZGvPW37Hlz4f3lW3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:28:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 816EB1A0D4D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:29:11 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgDnlltlzNhnzv4+Gw--.16554S2;
	Tue, 18 Mar 2025 09:29:11 +0800 (CST)
Subject: Re: [PATCH 0/9] Minor cleanups and improvements to swap freeing code
To: Tim Chen <tim.c.chen@linux.intel.com>, akpm@linux-foundation.org
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
 <94a5ebb9bd4c8076f23489e014462ac6d169cae0.camel@linux.intel.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <91963cc7-a02d-08ff-6063-a1d97e69d8f6@huaweicloud.com>
Date: Tue, 18 Mar 2025 09:29:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <94a5ebb9bd4c8076f23489e014462ac6d169cae0.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnlltlzNhnzv4+Gw--.16554S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8Cw4UJr47Gw4UJw1xGrg_yoW5Zr18pF
	Wag3ZxKF1kXr1Iyrn7Aw10qw1Fq3yrKFyUG3WUur1rZ3ZxGF1ruryvyrZ5CFyDu395X34U
	tF48K34Uu3ZYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/15/2025 4:27 AM, Tim Chen wrote:
> On Fri, 2025-03-14 at 05:05 +0800, Kemeng Shi wrote:
>> Hi All,
>> This series contains some cleanups and improvements which are made
>> during learning swapfile. Here is a summary of the changes:
> 
Hello,

> Nice work>
>> 1. Function nameing improvments.
>> -Use "put" instead of "free" to name functions which only do actual free
>> when count drops to zero.
>> -Use "entry" to name function only frees one swap slot. Use "entries" to
>> name function could may free multi swap slots within one cluster. Use
>> "_nr" suffix to name function which could free multi swap slots spanning
>> cross multi clusters.
> 
> Will be nice to add some comments in the code about functions with _nr 
> crossing the cluster boundaries and those without stay within a cluster. 
Thanks for reviewing and all advises to this series. Will improve in next
version.
> 
>> 2. Eliminate the need to set swap slot to intermediate SWAP_HAS_CACHE
>> value before do actual free by using swap_entry_range_free()
>> 3. Add helpers swap_entries_put_map() and swap_entries_put_cache() as a
>> general-purpose routine to free swap entries within a single cluster
>> which will try batch-remove first and fallback to put eatch entry
>> indvidually with cluster lock acquired/released only once. By using 
>> these helpers, we could remove repeated code, levarage batch-remove in
>> more cases and aoivd to acquire/release cluster lock for each single
>> swap entry.
> 
> Wonder if the batching shows up in any swap performance improvement
I have a simple test which is roughly as following:
#define SIZE 1024*1024*1024
#define HP_SIZE 2 * 1024 * 1024
p = mmap(...,SIZE,...)
madvise(p, SIZE, MADV_HUGEPAGE)
memset(p, 0x11, SIZE); /* alloc page */
madvise(p, SIZE, MADV_PAGEOUT); /* swap out */
gettimeofday(&tv_b, NULL);
for (j = 0; j < SIZE; j+= HP_SIZE) {
	((char *)p)[j] = 0; /* swap in and free swap entry */
}

The time for swap-in and free swap entry shows no significant change.
Since this is more of a cleanup series, no further testing has been
conducted yet. I would appreciate it if you have any additional test
cases that could benefit from batching.

Thank,
Kemeng
.
> 
> Tim
> 
>>
>> Kemeng Shi (9):
>>   mm: swap: rename __swap_[entry/entries]_free[_locked] to
>>     swap_[entry/entries]_put[_locked]
>>   mm: swap: factor out the actual swap entry freeing logic to new helper
>>   mm: swap: use __swap_entry_free() to free swap entry in
>>     swap_entry_put_locked()
>>   mm: swap: remove unneeded VM_BUG_ON(*map != SWAP_HAS_CACHE) in
>>     swap_entry_range_free()
>>   mm: swap: use swap_entries_free() drop last 1 flag in
>>     swap_entries_put_nr()
>>   mm: swap: drop last SWAP_MAP_SHMEM flag in batch in
>>     swap_entries_put_nr()
>>   mm: swap: free each cluster individually in swap_entries_put_map_nr()
>>   mm: swap: factor out helper to drop cache of entries within a single
>>     cluster
>>   mm: swap: replace cluster_swap_free_nr() with
>>     swap_entries_put_[map/cache]()
>>
>>  mm/swapfile.c | 173 +++++++++++++++++++++++++-------------------------
>>  1 file changed, 86 insertions(+), 87 deletions(-)
>>
> 
> 


