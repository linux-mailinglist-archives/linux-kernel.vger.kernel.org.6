Return-Path: <linux-kernel+bounces-526249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8281A3FC21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD8188BE15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514B1F4E38;
	Fri, 21 Feb 2025 16:47:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407251E9905;
	Fri, 21 Feb 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156463; cv=none; b=kq9zkhUa60+R9usAn9c03SDjRKtB6bxTOcgmA85WPAVbMmexnP4mcWsbmo7Q6TBdFHtsDSq171s+F4c1xClb6gL8H2WFJ+N75VJ2gE7r4Zra6dwn9pRpguiw1oIIB3Rg1FfvC3ZSeG+5uBENjJNBdykxMuMo4V3SekxanKbmnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156463; c=relaxed/simple;
	bh=hjZm/lTADPa3gditXKyT4WjZDJVx/vyCEtcp7LAsrGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW5BL6BkpQylRymDI788ORYZgK8lGQ1Uppja40yCzGOwULmFoshto7zUh2XoQnAE3lOWCkJUMpbHDKo8hDYxt2FFPNlXp0cjkAHZU33NBIJWeu5R3eMIWcf1/8KcBaCWVDPCsdkELXl5OtwdmhUwagKYYNmmiq8TjoL1IErkrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAD2168F;
	Fri, 21 Feb 2025 08:47:57 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EDB13F5A1;
	Fri, 21 Feb 2025 08:47:36 -0800 (PST)
Date: Fri, 21 Feb 2025 16:47:33 +0000
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
Message-ID: <Z7iuJdfgYNCeytJE@e133380.arm.com>
References: <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <Z7dccLOTPzySYTXL@e133380.arm.com>
 <Z7dqXlOMsw7Kb8F2@e133380.arm.com>
 <eb435a64-70d4-4821-908d-686243fec7a6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb435a64-70d4-4821-908d-686243fec7a6@intel.com>

Hi Reinette,

On Thu, Feb 20, 2025 at 10:36:18AM -0800, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/20/25 9:46 AM, Dave Martin wrote:
> > Hi again,
> > 
> > On Thu, Feb 20, 2025 at 04:46:40PM +0000, Dave Martin wrote:

[...]

> > Having taken a quick look at that now, this all seems to duplicate
> > perf's design journey (again).
> > 
> > "rate" events make some sense.  The perf equivalent is to keep an
> > accumulated count of the amount of time a counter has been assigned to
> > an event, and another accumulated count of the events counted by the
> > counter during assignment.  Only userspace knows what it wants to do
> > with this information: perf exposes the raw accumulated counts.
> > 
> > Perf events can be also pinned so that they are prioritised for
> > assignment to counters; that sounds a lot like the regular, non-shared
> > resctrl counters.
> > 
> > 
> > Playing devil's advocate:
> > 
> > It does feel like we are doomed to reinvent perf if we go too far down
> > this road...
> > 
> >> If we split the file, it will be more closely aligned with the design
> >> of the rest of the resctrlfs interface.
> >>
> >> OTOH, the current interface seems workable and I think the file size
> >> issue can be addressed without major re-engineering.
> >>
> >> So, from my side, I would not consider the current interface design
> >> a blocker.
> > 
> > ...so, drawing a hard line around the use cases that we intend to
> > address with this interface and avoiding feature creep seems desirable.
> 
> This is exactly what I am trying to do ... to understand what use cases
> the interface is expected to support.
> 
> You have mentioned a couple of times now that this interface is sufficient but
> at the same time you hinted at some features from MPAM that I do not see
> possible to accommodate with this interface.

It's kind of both.

I think the interface is sufficient to be useful, and therefore has
value.

The problem being addressed here (shortage of counters) is fully
relevant to MPAM (at last on some hardware).

Any architecture may define new metrics and types of event that can be
counted, and they're not going to match up exactly between arches -- so
I don't think we can expect everything to fit perfectly within a
generic interface.  But having a generic interface is still useful for
making common features convenient to use.

So the interface is useful but not universal, but that doesn't feel
like a bug.

Hopefully that makes my position a bit clearer.

> > resctrlfs is already in the wild, so providing reasonable baseline
> > compatiblity with that interface for ABMC hardware is a sensible goal.
> > The current series does that.
> > 
> > But I wonder how much additional functionality we should really be
> > adding via the mbm_assign_control interface, once this series is
> > settled.
> 
> Are you speculating that MPAM counters may not make use of this interface?
> 
> Reinette

No, I think it makes sense for MPAM to follow this interface, as least
as far as what has been proposed so far here.

I think James got his updated rebase working. [1]


perf support would be for the future if we do it, but the ABMC
interface may be a useful starting point anyway, because it allows
counters to be assigned explicitly -- that provides a natural way to
hand over some counters to perf, either because that interface may be a
more natural fit for what the user is trying to do, or perhaps to count
weird, platform-specific event types that do not merit the effort of
integration into resctrlfs proper.

Does that make sense?

Cheers
---Dave

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/abmc/v11

