Return-Path: <linux-kernel+bounces-179670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD88C6316
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37B21C2126C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85C53368;
	Wed, 15 May 2024 08:56:17 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE82AF0E
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763377; cv=none; b=XAYsOiRKa7EFjUdglRQUTdGsfXvdQu7PoKR0HYLTcaE0Bnm9p/8SSr8omUOTINFhgmaIQDdXFMVg+MwT3kLF8ikdPnEomZkOEakKZYhU2W0nqSC3E76Fp6VLAqPWMLSyQzA45PKNjn+ZKHXiLTZpouSNpyz6IJZ4DStomJKw3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763377; c=relaxed/simple;
	bh=xrASQiHXqzGD6l4n9Q+e4cuekzDSDwPKrmS9BxqpbF8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oacCcvUf8+ES2B3Wh66R1oHUEMlkVv00gzPx43UnwsZir1hrXG3wtuHmian2d4JCJbNHjWmSYVR8sWrmSHnFGyy0WLpyoV1iLvtzqh8hQFl0L50PG7KXb/LvJIaV2gTOtHB+nzE+0T1vmttknNiKf2vm5DxrEWx/tfhxJFPauBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VfRp53bsbz1ypG1;
	Wed, 15 May 2024 16:53:17 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 65EA81A0188;
	Wed, 15 May 2024 16:56:11 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 16:56:10 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1:Check whether indirect table is
 supported in allocate_vpe_l1_table
To: Marc Zyngier <maz@kernel.org>
CC: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <guoyang2@huawei.com>,
	<wangwudi@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>
References: <20240122160607.1078960-1-tangnianyao@huawei.com>
 <86sf2p91zt.wl-maz@kernel.org>
 <5de3da53-9c0d-2a2d-876b-2181e540fa2f@huawei.com>
 <86r0i98o0a.wl-maz@kernel.org>
From: Tangnianyao <tangnianyao@huawei.com>
Message-ID: <de3c10be-f4d4-75d0-bc70-0791e5217516@huawei.com>
Date: Wed, 15 May 2024 16:56:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86r0i98o0a.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500014.china.huawei.com (7.221.188.63)



On 1/22/2024 22:02, Marc Zyngier wrote:
> On Mon, 22 Jan 2024 13:13:09 +0000,
> Tangnianyao <tangnianyao@huawei.com> wrote:
>> On 1/22/2024 17:00, Marc Zyngier wrote:
>>> [Fixing the LKML address, which has bits of Stephan's address embedded
>>> in it...]
>>>
>>> On Mon, 22 Jan 2024 16:06:07 +0000,
>>> Nianyao Tang <tangnianyao@huawei.com> wrote:
>>>> In allocate_vpe_l1_table, when we fail to inherit VPE table from other
>>>> redistributors or ITSs, and we allocate a new vpe table for current common 
>>>> affinity field without checking whether indirect table is supported.
>>>> Let's fix it.
>>> Is there an actual implementation that doesn't support the indirect
>>> property for the VPE table? I know this is allowed for consistency
>>> with the original revision of the architecture, but I never expected
>>> an actual GICv4.1 implementation to be *that* bad.
>>>
>>> If that's the case, I'm a bit puzzled/worried.
>> I met this problem in a developing implementation and find it's allowed by GIC spec.
>> In such environment,  in a common affinity field with only redistributors and without
>> any ITS in it, forcing its_vpe_id_alloc to allocate a large vpeid(like 65000), and there
>> comes an error message "VPE IRQ allocation failure". It originally comes from
>> allocate_vpe_l2_table, reading GICR_VPROPBASER with GICR_VPROPBASER_4_1_SIZE=1
>> and GICR_VPROPBASER_4_1_INDIRECT=0.
> Really, you should get your HW engineers to fix their GIC
> implementation.  I'm OK with working around this issue for
> completeness, but shipping such an implementation would be a mistake.
>
> [...]
>
>> I have another question here. The max number of pages  for GITS_BASER
>> and GICR_VPROPBASER is different here, while GITS_BASER.Size is
>> bit[7:0] with max 256, and GICR_4_1_VPROPBASER.Size is bit[6:0] with max 128.
>> Kernel usually probe ITS basers first and then probe GICR_4_1_VPROPBASER in
>> a common affinity group. Maybe we need to check this in "inherit_vpe_l1_table_from_its" ?
> This is because GITS_BASER[] is generic (also works for devices and
> collections), while GICR_VPROPBASER is tailored to the VPE table which
> is usually smaller.
>
> I would expect that GICD_TYPER2.VID reports something that cannot
> result in something going wrong (in this case, the L1 allocation
> cannot be more than 128 pages).
>
> Overall, the kernel isn't a validation suite for the HW, and we expect
> it to have some level of sanity. So if none of this is in shipping HW
> but only in some model with crazy parameters, I don't think we should
> go out of our way to support it.
>
> Thanks,
>
> 	M.
>

Hi Marc,
Friendly ping. Do we have plan to fix this problem on kernel, or any other plan ?


