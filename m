Return-Path: <linux-kernel+bounces-357448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3D997153
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B093128766B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640661E572B;
	Wed,  9 Oct 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCRCJ/KC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDC1E571E;
	Wed,  9 Oct 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490665; cv=none; b=iCiaxwydWIRut6JgKVvUlVwLyeDOWyBW1AjkP5PI5SbvOQvcFhETJ6iEhmXRfPl9ASQ7x43ayJwIYV6OahNUZ7ltWyl+h5N+dxQyYSjQyCPV0WT3S7+AJEE2OR88aDRhs5y65CvJC6KBIHF4b8KBi1yfQjV+3xeqesnm8m9jqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490665; c=relaxed/simple;
	bh=6i1GdfoSgkbtdK5sBlHSQIXbHTBjQFwOpESet3AYHC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ7xKzGCeCZVN+mxPWrmwqxmqhoRlsy89nyTR7k8ka/pd3SYvWIFttF2KDwkX4mlUW31VkX5O7PyDXIqw5CqfXf8nffrX4kv3Uvl9356AIqQO+SfYFUjir+A9PNfgjRCFa57LfZ/hnZUaQNxtinW1QTIKN68KsWtyHMr+pYq6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCRCJ/KC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728490664; x=1760026664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6i1GdfoSgkbtdK5sBlHSQIXbHTBjQFwOpESet3AYHC8=;
  b=iCRCJ/KC70KoLoPpKQWqJpgjjf/eBu1csDtLoe8/NWYkDkL050C9DJXo
   ibkQDlBu/z1pr/X22qEf6D7sT19rblAG3QGfQEx/RQWE2Nw3o2WzatGLz
   5tRx8+A2Ra412/GqkbezS7bkz5dGOi5tobT+DAQOQ2MfmH9HhQfvZ3yqA
   pJBwMKXkYqwoof8G9UIOSSi56QuzZVBL0T6HUXmuuKzUyDGlZ8C6Z0/fS
   OJKR+cbyrDOO3jaruCdd1gKWkiEnHC9/fxlphLfG5JbwHd74oQlH49Q/H
   r2sWFDi5mekACl2fyF0nKq5ATZx3gLshEU/3LIgb1/giVWMli7bTXvYLz
   w==;
X-CSE-ConnectionGUID: LUfpVzTyRvCz03AtRU5I6g==
X-CSE-MsgGUID: OFu14R/yT7+hMQr+u1U/qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31699550"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="31699550"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:17:43 -0700
X-CSE-ConnectionGUID: FLVpvBRRTLuyRpdqjYspEg==
X-CSE-MsgGUID: D9zazPphTIaf5oKrGaozzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="75975659"
Received: from yaaguila-mobl.amr.corp.intel.com (HELO [10.125.83.153]) ([10.125.83.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:17:42 -0700
Message-ID: <879b3437-c706-47c4-b1aa-b2def940f569@linux.intel.com>
Date: Wed, 9 Oct 2024 09:17:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
To: "Kaplan, David" <David.Kaplan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "hpa@zytor.com" <hpa@zytor.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 12:24, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>> Sent: Tuesday, September 24, 2024 5:32 PM
>> To: Jonathan Corbet <corbet@lwn.net>; Thomas Gleixner <tglx@linutronix.de>;
>> Borislav Petkov <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh
>> Poimboeuf <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>; Dave
>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org
>> Cc: hpa@zytor.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> pawan.kumar.gupta@linux.intel.com
>> Subject: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
>> mitigations
>>
>> There are currently 4 mitigations that use VERW to flush different cpu buffers. This
>> can cause confusion when trying to disable all the different VERW mitigations.
>> Simplify enabling/disabling these mitigations by creating a single parameter for
>> controlling them.
> 
> Just curious, what is the use case for disabling the different VERW mitigations (but not other mitigations)?  Is that a testing/debugging use case or a production use case?
> 
>>
>> Future work will focus on combining similar code used in selecting these mitigations
>> to further simplify.
>>
>> Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 16 +++++++++
>>  arch/x86/kernel/cpu/bugs.c                    | 34 +++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 09126bb8cc9f..66b567c4dce5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -628,6 +628,21 @@
>>       cio_ignore=     [S390]
>>                       See Documentation/arch/s390/common_io.rst for details.
>>
>> +     clear_cpu_buffers=
>> +                     [X86]
>> +                     Controls the mitigations that use
>> +                     X86_FEATURE_CLEAR_CPU_BUF, namely
>> +                     Micro-architectrual Data Sampling (MDS)
>> +                     MMIO Stale Data
>> +                     TSX Async Abort (TAA)
>> +                     Register File Data Sampling (RFDS)
>> +
>> +                     The options are:
>> +                     on              - Enable cpu buffer clearing
>> +                     on,nosmt        - Enable cpu buffer clearing and disable
>> +                                       SMT
>> +                     off             - Disables cpu buffer clearing
>> +
> 
> At the x86 uconf at LPC, someone asked me about if we should have command line options that were mitigation-focused rather than bug-focused (like to enable STIBP, IBRS, etc.).  The feedback I had there applies to this series too, which is that I'm concerned this makes things more difficult for users because users are reacting to bugs, they're not experts in mitigations.  A user wants to know how to mitigate CVE XYZ, and the bug-specific command line options support that.  It's an extra step to say that to mitigate MDS, you have to figure out that MDS requires clearing cpu buffers, and therefore you should set this mitigation-specific option.
> 
> My general concern with this series is it seems to tie X86_FEATURE_CLEAR_CPU_BUF directly to these 4 bugs.  What would happen if hypothetically there was a new bug that required X86_FEATURE_CLEAR_CPU_BUF and some other mitigation?  With the existing bug-specific options this is easy enough, as the new bug could force this feature and do whatever else it needed.  But with a mitigation-specific option like this one, it would seem to be harder as it might require multiple options to mitigate one bug.  And could create conflicts if you enable that new mitigation but disable clear_cpu_buffers.
> 

Any new bug that is using X86_FEATURE_CLEAR_CPU_BUF will be related to these
existing bugs regardless. We may need to add another option to this parameter,
similar to what we do with ",nosmt", but I would hope that would be sufficient.
With the existing bug-focused parameters we have the same potential for
conflicts. What if I say "reg_file_data_sampling=off mds=full"? Since mds is on
rfds will be on even though I requested it off. The intent of this parameter is
to remove such conflicts.

> I do get the point that these specific 4 bugs are all closely related.  Another idea to consider could be a single command line option for these 4 bugs, but is tied to the bugs themselves, not the mitigation.  That might be more future-proof as the scope remains only about these 4 bugs, not the mitigation itself.
> 

Are you suggesting a name change away from "clear_cpu_buffers" since it is
clearly about the mitigation rather than the bug? I'm not sure there is a good
common name for those 4 bugs that isn't about the mitigation, but I'm open to
any suggestions.

> --David Kaplan


