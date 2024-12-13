Return-Path: <linux-kernel+bounces-445155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B43F9F1210
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98F6281C23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789E1E3DF2;
	Fri, 13 Dec 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYm0PSH7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A61E3DE8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107267; cv=none; b=I/zpXCuifTeJUdCdJ6IruxXuZAoRn8YnwOAqkagabgXeLAsWnXXVsXLbpMm/wnCPqB2kvoB6SKz3hLMOLHMTlKAWbvqdPOfkBTH+KIikU6Rws90HT1gATAr/WTgs5CI2NHS0DGM0Wd9KaRlKlAIo5QRhyLmpddrhQj9j7jRIQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107267; c=relaxed/simple;
	bh=kdqVaCCqhkmGPih7F8G9TlY17faS69U7LQ8M+EIlyE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpkPEPCLYMWjx+h3ilHNRBHDvowMUJNa93TcmWCKhzU1zStBOuOSIjkFXlxY/08Ij1xFh7fvoGX4HxrRgMHzwSYir1IY0gwO9RooUc67s406GzHXilMYOFMvoxZwoyqb3N3QKPA4VImRAxpatgl3Rmr/H/ZJQ7Y/zbijvxfVRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYm0PSH7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734107266; x=1765643266;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kdqVaCCqhkmGPih7F8G9TlY17faS69U7LQ8M+EIlyE8=;
  b=aYm0PSH7AY8UgUusuzxq832eh2smmQczLLkH8YcZznzZFzrIAqRaLu9R
   hMrA+0a/reEq4kEh4H5Zy7qo5BtTwmXyq/ynH2BeN2PDqWnbeDdIEI9JF
   Atjjfh79w7YKmo45q7Z8ZwfPBji/dvgMO8JvC31SHQ3axZu91MvcoHT1Q
   P9IX2myCRr5yUOXjaT+1RQ6L2xMWKc2r4tMyAPuXr4MhcivvnMCg11KS9
   uZ0a1mxlSgp2fsRo/GsV3C60/+oaMOQntp5yDCEsCr7muePEg1//wW9sE
   1El27g+0qVw6BFhevZ3g7qMVpoFABBCQ/jotrc7JL/H4mM4CuTDzwCSDZ
   w==;
X-CSE-ConnectionGUID: FGDyDUr+Ss65ykHHpP662A==
X-CSE-MsgGUID: M+05z7j3QbCy2sJ1gpe7BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="52084824"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="52084824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:27:45 -0800
X-CSE-ConnectionGUID: xUYNVNluQ0qqpYZkXFVIyQ==
X-CSE-MsgGUID: 36A+kq3JRfWLExxpU3YqkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="96806302"
Received: from philliph-desk.amr.corp.intel.com (HELO [10.124.223.121]) ([10.124.223.121])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:27:44 -0800
Message-ID: <d42655ed-d1a4-48e7-ab37-e3449801107d@intel.com>
Date: Fri, 13 Dec 2024 08:27:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] x86/cpu: Expose only stepping min/max interface
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 kan.liang@linux.intel.com, mingo@kernel.org, peterz@infradead.org,
 tony.luck@intel.com, pawan.kumar.gupta@linux.intel.com
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
 <20241206193832.DCF208DC@davehans-spike.ostc.intel.com>
 <20241213162443.GGZ1xfyw_EZBrn1i4B@fat_crate.local>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241213162443.GGZ1xfyw_EZBrn1i4B@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 08:24, Borislav Petkov wrote:
> drivers/edac/i10nm_base.c:951:90: error: macro "X86_MATCH_VFM_STEPPINGS" requires 4 arguments, but only 3 given
>   951 |         X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_DARKMONT_X,  X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
>       |                                                                                          ^

I'll fix that up.

>> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	0x0, 0xf, &gnr_cfg),
>> +	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	0x0, 0xf, &gnr_cfg),
> 
> Aren't those supposed to be:
> 
> 	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPING_MIN, X86_STEPPING_MAX, &gnr_cfg),
> 
> And while we're adding new defines, can we shorten them too?
> 
> 	X86_MATCH_VFM_STP(INTEL_ATOM_CRESTMONT,	X86_STP_MIN, X86_STP_MAX, &gnr_cfg),
> 
> all that "STEPPING" is screaming at me! :-P

I was trying to minimize the churn but that seems like a good thing to
add.  I'll also shorten the name.


