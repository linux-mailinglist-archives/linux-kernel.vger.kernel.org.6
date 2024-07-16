Return-Path: <linux-kernel+bounces-253447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68EF932172
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612B128140B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FD3CF4F;
	Tue, 16 Jul 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KgTiz0fx"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713F224EF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116036; cv=none; b=Sfa38K85pBNDUO2EojPOQnJFAhvPlR1M1XZ3TQ1QGgmQkUA9/gB6Kj03yqEmoLoL1WyUHByVN5De9tzxEp0lRxBFxPdwnFziHdjbBKgdzwmat1U2rYkJk2RNNSv+QJBybWNYoq49OCwWRAsa+PdcL8gzBqsyz/4Ow/bRcfEaT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116036; c=relaxed/simple;
	bh=CX5MqzUKxzsRK2F/vf0K5T08kwoDnfQkkw+GomXEvvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bd54/myR9FwMg/DNwpfAN1XxtZd/mML6Kv2KEilUl8NxGkeeGB8tzGrpPyT/FqeUN6fXQ3g4CmGU0HLKE6YpfSACE4+Q+a03dEnIZrwvYHADb5iDwP0Gouz2/6nNW4Z/b8vzvwzxcdDDRvgUAcrDHg7qCLD0zhAiF4HrJ8Uhh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KgTiz0fx; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721116031; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4VfzmAJpP7nz/o/ANl9MNmfc56+6S+wZTPx7LzliYxw=;
	b=KgTiz0fxV07Euu1dOTz0sDuPMc5VZJMyccFsD0x/MUUACcwiqlF1yEGZ1FXg7WBZvR5xyBlbnoMyV6STB2Ut75GWGwjG/grEZtp8++MlYmBzJx8StyDpGwXs544rpm/FSOdNfETRMZTZ1LZx1PQb9DtIsbqGZqZqap0PxlGjg90=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAgjKX0_1721116029;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAgjKX0_1721116029)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 15:47:10 +0800
Message-ID: <2c3e0012-9a41-4e00-bd4a-95374803de8e@linux.alibaba.com>
Date: Tue, 16 Jul 2024 15:47:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of
 erofs_allocpage
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com>
 <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com>
 <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
 <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com>
 <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
 <CAGWkznEUAJGzAD5iJ-wrwW=N4tYb1SGQtDZY7hwzwrum5QxGTQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGWkznEUAJGzAD5iJ-wrwW=N4tYb1SGQtDZY7hwzwrum5QxGTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/16 15:41, Zhaoyang Huang wrote:
> On Tue, Jul 16, 2024 at 2:50 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/7/16 14:46, Gao Xiang wrote:
>>>
>>>
>>> On 2024/7/16 14:43, Zhaoyang Huang wrote:
>>>> On Tue, Jul 16, 2024 at 2:20 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>>
>>>>>
>>>>>
>>>
>>> ...
>>>
>>>>>>>
>>>>>>> I don't see why it's an atomic context,
>>>>>>> so this patch is incorrect.
>>>>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
>>>>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
>>>>>> of page cache during readahead, which will disable preempt.
>>>>>
>>>>> Why a rwsem sleepable lock disable preemption?
>>>> emm, that's the original design of down_read()
>>>
>>> No.
>>>
>>>>
>>>>> context should be always non-atomic context, which is applied
>>>>> to all kernel filesystems.
>>>>    AFAICT, filemap_fault/read have added the folios of readahead to page
>>>> cache which means the aops->readahead basically just need to map the
>>>> block to this folios and then launch the bio. The erofs is a little
>>>> bit different to others as it has to alloc_pages for decompression
>>>> when doing this.
>>>
>>> Interesting.  The whole .readahead is sleepable, including
>>> submit block I/Os to storage.
>>
>> Also, please don't imagine your stack trace if it's a non-upstream
>> kernel.
> ok, it should be caused by a vendor hook function of the android
> system. sorry for interrupting by my stupid.

okay, thanks for confirmation.

Also more words may be useful here:  Note that .readahead doesn't
just map the block to this folios.  Even an uncompressed fs could
allocate/read (submit+wait) meta folio/blocks to get the block
mapping from these meta blocks and sleep in this context.

Thanks,
Gao Xiang

