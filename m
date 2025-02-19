Return-Path: <linux-kernel+bounces-521483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A5A3BDF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAD6169324
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B801DFD91;
	Wed, 19 Feb 2025 12:24:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0AB1DE89D;
	Wed, 19 Feb 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967896; cv=none; b=FQpgwJzdYpDGfY+972+VJjG8NiHIGmY8JJR1uE6fHJLnmbvdNtNxhLSVER6PoQjOXcxCNmVRMHyMiaPEzu6QEc5uPtnnvaeTCJyAvh19c8dZX7WxPS/0ZrP9hDLlLYowKOCWaS6h7QADhEVTN9OuL9AoKGSRzxXANXZgnKWWvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967896; c=relaxed/simple;
	bh=ppiQj7taOmrkOVW6WhbxT8Jb9kpZcTfAW6XFCQoFOv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPgBYHDh9EMEwioOfBMvp5Qjzj76MNIBWXTtKNRVGA/9VxabXHuvHCVSHpqJ1OUmZXkKehgn3oiGc4waA+DWVXEnvroUK4q4ZRC8rY9n2T+kMNkRjLjVxHLMj/EG441UzWl2xDGJifgHr2lOn2e0Bpun/s7unBV/7ZXGhzQL/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CC91682;
	Wed, 19 Feb 2025 04:25:11 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65B3C3F6A8;
	Wed, 19 Feb 2025 04:24:48 -0800 (PST)
Date: Wed, 19 Feb 2025 12:24:42 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	"Moger, Babu" <bmoger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, x86@kernel.org, hpa@zytor.com,
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
Message-ID: <Z7XNinHbdsNLZ977@e133380.arm.com>
References: <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
 <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>

Hi there,

On Tue, Feb 18, 2025 at 09:39:43AM -0600, Moger, Babu wrote:
> Hi All,
> 
> On 2/18/25 06:30, Dave Martin wrote:
> > On Mon, Feb 17, 2025 at 10:45:29AM -0600, Moger, Babu wrote:
> >> Hi All,

[...]

> >> One thing I am not clear why MPAM implementation plans to create separate
> >> files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
> >> events. We already have files in each group to read the events.
> >>
> >> # ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
> >> total 0
> >> -r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
> >> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
> >> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes
> > 
> > 
> > To be clear, we have no current plan to do this from the Arm side.
> > 
> > My sketch was just a thought experiment to test whether we would have
> > difficulties _if_ a decision were made to extend the interface in that
> > direction.
> > 
> > But it looks OK to me: the interface proposed in this series seems to
> > leave enough possibilities for extension open that we could do
> > something like what I described later in if we decide to.
> > 
> > 
> > Overall, the interface proposed in this series seems a reasonable way
> > to support ABMC systems while keeping the consumer-side interface
> > (i.e., reading the mbm_total_bytes files etc.) as similar to the
> > classic / Intel RDT situation as possible.
> > 
> > MPAM can fit in with this approach, as demonstrated by James' past
> > branches porting the MPAM driver on top of previous versions of the
> > ABMC series.
> 
> Thanks Dave.
> > 
> > As I understand it, he's almost done with porting onto this v11,
> > with no significant issues.
> > 
> Good to know. Thanks
> 
> I am working on v12 of ABMC with few changes from Reinette's earlier
> review comments.
> 
> Most of the changes are related to commit message update and user
> documentation update.
> 
> Introduced couple of new functions resctrl_reset_rmid_all() and
> mbm_cntr_free_all() to organize the code better based on the comment.
> https://lore.kernel.org/lkml/b60b4f72-6245-46db-a126-428fb13b6310@intel.com/
> 
> 
> On top of that I have few comments from from Dave.
> 
> 1.  Change "mbm_cntr_assign" to "mbm_counter_assign".
> 
> This will require me to search and replace lot of places. There are
> variables, names like num_mbm_cntrs, mbm_cntr_assignable,
> resctrl_arch_mbm_cntr_assign_enabled, resctrl_arch_mbm_cntr_assign_set,
> mbm_cntr_assign_enabled, resctrl_num_mbm_cntrs_show, mbm_cntr_cfg and list
> goes on.
> 
>  This is mostly cosmetic and not much value add. Will drop this change if
> Dave has no objections.

There is no need to change the names of kernel symbols -- this was just
about the interface presented to userspace.

So, if you rename only the affect file names in resctrlfs (I think
there weren't any others) then I'm happy with that.

But if you prefer to avoid this inconsistency, the file name can stay
as-is.  It's not a huge deal.


> 2. Change /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs to display per-domain
> supported counters instead of a single value.

Ack; thanks (we could always add it back in later without an ABI break,
if people feel strongly about it and it looks feasible).


> 3. Use the actual events instead of flags based on the below comment.
> 
> https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/
> 
>  Something like this.
>  # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
> >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>  Are we ready to go with this approach? I am still not clear on this.

[...]

> -- 
> Thanks
> Babu Moger

On this point, I'll defer to discussions elsewhere on the thread.


I have a few other minor comments pending to post, but it looks like
there may be a more serious issue with how the mbm_assign_control file
is handled in the kernel -- I'll try to post comments on that today.

Cheers
---Dave

