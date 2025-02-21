Return-Path: <linux-kernel+bounces-526323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83BCA3FD41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50651706710
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3D24E4A2;
	Fri, 21 Feb 2025 17:14:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498C24CED2;
	Fri, 21 Feb 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158085; cv=none; b=Qo7COE8D0ras3GpXRhwHxjI7zNWqn2CeeShncWJCTye4x0obLDklmiQg6So2JFeFlzj+L+RBiFLWldagTGd/SIkUkrs5CYh/IL2QprkoQXMrXAdn11MpGl/S1KO70BhKNf0kEyEon20jBSVEWseHrwND7rArnaYl6NgeGNSlZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158085; c=relaxed/simple;
	bh=h9885pvKDZGby9aBH7gp4Ywh3BHGtvtlKGQHhiyxVPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfkFppOs6mh14174/mXT29W9Ve5KwlybsjKyjBXxEAO+Z93ueBthSJUe5DMTdxecnFXr+JOIvvwBSqbkiWmvYuP/c2xnEQJdyOfE5csc5cQqQleZCUXwmY7wa4KhAxjWkKeUYhL9d+Kfti54sx1wueJOxRcpLrHY3aXX2Xd0WIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3452B168F;
	Fri, 21 Feb 2025 09:15:00 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC15C3F5A1;
	Fri, 21 Feb 2025 09:14:37 -0800 (PST)
Date: Fri, 21 Feb 2025 17:14:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
Message-ID: <Z7i0etOZcZ9jM/ZU@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
 <Z7cw4JTp3Hfx/4li@e133380.arm.com>
 <2889da50-b654-403c-910e-13b9144596fd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2889da50-b654-403c-910e-13b9144596fd@intel.com>

Hi,

On Thu, Feb 20, 2025 at 09:08:17AM -0800, Reinette Chatre wrote:
> Hi Dave,
> 
> On 2/20/25 5:40 AM, Dave Martin wrote:
> > On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
> >> Hi Reinette,
> >>
> >> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
> >> <reinette.chatre@intel.com> wrote:

[...]

> >>> Could you please remind me how a user will set this flag?
> >>
> >> Quoting my original suggestion[1]:
> >>
> >>  "info/L3_MON/mbm_assign_on_mkdir?
> >>
> >>   boolean (parsed with kstrtobool()), defaulting to true?"
> >>
> >> After mount, any groups that got counters on creation would have to be
> >> cleaned up, but at least that can be done with forward progress once
> >> the flag is cleared.
> >>
> >> I was able to live with that as long as there aren't users polling for
> >> resctrl to be mounted and immediately creating groups. For us, a
> >> single container manager service manages resctrl.

[...]

> > +1
> > 
> > That's basically my position -- the auto-assignment feels like a
> > _potential_ nuisance for ABMC-aware users, but it depends on what they
> > are trying to do.  Migration of non-ABMC-aware users will be easier for
> > basic use cases if auto-assignment occurs by default (as in this
> > series).
> > 
> > Having an explicit way to turn this off seems perfectly reasonable
> > (and could be added later on, if not provided in this series).
> > 
> > 
> > What about the question re whether turning mbm_cntr_assign mode on
> > should trigger auto-assignment?
> > 
> > Currently turning this mode off and then on again has the effect of
> > removing all automatic assignments for extant groups.  This feels
> > surprising and/or unintentional (?)
> 
> Connecting to what you start off by saying I also see auto-assignment
> as the way to provide a smooth transition for "non-ABMC-aware" users.

I agree, and having this on by default also helps non-ABMC-aware users.

> To me a user that turns this mode off and then on again can be
> considered as a user that is "ABMC-aware" and turning it "off and then
> on again" seems like an intuitive way to get to a "clean slate"
> wrt counter assignments. This may also be a convenient way for
> an "ABMC-aware" user space to unassign all counters and thus also
> helpful if resctrl supports the flag that Peter proposed. The flag
> seems to already keep something like this in its context with
> a name of "mbm_assign_on_mkdir" that could be interpreted as
> "only auto assign on mkdir"?

Yes, that's reasonable.  It could be a good idea to document this
behaviour of switching the mbm_cntr_assign mode, if we think it is
useful and people are likely to rely on it.

Since mkdir is an implementation detail of the resctrl interface, I'd
be tempted to go for a more generic name, say,
"mbm_assign_new_mon_groups".  But that's just bikeshedding.
The proposed behaviour seems fine.

Either way, if this is not included in this series, it could be added
later without breaking anything.


> I am not taking a stand for one or the other approach but instead
> trying to be more specific about pros/cons. Could you please provide
> more insight in the use case you have in mind so that we can see how
> resctrl could behave with few surprises? 
> 
> Reinette

I don't have a strong view either.

I don't have a concrete use case here -- I was just trying to imagine
the experience of an ABMC-aware user who wants full control over what
counters get assigned.

I agree that the convenience of the non-ABMC-aware user should probably
take priority over that of the ABMC-aware user, at least in situations
where the expected behaviour is achievable (i.e., where we didn't run
out of counters to auto-assign.)

Cheers
---Dave

