Return-Path: <linux-kernel+bounces-333697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD6C97CC83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53F928585B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3619F49C;
	Thu, 19 Sep 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2iyrOjR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836717555
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763310; cv=none; b=CPwepc1TfS0a680JkIfV/rD6kxJl9awXK7FOtLtgVZY46Ef4TKaEraUBuPlK9CqbZz5Hk7QJivtXDD56NFFppPpi29/FmlJ5bsOsvpxgo/fRBkUgQNPbgWoMUeicPdIIilMYK8cl/FSu6HL32LwtcPErmx+YwbbRRVRebrQOksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763310; c=relaxed/simple;
	bh=LJ7iK8ADo86ctNh+Yh+kU1v4dp7QdpUeqsCkKq261iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjvrHhdHSarpJBvcS1jMYW9BAP0Xbkh/BmHCMz4ZwNB/66UGPMyqEmySPpmm3Zi+Rm7s02QqOR1sJWpyOTqw+fV3LhuByF+wXB64FUMvMMbz9coFiRd1dbK9KJyYmbSAcz7Pwp1TPVgOyA8v2Sc84xZmS6sr7gVN77Di7LGHT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2iyrOjR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726763308; x=1758299308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJ7iK8ADo86ctNh+Yh+kU1v4dp7QdpUeqsCkKq261iM=;
  b=H2iyrOjR/bOX9AdIOTzrkaMcyX2P+XCZaBZKC8lFlOUA/T8bFkj0rB5h
   GszjBzniIUs2gW1ENsAbTA/s7Hm3cCh//uFTSEOXkGVSnKOuMn1HXjWbO
   B72Qock+hijjV05EHTzVfPLnqOgjWAiji4cKzJUCOCbmimeSlolMlwqsb
   D/V8BJK+IiqBGrso6hOmUo2s2YN2sCb2K8ZkAf/3J2CdwV5caYo5TWYRv
   xI/4pXeP49kzidZADVks6OeXd/++9A8H+rG03Lco3VkMP4VA3FZkQDBlJ
   EnM5B3adNYLGKS9S28z2s0XamuHj++R1OjLMbzPJjgjuRe1KCRnjfkSAu
   Q==;
X-CSE-ConnectionGUID: NMzDWPIIQK65D6EEE7IsBg==
X-CSE-MsgGUID: N4k8Z3bSQICtdGLTpsApAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36871523"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36871523"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:28:27 -0700
X-CSE-ConnectionGUID: eVFXiZCDTkWCPbmYpe8dVA==
X-CSE-MsgGUID: eP4k8HPXTROkcqFYDlhEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100722493"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:28:26 -0700
Received: from [10.212.121.54] (kliang2-mobl1.ccr.corp.intel.com [10.212.121.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9BCB320CFEE7;
	Thu, 19 Sep 2024 09:28:25 -0700 (PDT)
Message-ID: <a7906f41-f3b4-480d-a89a-587bf4c7b989@linux.intel.com>
Date: Thu, 19 Sep 2024 12:28:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
To: Guenter Roeck <linux@roeck-us.net>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-2-kan.liang@linux.intel.com>
 <dacb08c6-dc38-4292-93cd-12cdfba3972f@roeck-us.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <dacb08c6-dc38-4292-93cd-12cdfba3972f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-19 11:43 a.m., Guenter Roeck wrote:
> On Fri, Aug 02, 2024 at 08:16:37AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf subsystem assumes that the counters of a PMU are per-CPU. So
>> the user space tool reads a counter from each CPU in the system wide
>> mode. However, many PMUs don't have a per-CPU counter. The counter is
>> effective for a scope, e.g., a die or a socket. To address this, a
>> cpumask is exposed by the kernel driver to restrict to one CPU to stand
>> for a specific scope. In case the given CPU is removed,
>> the hotplug support has to be implemented for each such driver.
>>
>> The codes to support the cpumask and hotplug are very similar.
>> - Expose a cpumask into sysfs
>> - Pickup another CPU in the same scope if the given CPU is removed.
>> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
>> - In event init, always set the CPU in the cpumask to event->cpu
>>
>> Similar duplicated codes are implemented for each such PMU driver. It
>> would be good to introduce a generic infrastructure to avoid such
>> duplication.
>>
>> 5 popular scopes are implemented here, core, die, cluster, pkg, and
>> the system-wide. The scope can be set when a PMU is registered. If so, a
>> "cpumask" is automatically exposed for the PMU.
>>
>> The "cpumask" is from the perf_online_<scope>_mask, which is to track
>> the active CPU for each scope. They are set when the first CPU of the
>> scope is online via the generic perf hotplug support. When a
>> corresponding CPU is removed, the perf_online_<scope>_mask is updated
>> accordingly and the PMU will be moved to a new CPU from the same scope
>> if possible.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> This patch results in build failures in the mainline kernel.
> 
> Building arm:allmodconfig ... failed
> Building arm64:allmodconfig ... failed
> Building loongarch:allmodconfig ... failed
> Building mips:allmodconfig ... failed
> Building parisc:allmodconfig ... failed
> 
> [ and more ]
> 
> --------------
> Error log:
> kernel/events/core.c: In function 'perf_event_setup_cpumask':
> kernel/events/core.c:14012:13: error: the comparison will always evaluate as 'true' for the address of 'thread_sibling' will never be NULL
> 

The patch has been posted, but haven't been merged yet.

https://lore.kernel.org/lkml/20240912145025.1574448-1-kan.liang@linux.intel.com/

Thanks,
Kan


