Return-Path: <linux-kernel+bounces-355572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E28995437
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DAD2868C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303F1DF964;
	Tue,  8 Oct 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPHL+Wfk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A76F2F3;
	Tue,  8 Oct 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404269; cv=none; b=VUbbr0Q+mEp7x9t7gkQZ1obc1BIHDIQM70sEWL4nCFgCaM5j/vN6xY+QpoXgBClsNw2zVL6lSYF8EWWS/eVhxKqCi1FbnHoz5SbuWHHww8FPb1payV/lPh5YLS0jdOpPkwIop1ckNUbT6jQxj+5dZ/1TSCQkWNUm8MbltIZfXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404269; c=relaxed/simple;
	bh=sR6JvFTxNGC3GiWb6Y6Qt0YBiKYIfxLCrL9a5v+HpdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv7tF+wxK2DhrSvs6Dq0jhfFp2fkhOhdkjfhOIgDf8T86sFUGCuzBkXx2cg/mgjp4rpbB871DAcbnahl8+ivsud3VhNP7EVzMFkahXJKJK35OpZVL4ZcnGYg8a2GsqFh/GjR8Vb2sWucfB9j6M/lurzdymD2qwq/OtoImBOyjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPHL+Wfk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728404267; x=1759940267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sR6JvFTxNGC3GiWb6Y6Qt0YBiKYIfxLCrL9a5v+HpdU=;
  b=kPHL+WfkvV9kLHj9y8yHbkdV9pxmtx//LgLi0RWYIaI2z1Vt7sIApR2n
   lzOA9zNjk0cbe0yCVEQaA9s5n8IUnEmRcJb03VUX4ViDkQDrZyNlwbeGz
   6d4jhyF8K2DnfN3P5BWdmr7L49dCvtCItQPkWF29U8c0/7zKEi4ljRDdt
   NwwUY40jCYQCvYpaRXWQNaBQ8Z+YTmgtIUExupm/8LZETZy07v2v0yPr7
   2F5u/EYT4iMlEYxH0NPcomMYO7AOVfLPhMG0Cg+RFMqiclSkEyAnflDfu
   9L5qsVFqsu9tm3uV2R+DRc6at0zjF4BAsMiWHFwa7FP/ZCUoM8l+Hj5RJ
   w==;
X-CSE-ConnectionGUID: Fk3vD3K2Siy8s3wmT88v9A==
X-CSE-MsgGUID: 9KVvViZPTfOtg8nhr/SX7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31319855"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="31319855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:17:47 -0700
X-CSE-ConnectionGUID: prEA0tJQTyyzchkjNIRhmw==
X-CSE-MsgGUID: 1RajqlD7SrGhHjU/qK4tTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="76249134"
Received: from ryizhaki-mobl.amr.corp.intel.com (HELO [10.125.160.131]) ([10.125.160.131])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:17:45 -0700
Message-ID: <b6d33fd0-cdee-4cfa-819f-3ad2b54867d6@linux.intel.com>
Date: Tue, 8 Oct 2024 09:17:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, hpa@zytor.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
 <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
 <20241007193726.m5mzkjjy4yscge6x@treble>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241007193726.m5mzkjjy4yscge6x@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 12:37, Josh Poimboeuf wrote:
> On Tue, Sep 24, 2024 at 03:31:40PM -0700, Daniel Sneddon wrote:
>> +static void __init md_clear_select_mitigation(void)
>> +{
>>  	/*
>> -	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
>> -	 * Stale Data mitigation, if necessary.
>> +	 * If no CPU bug needs VERW, all VERW mitigations are disabled, or all
>> +	 * mitigations are disabled we bail.
>>  	 */
> 
> It's already clear what the code is doing, no comment necessary.
> 
Will remove.
>> -	if (mds_mitigation == MDS_MITIGATION_OFF &&
>> -	    boot_cpu_has_bug(X86_BUG_MDS)) {
>> +	if (!cpu_bug_needs_verw() || verw_mitigations_disabled() ||
>> +	    cpu_mitigations_off()) {
>> +		mds_mitigation = MDS_MITIGATION_OFF;
>> +		taa_mitigation = TAA_MITIGATION_OFF;
>> +		mmio_mitigation = MMIO_MITIGATION_OFF;
>> +		rfds_mitigation = RFDS_MITIGATION_OFF;
>> +		goto out;
>> +	}
> 
> In the case of verw_mitigations_disabled() it's weird to write the
> variables again if they're already OFF.  That should be a separate
> check.
> 
Sure. I will separate them out.
>> +
>> +	/* Check that at least one mitigation is using the verw mitigaiton.
>> +	 * If the cpu doesn't have the correct ucode or if the BUG_* is mitigated
>> +	 * by disabling a feature we won't want to use verw. Ignore MMIO
>> +	 * for now since it depends on what the others choose.
>> +	 */
> 
> Again I think this comment isn't needed as the code is pretty
> straightforward.  The only surprise is the MMIO dependency on
> X86_FEATURE_CLEAR_CPU_BUF, but that's called out below.
> 
Will remove.
>> +
>> +	if (boot_cpu_has_bug(X86_BUG_MDS)) {
>>  		mds_mitigation = MDS_MITIGATION_FULL;
>>  		mds_select_mitigation();
>> +	}  else {
>> +		mds_mitigation = MDS_MITIGATION_OFF;
>>  	}
>> -	if (taa_mitigation == TAA_MITIGATION_OFF &&
>> -	    boot_cpu_has_bug(X86_BUG_TAA)) {
>> +	if (boot_cpu_has_bug(X86_BUG_TAA)) {
>>  		taa_mitigation = TAA_MITIGATION_VERW;
>>  		taa_select_mitigation();
>> +	} else {
>> +		taa_mitigation = TAA_MITIGATION_OFF;
>>  	}
>> -	/*
>> -	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
>> -	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
>> -	 */
>> +	if (boot_cpu_has_bug(X86_BUG_RFDS)) {
>> +		rfds_mitigation = RFDS_MITIGATION_VERW;
>> +		rfds_select_mitigation();
>> +	} else {
>> +		rfds_mitigation = RFDS_MITIGATION_OFF;
>> +	}
> 
> This spaghetti can be simplifed by relying on *_select_mitigation() to
> set the mitigation, for example:
> 
> static void __init mds_select_mitigation(void)
> {
> 	if (!boot_cpu_has_bug(X86_BUG_MDS))
> 		mds_mitigation = MDS_MITIGATION_OFF;
> 	else if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
> 		mds_mitigation = MDS_MITIGATION_VERW;
> 	else
> 		mds_mitigation = MDS_MITIGATION_VMWERV;
> }
> 
> Then you can just do:
> 
> 	mds_select_mitigation();
> 	taa_select_mitigation();
> 	rfds_select_mitigation();
> 
> 
You're right. That is much cleaner. Will fix.
>> +	if (mds_mitigation == MDS_MITIGATION_FULL ||
>> +	    taa_mitigation == TAA_MITIGATION_VERW ||
>> +	    rfds_mitigation == RFDS_MITIGATION_VERW)
> 
> For consistency can we rename MDS_MITIGATION_FULL to
> MDS_MITIGATION_VERW?
> 
Will do!
>> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
>> +
>> +	/* Now handle MMIO since it may not use X86_FEATURE_CLEAR_CPU_BUF */
> 
> I would clarify this a bit, something like:
> 
> 	/*
> 	 * The MMIO mitigation has a dependency on
> 	 * X86_FEATURE_CLEAR_CPU_BUF so this must be called after it
> 	 * gets set.
> 	 */
> 
Will update.
>>  	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
>>  		mmio_mitigation = MMIO_MITIGATION_VERW;
>>  		mmio_select_mitigation();
>> +	} else {
>> +		mmio_mitigation = MMIO_MITIGATION_OFF;
>>  	}
>> -	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
>> -	    boot_cpu_has_bug(X86_BUG_RFDS)) {
>> -		rfds_mitigation = RFDS_MITIGATION_VERW;
>> -		rfds_select_mitigation();
>> -	}
>> +
>> +	/* handle nosmt */
> 
> Again I think this comment is superfluous.
> 
Will remove.
>> +	if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
>> +	    (mds_nosmt || cpu_mitigations_auto_nosmt()))
>> +		cpu_smt_disable(false);
>> +
>> +	if (taa_nosmt || mmio_nosmt || cpu_mitigations_auto_nosmt())
>> +		cpu_smt_disable(false);
>> +
> 

Thanks for the review!


