Return-Path: <linux-kernel+bounces-273012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC494635F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76EAB227DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617BE1547C8;
	Fri,  2 Aug 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TifqShLy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9501ABED8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624595; cv=none; b=tAvjp1MjAim5GKNhsOFBHQUlAaq2Q9ioBzwRu2p9C1N4v4F+eLiEzA9hQiYnEB6OlpwOgIbWtHUnUykbYnGQGMSlWPC6h8SCfRXABCDsf+eAvhX5CoVXogM7Qfxk/xL2L+TS6rI6LZ2rHxT3OrKaH6tzSUjjljDlmEplSThuQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624595; c=relaxed/simple;
	bh=Fq0xg6OeFDEmNgVxfyseIYXMIF20Yx7PXhFYUn/7XJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TshgB2WQ1PSdYoBeQlOHaR5AkuiDCN6yaZPKCsoPNxiKIi4RbqMgpermZa7YyYD9/rGvLgNML8TAN4JDITrGQ50yJy32lehQ+lDOq4kmIZ0pnbPNKhub8C6zHKV5wR9DPeSlU+74XLueNY5juarhrZIvbsto2HSWEe/x780fTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TifqShLy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso64850a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624592; x=1723229392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sp5ks/WFuQwJ2HLCLHxS9cwlThA7cVHKDAtGYwmkkA=;
        b=TifqShLyFrvXaEdxasFfr2LlvYc5yBqVN7EqGh9V/bqbuHNM7gfxhJWk3gREnBd0eT
         XxgGHGydTlguFW/FzqekhPF+dtd9qq+OfbHCYL8TcPkzCQOPHkeJknWf5kuPpCb5+XRm
         VQzkCmBAAQee9h9jDipNef+P462SwLi3PMAMn7X4bd+TKqoeV56pLxlFg8s5Qru3zM2f
         ylV8ItZmRpmXrjD4c9cCRpkB8y6Yt9/NR2js7Y/9Oq6z/T86lw1zZsQnRLt+PpVeEhVN
         TD8YyLL96HpBG8ArsAfjQDQSwLI75BNs63RDOTkkt168rjZuntL0ZMKj6NqHy8yAjTBG
         IP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624592; x=1723229392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sp5ks/WFuQwJ2HLCLHxS9cwlThA7cVHKDAtGYwmkkA=;
        b=Q4Sbqp/ThGS8aZzrUMn6E1Kis8DEI+LEhaqXmIotUa9kMb1INTeTws3dy2eA0WuFQJ
         3f8bR3VH02xiMk6jkESUida4badW4y+t16Y+LaRfeBDFXGuNbf1XPAy5QZ1RIrypGU2L
         s71I1pNXaUGPfW8msyLsaRXYS/yshxsVgoL5xBNHcE4/3pES5rCu6aqxhmjdkkcq6Hw1
         HIlj0QWIBKi4lIDxvhrG/PJJthJZZduLk5/NpTE2Qp18LAc4w5B8G58DotQRd4lkoI8h
         OEHjVTE4/aVj+K9Hpg0r2+5pNo+0hQ47+qRT6aN2pPJaOOx2V3sP/DpjrQnwYgIfEoGq
         preg==
X-Forwarded-Encrypted: i=1; AJvYcCURbO27D0eo+XwWf7n09Lagf9lCeVDXwElT+Jo9xwngeiTxdNqB2aLryDwIhNH6nTM/yRK+UkguIZYAcZDZ+FO3EJO6wfdFoJYGAsSK
X-Gm-Message-State: AOJu0YzoAnIQ8NIScSLHTaZM+Dx0cTsOdwHMr2A4NihD3RIxhcrLgo/Q
	gO1irlu2+7W3KxwsBLSQDA7Mq5MCLS07itNtXN3tOHMgbkBO1bPdt12HNRkjLktP/BzItiRj6Mo
	J9Sd4BF1J6JLNT2VvkfrAKQ2bD7PvFV/4OqhY
X-Google-Smtp-Source: AGHT+IGkkKCZcYnTuED+S1wjIkgbC/INxnGmNu5mbLZjftSm/T3hXcOjwHxa+JSHliyugk7c29QRNNKWEqA9kXg0MgQ=
X-Received: by 2002:a05:6402:34c9:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b99b44f5ffmr7734a12.1.1722624591267; Fri, 02 Aug 2024 11:49:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720043311.git.babu.moger@amd.com> <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com> <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com> <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
In-Reply-To: <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 2 Aug 2024 11:49:40 -0700
Message-ID: <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Fri, Aug 2, 2024 at 9:14=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 8/1/24 3:45 PM, Peter Newman wrote:
> > On Thu, Aug 1, 2024 at 2:50=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 7/17/24 10:19 AM, Moger, Babu wrote:
> >>> On 7/12/24 17:03, Reinette Chatre wrote:
> >>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>
> >>>>> # Examples
> >>>>>
> >>>>> a. Check if ABMC support is available
> >>>>>       #mount -t resctrl resctrl /sys/fs/resctrl/
> >>>>>
> >>>>>       #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> >>>>>       [abmc]
> >>>>>       legacy
> >>>>>
> >>>>>       Linux kernel detected ABMC feature and it is enabled.
> >>>>
> >>>> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mb=
m_cntrs
> >>>> info file and be the final step to make this generic so that another
> >>>> architecture
> >>>> can more easily support assignining hardware counters without needin=
g to call
> >>>> the feature AMD's "abmc".
> >>>
> >>> I think we aleady settled this with "mbm_cntr_assignable".
> >>>
> >>> For soft-RMID" it will be mbm_sw_assignable.
> >>
> >> Maybe getting a bit long but how about "mbm_cntr_sw_assignable" to mat=
ch
> >> with the term "mbm_cntr" in accompanying "num_mbm_cntrs"?
> >
> > My users are pushing for a consistent interface regardless of whether
> > counter assignment is implemented in hardware or software, so I would
> > like to avoid exposing implementation differences in the interface
> > where possible.
>
> This seems a reasonable ask but can we be confident that if hardware
> supports assignable counters then there will never be a reason to use
> software assignable counters? (This needs to also consider how/if Arm
> may use this feature.)
>
> I am of course not familiar with details of the software implementation
> - could there be benefits to using it even if hardware counters are
> supported?

I can't see any situation where the user would want to choose software
over hardware counters. The number of groups which can be monitored by
software assignable counters will always be less than with hardware,
due to the need for consuming one RMID (and the counters automatically
allocated to it by the AMD hardware) for all unassigned groups.

I consider software assignable a workaround to enable measuring
bandwidth reliably on a large number of groups on pre-ABMC AMD
hardware, or rather salvaging MBM on pre-ABMC hardware making use of
our users' effort to adapt to counter assignment in resctrl. We hope
no future implementations will choose to silently drop bandwidth
counts, so fingers crossed, the software implementation can be phased
out when these generations of AMD hardware are decommissioned.

The MPAM specification natively supports (or requires) counter
assignment in hardware. From what I recall in the last of James'
prototypes I looked at, MBM was only supported if the implementation
provided as many bandwidth counters as there were possible monitoring
groups, so that it could assume a monitor IDs for every PARTID:PMG
combination.

>
> What I would like to avoid is future complexity of needing a new mount/co=
nfig
> option that user space needs to use to select if a single "mbm_cntr_assig=
nable"
> is backed by hardware or software.

In my testing so far, automatically enabling counter assignment and
automatically allocating counters for all events in new groups works
well enough.

The only configuration I need is the ability to disable the automatic
counter allocation so that a userspace agent can have control of where
all the counters are assigned at all times. It's easy to implement
this as a simple flag if the user accepts that they need to manually
deallocate any automatically-allocated counters from groups created
before the flag was cleared.

>
> > The main semantic difference with SW assignments is that it is not
> > possible to assign counters to individual events. Because the
> > implementation is assigning RMIDs to groups, assignment results in all
> > events being counted.
> >
> > I was considering introducing a boolean mbm_assign_events node to
> > indicate whether assigning individual events is supported. If true,
> > num_mbm_cntrs indicates the number of events which can be counted,
> > otherwise it indicates the number of groups to which counters can be
> > assigned and attempting to assign a single event is silently upgraded
> > to assigning counters to all events in the group.
>
> How were you envisioning your users using the control file ("mbm_control"=
)
> in these scenarios? Does this file's interface even work for SW assignmen=
t
> scenarios?
>
> Users should expect consistent interface for "mbm_control" also.
>
> It sounds to me that a potential "mbm_assign_events" will be false for SW
> assignments. That would mean that "num_mbm_cntrs" will
> contain the number of groups to which counters can be assigned?
> Would user space be required to always enable all flags (enable all event=
s) of
> all domains to the same values ... or would enabling of one flag (one eve=
nt)
> in one domain automatically result in all flags (all events) enabled for =
all
> domains ... or would enabling of one flag (one event) in one domain only =
appear
> to user space to be enabled while in reality all flags/events are actuall=
y enabled?

I believe mbm_control should always accurately reflect which events
are being counted.

The behavior as I've implemented today is:

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
0

# cat /sys/fs/resctrl/info/L3_MON/mbm_control
test//0=3D_;1=3D_;
//0=3D_;1=3D_;

# echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
# cat /sys/fs/resctrl/info/L3_MON/mbm_control
test//0=3D_;1=3Dtl;
//0=3D_;1=3D_;

# echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
# cat /sys/fs/resctrl/info/L3_MON/mbm_control
test//0=3D_;1=3D_;
//0=3D_;1=3D_;


>
> > However, If we don't expect to see these semantics in any other
> > implementation, these semantics could be implicit in the definition of
> > a SW assignable counter.
>
> It is not clear to me how implementation differences between hardware
> and software assignment can be hidden from user space. It is possible
> to let user space enable individual events and then silently upgrade it
> to all events. I see two options here, either "mbm_control" needs to
> explicitly show this "silent upgrade" so that user space knows which
> events are actually enabled, or "mbm_control" only shows flags/events ena=
bled
> from user space perspective. In the former scenario, this needs more
> user space support since a generic user space cannot be confident which
> flags are set after writing to "mbm_control". In the latter scenario,
> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
> to rely on it to know which events can be enabled and if some are
> actually "silently enabled" when user space still thinks it needs to be
> enabled the number of available counters becomes vague.
>
> It is not clear to me how to present hardware and software assignable
> counters with a single consistent interface. Actually, what if the
> "mbm_mode" is what distinguishes how counters are assigned instead of how
> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
> and "mbm_cntr_group_assignable" is used? Could that replace a
> potential "mbm_assign_events" while also supporting user space in
> interactions with "mbm_control"?

If I understand this correctly, is this a preference that the info
node be named differently if its value will have different units,
rather than a second node to indicate what the value of num_mbm_cntrs
actually means? This sounds reasonable to me.

I think it's also important to note that in MPAM, the MBWU (memory
bandwidth usage) monitors don't have a concept of local versus total
bandwidth, so event assignment would likely not apply there either.
What the counted bandwidth actually represents is more implicit in the
monitor's position in the memory system in the particular
implementation. On a theoretical multi-socket system, resctrl would
require knowledge about the system's architecture to stitch together
the counts from different types of monitors to produce a local and
total value. I don't know if we'd program this SoC-specific knowledge
into the kernel to produce a unified MBM resource like we're
accustomed to now or if we'd present multiple MBM resources, each only
providing an mbm_total_bytes event. In this case, the counters would
have to be assigned separately in each MBM resource, especially if the
different MBM resources support a different number of counters.

Thanks,
-Peter

