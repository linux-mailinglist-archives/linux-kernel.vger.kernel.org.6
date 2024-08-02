Return-Path: <linux-kernel+bounces-272030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D4945606
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B411F234E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E23171BB;
	Fri,  2 Aug 2024 01:39:46 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE2134AC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562786; cv=none; b=arHdba536GQMRGrs6nDXFjmg3mu/KGx9Kp3om7F9AD6b0N6/QZOz38JQm6CehPFV4gC0MwOd0M06yZUvCtRbGDOUF8BcrgUm7kmx8i7c70n/vcOev/qVu/ITIY5qwckqveC17NW0dr0U4du4dFY00m+eN9vACRFpBq+V5CptTBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562786; c=relaxed/simple;
	bh=HYMtRlYBv1qXUi3R4GOGLKkKTuTelUkjeEIEB+MWwmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RDVwZtiVzKdjPS5PPkjdvfeYTxfNpzyNocskZ6UJyBWQq8Y0Pky8gsBCm6lZq+nKn7s6LJHQpVTvOxR0ultnMMGJNKY+pk7eYQsU9+kbN9ud6AIg+n9M/Bb4CsJ8h7H90cTwo0V2J+U3g7nbDHmzSv1Fs9HzvkfX+Gu0SQp+vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WZpKt6Qhmz1S71V;
	Fri,  2 Aug 2024 09:34:58 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 46B871A0188;
	Fri,  2 Aug 2024 09:39:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 09:39:34 +0800
Message-ID: <c55bbffe-9144-f787-eb70-8328be5cfe7c@huawei.com>
Date: Fri, 2 Aug 2024 09:39:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ARM: smp: Fix missing backtrace IPI statics
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <dianders@chromium.org>, <mhocko@suse.com>, <akpm@linux-foundation.org>,
	<maz@kernel.org>, <vschneid@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240801094022.1402616-1-ruanjinjie@huawei.com>
 <Zqu5ck+Ik8KlzE0O@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zqu5ck+Ik8KlzE0O@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/2 0:36, Russell King (Oracle) wrote:
> On Thu, Aug 01, 2024 at 05:40:22PM +0800, Jinjie Ruan wrote:
>> It is similar to ARM64 commit 916b93f4e865 ("arm64: smp: Fix missing IPI
>> statistics"), commit 56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal
>> interrupts") set CPU_BACKTRACE IPI "IRQ_HIDDEN" flag but not show it in
>> show_ipi_list(), which cause the interrupt kstat_irqs accounting
>> is missing in display.
> 
> I don't see why this needs to be included. If this IPI fires, it means
> that the kernel has suffered a lockup and is probably not very useful.
> So the chances of being able to read out from /proc/interrupts a non-
> zero "CPU backtrace interrupts" figure is highly unlikely.

It is more of a change than a bug.

If we reset the arm32 code to before commit 56afcd3dbd19 ("ARM: Allow
IPIs to be handled as normal interrupts"), the backtrace IPI statics is
shown ok as below, but after that it is missing:

/ # cat /proc/interrupts
           CPU0
 24:          6 GIC-0  34 Level     timer
 25:        469 GIC-0  29 Level     twd
 26:         61 GIC-0  75 Edge      virtio0
 29:          8 GIC-0  44 Level     kmi-pl050
 30:        118 GIC-0  45 Level     kmi-pl050
 31:          0 GIC-0  36 Level     rtc-pl031
 32:          0 GIC-0  41 Level     mmci-pl18x (cmd)
 33:          0 GIC-0  42 Level     mmci-pl18x (pio)
 34:          0 GIC-0  92 Level     arm-pmu
 35:          0 GIC-0  93 Level     arm-pmu
 36:          0 GIC-0  94 Level     arm-pmu
 37:          0 GIC-0  95 Level     arm-pmu
 39:         15 GIC-0  37 Level     uart-pl011
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  CPU stop interrupts
IPI5:          0  IRQ work interrupts
IPI6:          0  completion interrupts
IPI7:          0  CPU backtrace interrupts


> 
> So, I don't see much point to this change.
> 

