Return-Path: <linux-kernel+bounces-253398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A9932090
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2919B20D66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB16225DA;
	Tue, 16 Jul 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NMxtzTqe"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441761862C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112397; cv=none; b=PAGjUGNMcXwc7FOvA2R+yqBfEi8CEqpmqESYy4OM489DDdfgy219zHD/iGchCOShVxRAjV6mba26YjoywUcViC3RlUynnPRRyxW/HFkQwlVt3zRbuwyzcvOWj9LFrtDWHNaPWI8j8IDCMulUdYmzPsfobNh6YxJmmwwQOzGm1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112397; c=relaxed/simple;
	bh=cWVc6+CdvyhCJ8SbmioGD8az2nNiDojYywOeUMzt/Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUsLCJ1BJWA9sMZKzNReQ2EigaCE+NN9W7aKK+Elz3NEblRCZ8Vn5xw93eiPmHJEVfGC+8hESC/K2K1SksIiv0YmxrAzeBGlzNhnMJpGJCeKCSNVWIwtFewzwh2RIGAPKMbjkM2CbywwFCVs6qFI0HudthlV+iXwFm7rPCoU92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NMxtzTqe; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112386; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3VjkPs1ND3ZkbMZwPcFQ6dQO7g+M9DvU25mbr2pS8LQ=;
	b=NMxtzTqe/hnFQCUWYVE1Wini4yyHdSb3XNyYlQvnnOmHph+aCObgHqlgmzCP1Op2lWIQYQtfLBQNL8vIv5sM2JzG2miuRRfWANrbWStRsaX4/wlrBNyg/83LTO7kK0NHHWOpNqdIWcuxvokybnssnmQaHoI8H0yZW+kX1Hy8JyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAgYxGS_1721112385;
Received: from 30.97.48.217(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAgYxGS_1721112385)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:26 +0800
Message-ID: <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com>
Date: Tue, 16 Jul 2024 14:46:25 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/16 14:43, Zhaoyang Huang wrote:
> On Tue, Jul 16, 2024 at 2:20 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>

...

>>>>
>>>> I don't see why it's an atomic context,
>>>> so this patch is incorrect.
>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
>>> of page cache during readahead, which will disable preempt.
>>
>> Why a rwsem sleepable lock disable preemption?
> emm, that's the original design of down_read()

No.

> 
>> context should be always non-atomic context, which is applied
>> to all kernel filesystems.
>   AFAICT, filemap_fault/read have added the folios of readahead to page
> cache which means the aops->readahead basically just need to map the
> block to this folios and then launch the bio. The erofs is a little
> bit different to others as it has to alloc_pages for decompression
> when doing this.

Interesting.  The whole .readahead is sleepable, including
submit block I/Os to storage.

Nacked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

