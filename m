Return-Path: <linux-kernel+bounces-513685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24BA34D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E1C7A4887
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA4241692;
	Thu, 13 Feb 2025 18:18:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45914AD20;
	Thu, 13 Feb 2025 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470690; cv=none; b=TkS7/muN2QQ1ShEiMCtRRscflZqqBTReLPOT7+xOJCjtJHnhqtUwd0sOO8em+mVGgJ9k1EBYljv6D6hLLlOPWYLJ9i8tMHklwVtAbp5TnzQR841eTy6qj6MBfkrNM4ek8uBmboeUf1LZrIy+ZpYIslZTdMpJRAx+J4XklwkHucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470690; c=relaxed/simple;
	bh=XPe6RGG+3E8LPDsiWJclm164C2zfaeDhBS6YIN9n964=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvbuj64fLLoMxYXA/QWfmfF71iOyTkiFlauMik64rJMQxNA+fEwP2xxwwS/JYWdBbnfxSXSK4ImLi7aZlp9r6/WMageqPeObTQDmCx3/H7m1hq6DxIrYTSc2taQOBvyDhRYUk9YdA7QbTp8oj6KNBAsAuefKOj2PLctbGNHUVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7558113E;
	Thu, 13 Feb 2025 10:18:28 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2903F5A1;
	Thu, 13 Feb 2025 10:18:04 -0800 (PST)
Date: Thu, 13 Feb 2025 18:18:01 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: peternewman@google.com, corbet@lwn.net, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
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
Message-ID: <Z643WdXYARTADSBy@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>

Hi,

On Thu, Feb 13, 2025 at 10:19:29AM -0600, Moger, Babu wrote:
> Hi Dave,
> 
> Thanks for your help. Reinette has asked few questions already. I have few
> more questions on top of that.
> 
> On 2/12/25 11:46, Dave Martin wrote:
> > Hi there,
> > 
> > On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>
> >> This series adds the support for Assignable Bandwidth Monitoring Counters
> >> (ABMC). It is also called QoS RMID Pinning feature

[...]

> >> a. Check if ABMC support is available
> >> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> >>
> >> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> >> 	[mbm_cntr_assign]
> >> 	default
> > 
> > (Nit: can this be called "mbm_counter_assign"?  The name is already
> > long, so I wonder whether anything is gained by using a cryptic
> > abbreviation for "counter".  Same with all the "cntrs" elsewhere.
> > This is purely cosmetic, though -- the interface works either way.)
> 
> Yes. We can do that.

Thanks (note, I'm also happy without this change, if you aren't
planning do a substantial respin of the series.)

[...]

> >> b. Check how many ABMC counters are available. 
> >>
> >> 	# cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs 
> >> 	32
> > 
> > Is this file needed?
> > 
> > With MPAM, it is more difficult to promise that the same number of
> > counters will be available everywhere.
> > 
> > Rather than lie, or report a "safe" value here that may waste some
> > counters, can we just allow the number of counters to be be discovered
> > per domain via available_mbm_cntrs?
> 
> As  Reinette suggested below we can display per domain supported counters
> here.
> https://lore.kernel.org/lkml/9e849476-7c4b-478b-bd2a-185024def3a3@intel.com/

Although I'm still not convinced that this file is necessary, MPAM
should be able to work with this.

(I'm assuming that ABMC hardware has a set of counters for each
monitoring domain, of course -- otherwise this doesn't make sense.)

[...]

> >> c. Check how many ABMC counters are available in each domain.
> >>
> >> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
> >> 	0=30;1=30
> > 
> > For MPAM, this seems supportable.  Each monitoring domain will have
> > some counters, and a well-defined number of them will be available for
> > allocation at any one time.

[...]

> >>        Flags can be one of the following:
> >>
> >>         t  MBM total event is enabled.
> >>         l  MBM local event is enabled.
> >>         tl Both total and local MBM events are enabled.
> >>         _  None of the MBM events are enabled
> >>
> >> 	Examples:
> > 
> > [...]
> > 
> > I think that this basically works for MPAM.
> > 
> > The local/total distinction doesn't map in a consistent way onto MPAM,
> > but this problem is not specific to ABMC.  It feels sensible for ABMC
> > to be built around the same concepts that resctrl already has elsewhere
> > in the interface.  MPAM will do its best to fit (as already).
> > 
> > Regarding Peter's use case of assiging multiple counters to a
> > monitoring group [1], I feel that it's probably good enough to make
> > sure that the ABMC interface can be extended in future in a backwards
> > compatible way so as to support this, without trying to support it
> > immediately.
> > 
> > [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/
> > 
> > 
> > For example, if we added new generic "letters" -- say, "0" to "9",
> > combined with new counter files in resctrlfs, that feels like a
> > possible approach.  ABMC (as in this series) should just reject such
> > such assignments, and the new counter files wouldn't exist.
> 
> What is "combined with new counter files"? Does MPAM going to add new
> files to support counter assignment in ARM?
> 
> Also what is  "0" to "9"? Is this counter ids?
> 
> 
> > 
> > Availability of this feature could also be reported as a distinct mode
> > in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
> 
> Yes. That should be fine.
> 
> > 
> > 
> > A _sketch_ of this follows.  This is NOT a proposal -- the key
> > question is whether we are confident that we can extend the interface
> > in this way in the future without breaking anything.
> > 
> > If "yes", then the ABMC interface (as proposed by this series) works as
> > a foundation to build on.
> > 
> > --8<--
> > 
> > [artists's impression]
> > 
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> >  	mbm_cntr_generic
> >  	[mbm_cntr_assign]
> >  	default
> 
> Yes. This looks good.

Good to know, thanks.  (Just to be clear, I am *not* suggesting adding
anything like this just now -- just checking whether the idea works
at all.)


> > # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> > # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> Looks like you are assigning counter ids to domains here. That is
> different than ABMC. In ABMC, we assign events (local or total) to the
> domain. We internally handle the counter ids based on the availability.

The numbers are not supposed to have an hardware significance.

	'//0=6'

just "means assign some unused counter for domain 0, and create files
in resctrl so I can configure and read it".

The "6" is really just a tag for labelling the resulting resctrl
file names so that the user can tell them apart.  It's not supposed
to imply any specific hardware counter or event.

> Can MPAM follow the same concept?  It is possible?

[...]

> Thanks
> Babu Moger

Yes, although there is some hard-to-avoid fuzz about the precise
meaning of "local" and "total".

As Reinette pointed out, there is the also the possibility of adding
new named events other than "local" and "total" if we find that some
kinds of event don't fit these categories.

Cheers
---Dave

