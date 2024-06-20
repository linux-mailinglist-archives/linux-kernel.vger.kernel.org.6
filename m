Return-Path: <linux-kernel+bounces-223023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B48C910BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AE028820B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9F1B29BD;
	Thu, 20 Jun 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="angWdemX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD131AC76D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900341; cv=none; b=BqAoFJppfWqBbdQ0VSY0bSeYFLLTJvhAKfYoHwBZfWwcxqNT3CMZFjwGG/obU6dWIYF19HdttzCKidrZjJNjrPOqooA8aRoGdPTS1oCnIQw8Il/Wc1Nhd4Y/7KncWD39EZREJWduqXSTp+1adbVj2OxgYxDaPyTHpIgKFRtDcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900341; c=relaxed/simple;
	bh=JtrK2Rv/djL9B2SivfQcXSQNBAlAXZsyY+YJmbs6iIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZ//NoV0WByubfpMu4qI17mKMf5uRRWjbcECUXiZISttcgHxm+dPn3/9hscNg9pZWgO6EquS7rm4VWg93lsYwlnItMv6/0CYY1hbmP6h5ey+LJ6KV+BEC7MJ1zVn+X0PIcep2rYkDgFXoI+3SYVOLa/cZx7pgkzTXEPH08bSEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=angWdemX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718900339; x=1750436339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JtrK2Rv/djL9B2SivfQcXSQNBAlAXZsyY+YJmbs6iIo=;
  b=angWdemXU08K7lF2dfgzhrhhhzJADuuZTe5fWwZokeFGPJTuAIMO2qe3
   ofRsCYYk/zE/s25NBpS7e+dFom2Mb9WmxYG33N3QlZcDL2YlLSp/FugaQ
   XMR4nn0dClPtqEjapL6hqcH1YrrdteoPXULxUhQ4pHqYbHxJNiPeCdwfh
   jQDpu1dNjOId7chEcFOSfQ8OOnW+WEj8NH4huOhfKktoBoebtSC4+2Pev
   D51IN4Fj+hsSUw5wrtRJjomTGpQFNq0YS3zUKX0MvWVLAIhxMJN1RfcNn
   V2AQYlMhAqzutDVD7Qs0jHQN7sumHJQGs6jyqRK9ToilFqyvxPU5fK+Gk
   A==;
X-CSE-ConnectionGUID: +Dhm900RQ8ekvBJJ1tT2TQ==
X-CSE-MsgGUID: bD4ym05NSEqMVLnKkHvw4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="16126710"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="16126710"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:18:58 -0700
X-CSE-ConnectionGUID: BorlomISRMC1VIumo9fjJg==
X-CSE-MsgGUID: j/pmHWjuTtSAk4aLTWs+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="73501621"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:18:58 -0700
Received: from [10.212.43.222] (kliang2-mobl1.ccr.corp.intel.com [10.212.43.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 30D0620B5705;
	Thu, 20 Jun 2024 09:18:56 -0700 (PDT)
Message-ID: <22c4b8dd-b4af-4a2f-ac36-61532cf726d9@linux.intel.com>
Date: Thu, 20 Jun 2024 12:18:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 08/12] perf/x86: Extend event update interface
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
 ak@linux.intel.com, eranian@google.com, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, silviazhao
 <silviazhao-oc@zhaoxin.com>, CodyYao-oc <CodyYao-oc@zhaoxin.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-9-kan.liang@linux.intel.com>
 <20240620083810.GU31592@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240620083810.GU31592@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 4:38 a.m., Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 08:10:40AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The current event update interface directly reads the values from the
>> counter, but the values may not be the accurate ones users require. For
>> example, the sample read feature wants the counter value of the member
>> events when the leader event is overflow. But with the current
>> implementation, the read (event update) actually happens in the NMI
>> handler. There may be a small gap between the overflow and the NMI
>> handler. The new Intel PEBS counters snapshotting feature can provide
>> the accurate counter value in the overflow. The event update interface
>> has to be updated to apply the given accurate values.
>>
>> Pass the accurate values via the event update interface. If the value is
>> not available, still directly read the counter.
>>
>> For some cases, e.g., intel_update_topdown_event, there could be more
>> than one counter/register are read. Using u64 * rather than u64 as the
>> new parameter.
> 
> The stronger argument is that there is no special value to distinguish
> between there begin an argument and there not being one. You cannot have
> !val, because 0 might be a valid rdpmc() value.

Indeed. I will update the description.

Thanks,
Kan


