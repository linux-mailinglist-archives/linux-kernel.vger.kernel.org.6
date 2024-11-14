Return-Path: <linux-kernel+bounces-409103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1C9C8785
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699FD1F22E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64D1FF05E;
	Thu, 14 Nov 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kq/4ZjEj"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139041FCC68
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579521; cv=none; b=JdQYFRckePTnZ11bqA+usliRdZKKG0zbvhzmm1u2VHiGR3Zg2cY1Srh0BuCHTSCl6XF5bqHOFFUsIOM/F4Jd6xAR1jddxQCBUohGlBbhDIxZzNO3++iohqAy7GYn6jSBrmxhFW4HiKUvy8mFO/L0f26w9dPs4HExNrEsK65cOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579521; c=relaxed/simple;
	bh=0E1kcVEFD4VWCMB4QvTWrSq4iWERYvv0lkn2hwk5mUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ep0N6YvNlqRFtTEnrzh0U94n6Jj9dGTPFghh0wHCYMXyaoB1y0x/WFpSGDD99402Ug8KzzaE37I+zr4R9BllFypSb0tGBmLG5ufrf9/UATdyahH8m25DWtHkFhtcV87u6NZxPiDbg1BDlXImNXp8uoRK7AcWJoWEpeeINLZCEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kq/4ZjEj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so684736a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731579517; x=1732184317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KdwgmM8hsE4mUoUVmE15NjoaxAfwU+DCEkdo18P2dA=;
        b=Kq/4ZjEjajy8Wqyv1eUZ/f0Y55PNIeMWYTd+Nveg+Ey40y20+Y1CukIgYGel7VB3La
         kM1eZOO6Qrs8IKc0vwtlX6QZyZ8Ce+rylf54PwKfuZB9mdleIeYe+cFLvS+te+Vjjn4i
         0vXliwN2eP+zUn+3P4+VTi9CHaCG+CzSFEqkukiU8IsbmW/01UVZhr6SHYP0YrjfxmoY
         g1yM/Qzgau/KeuHHWHhy1U3uklVGro+DRr9gjYPZJG0N4hCOKJmMcmuF/rSLOBbPRq5z
         lH+kSZhdGcsgtNJxxkEdn32rJ0eWRgbeuO8myBaCzmDlSE0ropWanmMtVPkLgr6gweW+
         PX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731579517; x=1732184317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KdwgmM8hsE4mUoUVmE15NjoaxAfwU+DCEkdo18P2dA=;
        b=RTmSbkzWtqLXIpI+760PhRa4fQcrf7poQyBMHg+yR7/rRiuFjEA81ej+b3bnVzvGLP
         x5W+UdDzILcbvWO1mnAIPBgQ4sFVCCplA1C06jkB7bV7Y7RaAG0LoSfZnXM3zYp6i0GJ
         lC+IsVd6yHdfzvdjGxlcUzRirywO+CKo5lcfxxOKy9uNUBSl7E1d3+jvaPneGRXVs7hq
         sn1FaQXOEC63clrZIwv8vxFK/nMYnzwFlFmykUvWVQ3+JHhpsCMImbBCyZkcVnqyDJ0+
         vY7JynAxbjY+rIcLFtL3SsuR4Oii/RLfvjDLGCuiIOrTxVO/85s+TFcct4jR6LdB7PU/
         Q5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvxTKnb8aatTgfVbU5ExtqQPh6h5oa6eEmhz9H4qTjM/UNFkfgoK3AYZZt2KL/z+gKxWznF7LCusxnMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeQbqJeLzFHP81GGPo7dsAuUcQe68q3xlt3hhtprBWYORHrrx
	sUjSFlv4n3lRyHa8sAYuym+YePtOuVSO6RQKg85fqpUadt21BZW+k62V1O7S8SKgaCmoKabOh4z
	i4zXjUbHRYQ2wOm6Oo1TlkgiZHOP9tSvLDAtV
X-Google-Smtp-Source: AGHT+IFCV7/p3rK6y51DBH/g9xmjGIjRKPjlfBWoB3kFVp/oGSEf6skpsQ4uXm4PudKy4KIe9WMlYsNsKHqFY/n3bk8=
X-Received: by 2002:a05:6402:2689:b0:5ce:bb32:ccac with SMTP id
 4fb4d7f45d1cf-5cf77ed3cc7mr1224956a12.26.1731579517134; Thu, 14 Nov 2024
 02:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com> <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <34fd8713-3430-4e27-a2c2-fd8839f90f5a@intel.com> <CALPaoCjCWZ4ZYfwooFEzMn15jJM7s9Rfq83YhorOGUD=1GdSyw@mail.gmail.com>
 <7ee63634-3b55-4427-8283-8e3d38105f41@intel.com>
In-Reply-To: <7ee63634-3b55-4427-8283-8e3d38105f41@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 14 Nov 2024 11:18:26 +0100
Message-ID: <CALPaoCgpnVORZfbKVLXDFUZvv8jhpShHPzB3cwdLTZQH1o9ULw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter reads
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, eranian@google.com, hpa@zytor.com, 
	james.morse@arm.com, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	nert.pinx@gmail.com, tan.shaopeng@fujitsu.com, tglx@linutronix.de, 
	tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Thu, Nov 14, 2024 at 6:40=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 11/13/24 5:28 AM, Peter Newman wrote:
> > On Thu, Nov 7, 2024 at 8:15=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 11/7/24 6:26 AM, Peter Newman wrote:
> >>> On Thu, Nov 7, 2024 at 12:01=E2=80=AFPM Peter Newman <peternewman@goo=
gle.com> wrote:
> >>>>
> >
> >>>> Tony had prototyped an MBM rate event[1], which cached a MBps value
> >>>> per group/domain produced by the overflow workers. If the workers
> >>>> produce the mbps samples immediately after directly reading the
> >>>> counters, then this should be the best case in terms of precision an=
d
> >>>> introduce very little additional system overhead. Also, userspace
> >>>> reading a rate sample that's 1 second old would be a lot less harmfu=
l
> >>>> than performing an MBps calculation from a count sample that's 1
> >>>> second old.
> >>
> >> I looked at that implementation. Please do note that the implementatio=
n
> >> appears to be a PoC that does not handle the corner cases where issues=
 may
> >> arise. For example, when it reads the event values in the overflow han=
dler
> >> the rate is updated even if there was an error during the counter read=
.
> >> The moment a counter read encounters an error it impacts the measured
> >> rate so this will need more thought.
> >>
> >>>> Perhaps combining the per-second bandwidth rate cache with a
> >>>> per-domain file for each MBM event to aggregate the data for all
> >>>> groups will be the optimally-performing solution?
> >>
> >> I do not see a problem with exposing a per-domain file for each MBM ev=
ent
> >> that aggregates the data of all groups. For best accuracy I expect tha=
t
> >> this file will be created on demand, querying hardware counters at the=
 time
> >> user space makes the request. This may indeed result in output like be=
low
> >> (naming used is just a sample for this discussion):
> >>
> >>          # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes=
_01
> >>            <rdtgroup nameA> <MBM total count>
> >>            <rdtgroup nameB> <MBM total count>
> >>            <rdtgroup nameC> Error
> >>            <rdtgroup nameD> Unavailable
> >>            <rdtgroup nameE> Unassigned
> >>            ...
> >>
> >> As I understand from your earlier description this essentially moves t=
he
> >> counter reading work from a user space thread to the kernel. There are
> >> options to do this work, most disruptive can be done with a
> >> smp_call_function_any() to read all the domain's counters from a CPU
> >> in the domain without any preemption, less disruptive can be done
> >> with smp_call_on_cpu(). Some cond_resched() could be included if
> >> the number of events needing to be read starts impacting other parts o=
f
> >> the kernel. You already indicated that reading the counters from user =
space
> >> takes 488usec, which is very far from what will trigger the softlockup
> >> detector though.
> >>
> >>> Factoring ABMC into this, we'd have to decide the interval at which
> >>> we're comfortable with cycling the available event counters through
> >>> the group list in order to get valid MBps samples for every group
> >>> often enough.
> >>>
> >>> A counter will have to stay assigned long enough to get two valid
> >>> counts before an MBps value can be reported. If the regular MBps
> >>> samples is what we want, maybe we just want a mode where the overflow
> >>> workers would also drive the counter assignments too in order to
> >>> produce regular samples from all groups.
> >>
> >> The assignable counter implementation currently depends on user space
> >> assigning counters. In this design the events that do not have counter=
s
> >> assigned return "Unassigned". The "rate" value can also return
> >> "Unassigned" in this existing design. "Unassigned" is one scenario tha=
t
> >> needs to be handled, there is also hardware errors and MSR returning
> >> "Unavailable".
> >>
> >> We can surely consider a new mode that does not allow user space to as=
sign
> >> counters but instead lets resctrl manage counter assignments to suppor=
t
> >> rate events when assignable counters are supported.
> >>
> >> I see a couple of features being discussed in parallel:
> >> - A new per-domain file for each MBM event that aggregates the data of=
 all groups.
> >> - A new "rate" event built on top of user assigned counters.
> >> - A new "rate" event built on top of resctrl assigned counters.
> >>
> >> Which best support the use case you have in mind?
> >
> > After discussing with my users, it sounds like "all of the above".
> >
> > They like the idea of resctrl automatically dealing with counter
> > assignments for them, but they would also like to retain enough
> > control to provide higher resolution data for groups that concern them
> > more. The auto-assignment is nice in that they would get reliable
> > bandwidth numbers on AMD with very little development effort and the
> > assigning work will be done very efficiently, but eventually they will
> > want more control.
>
> It is not obvious to me what the expectations/assumptions are regarding
> efficiency. One efficiency benefit I can think of is related to what you
> suggested earlier where it is the overflow handler that can do the assign=
ment.
> By doing so resctrl can ensure counters are assigned at edges of time ran=
ge being
> measured by overflow handler.

I'm mainly concerned about the cost of sending IPIs numbering in the
thousands around the system to update the counters in every domain.
The overflow handlers are already local to their domains, so they can
drive all the necessary register updates directly.

>
> "eventually they will want more control" sounds like there are more requi=
rements
> that we need to be made aware of and makes me hesitant to add complicated
> automation for nothing.
>
> > They also asked whether they would be able to switch between
> > resctrl-assigned and user-assigned at runtime. I think the importance
> > of this would depend on how efficient the mbm_assign_control interface
> > ends up being. If it will necessarily result in floods of IPIs when
> > cycling counters on a large system, they will be eager to not use it
> > whenever they can avoid it.
>
> It could be possible to use both (resctrl-assigned and user-assigned)
> at the same time. For example, mbm_assign_control could use flag to indic=
ate
> which event needs to be counted and whether counter can be shared or not.
> For example, we already have "t" for dedicated "MBM total", and there
> could theoretically by "T" for shared "MBM total". A very basic
> solution could be for "T" counters to be assigned for two runs
> of the overflow handler and then round-robin to the next group of
> "T" counters.

This sounds promising, since it would cut down on the number of
routine counter-reassignments userspace would need to drive. The
counter-updating traffic could then be focused on the problematic
groups which we hope will be small in number.

>
> There are some sharp corners when implementing something like this.
> Tony already pointed out one scenario where reading a "shared counter"
> monitor group's mbm_local_bytes/mbm_total_bytes
> becomes unreliable due to counter being reset at each re-assignment.
>
> On the more complicated side resctrl could perhaps learn more about
> how perf multiplexes the limited PMC.
>
> I do think this will be an enhancement of existing counter assignment
> that Babu is working on and I do not know how much your users know
> about it or experimented with it. You already mentioned that the
> users would want more control so it may be most flexible
> to leave counter assignment to user space with the planned
> mbm_assign_control interface?

Yes, it's an acceptable interface.

>
> > The rate assignment events are easier to deal with because they can
> > simply be retrieved from memory without the caller needing to worry
> > about what domain they're reading from, so I don't believe we will
> > ever want to deal with cached count values paired with timestamps. On
> > systems with assignable counters, I don't know how much of a problem
> > the varying update rate will be. The aggregation files reading from
> > memory are cheap to poll every second, so I don't know how big of an
> > issue it is for most of the groups to report some sort of N/A-value
> > for bandwidth most of the time. They won't have any difficulty
> > remembering how long ago they last saw a valid mbps value because
> > they're already histogramming all the metrics they watch.
>
> This part seems most related to issue at hand. I understand that
> an aggregate file with rate data is most ideal. You snipped my question
> whether reading individual counters are required but thinking about this
> more it may indeed also be useful to have a per monitor group rate file
> containing the rate of that monitor group.

Yes, it should be no trouble to implement the per-group rate files.

>
> Would existing struct mbm_state.prev_bw be sufficient as a rate exposed t=
o user
> space? At this time it is only computed for consumption by the software c=
ontroller
> but we can explore calling mbm_bw_count() at every iteration of the overf=
low
> handler irrespective of software controller.
> Please note two things:
> - Tony is already adding enhancement for bandwidth to be computed for tot=
al as well as
>   local MBM bandwidth ([2])
> - Computing running bandwidth irrespective of software controller will ne=
ed mbm_bw_count()
>   to be more robust since it (as Tony highligted in [1]) assumes that
>   the preceding counter read always succeeds.

Yes, I had applied Tony's last series and prototyped interfaces for
reporting the mbm_state.prev_bw values to user space. It seemed to
work well.

Thanks!
-Peter


> [1] https://lore.kernel.org/all/ZzUvA2XE01U25A38@agluck-desk3/
> [2] https://lore.kernel.org/all/20241029172832.93963-3-tony.luck@intel.co=
m/
>

