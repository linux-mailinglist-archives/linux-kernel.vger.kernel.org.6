Return-Path: <linux-kernel+bounces-355879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5C995856
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF7289EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17885212D27;
	Tue,  8 Oct 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmJVcPrC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9R87JSp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0871215010
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419042; cv=none; b=fHojlNr4kHJPu19Z4NI1xJ9IZmK3REbshGYrKE2Le3smHjDwlpXY7jTzTme5cPEni4Jz/JnpnvZ87+cVHDNIPO84qfx8/fOm4RjJvzZga5tVPB5IXQZzjznCebtl70/n7Zwm7CiwNI3v5Wi3IJR9fu0soW5LpLevw25rLWahQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419042; c=relaxed/simple;
	bh=JaEiQ2jC4JfvnbWEueXdScRlCs4bRDSeloUkgCBGI98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=an4okwjVmysClYG5/4b0R2RRFQvohOdDbYEC3OFKsrUL71FjvwEMm9Bfe4Ts0/N5/a4L7ahlP1PivV7b8U7s7mTkTi9hjLHKyCZ7aedG29P17g6VBtaGxmUfZ23KGz89CchZfrHkDXZPfnEUBmiF5acuXeKJweFMM6Qtu3TZ03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZmJVcPrC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9R87JSp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728419032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5sMYfhKdtOUddKjzaYt54bGjINVSubsjk0NDKA3LC8=;
	b=ZmJVcPrCBysZQftHSIQ28RZT9O1EQvCYxdIZqZc0K2oSybHo2wmwkfJpBfYBSit9jTnQP+
	sct1N20i8ocCbqCN5xCc05u4w9NG8RvmGO8IWNYzHxRpZbzCRzUzcnkuZianxsTlA7hGCO
	0kt2S7nyM2q1SfVf22GN2pqwM5UlPva7CklNpH+9Y5m4enPR9NRiKooKB6dfCgcbUJyMah
	Z5dyFCn1Hx4zynfITSRo9Eivfc0C1uQaThKDNEYRHUm4wFZ4+gGFSOjWT7xfnKwnlOz4EF
	nsZav86e1QeI7571J+nQGgsfRN9Rg4Ti2lLnI45A5/ojPRmI3jvDGdYaZBE56A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728419032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5sMYfhKdtOUddKjzaYt54bGjINVSubsjk0NDKA3LC8=;
	b=h9R87JSpuKe0DhRYym8FnN69Emqv3GC1TjykMHwiW8j7oyCAbLLi0kvkGqyVCS/+LWFdcW
	eNx0p7YnMksNoCCA==
To: "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>, Dhananjay Ugwekar
 <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
In-Reply-To: <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
 <875xq2tv05.ffs@tglx>
 <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
Date: Tue, 08 Oct 2024 22:23:52 +0200
Message-ID: <87ploas5rb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 08 2024 at 16:10, Kan Liang wrote:
> On 2024-10-08 12:33 p.m., Thomas Gleixner wrote:
>> On Fri, Sep 13 2024 at 10:10, kan liang wrote:
>>> +static void __init init_rapl_pmu(void)
>>> +{
>>> +	struct rapl_pmu *pmu;
>>> +	s32 rapl_pmu_idx;
>>> +	int cpu;
>>> +
>>> +	cpus_read_lock();
>>> +
>>> +	for_each_cpu(cpu, cpu_online_mask) {
>> 
>> How is that supposed to work, when not all CPUs are online when
>> init_rapl_pmus() is invoked?
>> 
>
> RAPL is a module. The module_init() is called during do_initcalls(),
> which is after the smp_init(). The cpu_online_mask has been setup in the
> smp_init().
>
> I also patched the kernel to double check. The cpu_online_mask indeed
> shows all the online CPUs.
>
> [    7.021212] smp: Brought up 1 node, 48 CPUs
> [    7.021212] smpboot: Total of 48 processors activated (211200.00
> BogoMIPS)
> ... ...
> [   16.557323] RAPL PMU: rapl_pmu_init: cpu_online_mask 0xffffffffffff

 1) Start your kernel with maxcpus=2 (not recommended, but ...)
 2) Load the module
 3) Online the rest of the CPUs from userspace

If your machine has more than one die you might be surprised...

Thanks,

        tglx

