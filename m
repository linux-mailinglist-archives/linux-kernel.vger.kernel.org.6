Return-Path: <linux-kernel+bounces-251413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943349304A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391641F22F82
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185247F46;
	Sat, 13 Jul 2024 09:03:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E812032A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861383; cv=none; b=QuHPowXlfIE8wI0r7cBVHgVTPLBzeLvna08TqWqqkyaJKJrhFy29Pw9q5tVRHOSI53wp+2CFil5KGyyLA6z0KIEVSjpvwKReGAIheBTn5uJuCAuQws8HQ+5kNOzM4KKWesxmHjYgXC8yL6DvwdYPcDN0oBvaWf/VMyncYpkO0SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861383; c=relaxed/simple;
	bh=EVxEHlCMhF9a9eot5+XdClzUPctO/fY4IuVLZ1PL9po=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vAZVc2oImdCKmquOTAJjvNc72R/JNffd3772CHRsgP+ZfEyO1/Kn829iAVmq5g7GSATbX+sBkX+KfqZIfVC03sQVXRDGI/NRz0macLQuBiYT/+W9kizyqq4dH4JSz1VpF6GJ6ER/BleDdl79PiRoLuU8w+r+jmDpikSBOZ5FNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WLj7Q2TZ5zQlPP;
	Sat, 13 Jul 2024 16:58:58 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 605BA180088;
	Sat, 13 Jul 2024 17:02:57 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 17:02:56 +0800
Subject: Re: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch
To: Richard Weinberger <richard@nod.at>
CC: linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, Ben Hutchings <bwh@kernel.org>, kernel test
 robot <lkp@intel.com>
References: <20240713073519.25325-1-richard@nod.at>
 <3c624cf1-b5a3-f89c-ac6a-0875fcabaf25@huawei.com>
 <1422580650.65606.1720860390692.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9a210424-eac1-957e-dd6e-4290924216e3@huawei.com>
Date: Sat, 13 Jul 2024 17:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1422580650.65606.1720860390692.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/7/13 16:46, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>
>> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "Ben Hutchings" <bwh@kernel.org>, "kernel test robot" <lkp@intel.com>
>> Gesendet: Samstag, 13. Juli 2024 10:16:15
>> Betreff: Re: [PATCH] ubi: Fix ubi_init() ubiblock_exit() section mismatch
> 
>> 在 2024/7/13 15:35, Richard Weinberger 写道:
>>> Since ubiblock_exit() is now called from an init function,
>>> the __exit section no longer makes sense.
>>>
>>> Cc: Ben Hutchings <bwh@kernel.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes:
>>> https://lore.kernel.org/oe-kbuild-all/202407131403.wZJpd8n2-lkp@intel.com/
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>>    drivers/mtd/ubi/block.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Looks like that you prefer a simpler fix. Feel fine to add
> 
> Yes, and Ben sent the patch first. :)
>   
>> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Thanks for the review!
> And especially thanks for reviewing so many UBI/UBIFS patches,
> I appreciate your help.

You're welcome.
BTW, I have two favors to need your help.
1. Give me some feedbacks about the fsck.ubifs patch series 
[https://patchwork.ozlabs.org/project/linux-mtd/list/?series=409935], 
maybe you have started looking at them. I know it is a huge reviewing 
work, maybe you can start with using, testing or reading the documents.
2. I reported a 
BUG[https://lore.kernel.org/linux-ext4/346993f2-87f6-e20f-8f5a-d19f84c1604c@huaweicloud.com/T/#m36825671b018880ca17e4c093a4dbfc1b66d5db8] 
recently, please let me know if you have a good solution.

> 
> Thanks,
> //richard
> 
> .
> 


