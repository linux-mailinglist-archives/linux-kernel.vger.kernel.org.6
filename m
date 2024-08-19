Return-Path: <linux-kernel+bounces-291599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A395648C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E21F25379
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5AA15748F;
	Mon, 19 Aug 2024 07:25:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1A1799F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052324; cv=none; b=exVbC2ONmSso9KI5eNLnVzpKV5gsAkSW/f9gW6WxrnusAIjIz2bTpU53BnAj2LPyLyid8Il5X5HM8DMk3xMLW9tlZ7cxcxMxvDh/KiKWAALMTHPSA7gq1c+UPJDFWy7Cf0WP7Gh+IWeHgA35BZZjBhpQY8C/WWlXGv6KlOiWTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052324; c=relaxed/simple;
	bh=YpYEPRW5U05MP4vc7osRMus1jWU/Ko1cnF7gosd/qIM=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tIQ77GeJ6UQOW2AJEFLP1gubdmKYBbqx3Hpw7Ek/LQuGl6yP6DXG55b0/qsY08RORPnpEFhTu22LP5qmxzhblzZ6r4FsKBLvvAtT0AVt+zTUil08JfuFGz9WFDBvAyJ6xb20GzNfoLwT98E4C8xDsECMLNonJhDfAlVAYHOXHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnPBw732Rz20lxk;
	Mon, 19 Aug 2024 15:20:40 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 4786D180041;
	Mon, 19 Aug 2024 15:25:20 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 19 Aug 2024 15:25:19 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <yangyicong@hisilicon.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: Re: [PATCH v5 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240806085320.63514-1-yangyicong@huawei.com>
 <20240806085320.63514-2-yangyicong@huawei.com>
 <9c46d5f0-f4ff-461b-b483-840fab6dfecc@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <1feb896c-e2aa-2ae5-eb7e-dd28bfb40034@huawei.com>
Date: Mon, 19 Aug 2024 15:25:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c46d5f0-f4ff-461b-b483-840fab6dfecc@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/8/16 23:54, Dietmar Eggemann wrote:
> On 06/08/2024 10:53, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently if architectures want to support HOTPLUG_SMT they need to
>> provide a topology_is_primary_thread() telling the framework which
>> thread in the SMT cannot offline. However arm64 doesn't have a
>> restriction on which thread in the SMT cannot offline, a simplest
>> choice is that just make 1st thread as the "primary" thread. So
>> just make this as the default implementation in the framework and
>> let architectures like x86 that have special primary thread to
>> override this function.
> 
> IMHO, ARM64 (/ARM), RISCV and PARISC (SMP) use GENERIC_ARCH_TOPOLOGY
> (and drivers/base/arch_topology.c) so they could share
> topology_is_primary_thread() also there?
> 

I think yes, if they want to implement HOTPLUG_SMT and don't have a restriction
on the primary thread.

Thanks.

