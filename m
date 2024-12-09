Return-Path: <linux-kernel+bounces-436839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1539E8B80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279B02818A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D42147F6;
	Mon,  9 Dec 2024 06:28:12 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274B17C219;
	Mon,  9 Dec 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733725692; cv=none; b=unw2WtWogWPlEGxDh9QjbUuPbQuIQ9tiDMY2drOMjrKO6/2cumiBosvjiXmj0cTAskaUOQQbHWmt1fzuSds8XF4TpLZ2hJ847oqEtdD8OCCNcW+fjBHDxClK7IKm/Bk92HzSnCUCIumQe9XhzMmHbcsaOtkw3cN1+zeaQWxTF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733725692; c=relaxed/simple;
	bh=3EID9GGzdHT/F/F+Bl0HmFUV66x53Yec4t4oNfCvyYw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YGxssEsH6Ir5WSn6/S/fyaOd37DmlJC4akJPFMhGuXkwIVmt1qccYE2x6hqaN7kR4Ee70L8/A1SNyuwQrGsgpC0ZlCP7uRsDMUoUhYRI8d+Ny7W8VO5fOeNf06fsJppEAQMHqpqGcRrBw4HvhXfN/QepfFGi01prMnq+7lz8MjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y6Bfx3G3dz1V5hn;
	Mon,  9 Dec 2024 14:24:57 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A236140123;
	Mon,  9 Dec 2024 14:28:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 14:27:59 +0800
Subject: Re: [PATCH] mtdchar: fix integer overflow in read/write ioctls
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
 <e3da1bba-9740-6b6f-385a-1bdf25f056a9@huawei.com>
 <6b4f7a14-297f-4fc7-bc4b-a9e7d822fb23@stanley.mountain>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <fabbceb3-90a3-2cc8-c664-e53fcd504393@huawei.com>
Date: Mon, 9 Dec 2024 14:27:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b4f7a14-297f-4fc7-bc4b-a9e7d822fb23@stanley.mountain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/12/8 1:05, Dan Carpenter 写道:
> On Sat, Dec 07, 2024 at 12:17:33PM +0800, Zhihao Cheng wrote:
>> 在 2024/12/7 4:26, Dan Carpenter 写道:
>>> The "req.start" and "req.len" variables are u64 values that come from the
>>> user at the start of the function.  We mask away the high 32 bits of
>>> "req.len" so that's capped at U32_MAX but the "req.start" variable can go
>>> up to U64_MAX.
>>>
>>> Use check_add_overflow() to fix this bug.
>>>
>>> Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
>>
>> Hi, Dan. Why this fix tag? I think the adding result('req.start' and
>> 'req.len') could be overflow too before this commit.
>>
> 
> I've looked at this again, and I still don't see the bug before the
> commit.  Secondly, commit a1eda864c04c ("mtdchar: prevent integer
> overflow in a safety check") is missing a Fixes tag but the message says
> that it's this commit which introduced the bug.

Ah, I see. There is not an addition operation for 'req.start' and 
'req.len' until commit 6420ac0af95d("mtdchar: prevent unbounded 
allocation in MEMWRITE ioctl") and 095bb6e44eb1("mtdchar: add MEMREAD 
ioctl"), so I guess the there should be two fix tags?
> 
> Which commit should get the fixes tag?
> 
> I should have added a CC to the stable tree though.  I did that correctly
> in an earlier draft of this patch but I messed up in this version. :/
> 
> regards,
> dan carpenter
> 
> .
> 


