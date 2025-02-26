Return-Path: <linux-kernel+bounces-533962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E3A460E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4914E1899DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE40621CA07;
	Wed, 26 Feb 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLu3w03s"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D455218ABB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576449; cv=none; b=m/fApQmbfmT9n5L+cwDeNkvprqZouIyTxQMeq5iJu1EuD7N1rBUWmX/RE655qMbQ3KlALMu357pl7x4mpSTcGrJCc3lXmAugxwg1BqCq6TYR3ketRBOchvnZUXSnLZlZGf0RyvE2/KNH80oreVzfDIIFyu2/A6/H9Q23boRNb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576449; c=relaxed/simple;
	bh=4N7dtnKCn25G5CAmFNqtjbE0R23Rvt2fJ2eWDWvxrME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSflkxaNjS1mXNQFASSWced9Q8Hxn15aETAxK22/Y41YjWqdtHCOuuq42WT4QbpRQkWJsJwn3u81vX2IH0VOAuEjq7bUF5nTZxUU/8/k3PCMyYocFvVhv3WuI0cevNZinkUe9VkGsPEgAHdGPewTvDwHjl7AmbwLiO/Zt6Iptbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLu3w03s; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so12690091a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740576446; x=1741181246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5pEQ5VhFC4gUMpU/bvl/X0X3nFac0XRXhUEfAP6LDw=;
        b=hLu3w03sIj5dzF9ec27MuPVFROsQP75ChHndC+tYSgV2UK/lQbJCpoCRGZCrG++mVd
         hJgx4oegZt5eSZO07xVQbZ3Q7DtePpN72i1jvD2Da7OsSRft6SA6TGzrnLuTLLnanU/B
         lwK/kZreGRZjQiSOjnr2MAmw+zjl2TqPEPhc/JB0IUEvVHP46o8LFJIgGbxlaO+XVeKb
         Oslt8vXdgJuXN/0TFk3E/pqvI9N8ocmRAiWwJjoj+doZK0mDXB6XA2xK+Wxk45NFgdKK
         XPT+5afLYXuJXQHfpzm0FCZJD1mc+QL5jxBzq50G/GP46zxg5nFzgQFJceIKXj/RwUOA
         s2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576446; x=1741181246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5pEQ5VhFC4gUMpU/bvl/X0X3nFac0XRXhUEfAP6LDw=;
        b=Ju43Jdki9IQc0QNXucO8+p3SiGvvda5TLqAL9Ne+zxnsd8gp2/kqPTy9eD8k9+S1SC
         EJn+rZs42QSE2y8fFyTzp7XM3KgX3lOTD4FIkx4eqLju2QaQPbqJpl56BclC3JJeNkY7
         VWYld0i+c5Y22DluTe/te2NJAOzDVV9pFXbP+muw1wgJ34nZI3DO+B+iRTg+k4yOHpa/
         SbINJmc66SyH7O7ukbZlwFcxwwm0fdrtdFoGlJykeumg4JbUGE2ZW/dBLBNg0VDnADOs
         3MBOrViRTc6H1y7QA0sUFURTKxKBCFHGo09q3gd88yyDg6eR9QQ/sDsfc3TQEEPSskCY
         9pHw==
X-Forwarded-Encrypted: i=1; AJvYcCUyanSEo65i9tWqEbcfZXjcofGsbl4ra23v948ofYOwFccQM3WX4QG+ZVUbSXYcLqAKElzNDMjBjt0XODo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybO/M1OlNhm9XZUeVrHiq2XnF8YzgEyZ40FaHR8oPgIDUxcwg7
	eb1OCEy0X9T417Td8BfJSssCyBPLqF7kL0ngzXuJ6DnEIwF6kotN1MTrUxqbGJ0frnSnb9SowAF
	EmDyrGMXLtytKvSV46iStvf445b12DRZn/bFV
X-Gm-Gg: ASbGnctdCpRkCP7eHQToOuMOuk4TVw67h8oBAJUeqS1+xH8MHin/O/xo+Y9qQPD31mR
	6jatmsOwyblVaEAL+gFiW8XOkw4lDQa8Ded8mc/TQK5OuppsCPvbFiZtCe6VQrgVM/z51lAgT1o
	TyJmzmsCKqReCZeiGnMR8kINyDjyp1El9x43AEkQ==
X-Google-Smtp-Source: AGHT+IHb0sZG1UKIjmmh98VqtWyhn0qnIigjT71KOofLIqA5cGitXDnAcKH56RGgWtoqWE/zs2/HObflyy8ztwkX1IY=
X-Received: by 2002:a17:907:97cf:b0:abe:c84e:2ae6 with SMTP id
 a640c23a62f3a-abed0ce5d76mr738834266b.14.1740576445372; Wed, 26 Feb 2025
 05:27:25 -0800 (PST)
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
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com> <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com> <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
In-Reply-To: <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 26 Feb 2025 14:27:14 +0100
X-Gm-Features: AQ5f1Jor_KqYzQk1qN0Fe2eFfB0MOdzVlOuTZZK5SJm2SNzUCE2BAUjDRmAveU8
Message-ID: <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu" <bmoger@amd.com>, 
	Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com, 
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org, 
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

Hi Babu,

On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Moger, Babu <babu.moger@amd.com> w=
rote:
>
> Hi Peter,
>
> On 2/25/25 11:11, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Fri, Feb 21, 2025 at 11:43=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 2/21/25 5:12 AM, Peter Newman wrote:
> >>> On Thu, Feb 20, 2025 at 7:36=E2=80=AFPM Reinette Chatre
> >>> <reinette.chatre@intel.com> wrote:
> >>>> On 2/20/25 6:53 AM, Peter Newman wrote:
> >>>>> On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
> >>>>> <reinette.chatre@intel.com> wrote:
> >>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
> >>>>>>> On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> >>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>>>>>>>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre w=
rote:
> >>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrot=
e:
> >>>>>>>>>>
> >>>>>>>>>> (quoting relevant parts with goal to focus discussion on new p=
ossible syntax)
> >>>>>>>>>>
> >>>>>>>>>>>>>> I see the support for MPAM events distinct from the suppor=
t of assignable counters.
> >>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be =
assigned with existing interface.
> >>>>>>>>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters f=
or these events,
> >>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use=
 possible flags of:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> mbm_local_read_bytes a
> >>>>>>>>>>>>>> mbm_local_write_bytes b
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_a=
ssign_control
> >>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_by=
tes
> >>>>>>>>>>>>>> <value>
> >>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> One issue would be when resctrl needs to support more than=
 26 events (no more flags available),
> >>>>>>>>>>>>>> assuming that upper case would be used for "shared" counte=
rs (unless this interface is defined
> >>>>>>>>>>>>>> differently and only few uppercase letters used for it). W=
ould this be too low of a limit?
> >>>>>>>>>>
> >>>>>>>>>> As mentioned above, one possible issue with existing interface=
 is that
> >>>>>>>>>> it is limited to 26 events (assuming only lower case letters a=
re used). The limit
> >>>>>>>>>> is low enough to be of concern.
> >>>>>>>>>
> >>>>>>>>> The events which can be monitored by a single counter on ABMC a=
nd MPAM
> >>>>>>>>> so far are combinable, so 26 counters per group today means it =
limits
> >>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user com=
plained
> >>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting t=
heir
> >>>>>>>>> investigation, I would question whether they know what they're =
looking
> >>>>>>>>> for.
> >>>>>>>>
> >>>>>>>> The key here is "so far" as well as the focus on MBM only.
> >>>>>>>>
> >>>>>>>> It is impossible for me to predict what we will see in a couple =
of years
> >>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resc=
trl interface
> >>>>>>>> to support their users. Just looking at the Intel RDT spec the e=
vent register
> >>>>>>>> has space for 32 events for each "CPU agent" resource. That does=
 not take into
> >>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony =
already mentioned
> >>>>>>>> that he is working on patches [1] that will add new events and s=
hared the idea
> >>>>>>>> that we may be trending to support "perf" like events associated=
 with RMID. I
> >>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to =
support their
> >>>>>>>> customers.
> >>>>>>>> This all makes me think that resctrl should be ready to support =
more events than 26.
> >>>>>>>
> >>>>>>> I was thinking of the letters as representing a reusable, user-de=
fined
> >>>>>>> event-set for applying to a single counter rather than as individ=
ual
> >>>>>>> events, since MPAM and ABMC allow us to choose the set of events =
each
> >>>>>>> one counts. Wherever we define the letters, we could use more sym=
bolic
> >>>>>>> event names.
> >>>>>>
> >>>>>> Thank you for clarifying.
> >>>>>>
> >>>>>>>
> >>>>>>> In the letters as events model, choosing the events assigned to a
> >>>>>>> group wouldn't be enough information, since we would want to cont=
rol
> >>>>>>> which events should share a counter and which should be counted b=
y
> >>>>>>> separate counters. I think the amount of information that would n=
eed
> >>>>>>> to be encoded into mbm_assign_control to represent the level of
> >>>>>>> configurability supported by hardware would quickly get out of ha=
nd.
> >>>>>>>
> >>>>>>> Maybe as an example, one counter for all reads, one counter for a=
ll
> >>>>>>> writes in ABMC would look like...
> >>>>>>>
> >>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
> >>>>>>>
> >>>>>>> (per domain)
> >>>>>>> group 0:
> >>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>> group 1:
> >>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>> ...
> >>>>>>>
> >>>>>>
> >>>>>> I think this may also be what Dave was heading towards in [2] but =
in that
> >>>>>> example and above the counter configuration appears to be global. =
You do mention
> >>>>>> "configurability supported by hardware" so I wonder if per-domain =
counter
> >>>>>> configuration is a requirement?
> >>>>>
> >>>>> If it's global and we want a particular group to be watched by more
> >>>>> counters, I wouldn't want this to result in allocating more counter=
s
> >>>>> for that group in all domains, or allocating counters in domains wh=
ere
> >>>>> they're not needed. I want to encourage my users to avoid allocatin=
g
> >>>>> monitoring resources in domains where a job is not allowed to run s=
o
> >>>>> there's less pressure on the counters.
> >>>>>
> >>>>> In Dave's proposal it looks like global configuration means
> >>>>> globally-defined "named counter configurations", which works becaus=
e
> >>>>> it's really per-domain assignment of the configurations to however
> >>>>> many counters the group needs in each domain.
> >>>>
> >>>> I think I am becoming lost. Would a global configuration not break y=
our
> >>>> view of "event-set applied to a single counter"? If a counter is con=
figured
> >>>> globally then it would not make it possible to support the full conf=
igurability
> >>>> of the hardware.
> >>>> Before I add more confusion, let me try with an example that builds =
on your
> >>>> earlier example copied below:
> >>>>
> >>>>>>> (per domain)
> >>>>>>> group 0:
> >>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>> group 1:
> >>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>> ...
> >>>>
> >>>> Since the above states "per domain" I rewrite the example to highlig=
ht that as
> >>>> I understand it:
> >>>>
> >>>> group 0:
> >>>>  domain 0:
> >>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>  domain 1:
> >>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>> group 1:
> >>>>  domain 0:
> >>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>  domain 1:
> >>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>
> >>>> You mention that you do not want counters to be allocated in domains=
 that they
> >>>> are not needed in. So, let's say group 0 does not need counter 0 and=
 counter 1
> >>>> in domain 1, resulting in:
> >>>>
> >>>> group 0:
> >>>>  domain 0:
> >>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>> group 1:
> >>>>  domain 0:
> >>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>  domain 1:
> >>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>
> >>>> With counter 0 and counter 1 available in domain 1, these counters c=
ould
> >>>> theoretically be configured to give group 1 more data in domain 1:
> >>>>
> >>>> group 0:
> >>>>  domain 0:
> >>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>> group 1:
> >>>>  domain 0:
> >>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>  domain 1:
> >>>>   counter 0: LclFill,RmtFill
> >>>>   counter 1: LclNTWr,RmtNTWr
> >>>>   counter 2: LclSlowFill,RmtSlowFill
> >>>>   counter 3: VictimBW
> >>>>
> >>>> The counters are shown with different per-domain configurations that=
 seems to
> >>>> match with earlier goals of (a) choose events counted by each counte=
r and
> >>>> (b) do not allocate counters in domains where they are not needed. A=
s I
> >>>> understand the above does contradict global counter configuration th=
ough.
> >>>> Or do you mean that only the *name* of the counter is global and the=
n
> >>>> that it is reconfigured as part of every assignment?
> >>>
> >>> Yes, I meant only the *name* is global. I assume based on a particula=
r
> >>> system configuration, the user will settle on a handful of useful
> >>> groupings to count.
> >>>
> >>> Perhaps mbm_assign_control syntax is the clearest way to express an e=
xample...
> >>>
> >>>  # define global configurations (in ABMC terms), not necessarily in t=
his
> >>>  # syntax and probably not in the mbm_assign_control file.
> >>>
> >>>  r=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>  w=3DVictimBW,LclNTWr,RmtNTWr
> >>>
> >>>  # legacy "total" configuration, effectively r+w
> >>>  t=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
> >>>
> >>>  /group0/0=3Dt;1=3Dt
> >>>  /group1/0=3Dt;1=3Dt
> >>>  /group2/0=3D_;1=3Dt
> >>>  /group3/0=3Drw;1=3D_
> >>>
> >>> - group2 is restricted to domain 0
> >>> - group3 is restricted to domain 1
> >>> - the rest are unrestricted
> >>> - In group3, we decided we need to separate read and write traffic
> >>>
> >>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
> >>>
> >>
> >> I see. Thank you for the example.
> >>
> >> resctrl supports per-domain configurations with the following possible=
 when
> >> using mbm_total_bytes_config and mbm_local_bytes_config:
> >>
> >> t(domain 0)=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr=
,RmtNTWr
> >> t(domain 1)=3DLclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
> >>
> >>    /group0/0=3Dt;1=3Dt
> >>    /group1/0=3Dt;1=3Dt
> >>
> >> Even though the flags are identical in all domains, the assigned count=
ers will
> >> be configured differently in each domain.
> >>
> >> With this supported by hardware and currently also supported by resctr=
l it seems
> >> reasonable to carry this forward to what will be supported next.
> >
> > The hardware supports both a per-domain mode, where all groups in a
> > domain use the same configurations and are limited to two events per
> > group and a per-group mode where every group can be configured and
> > assigned freely. This series is using the legacy counter access mode
> > where only counters whose BwType matches an instance of QOS_EVT_CFG_n
> > in the domain can be read. If we chose to read the assigned counter
> > directly (QM_EVTSEL[ExtendedEvtID]=3D1, QM_EVTSEL[EvtID]=3DL3CacheABMC)
> > rather than asking the hardware to find the counter by RMID, we would
> > not be limited to 2 counters per group/domain and the hardware would
> > have the same flexibility as on MPAM.
>
> In extended mode, the contents of a specific counter can be read by
> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=3D1,
> [EvtID]=3DL3CacheABMC and setting [RMID] to the desired counter ID. Readi=
ng
> QM_CTR will then return the contents of the specified counter.
>
> It is documented below.
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/prog=
rammer-references/24593.pdf
>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>
> We previously discussed this with you (off the public list) and I
> initially proposed the extended assignment mode.
>
> Yes, the extended mode allows greater flexibility by enabling multiple
> counters to be assigned to the same group, rather than being limited to
> just two.
>
> However, the challenge is that we currently lack the necessary interfaces
> to configure multiple events per group. Without these interfaces, the
> extended mode is not practical at this time.
>
> Therefore, we ultimately agreed to use the legacy mode, as it does not
> require modifications to the existing interface, allowing us to continue
> using it as is.
>
> >
> > (I might have said something confusing in my last messages because I
> > had forgotten that I switched to the extended assignment mode when
> > prototyping with soft-ABMC and MPAM.)
> >
> > Forcing all groups on a domain to share the same 2 counter
> > configurations would not be acceptable for us, as the example I gave
> > earlier is one I've already been asked about.
>
> I don=E2=80=99t see this as a blocker. It should be considered an extensi=
on to the
> current ABMC series. We can easily build on top of this series once we
> finalize how to configure the multiple event interface for each group.

I don't think it is, either. Only being able to use ABMC to assign
counters is fine for our use as an incremental step. My longer-term
concern is the domain-scoped mbm_total_bytes_config and
mbm_local_bytes_config files, but they were introduced with BMEC, so
there's already an expectation that the files are present when BMEC is
supported.

On ABMC hardware that also supports BMEC, I'm concerned about enabling
ABMC when only the BMEC-style event configuration interface exists.
The scope of my issue is just whether enabling "full" ABMC support
will require an additional opt-in, since that could remove the BMEC
interface. If it does, it's something we can live with.

-Peter

