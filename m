Return-Path: <linux-kernel+bounces-214980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CCC908CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7203D28AE64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4538BE68;
	Fri, 14 Jun 2024 13:59:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3217996
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373574; cv=none; b=k3zQWfdjZuMgxdojNBKimqwwKmquZx+YmZGXZ1+8wJfX+SJU4Gx4/uwiJCnoZX0gA3Vw5BemeuIAbLRnMkPD4va2kgoCUnKK7PnSaGQohx37Kqk1jj/XRVHsaJRpsIsqKSerRZskRfrrFZ2ApqgEcIc9FGPZk8E97/RM9QrcEHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373574; c=relaxed/simple;
	bh=IuNsx2eGloa5KCaCTZ5Ehm44+9eIGVHtHPnYxdX2J0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMQU+9SqPqxsl7GRngWa6jHXJ6rLZKQgwBE1NYdIw0fIRF1uR3FzR4TNiRqmXtBUyRv7SxeMZZUCqrbIEO27bRT6NjWXvw/SnK37cR9YWAM/4NjOMES3nVkabyPh/gNjMnRQfIo8ZezLaeedQoarZIec2HSgsetSul5684LkvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3761480;
	Fri, 14 Jun 2024 06:59:57 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7563F5A1;
	Fri, 14 Jun 2024 06:59:29 -0700 (PDT)
Message-ID: <edd100ce-dac6-4075-81cb-820e57282bc6@arm.com>
Date: Fri, 14 Jun 2024 14:59:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 09/04/2024 04:13, Reinette Chatre wrote:
> Please consider the file movements as captured in the diffstat below:
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
>>  MAINTAINERS                               |    2 +
>>  arch/Kconfig                              |    8 +
>>  arch/x86/Kconfig                          |    5 +-
>>  arch/x86/include/asm/resctrl.h            |   45 +-
>>  arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
>>  arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
>>  arch/x86/kernel/cpu/resctrl/internal.h    |  433 +--
>>  arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +----
>>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1126 +-----
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3929 +-------------------
>>  arch/x86/kernel/process_32.c              |    2 +-
>>  arch/x86/kernel/process_64.c              |    2 +-
>>  fs/Kconfig                                |    1 +
>>  fs/Makefile                               |    1 +
>>  fs/resctrl/Kconfig                        |   23 +
>>  fs/resctrl/Makefile                       |    3 +
>>  fs/resctrl/ctrlmondata.c                  |  527 +++
>>  fs/resctrl/internal.h                     |  340 ++
>>  fs/resctrl/monitor.c                      |  843 +++++
>>  fs/resctrl/psuedo_lock.c                  | 1122 ++++++
> 
> (sidenote: James, please note typo in psuedo_lock.c)

Yeah - I still can't spell that...


>>  fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
>>  include/linux/resctrl.h                   |  153 +-
>>  include/linux/resctrl_types.h             |   98 +
>>  24 files changed, 7244 insertions(+), 6875 deletions(-)
>>  create mode 100644 fs/resctrl/Kconfig
>>  create mode 100644 fs/resctrl/Makefile
>>  create mode 100644 fs/resctrl/ctrlmondata.c
>>  create mode 100644 fs/resctrl/internal.h
>>  create mode 100644 fs/resctrl/monitor.c
>>  create mode 100644 fs/resctrl/psuedo_lock.c
>>  create mode 100644 fs/resctrl/rdtgroup.c
>>  create mode 100644 include/linux/resctrl_types.h

> I would like to check in on the sentiments regarding maintaining the resctrl
> contributions after this work is merged. Considering that resctrl will 
> be split between fs/resctrl and arch/x86, would it still be acceptable for
> resctrl code to both areas (filesystem as well as arch) to flow via the tip tree with
> help from x86 maintainers?

I think it makes sense for all that to be funnelled via tip.


> How will Arm patches flow?

No preference. If it makes the most sense for them to go via tip, then lets do that.

There will be the occasional dependency on arm64, but that should be manageable.
e.g. The first merge of the MPAM driver comes with some arm64 code for context-switch.
That will need co-ordinating with Will+Catalin.


> James, are you planning a separate MAINTAINERS entry for the Arm specific code?
> I would like to propose that you add yourself as a reviewer to the existing resctrl
> MAINTAINERS entry to learn when any changes are submitted that may impact Arm. 

I'll add a patch doing that to the end of the MPAM tree.


Thanks,

James

