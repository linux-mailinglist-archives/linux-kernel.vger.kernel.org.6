Return-Path: <linux-kernel+bounces-545014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F3A4E7BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3927A21D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF2280A28;
	Tue,  4 Mar 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxpO2Cry"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B676255248
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106692; cv=none; b=Jm5TzMtLbRZUxnISNnwwvImMcAm/8kpBgoMddzaX/0x9PhR7t4xddJLvGRy3fhiVIsvHPq8lAdMC+J0zGZ4re/gIEALTiJLc4d97W1jR2jYax1SnVxxcstFFMkFAo6ZGO9KiLARjj+HSc4KfqtrIf9KT8lJNPSIL5xW9YsPktKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106692; c=relaxed/simple;
	bh=SLx9fSKjogrblKd/BYuWPLaYan001HkpSXgLYkxnyY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVVTbt0sOp3cFnxgF/Yl6/4Wk76H1ZsGFuMGFajY6ghj4W8N1SGkl25/ho9gsVR33zVLFwK/zPEBuXVXEpcTwXe85lxBboZIjkxfXiMSwZJ4tYrGjn8w6Ukoq8aHkZakD8JprkM3JyTl3ug0ojHDW1Au04tk7Ct8mvMQBLhnUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxpO2Cry; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso10943764a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741106688; x=1741711488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=662UDMyMmmNrU5mUl1jjXb05rs8g1e2GXb448rS4pfI=;
        b=gxpO2CryjYl08cPnXdoR3TiaJq4IujapG8gMiUNm3dns6bjTupv6hUFMeXQHSiGHYx
         0R5AI9X0kLXwSONCDv85PEAv+/eZdXIraKV0ZhFhOGcU0HJ1v3x5l7naAYBytYNcKjAR
         AJ0vQ8av+mZGhzQdzpuYfg7fSeqw7DSJshm1uI9tEZIw8nDzjvh+JLHpmllLte9FpIjD
         Bn1RCZmoo7Z4HpMeyghD6RfDYs83d43njfpbZyzZO9zQmMFztO+96+8vMuKM9ma5CkNq
         drdXAAUUgNVtvr3D+Xw3i//y4bCer1nNKerVUrfI7Dc/JxWK5P8i7vLyO9ThHOJ3ObQ4
         DBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106688; x=1741711488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=662UDMyMmmNrU5mUl1jjXb05rs8g1e2GXb448rS4pfI=;
        b=RdXqc7AWPcVbaP3dgLmD3sMvqV+cHkFk+TyDFYcYvqHadczl1gscirLwKqu9iV6psi
         ckmDo2wvQzuH/v6jCMVxaQewzwIoSXlgopP6yUu7JdVD0PcFhnXxCk7IHXV+U7nJVF+v
         4XOL0cPmDzzX6uRwegCwHYGnuEX9Zh/QbA3hssj7LA/nXTjHuXgxlPQzz6ikysj0AOby
         b5NWtk5AAEY/xwdPkA/7audm8N+OGVk2sxGWsChchIedknSqqCQyOvt94ajaiR1AWYAB
         XbTYejiQtVpAMztPFGDkLrXlOgH5x/8FPbONjwbjBvyAL4pthNZl8u1Ajcbnu3Svq/75
         ru2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoesJGkR/14QHzn3TstRBTeYdtfnTCVhi7weL2FqGPwxQ0IcCRhNVOKz3nZ7EZDk1Ie6CdGlSoJpdgaGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6+wNT3NSvJpR/xinWDcMYUDogePCht5mZAT5aR3Z7GzUyliD
	miJ81RcKeEr2uHyRlXDeBIAsLAZItnBX7wR/Y1CIe7+vpFvkqd+JeE0qf1frujJ021/rFmLkBIR
	OXGyD/XeJfcEH1oC3kTSYyLvS2mjf1+AErFUS
X-Gm-Gg: ASbGncvHTANGxH+MRGEIiL6xAyWgZWZ/GbqJOfTBbFZu4MJIGaNfxnNaToofLXnMBi0
	iW9mCWZrSffqP2e1xNLDzBqoVBNVqybbCfeUYCSUI8VBPO0967WDz+dTORsbweoYxzvCNqOMGZF
	d77Oj/COV4B3f9oNpwLwvl2m3CQyryLV3Scw3b/XnHuvmtscINK70OwpGf
X-Google-Smtp-Source: AGHT+IFIb9Z8HvM6OmZQazfCRNAXk3w8gLV0G6yd2Xey3eDwyBO5ZR2u7rdtYgYQaI7W1xJbuKa5wmc+BNKRJTYLMtA=
X-Received: by 2002:a17:907:7d89:b0:abf:7832:bf5 with SMTP id
 a640c23a62f3a-abf783244f6mr892441866b.34.1741106687380; Tue, 04 Mar 2025
 08:44:47 -0800 (PST)
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
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com> <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
In-Reply-To: <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 4 Mar 2025 17:44:34 +0100
X-Gm-Features: AQ5f1JrGSx73Ujj73PaFIlbj05aFNZyMo7fc0ofDb2tBwehUD22NWivFBtYVG2s
Message-ID: <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
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

On Mon, Mar 3, 2025 at 8:16=E2=80=AFPM Moger, Babu <babu.moger@amd.com> wro=
te:
>
> Hi Peter/Reinette,
>
> On 2/26/25 07:27, Peter Newman wrote:
> > Hi Babu,
> >
> > On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Moger, Babu <babu.moger@amd.co=
m> wrote:
> >>
> >> Hi Peter,
> >>
> >> On 2/25/25 11:11, Peter Newman wrote:
> >>> Hi Reinette,
> >>>
> >>> On Fri, Feb 21, 2025 at 11:43=E2=80=AFPM Reinette Chatre
> >>> <reinette.chatre@intel.com> wrote:
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>> On 2/21/25 5:12 AM, Peter Newman wrote:
> >>>>> On Thu, Feb 20, 2025 at 7:36=E2=80=AFPM Reinette Chatre
> >>>>> <reinette.chatre@intel.com> wrote:
> >>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
> >>>>>>> On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
> >>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
> >>>>>>>>> On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> >>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>>>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre=
 wrote:
> >>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wr=
ote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new=
 possible syntax)
> >>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the supp=
ort of assignable counters.
> >>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can b=
e assigned with existing interface.
> >>>>>>>>>>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters=
 for these events,
> >>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we u=
se possible flags of:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> mbm_local_read_bytes a
> >>>>>>>>>>>>>>>> mbm_local_write_bytes b
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>>>>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm=
_assign_control
> >>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_=
bytes
> >>>>>>>>>>>>>>>> <value>
> >>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more th=
an 26 events (no more flags available),
> >>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" coun=
ters (unless this interface is defined
> >>>>>>>>>>>>>>>> differently and only few uppercase letters used for it).=
 Would this be too low of a limit?
> >>>>>>>>>>>>
> >>>>>>>>>>>> As mentioned above, one possible issue with existing interfa=
ce is that
> >>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters=
 are used). The limit
> >>>>>>>>>>>> is low enough to be of concern.
> >>>>>>>>>>>
> >>>>>>>>>>> The events which can be monitored by a single counter on ABMC=
 and MPAM
> >>>>>>>>>>> so far are combinable, so 26 counters per group today means i=
t limits
> >>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user c=
omplained
> >>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting=
 their
> >>>>>>>>>>> investigation, I would question whether they know what they'r=
e looking
> >>>>>>>>>>> for.
> >>>>>>>>>>
> >>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
> >>>>>>>>>>
> >>>>>>>>>> It is impossible for me to predict what we will see in a coupl=
e of years
> >>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on re=
sctrl interface
> >>>>>>>>>> to support their users. Just looking at the Intel RDT spec the=
 event register
> >>>>>>>>>> has space for 32 events for each "CPU agent" resource. That do=
es not take into
> >>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Ton=
y already mentioned
> >>>>>>>>>> that he is working on patches [1] that will add new events and=
 shared the idea
> >>>>>>>>>> that we may be trending to support "perf" like events associat=
ed with RMID. I
> >>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements t=
o support their
> >>>>>>>>>> customers.
> >>>>>>>>>> This all makes me think that resctrl should be ready to suppor=
t more events than 26.
> >>>>>>>>>
> >>>>>>>>> I was thinking of the letters as representing a reusable, user-=
defined
> >>>>>>>>> event-set for applying to a single counter rather than as indiv=
idual
> >>>>>>>>> events, since MPAM and ABMC allow us to choose the set of event=
s each
> >>>>>>>>> one counts. Wherever we define the letters, we could use more s=
ymbolic
> >>>>>>>>> event names.
> >>>>>>>>
> >>>>>>>> Thank you for clarifying.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> In the letters as events model, choosing the events assigned to=
 a
> >>>>>>>>> group wouldn't be enough information, since we would want to co=
ntrol
> >>>>>>>>> which events should share a counter and which should be counted=
 by
> >>>>>>>>> separate counters. I think the amount of information that would=
 need
> >>>>>>>>> to be encoded into mbm_assign_control to represent the level of
> >>>>>>>>> configurability supported by hardware would quickly get out of =
hand.
> >>>>>>>>>
> >>>>>>>>> Maybe as an example, one counter for all reads, one counter for=
 all
> >>>>>>>>> writes in ABMC would look like...
> >>>>>>>>>
> >>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
> >>>>>>>>>
> >>>>>>>>> (per domain)
> >>>>>>>>> group 0:
> >>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>> group 1:
> >>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>> ...
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I think this may also be what Dave was heading towards in [2] bu=
t in that
> >>>>>>>> example and above the counter configuration appears to be global=
. You do mention
> >>>>>>>> "configurability supported by hardware" so I wonder if per-domai=
n counter
> >>>>>>>> configuration is a requirement?
> >>>>>>>
> >>>>>>> If it's global and we want a particular group to be watched by mo=
re
> >>>>>>> counters, I wouldn't want this to result in allocating more count=
ers
> >>>>>>> for that group in all domains, or allocating counters in domains =
where
> >>>>>>> they're not needed. I want to encourage my users to avoid allocat=
ing
> >>>>>>> monitoring resources in domains where a job is not allowed to run=
 so
> >>>>>>> there's less pressure on the counters.
> >>>>>>>
> >>>>>>> In Dave's proposal it looks like global configuration means
> >>>>>>> globally-defined "named counter configurations", which works beca=
use
> >>>>>>> it's really per-domain assignment of the configurations to howeve=
r
> >>>>>>> many counters the group needs in each domain.
> >>>>>>
> >>>>>> I think I am becoming lost. Would a global configuration not break=
 your
> >>>>>> view of "event-set applied to a single counter"? If a counter is c=
onfigured
> >>>>>> globally then it would not make it possible to support the full co=
nfigurability
> >>>>>> of the hardware.
> >>>>>> Before I add more confusion, let me try with an example that build=
s on your
> >>>>>> earlier example copied below:
> >>>>>>
> >>>>>>>>> (per domain)
> >>>>>>>>> group 0:
> >>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>> group 1:
> >>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>> ...
> >>>>>>
> >>>>>> Since the above states "per domain" I rewrite the example to highl=
ight that as
> >>>>>> I understand it:
> >>>>>>
> >>>>>> group 0:
> >>>>>>  domain 0:
> >>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>  domain 1:
> >>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>> group 1:
> >>>>>>  domain 0:
> >>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>  domain 1:
> >>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>
> >>>>>> You mention that you do not want counters to be allocated in domai=
ns that they
> >>>>>> are not needed in. So, let's say group 0 does not need counter 0 a=
nd counter 1
> >>>>>> in domain 1, resulting in:
> >>>>>>
> >>>>>> group 0:
> >>>>>>  domain 0:
> >>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>> group 1:
> >>>>>>  domain 0:
> >>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>  domain 1:
> >>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>
> >>>>>> With counter 0 and counter 1 available in domain 1, these counters=
 could
> >>>>>> theoretically be configured to give group 1 more data in domain 1:
> >>>>>>
> >>>>>> group 0:
> >>>>>>  domain 0:
> >>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>> group 1:
> >>>>>>  domain 0:
> >>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>  domain 1:
> >>>>>>   counter 0: LclFill,RmtFill
> >>>>>>   counter 1: LclNTWr,RmtNTWr
> >>>>>>   counter 2: LclSlowFill,RmtSlowFill
> >>>>>>   counter 3: VictimBW
> >>>>>>
> >>>>>> The counters are shown with different per-domain configurations th=
at seems to
> >>>>>> match with earlier goals of (a) choose events counted by each coun=
ter and
> >>>>>> (b) do not allocate counters in domains where they are not needed.=
 As I
> >>>>>> understand the above does contradict global counter configuration =
though.
> >>>>>> Or do you mean that only the *name* of the counter is global and t=
hen
> >>>>>> that it is reconfigured as part of every assignment?
> >>>>>
> >>>>> Yes, I meant only the *name* is global. I assume based on a particu=
lar
> >>>>> system configuration, the user will settle on a handful of useful
> >>>>> groupings to count.
> >>>>>
> >>>>> Perhaps mbm_assign_control syntax is the clearest way to express an=
 example...
> >>>>>
> >>>>>  # define global configurations (in ABMC terms), not necessarily in=
 this
> >>>>>  # syntax and probably not in the mbm_assign_control file.
> >>>>>
> >>>>>  r=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>  w=3DVictimBW,LclNTWr,RmtNTWr
> >>>>>
> >>>>>  # legacy "total" configuration, effectively r+w
> >>>>>  t=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNT=
Wr
> >>>>>
> >>>>>  /group0/0=3Dt;1=3Dt
> >>>>>  /group1/0=3Dt;1=3Dt
> >>>>>  /group2/0=3D_;1=3Dt
> >>>>>  /group3/0=3Drw;1=3D_
> >>>>>
> >>>>> - group2 is restricted to domain 0
> >>>>> - group3 is restricted to domain 1
> >>>>> - the rest are unrestricted
> >>>>> - In group3, we decided we need to separate read and write traffic
> >>>>>
> >>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
> >>>>>
> >>>>
> >>>> I see. Thank you for the example.
> >>>>
> >>>> resctrl supports per-domain configurations with the following possib=
le when
> >>>> using mbm_total_bytes_config and mbm_local_bytes_config:
> >>>>
> >>>> t(domain 0)=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNT=
Wr,RmtNTWr
> >>>> t(domain 1)=3DLclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
> >>>>
> >>>>    /group0/0=3Dt;1=3Dt
> >>>>    /group1/0=3Dt;1=3Dt
> >>>>
> >>>> Even though the flags are identical in all domains, the assigned cou=
nters will
> >>>> be configured differently in each domain.
> >>>>
> >>>> With this supported by hardware and currently also supported by resc=
trl it seems
> >>>> reasonable to carry this forward to what will be supported next.
> >>>
> >>> The hardware supports both a per-domain mode, where all groups in a
> >>> domain use the same configurations and are limited to two events per
> >>> group and a per-group mode where every group can be configured and
> >>> assigned freely. This series is using the legacy counter access mode
> >>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
> >>> in the domain can be read. If we chose to read the assigned counter
> >>> directly (QM_EVTSEL[ExtendedEvtID]=3D1, QM_EVTSEL[EvtID]=3DL3CacheABM=
C)
> >>> rather than asking the hardware to find the counter by RMID, we would
> >>> not be limited to 2 counters per group/domain and the hardware would
> >>> have the same flexibility as on MPAM.
> >>
> >> In extended mode, the contents of a specific counter can be read by
> >> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=3D1,
> >> [EvtID]=3DL3CacheABMC and setting [RMID] to the desired counter ID. Re=
ading
> >> QM_CTR will then return the contents of the specified counter.
> >>
> >> It is documented below.
> >> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/p=
rogrammer-references/24593.pdf
> >>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
> >>
> >> We previously discussed this with you (off the public list) and I
> >> initially proposed the extended assignment mode.
> >>
> >> Yes, the extended mode allows greater flexibility by enabling multiple
> >> counters to be assigned to the same group, rather than being limited t=
o
> >> just two.
> >>
> >> However, the challenge is that we currently lack the necessary interfa=
ces
> >> to configure multiple events per group. Without these interfaces, the
> >> extended mode is not practical at this time.
> >>
> >> Therefore, we ultimately agreed to use the legacy mode, as it does not
> >> require modifications to the existing interface, allowing us to contin=
ue
> >> using it as is.
> >>
> >>>
> >>> (I might have said something confusing in my last messages because I
> >>> had forgotten that I switched to the extended assignment mode when
> >>> prototyping with soft-ABMC and MPAM.)
> >>>
> >>> Forcing all groups on a domain to share the same 2 counter
> >>> configurations would not be acceptable for us, as the example I gave
> >>> earlier is one I've already been asked about.
> >>
> >> I don=E2=80=99t see this as a blocker. It should be considered an exte=
nsion to the
> >> current ABMC series. We can easily build on top of this series once we
> >> finalize how to configure the multiple event interface for each group.
> >
> > I don't think it is, either. Only being able to use ABMC to assign
> > counters is fine for our use as an incremental step. My longer-term
> > concern is the domain-scoped mbm_total_bytes_config and
> > mbm_local_bytes_config files, but they were introduced with BMEC, so
> > there's already an expectation that the files are present when BMEC is
> > supported.
> >
> > On ABMC hardware that also supports BMEC, I'm concerned about enabling
> > ABMC when only the BMEC-style event configuration interface exists.
> > The scope of my issue is just whether enabling "full" ABMC support
> > will require an additional opt-in, since that could remove the BMEC
> > interface. If it does, it's something we can live with.
>
> As you know, this series is currently blocked without further feedback.
>
> I=E2=80=99d like to begin reworking these patches to incorporate Peter=E2=
=80=99s feedback.
> Any input or suggestions would be appreciated.
>
> Here=E2=80=99s what we=E2=80=99ve learned so far:
>
> 1. Assignments should be independent of BMEC.
> 2. We should be able to specify multiple event types to a counter (e.g.,
> read, write, victimBM, etc.). This is also called shared counter
> 3. There should be an option to assign events per domain.
> 4. Currently, only two counters can be assigned per group, but the design
> should allow flexibility to assign more in the future as the interface
> evolves.
> 5. Utilize the extended RMID read mode.
>
>
> Here is my proposal using Peter's earlier example:
>
> # define event configurations
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> Bits    Mnemonics       Description
> =3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 6       VictimBW        Dirty Victims from all types of memory
> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
> 2       LclNTWr         Non-temporal writes to local NUMA domain
> 1       mtFill          Reads to memory in the non-local NUMA domain
> 0       LclFill         Reads to memory in the local NUMA domain
> =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> #Define flags based on combination of above event types.
>
> t =3D LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
> l =3D LclFill, LclNTWr, LclSlowFill
> r =3D LclFill,RmtFill,LclSlowFill,RmtSlowFill
> w =3D VictimBW,LclNTWr,RmtNTWr
> v =3D VictimBW
>
> Peter suggested the following format earlier :
>
> /group0/0=3Dt;1=3Dt
> /group1/0=3Dt;1=3Dt
> /group2/0=3D_;1=3Dt
> /group3/0=3Drw;1=3D_

After some inquiries within Google, it sounds like nobody has invested
much into the current mbm_assign_control format yet, so it would be
best to drop it and distribute the configuration around the filesystem
hierarchy[1], which should allow us to produce something more flexible
and cleaner to implement.

Roughly what I had in mind:

Use mkdir in a info/<resource>_MON subdirectory to create free-form
names for the assignable configurations rather than being restricted
to single letters.  In the resulting directory, populate a file where
we can specify the set of events the config should represent. I think
we should use symbolic names for the events rather than raw BMEC field
values. Moving forward we could come up with portable names for common
events and only support the BMEC names on AMD machines for users who
want specific events and don't care about portability.

Next, put assignment-control file nodes in per-domain directories
(i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
counter-configuration name into the file would then allocate a counter
in the domain, apply the named configuration, and monitor the parent
group-directory. We can also put a group/resource-scoped assign_* file
higher in the hierarchy to make it easier for users who want to
configure all domains the same for a group.

The configuration names listed in assign_* would result in files of
the same name in the appropriate mon_data domain directories from
which the count values can be read.

 # mkdir info/L3_MON/counter_configs/mbm_local_bytes
 # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
 # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
 # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
LclFill
LclNTWr
LclSlowFill

Note that we could also pre-populate info/L3_MON/counter_configs with
the expected configuration for mbm_local_bytes and mbm_total_bytes for
backwards compatibility.

To manually allocate counters for "mbm_local_bytes":

 # mkdir test
 # echo mbm_local_bytes > test/mon_data/mon_L3_00/assign_exclusive
 # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
 # echo mbm_local_bytes > test/mon_data/mon_L3_02/assign_exclusive
[..]

Which would result in the creation of test/mon_data/mon_L3_*/mbm_local_byte=
s

For unassignment, we can just make an "unassign" node alongside
"assign_exclusive" and "assign_shared". These should provide enough
context to form resctrl_arch_config_cntr() calls.

-Peter

[1] https://lore.kernel.org/lkml/CALPaoCj1TH+GN6+dFnt5xuN406u=3DtB-8mj+UuMR=
Sm5KWPJW2wg@mail.gmail.com/

