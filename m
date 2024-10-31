Return-Path: <linux-kernel+bounces-390585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2079B7BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6FC2818D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15A19D89D;
	Thu, 31 Oct 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gagkVmBl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gv9/SICB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14914901B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381609; cv=none; b=WYfPXW99vhb1H3cfR/QJIHRovPlLXReKmRQtB1huQI4jwVSmSt4ffCEvVLwQ51/GGUM0Dk3Qe+kmDV2m3PJVvP4pg1Y7Z/e6gg93DRU3tODA5tMN+KO/JpLHPhonOBXTZJs6KlNIO1sPPxMD6gTRGR02VtMt49we2DMFoR606rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381609; c=relaxed/simple;
	bh=pPToxeOUNHdYOH/jCPN3t6khhYPJs65c39YQeW1/9N4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGVwKCll/657YNB0AG6ctFe61+jhadmM1QcSeemVVeC9L/oC4rtFNkp7A8o6T1Hr4Ps/UBnuoSp8G9YiIUMTYggqUbKWyOVsLQd3J5htFBJS0tJtadwVOGIKCS7hedxl98d+K7WoyPCuHXPCMxbcBFq59MIx4gRLxeohJRR/ooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gagkVmBl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gv9/SICB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730381603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26Hc5JbZE9H+bruksdDbu2UeUsWpWpzQwfy9DOEAULY=;
	b=gagkVmBl6WnQSFOD69Xb95l+H7UmNHpjjkTYe6X/DWIDEh0GjAMD8+vmk0wUpfeDt8O2X1
	CNA9S2Iv7ftRB/v4mTD6XiFPHvKIRx1ts35Dvt+P9eY67JNkhcFQZ5DXQvtYEg9IvGCpI7
	a/0C2D0B6aFNWSo+gX/VichuLWITHmmbZrqy8LCFk+8dSe7HdrcpAXm07hPpl02NyGVtSB
	yu4cSWIV57zaOxhosEs23HTdt2nPHkGUGxMsIiL4erY0LsD2WVrA5dzHE+DoQWnYDMM9xf
	jq+1iL8avH7blQ39B7u5lOKChCBlbLUiNGUdImnUWh45ZCEF9bHLP9Go+o2+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730381603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26Hc5JbZE9H+bruksdDbu2UeUsWpWpzQwfy9DOEAULY=;
	b=gv9/SICB709Be4Ze+KmpFVPyPGNclfHrUo9edWFPCMcONde8dWy5Dl1l4sJaeLKcfstvyH
	5+/U5qFxfh6KU+Cg==
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, peterz@infradead.org,
 mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 pierre.gondois@arm.com, dietmar.eggemann@arm.com
Cc: yangyicong@hisilicon.com, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
 linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com
Subject: Re: [PATCH v7 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
In-Reply-To: <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com>
References: <20241030125415.18994-1-yangyicong@huawei.com>
 <20241030125415.18994-2-yangyicong@huawei.com> <87ttcty71m.ffs@tglx>
 <488d8289-b538-01cb-5de7-d691f49c0d7b@huawei.com>
Date: Thu, 31 Oct 2024 14:33:23 +0100
Message-ID: <87frocwg64.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 31 2024 at 20:17, Yicong Yang wrote:
> On 2024/10/30 22:55, Thomas Gleixner wrote:
>>> +static inline bool topology_is_primary_thread(unsigned int cpu)
>>> +{
>>> +	/*
>>> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
>>> +	 * Architectures do have a special primary thread (e.g. x86) need
>>> +	 * to override this function. Otherwise just make the first thread
>>> +	 * in the SMT as the primary thread.
>>> +	 */
>>> +	return cpu == cpumask_first(topology_sibling_cpumask(cpu));
>> 
>> How is that supposed to work? Assume both siblings are offline, then the
>> sibling mask is empty and you can't boot the CPU anymore.
>> 
>
> For architectures' using arch_topology, topology_sibling_cpumask() will at least
> contain the tested CPU itself. This is initialized in
> drivers/base/arch_topology.c:reset_cpu_topology(). So it won't be
> empty here.

Fair enough. Can you please expand the comment and say:

     The sibling cpumask of a offline CPU contains always the CPU
     itself.

> Besides we don't need to check topology_is_primary_thread() at boot time:
> -> cpu_up(cpu)
>      cpu_bootable()
>        if (cpu_smt_control == CPU_SMT_ENABLED &&
>            cpu_smt_thread_allowed(cpu)) // will always return true if !CONFIG_SMT_NUM_THREADS_DYNAMIC
>          return true; // we'll always return here and @cpu is always bootable

cpu_smt_control is not guaranteed to have CPU_SMT_ENABLED state, so this
argument is bogus.

> Also tested fine in practice.

I've heard that song before.

What matters is not what you tested. What matters is whether the code is
correct _and_ understandable.

Thanks,

        tglx

