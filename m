Return-Path: <linux-kernel+bounces-272071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3FF945689
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D425E282093
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C31BC58;
	Fri,  2 Aug 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mqtB5b6n"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C123D68
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722568279; cv=none; b=oWVeQrUpRRVPCcZwgzA3rrE/dle4ffS13QvDaY0u6h3BkRgCQdwyMB3JEI0V2hZs2Gb1Z+EVvKhyvGiQzQVh398Fd6PkrIcsr0VzatpG02emE+YIKbjfMvrwGl07B4vZRxyeH9BAM1yFxdHMTVn6Q5tvPhynjnE46TKg+R8f+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722568279; c=relaxed/simple;
	bh=IvTN9RUuaMw52Yy78L9/uujylMXKbSELTdGuhqvLHzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYB5dfP70h/PUnd4tJ4DuU+qpIm4T6uvdT97ey/SZhkLOBbXk36OhUvtVEzU7ytIFGLoCjrQ0icU3a+n5zK3RtJS3fl6tJ03rw8Qw4TpE5RMMwV9vt167nRbmhmMcNHDwj7f2Y707xCBThdfJyjRhk7d/cUPZAkSI0WlHA5BJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mqtB5b6n; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722568275; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=12DXJCyM5dEPtaGag3N2aiCBqyKJKN9vuLRg7UajN00=;
	b=mqtB5b6naRK7Sj2kaLloMRV5pLFi8aSw/Sb+rwUfDNx7lgtoXn+S+LLGgDgupXnedraMhjTImg06jMpfnLN8EX67jub6EWaiPQj1RnaHFXbhUXkxKEVRzfdtBKo+6NXM35HPy559NWaw3odEi90oorjEFONd0u7pnyJTsqKrnIc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBvmIPN_1722568272;
Received: from 30.97.56.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBvmIPN_1722568272)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 11:11:13 +0800
Message-ID: <15d93ced-ffa5-4b87-9dea-bcf8cfaf44e9@linux.alibaba.com>
Date: Fri, 2 Aug 2024 11:11:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 hughd@google.com, willy@infradead.org, david@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com, ioworker0@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
 <c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
 <87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
 <ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
 <20240731134802.00541e78813997f3c59df36c@linux-foundation.org>
 <bf97923f-b59a-4d91-95b5-67e555fb4cd3@linux.alibaba.com>
 <20240801125552.12dc70cbe7220205a4a1a9ce@linux-foundation.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240801125552.12dc70cbe7220205a4a1a9ce@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/2 03:55, Andrew Morton wrote:
> On Thu, 1 Aug 2024 08:06:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>>
>> On 2024/8/1 04:48, Andrew Morton wrote:
>>> On Wed, 31 Jul 2024 18:22:17 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> (Hope Andrew can help to squash these changes :))
>>>
>>> I'm seeing some rejects against, amongst other things, your own "Some
>>> cleanups for shmem" series.
>>>
>>> So... v2, please?
>>
>> These two bugfix patches are based on the mm-hotfixes-unstable branch
>> and need to be merged into 6.11-rcX, so they should be queued first.
> 
> OK.
> 
>> For the 'Some cleanups for shmem' series, I can send a new V4 version to
>> you after resolving conflicts with the shmem bugfix patches. Sorry for
>> the inconvenience.
> 
> I fixed things up.

Thank you for your help, Andrew. I have checked the patches after 
resolving the conflicts, and all look good.

