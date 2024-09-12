Return-Path: <linux-kernel+bounces-326444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC94976870
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE551C22CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE31A0BD3;
	Thu, 12 Sep 2024 11:59:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78AC1E51D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142370; cv=none; b=ocRGat7qnVFs4I/Cj5aZk8J4aj0ziO++JhS+0J9+Cuakv3U4eQ13RSU0soFq2duN7AGVmFB91xF8+nSz9UdY15LUCKEIRpbub7aLVuWb9e8go25MVwn6S0gD5kgcx7w7s49vOOU51gG6xjr+oXqDoS6ElLCxD1IE+gW2FDibbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142370; c=relaxed/simple;
	bh=dRk9jKiFnZRIm1wfIHYvbHFiSWgN3xH57RqWDk9WAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drn8HzAEvZ6A9WWRyIW0IY2wcdvoHUBPH79A16XTuPl6JukpDrgq6YU3SmmHO1akGBPY/crH5xWRU8h+YQ4PcySymcTINVgOOqhC2bE+QOeCRQST4E4ImoPCmSdxOP7wUtKbLXeX8Oj7DbdgEJ1EZG8j8V59lIsI5liSRUqGTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E96DA7;
	Thu, 12 Sep 2024 04:59:57 -0700 (PDT)
Received: from R5WKVNH4JW (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE0D3F73B;
	Thu, 12 Sep 2024 04:59:24 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:59:16 +0200
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, Pierre Gondois <pierre.gondois@arm.com>,
	linuxppc-dev@lists.ozlabs.org, bp@alien8.de,
	dave.hansen@linux.intel.com, mingo@redhat.com,
	linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
	peterz@infradead.org, tglx@linutronix.de, sudeep.holla@arm.com,
	will@kernel.org, catalin.marinas@arm.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH v5 3/4] arm64: topology: Support SMT control on ACPI
 based system
Message-ID: <ZuLXlOe0CyiH5eXd@R5WKVNH4JW>
References: <a998c723-7451-439a-9c88-7c8b5c1b890b@arm.com>
 <00e6110a-462a-c117-0292-e88b57d27a05@huawei.com>
 <3947cb79-3199-4cd6-b784-51a245084581@arm.com>
 <1a7b5ac7-f040-672f-07a0-d7f3dc170c88@huawei.com>
 <6c05e39c-41f3-451c-b119-7b8662c1ceee@arm.com>
 <7f722af2-2969-aae5-1fb5-68d353eb95b9@huawei.com>
 <277bd093-422b-4301-92a3-d0a58eb41af5@arm.com>
 <10082e64-b00a-a30b-b9c5-1401a54f6717@huawei.com>
 <Ztqp-SUinu8C9a-P@R5WKVNH4JW>
 <bb2bd7f4-e0ea-a771-7960-e35949ec9e03@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2bd7f4-e0ea-a771-7960-e35949ec9e03@huawei.com>

On Fri, Sep 06, 2024 at 04:36:30PM +0800, Yicong Yang wrote:
> On 2024/9/6 15:06, Morten Rasmussen wrote:
> > Hi Yicong,
> > 
> > On Thu, Sep 05, 2024 at 08:02:20PM +0800, Yicong Yang wrote:
> >> On 2024/9/5 16:34, Pierre Gondois wrote:
> >>> Hello Yicong,
> >>>
> >>> If a platform has CPUs with:
> >>> - 1 thread
> >>> - X (!= 1) threads
> >>> Then I think that the asymmetry is not detected
> >>
> >> Ah ok, I only handle the case where there are several thread numbers except no SMT CPUs in the
> >> system. For this case I was thinking we don't need to handle this since there's only one kind
> >> of SMT core in the system, control should works fine for the SMT CPU clusters and we may not
> >> care about the CPUs with no SMT.
> >>
> >> Below code should handle the case if we initialize the max_smt_thread_num to 0. I also
> >> reword the warning messages to match the fact. For heterogeneous SMT topology we still
> >> support control SMT by on/off toggle but not fully support setting the thread number.
> >>
> >> 	int max_smt_thread_num = 0;
> >> 	[...]
> >> 	/*
> >> 	 * This should be a short loop depending on the number of heterogeneous
> >> 	 * CPU clusters. Typically on a homogeneous system there's only one
> >> 	 * entry in the XArray.
> >> 	 */
> >> 	xa_for_each(&hetero_cpu, hetero_id, entry) {
> >> 		/*
> >> 		 * If max_smt_thread_num has been initialized and doesn't match
> >> 		 * the thread number of this entry, then the system has
> >> 		 * heterogeneous SMT topology.
> >> 		 */
> >> 		if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)
> >> 			pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
> > 
> > What does 'partly supported' mean here?
> > 
> > If the SMT control doesn't work as intended for this topology, I don't
> > think it should be enabled for it.
> > 
> 
> The /sys/devices/system/cpu/smt/control supports 2 kind of controls [1]
> (a) enable/disable SMT entirely by writing on/off
> (b) enable/disable SMT partially by writing a valid thread number (CONFIG_SMT_NUM_THREADS_DYNAMIC)
> 
> We assume 3 kind of SMT topology:
> 1. homogeneous SMT topology, all the CPUs support SMT or not
> 2.1 heterogeneous SMT topology, part of CPU clusters have SMT and others not. Clusters support SMT
>     have the same SMT thread number
> 2.2 heterogeneous SMT topology, part of CPU clusters have SMT and the thread number may differs
>     (e.g. cluster 1 is of SMT 2 and cluster 2 is of SMT 4. not sure there's such a real system)
> 
> For any of above SMT topology, control (a) should work as expected. When enabling SMT by writing "on"
> the SMT is disabled for those CPU clusters who have SMT. Same for disabling SMT by writing "off".
> But control (b) may not work for case 2.2 since the SMT thread number is not the same across
> the system.
> 
> For this series alone we won't met this since CONFIG_SMT_NUM_THREADS_DYNAMIC is not enabled.
> So control (b) only supports write 1/max_thread which behaves same as write off/on and will
> work as intended for all the 3 cases. As discussed Pierre will add support for
>  CONFIG_SMT_NUM_THREADS_DYNAMIC since thunderX2 is a symmetric SMT4 machine and
> CONFIG_SMT_NUM_THREADS_DYNAMIC would be useful. We thought a warning should be useful
> if running on a system of case 2.2.

Thanks for explaining the situation.

So IIUC, for case 2.2 there will be _no_ failures if someone writes a
value different from 1 or max_threads?

The SMT control code can handle that max_threads isn't the correct
number of threads for all cores in the system?

