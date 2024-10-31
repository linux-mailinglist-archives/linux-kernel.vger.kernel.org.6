Return-Path: <linux-kernel+bounces-390314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0D9B7852
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E761C21453
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86851946CF;
	Thu, 31 Oct 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YPvEQJ9H"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C712C478
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369101; cv=none; b=bMruDEuvutxdSTs3hmLkGsve7au8UWZBaVy1QY4KQdsKLVdiWmA3jSQxn1/C+4D2TtykkBJrtbZNZWdxBGhHuKyTdkSBNF2g33fI18ZrMbsEdR8CAI3ffSBBK3IlOK/u8uQOi1lk1mc4uPTEM3BTuhPAt66iBkPIA6hIIwmKwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369101; c=relaxed/simple;
	bh=K6NzIsrGcuy/xHh3It5KMNcd5z0UZVTKwLw8HkUoQ98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZkq1V77B1Y4vGI1RtkIj4ihJ4EMN1pdRvQnxfcDNCWi3sb+dcNdQvHUfCAZYlrtj+mef6/j4xIGEBj23aqSfooGLD04jpeEgaFIWqgwHdjfQcFqPoEaFETXtN6HQpRyP5qj90bLgpWg1j0cQpO0PI/9xGiRrxNJ8S3lIisDTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YPvEQJ9H; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730369095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kxW54KB/34Dmh3dGyprdwmde4eQJWorML/uKda4ik4w=;
	b=YPvEQJ9HdhlFVyeu4fIp5KzfcVDtmt/yoGFRSKvdlm6wLv/Mn6nu326t2ImQ8+Z0DdSP6DX6bkfz9itebENdWGlegdr92P2IBv8MxD/LTeuH7xTNHN5Epb8Ii4r/EpMWlGJCr40/x11pBnP8CAooVsmyUdlUe7A1nmTIuDDCEy4=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WII9li5_1730369092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 18:04:53 +0800
Message-ID: <2782890e-09dc-46bd-ab86-1f8974c7eb7a@linux.alibaba.com>
Date: Thu, 31 Oct 2024 18:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, Daniel Gomez <d@kruces.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
 <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
 <7ca333ba-f9bc-4f78-8f5b-1035ca91c2d5@redhat.com>
 <0b7671fd-3fea-4086-8a85-fe063a62fa80@linux.alibaba.com>
 <d758a4f4-e0e6-4a78-beb4-e513de229310@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d758a4f4-e0e6-4a78-beb4-e513de229310@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/31 16:53, David Hildenbrand wrote:
>>>>
>>>> If we don't want to go with the shmem_enabled toggles, we should
>>>> probably still extend the documentation to cover "all THP sizes", like
>>>> we did elsewhere.
>>>>
>>>> huge=never: no THPs of any size
>>>> huge=always: THPs of any size (fault/write/etc)
>>>> huge=fadvise: like "always" but only with fadvise/madvise
>>>> huge=within_size: like "fadvise" but respect i_size
>>>
>>> Thinking some more about that over the weekend, this is likely the way
>>> to go, paired with conditionally changing the default to
>>> always/within_size. I suggest a kconfig option for that.
>>
>> I am still worried about adding a new kconfig option, which might
>> complicate the tmpfs controls further.
> 
> Why exactly?

There will be more options to control huge pages allocation for tmpfs, 
which may confuse users and make life harder? Yes, we can add some 
documentation, but I'm still a bit cautious about this.

> If we are changing a default similar to 
> CONFIG_TRANSPARENT_HUGEPAGE_NEVER -> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS, 
> it would make perfectly sense to give people building a kernel control 
> over that.
> 
> If we want to support this feature in a distro kernel like RHEL we'll 
> have to leave the default unmodified. Otherwise I see no way (excluding 
> downstream-only hacks) to backport this into distro kernels.
> 
>>
>>> That should probably do as a first shot; I assume people will want more
>>> control over which size to use, especially during page faults, but that
>>> can likely be added later.
> 
> I know, it puts you in a bad position because there are different 
> opinions floating around. But let's try to find something that is 
> reasonable and still acceptable. And let's hope that Hugh will voice an 
> opinion :D

Yes, I am also waiting to see if Hugh has any inputs :)

>> After some discussions, I think the first step is to achieve two goals:
>> 1) Try to make tmpfs use large folios like other file systems, that
>> means we should avoid adding more complex control options (per Matthew).
>> 2) Still need maintain compatibility with the 'huge=' mount option (per
>> Kirill), as I also remembered we have customers who use
>> 'huge=within_size' to allocate THPs for better performance.
> 
>>
>> Based on these considerations, my first step is to neither add a new
>> 'huge=' option parameter nor introduce the mTHP interfaces control for
>> tmpfs, but rather to change the default huge allocation behavior for
>> tmpfs. That is to say, when 'huge=' option is not configured, we will
>> allow the huge folios allocation based on the write size. As a result,
>> the behavior of huge pages for tmpfs will change as follows:
>  > > no 'huge=' set: can allocate any size huge folios based on write size
>  > huge=never: no any size huge folios> huge=always: only PMD sized THP 
> allocation as before
>  > huge=fadvise: like "always" but only with fadvise/madvise> 
> huge=within_size: like "fadvise" but respect i_size
> 
> I don't like that:
> 
> (a) there is no way to explicitly enable/name that new behavior.

But this is similar to other file systems that enable large folios 
(setting mapping_set_large_folios()), and I haven't seen any other file 
systems supporting large folios requiring a new Kconfig. Maybe tmpfs is 
a bit special?

If we all agree that tmpfs is a bit special when using huge pages, then 
fine, a Kconfig option might be needed.

> (b) "always" etc. are only concerned about PMDs.

Yes, currently maintain the same semantics as before, in case users 
still expect THPs.

> So again, I suggest:
> 
> huge=never: No THPs of any size
> huge=always: THPs of any size
> huge=fadvise: like "always" but only with fadvise/madvise 
> huge=within_size: like "fadvise" but respect i_size
> 
> "huge=" default depends on a Kconfig option.
> 
> With that we:
> 
> (1) Maximize the cases where we will use large folios of any sizes
>      (which Willy cares about).
> (2) Have a way to disable them completely (which I care about).
> (3) Allow distros to keep the default unchanged.
> 
> Likely, for now we will only try allocating PMD-sized THPs during page 
> faults, and allocate different sizes only during write(). So the effect 
> for many use cases (VMs, DBs) that primarily mmap() tmpfs files will be 
> completely unchanged even with "huge=always".
> 
> It will get more tricky once we change that behavior as well, but that's 
> something to likely figure out if it is a real problem at at different 
> day :)
> 
> 
> I really preferred using the sysfs toggles (as discussed with Hugh in 
> the meeting back then), but I can also understand why we at least want 
> to try making tmpfs behave more like other file systems. But I'm a bit 
> more careful to not ignore the cases where it really isn't like any 
> other file system.

That's also my previous thought, but Matthew is strongly against that. 
Let's step by step.

> If we start making PMD-sized THPs special in any non-configurable way, 
> then we are effectively off *worse* than allowing to configure them 
> properly. So if someone voices "but we want only PMD-sized" ones, the 
> next one will say "but we only want cont-pte sized-ones" and then we 
> should provide an option to control the actual sizes to use differently, 
> in some way. But let's see if that is even required.

Yes, I agree. So what I am thinking is, the 'huge=' option should be 
gradually deprecated in the future and eventually tmpfs can allocate any 
size large folios as default.

