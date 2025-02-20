Return-Path: <linux-kernel+bounces-523958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1691BA3DD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9AC7A3B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2A1D5160;
	Thu, 20 Feb 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvGcF7eD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595391CB332
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063218; cv=none; b=R3rbJInIHvxU+Tn0mOFWALb9/eSG6O+g5YApnN/xOHnrZ9eprhQB5kVO7lzknir/idtGYWhSQauJLCBjG9ZYUtBsbJ/Ab2fKcrWeQrq5odvAWna/1U6fXWrzOwwAv+DVzgTUZFcOZanGklVBSJ2+tqmp16HAAXkomr0PXBmf71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063218; c=relaxed/simple;
	bh=JFI7xFdohebGfh/rUi8AR902SaVz+AzRKDL3kXyHuSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iibVFnSw++LhQStKIX0KNWUjKprdg8lnRWsxwSt+3ha82BlHoGj6uagT9P83lFxjm5wZheQzrWJkcgdnw8XZO49IJxt/9eiUH0vXb30SXSd4yrP0VcKxQUrA2fhnuoPcspQvGROUEhp1HZ5u5HcQOW8o2VxlJ6vEfW/HgXzTeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvGcF7eD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbb12bea54so207867366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063215; x=1740668015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTRL4gxmlLi+NJrsXoSrS05iurRAAfx6bVkFP/yRfmE=;
        b=gvGcF7eDGoTd0H0RjKUTPL1MQD5ku5+jowS6HPHiuOtwv5ERqSkjGVRt4YsUdP2yaN
         lsKVNAIgHrnBEv3BtrcdRxAsYqUOyaQBPA9i2+JoPFLh1zGV6Kczgiwt6xV9HcTwv3hv
         /L0RpYeTF9chGUQtm+y/mMmf/XVIRnyeCKGO+iDZgpPji2hwgLhPMu9X52kgMyZvGR5f
         uTG7rM6CCFYKjbX3ABdTGev9Cks7IGvzQC3wh4chyVQpy0vqdJk+Z2MoaGkwv03Vn94I
         ktRV2Ysc8HaWSEFJ6y9JICHO/mjLp1vz19jdh8JNVPgA11zALK4uGxmI5kLr9T8aQayv
         L8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063215; x=1740668015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTRL4gxmlLi+NJrsXoSrS05iurRAAfx6bVkFP/yRfmE=;
        b=sY1TgplzP7K5a9HurnfV1xOHs2nurftsp99ekwmQvekJx9KlOTXHNNLt0MoNpGYXUS
         eZYtdOM8vu7RqDNh+GzieWvSb/H0D8vV8goT4t3wbfxLpoOQZ5M6lHCBTje3Lo6Vp/wN
         XFztC3g0VTwgzXHbApO6+JnewPI7pBpkPYJPPWC6AQbBCHZc/yuvDZnS220Ywm8Yyr+8
         UsSQ/ZmqJ6CVKOWHbugYPgiIGoNLsIn7/gCjnXbzd73cgoMYaSevBLFsYf5DvI4htmey
         EGEP1/xYoQR/xbhrPQBE63+Dp3yBANxaSHALlgFojhNhLl0MVQol4OSrGm+TGlBhmx8o
         Ogyw==
X-Forwarded-Encrypted: i=1; AJvYcCVfmW5LGPu7Q8M79yqZv133t8z8X4QFeVvCjGCunDw3hkB+iRjTz55rAscOFZ1l7zb1GdIOT+cNT7V8/QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgE0D5HLDI9b9OrbAQMyl9VJultbgDiuBSSzHIycr/OaBpGOVq
	ew8jI6j0tNVvZnwaa/KCc1U2cSrqnswLpXyO543ZEU5T6erkUCTCCDxMKYqbf5OBOo4WFCUYBWJ
	RAFt/wuMFlsD6KAwdQv6sdwDedZgqqRM+wdOk
X-Gm-Gg: ASbGncsG4d8N6g5R2tHZI0ioy94cxYN2aKfVVWG2FBeAg3WuLVI2rA1U87nws6Efww5
	U8kw3nKLBKgN20N+iCB6AGDC5V/kD9pokEa4p0jW/rzq9741YTQAuY6S2oTWKr18jdz3VsD0u1X
	lnotMe4b4Hb/Jw9JUWDApgWQ9w2g==
X-Google-Smtp-Source: AGHT+IE9eF0BwDQ5dmqLQP076H2O10DsrgDf87/nNNoMu31F54aBrrtN1gjpRMRYd2K3btjjJHxGBOi/ydQB/Ps4oFU=
X-Received: by 2002:a17:907:97d2:b0:aba:7a3a:e267 with SMTP id
 a640c23a62f3a-abb70dd8f5bmr2515811966b.45.1740063214362; Thu, 20 Feb 2025
 06:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737577229.git.babu.moger@amd.com> <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com> <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com> <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com> <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com> <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
In-Reply-To: <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 20 Feb 2025 15:53:23 +0100
X-Gm-Features: AWEUYZlcORC_iRuGdaEQvDQJxBjdF0n3FDwBzBL64e44VXcnjAXQo_uJfn-OBgE
Message-ID: <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>, 
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org, 
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org, 
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com, 
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com, 
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com, 
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com, 
	mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maciej.wieczor-retman@intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 2/19/25 3:28 AM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>> Hi Reinette,
> >>>
> >>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>> <reinette.chatre@intel.com> wrote:
> >>>>
> >>>> Hi Babu,
> >>>>
> >>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
> >>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>>>
> >>>> (quoting relevant parts with goal to focus discussion on new possibl=
e syntax)
> >>>>
> >>>>>>>> I see the support for MPAM events distinct from the support of a=
ssignable counters.
> >>>>>>>> Once the MPAM events are sorted, I think that they can be assign=
ed with existing interface.
> >>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>
> >>>>>>>> Doing so would need to come up with alphabetical letters for the=
se events,
> >>>>>>>> which seems to be needed for your proposal also? If we use possi=
ble flags of:
> >>>>>>>>
> >>>>>>>> mbm_local_read_bytes a
> >>>>>>>> mbm_local_write_bytes b
> >>>>>>>>
> >>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_assign_=
control
> >>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> >>>>>>>> <value>
> >>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>>>
> >>>>>>>> One issue would be when resctrl needs to support more than 26 ev=
ents (no more flags available),
> >>>>>>>> assuming that upper case would be used for "shared" counters (un=
less this interface is defined
> >>>>>>>> differently and only few uppercase letters used for it). Would t=
his be too low of a limit?
> >>>>
> >>>> As mentioned above, one possible issue with existing interface is th=
at
> >>>> it is limited to 26 events (assuming only lower case letters are use=
d). The limit
> >>>> is low enough to be of concern.
> >>>
> >>> The events which can be monitored by a single counter on ABMC and MPA=
M
> >>> so far are combinable, so 26 counters per group today means it limits
> >>> breaking down MBM traffic for each group 26 ways. If a user complaine=
d
> >>> that a 26-way breakdown of a group's MBM traffic was limiting their
> >>> investigation, I would question whether they know what they're lookin=
g
> >>> for.
> >>
> >> The key here is "so far" as well as the focus on MBM only.
> >>
> >> It is impossible for me to predict what we will see in a couple of yea=
rs
> >> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl in=
terface
> >> to support their users. Just looking at the Intel RDT spec the event r=
egister
> >> has space for 32 events for each "CPU agent" resource. That does not t=
ake into
> >> account the "non-CPU agents" that are enumerated via ACPI. Tony alread=
y mentioned
> >> that he is working on patches [1] that will add new events and shared =
the idea
> >> that we may be trending to support "perf" like events associated with =
RMID. I
> >> expect AMD PQoS and Arm MPAM to provide related enhancements to suppor=
t their
> >> customers.
> >> This all makes me think that resctrl should be ready to support more e=
vents than 26.
> >
> > I was thinking of the letters as representing a reusable, user-defined
> > event-set for applying to a single counter rather than as individual
> > events, since MPAM and ABMC allow us to choose the set of events each
> > one counts. Wherever we define the letters, we could use more symbolic
> > event names.
>
> Thank you for clarifying.
>
> >
> > In the letters as events model, choosing the events assigned to a
> > group wouldn't be enough information, since we would want to control
> > which events should share a counter and which should be counted by
> > separate counters. I think the amount of information that would need
> > to be encoded into mbm_assign_control to represent the level of
> > configurability supported by hardware would quickly get out of hand.
> >
> > Maybe as an example, one counter for all reads, one counter for all
> > writes in ABMC would look like...
> >
> > (L3_QOS_ABMC_CFG.BwType field names below)
> >
> > (per domain)
> > group 0:
> >  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >  counter 1: VictimBW,LclNTWr,RmtNTWr
> > group 1:
> >  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >  counter 3: VictimBW,LclNTWr,RmtNTWr
> > ...
> >
>
> I think this may also be what Dave was heading towards in [2] but in that
> example and above the counter configuration appears to be global. You do =
mention
> "configurability supported by hardware" so I wonder if per-domain counter
> configuration is a requirement?

If it's global and we want a particular group to be watched by more
counters, I wouldn't want this to result in allocating more counters
for that group in all domains, or allocating counters in domains where
they're not needed. I want to encourage my users to avoid allocating
monitoring resources in domains where a job is not allowed to run so
there's less pressure on the counters.

In Dave's proposal it looks like global configuration means
globally-defined "named counter configurations", which works because
it's really per-domain assignment of the configurations to however
many counters the group needs in each domain.

>
> Until now I viewed counter configuration separate from counter assignment=
,
> similar to how AMD's counters can be configured via mbm_total_bytes_confi=
g and
> mbm_local_bytes_config before they are assigned. That is still per-domain
> counter configuration though, not per-counter.
>
> > I assume packing all of this info for a group's desired counter
> > configuration into a single line (with 32 domains per line on many
> > dual-socket AMD configurations I see) would be difficult to look at,
> > even if we could settle on a single letter to represent each
> > universally.
> >
> >>
> >> My goal is for resctrl to have a user interface that can as much as po=
ssible
> >> be ready for whatever may be required from it years down the line. Of =
course,
> >> I may be wrong and resctrl would never need to support more than 26 ev=
ents per
> >> resource (*). The risk is that resctrl *may* need to support more than=
 26 events
> >> and how could resctrl support that?
> >>
> >> What is the risk of supporting more than 26 events? As I highlighted e=
arlier
> >> the interface I used as demonstration may become unwieldy to parse on =
a system
> >> with many domains that supports many events. This is a concern for me.=
 Any suggestions
> >> will be appreciated, especially from you since I know that you are ver=
y familiar with
> >> issues related to large scale use of resctrl interfaces.
> >
> > It's mainly just the unwieldiness of all the information in one file.
> > It's already at the limit of what I can visually look through.
>
> I agree.
>
> >
> > I believe that shared assignments will take care of all the
> > high-frequency and performance-intensive batch configuration updates I
> > was originally concerned about, so I no longer see much benefit in
> > finding ways to textually encode all this information in a single file
> > when it would be more manageable to distribute it around the
> > filesystem hierarchy.
>
> This is significant. The motivation for the single file was to support
> the "high-frequency and performance-intensive" usage. Would "shared assig=
nments"
> not also depend on the same files that, if distributed, will require many
> filesystem operations?
> Having the files distributed will be significantly simpler while also
> avoiding the file size issue that Dave Martin exposed.

The remaining filesystem operations will be assigning or removing
shared counter assignments in the applicable domains, which would
normally correspond to mkdir/rmdir of groups or changing their CPU
affinity. The shared assignments are more "program and forget", while
the exclusive assignment approach requires updates for every counter
(in every domain) every few seconds to cover a large number of groups.

When they want to pay extra attention to a particular group, I expect
they'll ask for exclusive counters and leave them assigned for a while
as they collect extra data.

-Peter

