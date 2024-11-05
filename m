Return-Path: <linux-kernel+bounces-396667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064A9BD04B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075AB1F21AF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A451D90DD;
	Tue,  5 Nov 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bH/+laet"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248293BB21
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820320; cv=none; b=pld7kjdq1LJROHXkK0S1ePyoX5+VmJufTNdWtRJ5x37SmPgoeXhVaw0ZqQf1z1JFmVBbrQrgQh7OFNXgX24VJueuk6ul5XYWieOjWjrb9kxZ/hL3roww4RMbDTcsuKWLm2FkgHWt9D4DOBEBOA8YW1rH3eMjMJjJUOEkQpGBRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820320; c=relaxed/simple;
	bh=FUkiDriTfAD3u0Bm8kr9w3o9c3VPn/SGGQO11L/BGak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZx4+aydeL34+qpwYZMfNtnuXBUbEW/Z/pwrgpEy7C1ibZxDQTL2KR5fuyzZTH62eigrUx6ZwebfWBrGgnUfrfAg/5tkgrHaSlfakhxg/n2mdcGldtTxqJXj17EZLYmamnLUer873CleojQnK+UR44otZk81XUIg6nnAsqAb8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bH/+laet; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730820319; x=1762356319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FUkiDriTfAD3u0Bm8kr9w3o9c3VPn/SGGQO11L/BGak=;
  b=bH/+laetPIQy7wvl2fHKuBVuNZoB7xVg9hGqKJ68mfdxiMkqhu0QbThd
   n8R+e1xe5kYWUFCPrT1LAf8AA2aizW8g61OMbokflGt+eLPJQJphfuqu9
   stnnuwVnX5xU7lq70qHLzlLtEHxTOLxu0uodhY8wkO1RiGMiXvM9xfj6U
   qEOkNAAEh7QecmBE28+juS8DeEC5cfBmvaaXhZpMVdutyrwA1mVSQB8/B
   GHtj21osEOWTpE7Yi+cP8LLQhhAKkPxMRL72CRBcT284SBZYBm1r31SVh
   bAuuRYLpX2DT8hEq8r8UAgBVcE/1Twmp/PEL614M5ZB2Xey0XhGNsnEXQ
   A==;
X-CSE-ConnectionGUID: Tn4C9YPQR9O3ebdgSb1s8g==
X-CSE-MsgGUID: 4VnaSQx0R1e57eSMIYgoGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30690802"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30690802"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:25:18 -0800
X-CSE-ConnectionGUID: ZlZUO2Z6QpK23j8mxTIfsw==
X-CSE-MsgGUID: UTdz7eegS/2QVGF55v/CcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="83715750"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:25:18 -0800
Received: from [10.212.68.38] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 629AB20B5703;
	Tue,  5 Nov 2024 07:25:16 -0800 (PST)
Message-ID: <19e1e59c-8a1b-4eb0-8e4a-222417a1bd4d@linux.intel.com>
Date: Tue, 5 Nov 2024 10:25:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
References: <20241104133909.669111662@infradead.org>
 <20241104135519.715883982@infradead.org>
 <98e43590-6e9f-4d7d-8ae5-184262dae434@linux.intel.com>
 <20241105151651.GI10375@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241105151651.GI10375@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-11-05 10:16 a.m., Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 10:08:54AM -0500, Liang, Kan wrote:
>>> @@ -2427,6 +2429,7 @@ __perf_remove_from_context(struct perf_e
>>>  			   void *info)
>>>  {
>>>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
>>> +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
>>
>> Set the PERF_EVENT_STATE_OFF as default seems dangerous.
>> If the event was in an error state, the state will be overwritten to the
>> PERF_EVENT_STATE_OFF later.
>>
>> One example may be the perf_pmu_migrate_context(). After the migration,
>> it looks like all the error state will be cleared.
>>
>> Thanks,
>> Kan
>>
>>>  	unsigned long flags = (unsigned long)info;
>>>  
>>>  	ctx_time_update(cpuctx, ctx);
>>> @@ -2435,16 +2438,22 @@ __perf_remove_from_context(struct perf_e
>>>  	 * Ensure event_sched_out() switches to OFF, at the very least
>>>  	 * this avoids raising perf_pending_task() at this time.
>>>  	 */
>>> -	if (flags & DETACH_DEAD)
>>> +	if (flags & DETACH_EXIT)
>>> +		state = PERF_EVENT_STATE_EXIT;
>>> +	if (flags & DETACH_REVOKE)
>>> +		state = PERF_EVENT_STATE_REVOKED;
>>> +	if (flags & DETACH_DEAD) {
>>>  		event->pending_disable = 1;
>>> +		state = PERF_EVENT_STATE_DEAD;
>>> +	}
>>>  	event_sched_out(event, ctx);
>>>  	if (flags & DETACH_GROUP)
>>>  		perf_group_detach(event);
>>>  	if (flags & DETACH_CHILD)
>>>  		perf_child_detach(event);
>>>  	list_del_event(event, ctx);
>>> -	if (flags & DETACH_DEAD)
>>> -		event->state = PERF_EVENT_STATE_DEAD;
>>> +
>>> +	event->state = state;
> 
> How about we make this:
> 
> 	event->state = min(event->state, state);
> 
> ?

Yep, it looks good to me.

Thanks,
Kan


