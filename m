Return-Path: <linux-kernel+bounces-357776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C39975DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E051C20AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B41E1051;
	Wed,  9 Oct 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaXFH/xb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653ED2629D;
	Wed,  9 Oct 2024 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503057; cv=none; b=KWmQWqbjso6l/PscpAXkenIdCo9yGCO6EsDeQtKTE5SWpTaCplWTLmB2XZ9YCr9g0yWMlfyWQ8kxKIArhwFhmCTnX8ZYV61v16PnvuKjRM3dnMP95CwPB+M+YqGV4+H5cbiOCqBkjTUUJQgY+tEvuZo0a/NSeEZM/0QXsDTy+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503057; c=relaxed/simple;
	bh=1pgldR4TDMi05Jhf4Io963ZyBUXdGxSLlxMrZyb+vOo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VYmpbMAAzhhifoQgzM89eE9m5CJRlEJSXdStJFgkPxj9LOO9SXsPwWn14twEsunDZVbwd1saDdiEnTiNS8RMeH5pS1iqy6RvsukKYBhA7kchDX5PJEjjP+6+bqhktlBRK23K8veQeVxiN7PoaSJqvl3NizJW4Zd/FQhpo+WvfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaXFH/xb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728503057; x=1760039057;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=1pgldR4TDMi05Jhf4Io963ZyBUXdGxSLlxMrZyb+vOo=;
  b=AaXFH/xbCc408uWQ1Kj3eAR4yIb6p7tauurpydwg3PkjHMg7GJDMrPYN
   c0UsRlao0WMlrqRdnTCf33Vg/43bXcKxPVfk2HnyhezffwKeDBmHWFQiU
   DgcWdMGgnxD8ns35zs6aEw2O7Z98YlpztfdNPhcbHlyrWPakjgSrCkBjD
   aNrYKJScdmGnnGeW3et62i22PwFOIWUqenUvBpKW8jWSxIuZZ1+DSQS8L
   v2IgCCusCt/BeUxTZBBQkxH/9+SOrnUgHRXShEGJUOTMSN2LRcXcg93Sq
   cJTbxTRE3vo49kRsTlYVtMyyCzy9B7S1rrW4RZdhYDxh9IejfaNou9SvQ
   A==;
X-CSE-ConnectionGUID: +rvZ6sYVSDiAWyFW0Cr04A==
X-CSE-MsgGUID: hQzVeq5HQ0S2r7mIuw5LtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31531197"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="31531197"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 12:44:16 -0700
X-CSE-ConnectionGUID: xuGlGIvVTd2vkMsbKRl62Q==
X-CSE-MsgGUID: 8UmA5RcWSDmcw15KWj8avA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="107108658"
Received: from yaaguila-mobl.amr.corp.intel.com (HELO [10.125.83.153]) ([10.125.83.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 12:44:14 -0700
Message-ID: <83686f5b-7957-432c-9e2c-d54e381c06c9@linux.intel.com>
Date: Wed, 9 Oct 2024 12:44:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
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
 <7c1de6fb-fa83-47bc-a57b-e6700860513d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <7c1de6fb-fa83-47bc-a57b-e6700860513d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 09:39, Daniel Sneddon wrote:
> 
>>>
>>> Are you suggesting a name change away from "clear_cpu_buffers" since it is
>>> clearly about the mitigation rather than the bug? I'm not sure there is a good
>>> common name for those 4 bugs that isn't about the mitigation, but I'm open
>>> to any suggestions.
>>>
>>
>> Yes, I think that would be better.  I wasn't sure on a name either.  In the RFDS webpage I see it described as "similar to data sampling transient execution attacks".  Perhaps something like that could be an umbrella term?
>>

data sampling feels a little too generic. How about something like
microarch_data_sampling?


