Return-Path: <linux-kernel+bounces-301794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8495F5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD8C1C209CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21DD194124;
	Mon, 26 Aug 2024 15:56:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B84C49631
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687760; cv=none; b=ON629Lro+oCR1g1vcVkF9x7ebbwaZZlKcfGIsqpjhQv2HhMUUepnJa2H58aBq0Ce+mdQtTKvxbJDJal9TKO/dr0tdJMj5ZtldJR5pD0igv5iYQVZ96V8vzjIHISWRM51ZdDGpOCHEqK5rPkAYve07ykx03FSzXhgLoCsPeDzh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687760; c=relaxed/simple;
	bh=gvJg0Wii1ygWrQe1rmKFZvnsHC0A8XNgyEAD1k0qAPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+Sq54xyUfp3ZF4+xpKDtyrd1Gm6uk4OjF37LH4cEXEDA5mg5Q+OfYGM6IDsl7bMEARO2ttCgypgFYNBKiSm3Lt34cRFIKyO1ijow74qjqGqKMlU6WrZpoE1/eUIUDSvCmQxB1boXFLQIiEd5Kx0pXiC5We093/XBqjo4EtaKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7793ADA7;
	Mon, 26 Aug 2024 08:56:22 -0700 (PDT)
Received: from [10.57.71.136] (unknown [10.57.71.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694E23F762;
	Mon, 26 Aug 2024 08:55:52 -0700 (PDT)
Message-ID: <025cfbf4-d5cd-4b06-b86c-8d70f19205df@arm.com>
Date: Mon, 26 Aug 2024 17:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] entry: Add some arch funcs to support arm64 to use
 generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org, kees@kernel.org,
 wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
 broonie@kernel.org, mark.rutland@arm.com, rick.p.edgecombe@intel.com,
 leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-2-ruanjinjie@huawei.com>
 <1ce09739-14a4-42a2-b5c9-66fdc72ae999@arm.com>
 <39117062-fa67-2154-3f3f-55c7a1a6a265@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <39117062-fa67-2154-3f3f-55c7a1a6a265@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 14:36, Jinjie Ruan wrote:
>>> +/**
>>> + * arch_exit_to_kernel_mode_prepare - Architecture specific final work before
>>> + *				      exit to kernel mode.
>>> + */
>>> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs);
>> Any reason to suffix this function with "prepare"? Just
>> arch_exit_to_kernel_mode() seems appropriate (symmetric with
>> arch_enter_from_kernel_mode()).
> prepare means it is the first function before all other exit_to_kernel
> operation in irqentry_exit(), but as the order problem, it can be
> adjusted to the last to aligh with the older arm64 version.

I understand the rationale, but I don't think this aligns very well with
the other hooks - they are generally called after the functions they are
called from, without suggesting where they are called (beginning/end of
the function). In particular we already have
arch_exit_to_user_mode_prepare(), which is named so because it is called
from exit_to_user_mode_prepare(). If we use "prepare" as a suffix here,
I'm concerned we're confusing rather than clarifying things.

Kevin

