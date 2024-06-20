Return-Path: <linux-kernel+bounces-222972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE1910AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127E6B23F23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E76A1AB8E0;
	Thu, 20 Jun 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF2308+3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D011ACE89
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899377; cv=none; b=BQFDogv5w6DV6ZoGiuHBapA4wQMBWV62iv+Vd7fqvVPXbZxzQR62M/R4h3DiDJjEvwJUWPO13CfRn/phgp82Adr0DQ2g9FVetfxsUaeySOYICMn4OV8hk0PNPQNxvt00aTzqjfsi2xBATcCWB+izj9sdtGybof5b5U/NCB+NGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899377; c=relaxed/simple;
	bh=ZqpKVw/sQZa6KKcNHbrfifDQgxd9CfYmJ9vfGPOTfbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6BNidrTCB7mejO6DsevuixpDmV2nhXe0RX/zXotEzbvODuHD1+HN9LRkdlnBE2zBwJYzJ4ndK/1jN2y0Dc+0prVXc1M8MtXSjluMtJDJDbse+0ZhIzrRrlWl9uWB0GsEdkM4iChfzGvie35cw1ggLQGgea0hcGORJfzciuOOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF2308+3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718899376; x=1750435376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZqpKVw/sQZa6KKcNHbrfifDQgxd9CfYmJ9vfGPOTfbg=;
  b=TF2308+3/pGGEgY/w0t5EKjhLqqTV2UiGu4C7HDyXQgY0GnzhpwtrfEg
   XZlTF/v3QZI9W9mYUo5qRIY2hTwgKxJPlQs9WnokXRsHaEaEN6otdPvwZ
   1AuM462A4Yl2lsw5RAh8AOlmkfqRbMgdWKK0aTDOEOEMIfDNiJiAq4Gy2
   he2o6W4496878LkOBWqru6o8bU0dUaC+8uC3gbjgmwGj8SuK8ZtEBE3kX
   k6/761682FURj04gNvtt2eIQGf/mGYog+3HFxRlFrLWjDwshtgLk1mpx0
   KCD2xhE0WevaSlsYWwHrTgO3hXw0Q7VGOCHMuJLTX2+gchGG9fqr/bi6J
   Q==;
X-CSE-ConnectionGUID: hoY7LUWmQMK7fjbi4FQzmQ==
X-CSE-MsgGUID: 4Oxk4rxaS2GvtDj0UyaJxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19766600"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19766600"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:02:08 -0700
X-CSE-ConnectionGUID: 6+E5ddO1TQO3GDNjfY9Fuw==
X-CSE-MsgGUID: I5XvbcdwQpy4VMYcNo7dZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="73028851"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:02:09 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8149020B5703;
	Thu, 20 Jun 2024 09:02:06 -0700 (PDT)
Message-ID: <95829e55-adb3-499e-9285-34a47839e2da@linux.intel.com>
Date: Thu, 20 Jun 2024 12:02:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 02/12] perf/x86: Support counter mask
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, silviazhao
 <silviazhao-oc@zhaoxin.com>, CodyYao-oc <CodyYao-oc@zhaoxin.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-3-kan.liang@linux.intel.com>
 <20240620070649.GQ31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620070649.GQ31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 3:06 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:34AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +	for_each_set_bit(idx, c->idxmsk, x86_pmu_num_counters(NULL)) {
>>  		if (new == -1 || hwc->idx == idx)
>>  			/* assign free slot, prefer hwc->idx */
>>  			old = cmpxchg(nb->owners + idx, NULL, event);
> 
>> +static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
>> +{
>> +	return hweight64(hybrid(pmu, fixed_cntr_mask64));
>> +}
> 
> 
> This is wrong. You don't iterate a bitmask by the number of bits set,
> but by the highest set bit in the mask.

It seems we need two functions for the number.
For the above iterate case, yes, we need the highest set bit to tell the
possible max number.

There could be other cases as below. An exact number of available
counters are required.

-void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
-                         u64 intel_ctrl)
+void x86_pmu_show_pmu_cap(struct pmu *pmu)
 {
        pr_info("... version:                %d\n",     x86_pmu.version);
        pr_info("... bit width:              %d\n",
x86_pmu.cntval_bits);
-       pr_info("... generic registers:      %d\n",     num_counters);
+       pr_info("... generic registers:      %d\n",
x86_pmu_num_counters(pmu));
I will add two functions,  x86_pmu_max_num_counters() and
x86_pmu_num_counters().

Thanks,
Kan


