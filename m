Return-Path: <linux-kernel+bounces-285596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4A951021
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1631F24997
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4931AB533;
	Tue, 13 Aug 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="br62628w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8716DEA9;
	Tue, 13 Aug 2024 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590110; cv=none; b=KPUyJ1NT/S4B6DvSfHI/s72lqi/IlfSqKuvy6DyNNkNPzdu2D7BqIHhwtw9xF9bOO8lBkKoI6zS8+1YJSmXhsFPVbHl80aEBY8zVu7QWiLw8hLsQeH/G3nQXDsfvDv53dmn3N/mfPKkGK3GP58QGpGunFNrdBMtAxCCygnjja4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590110; c=relaxed/simple;
	bh=Mm+2sEeIhnMoTfxzhb1SwNQk8u48va+ZsMjk/JBna5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zsf3hnSs2KB4iHayHuKkvIFOAgYBM7OpXMEnpx+Q90ERaAAg5+MwkuTYHQ/6xy5PT5STfv879rZOK7H3tE/A4x3RyNSw45b6iwpwSxDUlSzauzpG664n2+WGfWTcOBJnEr5cbLUFhkjfIE3kBNtf2MrW6KMjZVOeoejo2LQ0y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=br62628w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723590109; x=1755126109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mm+2sEeIhnMoTfxzhb1SwNQk8u48va+ZsMjk/JBna5E=;
  b=br62628w5oIqNMA4/NtY3q6XH+O73YhCTVo3wigm1ofbFKN7jKWhw08R
   cLPlZ5LrQHrgxbFxhQ2dgHXRfXF3EEiWvuGrRTPS0CBIYbt1UdQ7II8Mj
   3ilyrWw+FvBRcJ8i+UPIwxDtwZYczh/MwoaxYMQI15AdtQetM/7ixFj8G
   KLCi9CVZqt9tY+jiHl206FVVXicy7S240T1EHN8hVnIursSYNZcSknTwj
   6SsrHtu7oWbJGTdBql2x8mKJKDmk/xZ34fRtWc9PCnd1B3biN3itSmNSQ
   7gqjo/2u1B+S6El1+yLfady6Mo9MK4GgLjeZczAuZxeXPjS9AVXPtpg/P
   w==;
X-CSE-ConnectionGUID: t9Atp/tyR3u+Fu5th22RgA==
X-CSE-MsgGUID: auvDsYnESeC4d9Ovf7cTqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25581545"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="25581545"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 16:01:48 -0700
X-CSE-ConnectionGUID: +FAT3N+mTo+jIDJX74Pr0w==
X-CSE-MsgGUID: D7DBU5jhRNyJsykqaLJgtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="59126179"
Received: from xpardee-mobl.amr.corp.intel.com (HELO [10.125.227.132]) ([10.125.227.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 16:01:46 -0700
Message-ID: <72dd19cc-5f24-4b76-ad31-86f7432c6d34@linux.intel.com>
Date: Tue, 13 Aug 2024 16:01:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Create Intel PMC SSRAM Telemetry driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
 <ad5e7c93-33fa-4a5e-35af-7f99150dd4be@linux.intel.com>
Content-Language: en-US
From: Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <ad5e7c93-33fa-4a5e-35af-7f99150dd4be@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/13/2024 9:01 AM, Ilpo Järvinen wrote:
> On Fri, 9 Aug 2024, Xi Pardee wrote:
>
>> This patch series removes the SSRAM support from Intel PMC Core driver
>> and creates a separate PCI driver for SSRAM device. The new Intel PMC
>> SSRAM driver provides the following functionalities:
>>   
>> 1. Search and store the PMC information in a structure, including PWRMBASE
>> address and devid for each available PMC. Then Intel PMC Core driver
>> achieves the PMC information using the API provided by the new driver.
>>   
>> 2. Search and register Intel Platform Monitoring Techology telemetry
>> regions so they would by available for read through sysfs and Intel PMT
>> API. Intel PMC Core driver can achieve Low Power Mode requirement
>> information from a telemetry region registered by the new driver.
>> The above functionalities was previously handled by Intel PMC Core
>> driver. Intel PMC Core driver returns -EPROBE_DEFER when trying to read
>> data from a telem region that is not available yet. This setup may
>> result in an infinite loop of .probe() calls as Intel PMC Core driver
>> creates child devices. Creating a separate PCI driver avoids the infinite
>> loop possibility.
>>   
>> Xi Pardee (7):
>>    platform/x86:intel/pmc: Remove SSRAM support from PMC Core
>>    platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
>>    platform/x86:intel/pmc: Add support to get PMC information from SSRAM
>>    platform/x86:intel/pmt: Get PMC from SSRAM for available platforms
>>    platform/x86:intel/pmt: Create inline version for telemetry functions
>>    platform/x86:intel/pmc: Add support to Retrieve LPM information
>>    platform/x86:intel/pmc: Get LPM information for available platforms
> Hi,
>
> I don't see why the removal first, then re-add approach would be justified
> here. You're basically adding the same code back later in many cases with
> only very minimal changes, and some changes are entirely pointless such as
> pmc_idx -> pmc_index parameter rename. This is just a big pain to review.
>
> I'd suggest you move functions in first patch into core.c. Try to
> avoid logic/code changes other than making making the necessary functions
> non-static and adding the prototypes for them into a header (temporarily).
>
> Then rename the ssram file to its new name in the second change.
>
> Then do the rework on top of that (and make things back static again).
>
> Try to split the rework into sensible chunks, anything that can be taken
> away from the main rework change is less lines to review in that patch.
> If you e.g. want to do pcidev -> pdev renames, put them into own separate
> change (and do it consistently then, not just for some of the cases like
> currently :-/).
>
> The move patches are nearly trivial to review and take large chunk of
> diff away from the actual rework itself which doesn't seem that
> complicated to review once the 1:1 move bits and trivial rename churn is
> eliminated from the diff.


Hi,

Thanks for reviewing the patches. I will rearrange the code in next version.

Xi

>>   drivers/platform/x86/intel/pmc/Kconfig        |  13 +-
>>   drivers/platform/x86/intel/pmc/Makefile       |   8 +-
>>   drivers/platform/x86/intel/pmc/arl.c          |  36 +-
>>   drivers/platform/x86/intel/pmc/core.c         | 216 +++++++++++-
>>   drivers/platform/x86/intel/pmc/core.h         |  25 +-
>>   drivers/platform/x86/intel/pmc/core_ssram.c   | 326 ------------------
>>   drivers/platform/x86/intel/pmc/lnl.c          |  36 +-
>>   drivers/platform/x86/intel/pmc/mtl.c          |  34 +-
>>   .../platform/x86/intel/pmc/ssram_telemetry.c  | 184 ++++++++++
>>   .../platform/x86/intel/pmc/ssram_telemetry.h  |  45 +++
>>   drivers/platform/x86/intel/pmt/telemetry.h    |  19 +-
>>   11 files changed, 550 insertions(+), 392 deletions(-)
>>   delete mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
>>   create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h
>>
>>

