Return-Path: <linux-kernel+bounces-525803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF55A3F5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE3C425786
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432F20DD54;
	Fri, 21 Feb 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSSKsBDM"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5020C489
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143597; cv=none; b=aDnWPdVx/D+yZ1q6uv5iU00NKALiUR0oZTocinTsf7+XT/4mnmBoUZVMDkTH/Vn5aZUCrcB+ahEsLIMVdLc3fMX3S7WbypxmbGiMMygCAa9C8AnPcKskjrkKptkMTN8yIfStrs2sRPKM0bWBgUqHNZJOHgG4I7mNa3Pz3abdnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143597; c=relaxed/simple;
	bh=yz7l+2hucwQYabRJfcpXcNb+5iu7A7IUhj8Vu94P1QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLorX4E99IhRYI1UVNux4ZJXDYm/UIAussmiZhPl1khdpc02YXAvck2v/oj01kianRhYv4IQOZQaLFb9rh8CgH4A9ROw334DsDJsIvd95+FmIgxNlOYnbUPa66i2Xpi1xe2e/pNFOaTLnMZtFPyp5q16hvkWqOoF1m2cmVfhDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LSSKsBDM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbda4349e9so305949466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740143583; x=1740748383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxKgSVBFr1Jj9c3ThVva5AWPrKinPAeaGUJ/lmxHvl4=;
        b=LSSKsBDMVQ5hvQhLWItcUxlWS13spkxg0UjzVDB1PuziKl5odjDBj8L9JQShBvU+Z9
         4HsQVTguhK6R0lDsS9oUAu6VonuKXDOAVbQW1hclbgKvIbYxJjJBOIC07g3DX3JPmwtX
         CegghD5h1fP3sGqR60dbx+HhPJhMRZByXe8JKlsJmzWYrmIVnnabi3MJlcZPIE8BoK1X
         ovDs9bZ92MMbWDVqRPiV1GlhzmMYUB6SQFjRT44ZywQruooyjL5W/Zig2LRw2NxwxZkV
         YScMmK42iWsopUADXzbjCcnzX7P4pbqL0YN/Y/ol8vGg1TIdD7TUiZNTLP6+H4HQn/j9
         13mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740143583; x=1740748383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxKgSVBFr1Jj9c3ThVva5AWPrKinPAeaGUJ/lmxHvl4=;
        b=sS5GUi01QEwbDIYPPjNe7Q6B7oyS8vcj6d34SEMHrpXs3lG6n3yTxrbVAdu1qNYPbp
         LMNXMzU6smNeH3qMSqitmdhzSnYJOnyV3rvIw7uy3oVomH+oU9DRSu9b82pl1DyMyWDk
         /3t46O5Lz5OEh4oPlcmIfdwVVWtHU4MgBZlsMjLBgJ6OUDhcOF4x6x4cK9ku4jwuvY9T
         32zdQg7V9FWYjEBn42pfdIsKsJN3y3V3D2mBjeYc33r+bAGyj9daYxV5ihB6RuNlpE4H
         ITuhFr8qiykn2mJAgQUw6nCyLAXUrBNlcJuJmgQRwsT8zmcHc2PWPbRMpx80cJDfDji5
         K8cA==
X-Forwarded-Encrypted: i=1; AJvYcCVay1AUFB5JUg5UuFkXFhPdx3bvB4Iu0wO59uorHfLh+dkPP5H1KmeFhtm7eZBIcIfvWmJaB/AvZyXeeGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyngnofgdh465pMzF40l502+3K/LII4RciFDVznUkI+M5Oe2WAW
	a89UZKj6lkOS10846dCVTEjF+hvea5x8iRIPEdAercaV7Gc4UmMf1ebKQI9/BtN6l1H0QmMbuzJ
	ZFBkzxeTzbB/xPO4Tb/RK4A8tdxLioxRlSNLd
X-Gm-Gg: ASbGnctqpHcxm4J84nbWKOEW4sATitt5LnWzTi8+1/3TPF18Gs5EsNGy6Nh+igzVl8h
	MLoaI7XwI2EAxG4D5i4oKyCQIxz2+9MaI3kndrjEc3nkhm+po+lL0SMVfStOFntJtHSdgF5ylnX
	n4UY+GlXxBuICAJP0ZMPNIkm9+ss5mkLUu8mn7lg==
X-Google-Smtp-Source: AGHT+IF0Y74UAxrbedLnaIJQ/t63IYMtMdYuIsubxScoTWeDzOkMWcwhZbqBVc9a6Sdxm6/kam3mZ620GyoJKZpTVlE=
X-Received: by 2002:a17:907:7285:b0:ab6:f06b:4a26 with SMTP id
 a640c23a62f3a-abc0da33bf1mr320648166b.34.1740143583018; Fri, 21 Feb 2025
 05:13:03 -0800 (PST)
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
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com> <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
In-Reply-To: <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 21 Feb 2025 14:12:51 +0100
X-Gm-Features: AWEUYZk3iR5VxlU9mHLttofMrNuxRSxNZKJLECLXx2xtrPiD90h6ry76gw9zM44
Message-ID: <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
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

On Thu, Feb 20, 2025 at 7:36=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 2/20/25 6:53 AM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 2/19/25 3:28 AM, Peter Newman wrote:
> >>> Hi Reinette,
> >>>
> >>> On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> >>> <reinette.chatre@intel.com> wrote:
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>>>> Hi Reinette,
> >>>>>
> >>>>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>
> >>>>>> Hi Babu,
> >>>>>>
> >>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote=
:
> >>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>>>>>
> >>>>>> (quoting relevant parts with goal to focus discussion on new possi=
ble syntax)
> >>>>>>
> >>>>>>>>>> I see the support for MPAM events distinct from the support of=
 assignable counters.
> >>>>>>>>>> Once the MPAM events are sorted, I think that they can be assi=
gned with existing interface.
> >>>>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>>>
> >>>>>>>>>> Doing so would need to come up with alphabetical letters for t=
hese events,
> >>>>>>>>>> which seems to be needed for your proposal also? If we use pos=
sible flags of:
> >>>>>>>>>>
> >>>>>>>>>> mbm_local_read_bytes a
> >>>>>>>>>> mbm_local_write_bytes b
> >>>>>>>>>>
> >>>>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_assig=
n_control
> >>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> >>>>>>>>>> <value>
> >>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>>>>>
> >>>>>>>>>> One issue would be when resctrl needs to support more than 26 =
events (no more flags available),
> >>>>>>>>>> assuming that upper case would be used for "shared" counters (=
unless this interface is defined
> >>>>>>>>>> differently and only few uppercase letters used for it). Would=
 this be too low of a limit?
> >>>>>>
> >>>>>> As mentioned above, one possible issue with existing interface is =
that
> >>>>>> it is limited to 26 events (assuming only lower case letters are u=
sed). The limit
> >>>>>> is low enough to be of concern.
> >>>>>
> >>>>> The events which can be monitored by a single counter on ABMC and M=
PAM
> >>>>> so far are combinable, so 26 counters per group today means it limi=
ts
> >>>>> breaking down MBM traffic for each group 26 ways. If a user complai=
ned
> >>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
> >>>>> investigation, I would question whether they know what they're look=
ing
> >>>>> for.
> >>>>
> >>>> The key here is "so far" as well as the focus on MBM only.
> >>>>
> >>>> It is impossible for me to predict what we will see in a couple of y=
ears
> >>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl =
interface
> >>>> to support their users. Just looking at the Intel RDT spec the event=
 register
> >>>> has space for 32 events for each "CPU agent" resource. That does not=
 take into
> >>>> account the "non-CPU agents" that are enumerated via ACPI. Tony alre=
ady mentioned
> >>>> that he is working on patches [1] that will add new events and share=
d the idea
> >>>> that we may be trending to support "perf" like events associated wit=
h RMID. I
> >>>> expect AMD PQoS and Arm MPAM to provide related enhancements to supp=
ort their
> >>>> customers.
> >>>> This all makes me think that resctrl should be ready to support more=
 events than 26.
> >>>
> >>> I was thinking of the letters as representing a reusable, user-define=
d
> >>> event-set for applying to a single counter rather than as individual
> >>> events, since MPAM and ABMC allow us to choose the set of events each
> >>> one counts. Wherever we define the letters, we could use more symboli=
c
> >>> event names.
> >>
> >> Thank you for clarifying.
> >>
> >>>
> >>> In the letters as events model, choosing the events assigned to a
> >>> group wouldn't be enough information, since we would want to control
> >>> which events should share a counter and which should be counted by
> >>> separate counters. I think the amount of information that would need
> >>> to be encoded into mbm_assign_control to represent the level of
> >>> configurability supported by hardware would quickly get out of hand.
> >>>
> >>> Maybe as an example, one counter for all reads, one counter for all
> >>> writes in ABMC would look like...
> >>>
> >>> (L3_QOS_ABMC_CFG.BwType field names below)
> >>>
> >>> (per domain)
> >>> group 0:
> >>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>> group 1:
> >>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>> ...
> >>>
> >>
> >> I think this may also be what Dave was heading towards in [2] but in t=
hat
> >> example and above the counter configuration appears to be global. You =
do mention
> >> "configurability supported by hardware" so I wonder if per-domain coun=
ter
> >> configuration is a requirement?
> >
> > If it's global and we want a particular group to be watched by more
> > counters, I wouldn't want this to result in allocating more counters
> > for that group in all domains, or allocating counters in domains where
> > they're not needed. I want to encourage my users to avoid allocating
> > monitoring resources in domains where a job is not allowed to run so
> > there's less pressure on the counters.
> >
> > In Dave's proposal it looks like global configuration means
> > globally-defined "named counter configurations", which works because
> > it's really per-domain assignment of the configurations to however
> > many counters the group needs in each domain.
>
> I think I am becoming lost. Would a global configuration not break your
> view of "event-set applied to a single counter"? If a counter is configur=
ed
> globally then it would not make it possible to support the full configura=
bility
> of the hardware.
> Before I add more confusion, let me try with an example that builds on yo=
ur
> earlier example copied below:
>
> >>> (per domain)
> >>> group 0:
> >>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>> group 1:
> >>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>> ...
>
> Since the above states "per domain" I rewrite the example to highlight th=
at as
> I understand it:
>
> group 0:
>  domain 0:
>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 1: VictimBW,LclNTWr,RmtNTWr
>  domain 1:
>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 1: VictimBW,LclNTWr,RmtNTWr
> group 1:
>  domain 0:
>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 3: VictimBW,LclNTWr,RmtNTWr
>  domain 1:
>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 3: VictimBW,LclNTWr,RmtNTWr
>
> You mention that you do not want counters to be allocated in domains that=
 they
> are not needed in. So, let's say group 0 does not need counter 0 and coun=
ter 1
> in domain 1, resulting in:
>
> group 0:
>  domain 0:
>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 1: VictimBW,LclNTWr,RmtNTWr
> group 1:
>  domain 0:
>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 3: VictimBW,LclNTWr,RmtNTWr
>  domain 1:
>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 3: VictimBW,LclNTWr,RmtNTWr
>
> With counter 0 and counter 1 available in domain 1, these counters could
> theoretically be configured to give group 1 more data in domain 1:
>
> group 0:
>  domain 0:
>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 1: VictimBW,LclNTWr,RmtNTWr
> group 1:
>  domain 0:
>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>   counter 3: VictimBW,LclNTWr,RmtNTWr
>  domain 1:
>   counter 0: LclFill,RmtFill
>   counter 1: LclNTWr,RmtNTWr
>   counter 2: LclSlowFill,RmtSlowFill
>   counter 3: VictimBW
>
> The counters are shown with different per-domain configurations that seem=
s to
> match with earlier goals of (a) choose events counted by each counter and
> (b) do not allocate counters in domains where they are not needed. As I
> understand the above does contradict global counter configuration though.
> Or do you mean that only the *name* of the counter is global and then
> that it is reconfigured as part of every assignment?

Yes, I meant only the *name* is global. I assume based on a particular
system configuration, the user will settle on a handful of useful
groupings to count.

Perhaps mbm_assign_control syntax is the clearest way to express an example=
...

 # define global configurations (in ABMC terms), not necessarily in this
 # syntax and probably not in the mbm_assign_control file.

 r=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill
 w=3DVictimBW,LclNTWr,RmtNTWr

 # legacy "total" configuration, effectively r+w
 t=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr

 /group0/0=3Dt;1=3Dt
 /group1/0=3Dt;1=3Dt
 /group2/0=3D_;1=3Dt
 /group3/0=3Drw;1=3D_

- group2 is restricted to domain 0
- group3 is restricted to domain 1
- the rest are unrestricted
- In group3, we decided we need to separate read and write traffic

This consumes 4 counters in domain 0 and 3 counters in domain 1.

>
> >> Until now I viewed counter configuration separate from counter assignm=
ent,
> >> similar to how AMD's counters can be configured via mbm_total_bytes_co=
nfig and
> >> mbm_local_bytes_config before they are assigned. That is still per-dom=
ain
> >> counter configuration though, not per-counter.
> >>
> >>> I assume packing all of this info for a group's desired counter
> >>> configuration into a single line (with 32 domains per line on many
> >>> dual-socket AMD configurations I see) would be difficult to look at,
> >>> even if we could settle on a single letter to represent each
> >>> universally.
> >>>
> >>>>
> >>>> My goal is for resctrl to have a user interface that can as much as =
possible
> >>>> be ready for whatever may be required from it years down the line. O=
f course,
> >>>> I may be wrong and resctrl would never need to support more than 26 =
events per
> >>>> resource (*). The risk is that resctrl *may* need to support more th=
an 26 events
> >>>> and how could resctrl support that?
> >>>>
> >>>> What is the risk of supporting more than 26 events? As I highlighted=
 earlier
> >>>> the interface I used as demonstration may become unwieldy to parse o=
n a system
> >>>> with many domains that supports many events. This is a concern for m=
e. Any suggestions
> >>>> will be appreciated, especially from you since I know that you are v=
ery familiar with
> >>>> issues related to large scale use of resctrl interfaces.
> >>>
> >>> It's mainly just the unwieldiness of all the information in one file.
> >>> It's already at the limit of what I can visually look through.
> >>
> >> I agree.
> >>
> >>>
> >>> I believe that shared assignments will take care of all the
> >>> high-frequency and performance-intensive batch configuration updates =
I
> >>> was originally concerned about, so I no longer see much benefit in
> >>> finding ways to textually encode all this information in a single fil=
e
> >>> when it would be more manageable to distribute it around the
> >>> filesystem hierarchy.
> >>
> >> This is significant. The motivation for the single file was to support
> >> the "high-frequency and performance-intensive" usage. Would "shared as=
signments"
> >> not also depend on the same files that, if distributed, will require m=
any
> >> filesystem operations?
> >> Having the files distributed will be significantly simpler while also
> >> avoiding the file size issue that Dave Martin exposed.
> >
> > The remaining filesystem operations will be assigning or removing
> > shared counter assignments in the applicable domains, which would
> > normally correspond to mkdir/rmdir of groups or changing their CPU
> > affinity. The shared assignments are more "program and forget", while
> > the exclusive assignment approach requires updates for every counter
> > (in every domain) every few seconds to cover a large number of groups.
> >
> > When they want to pay extra attention to a particular group, I expect
> > they'll ask for exclusive counters and leave them assigned for a while
> > as they collect extra data.
>
> The single file approach is already unwieldy. The demands that will be
> placed on it to support the usages currently being discussed would make t=
his
> interface even harder to use and manage. If the single file is not requir=
ed
> then I think we should go back to smaller files distributed in resctrl.
> This may not even be an either/or argument. One way to view mbm_assign_co=
ntrol
> could be as a way for user to interact with the distributed counter
> related files with a single file system operation. Although, without
> knowing how counter configuration is expected to work this remains unclea=
r.

If we do both interfaces and the multi-file model gives us more
capability to express configurations, we could find situations where
there are configurations we cannot represent when reading back from
mbm_assign_control, or updates through mbm_assign_control have
ambiguous effects on existing configurations which were created with
other files.

However, the example I gave above seems to be adequately represented
by a minor extension to mbm_assign_control and we all seem to
understand it now, so maybe it's not broken yet. It's unfortunate that
work went into a requirement that's no longer relevant, but I don't
think that on its own is a blocker.

-Peter

