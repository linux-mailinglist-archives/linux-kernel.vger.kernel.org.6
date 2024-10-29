Return-Path: <linux-kernel+bounces-387334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAD9B4F99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977161F2350B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C019DF95;
	Tue, 29 Oct 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz3t6dTd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4218FC9D;
	Tue, 29 Oct 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219988; cv=none; b=OISdJElnxbk7+JaHNqlJfgdu6/2ug9kQjl1DACXc2hRRtohA+uF7ADj2jnTottXrB8qFdBgHCEfo0qP/Dn40WIHZML8WhkvJTA60AeP2YF+k2RSrsyxL1PYBoSUvqSEdJGK0yzb6Mqk3neV32o6d9l0tHS4nqG6mDV2e3lKSHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219988; c=relaxed/simple;
	bh=6I/kfLLxGDLdpTR0HeTd60odPvrBlqC94SDfCXBwCqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhQEMaA0nXHoKz0FN0+yzfTwPLyv8zRT+kJwF5Rb/rX6KlMKx9ktXInrUazfXtFxsxyYrL5MAabiD5VvWgvt1bj8mo9PMFMyfyW6mJ1P4o5CPfWQgBaniIRGQn+7EMjl9G7Bpw+fuSPrBVK17fmhCpQgE95KWk/WmmwPZwFyo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz3t6dTd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730219986; x=1761755986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6I/kfLLxGDLdpTR0HeTd60odPvrBlqC94SDfCXBwCqA=;
  b=cz3t6dTdmwaXLB9DgnPbQIjSounMYIG6j5nrR0+0UyOBO8ZOiPnFgodz
   RE3r6Tmu545NQ7RjwrZHW5Hfk2AXBL1hIm7DYPsi/y22h+Mp2o0lnvM0V
   GOhXkhQKysMwli7CRBzil3LirWMhed3q8Emb3HiFfYVbmMfAS9/O7HpYm
   qEdQOUfI4DEzYPxNQJzvyqReREJxTyn278LJT+LrM+zJbhKC89nVJScAS
   2gEPGVgw0M2FE6WUncIXyWYszOL6/m5P0v1NtO4ThTdv8BGrSk3sKw0H6
   CzxhqZNR7GcKodl2CLDT0IEBTjMph3DXKsaPUAFthtEaEG3GdmY9vJLU+
   g==;
X-CSE-ConnectionGUID: RvktJUOzShacPSj1RTyLCQ==
X-CSE-MsgGUID: ARRAQ0dpTh6VjgSZOTxm5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29776054"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29776054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:39:45 -0700
X-CSE-ConnectionGUID: rwQaZcLyTgiUG4B2vTKvhg==
X-CSE-MsgGUID: SeQh9DULTcm2cKy2vssFBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86788553"
Received: from jerrycli-mobl2.amr.corp.intel.com (HELO [10.125.224.112]) ([10.125.224.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:39:44 -0700
Message-ID: <d6fa8ecb-17dd-4718-8ffc-b678dbe2c27c@linux.intel.com>
Date: Tue, 29 Oct 2024 09:39:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
To: Borislav Petkov <bp@alien8.de>
Cc: David Kaplan <David.Kaplan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 pawan.kumar.gupta@linux.intel.com
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
 <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>
 <20241029150022.GJZyD4ht9wYcVetdDS@fat_crate.local>
 <f82878e8-fdf7-4a73-93a1-2edf52fc0145@linux.intel.com>
 <20241029163712.GPZyEPOHFklQ1d1lMV@fat_crate.local>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20241029163712.GPZyEPOHFklQ1d1lMV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 09:37, Borislav Petkov wrote:
> On Tue, Oct 29, 2024 at 08:33:51AM -0700, Daniel Sneddon wrote:
>> I really like the attack vector idea David is using. I suspect people really
>> care about "protect my kernel from bad users" or "protect my host vm from
>> guests" more than "protect me from mds and rfds." 
> 
> Yeah, exactly!
> 
>> I was trying to get rid of the need to do a call to any kind of update
>> function where he took the existing function and split it into one for each
>> mitigation that needs it. Like you said, different approach same end result
>> really.
> 
> Right.
> 
> Ok, let's concentrate on David's set, then, so that we don't do
> unnecessary/doubled work. I'd appreciate it if you took a look at the Intel's
> side of things there but please wait until he sends a new version next week.

Will do!
> 
> I guess if all agree with the final result, we could look into taking it for
> 6.14 or so...
> 
> Thx.
> 


