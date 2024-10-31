Return-Path: <linux-kernel+bounces-389918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C69B7309
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4708284272
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957013D89D;
	Thu, 31 Oct 2024 03:34:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0313A86A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730345672; cv=none; b=J87qAMiDzhbPPdUmHmzlWLm3lLfQaemaOznkjr3y+tcT2PxIXjIfhAarb4Kk3ec3KorDY1PepbTGuTTNwzGBV4CdUYSLP8xvYPvDdqQKjdoWHfwISS10p6g1UhKVP2CgtiHxYMAoIuA46QFUuo91pUN8Cna7ycsXI15gvWhBLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730345672; c=relaxed/simple;
	bh=voJJnS9Ahgn97P3nrcnPWCmLEPfPS1ajSd6csfb3PBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZAD88QBg/rCnlQ/u/6bDPQmvU8UxFqX7T21ZpoMA+pefB6NweFQG1GIE14sszGs2L7I/c0VMsZ95fH9DQlSeykM2Gy4jEtGwsRgz7Fv0AYFu9jTZkamnYA+zPHeI6acSSo4FWbu3jtbyUDbbADTXzxmkMgm/ZnasJ1ljAblMsfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xf8gw2BpVzpXgN;
	Thu, 31 Oct 2024 11:32:28 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id AA015180115;
	Thu, 31 Oct 2024 11:34:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 11:34:21 +0800
Message-ID: <d1293fb3-6516-8680-d676-a68d648b904b@huawei.com>
Date: Thu, 31 Oct 2024 11:34:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 01/19] arm64: ptrace: Replace
 interrupts_enabled() with regs_irqs_disabled()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <sstabellini@kernel.org>, <maz@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <akpm@linux-foundation.org>,
	<samitolvanen@google.com>, <arnd@arndb.de>, <ojeda@kernel.org>,
	<rppt@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<samuel.holland@sifive.com>, <paulmck@kernel.org>, <aquini@redhat.com>,
	<petr.pavlu@suse.com>, <viro@zeniv.linux.org.uk>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-2-ruanjinjie@huawei.com>
 <ZyDu9XHNmxMHBMSI@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZyDu9XHNmxMHBMSI@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 22:19, Mark Rutland wrote:
> On Fri, Oct 25, 2024 at 06:06:42PM +0800, Jinjie Ruan wrote:
>> Implement regs_irqs_disabled(), and replace interrupts_enabled() macro
>> with regs_irqs_disabled() all over the place.
>>
>> No functional changes.
>>
> 
> Please say why, e.g.
> 
> | The generic entry code expects architecture code to provide
> | regs_irqs_disabled(regs), but arm64 does not have this and provides
> | interrupts_enabled(regs), which has the opposite polarity.
> | 
> | In preparation for moving arm64 over to the generic entry code,
> | replace arm64's interrupts_enabled() with regs_irqs_disabled() and
> | update its callers under arch/arm64.
> |
> | For the moment, a definition of interrupts_enabled() is provided for
> | the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
> | can be removed.
> 

Thank you！ Will expand the commit message and describe the cause of the
patch also for other patches.

>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
> 
> [...]
> 
>>  arch/arm/include/asm/ptrace.h       | 4 ++--
>>  arch/arm/kernel/hw_breakpoint.c     | 2 +-
>>  arch/arm/kernel/process.c           | 2 +-
>>  arch/arm/mm/alignment.c             | 2 +-
>>  arch/arm/mm/fault.c                 | 2 +-
> 
>>  drivers/irqchip/irq-gic-v3.c        | 2 +-
> 
> I hadn't realised that the GICv3 driver was using this and hence we'd
> need to update a few places in arch/arm at the same time. Please update
> just the arch/arm64 bits, and add:
> 
> | /* 
> |  * Used by the GICv3 driver, can be removed once arch/arm implements
> |  * regs_irqs_disabled() directly.
> |  */
> | #define interrupts_enabled(regs)	(!regs_irqs_disabled(regs))
> 
> ... and then once 32-bit arm implements this we can update the GIC
> driver and remove the architecture definitions.
> 
> That way we avoid the risk of conflicts with 32-bit arm.
> 
> Mark.
> 

