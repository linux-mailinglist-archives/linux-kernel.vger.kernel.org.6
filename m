Return-Path: <linux-kernel+bounces-375541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA469A9725
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C442827FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585712E1CA;
	Tue, 22 Oct 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iyqrztnD"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39E2110E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568062; cv=none; b=C4TvG39g+mEjn1aysS8dI2NtFfqMVkOrtCxOyZKFnFA09TKtAqDd8pvnm2PFVA2OXtGcSn5kgfDgdCFDrtyObzKFOjq+4MpmsCJdDQySi6avPxyfptMPmBgMKjlDFtILz1Osk8tChpaULIq8DyDFs7ClNJ2PZXU78syeG+L0+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568062; c=relaxed/simple;
	bh=NvFcoLdO5B5977/kT1+5tyV9WhPQYWvFCEpuTO+c70s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0d4xfhAwSI1hHEmQvaPiW7kPZO8KcDEClisZ0qoPq+sqH8m5yy5wyN6EidgMZr8yv1joYAhVfEQWg8L3Rncm1Zfi9VQJFzZSWFgFh9MWmlNvCq4SwoHGbhZ71Jk6gMumRAwTvWMz8F1joLUKT36tlMPSdYcrDCc9mQPahrDMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iyqrztnD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729568057; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+mCA/Ku9P9aJGHHaHesY9FGYchTbxDumxyCuDvQcJT4=;
	b=iyqrztnDCklLE8nmSupMzvQI36oAdAjmyey3vqAD7oPsKsGodnP+DlrT9M22UFEhS4RIRH2w7pizOVo7QnVPLa9wm6XBQqmgwWaEaGFlb+M3xTe5XqPytXvMHMbI9pDbXPGTpKimvFxIBJKW4J0iS7h1OgnDZOWjwuc/JGaEpc0=
Received: from 30.74.144.133(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHgRv3t_1729568054 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 11:34:15 +0800
Message-ID: <2c6b7456-8846-44b0-8e58-158c480aaead@linux.alibaba.com>
Date: Tue, 22 Oct 2024 11:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, ioworker0@gmail.com,
 da.gomez@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/21 16:54, Kirill A. Shutemov wrote:
> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
>>
>>
>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
>>> On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
>>>> + Kirill
>>>>
>>>> On 2024/10/16 22:06, Matthew Wilcox wrote:
>>>>> On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>>>>>> Considering that tmpfs already has the 'huge=' option to control the THP
>>>>>> allocation, it is necessary to maintain compatibility with the 'huge='
>>>>>> option, as well as considering the 'deny' and 'force' option controlled
>>>>>> by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>
>>>>> No, it's not.  No other filesystem honours these settings.  tmpfs would
>>>>> not have had these settings if it were written today.  It should simply
>>>>> ignore them, the way that NFS ignores the "intr" mount option now that
>>>>> we have a better solution to the original problem.
>>>>>
>>>>> To reiterate my position:
>>>>>
>>>>>     - When using tmpfs as a filesystem, it should behave like other
>>>>>       filesystems.
>>>>>     - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
>>>>>       behave like anonymous memory.
>>>>
>>>> I do agree with your point to some extent, but the ‘huge=’ option has
>>>> existed for nearly 8 years, and the huge orders based on write size may not
>>>> achieve the performance of PMD-sized THP in some scenarios, such as when the
>>>> write length is consistently 4K. So, I am still concerned that ignoring the
>>>> 'huge' option could lead to compatibility issues.
>>>
>>> Yeah, I don't think we are there yet to ignore the mount option.
>>
>> OK.
>>
>>> Maybe we need to get a new generic interface to request the semantics
>>> tmpfs has with huge= on per-inode level on any fs. Like a set of FADV_*
>>> handles to make kernel allocate PMD-size folio on any allocation or on
>>> allocations within i_size. I think this behaviour is useful beyond tmpfs.
>>>
>>> Then huge= implementation for tmpfs can be re-defined to set these
>>> per-inode FADV_ flags by default. This way we can keep tmpfs compatible
>>> with current deployments and less special comparing to rest of
>>> filesystems on kernel side.
>>
>> I did a quick search, and I didn't find any other fs that require PMD-sized
>> huge pages, so I am not sure if FADV_* is useful for filesystems other than
>> tmpfs. Please correct me if I missed something.
> 
> What do you mean by "require"? THPs are always opportunistic.
> 
> IIUC, we don't have a way to hint kernel to use huge pages for a file on
> read from backing storage. Readahead is not always the right way.

IIUC, most file systems use method similar to iomap buffered IO (see 
iomap_get_folio()) to allocate huge pages. What I mean is that, it would 
be better to have a real use case to add a hint for allocating THP 
(other than tmpfs).

>>> If huge= is not set, tmpfs would behave the same way as the rest of
>>> filesystems.
>>
>> So if 'huge=' is not set, tmpfs write()/fallocate() can still allocate large
>> folios based on the write size? If yes, that means it will change the
>> default huge behavior for tmpfs. Because previously having 'huge=' is not
>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar to what I
>> mentioned:
>> "Another possible choice is to make the huge pages allocation based on write
>> size as the *default* behavior for tmpfs, ..."
> 
> I am more worried about breaking existing users of huge pages. So changing
> behaviour of users who don't specify huge is okay to me.

OK. Good.

