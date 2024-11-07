Return-Path: <linux-kernel+bounces-399532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD939C0040
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0459283C67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740319F120;
	Thu,  7 Nov 2024 08:44:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADDD53F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969049; cv=none; b=D/pbtA3gz2elb9YyOgOMeNstoN5VV+Kvou2x+JWQB6E6aeubRUq/14fgTb0mNcmFREqJ4OZQmsIMIiFiQ95a5VtV+YMXKmAll3CPs7kDUoN7D7yqjm19igNNUqG9vpiOB3RfamLRm0jc9y4uMTPEmUM1ckiIiKRdRy1cV6+QQRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969049; c=relaxed/simple;
	bh=2ShyfYHasgBMu3XS7fVerF4MEpeh/ji+H3mNwEWOhEs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HvN6AG1UcL/j0Q7bl+jCnjy61nJjFqm4rfd/QNlDsISTGptIcCmejwa4UBklqVVpfpbibjYG14ZvDsuTHdbLHK3hKRx/fYHiR4LZhlXY8Ahojjv1RyhwhNcOGHuT+i3rCd23BSyB+crIYE2q5w5hEE8XguZ9hwYjgDDxwTb+ELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XkbDF1pcnz1jwXJ;
	Thu,  7 Nov 2024 16:42:21 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A2E41401E9;
	Thu,  7 Nov 2024 16:44:03 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 16:43:55 +0800
Message-ID: <7e860861-c7cb-401f-ac92-61db92fa4d8b@huawei.com>
Date: Thu, 7 Nov 2024 16:43:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>, <xrivendell7@gmail.com>,
	<wang1315768607@163.com>, <fleischermarius@gmail.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in
 copy_page_range()
To: <david@redhat.com>, <peterx@redhat.com>
References: <20241029210331.1339581-1-david@redhat.com> <ZyKl_cRRUmZGbp9G@x1n>
 <8c494db6-1def-44ea-84ef-51d0140bddf3@redhat.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <8c494db6-1def-44ea-84ef-51d0140bddf3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/10/31 17:47, David Hildenbrand wrote:
> On 30.10.24 22:32, Peter Xu wrote:
>> On Tue, Oct 29, 2024 at 10:03:31PM +0100, David Hildenbrand wrote:
>>> If track_pfn_copy() fails, we already added the dst VMA to the maple
>>> tree. As fork() fails, we'll cleanup the maple tree, and stumble over
>>> the dst VMA for which we neither performed any reservation nor copied
>>> any page tables.
>>>
>>> Consequently untrack_pfn() will see VM_PAT and try obtaining the
>>> PAT information from the page table -- which fails because the page
>>> table was not copied.
>>>
>>> The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
>>> if track_pfn_copy() fails. However, the whole thing is about "simply"
>>> clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
>>> and performed a reservation, but copying the page tables fails, we'll
>>> simply clear the VM_PAT flag, not properly undoing the reservation ...
>>> which is also wrong.
>>
>> David,
>>
> 
> Hi Peter,
> 
>> Sorry to not have chance yet reply to your other email..
>>
>> The only concern I have with the current fix to fork() is.. we started to
>> have device drivers providing fault() on PFNMAPs as vfio-pci does, then I
>> think it means we could potentially start to hit the same issue even
>> without fork(), but as long as the 1st pgtable entry of the PFNMAP range is
>> not mapped when the process with VM_PAT vma exit()s, or munmap() the vma.
> 
> As these drivers are not using remap_pfn_range, there is no way they could currently get VM_PAT set.
> 
> So what you describe is independent of the current state we are fixing here, and this fix should sort out the issues with current VM_PAT handling.
> 
> It indeed is an interesting question how to handle reservations when *not* using remap_pfn_range() to cover the whole area.
> 
> remap_pfn_range() handles VM_PAT automatically because it can do it: it knows that the whole range will map consecutive PFNs with the same protection, and we expect not parts of the range suddenly getting unmapped (and any driver that does that is buggy).
> 
> This behavior is, however, not guaranteed to be the case when remap_pfn_range() is *not* called on the whole range.
> 
> For that case (i.e., vfio-pci) I still wonder if the driver shouldn't do the reservation and leave VM_PAT alone.
> 
> In the driver, we'd do the reservation once and not worry about fork() etc ... and we'd undo the reservation once the last relevant VM_PFNMAP VMA is gone or the driver let's go of the device. I assume there are already mechanisms in place to deal with that to some degree, because the driver cannot go away while any VMA still has the VM_PFNMAP mapping -- otherwise something would be seriously messed up.
> 
> Long story short: let's look into not using VM_PAT for that use case.
> 
> Looking at the VM_PAT issues we had over time, not making it more complicated sounds like a very reasonable thing to me :)

Hi David,

The VM_PAT reservation do seems complicated. It can trigger the same warning in get_pat_info if remap_p4d_range fails:

remap_pfn_range
  remap_pfn_range_notrack
    remap_pfn_range_internal
      remap_p4d_range	// page allocation can failed here
    zap_page_range_single
      unmap_single_vma
        untrack_pfn
          get_pat_info
            WARN_ON_ONCE(1);

Any idea on this problem?

> 


