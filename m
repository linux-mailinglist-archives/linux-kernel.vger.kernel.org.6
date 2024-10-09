Return-Path: <linux-kernel+bounces-357521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B2997222
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FC81C23D53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AC1A3AAD;
	Wed,  9 Oct 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFktITqL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AE8489;
	Wed,  9 Oct 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492007; cv=none; b=d/CCMfFtrN0IKaz+bnnjHWsFCPHz1Tie7VcV85ZTf1LtWk2V24n/q0JRS3msWXKfVyaJmE7DY6jTmA8k9PcliEDHoD3rU1vE8rHCeVE+ClUiKKZE+JqdF2bepGtJXQ3xerP9EtplHcUVMBi9ZSMQ8trIbzY4epg4GZRE7noOh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492007; c=relaxed/simple;
	bh=AyEmnMzFLIGd/wqwrwyUbljGLWa9Ym+dv+sMjDK0TEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s29fxnDERAkfiL4C34vy9VNwyC0WiPoCsk7B5s22b4jz+cIJC2BDazWTVfwBbLTx7jg/Xe2HprbU9tF3DlclsyQ1/SoO0kfFYQ+IApPTBlqP7VuKcNcNN7ymFB1TQmCYSe/pBdyqAoCKJLRHVVTygyXYj6m3B1Th1XIm0ch4ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFktITqL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728492006; x=1760028006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AyEmnMzFLIGd/wqwrwyUbljGLWa9Ym+dv+sMjDK0TEI=;
  b=XFktITqL/slGcNMRhxejNs+PRUeKuAQe17F4FRz0SGnZHpp6+ZvHUN+N
   X5/04NICt5S5YLGtAqPd+BCVcVpwWt2v0VG7Xp42BtJD0hHqLj0ax1yJv
   xvehrQChPYaqwaY+ir80uCaD8Op5OOYITUFpwlWboFwc2uqmC1H5n9VIk
   LFF0K3vOxbhP8JX7Z/8iDMlzJzYfappi3AnCeZV0OH14NtXBdy8U8krGW
   Faj+V9pvlwfi0qwR56Dj6TuSSzSJQQyxfSBplBiyX5qdoLxTcguuk4Nc2
   sKZ5nCXHFgQFZulkgJMrpAsrUJtW+feYCR22dMdwpDbYbeuV/h4NvNB9t
   w==;
X-CSE-ConnectionGUID: H/m5Z8G+QzyiwTp23e/vfQ==
X-CSE-MsgGUID: zCY/RkXNQoaWiQ4KMcne0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27889470"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27889470"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:39:54 -0700
X-CSE-ConnectionGUID: GOxybgkTQEOM5IZ6AGO8tg==
X-CSE-MsgGUID: U4+LrSI/QwuW5t8SwSuHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76254671"
Received: from yaaguila-mobl.amr.corp.intel.com (HELO [10.125.83.153]) ([10.125.83.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:39:53 -0700
Message-ID: <7c1de6fb-fa83-47bc-a57b-e6700860513d@linux.intel.com>
Date: Wed, 9 Oct 2024 09:39:51 -0700
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
 <879b3437-c706-47c4-b1aa-b2def940f569@linux.intel.com>
 <LV3PR12MB9265A30309277CBB4A9B81D1947F2@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <LV3PR12MB9265A30309277CBB4A9B81D1947F2@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>>
>> Are you suggesting a name change away from "clear_cpu_buffers" since it is
>> clearly about the mitigation rather than the bug? I'm not sure there is a good
>> common name for those 4 bugs that isn't about the mitigation, but I'm open
>> to any suggestions.
>>
> 
> Yes, I think that would be better.  I wasn't sure on a name either.  In the RFDS webpage I see it described as "similar to data sampling transient execution attacks".  Perhaps something like that could be an umbrella term?
> 

Sure, I can change it. Thanks for the review!

> --David Kaplan


