Return-Path: <linux-kernel+bounces-408763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F8B9C8341
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D13B2838AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C741E9060;
	Thu, 14 Nov 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oTLC1Sej"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAA70818
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566344; cv=none; b=gSLURuIu+XxPzJrKYTOh8P2lc8qSDKmmCHFCiKagNzgfRpjugmKv9QsyYLCkTmZu8W5na3PHGUSs4jY+IesQaXqbeU53qID/2q3nBe1x9Sewsdxn3ECxqOjs0taouJmfmarCKzN1du3kvosktmXVj+MmkZPRSDH1ljfJMNURmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566344; c=relaxed/simple;
	bh=nnYUSwbkLRoENKIniibOfyYvagPgtMYZTE0NrQlU+6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+SAGkxy7ga2xYFippHon770qCV3nZ99djB5LljLejZAJ8xmem5EfU+Gina98NtdiDEM3o0a2mIzSLkVmNXrQT11H01YKyzWnmnxQ8ilQ/xR9hZ6rLYguHK34PJPoGDuGYu6VDVdjEeKrtVtBXV8HORRAvALEf9Zczt5OMWDrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oTLC1Sej; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731566332; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9Gunj5vQo63mYOinHnhZqgyjOHsdlSs0pB4xnbgZGmc=;
	b=oTLC1SejKc/jm/F2OVz4q/b0ZC+/Fx1e1VuEyQ4NwDrPjL9sHlX3qyo6bUvqqvnrDIJk+4QV9VFcIFY1rllCbWzYxGjQxwTW5Iylfkr0X/cn5qpB+cbvxAKOSKbLMfT0sGFG74V96lBjDi8Xq5bl80OxFCaEzikSZbz6H8p+Cww=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNT9Tf_1731566331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 14:38:52 +0800
Message-ID: <0a82d4fc-3b2c-4b04-a0ee-539bf6896c6f@linux.alibaba.com>
Date: Thu, 14 Nov 2024 14:38:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
 <20241114060434.GL3387508@ZenIV>
 <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
 <20241114063422.GM3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114063422.GM3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/14 14:34, Al Viro wrote:
> On Thu, Nov 14, 2024 at 02:23:27PM +0800, Gao Xiang wrote:
> 
>>> 3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
>>> the point of having that as a separate field?
>>
>> Once buf->kmap_type has EROFS_KMAP and EROFS_KMAP_ATOMIC, but it
>> seems that it can be cleaned up now.
>>
>> I will clean up later but it's a seperate story.
>>
>>>
>>> 4) Why bother with union?  Just have buf->file serve as your buf->use_fp
>>> and be done with that...
>>
>> I'd like to leave `struct erofs_buf` as small as possible since
>> it's on stack.
> 
> enum + bool eats at least as much as a pointer, and if it's on stack...
> an extra word is really noise - it's not as if you had a plenty of
> those in the current call chain at any given point.

Yeah, enum can be avoided now, I will clean up this enum
as a seperate effort.

Thanks,
Gao Xiang


