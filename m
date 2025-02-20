Return-Path: <linux-kernel+bounces-524428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE232A3E2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11D6166B29
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF108213E64;
	Thu, 20 Feb 2025 17:46:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602E213E60;
	Thu, 20 Feb 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073576; cv=none; b=pKO3wNSSU3Xlss9F+VBI8pBBraDFSlHLKjRqQ4LRkTTw0ckj4yWeFRCYPQnx8Tgx5TmsnTW/j15P4e052sJSnzJlZhGtRnUMJdt/1INEEzKHSD3qDILa+TI7koN54oDLUCgTNmT8b/ZGVORsVsAfx8581dH3ne1qBrUWvS1Nbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073576; c=relaxed/simple;
	bh=K8pF/ngKr2xu3Uv+T441vpPH49v2IpaOUXbkcMyrnao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkS5ia7ETgJCPU4ypckoQLU7VstyglFtCScKj4f9YxSlNaeZXTCN7CEnUNapKKfiFIgv7VRcMOB6a4ApTssyQppU7YCvObSj+E1JNYAFmhJHnUm7IHVP3ZE7ycbf7tOoxM4cvYi+RMfFMe/dThlL0XrCBLTa8it0Nvbz0WUvtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 812E116F3;
	Thu, 20 Feb 2025 09:46:31 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D8A3F5A1;
	Thu, 20 Feb 2025 09:46:08 -0800 (PST)
Date: Thu, 20 Feb 2025 17:46:06 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
	Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
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
Message-ID: <Z7dqXlOMsw7Kb8F2@e133380.arm.com>
References: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <Z7dccLOTPzySYTXL@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dccLOTPzySYTXL@e133380.arm.com>

Hi again,

On Thu, Feb 20, 2025 at 04:46:40PM +0000, Dave Martin wrote:
> Hi,
> 
> On Wed, Feb 19, 2025 at 09:56:29AM -0800, Reinette Chatre wrote:
> > Hi Peter,
> > 
> > On 2/19/25 3:28 AM, Peter Newman wrote:
> 
> [...]
> 
> > > In the letters as events model, choosing the events assigned to a
> > > group wouldn't be enough information, since we would want to control
> > > which events should share a counter and which should be counted by
> > > separate counters. I think the amount of information that would need
> > > to be encoded into mbm_assign_control to represent the level of
> > > configurability supported by hardware would quickly get out of hand.
> > > 
> > > Maybe as an example, one counter for all reads, one counter for all
> > > writes in ABMC would look like...
> > > 
> > > (L3_QOS_ABMC_CFG.BwType field names below)
> > > 
> > > (per domain)
> > > group 0:
> > >  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> > >  counter 1: VictimBW,LclNTWr,RmtNTWr
> > > group 1:
> > >  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> > >  counter 3: VictimBW,LclNTWr,RmtNTWr
> > > ...
> > > 
> > 
> > I think this may also be what Dave was heading towards in [2] but in that
> > example and above the counter configuration appears to be global. You do mention
> > "configurability supported by hardware" so I wonder if per-domain counter
> > configuration is a requirement?
> > 
> > Until now I viewed counter configuration separate from counter assignment,
> > similar to how AMD's counters can be configured via mbm_total_bytes_config and
> > mbm_local_bytes_config before they are assigned. That is still per-domain
> > counter configuration though, not per-counter.
> 
> I hadn't tried to work the design through in any detail: it wasn't
> intended as a suggestion for something we should definitely do right
> now; rather, it was just an incomplete sketch of one possible future
> evolution of the interface.
> 
> Either way these feel like future concerns, if the first iteration of
> ABMC is just to provide the basics so that ABMC hardware can implement
> resctrl without userspace seeing counters randomly stopping and
> resetting...
> 
> Peter, can you give a view on whether the ABMC as proposed in this series
> is a useful stepping-stone?  Or are there things that you need that you
> feel could not be added as a later extension without ABI breakage?
> 
> [...]
> 
> > > I believe that shared assignments will take care of all the
> > > high-frequency and performance-intensive batch configuration updates I
> > > was originally concerned about, so I no longer see much benefit in
> > > finding ways to textually encode all this information in a single file
jjjk> > > when it would be more manageable to distribute it around the
> > > filesystem hierarchy.
> > 
> > This is significant. The motivation for the single file was to support
> > the "high-frequency and performance-intensive" usage. Would "shared assignments"
> > not also depend on the same files that, if distributed, will require many
> > filesystem operations? 
> > Having the files distributed will be significantly simpler while also
> > avoiding the file size issue that Dave Martin exposed. 
> > 
> > Reinette
> 
> I still haven't fully understood the "shared assignments" proposal;
> I need to go back and look at it.

Having taken a quick look at that now, this all seems to duplicate
perf's design journey (again).

"rate" events make some sense.  The perf equivalent is to keep an
accumulated count of the amount of time a counter has been assigned to
an event, and another accumulated count of the events counted by the
counter during assignment.  Only userspace knows what it wants to do
with this information: perf exposes the raw accumulated counts.

Perf events can be also pinned so that they are prioritised for
assignment to counters; that sounds a lot like the regular, non-shared
resctrl counters.


Playing devil's advocate:

It does feel like we are doomed to reinvent perf if we go too far down
this road...

> If we split the file, it will be more closely aligned with the design
> of the rest of the resctrlfs interface.
> 
> OTOH, the current interface seems workable and I think the file size
> issue can be addressed without major re-engineering.
> 
> So, from my side, I would not consider the current interface design
> a blocker.

...so, drawing a hard line around the use cases that we intend to
address with this interface and avoiding feature creep seems desirable.

resctrlfs is already in the wild, so providing reasonable baseline
compatiblity with that interface for ABMC hardware is a sensible goal.
The current series does that.

But I wonder how much additional functionality we should really be
adding via the mbm_assign_control interface, once this series is
settled.

Cheers
---Dave

