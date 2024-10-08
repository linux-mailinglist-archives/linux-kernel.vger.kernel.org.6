Return-Path: <linux-kernel+bounces-355866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D499582F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F661F21BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6E2141DF;
	Tue,  8 Oct 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcPr1h1R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02558213EFB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418232; cv=none; b=EEHXAeKvx7ReaUhKG1W7yK5WiUNvxkJT9b0U0qpKWk5jlKerTsXPNBs8sXqBYJiYUKW+5/deR1+n1DfVYwGuw85MN14jugQO9cGkLpp4/wUVNgThMfADpa0kVHllbvJO4jfOm6kz68jVEdnQmVWsaC+Ls9ny/bNjsNZGIaGmuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418232; c=relaxed/simple;
	bh=q2xoNqMJNqDn8F+cJmfgQ+xPZG8EqIivYnaaQoRudho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVbkHOFafTHFXdIUp7apToeCiO/jzPUdlAmCyZ17s5F1NnQCWBYcTLWqv/+8UWHXbiTQnlkEsdPLDwKjZ2IEt39N4yEOeFRxJQtflU80G92v7bhXwAfUWMdYxrttUK9eOcHp7buH4iojSv1VlEQibXkkxvF/hpk+HT1ROjrLXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcPr1h1R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728418231; x=1759954231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q2xoNqMJNqDn8F+cJmfgQ+xPZG8EqIivYnaaQoRudho=;
  b=jcPr1h1RoMgxAWWLKpTsXUkwVJM1jsBt3skGMDJ6Q/OobeLdTe8W4GY5
   5Uak0qSljZdL4VDyr6cBRqk4+IokiQVqjF7t06NrLJu1X3/42V7IEAtuv
   MphASoMp4xAf81l8cifqTmRFKF86zE8Y8+xnakpmGIjjMpW65BpzXynWK
   ksiziEY/wIVct5QSa0JZVghJCrF7MrA2XOSVxZzrjBENGZrIpwK+/pLyt
   TKtofM+0Zkm6QymeibdV+eDrIGa3T1MhJ3hpnrO0a3z4gCVEZUkBY1/9u
   wo0ggIrWcrw9zeD6USyrIgMDFpbcXFYl8uCQI0/HE8IU2DUqiKguIcdV2
   g==;
X-CSE-ConnectionGUID: S3zdOB6eSTWBFOoEEurcXQ==
X-CSE-MsgGUID: LTUCZcEPR6epq/5Or8qWEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31549803"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="31549803"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 13:10:31 -0700
X-CSE-ConnectionGUID: IOLLLd7FQmy9jUU9OaBpfQ==
X-CSE-MsgGUID: OmPw/QJ+QYG7EndN9XZnjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76332658"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 13:10:30 -0700
Received: from [10.212.24.252] (kliang2-mobl1.ccr.corp.intel.com [10.212.24.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2129420B5782;
	Tue,  8 Oct 2024 13:10:29 -0700 (PDT)
Message-ID: <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
Date: Tue, 8 Oct 2024 16:10:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
To: Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
 <875xq2tv05.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <875xq2tv05.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-08 12:33 p.m., Thomas Gleixner wrote:
> On Fri, Sep 13 2024 at 10:10, kan liang wrote:
>> +static void __init init_rapl_pmu(void)
>> +{
>> +	struct rapl_pmu *pmu;
>> +	s32 rapl_pmu_idx;
>> +	int cpu;
>> +
>> +	cpus_read_lock();
>> +
>> +	for_each_cpu(cpu, cpu_online_mask) {
> 
> How is that supposed to work, when not all CPUs are online when
> init_rapl_pmus() is invoked?
> 

RAPL is a module. The module_init() is called during do_initcalls(),
which is after the smp_init(). The cpu_online_mask has been setup in the
smp_init().

I also patched the kernel to double check. The cpu_online_mask indeed
shows all the online CPUs.

[    7.021212] smp: Brought up 1 node, 48 CPUs
[    7.021212] smpboot: Total of 48 processors activated (211200.00
BogoMIPS)
... ...
[   16.557323] RAPL PMU: rapl_pmu_init: cpu_online_mask 0xffffffffffff


Thanks,
Kan

