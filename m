Return-Path: <linux-kernel+bounces-547346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D989AA5060F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF1C1883999
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F96221D83;
	Wed,  5 Mar 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqBiFcvR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8919E806
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194605; cv=none; b=R17DKA3BYhaG6ty0v18y9Rq0KaOExTO/lN7fw4WLGnYkEXCTcySKP0qWSsYvyqW9k4ZJKYwrvMnZ6qUr0u4xFEg74IeOS/V8bsNVx4iqkCGe9e8G/Ak38YVB/zZX0ShZFDC1CqyP1QHB6KMh2aPkYmUCUbEWKBnluwTiesVzFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194605; c=relaxed/simple;
	bh=NUnw3w4zHpUUxzHAOjlde1jApGndTD9n9qsIaxBYZ98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXfsxilAPrNlvRdj4vr25X6OUrL49DihnIYADTZwuXOaAFINGgWW4YYlNCXk0egyY7Mn8PQhSdCRrB4KPO4JCl1EFCpNNfJu1AnIr+GReGSUjs1kUbWHcgDOJd8tccRRNkZw/OFTXw9aehwx/Pufg3swIaGGljYIn8VR2dsDb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqBiFcvR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741194603; x=1772730603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NUnw3w4zHpUUxzHAOjlde1jApGndTD9n9qsIaxBYZ98=;
  b=hqBiFcvRKnuir8+rFFXpafKtA7Hvsp7UC3UD7hKgotqt6fiCdpTPac3E
   5W9TSGf0fzlCANuOEgRJ2g8SVm5WpXSpCHq1C04JbTt7+QF92VuM8/iw3
   YyTbok04ayL3Nlk5G4Wgan8nGuecuuBo8zLoBVNoJcXAZoPwoquRP8yu2
   m2S6Wj7QpbComjP9KxGXcHYiqp1FS5LZv1QJggfMUaeLYx4AtYbmts1TE
   IeHZnjtvQ+WtJB7DAv9mJFqR19E+hkHYD+E+BdOABfaSLeiSnzIozVfd/
   37bKz4zEKzd70hoVHtZJdSD8rIfeK7+XLpcRoCTp00D08lt1ckXbHoOcW
   A==;
X-CSE-ConnectionGUID: l09wEgTESgGKQ4SI0csdGg==
X-CSE-MsgGUID: OLG9Lb64TxWst5cFY3vJuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67540056"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="67540056"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:09:27 -0800
X-CSE-ConnectionGUID: kFXu1EydSj+Xt4FR9HCBrg==
X-CSE-MsgGUID: gzcg3VfsSO6C3pgbEodciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123779360"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.196]) ([10.125.109.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:09:27 -0800
Message-ID: <e2f9c22d-d09c-46b5-9695-a052859d04d2@intel.com>
Date: Wed, 5 Mar 2025 09:09:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <jroedel@suse.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 Larry.Dewey@amd.com
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <20250305165502.GLZ8iB5kAtQmW6fu1F@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250305165502.GLZ8iB5kAtQmW6fu1F@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 08:55, Borislav Petkov wrote:
> On Wed, Mar 05, 2025 at 08:40:29AM -0800, Dave Hansen wrote:
>> TDX guests have CPUID to tell them that they're running that way.
> 
> And those CPUID leafs cannot be modified or intercepted or so by the
> hypervisor?

They are documented as coming straight from the TDX module when TDX is
in place. But there's nothing stopping an evil hypervisor from faking
them, except attestation.

>> We've just got X86_FEATUREs for hosts and guests:
>>
>> 	#define X86_FEATURE_TDX_HOST_PLATFORM ( 7*32+ 7)
>> 	#define X86_FEATURE_TDX_GUEST ( 8*32+22)
>>
>> and that's it.
> 
> And there are no new ones coming down the pipe?

Not really. There are always new features in the pipeline, but no real
fundamental changes to the threat model like SEV has had throughout its
iterations.

>> Folks certainly _want_ something in sysfs to dump the TDX module version
>> and so forth, but we've resisted the urge so far.
> 
> Perhaps now is the time do design something together...
> 
> I was thinking
> 
> /sys/guest/...
> 
> or something tied to the x86_platform gunk so that we can stick always some
> info there about any platform arch/x86/ has detected and is running on...

Xen has a bunch of gunk in:

	/sys/hypervisor

Joerg, why do folks care if they're running under SEV? What kind of
stuff are they doing after they do the rdmsr and see that SEV is in play?

