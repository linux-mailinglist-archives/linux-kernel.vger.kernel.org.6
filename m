Return-Path: <linux-kernel+bounces-386209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF669B4077
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6421AB220D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799B1DE3BE;
	Tue, 29 Oct 2024 02:34:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00271EEC5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169247; cv=none; b=pWlCM9+3gOfmPlKfH4u9qC7bb5Ql21jxXMhpITC9dB3a9v4Tk83H5CLsDL9OKxGg+x/+8apdwoJbNCvsmIBUI7V25RoR8UgQLKyPcMnL1Ei7WjfMKdJKusuZahc0iaEKQnLVTxrFnMj9HxzwlWOJNZ42igO0GxA2h/pRI56Hc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169247; c=relaxed/simple;
	bh=VABOPakHa2apOv7zAxD6bUx1YB8Vlh4yW1SEAIF35Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RULttwo0M3un3Bk7MuHgq0FA44N8d54ITNeVkY8xHKhG2JaGN6t+CbnXjaSJDg4O0QDLCTmLmsc8JPXAwZPTWdI9NIxoPzQdA5iRc+AAinng7PBf+rZyA/cwDWCRJJ/r/F2lljtPcvcLG1MOQBgVsTXcMtmzIxcoeIb2ougT6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcvQQ6V28zfdZx;
	Tue, 29 Oct 2024 10:31:26 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id D8120180064;
	Tue, 29 Oct 2024 10:33:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 10:33:57 +0800
Message-ID: <264f092c-dbaa-b475-831f-f50f4471de2f@huawei.com>
Date: Tue, 29 Oct 2024 10:33:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 15/19] entry: Add arch
 irqentry_exit_need_resched() for arm64
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <oleg@redhat.com>,
	<linux@armlinux.org.uk>, <will@kernel.org>, <mark.rutland@arm.com>,
	<catalin.marinas@arm.com>, <sstabellini@kernel.org>, <maz@kernel.org>,
	<peterz@infradead.org>, <luto@kernel.org>, <kees@kernel.org>,
	<wad@chromium.org>, <akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<arnd@arndb.de>, <ojeda@kernel.org>, <rppt@kernel.org>, <hca@linux.ibm.com>,
	<aliceryhl@google.com>, <samuel.holland@sifive.com>, <paulmck@kernel.org>,
	<aquini@redhat.com>, <petr.pavlu@suse.com>, <viro@zeniv.linux.org.uk>,
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
 <20241025100700.3714552-16-ruanjinjie@huawei.com> <878qu82je2.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <878qu82je2.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 2:05, Thomas Gleixner wrote:
> On Fri, Oct 25 2024 at 18:06, Jinjie Ruan wrote:
> 
>> As the front patch 6 ~ 13 did, the arm64_preempt_schedule_irq() is
> 
> Once this series is applied nobody knows what 'front patch 6 ~ 13' did.

Yes, if some of the previous patches are applied, the description will
immediately become difficult to understand, the other patch's similar
commit message will be updated too.

> 
>> same with the irq preempt schedule code of generic entry besides those
>> architecture-related logic called arm64_irqentry_exit_need_resched().
>>
>> So add arch irqentry_exit_need_resched() to support architecture-related
>> need_resched() check logic, which do not affect existing architectures
>> that use generic entry, but support arm64 to use generic irq entry.
> 
> Simply say:
> 
>  ARM64 requires an additional whether to reschedule on return from
>  interrupt.
> 
>  Add arch_irqentry_exit_need_resched() as the default NOOP
>  implementation and hook it up into the need_resched() condition in
>  raw_irqentry_exit_cond_resched().
> 
>  This allows ARM64 to implement the architecture specific version for
>  switchting over to the generic entry code.
> 
> That explains things completely independently. Hmm?

Of course, this is clearer and not as coupled as other patches and
describes how to implement it.
> 
> Thanks,
> 
>         tglx
> 

