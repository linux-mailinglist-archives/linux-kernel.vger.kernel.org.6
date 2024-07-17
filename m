Return-Path: <linux-kernel+bounces-254918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCE933949
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBBD2816A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEB38FA1;
	Wed, 17 Jul 2024 08:41:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1612E7F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205714; cv=none; b=FAEPAMjRpB0uMyHTLMxXZ8GPyQ6Dn/1++bYsWdiqXv//FYVmPKvVlDbWKyhxtt7I0D6RKZtO5DrWQlGQkz6Y6TwnbmMAK58Jjh32YGZOPANbfkGfTUnmQZxA6002g6UnTvPO4OjfMujK6CBaDwa7/KnpgFlfHSTW8btWYtCxejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205714; c=relaxed/simple;
	bh=36I92MfdDaLc5Z9GuACUle00L41syxWoLa+OmzE3oUA=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oow5tShU6L9a77TFxRHcx4iRd7i+nusJBhhFW3/u3MBhAV8z2N8PU0UqcTyFnE5zmXKADCaKVjb+q1X2DqmQYeYuo+gJMoIbI3hJ2BloxmbbzwzsCCUqWIzClN5HAhxoX1a/ixuaYshVXHiwwNGCT5S4NBzcQHIsQ70axd4LJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WP8Vp6Xlvz1HFMP;
	Wed, 17 Jul 2024 16:39:14 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 49EB11400D4;
	Wed, 17 Jul 2024 16:41:48 +0800 (CST)
Received: from [10.67.146.137] (10.67.146.137) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 17 Jul 2024 16:41:47 +0800
Subject: Re: [PATCH 0/3] irqchip/gic-v4: Fix VMAPP/VMOVP races
From: Tangnianyao <tangnianyao@huawei.com>
To: Marc Zyngier <maz@kernel.org>, <kvmarm@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, "guoyang (C)" <guoyang2@huawei.com>,
	jiangkunkun <jiangkunkun@huawei.com>, wangwudi <wangwudi@hisilicon.com>
References: <20240705093155.871070-1-maz@kernel.org>
 <ce1c797f-1b00-2f14-de1d-b3524acf3c1f@huawei.com>
Message-ID: <42e08881-5faf-a78c-0d94-2a48415bc655@huawei.com>
Date: Wed, 17 Jul 2024 16:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce1c797f-1b00-2f14-de1d-b3524acf3c1f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi, Marc

I meet another problem while fixing this in kernel 5.10.

Kernel 5.10 does not support guard and we replace it with raw_spin_lock/unlock.

When guest insmod nic drivers, it trigger host cpu power off somehow. The same

testcase runs quite good in kernel 6.6(both host and guest).

Would you fix this on long-term kernel 5.10? Or any sugguestion?


Thanks for your help.

Nianyao Tang



On 7/8/2024 10:02, Tangnianyao wrote:
>
> On 7/5/2024 17:31, Marc Zyngier wrote:
>> In 20240701072305.4129823-1-tangnianyao@huawei.com, Nianyao reports
>> a number of possible races that can trigger on GICv4 implementations
>> using the ITSList feature.
>>
>> These races involve concurrent VMOVP and VMAPP, the former happening
>> on vcpu load, while the latter is triggered on the first device being
>> MAPTI'd on a given ITS for this particular guest.
>>
>> The main issue is that we want to establish the affinity at VMAPP time,
>> while vcpu_load wants to set the affinity where the vcpu actually runs.
>> Lock ordering constraints mean that we can't lock the VPE on VMAPP,
>> so things are modified without any lock. What could possibly go wrong?
>>
>> THe fix is a bit involved, and relies on 3 things:
>>
>> - Making sure that the initial affinity of a VPE is fixed at activate
>>   time, which is done early in the life of the vcpup, before it can run.
>>
>> - Add a per-VM lock that can be taken instead of the global vmovp_lock,
>>   paving the way for a more manageable lock order.
>>
>> - Take the per-VPE lock whenever modifying the VPE affinity, as expected
>>   everywhere else in the code.
>>
>> With that, VMAPP and VMOVP can now run concurrently and still lead to
>> sensible results.
>>
>> Marc Zyngier (3):
>>   irqchip/gic-v4: Always configure affinity on VPE activation
>>   irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock
>>   irqchip/gic-v4: Make sure a VPE is locked when VMAPP is issued
>>
>>  drivers/irqchip/irq-gic-v3-its.c   | 48 ++++++++++++++----------------
>>  include/linux/irqchip/arm-gic-v4.h |  8 +++++
>>  2 files changed, 30 insertions(+), 26 deletions(-)
>>
> I've tested this patch series. It works.
>
> Tested-by: Nianyao Tang <tangnianyao@huawei.com>
>
> .
>


