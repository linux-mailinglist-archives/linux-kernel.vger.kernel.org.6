Return-Path: <linux-kernel+bounces-245049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D192AD8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CC11C21424
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CAD2AEE1;
	Tue,  9 Jul 2024 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QsVWUxHq"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760312C1AC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487257; cv=none; b=OFLDX6nS0gCNZ6andUOeqaoQxq6ofzkd5/tJe6to8uq+UE/9NtXrE9Q12QEj1u7DH5jiGvh3VvxOYmeMFz+rIu1KGXctW28KtYOJQzyiEy+YlpsyBsnkfvGH6LSCnTSvj/4qcMzW70AIHxPyEYiuWntU6p9QY7u0pOq6DcRlx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487257; c=relaxed/simple;
	bh=vJEZgvhJlVfzSmPe4+aP0V+d+0pf77ffDYj2CwhdXUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAWspZSRbqyZXhgX9XDQVkvabY3u305Ea9TxCVATwv4BH1DUPlE48NIFPwUypRwtorGLXHu3x4+gf937KOPpGO6TMT1FESnLnVag8SoE1Zh7XGAAN9MADvKx1HVylDIvbAMyYnYshUm69QtxWz+TKmbCkyRAs7KXD00IsEnI4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QsVWUxHq; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720487253; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mECnJeehZNBoxiLQRn/E4jwV446jfFeTcaKLoHUc6Zg=;
	b=QsVWUxHqzPrsSRZFtCmnsSIGID+B9p1t/K8/ngloj4fAbvzupibE/UJxPfikC0XGMrxNZuXeMk4WOPHeeM63DTxl99p42rIj3HDuTeAaF1i5cen7XesAo3WzffJlBnF0qKz+xWbj//qcu3u1WH81uqHLnIdEPshDCMJhj6Yk8Qc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WA9bRN5_1720487250;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WA9bRN5_1720487250)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 09:07:31 +0800
Message-ID: <2672552a-b252-42ba-964b-db25413a418c@linux.alibaba.com>
Date: Tue, 9 Jul 2024 09:07:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
 <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/8 20:29, Ryan Roberts wrote:
> On 08/07/2024 12:36, Barry Song wrote:
>> On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> The legacy PMD-sized THP counters at /proc/vmstat include
>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
>>> rather confusingly refer to shmem THP and do not include any other types
>>> of file pages. This is inconsistent since in most other places in the
>>> kernel, THP counters are explicitly separated for anon, shmem and file
>>> flavours. However, we are stuck with it since it constitutes a user ABI.
>>>
>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
>>> same "file_" prefix in the names. But in future, we may want to add
>>> extra stats to cover actual file pages, at which point, it would all
>>> become very confusing.
>>>
>>> So let's take the opportunity to rename these new counters "shmem_"
>>> before the change makes it upstream and the ABI becomes immutable.
>>
>> Personally, I think this approach is much clearer. However, I recall
>> we discussed this
>> before [1], and it seems that inconsistency is a concern?
> 
> Embarrassingly, I don't recall that converstation at all :-| but at least what I
> said then is consistent with what I've done in this patch.
> 
> I think David's conclusion from that thread was to call them FILE_, and add both
> shmem and pagecache counts to those counters, meaning we can keep the same name
> as legacy THP counters. But those legacy THP counters only count shmem, and I
> don't think we would get away with adding pagecache counts to those at this
> point? (argument: they have been around for long time and there is a risk that
> user space relies on them and if they were to dramatically increase due to
> pagecache addition now that could break things). In that case, there is still
> inconsistency, but its worse; the names are consistent but the semantics are
> inconsistent.
> 
> So my vote is to change to SHMEM_ as per this patch :)
> 
>>
>> [1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com/

My original preference was also for SHMEM-specific counters :)
So feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

