Return-Path: <linux-kernel+bounces-288708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E0953DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B251328AD47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386B155CB5;
	Thu, 15 Aug 2024 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MICWZqcn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBF155742
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763198; cv=none; b=i12FDOoQxYbfyQAeZSiMlE1FYeoO4I3f98Yj17pMjgpp1ugctjoEaNbKhUENd6/JMZxojfuco8cSZkCuzlMD5eCpGsxPS9bakI5Mx2kCdbmMT/PaUbkFp7Sphfo4b1OMPWvcB24CjIP0Cu+FvfUscO4NT+XRR8cy8Z5ikGnSyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763198; c=relaxed/simple;
	bh=uURx1zSm1o3xNM5Cig3trr3wzrjhSY8S9iwG67gdkTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSix0CePvlygjp6D4nw2Ee9hhh6l7ZfYU1FegSd5fK4DMSPFsZbj6yTnDmiaAg+1NS/1pBaeY45GhMSybQJtiSecGVxjfSZ/VdckGD2nBQcNL2/5Ieamtim9qHqrftrJlg5O+uQuJCw2OU5INixl57n6gNxDM/iOMOadwYigOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MICWZqcn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a83a968ddso185131766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723763194; x=1724367994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uURx1zSm1o3xNM5Cig3trr3wzrjhSY8S9iwG67gdkTg=;
        b=MICWZqcnKOnozEiO1IJ4x7NNdtQ2n2vkXQizeNdRMZTRumqBPzj3eFGb2ISbm3WnPo
         dzGu8KCaKlnHsjJNf2nDHyqczzeVSCfX5IPhlQTFXo7iVxoE4WlTeA0d3dIzQ/Llwj1O
         uOV66yMWDZ3x5fUtHbfVuoeqH5rMOKnXyNS8TJhiL5oM9Tauk4oyd0SdQ/qOLs2X8PDy
         2jFns4VKRAyhzYpFkEVIFFVoR1hy/WKLXqVP3wvm5Bgod+o82y/i7+OTMY3TBuiHvOth
         KRn4pcqKsZ+z8zMCTx6A8okWRFI0BH8lwa2CqX+nL4MXYTjvfL2xIyQ+iabt+zZlWdv1
         QF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723763194; x=1724367994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uURx1zSm1o3xNM5Cig3trr3wzrjhSY8S9iwG67gdkTg=;
        b=pGo2X8TqMbhv9rLADOtlui7bkN10aUGYLq9xk1QAeLuzGTJrpwju7qIliBJMYfPbhv
         WLcs1Ci4bKof8VBLJN3re5zH/4aj8w4W7k3V0wj3b71IregI0rD4tXRedUOepVQCIbyN
         jI+xN8pr/SDqJQ+tqljkNCPB0mShFHr0PWGZom+rIsSfuuXJkFP52vV0J61naYgB7Mje
         O/yTY3f7OXGa0kjAQ2g+hpTca5yr8bccwjYPen/mcoG78fTjcLBsS7z8WvsSNrywEbEI
         387wrctng2PbxmOvh8KNsZw3o1dihIRYpPwIR9u9pFj+6pqncJz/FLxGlxIzHuJAqrUk
         Nd8A==
X-Forwarded-Encrypted: i=1; AJvYcCWgEGOBFaSW7YkNV5nmFMFIUWAkPp+cM6soW8oO9BepyFjPDkMZiRH7EY2kF//bz5EESdvp5O9O1hbyZZN7BMvAX1Nn1kiMugcS6gu5
X-Gm-Message-State: AOJu0YzQS5fvhi347Q/yJFg3wGmwc7kRggnaXMTIxWotNuw4dIsqf+tA
	iUb75h4i4qlZPson7ov1CZjAVVcW9LUIobjSVFn4e56gSRqNq57rVxbzNlc6c2l2cF0393dc0bX
	4qtF0niUCNIrRf53qN1zUCCBHLWevkBN1u8ys
X-Google-Smtp-Source: AGHT+IEIYDxC5f1uGEQRKZMhCIE3PtCaz0bcEAToxMIFkYzxOYetvw9zZ6UvQCN9UzanNt3rz06v/ooyJO4Xv5kA6wo=
X-Received: by 2002:a17:907:6d22:b0:a77:b726:4fc with SMTP id
 a640c23a62f3a-a839288691fmr68629066b.1.1723763193558; Thu, 15 Aug 2024
 16:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720043311.git.babu.moger@amd.com> <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com> <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com> <CALPaoCi1CwLy_HbFNOxPfdReEJstd3c+DvOMJHb5P9jBP+iatw@mail.gmail.com>
 <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com> <CALPaoCg3KpF94g2MEmfP_Ro2mQZYFA8sKVkmb+7isotKNgdY9A@mail.gmail.com>
 <a19d96ac-f83a-4f5a-98ce-c5554e12afc5@intel.com>
In-Reply-To: <a19d96ac-f83a-4f5a-98ce-c5554e12afc5@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 15 Aug 2024 16:06:22 -0700
Message-ID: <CALPaoCiV-xTKn9N+oP4mqgRwsWxPUfutKDF==1h-8K9b7YfE0g@mail.gmail.com>
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

On Wed, Aug 14, 2024 at 10:37=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 8/2/24 3:50 PM, Peter Newman wrote:
> > On Fri, Aug 2, 2024 at 1:55=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 8/2/24 11:49 AM, Peter Newman wrote:
> >>> On Fri, Aug 2, 2024 at 9:14=E2=80=AFAM Reinette Chatre
> >>>> I am of course not familiar with details of the software implementat=
ion
> >>>> - could there be benefits to using it even if hardware counters are
> >>>> supported?
> >>>
> >>> I can't see any situation where the user would want to choose softwar=
e
> >>> over hardware counters. The number of groups which can be monitored b=
y
> >>> software assignable counters will always be less than with hardware,
> >>> due to the need for consuming one RMID (and the counters automaticall=
y
> >>> allocated to it by the AMD hardware) for all unassigned groups.
> >>
> >> Thank you for clarifying. This seems specific to this software impleme=
ntation,
> >> and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I=
 remember
> >> correctly this depends on undocumented hardware specific knowledge.
> >
> > For the benefit of anyone else who needs to monitor bandwidth on a
> > large number of monitoring groups on pre-ABMC AMD implementations,
> > hopefully a future AMD publication will clarify, at least on some
> > existing, pre-ABMC models, exactly when the QM_CTR.U bit is set.
> >
> >
> >>>
> >>> The behavior as I've implemented today is:
> >>>
> >>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
> >>> 0
> >>>
> >>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> >>> test//0=3D_;1=3D_;
> >>> //0=3D_;1=3D_;
> >>>
> >>> # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> >>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> >>> test//0=3D_;1=3Dtl;
> >>> //0=3D_;1=3D_;
> >>>
> >>> # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> >>> # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> >>> test//0=3D_;1=3D_;
> >>> //0=3D_;1=3D_;
> >>>
> >>>
> >>
> >> This highlights how there cannot be a generic/consistent interface bet=
ween hardware
> >> and software implementation. If resctrl implements something like abov=
e without any
> >> other hints to user space then it will push complexity to user space s=
ince user space
> >> would not know if setting one flag results in setting more than that f=
lag, which may
> >> force a user space implementation to always follow a write with a read=
 that
> >> needs to confirm what actually resulted from the write. Similarly, tha=
t removing a
> >> flag impacts other flags needs to be clear without user space needing =
to "try and
> >> see what happens".
> >
> > I'll return to this topic in the context of MPAM below...
> >
> >> It is not clear to me how to interpret the above example when it comes=
 to the
> >> RMID management though. If the RMID assignment is per group then I exp=
ected all
> >> the domains of a group to have the same flag(s)?
> >
> > The group RMIDs are never programmed into any MSRs and the RMID space
> > is independent in each domain, so it is still possible to do
> > per-domain assignment. (and like with soft RMIDs, this enables us to
> > create unlimited groups, but we've never been limited by the size of
> > the RMID space)
> >
> > However, in our use cases, jobs are not confined to any domain, so
> > bandwidth measurements must be done simultaneously in all domains, so
> > we have no current use for per-domain assignment. But if any Google
> > users did begin to see value in confining jobs to domains, this could
> > change.
> >
> >>
> >>>>
> >>>>> However, If we don't expect to see these semantics in any other
> >>>>> implementation, these semantics could be implicit in the definition=
 of
> >>>>> a SW assignable counter.
> >>>>
> >>>> It is not clear to me how implementation differences between hardwar=
e
> >>>> and software assignment can be hidden from user space. It is possibl=
e
> >>>> to let user space enable individual events and then silently upgrade=
 it
> >>>> to all events. I see two options here, either "mbm_control" needs to
> >>>> explicitly show this "silent upgrade" so that user space knows which
> >>>> events are actually enabled, or "mbm_control" only shows flags/event=
s enabled
> >>>> from user space perspective. In the former scenario, this needs more
> >>>> user space support since a generic user space cannot be confident wh=
ich
> >>>> flags are set after writing to "mbm_control". In the latter scenario=
,
> >>>> meaning of "num_mbm_cntrs" becomes unclear since user space is expec=
ted
> >>>> to rely on it to know which events can be enabled and if some are
> >>>> actually "silently enabled" when user space still thinks it needs to=
 be
> >>>> enabled the number of available counters becomes vague.
> >>>>
> >>>> It is not clear to me how to present hardware and software assignabl=
e
> >>>> counters with a single consistent interface. Actually, what if the
> >>>> "mbm_mode" is what distinguishes how counters are assigned instead o=
f how
> >>>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" a=
nd
> >>>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assigna=
ble"
> >>>> and "mbm_cntr_group_assignable" is used? Could that replace a
> >>>> potential "mbm_assign_events" while also supporting user space in
> >>>> interactions with "mbm_control"?
> >>>
> >>> If I understand this correctly, is this a preference that the info
> >>> node be named differently if its value will have different units,
> >>> rather than a second node to indicate what the value of num_mbm_cntrs
> >>> actually means? This sounds reasonable to me.
> >>
> >> Indeed. As you highlighted, user space may not need to know if
> >> counters are backed by hardware or software, but user space needs to
> >> know what to expect from (how to interact with) interface.
> >>
> >>> I think it's also important to note that in MPAM, the MBWU (memory
> >>> bandwidth usage) monitors don't have a concept of local versus total
> >>> bandwidth, so event assignment would likely not apply there either.
> >>> What the counted bandwidth actually represents is more implicit in th=
e
> >>> monitor's position in the memory system in the particular
> >>> implementation. On a theoretical multi-socket system, resctrl would
> >>> require knowledge about the system's architecture to stitch together
> >>> the counts from different types of monitors to produce a local and
> >>> total value. I don't know if we'd program this SoC-specific knowledge
> >>> into the kernel to produce a unified MBM resource like we're
> >>> accustomed to now or if we'd present multiple MBM resources, each onl=
y
> >>> providing an mbm_total_bytes event. In this case, the counters would
> >>> have to be assigned separately in each MBM resource, especially if th=
e
> >>> different MBM resources support a different number of counters.
> >>>
> >>
> >> "total" and "local" bandwidth is already in grey area after the
> >> introduction of mbm_total_bytes_config/mbm_local_bytes_config where
> >> user space could set values reported to not be constrained by the
> >> "total" and "local" terms. We keep sticking with it though, even in
> >> this implementation that uses the "t" and "l" flags, knowing that
> >> what is actually monitored when "l" is set is just what the user
> >> configured via mbm_local_bytes_config, which theoretically
> >> can be "total" bandwidth.
> >
> > If it makes sense to support a separate, group-assignment interface at
> > least for MPAM, this would be a better fit for soft-ABMC, even if it
> > does have to stay downstream.
>
> (apologies for the delay)
>
> Could we please take a step back and confirm/agree what is meant with "gr=
oup-
> assignment"? In a previous message [1] I latched onto the statement
> "the implementation is assigning RMIDs to groups, assignment results in a=
ll
> events being counted.". In this I understood "groups" to be resctrl group=
s
> and I understood this to mean that when a (soft-ABMC) counter is assigned
> it applies to the entire resctrl group (all domains, all events). The
> subsequent example in [2] was thus unexpected to me when the interface
> was used to assign a (soft-ABMC) counter to the group but not all domains
> were impacted.
>
> Considering this, could you please elaborate what is meant with
> "group assignment"?

By "group assignment", I just mean assigning counters to individual
MBM events is not possible, or that assignment results in counters
being assigned to all MBM events for a group in a domain.

I only omitted per-domain assignment in soft-ABMC before because
Google doesn't have a use-case for it. I started the prototype before
Babu's proposed interface required domain-scoped assignments[1]. Now
that some sort of domain selector is required, I'm reconsidering.

-Peter

[1] https://lore.kernel.org/lkml/cover.1705688538.git.babu.moger@amd.com/

