Return-Path: <linux-kernel+bounces-389927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE309B731B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5505F2856AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E02139D03;
	Thu, 31 Oct 2024 03:40:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2043173
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346050; cv=none; b=eWoLM6Dv1iUUzew0qCNK3f14vUYV10HU9s9zqmRtTclvG4rFxU5+wDUfky0aYjZTFPVTNCBlS+hO2AjTkL6C/LJNEj3Erejp0R4m6INDbm0Sd29+4GDdbgIgVBA6eqhjYMQkVO0YTULs4E6L/X45XYK7vOvmU/3Qs3sArI5rNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346050; c=relaxed/simple;
	bh=2a1jYQPzOjR08hTDlpjepZM/451MWSlA7VtYt6781vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GCK7Gnlpmk+FaHaVvRllJYnPfAsixC3mRZFAmgif+WaLykEaNpuOeljmUrFaWWvt6RMc72qLnynJjkVQL3EYONXB+Nv4v8COkP8bFSEys4HLNc8lXfcOFdYInFjd27oGbbArFZzLVEXfdkht8pv9AwMTDCtoVKG0iJnnLB2JU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xf8pw1JPKz1T9TY;
	Thu, 31 Oct 2024 11:38:32 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E13B4180103;
	Thu, 31 Oct 2024 11:40:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 11:40:41 +0800
Message-ID: <bcce44bc-5047-18d9-6cb3-4e664d99a129@huawei.com>
Date: Thu, 31 Oct 2024 11:40:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 03/19] arm64: entry: Remove
 __enter_from_user_mode()
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
 <20241025100700.3714552-4-ruanjinjie@huawei.com>
 <ZyD0WJeAhESLIBJp@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZyD0WJeAhESLIBJp@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 22:42, Mark Rutland wrote:
> On Fri, Oct 25, 2024 at 06:06:44PM +0800, Jinjie Ruan wrote:
>> The __enter_from_user_mode() is only called by enter_from_user_mode(),
>> so replaced it with enter_from_user_mode().
> 
> As with the next two patches, all the __enter_from_*() and __exit_to_*()
> are supposed to handle the raw entry, closely matching the generic code,
> and the non-underscored enter_from_*() and exit_to_*() functions are
> supposed to be wrappers that handle (possibly instrumentable)

Sure, the __enter_from_*() and __exit_to_*() is all about the generic
code, and the enter_from_*() and exit_to_*() includes arm64-specific MTE
  check.

> arm64-specific post-entry and pre-exit logic.
> 
> I would prefer to keep that split, even though enter_from_user_mode() is
> a trivial wrapper.
> 
> Am I missing some reason we must remove the wrappers?

It is not necessary to remove these functions, just found it by chance
and cleanup them by the way, originally I thought that removing the
underline function might make the relative order of the MTE functions
look clearer.

> 
> Mark.
> 
>>
>> No functional changes.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/entry-common.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index 68a9aecacdb9..ccf59b44464d 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -109,7 +109,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>>   * Before this function is called it is not safe to call regular kernel code,
>>   * instrumentable code, or any code which may trigger an exception.
>>   */
>> -static __always_inline void __enter_from_user_mode(void)
>> +static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>>  {
>>  	lockdep_hardirqs_off(CALLER_ADDR0);
>>  	CT_WARN_ON(ct_state() != CT_STATE_USER);
>> @@ -118,11 +118,6 @@ static __always_inline void __enter_from_user_mode(void)
>>  	mte_disable_tco_entry(current);
>>  }
>>  
>> -static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>> -{
>> -	__enter_from_user_mode();
>> -}
>> -
>>  /*
>>   * Handle IRQ/context state management when exiting to user mode.
>>   * After this function returns it is not safe to call regular kernel code,
>> -- 
>> 2.34.1
>>
> 

