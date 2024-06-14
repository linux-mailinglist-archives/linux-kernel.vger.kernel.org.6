Return-Path: <linux-kernel+bounces-214271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A004908205
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E072847AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69F1836F9;
	Fri, 14 Jun 2024 02:48:21 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F823184116
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333301; cv=none; b=OV6493Xj4c6TAbGIzomN0OmAC5A4kUBeWEcaJak2f6122nOJ7Cq//oAv1KE0WKPMBVAVPposet7Yohc+ReQ/aO8+tom/A8/Tz6OuB+BeHHs1Z9JQiD1SYTIe1h6D5YbjN9FMd011vAEZ6EwkKoH9+3DDLsd8jVPGZEbm2me/DBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333301; c=relaxed/simple;
	bh=1YoPP/KFuVlpzsYsMmO/52Yaf/qvfufpUVKcnkocOBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IRhNerw5zVjKyBS1uvCZhdo3ZRPP8NNrsJ7BmrAgt2yWTWjpUUT4+Ekzz6nMtOOePJ5pzDEsNwtFHeTfO+WSr5EnYKtSLexCWbLgzGeQC+AXXsZVGpzUG5a7AmKbCrCD9ij6oOapmbFcx7mDqhFkTmgh+oIBB5Mqy1KtJmUERXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4W0kFL6ZScz3PsZk;
	Fri, 14 Jun 2024 10:46:46 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E7B2A1401E9;
	Fri, 14 Jun 2024 10:48:10 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 10:48:10 +0800
Message-ID: <4dabec63-66bf-b13a-de00-287157cf80ef@huawei.com>
Date: Fri, 14 Jun 2024 10:48:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] arm64: smp: Fix missing IPI statistics
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<swboyd@chromium.org>, <sumit.garg@linaro.org>, <frederic@kernel.org>,
	<scott@os.amperecomputing.com>, <misono.tomohiro@fujitsu.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240607074716.4068975-1-ruanjinjie@huawei.com>
 <CAD=FV=W6Y+sUcOZ02DrsNDAkd2eOJ8VAC_ke04gOO6s5OgMvzw@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAD=FV=W6Y+sUcOZ02DrsNDAkd2eOJ8VAC_ke04gOO6s5OgMvzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/8 0:02, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 7, 2024 at 12:45 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
>> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
>> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
>> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
>> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
>> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
>> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
>> is missing in display.
>>
>> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/smp.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> While I won't object to your patch if everyone agrees that we want it,

Hello, What's everyone's opinion?

> fully excluding "cpu backtrace" and "kgdb roundup" from
> /proc/interrupts was more of a design decision than a bug. Those two
> IPIs are really special cases and not something that I'd expect anyone
> to care about knowing the count of. Keeping them out of
> "/proc/interrupts" just avoids noise. I'd also note that I believe
> arm32 makes the same design choice for "cpu backtrace".

Yes, arm32 is same as arm64.

> 
> In any case, if we truly think people want the count of these IPIs
> then it feels like we should report them in arch_show_interrupts()
> where we can give them a nice string.

That's a good idea.

> 
> -Doug

