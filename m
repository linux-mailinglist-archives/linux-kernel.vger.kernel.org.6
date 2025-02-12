Return-Path: <linux-kernel+bounces-511652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81FA32DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F0E163BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284625B69B;
	Wed, 12 Feb 2025 17:46:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C425A2D3;
	Wed, 12 Feb 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382375; cv=none; b=AVDYTOr1K1+1E4sUaa39HYcRQjZyYFsILIYH5vqVQFqHuNHD66+EcDOFxBh/G/W05HEKz8sAz86VoRpqxo81/BJx4eD0RfUxqTXv8U0DMcEz5YnyxPzrYznnItnuWgC1Xh6EsZ5h0TnCtnhq01DB+NShGlMkkpAACbus1jN1EdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382375; c=relaxed/simple;
	bh=jMD/H7uMUbc7ssjp65BmFcgJoR7L5VSSPfr1wMYg6X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDm9MZwNkwOGITZH2obrOHmJ8Wxr+u8zVOrAR/s1aI9Bi8ZhBK0TV/HJ5jaCoyDu0wYzwiZe6LpJz/Hlz6H66Xz9YUWcuv1xjwfy4Mhx5tI2s6H9GyYqUOUsatF1qHxGkjbDq3aJpY/Lm4RPnC3q+YuEfJBJmLcFbDWq/NGSacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23DB12FC;
	Wed, 12 Feb 2025 09:46:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54EAF3F5A1;
	Wed, 12 Feb 2025 09:46:08 -0800 (PST)
Date: Wed, 12 Feb 2025 17:46:05 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>, peternewman@google.com
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, fenghua.yu@intel.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Message-ID: <Z6zeXby8ajh0ax6i@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1737577229.git.babu.moger@amd.com>

Hi there,

On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> 
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
> 
> # Introduction

[...]

> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 	[mbm_cntr_assign]
> 	default

(Nit: can this be called "mbm_counter_assign"?  The name is already
long, so I wonder whether anything is gained by using a cryptic
abbreviation for "counter".  Same with all the "cntrs" elsewhere.
This is purely cosmetic, though -- the interface works either way.)

> 	ABMC feature is detected and it is enabled.
> 
> b. Check how many ABMC counters are available. 
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
> 	32

Is this file needed?

With MPAM, it is more difficult to promise that the same number of
counters will be available everywhere.

Rather than lie, or report a "safe" value here that may waste some
counters, can we just allow the number of counters to be be discovered
per domain via available_mbm_cntrs?

num_closids and num_rmids are already problematic for MPAM, so it would
be good to avoid any more parameters of this sort from being reported
to userspace unless there is a clear understanding of why they are
needed.

Reporting number of counters per monitoring domain is a more natural
fit for MPAM, as below:

> c. Check how many ABMC counters are available in each domain.
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
> 	0=30;1=30

For MPAM, this seems supportable.  Each monitoring domain will have
some counters, and a well-defined number of them will be available for
allocation at any one time.

> d. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> 
> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    to list and modify any group's monitoring states. File provides single place
>    to list monitoring states of all the resctrl groups. It makes it easier for
>    user space to learn about the used counters without needing to traverse all
>    the groups thus reducing the number of file system calls.
> 
> 	The list follows the following format:
> 
> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> 	Format for specific type of groups:
> 
> 	* Default CTRL_MON group:
> 	 "//<domain_id>=<flags>"

[...]

>        Flags can be one of the following:
> 
>         t  MBM total event is enabled.
>         l  MBM local event is enabled.
>         tl Both total and local MBM events are enabled.
>         _  None of the MBM events are enabled
> 
> 	Examples:

[...]

I think that this basically works for MPAM.

The local/total distinction doesn't map in a consistent way onto MPAM,
but this problem is not specific to ABMC.  It feels sensible for ABMC
to be built around the same concepts that resctrl already has elsewhere
in the interface.  MPAM will do its best to fit (as already).

Regarding Peter's use case of assiging multiple counters to a
monitoring group [1], I feel that it's probably good enough to make
sure that the ABMC interface can be extended in future in a backwards
compatible way so as to support this, without trying to support it
immediately.

[1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/


For example, if we added new generic "letters" -- say, "0" to "9",
combined with new counter files in resctrlfs, that feels like a
possible approach.  ABMC (as in this series) should just reject such
such assignments, and the new counter files wouldn't exist.

Availability of this feature could also be reported as a distinct mode
in mbm_assign_mode, say "mbm_cntr_generic", or whatever.


A _sketch_ of this follows.  This is NOT a proposal -- the key
question is whether we are confident that we can extend the interface
in this way in the future without breaking anything.

If "yes", then the ABMC interface (as proposed by this series) works as
a foundation to build on.

--8<--

[artists's impression]

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
 	mbm_cntr_generic
 	[mbm_cntr_assign]
 	default

# echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
# echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
# echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
# echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
# echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
# echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 

...

# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes

etc.

-->8--

Any thoughts on this, Peter?

[...]

Cheers
---Dave

