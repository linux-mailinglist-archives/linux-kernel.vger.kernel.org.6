Return-Path: <linux-kernel+bounces-561526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323AA6130C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D9046366F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1012FF6F;
	Fri, 14 Mar 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne4sEdH0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850F2E336A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960241; cv=none; b=u5WhZcHp86ifiHJ8gufbv3cdzL3PBjIu20RzmtqyoqP937EUeOE2oeDttneCF0a7tETZpTi0AF2oBNqE8DubtjNqKtBsGqh0TVfY9ZjHxWgBqymDL/Pebk0Oajd4rRCzw4u6A8G6ZJ4hg6bjc1Ve49JWmnqNC2V+2494AC6c3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960241; c=relaxed/simple;
	bh=CadWzEzLipP3Dn2Gd1WWq6mVZcm6prMC67CNjWw9txs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUTrq3LaTm+7uWnaor1WPuXKuRl4KG7Jz2K+/63bvAd3gSaGdfO5sMCLBCOc2qxCEteHF0hYUv86JGXyh1MBNK/Eh1tR4oVIlPj1XQ4Q9T9lxds23TO6oeg0D1ArRCyXPG0d80oQUzKtTNgj2vZHpLRAaFawrZLf2YpOfYoKHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne4sEdH0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741960240; x=1773496240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CadWzEzLipP3Dn2Gd1WWq6mVZcm6prMC67CNjWw9txs=;
  b=ne4sEdH0kT2xUYWzMhg9dZIf0gZw38wORbUGiIbtbPaE6cRtLf4wfqzy
   8m66DFt+Ehom76ilYGQ9FgtUHgcDpLQohEnE9Wllz+WpPfhvLSQdwlF/C
   1Rob0i9VlFljzvWAf/zm4kylV106yQSlxLdIzeVeEZwC3nkgiBPhfUZsS
   Gb9jmMjMw+4WIhG3SGGpBftsX+XnFaU27YTCPrIqlbsm6o/OWi/PUzCCs
   ka1XbkraCAUuV5cdiJ4IPaHN3aYk3kqzQ3gnt7jsQ0INvrGzGQLJXCB6X
   NtkDzDvO9Nq95KTRqyRdRR7w0j21iXpuexyxBUGt5eQwizN7JF1efVoxN
   g==;
X-CSE-ConnectionGUID: Qtr5bNVAQP+spekhiRTlZA==
X-CSE-MsgGUID: Jbn3ZSaHTmW+6ZaB/6Tn4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43240796"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43240796"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:50:39 -0700
X-CSE-ConnectionGUID: 6hFO89U6SsSpKY8ThD1Fsw==
X-CSE-MsgGUID: fEzCYgU4TuqOm/0uy7EQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126500452"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:50:39 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B2CD320B5736;
	Fri, 14 Mar 2025 06:50:37 -0700 (PDT)
Message-ID: <a619615f-3313-4e55-a780-f280fbb643dc@linux.intel.com>
Date: Fri, 14 Mar 2025 09:50:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/7] perf: attach/detach PMU specific data
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
 <20250314000242.323199-3-kan.liang@linux.intel.com>
 <20250314125958.GC36322@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250314125958.GC36322@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-14 8:59 a.m., Peter Zijlstra wrote:
> On Thu, Mar 13, 2025 at 05:02:38PM -0700, kan.liang@linux.intel.com wrote:
> 
>> @@ -12551,6 +12813,14 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>  	if (err)
>>  		return ERR_PTR(err);
>>  
>> +	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
>> +		err = attach_perf_ctx_data(event);
>> +		if (err) {
>> +			security_perf_event_free(event);
>> +			return ERR_PTR(err);
>> +		}
>> +	}
>> +
>>  	/* symmetric to unaccount_event() in _free_event() */
>>  	account_event(event);
>>  
> 
> This seems weird. We just pushed all the error handling into
> __free_event(), and now you're adding one special case back.
> 
> Also, you've placed it after security_perf_event_alloc(), which I
> _think_ wants to be last.

Right, I will send a new series to fix it.

Thanks,
Kan

