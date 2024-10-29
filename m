Return-Path: <linux-kernel+bounces-387128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30749B4C50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D349B23295
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C5206E6D;
	Tue, 29 Oct 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6zvIOkI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA9206071;
	Tue, 29 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212834; cv=none; b=Jy4282BObZw3X+Yo7UFpNgo1xFVoDgx9F8ZHMinzqXmAF0hvCQTnLS6LGH68wSnGN8ft2bxqyDr+JSS3HRHl1OK8g/PFQSlMgKmaDgJ+W+8z60VQEzR81O3kvinImHI52Ki6iGzlgxqg86Cy4MGhJ5bqhYoiEGM3aAs2M8AlFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212834; c=relaxed/simple;
	bh=6KyHT+7ttw2brv7RoX9JFe5iSkFH7OpG7IZ9J2mXn9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgUX51RWz9OtaV04jRd/4Qq9kBgG3DEBvGlB8KAzLp+W/ZRB53e9pNXHL0kKICKD583H2w+ax5UTHQVAoz6eoBghQ+xqj4OO+3ynAbvcQXMuB2OKFctizVXzMn9FevjMfV1j5QLS4pK3+gYvtkMF/GAKtrhiWGEa6JtjD/v6nrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6zvIOkI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730212832; x=1761748832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6KyHT+7ttw2brv7RoX9JFe5iSkFH7OpG7IZ9J2mXn9U=;
  b=U6zvIOkIT7kET7yl7ydF2vEDBFjgj5UrYDWbg1DJZi5uuyTu+7tF9L7e
   gHP7fAZnOQLgcBmbDRhJhLXa9RxJ1L63BetVZ/PdRXgyNP2oELRak8hr/
   CqfATtvaW4X54/nFm0RwR7cIPdcIreCclQCCPM9t00GD7Pp7H0TMebApw
   tNdwBNGnW3mp1Vi+sLlhhE/gCqVyTzXEfndvCzyzWCud2ANhruV7l7/14
   +YDppA2Y2sH+Wvz5J9HLRU9jU2mVV+AqQEnMaVanoMpvtoqNlv72zr9eR
   gAuYoBY5vajysaC85cHXDPSDdr/Tbr6iGHijo7UZ5EKm/8kuYX/G61hTC
   A==;
X-CSE-ConnectionGUID: CP7gKtOXSNelicAFJhVHaw==
X-CSE-MsgGUID: TKQzNyvzQ42pF75PANiFyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="47335801"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="47335801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:40:31 -0700
X-CSE-ConnectionGUID: Rag48sEWQ8+dJ6ad7Z5JLQ==
X-CSE-MsgGUID: OP9r9foDRxyldqmGqe14Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="87114346"
Received: from jerrycli-mobl2.amr.corp.intel.com (HELO [10.125.224.112]) ([10.125.224.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:40:30 -0700
Message-ID: <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>
Date: Tue, 29 Oct 2024 07:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, hpa@zytor.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 04:37, Borislav Petkov wrote:
> On Mon, Oct 28, 2024 at 04:50:35PM -0700, Daniel Sneddon wrote:
>> @@ -599,20 +503,70 @@ static void __init verw_mitigations_check(void)
>>  	}
>>  }
>>  
>> -static void __init md_clear_select_mitigation(void)
>> +static bool __init verw_mitigations_disabled(void)
>>  {
>>  	verw_mitigations_check();
>> +	/*
>> +	 * TODO: Create a single mitigation variable that will allow for setting
> 
> A patch which introduces a TODO is basically telling me, it is not ready to go
> anywhere yet...
> 
>> +	 * the location of the mitigation, i.e.:
>> +	 *
>> +	 * kernel->user
>> +	 * kvm->guest
>> +	 * kvm->guest if device passthrough
>> +	 * kernel->idle
>> +	 */
>> +	return (mds_mitigation == MDS_MITIGATION_OFF &&
>> +		taa_mitigation == TAA_MITIGATION_OFF &&
>> +		mmio_mitigation == MMIO_MITIGATION_OFF &&
>> +		rfds_mitigation == RFDS_MITIGATION_OFF);
> 
> This should be used inside verw_mitigations_check() instead of repeated here,
> no?
> 
> Also, pls call verw_mitigations_check() "check_verw_mitigations" - the name
> should start with a verb.
> 
> Actually, you can merge verw_mitigations_check() and
> verw_mitigations_disabled(). Please do a *minimal* patch when cleaning this up
> - bugs.c is horrible. It should not get worse.
> 
I'll merge those two.

> What could also help is splitting this patch - it is hard to review as it
> is...
> 
Sure, I'll split this up as much as possible.
> Thx.
> 


