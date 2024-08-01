Return-Path: <linux-kernel+bounces-270522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621679440EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181591F28342
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011413A86D;
	Thu,  1 Aug 2024 02:00:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F84879B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477599; cv=none; b=gGkm/dNb6nCbY3F2OwiHJoxGBTcIIjd8wbUVucM8RRjhYBsES3Dzt4yIpyOV4CzhLhBgJbyTCj8YhRZ9mKDjMWK3YDA51SQfTCrrgTzg2Mq7GhqqhdDAcebXDzAAVdHwB7aGUAEuTL5kRMWGtWUli6vtWh9JI66szCQsiUpX8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477599; c=relaxed/simple;
	bh=VDsk8lp4oj8s9sfCh/B3tX6QHpw1uoKikBR/L3EXafk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DzWTJc0qMP5XPWzZERKs9WyeS878M83pR21IEh5je/BCQxHVfB2yxa8HoDWrEN77n90BditIICHNidWlSj8FbmCV88V944PW+RsOpsTykZGPo9kXm+f4kLLHUfKAbOhshpMD4Y3gvS6dDzcrhwgj1PjYtOEZZPV91UkG+cp+AJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZBvx2tgmznd51;
	Thu,  1 Aug 2024 09:58:53 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id CA8001400DC;
	Thu,  1 Aug 2024 09:59:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 09:59:53 +0800
Subject: Re: Investigation Request - Strange PEB Reservation Behavior in UBI
To: Nikhil Kashyap H R <nikhil.kashyap@iwave-global.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <17c0f7e8-5e16-41e1-9b11-a6fa00169856@iwave-global.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7c001e77-de13-e2e2-83b1-ccfdec6cef98@huawei.com>
Date: Thu, 1 Aug 2024 09:59:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <17c0f7e8-5e16-41e1-9b11-a6fa00169856@iwave-global.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/7/31 17:53, Nikhil Kashyap H R Ð´µÀ:
> Dear Team,
> I am writing to request an investigation into a strange issue we have 
> observed regarding PEB reservation for bad block management in UBI. For 
> context, our system uses MT29FxxG NAND flash chips with a minimum of 
> 4016 valid blocks (NVB) per LUN out of a total of 4096 blocks.
> We have noticed that when using the CONFIG_MTD_UBI_BEB_LIMIT parameter, 
> which is typically calculated as 1024 * (1 - MinNVB / TotalNVB) = 20 
> PEBs, UBI is reserving significantly more PEBs than expected. Instead of 
> the expected 20 PEBs, UBI is reserving around 160 PEBs per LUN, which is 
> approximately 8 times more than it should be.
> To work around this issue, we have set the CONFIG_MTD_UBI_BEB_LIMIT 
> parameter to 3, which corresponds to ~91 reserved PEBs per LUN. However, 
> this strange 8x multiplier effect is concerning and requires further 
> investigation. Additionally, we have observed crashes in our system and 
> suspect that the over-reservation of PEBs for bad block handling may be 
> related to these issues.
> We would like to understand the root cause of the crashes and how the 
> excessive PEB reservation might be contributing to the problem. We have 
> some similar questions related to the PEB's usage in UBI operations:
> Why is UBI reserving significantly more PEBs for bad block handling than 
> expected when using the CONFIG_MTD_UBI_BEB_LIMIT parameter?

Just like the description in drivers/mtd/ubi/Kconfig, 
CONFIG_MTD_UBI_BEB_LIMIT specifies the maximum bad physical eraseblocks 
UBI expects on the MTD device (per 1024 eraseblocks). For example, if we 
attach an UBI device to a mtd partition(from a nandchip with 8192 PEBs), 
UBI will keep 8192/1024 * CONFIG_MTD_UBI_BEB_LIMIT[default val is 20] = 
160 PEBs for bad block reservation.

config MTD_UBI_BEB_LIMIT 

         int "Maximum expected bad eraseblock count per 1024 
eraseblocks"
         default 20 

         range 0 768 

         help 

           This option specifies the maximum bad physical eraseblocks 
UBI
           expects on the MTD device (per 1024 eraseblocks). If the 
underlying
           flash does not admit of bad eraseblocks (e.g. NOR flash), 
this value
           is ignored. 

 

           NAND datasheets often specify the minimum and maximum NVM 
(Number of
           Valid Blocks) for the flashes' endurance lifetime. The 
maximum
           expected bad eraseblocks per 1024 eraseblocks then can be 
calculated
           as "1024 * (1 - MinNVB / MaxNVB)", which gives 20 for most 
NANDs
           (MaxNVB is basically the total count of eraseblocks on the 
chip).
 

           To put it differently, if this value is 20, UBI will try to 
reserve
           about 1.9% of physical eraseblocks for bad blocks handling. 
And that
           will be 1.9% of eraseblocks on the entire NAND chip, not just 
the MTD
           partition UBI attaches. This means that if you have, say, a 
NAND
           flash chip admits maximum 40 bad eraseblocks, and it is split 
on two
           MTD partitions of the same size, UBI will reserve 40 
eraseblocks when
           attaching a partition.

> 1A) The typical calculation suggests reserving 20 PEBs, but UBI is 
> reserving 8 times more, around 160 PEBs per LUN. What is causing this 8x 
> multiplier effect?
> Does the issue of over-reserving PEBs only occur when multiple NAND 
> partitions are grouped under the same parent MTD device, as is the case 
> with the custom driver? Or can it also happen with a single NAND 
> partition per MTD device?
> Is the over-reservation of PEBs for bad block handling related to the 
> crashes observed in the system? If so, what is the root cause of the 
> crashes and how does the excessive PEB reservation contribute to the issue?
> What is the expected behavior of UBI when reserving PEBs for bad block 
> management based on the CONFIG_MTD_UBI_BEB_LIMIT parameter? Why is UBI 
> not following the typical calculation in this case?
> Are there any known bugs, issues or unexpected behaviors in the UBI 
> subsystem or NAND flash drivers that could explain the observed PEB 
> reservation problem? If so, are there any workarounds or fixes available?
> We would greatly appreciate if you could investigate this issue and 
> provide us with your findings and recommendations.
> Thank you for your assistance.
> Best regards,
> Nikhil Kashyap H R
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .


