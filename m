Return-Path: <linux-kernel+bounces-561982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F170DA619C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C413B4042
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83002040A4;
	Fri, 14 Mar 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWjy0RXh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF02F3B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978085; cv=none; b=korv58M12OTKhTAyf/NY61fEHDT5KOvnf004/Fd7qjToGgJe8hMJj59lpf5QuAwp/8mY0MtCcejs8mP3TWMvtnoTI5jGWhBYCKB8aUvfi9iFPtfMybMUsDmm4xsPWkz5uMvfitLRsd3vNmDxEH1TPsK8Eoy/7Q62Av3knlyReqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978085; c=relaxed/simple;
	bh=uMMDkGQ6VhesV55oSepUIph7REV8G1+tG7T4C0ivI9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eIgnOsHhzac4Q7pqMOoyFMeHD0R3CaevBGwIU4eGiq6cITRbOew823+c565Q3XRGS5ua4LInYXsRY5XXCNB1Ztzn1vE4AkhhOIuBbtILVJ2QVbcQEIQ/jkndgnt70c6A/XxSgz1CPGR2w6YYcLNBn3Mz2Gw7kjT3g9R5obrXQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWjy0RXh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741978084; x=1773514084;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=uMMDkGQ6VhesV55oSepUIph7REV8G1+tG7T4C0ivI9w=;
  b=NWjy0RXh8D6GmuWlXk56TrH7QK/XrToGF8SUV3NUot4Aj63lZ5KrKlu2
   XQ6CkNTRe/vtewux+bZX78p8XZBgiSCtMO2rxukmQAN6TynjQO5/Q0zqe
   J6ojZY5VxYATYkzj9vqVvhhuSM+pjx+4IszexQyYtYAa9843WuDNKA5fT
   Y8UPyq5Y4uhbAjuHPyi4yPwlAt2TcHaI4ZN0BDH5Ag15T5tW309of+YKC
   VQYAaiMBAMiUOGT8vFk7YqvcHC59nMcv7YyRG8fNlH+QQvJoEvktq7XVA
   qpVySmaQGy5dZvC49BUgWwIOTa0CTIW0R+lPrcaUzTarsWHZUoPBMac6T
   A==;
X-CSE-ConnectionGUID: 7sMO9Kf4RSCq7faqa1JHvw==
X-CSE-MsgGUID: FS5LyT88R7WB9wmlXTxgvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42390695"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42390695"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:48:03 -0700
X-CSE-ConnectionGUID: f4IqP3YjTOWZi2qnkPbuVw==
X-CSE-MsgGUID: rQYjG0V0SuOLO8sAQARJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121395947"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:48:02 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 29C2320B5736;
	Fri, 14 Mar 2025 11:48:01 -0700 (PDT)
Message-ID: <b69595c9-5240-40ea-89e6-c36331ca245c@linux.intel.com>
Date: Fri, 14 Mar 2025 14:48:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] perf/x86/intel: Support auto counter reload
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
 linux-kernel@vger.kernel.org, eranian@google.com, thomas.falcon@intel.com
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
 <20241010192844.1006990-4-kan.liang@linux.intel.com>
 <20250314102031.GL19344@noisy.programming.kicks-ass.net>
 <5c6b52ec-e903-42be-aa57-675abc350241@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5c6b52ec-e903-42be-aa57-675abc350241@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-14 9:48 a.m., Liang, Kan wrote:
>>> +	}
>>> +}
>>> +
>>> +static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>>> +{
>>> +	struct perf_event *event;
>>> +	int ret = x86_schedule_events(cpuc, n, assign);
>>> +
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (cpuc->is_fake)
>>> +		return ret;
>>> +
>>> +	event = cpuc->event_list[n - 1];
>> ISTR seeing this pattern before somewhere and then argued it was all
>> sorts of broken. Why is it sane to look at the last event here?
> The schedule_events() is invoked for only two cases, a new event or a
> new group. Since the event_list[] is in enabled order, the last event
> should be either the new event or the last event of the new group.
> 
> The is_acr_event_group() always checks the leader's flag. It doesn't
> matter which event in the ACR group is used to do the check.
> 
> Checking the last event should be good enough to cover both cases.

This is an old implementation. Actually, I once sent a V3 last month
which move the codes to late_setup(). The late_setup was introduced
by the counters snapshotting feature. It does a late configuration in
the x86_pmu_enable() after the counters are assigned.
https://lore.kernel.org/lkml/173874832555.10177.18398857610370220622.tip-bot2@tip-bot2/

We don't need to check the last event anymore.

The V3 optimize the late_setup() a little bit.
https://lore.kernel.org/lkml/20250213211718.2406744-3-kan.liang@linux.intel.com/

and extend it for both counters snapshotting and ACR.
https://lore.kernel.org/lkml/20250213211718.2406744-6-kan.liang@linux.intel.com/

But other comments still stand. I will send a V4 later.

Thanks,
Kan

