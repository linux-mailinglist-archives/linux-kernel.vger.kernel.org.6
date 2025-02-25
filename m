Return-Path: <linux-kernel+bounces-532023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC13A447B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B4C1897002
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEA1A08AB;
	Tue, 25 Feb 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oM9wlbSX"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF918EFDE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503521; cv=none; b=VWY2nk4EIVGqTfiJ3VHT5qq8gu2zdOeFD3bf8ii57d4/p38mOSJQC11xqzZtwrzS1IdE4eivIfXlJ7bcf60n9E6eOVolcMSBb3g6jpEzB8W/gBcRpSlwucIWX2Q2Uv8ZKvWnDijsI83nwjxLlO6TwsBunPnbzzqAiFOgB724Q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503521; c=relaxed/simple;
	bh=pT0cgQ/2YRswFVMSWOEQo2QDG4yANrD8ulG6IkEXgXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mp/nBCu8wlDoVxRg4GmF9f3CVB/TnCmyHbH16ONLe2jOC0qWgdKOnLd3SB6yJJmouGn7jg1vJwt1ViuQ6sLmfn8jODxUX/v8u6GNMcmkk86ztoBF9UghFsieqocV0fSVvOhpp9pfmX+un2Oak2uia+GE3fGlch3sNbjPNhmuiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oM9wlbSX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so6199299f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503517; x=1741108317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjuCQZ8fLcYJByklqY+YYETf7iUkFw9wOFlS6kZvT5g=;
        b=oM9wlbSXP/btH80b5J+cpYSy7k7tdEA2f7QSvuZUjQmrRmrazlxHNDdzYOwvygcjCg
         SYHWdHZKtOMKKnIPNn3VTfYb6ZfsA57TQGRoUEqLWOnwSS58IlTSFAuBN0KV1trfJH7e
         HJhwlpLaBBRsR2HOLj5JeplI9TtYdzBamfeZESu4eSbXsi3baIHx7kCcBd9C5LJFJSm/
         LFicavLX/R7c2VcT3mp43Jzt582BKNe6TUa1fJwohEavTniy64y9tkYqutxsUnpfcZ6i
         PQBglt0Wbjb3z3Y2hPC4j0njYyYaJlroCmbVQSAdIPsU5fIDLOgGzTNdh7XcTl4EzYRV
         eGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503517; x=1741108317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjuCQZ8fLcYJByklqY+YYETf7iUkFw9wOFlS6kZvT5g=;
        b=uUmQ1Aw7YkKfGEn+0PNey4PCm+bfeyybo68jtzoLI9+zpjHhjmKqwNfM/Q0jE/dyj1
         Y7K4W2rmIM2HuD8zXVUI1LOHLMqL8asY/vsG/MaN+jkHn/oahGvJYJSiMQ+ZenjvsEM1
         IO3oV9zbo5WdeB3cBzBQAUnBTn7ax2eOjCLsTH2oo/+uivaGuuywd3M2DFtvICcZ8/aK
         iOIfVHsFmx1Uk+phbtXgEZLDcFC9naJ5jXcA7GAFlslHcTDNaPA7hB49Cc7moSdTLUej
         QdDXYFY4HYzq9/+2WuWEwuGxzmY3JLCllLM2tf0JF+ngXpo4vt9MdNpNRJ7ChMkNUWQY
         NylA==
X-Forwarded-Encrypted: i=1; AJvYcCVq3TZqScewB/yrL7Qfopn8YkZrM9Y81aIAdYRWm97NqiawocHCDsQLMjxkhEQL9Pu7mw+pgDlesN1AKaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZxvZVPKppgkUr1XXXmGEds/Hso7facKN7V2sTdGQKslu0BOG
	yS8Z30BDq1ZCeY2rYGGZzhUxNgyhKHycjpN4kfeqFzPgrjBhKq43eUU6azbu6uKmx0h9Dsq1z5M
	pIx9/lMJV8A/gyiAoH8xRwsmmgpLrxlZKqgvs
X-Gm-Gg: ASbGncu1eL2WWIlhN1d+S/or0YBsmqPjNKo7SR116wGzt3Z3NYvoKMTglauGiWWCas8
	EAWtwyfHSlcAqogYuaZ2nm8lOxbqZD+YuP514H9fe32WKg6IkWR+va5ThMeQojCSCxlm5KrC6wa
	OGzdt7j2xZpl8Pb3jOuEoeNmCEOVKQbAueCsUrAw==
X-Google-Smtp-Source: AGHT+IEs2UzyPqafTS1Hg0rgAd3RRkUGIGcwjfSlD2z+sO6XPjIjlYsGHXbXTr6PQWsea9N14XgeZBn2j//4Qxc2/GE=
X-Received: by 2002:a05:6000:2aa:b0:38f:577f:2f6d with SMTP id
 ffacd0b85a97d-390cc5f57c3mr4218793f8f.2.1740503516687; Tue, 25 Feb 2025
 09:11:56 -0800 (PST)
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
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
In-Reply-To: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 25 Feb 2025 18:11:44 +0100
X-Gm-Features: AQ5f1JqS9hrB_6jkfSQO-em0_LCeLs8enePd6Hnl0g-Dg22KG-BfTapELHMNHfI
Message-ID: <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
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

On Fri, Feb 21, 2025 at 11:43=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 2/21/25 5:12 AM, Peter Newman wrote:
> > On Thu, Feb 20, 2025 at 7:36=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >> On 2/20/25 6:53 AM, Peter Newman wrote:
> >>> On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
> >>> <reinette.chatre@intel.com> wrote:
> >>>> On 2/19/25 3:28 AM, Peter Newman wrote:
> >>>>> On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> >>>>> <reinette.chatre@intel.com> wrote:
> >>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>>>>>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wro=
te:
> >>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>>>>>>>
> >>>>>>>> (quoting relevant parts with goal to focus discussion on new pos=
sible syntax)
> >>>>>>>>
> >>>>>>>>>>>> I see the support for MPAM events distinct from the support =
of assignable counters.
> >>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be as=
signed with existing interface.
> >>>>>>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Doing so would need to come up with alphabetical letters for=
 these events,
> >>>>>>>>>>>> which seems to be needed for your proposal also? If we use p=
ossible flags of:
> >>>>>>>>>>>>
> >>>>>>>>>>>> mbm_local_read_bytes a
> >>>>>>>>>>>> mbm_local_write_bytes b
> >>>>>>>>>>>>
> >>>>>>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_ass=
ign_control
> >>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_byte=
s
> >>>>>>>>>>>> <value>
> >>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>>>>>>>
> >>>>>>>>>>>> One issue would be when resctrl needs to support more than 2=
6 events (no more flags available),
> >>>>>>>>>>>> assuming that upper case would be used for "shared" counters=
 (unless this interface is defined
> >>>>>>>>>>>> differently and only few uppercase letters used for it). Wou=
ld this be too low of a limit?
> >>>>>>>>
> >>>>>>>> As mentioned above, one possible issue with existing interface i=
s that
> >>>>>>>> it is limited to 26 events (assuming only lower case letters are=
 used). The limit
> >>>>>>>> is low enough to be of concern.
> >>>>>>>
> >>>>>>> The events which can be monitored by a single counter on ABMC and=
 MPAM
> >>>>>>> so far are combinable, so 26 counters per group today means it li=
mits
> >>>>>>> breaking down MBM traffic for each group 26 ways. If a user compl=
ained
> >>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting the=
ir
> >>>>>>> investigation, I would question whether they know what they're lo=
oking
> >>>>>>> for.
> >>>>>>
> >>>>>> The key here is "so far" as well as the focus on MBM only.
> >>>>>>
> >>>>>> It is impossible for me to predict what we will see in a couple of=
 years
> >>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctr=
l interface
> >>>>>> to support their users. Just looking at the Intel RDT spec the eve=
nt register
> >>>>>> has space for 32 events for each "CPU agent" resource. That does n=
ot take into
> >>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony al=
ready mentioned
> >>>>>> that he is working on patches [1] that will add new events and sha=
red the idea
> >>>>>> that we may be trending to support "perf" like events associated w=
ith RMID. I
> >>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to su=
pport their
> >>>>>> customers.
> >>>>>> This all makes me think that resctrl should be ready to support mo=
re events than 26.
> >>>>>
> >>>>> I was thinking of the letters as representing a reusable, user-defi=
ned
> >>>>> event-set for applying to a single counter rather than as individua=
l
> >>>>> events, since MPAM and ABMC allow us to choose the set of events ea=
ch
> >>>>> one counts. Wherever we define the letters, we could use more symbo=
lic
> >>>>> event names.
> >>>>
> >>>> Thank you for clarifying.
> >>>>
> >>>>>
> >>>>> In the letters as events model, choosing the events assigned to a
> >>>>> group wouldn't be enough information, since we would want to contro=
l
> >>>>> which events should share a counter and which should be counted by
> >>>>> separate counters. I think the amount of information that would nee=
d
> >>>>> to be encoded into mbm_assign_control to represent the level of
> >>>>> configurability supported by hardware would quickly get out of hand=
.
> >>>>>
> >>>>> Maybe as an example, one counter for all reads, one counter for all
> >>>>> writes in ABMC would look like...
> >>>>>
> >>>>> (L3_QOS_ABMC_CFG.BwType field names below)
> >>>>>
> >>>>> (per domain)
> >>>>> group 0:
> >>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>> group 1:
> >>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>> ...
> >>>>>
> >>>>
> >>>> I think this may also be what Dave was heading towards in [2] but in=
 that
> >>>> example and above the counter configuration appears to be global. Yo=
u do mention
> >>>> "configurability supported by hardware" so I wonder if per-domain co=
unter
> >>>> configuration is a requirement?
> >>>
> >>> If it's global and we want a particular group to be watched by more
> >>> counters, I wouldn't want this to result in allocating more counters
> >>> for that group in all domains, or allocating counters in domains wher=
e
> >>> they're not needed. I want to encourage my users to avoid allocating
> >>> monitoring resources in domains where a job is not allowed to run so
> >>> there's less pressure on the counters.
> >>>
> >>> In Dave's proposal it looks like global configuration means
> >>> globally-defined "named counter configurations", which works because
> >>> it's really per-domain assignment of the configurations to however
> >>> many counters the group needs in each domain.
> >>
> >> I think I am becoming lost. Would a global configuration not break you=
r
> >> view of "event-set applied to a single counter"? If a counter is confi=
gured
> >> globally then it would not make it possible to support the full config=
urability
> >> of the hardware.
> >> Before I add more confusion, let me try with an example that builds on=
 your
> >> earlier example copied below:
> >>
> >>>>> (per domain)
> >>>>> group 0:
> >>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>> group 1:
> >>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>> ...
> >>
> >> Since the above states "per domain" I rewrite the example to highlight=
 that as
> >> I understand it:
> >>
> >> group 0:
> >>  domain 0:
> >>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>  domain 1:
> >>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >> group 1:
> >>  domain 0:
> >>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>  domain 1:
> >>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>
> >> You mention that you do not want counters to be allocated in domains t=
hat they
> >> are not needed in. So, let's say group 0 does not need counter 0 and c=
ounter 1
> >> in domain 1, resulting in:
> >>
> >> group 0:
> >>  domain 0:
> >>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >> group 1:
> >>  domain 0:
> >>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>  domain 1:
> >>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>
> >> With counter 0 and counter 1 available in domain 1, these counters cou=
ld
> >> theoretically be configured to give group 1 more data in domain 1:
> >>
> >> group 0:
> >>  domain 0:
> >>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >> group 1:
> >>  domain 0:
> >>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>  domain 1:
> >>   counter 0: LclFill,RmtFill
> >>   counter 1: LclNTWr,RmtNTWr
> >>   counter 2: LclSlowFill,RmtSlowFill
> >>   counter 3: VictimBW
> >>
> >> The counters are shown with different per-domain configurations that s=
eems to
> >> match with earlier goals of (a) choose events counted by each counter =
and
> >> (b) do not allocate counters in domains where they are not needed. As =
I
> >> understand the above does contradict global counter configuration thou=
gh.
> >> Or do you mean that only the *name* of the counter is global and then
> >> that it is reconfigured as part of every assignment?
> >
> > Yes, I meant only the *name* is global. I assume based on a particular
> > system configuration, the user will settle on a handful of useful
> > groupings to count.
> >
> > Perhaps mbm_assign_control syntax is the clearest way to express an exa=
mple...
> >
> >  # define global configurations (in ABMC terms), not necessarily in thi=
s
> >  # syntax and probably not in the mbm_assign_control file.
> >
> >  r=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill
> >  w=3DVictimBW,LclNTWr,RmtNTWr
> >
> >  # legacy "total" configuration, effectively r+w
> >  t=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
> >
> >  /group0/0=3Dt;1=3Dt
> >  /group1/0=3Dt;1=3Dt
> >  /group2/0=3D_;1=3Dt
> >  /group3/0=3Drw;1=3D_
> >
> > - group2 is restricted to domain 0
> > - group3 is restricted to domain 1
> > - the rest are unrestricted
> > - In group3, we decided we need to separate read and write traffic
> >
> > This consumes 4 counters in domain 0 and 3 counters in domain 1.
> >
>
> I see. Thank you for the example.
>
> resctrl supports per-domain configurations with the following possible wh=
en
> using mbm_total_bytes_config and mbm_local_bytes_config:
>
> t(domain 0)=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,Rm=
tNTWr
> t(domain 1)=3DLclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>
>    /group0/0=3Dt;1=3Dt
>    /group1/0=3Dt;1=3Dt
>
> Even though the flags are identical in all domains, the assigned counters=
 will
> be configured differently in each domain.
>
> With this supported by hardware and currently also supported by resctrl i=
t seems
> reasonable to carry this forward to what will be supported next.

The hardware supports both a per-domain mode, where all groups in a
domain use the same configurations and are limited to two events per
group and a per-group mode where every group can be configured and
assigned freely. This series is using the legacy counter access mode
where only counters whose BwType matches an instance of QOS_EVT_CFG_n
in the domain can be read. If we chose to read the assigned counter
directly (QM_EVTSEL[ExtendedEvtID]=3D1, QM_EVTSEL[EvtID]=3DL3CacheABMC)
rather than asking the hardware to find the counter by RMID, we would
not be limited to 2 counters per group/domain and the hardware would
have the same flexibility as on MPAM.

(I might have said something confusing in my last messages because I
had forgotten that I switched to the extended assignment mode when
prototyping with soft-ABMC and MPAM.)

Forcing all groups on a domain to share the same 2 counter
configurations would not be acceptable for us, as the example I gave
earlier is one I've already been asked about.

I'm worried about requiring support for domain-level
mbm_total_bytes_config and mbm_local_bytes_config files to be carried
forward, because this conflicts with the configuration being per
group/domain. (i.e., what would be read back from the domain files if
per-group customizations have already been applied?)

>
> >>
> >>>> Until now I viewed counter configuration separate from counter assig=
nment,
> >>>> similar to how AMD's counters can be configured via mbm_total_bytes_=
config and
> >>>> mbm_local_bytes_config before they are assigned. That is still per-d=
omain
> >>>> counter configuration though, not per-counter.
> >>>>
> >>>>> I assume packing all of this info for a group's desired counter
> >>>>> configuration into a single line (with 32 domains per line on many
> >>>>> dual-socket AMD configurations I see) would be difficult to look at=
,
> >>>>> even if we could settle on a single letter to represent each
> >>>>> universally.
> >>>>>
> >>>>>>
> >>>>>> My goal is for resctrl to have a user interface that can as much a=
s possible
> >>>>>> be ready for whatever may be required from it years down the line.=
 Of course,
> >>>>>> I may be wrong and resctrl would never need to support more than 2=
6 events per
> >>>>>> resource (*). The risk is that resctrl *may* need to support more =
than 26 events
> >>>>>> and how could resctrl support that?
> >>>>>>
> >>>>>> What is the risk of supporting more than 26 events? As I highlight=
ed earlier
> >>>>>> the interface I used as demonstration may become unwieldy to parse=
 on a system
> >>>>>> with many domains that supports many events. This is a concern for=
 me. Any suggestions
> >>>>>> will be appreciated, especially from you since I know that you are=
 very familiar with
> >>>>>> issues related to large scale use of resctrl interfaces.
> >>>>>
> >>>>> It's mainly just the unwieldiness of all the information in one fil=
e.
> >>>>> It's already at the limit of what I can visually look through.
> >>>>
> >>>> I agree.
> >>>>
> >>>>>
> >>>>> I believe that shared assignments will take care of all the
> >>>>> high-frequency and performance-intensive batch configuration update=
s I
> >>>>> was originally concerned about, so I no longer see much benefit in
> >>>>> finding ways to textually encode all this information in a single f=
ile
> >>>>> when it would be more manageable to distribute it around the
> >>>>> filesystem hierarchy.
> >>>>
> >>>> This is significant. The motivation for the single file was to suppo=
rt
> >>>> the "high-frequency and performance-intensive" usage. Would "shared =
assignments"
> >>>> not also depend on the same files that, if distributed, will require=
 many
> >>>> filesystem operations?
> >>>> Having the files distributed will be significantly simpler while als=
o
> >>>> avoiding the file size issue that Dave Martin exposed.
> >>>
> >>> The remaining filesystem operations will be assigning or removing
> >>> shared counter assignments in the applicable domains, which would
> >>> normally correspond to mkdir/rmdir of groups or changing their CPU
> >>> affinity. The shared assignments are more "program and forget", while
> >>> the exclusive assignment approach requires updates for every counter
> >>> (in every domain) every few seconds to cover a large number of groups=
.
> >>>
> >>> When they want to pay extra attention to a particular group, I expect
> >>> they'll ask for exclusive counters and leave them assigned for a whil=
e
> >>> as they collect extra data.
> >>
> >> The single file approach is already unwieldy. The demands that will be
> >> placed on it to support the usages currently being discussed would mak=
e this
> >> interface even harder to use and manage. If the single file is not req=
uired
> >> then I think we should go back to smaller files distributed in resctrl=
.
> >> This may not even be an either/or argument. One way to view mbm_assign=
_control
> >> could be as a way for user to interact with the distributed counter
> >> related files with a single file system operation. Although, without
> >> knowing how counter configuration is expected to work this remains unc=
lear.
> >
> > If we do both interfaces and the multi-file model gives us more
> > capability to express configurations, we could find situations where
> > there are configurations we cannot represent when reading back from
> > mbm_assign_control, or updates through mbm_assign_control have
> > ambiguous effects on existing configurations which were created with
> > other files.
>
> Right. My assumption was that the syntax would be identical.
>
> >
> > However, the example I gave above seems to be adequately represented
> > by a minor extension to mbm_assign_control and we all seem to
>
> To confirm what you mean with "minor extension to mbm_assign_control",
> is this where the flags are associated with counter configurations? At th=
is
> time this is done separately from mbm_assign_control with the hardcoded "=
t"
> and "l" flags configured via mbm_total_bytes_config and mbm_local_bytes
> respectively. I think it would be simpler to keep these configurations
> separate from mbm_assign_control. How it would look without better
> understanding of MPAM is not clear to me at this time, unless if the
> requirement is to enhance support for ABMC and BMEC. I do see that
> this can be added later to build on what is supported by mbm_assign_contr=
ol
> with the syntax in this version.

As I explained above, I was looking at this from the perspective of
the extended event assignment mode.

Thanks,
-Peter

