Return-Path: <linux-kernel+bounces-526411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D057DA3FE50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6677D19C8A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED52528E0;
	Fri, 21 Feb 2025 18:08:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04C250C1E;
	Fri, 21 Feb 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161286; cv=none; b=stBzQBIWwSfqQjrVCJNKrhFFKNIfzspSL5kZ1gLXRflTR1/dP5j8Qd8j7NNsg/TKLuOzIBwxaGoFBbrUtFBqW0W+CgFn30I7IO+EAp1gNDI2VTBAr3XuvBF/GJZ06aTxv+8/gVMy+J2p5jL+4mPm+jQ5SuF08TeF54n6SdOYTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161286; c=relaxed/simple;
	bh=/Duaa8CLIqaRcEqpAhL4aJO4iVDHZy9rN69g1KMIxkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncSHyScoBk/PIBpBi/fn10IBTtO+FI72uqu6yBlPXZIM0qMvsvlhInK8XfVoBzSYiojDgXPQAJKFu7hICVNEk+orrkJF21A++DHsvRgph1BvtndSPo+aHGSxyiP3ztTHNWznW1+lacfra2YuaOsV4zjmeP+sGoru95bRdNHkuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77FA237B;
	Fri, 21 Feb 2025 10:08:21 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC9B3F59E;
	Fri, 21 Feb 2025 10:08:00 -0800 (PST)
Message-ID: <7e4a685f-47db-4425-bb8f-20340ae15a93@arm.com>
Date: Fri, 21 Feb 2025 18:07:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
 peternewman@google.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <cover.1737577229.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 22/01/2025 20:20, Babu Moger wrote:
> This series adds the support for Assignable Bandwidth Monitoring Counters
> (ABMC). It is also called QoS RMID Pinning feature
> 
> Series is written such that it is easier to support other assignable
> features supported from different vendors.
> 
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit
> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'

I've rebased the MPAM tree on top of this v11, here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/abmc/v11
Hopefully this is sufficient evidence that this interface works for MPAM.

It would be convenient for MPAM platforms to not have to support a 'default' mode if they
are emulating ABMC - this was something that was never supported, and its not a problem
that can be solved. (comments on the relevant patches).


Thanks,

James

