Return-Path: <linux-kernel+bounces-513591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ABEA34C17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876A4168703
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2D21D3FC;
	Thu, 13 Feb 2025 17:37:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4C204684;
	Thu, 13 Feb 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468241; cv=none; b=UolE38x0E8fol64FvJJljty2Nb+rb65FX8zXZDJ0Af14yVfoysxrrISI8tLwdLdzX6E0mlqw2iZqTytp2bVpIxvFnNSRzy0N3cqZ1fDNRCWV70cky8DL0UzBhYrPoOaixe0L9F6Pytz5NDQRa/DnbLmfjcbhX5UL19nRYycZtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468241; c=relaxed/simple;
	bh=eF+lSLpbwJ2LDHqFaSJjz+GZVzWESaTmld8m1MfCj+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGt5E+ajgG4YTblwrY/lf4QO5jeLz5KrlqwB4oD+YlgOjOhYbR9IFsXWJfkw0soO6+ZWB3JpgHqIZLGtvCjZEfoAYBJDa99X3eqXeneIVHNy2Ew7x1+1SqbgXHLdrxsMknXxt1zquYQaeQcGyvQpUiuW15PD9pVBHneFO+Gsphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD4B9113E;
	Thu, 13 Feb 2025 09:37:38 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AD843F5A1;
	Thu, 13 Feb 2025 09:37:13 -0800 (PST)
Date: Thu, 13 Feb 2025 17:37:07 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, peternewman@google.com, corbet@lwn.net,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, tony.luck@intel.com,
	fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
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
Message-ID: <Z64tw2NbJXbKpLrH@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>

Hi Reinette,

On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/12/25 9:46 AM, Dave Martin wrote:
> > Hi there,
> > 
> > On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>
> >> This series adds the support for Assignable Bandwidth Monitoring Counters
> >> (ABMC). It is also called QoS RMID Pinning feature
> >>
> >> Series is written such that it is easier to support other assignable
> >> features supported from different vendors.
> >>
> >> The feature details are documented in the  APM listed below [1].
> >> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> >> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> >> Monitoring (ABMC). The documentation is available at
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> >>
> >> The patches are based on top of commit
> >> d361b84d51bfe (tip/master) Merge branch into tip/master: 'x86/tdx'

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
> This sounds reasonable to me. I think us having trouble with the
> user documentation of this file so late in development should also have been
> a sign to rethink its value.
> 
> For a user to discover the number of counters supported via available_mbm_cntrs
> would require the file's contents to be captured right after mount. Since we've
> had scenarios where new userspace needs to discover an up-and-running system's
> configuration this may not be possible. I thus wonder instead of removing
> num_mbm_cntrs, it could be modified to return the per-domain supported counters
> instead of a single value? 

Is it actually useful to be able to discover the number of counters
that exist?  A counter that exists but is not available cannot be used,
so perhaps it is not useful to know about it in the first place.

But if we keep this file but make it report the number of counters for
each domain (similarly to mbm_available_cntrs), then I think the MPAM
driver should be able to work with that.

> > num_closids and num_rmids are already problematic for MPAM, so it would
> > be good to avoid any more parameters of this sort from being reported
> > to userspace unless there is a clear understanding of why they are
> > needed.
> 
> Yes. Appreciate your help in identifying what could be problematic for MPAM.

For clarity: this is a background issue, mostly orthogonal to this
series.

If this series is merged as-is, with a global per-resource
num_mbm_cntrs property, then this not really worse than the current
situation -- it's just a bit annoying from the MPAM perspective.


In a nutshell, the num_closids / num_rmids parameters seem to expose
RDT-specific hardware semantics to userspace, implying a specific
allocation model for control group and monitoring group identifiers.

The guarantees that userspace is entitled to asssume when resctrl
reports particular values do not seem to be well described and are hard
to map onto the nearest-equivalent MPAM implementation.  A combination
of control and monitoring groups that can be created on x86 may not be
creatable on MPAM, even when the number of supportable control and
monitoring partitions is the same.

Even with the ABMC series, we may still be constrained on what we can
report for num_rmids: we can't know in advance whether or not the user
is going to use mbm_cntr_assign mode -- if not, we can't promise to
create more monitoring groups than the number of counters in the
hardware.


It seems natural for the counts reported by "available_mbm_cntrs" to
change dynamically when the ABMC assignment mode is changed, but I
think userspace are likely to expect the global "num_rmids" parameters
to be fixed for the lifetime of the resctrl mount (and possibly fixed
for all time on a given hardware platform -- at least, modulo CDP).


I think it might be possible to tighten up the docmentation of
num_closids in particular in a way that doesn't conflict with x86 and
may make it easier for MPAM to fit in with, but that feels like a
separate conversation.

None of this should be considered a blocker for this series, either way.

> > 
> > Reporting number of counters per monitoring domain is a more natural
> > fit for MPAM, as below:
> > 
> >> c. Check how many ABMC counters are available in each domain.
> >>
> >> 	# cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs 
> >> 	0=30;1=30
> > 
> > For MPAM, this seems supportable.  Each monitoring domain will have
> > some counters, and a well-defined number of them will be available for
> > allocation at any one time.

[...]

> >> e. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control

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
> 
> I do not think that resctrl's current support of the mbm_total_bytes and
> mbm_local_bytes should be considered as the "only" two available "slots"
> into which all possible events should be forced into. "mon_features" exists
> to guide user space to which events are supported and as I see it new events
> can be listed here to inform user space of their availability, with their
> associated event files available in the resource groups.

That's fair.  I wasn't currently sure how (or if) the set of countable
events was expected to grow / evolve via this route.

Either way, I think this confirms that there is at least one viable way
to enable more counters for a single control group, on top of this
series.

(If there is more than one way, that seems fine?)

> > 
> > For example, if we added new generic "letters" -- say, "0" to "9",
> > combined with new counter files in resctrlfs, that feels like a
> > possible approach.  ABMC (as in this series) should just reject such
> > such assignments, and the new counter files wouldn't exist.
> > 
> > Availability of this feature could also be reported as a distinct mode
> > in mbm_assign_mode, say "mbm_cntr_generic", or whatever.
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
> > 
> > # echo mbm_cntr_generic >/sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> > # echo '//0=01;1=23' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> > # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter0_bytes_type 
> > # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter1_bytes_type 
> > # echo t >/sys/fs/resctrl/info/L3_MON/mbm_counter2_bytes_type 
> > # echo l >/sys/fs/resctrl/info/L3_MON/mbm_counter3_bytes_type 
> > 
> > ...
> > 
> > # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_counter1_bytes
> > 
> > etc.
> > 
> 
> It is not clear to me what additional features such an interface enables. It
> also looks like user space will need to track and manage counter IDs?

My idea was that for these generic counters, new files could be exposed
to configure what they actually count (the ..._type files shown above;
or possibly via the ..._config files that already exist).

The "IDs" were inteded as abstract; the number only relates the
assignments in mbm_assign_control to the files created elsewhere.  This
wouldn't be related to IDs assigned by the hardware.

If there are multiple resctrl users then using numeric IDs might be
problematic; though if we go eventually in the direction of making
resctrlfs multi-mountable then each mount could have its own namespace.

Allowing counters to be named and configured with a mkdir()-style
interface might be possible too; that might make it easier for users to
coexist within a single resctrl mount (if we think that's important
enough).

> It sounds to me as though the issue starts with your statement
> "The local/total distinction doesn't map in a consistent way onto MPAM". To
> address this I expect that an MPAM system will not support nor list
> mbm_total_bytes and/or mbm_local_bytes in its mon_features file (*)? Instead,
> it would list the events that are appropriate to the system? Trying to match
> with what Peter said [1] in the message you refer to, this may be possible:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
> mbm_local_read_bytes
> mbm_local_write_bytes
> mbm_local_bytes
> 
> (*) I am including mbm_local_bytes since it could be an event that can be software
> defined as a sum of mbm_local_read_bytes and mbm_local_write_bytes when they are both
> counted.
> 
> I see the support for MPAM events distinct from the support of assignable counters.
> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
> Please help me understand if you see it differently.
> 	
> Doing so would need to come up with alphabetical letters for these events,
> which seems to be needed for your proposal also? If we use possible flags of:
> 
> mbm_local_read_bytes a
> mbm_local_write_bytes b
> 
> Then mbm_assign_control can be used as:
> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> <value>
> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> 
> One issue would be when resctrl needs to support more than 26 events (no more flags available),
> assuming that upper case would be used for "shared" counters (unless this interface is defined
> differently and only few uppercase letters used for it). Would this be too low of a limit?
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com/

That approach would also work, where an MPAM system has events are not
a reasonable approximation of the generic "total" or "local".

For now we would probably stick with "total" and "local" anyway though,
because the MPAM architecture doesn't natively allow the mapping onto
the memory system topology to be discovered, and the information in
ACPI / device tree is insufficient to tell us everything we'd need to
know.  But I guess what counts as "local" in particular will be quite
hardware and topology dependent even on x86, so perhaps we shouldn't
worry about having the behaviour match exactly (?)

Regarding the code letters, my idea was that the event type might be
configured by a separate file, instead of in mbm_assign_control
directly, in which case running out of letters wouldn't be a problem.

Alternatively, if we want to be able to expand beyond single letters,
could we reserve one or more characters for extension purposes?

If braces are forbidden by the syntax today, could we add support for
something like the following later on, without breaking anything?

# echo '//0={foo}{bar};1={bar}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control


For now, my main concern would be whether this series prevents that
sort of thing being added in a backwards compatible way later.

I don't really see anything that is a blocker.

What do you think?

Cheers
---Dave

