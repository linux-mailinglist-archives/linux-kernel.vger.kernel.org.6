Return-Path: <linux-kernel+bounces-561594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17307A613CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0923E883160
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CC3200BBE;
	Fri, 14 Mar 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAnnbfQm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83351FF7C9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963114; cv=none; b=ZIf0dM2rtKtCHaw2tE3Ro2Jfp5AqrgnMpJ/acZakg1Nh+900QwkSfEQBLmyM56Pb7CUsMwgxybMFCwj6BF1mTwLtu59JmplO2OKbOw4J8qFnu0EkGYA9w6Hs6thXF1+7GuyssNkfyf5pO4lurTK7IdRZqm7638+XpBHOPvhZB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963114; c=relaxed/simple;
	bh=jTH9XdFtdO1Z0KkNHGhEi16y2vvmFS1zRIAktZ9HF8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JSiJlR2wJZ2HscPSGy6y4iy30GVve+xMwputdlYXODRKQdd9nC6quNwqrX5ayGembspLz5DYyZL8mw3UONOX0Wl3zGR/4yV5VKMBtUjYXfjLMD/XZj9QJASTsdE/YR/oXu6P0nnqlLg47Gz93nkR1StQ6OCwYIvc7S5tjqt2daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAnnbfQm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741963113; x=1773499113;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=jTH9XdFtdO1Z0KkNHGhEi16y2vvmFS1zRIAktZ9HF8w=;
  b=KAnnbfQm4AJqWsaFODHAdU3uD7TWikr2FPVBLsOH+83by2UUOe9fiXdH
   JMUAuGsYMv2XM+dTeliBG8fliys4rrfSoR8GNIwbVO9vedjPLaU+G7B/C
   WZsGZCk/JfDY/4yrWO5bysAwCWQvdZL6qdLOeG4Lp3N7jvLn3IugxrjcF
   PbqFYTUwzxVNzkr8V+rtGNgiSgkmnnHXpoS9nzXSMIuTBXJPZ4dP87UQf
   eZtaMY23wtBhL1Z2V/4nl+ev5VuynFS546poFrC1Mw7DJEwsusfJ9P/xI
   qevBi5FjuBci3fIm2px0eRMQy4ReLS1Zn/B0VrENurtiOMaSsJNBlisCt
   A==;
X-CSE-ConnectionGUID: INShEdSMRMm5st+NXIOZ9A==
X-CSE-MsgGUID: FGaP9QL1TwiR86hguRRQPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43291439"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43291439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:38:33 -0700
X-CSE-ConnectionGUID: 3pwVWW/zR3eqIzDXpUo30g==
X-CSE-MsgGUID: lvR22TT7TBWk6dR4W1t6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121341037"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:38:31 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3E68720B5736;
	Fri, 14 Mar 2025 07:38:30 -0700 (PDT)
Message-ID: <1ec56e83-be22-480c-be60-5b898fc5f5b7@linux.intel.com>
Date: Fri, 14 Mar 2025 10:38:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/7] perf: attach/detach PMU specific data
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
 <20250314000242.323199-3-kan.liang@linux.intel.com>
 <20250314125958.GC36322@noisy.programming.kicks-ass.net>
 <a619615f-3313-4e55-a780-f280fbb643dc@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a619615f-3313-4e55-a780-f280fbb643dc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-14 9:50 a.m., Liang, Kan wrote:
> 
> 
> On 2025-03-14 8:59 a.m., Peter Zijlstra wrote:
>> On Thu, Mar 13, 2025 at 05:02:38PM -0700, kan.liang@linux.intel.com wrote:
>>
>>> @@ -12551,6 +12813,14 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>>  	if (err)
>>>  		return ERR_PTR(err);
>>>  
>>> +	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
>>> +		err = attach_perf_ctx_data(event);
>>> +		if (err) {
>>> +			security_perf_event_free(event);
>>> +			return ERR_PTR(err);
>>> +		}
>>> +	}
>>> +
>>>  	/* symmetric to unaccount_event() in _free_event() */
>>>  	account_event(event);
>>>  
>>
>> This seems weird. We just pushed all the error handling into
>> __free_event(), and now you're adding one special case back.
>>
>> Also, you've placed it after security_perf_event_alloc(), which I
>> _think_ wants to be last.
> 
> Right, I will send a new series to fix it.
> 

I think the attach_perf_ctx_data() should be moved even earlier, right
after the perf_init_event(). Because the PERF_ATTACH_TASK_DATA is set in
the event_init()->hw_config(), rather than after perf attach the data.

So any errors between perf_init_event() and attach_perf_ctx_data(event)
would cause the detach_perf_ctx_data() mistakenly invoked.

@@ -5393,6 +5607,9 @@ static void __free_event(struct perf_event *event)
 	if (is_cgroup_event(event))
 		perf_detach_cgroup(event);

+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		detach_perf_ctx_data(event);
+
 	if (event->destroy)
 		event->destroy(event);
@@ -12481,6 +12746,18 @@ perf_event_alloc(struct perf_event_attr *attr,
int cpu,
 	if (IS_ERR(pmu))
 		return (void*)pmu;

+	/*
+	 * The PERF_ATTACH_TASK_DATA is set in the event_init()->hw_config().
+	 * The attach should be right after the perf_init_event().
+	 * Otherwise, the __free_event() would mistakenly detach the non-exist
+	 * perf_ctx_data because of the other errors between them.
+	 */
+	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
+		err = attach_perf_ctx_data(event);
+ 		if (err)
+			return ERR_PTR(err);
+	}
+
 	/*
 	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 	 * events (they don't make sense as the cgroup will be different


Thanks,
Kan


