Return-Path: <linux-kernel+bounces-355906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F36995886
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73FA1C2192A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783C21500F;
	Tue,  8 Oct 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OppcZTz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTN+en0M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360A7DA76
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419769; cv=none; b=ILwZNaXp7BRvUZOEafbk+H9nu5izakMAPZHGoXE9ddnsAeOHE+5x9gf5oCYpKo6GeZe8OF6i3eMPKlgHtLxv7ryrAiTx2zVmd0Ef/PpBZuEh+bJZ2YzHYILx6y3xfadg5rotYjgWgME96UH4IQ90cbF7Yl8wQUqDRFmwrozbAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419769; c=relaxed/simple;
	bh=B2y3F3LyxXbELqVVkDy1nG3Uzg1gTqtNASI9qMw1EQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ojkfuxk7l0r0P0WItqXQM0sl/wBz6ItcJbKHV+viCGyDEPDvQyH3++bP6CIE7ddJ6LDIfQKdzUtV5NQqIUPGAHQXQ+Xbwu3xJPsERRVDZW455+SGWFpqT2OaTWhuGE8U0Li4Gx95+z7/ru49IMyb65f79IuBHAF5veWf5AT8YaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OppcZTz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTN+en0M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728419766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dH/hatyQ32Mb5T5947LJOpV0fxd2U5KM2RpMlfGwfA=;
	b=2OppcZTzar5tKcyPOw3HxHvrDcR/ITIq2nKYtbL1UgmCByz0/dCjQHyRcDVu4HPGyHYWc3
	QKjMneeptb30VmBAfE0+x0acBqHYGNsBpkQxozMIzDcF3bAkOnTxjedqsY2xTdEU4Eucx3
	jdiELk5EU9dX2MKAPqYwvWPRw9EcvUhCBBV9V1WUQfyKzog4loeocAymLVwg+SX6tslCaC
	jcYm1v8Elf7MPc1Z1ocljOTJ3gv7dlnuyz6SUMFqb8TfdDjtrC6UwHblcSJ5RLHVfJt1s5
	Uhfr3Bw7xkisVHYuZsgQlayncMYB09jBsKfgZhHORLf0JH8pBk4M28q51geKkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728419766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dH/hatyQ32Mb5T5947LJOpV0fxd2U5KM2RpMlfGwfA=;
	b=bTN+en0MZbEKsopkPRHbiOM3sdYi7ao05/GQe0Z0lea2FupohNLWr2n7FVMqOAMxMYR36I
	fjFGw5U8OMWhSpBA==
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>, Dhananjay Ugwekar
 <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
In-Reply-To: <87ploas5rb.ffs@tglx>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
 <875xq2tv05.ffs@tglx>
 <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
 <87ploas5rb.ffs@tglx>
Date: Tue, 08 Oct 2024 22:36:06 +0200
Message-ID: <87msjes56x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 08 2024 at 22:23, Thomas Gleixner wrote:
> On Tue, Oct 08 2024 at 16:10, Kan Liang wrote:
>> On 2024-10-08 12:33 p.m., Thomas Gleixner wrote:
>>> On Fri, Sep 13 2024 at 10:10, kan liang wrote:
>>>> +static void __init init_rapl_pmu(void)
>>>> +{
>>>> +	struct rapl_pmu *pmu;
>>>> +	s32 rapl_pmu_idx;
>>>> +	int cpu;
>>>> +
>>>> +	cpus_read_lock();
>>>> +
>>>> +	for_each_cpu(cpu, cpu_online_mask) {
>>> 
>>> How is that supposed to work, when not all CPUs are online when
>>> init_rapl_pmus() is invoked?
>>> 
>>
>> RAPL is a module. The module_init() is called during do_initcalls(),
>> which is after the smp_init(). The cpu_online_mask has been setup in the
>> smp_init().
>>
>> I also patched the kernel to double check. The cpu_online_mask indeed
>> shows all the online CPUs.
>>
>> [    7.021212] smp: Brought up 1 node, 48 CPUs
>> [    7.021212] smpboot: Total of 48 processors activated (211200.00
>> BogoMIPS)
>> ... ...
>> [   16.557323] RAPL PMU: rapl_pmu_init: cpu_online_mask 0xffffffffffff
>
>  1) Start your kernel with maxcpus=2 (not recommended, but ...)
>  2) Load the module
>  3) Online the rest of the CPUs from userspace
>
> If your machine has more than one die you might be surprised...

You can make this work because the new topology code allows you to
retrieve the possible number of cores/dies/packages even when they have
not been onlined yet. 

Thanks,

        tglx

