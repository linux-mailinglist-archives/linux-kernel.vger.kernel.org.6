Return-Path: <linux-kernel+bounces-302438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E788A95FE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E9C282BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A238BE5;
	Tue, 27 Aug 2024 01:42:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED394CA6B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722957; cv=none; b=nJw2Dytvmqq3E6vGIOzwt8sRnMeg2KKr8Ic/4vtWzSmaZfY9SJVfpC5PBoI8NoyLyiOEYihMo+6YjT9TBTK5R020Qiu+Z+nG6tVLhw6hHGIdnyPwi4tVgBPFVZ73QetElqKThyl6qpFmUFUggITLDXm11FMilmrBGOp1y+KmAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722957; c=relaxed/simple;
	bh=2KjMXZv8U/2bgFxhQaUWypJuW55QTDQDghkAvO8kBAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rt9uWDlsMhdN1FXHUYzeB4y+PsSTrmXcCVshUpaDFjcqHgLeb5Ati5Dld+1fyLzVaNOu95Xt06UNstb2CIKPrndyn/Xeht5ZxUn6Ii1aRCE7De16LajQyxrQzAlJ/ckdlQoHdJTeLlromqPssILEr6eTokKsw2yseJekk9Lo81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wt9CX2yzTz20mq7;
	Tue, 27 Aug 2024 09:37:44 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B824140120;
	Tue, 27 Aug 2024 09:42:32 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 09:42:30 +0800
Message-ID: <9f93fe1f-c7d7-7d96-44ab-2bca0aae407e@huawei.com>
Date: Tue, 27 Aug 2024 09:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 2/5] drm/mediatek: Fix missing of_node_put() for
 mtk_drm_get_all_drm_priv()
Content-Language: en-US
To: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
 <20240823092053.3170445-3-ruanjinjie@huawei.com>
 <a4d23c3a-9791-4d2b-9853-9c9b27460db5@wanadoo.fr>
 <6d4ec950-878f-499c-a808-dd5b31c2ddb6@wanadoo.fr>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <6d4ec950-878f-499c-a808-dd5b31c2ddb6@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/25 13:16, Marion & Christophe JAILLET wrote:
> 
> 
> Le 23/08/2024 à 12:46, Christophe JAILLET a écrit :
>>> @@ -933,10 +931,8 @@ static int mtk_drm_probe(struct platform_device
>>> *pdev)
>>>           }
>>>           ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id],
>>> comp_id);
>>> -        if (ret) {
>>> -            of_node_put(node);
>>> +        if (ret)
>>>               goto err_node;
>>
>> Hi,
>>
>> I've seen on another thread that is was not sure that scoped versions
>> and gotos played well together.
>>
>> It was asked to check more in details and confirm that it was safe
>> before applying the patch.
>>
>> I've not followed the discussion, so I just point it out, in case it
>> helps.
>>
>> I'll try to give it a look in the coming days.
>>
>>
>> CJ
>>
> 
> Hi,
> looking at the generated asm file (gcc 14.2.1), everything looks fine.

Yes, as I pointed out in another thread, the test show that goto with
this scoped function is good.

> 
> # drivers/gpu/drm/mediatek/mtk_drm_drv.c:933:         ret =
> mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
>     salq    $5, %rax    #, _36
>     movl    %r14d, %edx    # comp_id,
>     movq    %rbx, %rdi    # node,
>     leaq    552(%rbp,%rax), %rsi    #, _28
>     call    mtk_ddp_comp_init    #
>     movl    %eax, %r12d    # tmp205, <retval>
> # drivers/gpu/drm/mediatek/mtk_drm_drv.c:934:         if (ret)
>     testl    %eax, %eax    # <retval>
>     jne    .L212    #,
> 
> ...
> 
> .L212:
> # ./include/linux/of.h:138: DEFINE_FREE(device_node, struct device_node
> *, if (_T) of_node_put(_T))
>     movq    %rbx, %rdi    # node,
>     call    of_node_put    #
>     jmp    .L171    #
> 
> CJ
> 

