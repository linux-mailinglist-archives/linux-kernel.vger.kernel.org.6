Return-Path: <linux-kernel+bounces-519374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA1A39C30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DDC188F792
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110E243388;
	Tue, 18 Feb 2025 12:30:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC023956B;
	Tue, 18 Feb 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881829; cv=none; b=erUwtPNeQRJijOMgRp2MePLHj665heaoT98KNx8lGrT3yBPXeAzk5pd6p3gDMk3IAvvzqaTFXQY9sjSnFPnSR7sGqNxv7qDs0xuo6vzT7tsBHwmxA9b4M8uGyQVLaGmGw7ZIpIT8qP4u0aoVAtopqwEgItHJs7ljlDDa5ey108U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881829; c=relaxed/simple;
	bh=50w9gD6DC9COZUV427hx8aS/EN3zeOLz8lNxNdJnek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtvVkldNqEigx6rnvQ/8MH4+j9v5S0KvEK/cVKdN1x8CQqkn9HjK2cyu3/v4/L4xdbhBJUSkOrd4wbxX6A1y40yhZJ31KyWpVpWyMVxjdk5y2vqyNRS6/fd47vi9HHNVxoH5VFRE5OQBr9foIAryTSXOzVj37Px0RKDLpReh+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FAC1152B;
	Tue, 18 Feb 2025 04:30:44 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBEAD3F59E;
	Tue, 18 Feb 2025 04:30:21 -0800 (PST)
Date: Tue, 18 Feb 2025 12:30:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Peter Newman <peternewman@google.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
Message-ID: <Z7R9VedhOSp64W7X@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>

On Mon, Feb 17, 2025 at 10:45:29AM -0600, Moger, Babu wrote:
> Hi All,
> 
> On 2/17/25 04:26, Peter Newman wrote:
> > Hi Reinette,
> > 
> > On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Babu,
> >>
> >> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
> >>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>
> >> (quoting relevant parts with goal to focus discussion on new possible syntax)
> >>
> >>>>>> I see the support for MPAM events distinct from the support of assignable counters.
> >>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
> >>>>>> Please help me understand if you see it differently.
> >>>>>>
> >>>>>> Doing so would need to come up with alphabetical letters for these events,
> >>>>>> which seems to be needed for your proposal also? If we use possible flags of:
> >>>>>>
> >>>>>> mbm_local_read_bytes a
> >>>>>> mbm_local_write_bytes b
> >>>>>>
> >>>>>> Then mbm_assign_control can be used as:
> >>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> >>>>>> <value>
> >>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>
> >>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
> >>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
> >>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
> >>
> >> As mentioned above, one possible issue with existing interface is that
> >> it is limited to 26 events (assuming only lower case letters are used). The limit
> >> is low enough to be of concern.
> > 
> > The events which can be monitored by a single counter on ABMC and MPAM
> > so far are combinable, so 26 counters per group today means it limits
> > breaking down MBM traffic for each group 26 ways. If a user complained
> > that a 26-way breakdown of a group's MBM traffic was limiting their
> > investigation, I would question whether they know what they're looking
> > for.
> 
> Based on the discussion so far, it felt like it is not a group level
> breakdown. It is kind of global level breakdown. I could be wrong here.
> 
> My understanding so far, MPAM has a number of global counters. It can be
> assigned to any domain in the system and monitor events.
> 
> They also have a way to configure the events (read, write or both).
> 
> Both these feature are inline with current resctrl implementation and can
> be easily adapted.
> 
> One thing I am not clear why MPAM implementation plans to create separate
> files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
> events. We already have files in each group to read the events.
> 
> # ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
> total 0
> -r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
> -r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes


To be clear, we have no current plan to do this from the Arm side.

My sketch was just a thought experiment to test whether we would have
difficulties _if_ a decision were made to extend the interface in that
direction.

But it looks OK to me: the interface proposed in this series seems to
leave enough possibilities for extension open that we could do
something like what I described later in if we decide to.


Overall, the interface proposed in this series seems a reasonable way
to support ABMC systems while keeping the consumer-side interface
(i.e., reading the mbm_total_bytes files etc.) as similar to the
classic / Intel RDT situation as possible.

MPAM can fit in with this approach, as demonstrated by James' past
branches porting the MPAM driver on top of previous versions of the
ABMC series.

As I understand it, he's almost done with porting onto this v11,
with no significant issues.

Cheers
---Dave

