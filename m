Return-Path: <linux-kernel+bounces-273223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38287946600
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF5C2824CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C113A406;
	Fri,  2 Aug 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02iSVBoa"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770221ABEDD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639034; cv=none; b=V2S+aAGJzprrvCjbifPryD6VPfW5HeL+l3WYm798fM7e2dqVUBJDkF5+VUHi7Bh9FbLBRxdABwjmCO0eg9U0tgV817Kmz98UCFb3TUJy8CPBuKvVLtrB087NyMseSrOvwO8Z2B5m0jMgqIQq6lbbctjfkAMQP6sEM6wVDbBT9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639034; c=relaxed/simple;
	bh=Lz433szemY81Khu0vn90dYlaxMCyjw/psqtSquI5qHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOlxR8REIPhFXkRC39uqAu1Qc69iNquZGt/6WYh/b/MwhTshITjZENl0PSS/6IXPP2x0qceSK1n42MC0C5Snggmbvg44MhFx6v5qaV9gzAYeIP8oUGrFCmHn3fkauBLEuMB8D8L8dcg/grOsZV+OthW58qZ9oZHzsliZb5GAWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02iSVBoa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so59991a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722639031; x=1723243831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz433szemY81Khu0vn90dYlaxMCyjw/psqtSquI5qHo=;
        b=02iSVBoahyOiZ5eHB2cwc36BH1RFyFmGhepSjSpBE7g6lyCWHkZRvfYThIzRIYfho2
         Te7LbvTx3XHkby3El6qACIK2rQjKa8FkarsalMrldRZdkn9PNRQdA3AaMfpNomEeG9ZE
         9uiNbGEylCq6HJaA1TvyckXaMhT4gfu1lWRZIES3Nk8CsBHkjRSKjX+quDPWEb3kefUo
         I45O6RjOwtEgkg+hju4OTXl3NiTvBj5Mk7wjSNvPt9IU6DGzpYQiIDmAJLJS60JHiVfu
         fEigShDnMHCwRiuxPayboNEofpEkUKbkkZx255MK87oNxtRipt29f/F9qszXTAu50Y/N
         NDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722639031; x=1723243831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz433szemY81Khu0vn90dYlaxMCyjw/psqtSquI5qHo=;
        b=NSiAfoiuVgNT9x9g7wZEe1vlEjqW0SwLWxPyJntnmjGZJ2Qmcf5QAwLNGE+pJEE1hT
         zbWQMVUlE6zEr9yx8dQ4kvDnWP7aZz6IZuvSGuMKDzeSTLWE+u+9rRa3cModtP/r0wW+
         bJz8a0bwvpQmiRFF9P7RygXFQyXll4X+6HdCLLvcgINJIrqE1ajGczaY/AU7io5K8gX+
         EQ0jM29RNJHPrdrxGuEuHGRvI3OmcXMWNdlwBKDoICWd3jND6BchlBcO6n0ziXyTzySj
         OfBJN3Ag2eZSjkkrkotMabQfdvqcrMo/mryUYipx9ourdEgUnteS9H0vFOytkiS3rCDE
         JXCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/VH1/JI8Zw75nqvrbjnaOPgwCpRzKeezLCKHjKrMa9EzokC7rET9O/AGs+X/DaF5uzqV9e9aa5/Qq6pYkEnqBe9HtqHFwNmz9VkHv
X-Gm-Message-State: AOJu0Ywba3i2UIJqraC2atyo/aEeQIp1sMFn1KAUE9FTD30NCGIwDhr5
	BqG8i+vjkYYkz1JIgLu+2qN1hD+8YvfXnmEDeUoyWKmuU0O9d8LY2p+kSlzlpIx+PNMWLdKQxeX
	rJBVE3BIltRlJ2H37vU1NVLQvuqwxXSv6XNlI
X-Google-Smtp-Source: AGHT+IHjS406OsupmiOhjoHudvD6xuQqstRDy26CM2dgs/KkfNzdNZY2a/zTAw+fdS579lDAiEkHNGE0YxMB+88Dh1A=
X-Received: by 2002:a05:6402:26cb:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b9caf072d4mr18075a12.7.1722639030379; Fri, 02 Aug 2024
 15:50:30 -0700 (PDT)
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
 <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
In-Reply-To: <b9e48e8f-3035-4a7e-a983-ce829bd9215a@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 2 Aug 2024 15:50:19 -0700
Message-ID: <CALPaoCg3KpF94g2MEmfP_Ro2mQZYFA8sKVkmb+7isotKNgdY9A@mail.gmail.com>
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

On Fri, Aug 2, 2024 at 1:55=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 8/2/24 11:49 AM, Peter Newman wrote:
> > On Fri, Aug 2, 2024 at 9:14=E2=80=AFAM Reinette Chatre
> >> I am of course not familiar with details of the software implementatio=
n
> >> - could there be benefits to using it even if hardware counters are
> >> supported?
> >
> > I can't see any situation where the user would want to choose software
> > over hardware counters. The number of groups which can be monitored by
> > software assignable counters will always be less than with hardware,
> > due to the need for consuming one RMID (and the counters automatically
> > allocated to it by the AMD hardware) for all unassigned groups.
>
> Thank you for clarifying. This seems specific to this software implementa=
tion,
> and I missed that there was a shift from soft-RMIDs to soft-ABMC. If I re=
member
> correctly this depends on undocumented hardware specific knowledge.

For the benefit of anyone else who needs to monitor bandwidth on a
large number of monitoring groups on pre-ABMC AMD implementations,
hopefully a future AMD publication will clarify, at least on some
existing, pre-ABMC models, exactly when the QM_CTR.U bit is set.


> >
> > The behavior as I've implemented today is:
> >
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_events
> > 0
> >
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> > test//0=3D_;1=3D_;
> > //0=3D_;1=3D_;
> >
> > # echo "test//1+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> > test//0=3D_;1=3Dtl;
> > //0=3D_;1=3D_;
> >
> > # echo "test//1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> > # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> > test//0=3D_;1=3D_;
> > //0=3D_;1=3D_;
> >
> >
>
> This highlights how there cannot be a generic/consistent interface betwee=
n hardware
> and software implementation. If resctrl implements something like above w=
ithout any
> other hints to user space then it will push complexity to user space sinc=
e user space
> would not know if setting one flag results in setting more than that flag=
, which may
> force a user space implementation to always follow a write with a read th=
at
> needs to confirm what actually resulted from the write. Similarly, that r=
emoving a
> flag impacts other flags needs to be clear without user space needing to =
"try and
> see what happens".

I'll return to this topic in the context of MPAM below...

> It is not clear to me how to interpret the above example when it comes to=
 the
> RMID management though. If the RMID assignment is per group then I expect=
ed all
> the domains of a group to have the same flag(s)?

The group RMIDs are never programmed into any MSRs and the RMID space
is independent in each domain, so it is still possible to do
per-domain assignment. (and like with soft RMIDs, this enables us to
create unlimited groups, but we've never been limited by the size of
the RMID space)

However, in our use cases, jobs are not confined to any domain, so
bandwidth measurements must be done simultaneously in all domains, so
we have no current use for per-domain assignment. But if any Google
users did begin to see value in confining jobs to domains, this could
change.

>
> >>
> >>> However, If we don't expect to see these semantics in any other
> >>> implementation, these semantics could be implicit in the definition o=
f
> >>> a SW assignable counter.
> >>
> >> It is not clear to me how implementation differences between hardware
> >> and software assignment can be hidden from user space. It is possible
> >> to let user space enable individual events and then silently upgrade i=
t
> >> to all events. I see two options here, either "mbm_control" needs to
> >> explicitly show this "silent upgrade" so that user space knows which
> >> events are actually enabled, or "mbm_control" only shows flags/events =
enabled
> >> from user space perspective. In the former scenario, this needs more
> >> user space support since a generic user space cannot be confident whic=
h
> >> flags are set after writing to "mbm_control". In the latter scenario,
> >> meaning of "num_mbm_cntrs" becomes unclear since user space is expecte=
d
> >> to rely on it to know which events can be enabled and if some are
> >> actually "silently enabled" when user space still thinks it needs to b=
e
> >> enabled the number of available counters becomes vague.
> >>
> >> It is not clear to me how to present hardware and software assignable
> >> counters with a single consistent interface. Actually, what if the
> >> "mbm_mode" is what distinguishes how counters are assigned instead of =
how
> >> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
> >> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignabl=
e"
> >> and "mbm_cntr_group_assignable" is used? Could that replace a
> >> potential "mbm_assign_events" while also supporting user space in
> >> interactions with "mbm_control"?
> >
> > If I understand this correctly, is this a preference that the info
> > node be named differently if its value will have different units,
> > rather than a second node to indicate what the value of num_mbm_cntrs
> > actually means? This sounds reasonable to me.
>
> Indeed. As you highlighted, user space may not need to know if
> counters are backed by hardware or software, but user space needs to
> know what to expect from (how to interact with) interface.
>
> > I think it's also important to note that in MPAM, the MBWU (memory
> > bandwidth usage) monitors don't have a concept of local versus total
> > bandwidth, so event assignment would likely not apply there either.
> > What the counted bandwidth actually represents is more implicit in the
> > monitor's position in the memory system in the particular
> > implementation. On a theoretical multi-socket system, resctrl would
> > require knowledge about the system's architecture to stitch together
> > the counts from different types of monitors to produce a local and
> > total value. I don't know if we'd program this SoC-specific knowledge
> > into the kernel to produce a unified MBM resource like we're
> > accustomed to now or if we'd present multiple MBM resources, each only
> > providing an mbm_total_bytes event. In this case, the counters would
> > have to be assigned separately in each MBM resource, especially if the
> > different MBM resources support a different number of counters.
> >
>
> "total" and "local" bandwidth is already in grey area after the
> introduction of mbm_total_bytes_config/mbm_local_bytes_config where
> user space could set values reported to not be constrained by the
> "total" and "local" terms. We keep sticking with it though, even in
> this implementation that uses the "t" and "l" flags, knowing that
> what is actually monitored when "l" is set is just what the user
> configured via mbm_local_bytes_config, which theoretically
> can be "total" bandwidth.

If it makes sense to support a separate, group-assignment interface at
least for MPAM, this would be a better fit for soft-ABMC, even if it
does have to stay downstream.

Thanks,
-Peter

