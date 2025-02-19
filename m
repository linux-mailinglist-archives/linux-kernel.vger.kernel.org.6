Return-Path: <linux-kernel+bounces-521485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E4A3BDFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B11618BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538891DFE36;
	Wed, 19 Feb 2025 12:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B8F1DE2DA;
	Wed, 19 Feb 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968003; cv=none; b=IpPTUJZyIQRoK0vCSXQwRRh29IEhu6aBXae4MAVknBsVxIU/CrqFC92181FjGkV1VKd6egCtIZG4Q6RY65nIfhcIaR2Xx+nUpc2NvIHjeWDhD4Gunp21PCp6WWvzvp80Ivfn6jS5yYWf0mtiBcJVq/ewSEeF9vbA6dqj5nuFF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968003; c=relaxed/simple;
	bh=wKWQbnzY5lHPIE77gLaiE7Yx+5qWZmbyNDaFreqyVRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMV82+ECICwk1nWae75g0svBx4Y1rAAIR3aOPXsppntUL4mmd2+zIbcD+RRahUZlIc2T/oiGRsOL25RoEqQIuPMvifzG3e2e5R/OnfcRE8fStflz/i6HaDtJPd5JVAkt3BrZGfyKNy1HyzS2lXhlPEgMJWPJRWmr8tsGj06Qi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91ACB1682;
	Wed, 19 Feb 2025 04:26:59 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376973F6A8;
	Wed, 19 Feb 2025 04:26:37 -0800 (PST)
Date: Wed, 19 Feb 2025 12:26:34 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	"Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
Message-ID: <Z7XN+iO10LnuoENO@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>

Hi,

On Wed, Feb 19, 2025 at 12:28:16PM +0100, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> >
> > Hi Peter,
> >
> > On 2/17/25 2:26 AM, Peter Newman wrote:
> > > Hi Reinette,
> > >
> > > On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
> > > <reinette.chatre@intel.com> wrote:

[...]

> > >> As mentioned above, one possible issue with existing interface is that
> > >> it is limited to 26 events (assuming only lower case letters are used). The limit
> > >> is low enough to be of concern.
> > >
> > > The events which can be monitored by a single counter on ABMC and MPAM
> > > so far are combinable, so 26 counters per group today means it limits
> > > breaking down MBM traffic for each group 26 ways. If a user complained
> > > that a 26-way breakdown of a group's MBM traffic was limiting their
> > > investigation, I would question whether they know what they're looking
> > > for.
> >
> > The key here is "so far" as well as the focus on MBM only.
> >
> > It is impossible for me to predict what we will see in a couple of years
> > from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
> > to support their users. Just looking at the Intel RDT spec the event register
> > has space for 32 events for each "CPU agent" resource. That does not take into
> > account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
> > that he is working on patches [1] that will add new events and shared the idea
> > that we may be trending to support "perf" like events associated with RMID. I
> > expect AMD PQoS and Arm MPAM to provide related enhancements to support their
> > customers.
> > This all makes me think that resctrl should be ready to support more events than 26.
> 
> I was thinking of the letters as representing a reusable, user-defined
> event-set for applying to a single counter rather than as individual
> events, since MPAM and ABMC allow us to choose the set of events each
> one counts. Wherever we define the letters, we could use more symbolic
> event names.
> 
> In the letters as events model, choosing the events assigned to a
> group wouldn't be enough information, since we would want to control
> which events should share a counter and which should be counted by
> separate counters. I think the amount of information that would need
> to be encoded into mbm_assign_control to represent the level of
> configurability supported by hardware would quickly get out of hand.
> 
> Maybe as an example, one counter for all reads, one counter for all
> writes in ABMC would look like...
> 
> (L3_QOS_ABMC_CFG.BwType field names below)
> 
> (per domain)
> group 0:
>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>  counter 1: VictimBW,LclNTWr,RmtNTWr
> group 1:
>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>  counter 3: VictimBW,LclNTWr,RmtNTWr
> ...
> 
> I assume packing all of this info for a group's desired counter
> configuration into a single line (with 32 domains per line on many
> dual-socket AMD configurations I see) would be difficult to look at,
> even if we could settle on a single letter to represent each
> universally.
> 
> >
> > My goal is for resctrl to have a user interface that can as much as possible
> > be ready for whatever may be required from it years down the line. Of course,
> > I may be wrong and resctrl would never need to support more than 26 events per
> > resource (*). The risk is that resctrl *may* need to support more than 26 events
> > and how could resctrl support that?
> >
> > What is the risk of supporting more than 26 events? As I highlighted earlier
> > the interface I used as demonstration may become unwieldy to parse on a system
> > with many domains that supports many events. This is a concern for me. Any suggestions
> > will be appreciated, especially from you since I know that you are very familiar with
> > issues related to large scale use of resctrl interfaces.
> 
> It's mainly just the unwieldiness of all the information in one file.
> It's already at the limit of what I can visually look through.
> 
> I believe that shared assignments will take care of all the
> high-frequency and performance-intensive batch configuration updates I
> was originally concerned about, so I no longer see much benefit in
> finding ways to textually encode all this information in a single file
> when it would be more manageable to distribute it around the
> filesystem hierarchy.
> 
> -Peter

This was sort of what I had in my mind.

I think it may make some sense to support "t" and "l" out of the box,
as intuitively backwards-compatible event names, but provide a way to
create new "letters" as needed, with well-defined way (customisable or
not) of mapping these to event names visible in resctrlfs.  I just used
the digits for this purpose, but we could have an explicit interface
for it.

In order for this series to stabilise though, does it make sense to put
this out of scope just for now?

The current series provides a way to provide the mbm_total_bytes and
mbm_local_bytes counters on AMBC and MPAM systems, without having to
limit the total number of monitoring groups (MPAM's current approach)
or overcommit the counters so that they may not be continuously
reliable when there are too many groups (AMD?).

That seems immediately useful.

The ability to assign arbitrarily many counters to a group is a new
feature however.  Does it make sense to consider this on its own merits
when the baseline ABMC interface has been settled?

May main concern right now (from the Arm side) is to be confident that
the initial ABMC interface definition doesn't paint us into a corner.

Cheers
---Dave

