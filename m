Return-Path: <linux-kernel+bounces-523810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB0A3DB85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A434206A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41D1F91C8;
	Thu, 20 Feb 2025 13:40:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F521F8BCC;
	Thu, 20 Feb 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058858; cv=none; b=q5NGkrj9IEYXWfaqyXiw5Y53myW3zuciR8q9ODMO2X5kX7Z3wOa01SALT1f2HAMc7kK/TaYmp/s7vcmVI+XTwaJVKuSiY9s/lIZ61dMBsPTPI2WV6zQKx6ZbzOTBgiJ92PuuXjL/8IJKEvdvx+A+HSz5p+FfM0JylE+1g1CFZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058858; c=relaxed/simple;
	bh=HfCNOkX/ICg8oeRV+sVzvq8QE4RgVzBR32UtK4AyFVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFTguZaojybLKTHcC3EsfL9pGIQfiqwyB7wQ9BBg5M049J1Byc7II7lX9V//KvCA+kcp0b9xyOd3WsrWpGwJvZUtfE/zhPXEKS6u4GeL6D5GgMscwfwHGejP6IRw7BSouE7kmN1ekyn4wqxybgKoNqM0PEectqoTQIUnaDGiQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39D7516F3;
	Thu, 20 Feb 2025 05:41:13 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEA093F5A1;
	Thu, 20 Feb 2025 05:40:50 -0800 (PST)
Date: Thu, 20 Feb 2025 13:40:48 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
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
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
Message-ID: <Z7cw4JTp3Hfx/4li@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>

On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
> Hi Reinette,
> 
> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> >
> > Hi Dave and Peter,
> >
> > On 2/19/25 6:09 AM, Peter Newman wrote:
> > > Hi Dave,
> > >
> > > On Wed, Feb 19, 2025 at 2:41 PM Dave Martin <Dave.Martin@arm.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On Wed, Jan 22, 2025 at 02:20:25PM -0600, Babu Moger wrote:
> > >>> Assign/unassign counters on resctrl group creation/deletion. Two counters
> > >>> are required per group, one for MBM total event and one for MBM local
> > >>> event.
> > >>>
> > >>> There are a limited number of counters available for assignment. If these
> > >>> counters are exhausted, the kernel will display the error message: "Out of
> > >>> MBM assignable counters". However, it is not necessary to fail the
> > >>> creation of a group due to assignment failures. Users have the flexibility
> > >>> to modify the assignments at a later time.
> > >>
> > >> If we are doing this, should turning mbm_cntr_assign mode on also
> > >> trigger auto-assingment for all extant monitoring groups?
> > >>
> > >> Either way though, this auto-assignment feels like a potential nuisance
> > >> for userspace.
> >
> > hmmm ... this auto-assignment was created with the goal to help userspace.
> > In mbm_cntr_assign mode the user will only see data when a counter is assigned
> > to an event. mbm_cntr_assign mode is selected as default on a system that
> > supports ABMC. Without auto assignment a user will thus see different
> > behavior when reading the monitoring events when the user switches to a kernel with
> > assignable counter support: Before assignable counter support events will have
> > data, with assignable counter support the events will not have data.
> >
> > I understood that interfaces should not behave differently when user space
> > switches kernels and that is what the auto assignment aims to solve.
> >
> > >>
> > >> If the userspace use-case requires too many monitoring groups for the
> > >> available counters, then the kernel will auto-assign counters to a
> > >> random subset of groups which may or may not be the ones that userspace
> > >> wanted to monitor; then userspace must manually look for the assigned
> > >> counters and unassign some of them before they can be assigned where
> > >> userspace actually wanted them.
> > >>
> > >> This is not impossible for userspace to cope with, but it feels
> > >> awkward.
> > >>
> > >> Is there a way to inhibit auto-assignment?
> > >>
> > >> Or could automatic assignments be considered somehow "weak", so that
> > >> new explicit assignments can steal automatically assigned counters
> > >> without the need to unassign them explicitly?
> > >
> > > We had an incomplete discussion about this early on[1]. I guess I
> > > didn't revisit it because I found it was trivial to add a flag that
> > > inhibits the assignment behavior during mkdir and had moved on to
> > > bigger issues.
> >
> > Could you please remind me how a user will set this flag?
> 
> Quoting my original suggestion[1]:
> 
>  "info/L3_MON/mbm_assign_on_mkdir?
> 
>   boolean (parsed with kstrtobool()), defaulting to true?"
> 
> After mount, any groups that got counters on creation would have to be
> cleaned up, but at least that can be done with forward progress once
> the flag is cleared.
> 
> I was able to live with that as long as there aren't users polling for
> resctrl to be mounted and immediately creating groups. For us, a
> single container manager service manages resctrl.
> 
> >
> > >
> > > If an agent creating directories isn't coordinated with the agent
> > > managing counters, a series of creating and destroying a group could
> > > prevent a monitor assignment from ever succeeding because it's not
> > > possible to atomically discover the name of the new directory that
> > > stole the previously-available counter and reassign it.
> > >
> > > However, if the counter-manager can get all the counters assigned once
> > > and only move them with atomic reassignments, it will become
> > > impossible to snatch them with a mkdir.
> > >
> >
> > You have many points that makes auto-assignment not be ideal but I
> > remain concerned that not doing something like this will break
> > existing users who are not as familiar with resctrl internals.
> 
> I agree auto-assignment should be the default. I just want an official
> way to turn it off.
> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com/
> 

+1

That's basically my position -- the auto-assignment feels like a
_potential_ nuisance for ABMC-aware users, but it depends on what they
are trying to do.  Migration of non-ABMC-aware users will be easier for
basic use cases if auto-assignment occurs by default (as in this
series).

Having an explicit way to turn this off seems perfectly reasonable
(and could be added later on, if not provided in this series).


What about the question re whether turning mbm_cntr_assign mode on
should trigger auto-assignment?

Currently turning this mode off and then on again has the effect of
removing all automatic assignments for extant groups.  This feels
surprising and/or unintentional (?)

Cheers
---Dave

