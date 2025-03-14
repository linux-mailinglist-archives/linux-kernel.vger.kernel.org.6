Return-Path: <linux-kernel+bounces-561457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A4A611FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5CD1B62B43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF381F130E;
	Fri, 14 Mar 2025 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZkl0rIf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11682E3398
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957573; cv=none; b=GhgQ+iG6bBrHV8MyuRMROL6HfIwG9fzhD/6Ss422TqGlyHVunOO5R5eOvZ6R5ic6lkXcYeqn2uQdK6CqdKlkAUKhFoKjqy5PLAfGBfRBkZEmutvCUJmhg09SRojO2XJLsoay9vM++rSIpeQ2dkkzN+dxxW/bV6rZt+Z/jvcj7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957573; c=relaxed/simple;
	bh=5ykfQotWkvLY3QAFu6nKaTw+qHt85KWptUeqV8O95+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMd8EsPJVJ6SHo2E2QLWeC/vFF97HvZDPU6vaXQXD/Rkudai61zkV9aXSW9k3FdKtKgJXKX+wDz90oozyL6AllP30Rv2QgHZpzDFbsMxpVgKhzGy5mTrc+L5kA7VxSIe8nG1l9j4meaDCeIQ5TqhzT+iqlDmGICN2o88QuH7fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZkl0rIf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741957572; x=1773493572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ykfQotWkvLY3QAFu6nKaTw+qHt85KWptUeqV8O95+Q=;
  b=WZkl0rIfoPkjdRVFq8tRtL8bVoMWmieqJAdicnSwRS4ZSgEOTrNf22br
   1I22sekF93PD6GXBcXyfBgqM8/7hEF5of/jNsnBAfuItgryzToGXYYcP+
   ML514JX/uZ4Vq3WduwD1PrBuDEFFweQk2I1Wfd2QHYwyJ1wci+NNyFSLD
   +CartfXxfkwBKSL7Z8tbprAeLQNds+jBCfYemAtUZ7f1sERQgqDJbF/fD
   rU5ZY2psZfBE5geDS82sHh8+/HkL8W2GaJayouN7ZsBn4AvGtRoTVzQ/I
   i6WCJELjCQ5iMPzwnaKKALxQhU4sjYXS1PQDLhkBhA9+DQC1mj57nXYPE
   Q==;
X-CSE-ConnectionGUID: R1IcS2ZxTuK89kVbsAbeSQ==
X-CSE-MsgGUID: X/RBbJhkSjCP/NzPga8ZXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53761963"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53761963"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:06:11 -0700
X-CSE-ConnectionGUID: buFAKAfyS5GFxeujkPvRXA==
X-CSE-MsgGUID: ZNf8xV09RYyoCcFw6IrnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121778146"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:06:12 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 89FA220B5736;
	Fri, 14 Mar 2025 06:06:09 -0700 (PDT)
Message-ID: <108c7d02-257c-4131-a7f0-f9cb34ed3f5c@linux.intel.com>
Date: Fri, 14 Mar 2025 09:06:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] Support auto counter reload
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
 linux-kernel@vger.kernel.org, eranian@google.com, thomas.falcon@intel.com
References: <20241010192844.1006990-1-kan.liang@linux.intel.com>
 <Z9P8EDcGv0m__WiN@gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z9P8EDcGv0m__WiN@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-14 5:51 a.m., Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V1:
>> - Add a check to the reload value which cannot exceeds the max period
>> - Avoid invoking intel_pmu_enable_acr() for the perf metrics event.
>> - Update comments explain to case which the event->attr.config2 exceeds
>>   the group size
> 
>> The 2498 samples are all from the branch-misses events for the Loop 2.
>>
>> The number of samples and overhead is significantly reduced without
>> losing any information.
> 
> Ok, that looks like a pretty sweet PMU feature.
> 

Thanks for the review.

> What is the hardware support range of this auto count reload feature, 
> how recent CPU does one have to have?

The feature was first introduced into the Sierra Forest server, which
was launched last year.
https://en.wikipedia.org/wiki/Sierra_Forest

All the future platforms should have it support as well.

> 
> The series has aged a bit though, while a variant of patch #1 has been 
> merged already under:
> 
>   47a973fd7563 perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
> 
> ... but #2 and #3 don't apply cleanly anymore.
> 
> Mind sending a refreshed series perhaps?

No problem.

I saw Peter just gives several feedback. I will also address the
concerns in the new series.

Thanks,
Kan



