Return-Path: <linux-kernel+bounces-424583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2CE9DB64D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89828B2639E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2700194C6A;
	Thu, 28 Nov 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBD90AYc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FA192D82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792251; cv=none; b=jmRd2PKH3NRV/bPXGSGtJm4q0swcSht7ApH40UojHPtKKyI/hUnwoD3vFpeGwGE9lNYsxy9+lHI3CUkiIYr2jOu7M3nJHtX69TNUuKctGd5Ujlm8GoRLYnNaP3RmQd20sNvbzFSht69cA9REzOlJnWNFhKL3DwckylDr6auYBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792251; c=relaxed/simple;
	bh=vU4mFUiZeoJ8mNfxo9AUZOBvs+rispKvfk1czHNy4C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isTH92hAxRcMvK7tPlw+HzyPz6lFW+V8c4NylVbgwxxrlK87Yy2xvkF9gyvvAmrfuPew0Dc7ah/j90VIDnee1xlMDHumE9TDlyVcyqGHqaGZFBdVnFy/JLwazN9+FDCjoI0QU44NBRPMiG2yMt7f73APZr6U9Hk+TiAFD8M9Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBD90AYc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so7459151fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732792248; x=1733397048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyYOjc4b+Tz8R8t4zcFMUvRg8xgq4W0vy/s8KMmI1Ng=;
        b=CBD90AYcp1vsQziI0JlarFw7BkQFC1/YP93bPmDA7Bes+W7SjrggwVJLypwK3yrg9+
         akRCU1IwLvxteyADo2GjxJVc8eHTQNo2BlEZJDFYCpInD987PI769LeKrN5aicxeD1gr
         TZ/kT6iEp0lMiKX7t99hccWpUM/5mCZM+oCA++CFC7jLL9G5mPtyl84e4cgfTvjpSAHO
         LCyR/3g+mCh84egQ6OwHb4y/DGhC/Gex/zcnna8FtvL6/1Pc0qpjmC32jDz7HXmajhxf
         XjKuuiG5RQ0UfoYk3apuFWCD5KIR12SYAWFoEErTaosrgLkVnC2NRX31JrRyGwuKlcCW
         SvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792248; x=1733397048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyYOjc4b+Tz8R8t4zcFMUvRg8xgq4W0vy/s8KMmI1Ng=;
        b=YV/5Gqqj8WV6vrmWX7sUkyfeTuqbZwhH1g0iN55layXUFSgrgLc9gsP1kxmSG3IWxH
         p6C7fOW9VrnOFg8tUaGJFRz5H1Sej78FAUZEpaec+E2ShngdA28qFEZKfjaZx7b+6tWz
         bvkDDnkk15sgQTlk9fNC3ptqBEVEj6KNuppnofWmc+SEWJtkhSIMZgfILpeaSLZKJQqZ
         FCZ1EpS1qjeENkJi3W54CAeJ8Fn/Rh9ZTlmMx31n+8Ly/uNOzUM46TS4aIk0l2K7cfRW
         lDTV8i626eGxYHRZchnZ1Efq8RCVexUiRWl/9b0T8Z0YiVs6xohe17FGu+wgqB/62HBQ
         aYyA==
X-Forwarded-Encrypted: i=1; AJvYcCVDMsxGUOHCvOeyf2yaMX8YzzWHZ/Hg3IO8CqN4KetMJxA0L7s6/ea9t6R2nLS55J4GO7HvGhh97asatDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNudCbUWSZ+NEfivS6/PwLN43mnHpWXvY5kTgmn/nE0buWRZr
	S/Q/pzBgmD5GGpf9So3DiZaewy06TDEa/BhiuJw3wFHa0c0KVCUzlN27tG1q5vod6pQmMDV+I7K
	AR9f5OxSotloC/N/aqqcebV6W4AvmsHTHrK34
X-Gm-Gg: ASbGncsGvfJkczgK/l7Z/teHtqnhB1rPihPy8KDEw3iRneMHI06rXmLF4/y+HAz7/PU
	xJfY7b3o4lPufqVJm8sLi6ng7LMmmTkY5KuK+pLzquVVuAA0WRMnAdnIqEqaG6A==
X-Google-Smtp-Source: AGHT+IGPOTzi+8FuFlmB/vYskh1wEsPtLgw5bdZfIt7/L3SqV4ncD2DOKqg9nbUCNqbonjthpscVgkOuIL0ELwZSk2M=
X-Received: by 2002:a2e:bcd1:0:b0:2fb:51a2:4f63 with SMTP id
 38308e7fff4ca-2ffd6142a6emr45425511fa.34.1732792247460; Thu, 28 Nov 2024
 03:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730244116.git.babu.moger@amd.com> <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com> <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com> <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com> <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com> <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
In-Reply-To: <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 28 Nov 2024 12:10:36 +0100
Message-ID: <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com, 
	x86@kernel.org, hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, 
	rostedt@goodmis.org, akpm@linux-foundation.org, xiongwei.song@windriver.com, 
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com, 
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com, 
	xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com, 
	brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com, 
	andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com, 
	tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com, 
	eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu, Reinette,

On Wed, Nov 27, 2024 at 8:05=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Babu,
>
> On 11/27/24 6:57 AM, Moger, Babu wrote:
> > Hi Reinette,
> >
> > On 11/26/2024 5:56 PM, Reinette Chatre wrote:
> >> Hi Babu,
> >>
> >> On 11/26/24 3:31 PM, Moger, Babu wrote:
> >>> On 11/25/2024 1:00 PM, Reinette Chatre wrote:
> >>>> On 11/22/24 3:36 PM, Moger, Babu wrote:
> >>>>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
> >>>>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
> >>>>>>> On 11/15/24 18:31, Reinette Chatre wrote:
> >>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
> >>>>>>>>> Provide the interface to display the number of free monitoring =
counters
> >>>>>>>>> available for assignment in each doamin when mbm_cntr_assign is=
 supported.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>>>>>>>> ---
> >>>>>>>>> v9: New patch.
> >>>>>>>>> ---
> >>>>>>>>>     Documentation/arch/x86/resctrl.rst     |  4 ++++
> >>>>>>>>>     arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
> >>>>>>>>>     arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 +++++++++++++++=
+++++++++++
> >>>>>>>>>     3 files changed, 38 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation=
/arch/x86/resctrl.rst
> >>>>>>>>> index 2f3a86278e84..2bc58d974934 100644
> >>>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
> >>>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
> >>>>>>>>> @@ -302,6 +302,10 @@ with the following files:
> >>>>>>>>>         memory bandwidth tracking to a single memory bandwidth =
event per
> >>>>>>>>>         monitoring group.
> >>>>>>>>>     +"available_mbm_cntrs":
> >>>>>>>>> +    The number of free monitoring counters available assignmen=
t in each domain
> >>>>>>>>
> >>>>>>>> "The number of free monitoring counters available assignment" ->=
 "The number of monitoring
> >>>>>>>> counters available for assignment"?
> >>>>>>>>
> >>>>>>>> (not taking into account how text may change after addressing Pe=
ter's feedback)
> >>>>>>>
> >>>>>>> How about this?
> >>>>>>>
> >>>>>>> "The number of monitoring counters available for assignment in ea=
ch domain
> >>>>>>> when the architecture supports mbm_cntr_assign mode. There are a =
total of
> >>>>>>> "num_mbm_cntrs" counters are available for assignment. Counters c=
an be
> >>>>>>> assigned or unassigned individually in each domain. A counter is =
available
> >>>>>>> for new assignment if it is unassigned in all domains."
> >>>>>>
> >>>>>> Please consider the context of this paragraph. It follows right af=
ter the description
> >>>>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned=
 per monitoring group".
> >>>>>> I think it is confusing to follow that with a paragraph that state=
s "Counters can be
> >>>>>> assigned or unassigned individually in each domain." I wonder if i=
t may be helpful to
> >>>>>> use a different term ... for example a counter is *assigned* to an=
 event of a monitoring
> >>>>>> group but this assignment may be to specified (not yet supported) =
or all (this work) domains while
> >>>>>> it is only *programmed*/*activated* to specified domains. Of cours=
e, all of this documentation
> >>>>>> needs to remain coherent if future work decides to indeed support =
per-domain assignment.
> >>>>>>
> >>>>>
> >>>>> Little bit lost here. Please help me.
> >>>>
> >>>> I think this highlights the uncertainty this interface brings. How d=
o you expect users
> >>>> to use this interface? At this time I think this interface can creat=
e a lot of confusion.
> >>>> For example, consider a hypothetical system with three domains and f=
our counters that
> >>>> has the following state per mbm_assign_control:
> >>>>
> >>>> //0=3Dtl;1=3D_;2=3Dl #default group uses counters 0 and 1 to monitor=
 total and local MBM
> >>>> /m1/0=3D_;1=3Dt;2=3Dt #monitor group m1 uses counter 2, just for tot=
al MBM
> >>>> /m2/0=3Dl;1=3D_;2=3Dl #monitor group m2 uses counter 3, just for loc=
al MBM
> >>>> /m3/0=3D_;1=3D_;2=3D_
> >>>>
> >>>> Since, in this system there are only four counters available, and
> >>>> they have all been assigned, then there are no new counters availabl=
e for
> >>>> assignment.
> >>>>
> >>>> If I understand correctly, available_mbm_cntrs will read:
> >>>> 0=3D1;1=3D3;2=3D1
> >>>
> >>> Yes. Exactly. This causes confusion to the user.
> >>>>
> >>>> How is a user to interpret the above numbers? It does not reflect
> >>>> that no counter can be assigned to m3, instead it reflects which of =
the
> >>>> already assigned counters still need to be activated on domains.
> >>>> If, for example, a user is expected to use this file to know how
> >>>> many counters can still be assigned, should it not reflect the actua=
l
> >>>> available counters. In the above scenario it will then be:
> >>>> 0=3D0;1=3D0;2=3D0
> >>>
> >>> We can also just print
> >>> #cat available_mbm_cntrs
> >>> 0
> >>>
> >>> The domain specific information is not important here.
> >>> That was my original idea. We can go back to that definition. That is=
 more clear to the user.
> >>
> >> Tony's response [1] still applies.
> >>
> >> I believe Tony's suggestion [2] considered that the available counters=
 will be the
> >> same for every domain for this implementation. That is why my example =
noted:
> >> "0=3D0;1=3D0;2=3D0"
> >
> > yes. We can keep it like this.
> >
> >>
> >> The confusion surrounding the global allocator seems to be prevalent (=
[3], [4]) as folks
> >> familiar with resctrl attempt to digest the work. The struggle to make=
 this documentation clear
> >> makes me more concerned how this feature will be perceived by users wh=
o are not as familiar with
> >> resctrl internals. I think that it may be worth it to take a moment an=
d investigate what it will take
> >> to implement a per-domain counter allocator. The hardware supports it =
and I suspect that the upfront
> >> work to do the enabling will make it easier for users to adopt and und=
erstand the feature.
> >>
> >> What do you think?
> >
> > It adds more complexity for sure.
>
> I do see a difference in data structures used but the additional complexi=
ty is not
> obvious to me. It seems like there will be one fewer data structure, the
> global bitmap, and I think that will actually bring with it some simplifi=
cation since
> there is no longer the need to coordinate between the per-domain and glob=
al counters,
> for example the logic that only frees a global counter if it is no longer=
 used by a domain.
>
> This may also simplify the update of the monitor event config (BMEC) sinc=
e it can be
> done directly on counters of the domain instead of needing to go back and=
 forth between
> global and per-domain counters.
>
> >
> > 1. Each group needs to remember counter ids in each domain for each eve=
nt.
> >    For example:
> >    Resctrl group mon1
> >     Total event
> >     dom 0 cntr_id 1,
> >     dom 1 cntr_id 10
> >     dom 2 cntr_id 11
> >
> >    Local event
> >     dom 0 cntr_id 2,
> >     dom 1 cntr_id 15
> >     dom 2 cntr_id 10
>
> Indeed. The challenge here is that domains may come and go so it cannot b=
e a simple
> static array. As an alternative it can be an xarray indexed by the domain=
 ID with
> pointers to a struct like below to contain the counters associated with t=
he monitor
> group:
>         struct cntr_id {
>                 u32     mbm_total;
>                 u32     mbm_local;
>         }
>
>
> Thinking more about how this array needs to be managed made me wonder how=
 the
> current implementation deals with domains that come and go. I do not thin=
k
> this is currently handled. For example, if a new domain comes online and
> monitoring groups had counters dynamically assigned, then these counters =
are
> not configured to the newly online domain.

In my prototype, I allocated a counter id-indexed array to each
monitoring domain structure for tracking the counter allocations,
because the hardware counters are all domain-scoped. That way the
tracking data goes away when the hardware does.

I was focused on allowing all pending counter updates to a domain
resulting from a single mbm_assign_control write to be batched and
processed in a single IPI, so I structured the counter tracker
something like this:

struct resctrl_monitor_cfg {
    int closid;
    int rmid;
    int evtid;
    bool dirty;
};

This mirrors the info needed in whatever register configures the
counter, plus a dirty flag to skip over the ones that don't need to be
updated.

For the benefit of displaying mbm_assign_control, I put a pointer back
to any counter array entry allocated in the mbm_state struct only
because it's an existing structure that exists for every rmid-domain
combination.

I didn't need to change the rdtgroup structure.

>
> >
> >
> > 2. We should have a bitmap of "available counters" in each domain. We h=
ave
> > this already. But allocation method changes.
>
> Would allocation/free not be simpler with only the per-domain bitmap need=
ing
> to be consulted?
>
> One implementation change I can think of is the dynamic assign of counter=
s when
> a monitor group is created. Now a free counter needs to be found in each
> domain. Here it can be discussed if it should be an "all or nothing"
> assignment but the handling does not seem to be complex and would need to=
 be
> solved eventually anyway.
>
> > 3. Dynamic allocation/free of the counters
> >
> > There could be some more things which I can't think right now. It might
> > come up when we start working on it.
> >
> > It is doable. But, is it worth adding this complexity? I am not sure.
>
> Please elaborate where you see that this is too complex.
>
> >
> > Peter mentioned earlier that he was not interested in domain specific
> > assignments. He was only interested in all domain ("*") implementation.
>
> Peter's most recent message indicates otherwise:
> https://lore.kernel.org/all/CALPaoCgiHEaY_cDbCo=3D537JJ7mkYZDFFDs9heYvtQ8=
0fXuuvWQ@mail.gmail.com/

For now, I'm focused on managing the domains locally whenever possible
to avoid all IPIs, as this gives me the least overhead.

I'm also prototyping the 'T' vs 't' approach that Reinette
suggested[1], as this may take a lot of performance pressure off the
mbm_assign_control interface, as most of the routine updates to
counter assignments would be automated.

-Peter

[1] https://lore.kernel.org/lkml/7ee63634-3b55-4427-8283-8e3d38105f41@intel=
.com/

