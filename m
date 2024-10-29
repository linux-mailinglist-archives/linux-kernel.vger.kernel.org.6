Return-Path: <linux-kernel+bounces-387319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD09B4F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4303E1F227A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7D1D5CD6;
	Tue, 29 Oct 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ7Wac5e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A0198A19;
	Tue, 29 Oct 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219704; cv=none; b=MplGxv/2IPdNYGF/3kr/832qLDy14pjvlYpeMYt2vyf4Hflof5oqOqb8/mHcUJNZH1jcXchr3ljYOQtzebz/3BDQL+4M7pwq3Ix7d/15rPaVXKsLCkNWzwX+Mlc8dQix3jS5bHJnl9pYYQSEi4hxzNycRYsX0O+qNdC/4s3YRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219704; c=relaxed/simple;
	bh=0kPRdVaBnlSkEYEdzX5ydl9lntCUi+JXSR0mA62Hn98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4L80TLG1dE8fVjBKwWEoZo7YYcPGLbf3rOiwku2aRpcP0ARszFRolac67uDJetoZCrXio7fga30AhzXBGRK1XlCcnLHJYZPWVUV6IJzW18BLZGrHilCZiL5aSG+AOZ8+yoqPTSGt/qmqUCbF7YAjre+Kr+svrU09dhYtr0NKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJ7Wac5e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730219702; x=1761755702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0kPRdVaBnlSkEYEdzX5ydl9lntCUi+JXSR0mA62Hn98=;
  b=PJ7Wac5ePmZw5i/JnpugEiDR7LtUBr55DABF7HX1k0s3vpGJvq2965qJ
   1P6yHzl4iWJjJtyA8V0cnzr0/gzwfBT5i7bfvQb5rG9uAXsvBj5/eam62
   X3Kt2CW3wV0UpGPJ4mjNDUvRNXqAEK+vhXjFpMFY8TjwzhF+JWKh1kNI2
   H5/H6XRmm2G3+y/hVWmst4Bq3Eox4gF/pOLqwuGN6Qg3LOPVjtl4TvRhK
   SrWRVGuIO6IRd6I2CUuLYP6wr1xNxs/wAM2oH41xpJVU66AoIRoriTTw0
   BCAgv4KlhggwI4Xy1txCfd+yOf++OYBUawqLFKtxmT1PjlpwLYfBDaRgU
   g==;
X-CSE-ConnectionGUID: Mf++VcBzQ8S8vT5IFpKQxg==
X-CSE-MsgGUID: 2AQV5gXAQTmBVtCZqIbq5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33669689"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33669689"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:35:01 -0700
X-CSE-ConnectionGUID: x3v5ZdEwQue2n/moDWY77A==
X-CSE-MsgGUID: ulBzQPt4SLaRYDn4OrHebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81949200"
Received: from jerrycli-mobl2.amr.corp.intel.com (HELO [10.125.224.112]) ([10.125.224.112])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:35:00 -0700
Message-ID: <01b20580-9dd7-460b-aab1-86ad153fb3a7@linux.intel.com>
Date: Tue, 29 Oct 2024 09:34:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/bugs: Check VERW mitigations for consistency
To: Nikolay Borisov <nik.borisov@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: hpa@zytor.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <3ed45a10e2f7fbecce31d9964b1da1372e8cb838.1730158506.git.daniel.sneddon@linux.intel.com>
 <35c07733-d9e4-43a3-9dde-2cc10cd1ab9f@suse.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <35c07733-d9e4-43a3-9dde-2cc10cd1ab9f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/24 09:32, Nikolay Borisov wrote:
> 
> 
> On 29.10.24 г. 1:50 ч., Daniel Sneddon wrote:
>> There are currently 4 mitigations that use VERW: MDS, TAA,
>> MMIO Stale Data, and Register File Data Sampling. Because
>> all 4 use the same mitigation path, if any one of them is
>> enabled, they're all enabled. Normally, this is what is
>> wanted. However, if a user wants to disable the mitigation,
>> this can cause problems. If the user misses disabling even
>> one of these mitigations, then none of them will be
>> disabled. This can cause confusion as the user expects to
>> regain the performance lost to the mitigation but isn't
>> seeing any improvement. Since there are already 4 knobs for
>> controlling it, adding a 5th knob that controls all 4
>> mitigations together would just overcomplicate things.
>> Instead, let the user know their mitigations are out of sync
>> when at least one of these mitigations is disabled but not
>> all 4.
>>
>> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>> ---
>>   arch/x86/kernel/cpu/bugs.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index d1915427b4ff..b26b3b554330 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -582,8 +582,26 @@ static void __init md_clear_update_mitigation(void)
>>   		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
>>   }
>>   
>> +static void __init verw_mitigations_check(void)
>> +{
>> +	if (mds_mitigation == MDS_MITIGATION_OFF ||
>> +	    taa_mitigation == TAA_MITIGATION_OFF ||
>> +	    mmio_mitigation == MMIO_MITIGATION_OFF ||
>> +	    rfds_mitigation == RFDS_MITIGATION_OFF) {
>> +		if (mds_mitigation == MDS_MITIGATION_OFF &&
>> +		    taa_mitigation == TAA_MITIGATION_OFF &&
>> +		    mmio_mitigation == MMIO_MITIGATION_OFF &&
>> +		    rfds_mitigation == RFDS_MITIGATION_OFF)
>> +			return;
> 
> Ugh, why don't you simply XOR the 4 values and if it's 1 it means the 
> inputs differe => there is inconsistency.
> 
That's certainly cleaner. Will update.

Thx
>> +
>> +		pr_info("MDS, TAA, MMIO Stale Data, and Register File Data Sampling all depend on VERW\n");
>> +		pr_info("In order to disable any one of them please ensure all 4 are disabled.\n");
>> +	}
>> +}
>> +
>>   static void __init md_clear_select_mitigation(void)
>>   {
>> +	verw_mitigations_check();
>>   	mds_select_mitigation();
>>   	taa_select_mitigation();
>>   	mmio_select_mitigation();


