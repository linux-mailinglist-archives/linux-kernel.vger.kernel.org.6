Return-Path: <linux-kernel+bounces-173739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907128C04C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD6F1C218C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9B130A4C;
	Wed,  8 May 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irIf9ad4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94012FF99;
	Wed,  8 May 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195466; cv=none; b=nY3sIWo4u172zY1qv9qWzeLoBOalZ3xDOBvfVG1yFY2HI2miWtSG4mWez7pjyjhrZ+mQflxH2BR0CjN22SMXWI41vEe4b2o+nbvUcR2KPCEi032ZCPTdTH5p/Mf6UVnbpscQ2ud7gHqWfAb0eqCAoK3Z1DgKTDudxvp+PIdGEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195466; c=relaxed/simple;
	bh=m1n0jtqGHpl+7n0zR7w9meeDsaQ2zN0GFOpoSCTAVvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4OQtFcVKsbRc5TN9Mc/dL/uk3jwO6KeACKHPvFlSCT9+tYtRhiLSZ/mxEdbMX2hGCUjLfTrWHYBGbzOWrJA6n+yr4afZkAGnYiSEZWhV+9WYMOSoq39lvh4nIovmQ+24wNBNC9v4uAHw1S3SIg8xCaEQ96+8upeNbZt9zXzGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irIf9ad4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715195464; x=1746731464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m1n0jtqGHpl+7n0zR7w9meeDsaQ2zN0GFOpoSCTAVvM=;
  b=irIf9ad4cJKt2IJy2mAmQzmqX0aVHmG3/LoVz1ZTr3NasiyWVSLJNbuK
   xYdBsq9s3te4pXB62j5ad1Kub4163xwd7dVYQh/Bg1jsaJ9bEbK/tw9Fe
   x3gm1fFCKW1l1/d9MarRnosS54Kj0oncLv/fosXXR1KgrUcHwsYdRMsyJ
   J2xq4Eaov/Y3yp2fpilIY5e3vbAtYKVJvJix+Ri80+dbRM5fqqLcIH3Yn
   7w6VsvfZMfi2MAKcE0PdXyN50n8lw5zZTPGVqRcE3WdieoS4q9LrPcHfj
   MZnA+xMp7rQOZskc3jnDPRrRTA8NWPbSUCQjiUmMVOh9PLm44PKsrfW6e
   w==;
X-CSE-ConnectionGUID: p+s+ePTaR5WxnDdck5O9ow==
X-CSE-MsgGUID: UZsszesuT5yK/PzD2bHNNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22233150"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22233150"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 12:11:04 -0700
X-CSE-ConnectionGUID: 4inLX1JoQFmiNEFYGmh/ZA==
X-CSE-MsgGUID: RBqNOAzrRvGVklrLpd7KvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33460708"
Received: from hemanthr-mobl.amr.corp.intel.com (HELO [10.209.17.69]) ([10.209.17.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 12:11:03 -0700
Message-ID: <29e54919-edff-41ba-a3d0-d400e36fa6b9@intel.com>
Date: Wed, 8 May 2024 12:11:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 ashok.raj@intel.com, jithu.joseph@intel.com
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
 <62e2ebd9-4afa-4bb1-a30c-5ba34bc6b94e@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <62e2ebd9-4afa-4bb1-a30c-5ba34bc6b94e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/24 11:03, Chang S. Bae wrote:
> On 5/8/2024 7:40 AM, Dave Hansen wrote:
>> On 5/7/24 16:53, Chang S. Bae wrote:
>>
>>> However, due to resource constraints in storage, AMX state is excluded
>>> from the scope of state recovery. Consequently, AMX state must be in its
>>> initialized state for the IFS test to run.
>>
>> This doesn't mention how this issue got introduced.  Are we all bad at
>> reading the SDM? :)
> 
> Ah, I'd rather zap out this SDM sentence.

My point is that this is fixing a bug.  Where did that bug come from?
What got screwed up here?

Hint: I don't think us software folks screwed up here.  It was likely
the folks that built the two hardware features (AMX and IFS) forgot to
talk to each other, or someone forgot to document the AMX clobbering
aspect of the architecture.

>>> When AMX workloads are running, an active user AMX state remains even
>>> after a context switch, optimizing to reduce the state reload cost. In
>>> such cases, the test cannot proceed if it is scheduled.
>>
>> This is a bit out of the blue.  What does scheduling have do do with IFS?
..
> So, the CPU stopper threads for <cpu#> and its sibling to execute
> doscan() are queued up with the highest priority.
..

But this is the IFS implementation *today*.  The explanation depends on
IFS being implemented with something that context switches.  It also
depends on folks expecting context switches to always switch FPU state.

I'd just say:

	The kernel generally runs with live user FPU state, including
	AMX. That state can prevent IFS tests from running.

That's _much_ more simple, generic and also fully explains the
situation.  It also isn't dependent on the IFS stop_cpus_run()
implementation of today, which could totally change tomorrow.

The underlying rule has zero to do with scheduling or context switching
optimizations.

