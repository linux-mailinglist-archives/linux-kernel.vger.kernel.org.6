Return-Path: <linux-kernel+bounces-198126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829418D73BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 06:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372C3282051
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F1BE47;
	Sun,  2 Jun 2024 04:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TSsMipuv"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A4119A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717301754; cv=none; b=fFkDfhh/NkckE4Zvc3DjolhNddYx0N2C2lkVtFi1cTY9R8Us/2gKdm/ijFrhwxeEZ1gHKrnsaf+jgcssWVhJIY1Lp7xAYpJYwIoqazFlpP+LG8UzrUrrfpEZXbFmL+XOpCSxQzilfSmiBU5/BtG4uiid4QBR0j0BmWXm0CtRKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717301754; c=relaxed/simple;
	bh=pP23c34d1k7vsjNfiIwhW6IBcKFaRNdTPn6CMR1xTT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMX6Vhi2YnEwKdMk0juaZAVpUieKH/bWHZaz6s70aiunvVAZvrsf50/A6NTr1XM2HGsmLkyRGQ1DX5Xfz9vpHHYTYpMAGYdUwL7lqVMx5yf6pXg4qLE8zfdlQmDsOxtPLWKmvcRhd5AfO7K1tJ7d38d/opYVcb+yDHPz44ZrbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TSsMipuv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717301743; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=H/RSLeYXVTSGVuTsSLN6zoli4sMA0dh6fPFicS8Jvbs=;
	b=TSsMipuvMLDDvz9m6R1SwzusmaZ3bKkcp8uXLY3PdcQlvG5beL458cQgvTBfdwExfriVNaeGmuto7yzKVNaxNU7kUa7l6DEzhfFVqFwA0NglJekebHsEa8xq4ac6W5Wv7wLg480ugAir/sKfWWAinX++bzty16xZHHjkvM/AYuQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7do2aB_1717301741;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7do2aB_1717301741)
          by smtp.aliyun-inc.com;
          Sun, 02 Jun 2024 12:15:42 +0800
Message-ID: <cce7a033-08ab-4d5e-967e-9b9493a2600e@linux.alibaba.com>
Date: Sun, 2 Jun 2024 12:15:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
 <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/31 19:13, David Hildenbrand wrote:
>>>
>>> As a default, we should not be using large folios / mTHP for any shmem,
>>> just like we did with THP via shmem_enabled. This is what this series
>>> currently does, and is aprt of the whole mTHP user-space interface 
>>> design.
>>>
>>> Further, the mTHP controls should control all of shmem, not only
>>> "anonymous shmem".
>>
>> Yes, that's what I thought and in my TODO list.
> 
> Good, it would be helpful to coordinate with Daniel and Pankaj.
> 
>>
>>>
>>> Also, we should properly fallback within the configured sizes, and not
>>> jump "over" configured sizes. Unless there is a good reason.
>>>
>>> (3) khugepaged
>>>
>>> khugepaged needs to handle larger folios properly as well. Until fixed,
>>> using smaller THP sizes as fallback might prohibit collapsing a
>>> PMD-sized THP later. But really, khugepaged needs to be fixed to handle
>>> that. >
>>> (4) force/disable
>>>
>>> These settings are rather testing artifacts from the old ages. We should
>>> not add them to the per-size toggles. We might "inherit" it from the
>>> global one, though.
>>
>> Sorry, I missed this. So I thould remove the 'force' and 'deny' option
>> for each mTHP, right?
> 
> Yes, that's my understanding. But we have to keep them on the top level 
> for any possible user out there.

OK.

>>>
>>> "within_size" might have value, and especially for consistency, we
>>> should have them per size.
>>>
>>>
>>>
>>> So, this series only tackles anonymous shmem, which is a good starting
>>> point. Ideally, we'd get support for other shmem (especially during
>>> fault time) soon afterwards, because we won't be adding separate toggles
>>> for that from the interface POV, and having inconsistent behavior
>>> between kernel versions would be a bit unfortunate.
>>>
>>>
>>> @Baolin, this series likely does not consider (4) yet. And I suggest we
>>> have to take a lot of the "anonymous thp" terminology out of this
>>> series, especially when it comes to documentation.
>>
>> Sure. I will remove the "anonymous thp" terminology from the
>> documentation, but want to still keep it in the commit message, cause I
>> want to start from the anonymous shmem.
> 
> For commit message and friends makes sense. The story should be 
> "controls all of shmem/tmpfs, but support will be added iteratively. The 
> first step is anonymous shmem."

Sure. Thanks.

