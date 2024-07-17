Return-Path: <linux-kernel+bounces-254598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FDA93353B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DBB1F23313
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E821B662;
	Wed, 17 Jul 2024 02:01:46 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C3AD2D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181705; cv=none; b=dzXZxrS1dgS/4u+akWvc6icqV4n2dp/GtCFOJGcptR+vATX6ZZWTpiAn2hmuvc2Jff3tgnO2bzPNZMraswrL6AV/Lkf3hWT38+T4+n6Z35cN0q4azzzWiK2lmqqg00ysrRPv4iw9TMF1gp3AeWuw4E1xb2ZOQN2fnF5mlYWC0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181705; c=relaxed/simple;
	bh=kble9R2tYVQZB+zFzB0Wpy3xLCEdhXZPi/jxuJY+Nts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lzqkq1KGl9LwwQx+/aEoTNVmaqCPTxbcmZN3xK2rtMChXg56pniPEqbl00qx9svMZA6CdPpxsMk0B6EbMsNJmt6JzJKxamAMP3Ep3KpmY87GVCE/UYWbaQm5YamlPI+R/UmcD88uWqDJeTX/5SBH1/5LqfqFhuaN2B6OPGidhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WNzZT0Z2KzxT6w;
	Wed, 17 Jul 2024 09:56:49 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 82FDB18009D;
	Wed, 17 Jul 2024 10:01:40 +0800 (CST)
Received: from [10.45.179.188] (10.45.179.188) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jul 2024 10:01:39 +0800
Message-ID: <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
Date: Wed, 17 Jul 2024 10:01:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
To: Tejun Heo <tj@kernel.org>
CC: <void@manifault.com>, <linux-kernel@vger.kernel.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
From: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
In-Reply-To: <ZpbclgFjf_q6PSd1@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2024/7/17 4:48, Tejun Heo 写道:
> Hello,
>
> On Tue, Jul 16, 2024 at 07:32:09PM +0800, Zhangqiao (2012 lab) wrote:
>> 在 2024/7/12 2:57, Tejun Heo 写道:
>>> On Thu, Jul 11, 2024 at 07:07:20PM +0800, Zhangqiao (2012 lab) wrote:
>>> ...
>>>>    		if (p->policy == SCHED_EXT) {
>>>>    			p->policy = SCHED_NORMAL;
>>>> +			p->sched_class = &fair_sched_class;
>>>>    			atomic_long_inc(&scx_nr_rejected);
>>> Did you see any issues with the existing implementation? The policy is set
>>> before the task is attached, so it should work fine. Also, you can't change
>>> sched_class by just assigning to it.
>> What does "attach" mean? I'm not sure. p->sched_class is assigned in
>> __sched_fork() which is performed before scx_ops_init_task().
> Ah, I see what you mean. I was referring to the classs switching operations
> in scx_ops_enable(). You're looking at the fork path. I don't think we can

Yes, i was referring to the fork path.

> switch sched_class at that point and the .disallow mechanism is there to
> allow the scheduler to filter out tasks on scheduler start. I'll update the
> code so that .disallow is only allowed during the initial attach.
>
> Thanks.
>


