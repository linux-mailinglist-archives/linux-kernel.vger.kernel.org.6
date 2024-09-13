Return-Path: <linux-kernel+bounces-327652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E069E9778D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5481F2551D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F216187FF7;
	Fri, 13 Sep 2024 06:30:47 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279044A07;
	Fri, 13 Sep 2024 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209047; cv=none; b=Z9EeV6NEWfL8J18JBWE6/rZlgag+X/95uwV3CGj4QNWX7WmEuNbf5qB0Sd6q+UHi0LxJmOp+Iy3aKZrL17+/Ms4p34MtJln0bCgcjT8LdoOqB/hVk+LyxKswUDv08NR53ayY6FPv9Mb7tLYXfNc87Be70u8HuKaUgX/UpVI18SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209047; c=relaxed/simple;
	bh=wqhkE51D6fBFTxHsF7tyblzU++jlhsqpAQT2Nky7JCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWzNiN/s7hi4ce9gmiF02L5a9hSWFupu5f1s8RGuBHbeDl83M874RoRPjoZhy5dOYod93099G28+2W3a4Ajyg0pYCF2RpPXdxZEkD5UyT/dhgkSThrcqWnu+CzS+0ydmnQW+NT3JaMp4X0N7B7sHHr7he4jo/2HKbzsd04MeNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4kvl1mYcz9sxD;
	Fri, 13 Sep 2024 08:30:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPoVoPcVMXmd; Fri, 13 Sep 2024 08:30:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4kvl0pksz9sxB;
	Fri, 13 Sep 2024 08:30:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 093388B77A;
	Fri, 13 Sep 2024 08:30:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id r0dE7jHRRDpY; Fri, 13 Sep 2024 08:30:42 +0200 (CEST)
Received: from [192.168.233.70] (unknown [192.168.233.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 511308B766;
	Fri, 13 Sep 2024 08:30:42 +0200 (CEST)
Message-ID: <56b53876-0838-416f-adce-b1ffbd0916fc@csgroup.eu>
Date: Fri, 13 Sep 2024 08:30:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/vpa_pmu: Add interface to expose vpa counters
 via perf
To: Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au
Cc: atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
 disgoel@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hbathini@linux.ibm.com, adubey@linux.ibm.com
References: <20240828102141.1052332-1-kjain@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828102141.1052332-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 12:21, Kajol Jain a écrit :
> The pseries Shared Processor Logical Partition(SPLPAR) machines
> can retrieve a log of dispatch and preempt events from the
> hypervisor using data from Disptach Trace Log(DTL) buffer.
> With this information, user can retrieve when and why each dispatch &
> preempt has occurred. Added an interface to expose the Virtual Processor
> Area(VPA) DTL counters via perf.
> 
> The following events are available and exposed in sysfs:
> 
>   vpa_dtl/dtl_cede/ - Trace voluntary (OS initiated) virtual processor waits
>   vpa_dtl/dtl_preempt/ - Trace time slice preempts
>   vpa_dtl/dtl_fault/ - Trace virtual partition memory page faults.
>   vpa_dtl/dtl_all/ - Trace all (dtl_cede/dtl_preempt/dtl_fault)
> 
> Added interface defines supported event list, config fields for the
> event attributes and their corresponding bit values which are exported
> via sysfs. User could use the standard perf tool to access perf events
> exposed via vpa-dtl pmu.
> 
> The VPA DTL PMU counters do not interrupt on overflow or generate any
> PMI interrupts. Therefore, the kernel needs to poll the counters, added
> hrtimer code to do that. The timer interval can be provided by user via
> sample_period field in nano seconds.
> 
> Result on power10 SPLPAR system with 656 cpu threads.
> In the below perf record command with vpa_dtl pmu, -c option is used
> to provide sample_period whch corresponding to 1000000000ns i.e; 1sec
> and the workload time is also 1 second, hence we are getting 656 samples:
> 
> [command] perf record -a -R -e vpa_dtl/dtl_all/ -c 1000000000 sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.828 MB perf.data (656 samples) ]
> 
> There is one hrtimer added per vpa-dtl pmu thread. Code added to handle
> addition of dtl buffer data in the raw sample. Since DTL does not provide
> IP address for a sample and it just have traces on reason of
> dispatch/preempt, we directly saving DTL buffer data to perf.data file as
> raw sample. For each hrtimer restart call, interface will dump all the
> new dtl entries added to dtl buffer as a raw sample.
> 
> To ensure there are no other conflicting dtl users (example: debugfs dtl
> or /proc/powerpc/vcpudispatch_stats), interface added code to use
> "down_write_trylock" call to take the dtl_access_lock. The dtl_access_lock
> is defined in dtl.h file. Also added global reference count variable called
> "dtl_global_refc", to ensure dtl data can be captured per-cpu. Code also
> added global lock called "dtl_global_lock" to avoid race condition.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
> Notes:
> 
> - Made code changes on top of recent fix sent by Michael Ellerman.
>    Link to the patch: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240819122401.513203-1-mpe@ellerman.id.au/
> 
>   arch/powerpc/perf/Makefile  |   2 +-
>   arch/powerpc/perf/vpa-pmu.c | 469 ++++++++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h  |   1 +
>   3 files changed, 471 insertions(+), 1 deletion(-)
>   create mode 100644 arch/powerpc/perf/vpa-pmu.c


Seems like it doesn't build on PPC64:

arch/powerpc/perf/vpa-pmu.c#L212
passing argument 1 of 'up_write' from incompatible pointer type 
[-Wincompatible-pointer-types]

arch/powerpc/perf/vpa-pmu.c#L261
passing argument 1 of 'down_write_trylock' from incompatible pointer 
type [-Wincompatible-pointer-types]

arch/powerpc/perf/vpa-pmu.c#L402
passing argument 1 of 'up_write' from incompatible pointer type 
[-Wincompatible-pointer-types]

