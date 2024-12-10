Return-Path: <linux-kernel+bounces-438809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040559EA68D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6483168DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13091D5CD4;
	Tue, 10 Dec 2024 03:25:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4075B644
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801130; cv=none; b=pQhJqpGqvDoSmQunAX8AMKALxeXT+92GbscCo1JCNCQ24ERWz2Ozgs8y+o+GeYv0pZmfBYzbvg6VFsreJOr2Xdy3eZqryPwrQapUpGiNdOOoPli6P8b0heWXQimzygmtyI7n3crw5oN/Y2VgiBrNbkaL0Fu6ZRXK2UWLc84zZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801130; c=relaxed/simple;
	bh=6s92LB4hy4I65Qor+FdlJMIeq0F3LdVO/k8zzov8Az0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqWVldq5t3uxHvhIPny2g6WvKpAJbWQB6ahfpEKgEUvTlHTu+AkfqjKrJc27tdjbQsw3dWdPTxbFFPYHXdk7YNFtY6Fvcn2FInCeM/bryLn0Eev+PvmPoZqLdI5dLrvsGM8PkxvNRgColq5VaJpQGjFDDoPuIIP+XtYiXEElnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC10339;
	Mon,  9 Dec 2024 19:25:47 -0800 (PST)
Received: from [10.163.48.173] (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0D543F720;
	Mon,  9 Dec 2024 19:25:16 -0800 (PST)
Message-ID: <c17a45b9-a3a2-4f9d-8243-399f65fc1a52@arm.com>
Date: Tue, 10 Dec 2024 08:55:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on
 EXECMEM
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
 Paul Gazzillo <paul@pgazz.com>,
 Necip Fazil Yildiran <fazilyildiran@gmail.com>,
 oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241209031251.515903-1-anshuman.khandual@arm.com>
 <202412092048.tTzJ5szH-lkp@intel.com>
 <f492ac51-9dad-4b18-8cd4-81dc236b3162@arm.com> <Z1ckOoPMSXfNdrXd@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z1ckOoPMSXfNdrXd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/9/24 22:39, Catalin Marinas wrote:
> On Mon, Dec 09, 2024 at 07:43:32PM +0530, Anshuman Khandual wrote:
>> On 12/9/24 18:06, kernel test robot wrote:
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on akpm-mm/mm-everything]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-execmem-Make-ARCH_WANTS_EXECMEM_LATE-depend-on-EXECMEM/20241209-111533
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>>> patch link:    https://lore.kernel.org/r/20241209031251.515903-1-anshuman.khandual%40arm.com
>>> patch subject: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on EXECMEM
>>> config: arm64-kismet-CONFIG_ARCH_WANTS_EXECMEM_LATE-CONFIG_ARM64-0-0 (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/config)
>>> reproduce: (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202412092048.tTzJ5szH-lkp@intel.com/
>>>
>>> kismet warnings: (new ones prefixed by >>)
>>>>> kismet: WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE when selected by ARM64
>>>    WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE
>>>      Depends on [n]: EXECMEM [=n]
>>>      Selected by [y]:
>>>      - ARM64 [=y]
>>
>> Although above mentioned config here has CONFIG_ARCH_WANTS_EXECMEM_LATE=y
>> and CONFIG_EXECMEM=n (actually absent), could that really happen though ?
>>
>> Tried making CONFIG_EXECMEM=n (rather deselecting) but that did now allow
>> setting CONFIG_EXECMEM=n, it always remained set. Reverting this patch i.e
>> the current behaviour is also the same (CONFIG_EXECMEM always remains set).
>>
>> select ARCH_WANTS_EXECMEM_LATE if EXECMEM
>>
>> Above statement seems to be selecting EXECMEM as well but the intent seems
>> to be a dependency check instead! OR arch selection for a config brings in
>> all its dependencies as well.
>>
>> If the selection is always, should this change be like the following ?
>>
>> config ARCH_WANTS_EXECMEM_LATE
>>  	bool
>> 	selects EXECMEM
> 
> This is wrong. What ARCH_WANTS_EXECMEM_LATE means is that, _if_ EXECMEM
> is enabled, the arch code require its late initialisation. Currently for

Which implies that even if ARCH_WANTS_EXECMEM_LATE is only applicable when
EXECMEM is enabled, there is no real dependence on the later for platforms
that need a certain init behaviour.

> arm64 EXECMEM is selected by KPROBES, BPF_JIT and MODULES. So if you

EXECMEM gets enabled from the above, not via ARCH_WANTS_EXECMEM_LATE as I
had anticipated earlier.

> don't have any of these on, you don't need EXECMEM either, no point in
> selecting it above just because arm64 wants a specific behaviour (late
> initialisation) for EXECMEM.

Right, specific behaviour preference for a function on a platform should
not necessarily pull in that function itself.

> 
> If you do want a patch for this, I think for arm64 we simply need to
> select ARCH_WANTS_EXECMEM_LATE unconditionally. Not much use in having
> any dependencies really, it just adds to the clutter. And don't change
> the core Kconfig either.

Sure, will do.

