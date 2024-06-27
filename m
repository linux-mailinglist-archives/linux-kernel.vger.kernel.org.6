Return-Path: <linux-kernel+bounces-231872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E3919FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7858C285E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982914501F;
	Thu, 27 Jun 2024 06:59:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173A4D8A7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471547; cv=none; b=meleSAofWtI2apUA3Xjf6OIK3BblS0fdnQ0rmBzN7xAouvlkjlTMCFy5e4thU36gMUUilYJq3SYAg4HEan96Hy0rU6llQ4Rt/0eG3yFGGz4o7kl347PHFRuHjAvbDBlON0XtDPCjUTbx0NPK3Z58R1D4GMHRrSY7zmgBSpzuxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471547; c=relaxed/simple;
	bh=zz7epBxEWzQpH7+IoGDmZvTTmkokWN/rvjMnRr/JLhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uG7pjkRUQuI3hpNNbPh0L/6wXjAwnt+Ss6MVOIj/MnxIQpFlGNw6rxmwut1pGIXnn/GsIinqsd24sLLbq5Z6R2Yn+te5wusMqzlSSXMShrDkXW7Af5RF4ULnTCZgyQFqbmRPQjT3rWqqotGTd0E7gm3ONyp7u2T/vm9/FAApox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W8qBS70Jxzdf8j;
	Thu, 27 Jun 2024 14:57:20 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D0E14040D;
	Thu, 27 Jun 2024 14:58:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 14:58:54 +0800
Message-ID: <319b42b3-271f-2e29-0171-a6f1a8b090d9@huawei.com>
Date: Thu, 27 Jun 2024 14:58:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<wad@chromium.org>, <rostedt@goodmis.org>, <arnd@arndb.de>,
	<ardb@kernel.org>, <broonie@kernel.org>, <mark.rutland@arm.com>,
	<rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240625092759.1533875-1-ruanjinjie@huawei.com>
 <202406261550.2AD733291D@keescook>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <202406261550.2AD733291D@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/27 6:52, Kees Cook wrote:
> On Tue, Jun 25, 2024 at 05:27:56PM +0800, Jinjie Ruan wrote:
>> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>> to use the generic entry infrastructure from kernel/entry/*. The generic
>> entry makes maintainers' work easier and codes more elegant, which aslo
>> removed a lot of duplicate code.
>>
>> Jinjie Ruan (3):
>>   entry: Add some arch funcs to support arm64 to use generic entry
>>   arm64: Prepare to switch to generic entry
>>   arm64: entry: Convert to generic entry
>>
>>  arch/arm64/Kconfig                    |   1 +
>>  arch/arm64/include/asm/entry-common.h |  60 +++++
>>  arch/arm64/include/asm/ptrace.h       |   5 +
>>  arch/arm64/include/asm/stacktrace.h   |   5 +-
>>  arch/arm64/include/asm/syscall.h      |   6 +-
>>  arch/arm64/include/asm/thread_info.h  |  23 +-
>>  arch/arm64/kernel/entry-common.c      | 355 ++++++--------------------
>>  arch/arm64/kernel/ptrace.c            |  78 +++---
>>  arch/arm64/kernel/signal.c            |   3 +-
>>  arch/arm64/kernel/syscall.c           |  18 +-
>>  include/linux/entry-common.h          |  51 ++++
>>  kernel/entry/common.c                 |  49 +++-
>>  12 files changed, 294 insertions(+), 360 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/entry-common.h
> 
> This is very cool! While the arm64 maintainers need to review it, I at
> least built and ran tests using the seccomp selftests which tends to be
> pretty sensitive to corner cases around syscall exit/entry things, and
> it passed just fine.

Kees, thank you for helping to test the code.

> 
> Tested-by: Kees Cook <kees@kernel.org>
> 

