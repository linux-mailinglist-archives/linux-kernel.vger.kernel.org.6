Return-Path: <linux-kernel+bounces-173398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA58BFFF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2EE283821
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366185632;
	Wed,  8 May 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yr1s9nyu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E81DA22
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178524; cv=none; b=dya2Amad90rRCAuVqpTTT5SFsgvnHAPGHkfFhDL70kN8djYRcbjuebzXJtXC36oJdk/oaaOyPCqA4UHDBJUomVvMW1TNssH57Jxfj7JX3Jr+Gl0LiSM/q8VOu7d78QKWKBN+HnpIJiNFq4ddMoG/VU65WawbSWTaQZBW01KJ19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178524; c=relaxed/simple;
	bh=Bs9qnpmMzJ7MpSTPe1gl+OcouVxZVLR4mSJqncW0wT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6Isfz98Z2euB888nZgoJv+j8JeZ22tRgBB/TSza6LcCcOwqpMN6SBHwpM3LTnhADPvTUkNR1/h9Rc32C7w2HcJ4enCff0ZsTQfxaL4tGS31Ua+dg84rJJ8+7vKwZ8HqPOgp7gUdnP7HLzOXZkHDzawBmwPYk9WE2sdYKAUsxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yr1s9nyu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715178523; x=1746714523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bs9qnpmMzJ7MpSTPe1gl+OcouVxZVLR4mSJqncW0wT8=;
  b=Yr1s9nyuot9i5CLNd4/9UxJJRabV8Qgcx93M9fTcBd2qudC+vet4LP1v
   eY3SRXLot4qFHWOtwn/eQXRskF5Y9wTO6HWK2JYXy7O6aXCI8SUgG4DNG
   RcN1uyJfZYTFzT/bVZUGBFJz3PK4GjrC4REQxuw8OfiMf5IOiMtx6+dTs
   EMbReq74omjpjw1q12SeubDvdqoEXDcJOlwNPHJLyAnltujYg1I5jzD/g
   1FI/rXPIbJBBwUOhyPztDAnxz0shjzER78VOQyzoGIPW1ERtuKETqicsT
   HkZ5TzWUC0pqyYnEiNxR1tODf3j6qB0bcLtKPt/XbDaFf4mXYPFAXuE93
   A==;
X-CSE-ConnectionGUID: iErZ6oPaReW7dnxA/vx38A==
X-CSE-MsgGUID: uoYSprHSThaYSclmIU0TAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11171477"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11171477"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:28:42 -0700
X-CSE-ConnectionGUID: qEpfcQqMSaWzduMfJKqj1A==
X-CSE-MsgGUID: 2u5SR5n5SFKjlgXrmGqi5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28887046"
Received: from jmlang-mobl1.amr.corp.intel.com (HELO [10.125.131.224]) ([10.125.131.224])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 07:28:40 -0700
Message-ID: <8c88c185-cf9f-470c-8d7c-2b933d9419bc@linux.intel.com>
Date: Wed, 8 May 2024 07:28:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] x86/bugs: Remove duplicate Spectre cmdline option
 descriptions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <cdfe36cf9c8b6cd98eb0f32b798d5af1af95cb2c.1715059256.git.jpoimboe@kernel.org>
 <d0079f0c-3be8-484b-9c67-f08d6a1fb31e@linux.intel.com>
 <20240508055545.eix25ok3wvv6gcpg@treble>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240508055545.eix25ok3wvv6gcpg@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/24 22:55, Josh Poimboeuf wrote:
> On Tue, May 07, 2024 at 08:04:37AM -0700, Daniel Sneddon wrote:
>> I love the idea here, but
>>
>>>  	nospectre_v2
>>> +	spectre_v2={option}
>>> +	spectre_v2_user={option}
>>> +	spectre_bhi={option}
>>>  
>>
>> this comes out as just a single line when I run make htmldocs.
> 
> Thanks, the below turns it into a bulleted list:
> 
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index f9797ab6b38f..132e0bc6007e 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -598,11 +598,11 @@ current CPU.
>  Spectre default mitigations can be disabled or changed at the kernel
>  command line with the following options:
>  
> -	nospectre_v1
> -	nospectre_v2
> -	spectre_v2={option}
> -	spectre_v2_user={option}
> -	spectre_bhi={option}
> +	- nospectre_v1
> +	- nospectre_v2
> +	- spectre_v2={option}
> +	- spectre_v2_user={option}
> +	- spectre_bhi={option}
>  
>  For more details on the available options, refer to Documentation/admin-guide/kernel-parameters.txt
>  

Looks good.

Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>


