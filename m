Return-Path: <linux-kernel+bounces-204607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2388FF12D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8561C21010
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F07197A6A;
	Thu,  6 Jun 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="histN5GR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71109198E6C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688919; cv=none; b=YuowYtGZ5onrW1wQVUnHYDhEN0e9rOQ4bviGWsg3FF+mnIFgrwLm4pJPfSdE6G139/QKFMPanFQIJjzHEq+K9SHdidxrjIy/ijKcukf4zRtqvbwvmtnj2V4YoU/HHzJcJb0NCML5JeIQtPceGXj+jxj8djxAoFzujYyv1MLyHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688919; c=relaxed/simple;
	bh=tVjh5ldKzE1KX+dKPWFFnscnyL9qo0R9eo6uonINpT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0RLQjGUTo+VoSiIdKyWRBQl3UWWml4JAeVXBBXXYdiDogJW0Fp1HsbFjtZ3amD1BNwtk9E+zNSa3bL40TerJsSLV+UveNoj0L2JZmFN07oN31K39Z+EpFJBp7kvr3Ih7Mme3Zm3XDPkGL1lFKcWGFCRgta95qXYddM49/39xJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=histN5GR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717688917; x=1749224917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tVjh5ldKzE1KX+dKPWFFnscnyL9qo0R9eo6uonINpT0=;
  b=histN5GRWAp9pL9ru6Ew4XnritHayhWoeKl1X/o3w6nEnsewCoEXYauq
   pfBmUhKIMqE3pU9/+aoLSixJNgvAzFnITlawfG0ZDLTkvs6MRu92tvXnZ
   ildGlMz6/EPFVyWKwlNA4nMS/X0VoeuDTAIkCG9QFc/9tIxJOuwwRNjRj
   twOyUpZ/MiW787cj8jaLjfMl126AzxTt5ZpKJF2GKqBE/T61n8O7dqsxU
   499MRlTJJZb/H70DB8PE8wtF/eoHFQgMJEu3T+LXeW8Vj+A0uYkRmfG1Q
   eu2tFEts5551XsQsFl1LwRfE2C3D/v+AdFpaZBCqnnKyBBHG9YodGjbzL
   Q==;
X-CSE-ConnectionGUID: QnWMGnvNS7uWFY2zBH/PCg==
X-CSE-MsgGUID: t3Ysf2tiR6qBFqNVqL6L+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25774697"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25774697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:48:37 -0700
X-CSE-ConnectionGUID: OyRaKrYGTpWiKXgN2mJMHQ==
X-CSE-MsgGUID: bVNx+HugQk+vxeWpv7b0sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42443089"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 08:48:36 -0700
Received: from [10.212.72.92] (kliang2-mobl1.ccr.corp.intel.com [10.212.72.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7FAB720B5703;
	Thu,  6 Jun 2024 08:48:34 -0700 (PDT)
Message-ID: <4622060b-b758-4629-9aa4-cc8334111be0@linux.intel.com>
Date: Thu, 6 Jun 2024 11:48:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] perf_events: exclude_guest impact on
 time_enabled/time_running
To: Stephane Eranian <eranian@google.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, "Narayan, Ananth" <ananth.narayan@amd.com>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>,
 Namhyung Kim <namhyung@google.com>, Mingwei Zhang <mizhang@google.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>
References: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-06 3:57 a.m., Stephane Eranian wrote:
> Hi Peter,
> 
> In the context of the new vPMU passthru patch series, we have to look
> closer at the definition and implementation of the exclude_guest
> filter in the perf_event_attr structure. This filter has been in the
> kernel for many years. See patch:
> https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com/
> 
> The presumed  definition of the filter is that the user does not want
> the event to count while the processor is running in guest mode (i.e.,
> inside the virtual machine guest OS or guest user code).
> 
> The perf tool sets is by default on all core PMU events:
> $ perf stat -vv -e cycles sleep 0
> ------------------------------------------------------------
> perf_event_attr:
>   size                             112
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> 
> In the kernel, the way this is treated differs between AMD and Intel because AMD
> does provide a hardware filter for guest vs. host in the PMU counters
> whereas Intel
> does not. For the latter, the  kernel simply disables the event in the
> hardware counters,
> i.e., the event is not descheduled.  Both approaches produce pretty
> much the same
> desired effect, the event is not counted while in guest mode.
> 
> The issue I would like to raise has to do with the effects on
> time_enabled and time_running
> for exclude_guest=1 events.
> 
> Given the event is not scheduled out while in guest mode, even though
> it is stopped, both time_enabled and time_running continue ticking
> while in guest mode.  If a measurement is 10s
> long but only 5s are in non-guest mode, then time_enabled=10s,
> time_running=10s. The count
> represents 10s worth of non guest mode, of which only 5s were really
> actively monitoring, but
> the user has no way of determining this.


For the latest design/implementation, only the exclude_guest=1 host
event can be successfully created for the case.
The end user should not expect that anything is collected in the guest
mode. So both the time_enabled and the time_running will be 5s.

> 
> If we look at vPMU passthru, the host event must have exclude_guest=1
> to avoid going into
> an error state on context switch to the vCPU thread (with vPMU
> enabled). 

That's the design in V1. There is no error state anymore in V2 and later
as suggested by Sean.
https://lore.kernel.org/all/ZhmIrQQVgblrhCZs@google.com/

The VM cannot be created if there are host events with exclude_guest=0.
If a VM has been created, user cannot create an event with
exclude_guest=0. So nothing will be moved to an error state on context
switch to the vCPU thread.

> But this time,
> the event is scheduled out, that means that time_enabled keeps
> counting, but time_running
> stops. On context switch back in, the host event is scheduled again
> and time_running restarts
> ticking. For a 10s measurement, where 5s here in the guest, the event
> will come out with
> time_enabled=10s, time_running=5s, and the tool will scale it up
> because it thinks the event
> was multiplexed, when in fact it was not. This is not the intended
> outcome here. The tool should
> not scale the count, it was not multiplexed, it was descheduled
> because the filter forced it out.
> Note that if the event had been multiplexed while running on the host,
> then the scaling would be
> appropriate.

The scaling will not happen, since both time_enabled and time_running
should be the same when there are enough counter resources.

> 
> In that case, I argue, time_running should be updated to cover the
> time the event was not running. That would bring us back to the case I
> was describing earlier.
> 
> It boils down to the exact definition of exclude_guest and expected
> impact on time_enabled
> and time_running. Then, with or without vPMU passthru, we can fix the
> kernel to ensure a
> uniform behavior.

I think the time_enabled should be the one that has a controversial
definition.
Should the time in the guest mode count as the enabled time for an host
event that explicitly sets the exclude_guest=1?

I think the answer is NO. So I implemented it in the code.

> 
> What are your thoughts on this problem?
> 

Peter, please share your thoughts. We want to make sure the design is on
the right track.

Thanks,
Kan

