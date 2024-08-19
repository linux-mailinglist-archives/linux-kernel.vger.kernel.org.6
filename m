Return-Path: <linux-kernel+bounces-292701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D366195732F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625691F2320B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB285189513;
	Mon, 19 Aug 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj3j4MCu"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65CD531
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092068; cv=none; b=H/Tm6X1Ko4xzrDo1bznktCx5UzwjMhpAZMwlO/6k6DLFRBaJVFYnPC72TNLIgXDxj5KKYN2Oo+Jey7sarf7fKvkg0CpOclHbqOqbP6+9T6haWp/juTsl6os7TH2s42leN7V4NSuo0KhLY8eU/8TAE0rV0np/tR9va8aDBOSusXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092068; c=relaxed/simple;
	bh=GrzuF9ETqK0wSaQ2gn3bjMO1MZ7YgepiRwEsqY4/xSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6ReN49ooN0bAOPtuocym6d1iNRqLBsrw6gw3hlgh2o5kLgoGk0M1mdii4Yf9Jqa0Hw9FPi3Lfo3br4cPZ7TWPk8zYxbcH7fNJiBcms/Of3Xjrak511p5LCZs8oyN59ZowaoSOKr///i55fyDK0PxX6c+2wH6eyV1EgLZfHzp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj3j4MCu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso3233606a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724092065; x=1724696865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXfcjOd7OrDKG9spQBdXpPk4BtnCdubI3RqPVTY/z94=;
        b=Kj3j4MCubpKcxTGpm+cWAkDwbLuqX0Cxi3Jhmj09wZSnqfIjs3VaA4iFZqI0+6aLPe
         QoS5+209Mn4iHDgUgt4CmJxyp3dhbVICTZr07uFovkrcCntLz/2yKdgpJWNHS/g3NKOP
         7V5fcNda9ui+eBswuD4gkRlOdZTcAVqYPEhH16BvdgJOueOrj9a9c0jAU1fM2Z0WCmKx
         5eHDQvAedLfUsrPLNmTCZmxJgU464ufxkTgfPiVqBcm3b/odv5XowsKvOIk0zVjibWBO
         yDCeXAjoiDPutCEODTEJEmp2kz/Bgvh/NcWwO5L/ZmGrNE2rjvxg6LCfIajPwfdF8cPG
         RYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092065; x=1724696865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXfcjOd7OrDKG9spQBdXpPk4BtnCdubI3RqPVTY/z94=;
        b=ioUh0aYAl+juLhJYtNPwrdwSwL8rIgYkijdJBPYXhVyhUuyFCSBga2Oy/ISRoZkW9e
         BADO9JHktU3BMoFjfUcBmmkL6v4UOC1wKamhg3BIT2cKK/NAMSko0lkwywuI2hzy6yFH
         GER7SaPuQCPD0sN2RVO9rkmTMJPjkS+8FlpLvBbmYuzagdVSDvQvRfIQreRCd9vOI3KY
         06RdgHI7mD9aGAnHZCCSgM2hg7yTv6e8EDO/oSgeRtgslJDejd5KynjNZvO/Co/VI3A8
         0kfFSi8GCUf1UV0cyMY+zfca8oWxom5F5fOguEWgf+f9LnkOXjU/g5iRblUjpu2venPN
         jalw==
X-Forwarded-Encrypted: i=1; AJvYcCXfMZQLPBqTClfSM5m9KADsh62GH1QAudbbqievXrITOJjmE2m8waW/icMg/eQUxE06rJL0x6MqDB3e6v3D+RLW8BqzB1sg6g+k7+US
X-Gm-Message-State: AOJu0YxDK0ozK5j46DudIdvOKaQ4D2bqTH8bzT5g+MGaOFVGzCOltlxs
	c7RkEUrdGwJ67WyLcV55CZa7hXgnQwo0z+9hD9V61VXUEGcA/XXQj3VXg0yCH6EWrvCFEITrjhS
	tb/kAj/YKqMxLr6x3MiTARnMBfiCmb2WaStyN
X-Google-Smtp-Source: AGHT+IGE9hCFXFW7/ZoM3ST5slr7DI5WQY6KcZ8cwUl9tx8GVfN7Fa8vJlS7zVPIW7Pphw160mce2C5mlT6DqbDTQO0=
X-Received: by 2002:a05:6402:5215:b0:5be:d63a:4608 with SMTP id
 4fb4d7f45d1cf-5bed63a486emr5746480a12.3.1724092064436; Mon, 19 Aug 2024
 11:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722981659.git.babu.moger@amd.com> <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <983fded5-48f8-439d-8afe-45b60841985a@arm.com> <8c93c091-39b3-4219-b892-9df2747eb91a@intel.com>
 <CALPaoCjmRyP00b9rTCjpxwLDJ2rYkQ8HuNMYJA+qVNo5a4Q9JQ@mail.gmail.com>
 <56aae68f-b590-42ec-a6b5-de3af97a8091@intel.com> <96880c73-7f0b-4a62-8f9f-11042dec92c7@intel.com>
In-Reply-To: <96880c73-7f0b-4a62-8f9f-11042dec92c7@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 19 Aug 2024 11:27:33 -0700
Message-ID: <CALPaoCieONpok0ZXyBbWxzFwTT3mq4vPoUuaRsE7_Ad8CY-1AA@mail.gmail.com>
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, x86@kernel.org, 
	hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, mingo@redhat.com, 
	bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com, 
	fenghua.yu@intel.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Mon, Aug 19, 2024 at 7:53=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter and James,
>
> On 8/16/24 11:09 AM, Reinette Chatre wrote:
> > Hi Peter,
> >
> > On 8/16/24 10:16 AM, Peter Newman wrote:
> >> Hi Reinette,
> >>
> >> On Fri, Aug 16, 2024 at 10:01=E2=80=AFAM Reinette Chatre
> >> <reinette.chatre@intel.com> wrote:
> >>>
> >>> Hi James,
> >>>
> >>> On 8/16/24 9:31 AM, James Morse wrote:
> >>>> Hi Babu,
> >>>>
> >>>> On 06/08/2024 23:00, Babu Moger wrote:
> >>>>> Introduce interface to switch between ABMC and legacy modes.
> >>>>>
> >>>>> By default ABMC is enabled on boot if the feature is available.
> >>>>> Provide the interface to go back to legacy mode if required.
> >>>>
> >>>> I may have missed it on an earlier version ... why would anyone want=
 the non-ABMC
> >>>> behaviour on hardware that requires it: counters randomly reset and =
randomly return
> >>>> 'Unavailable'... is that actually useful?
> >>>>
> >>>> You default this to on, so there isn't a backward compatibility argu=
ment here.
> >>>>
> >>>> It seems like being able to disable this is a source of complexity -=
 is it needed?
> >>>
> >>> The ability to go back to legacy was added while looking ahead to sup=
port the next
> >>> "assignable counter" feature that is software based ("soft-RMID" .. "=
soft-ABMC"?).
> >>>
> >>> This series adds support for ABMC on recent AMD hardware to address t=
he issue described
> >>> in cover letter. This issue also exists on earlier AMD hardware that =
does not have the ABMC
> >>> feature and Peter is working on a software solution to address the is=
sue on non-ABMC hardware.
> >>> This software solution is expected to have the same interface as the =
hardware solution but
> >>> earlier discussions revealed that it may introduce extra latency that=
 users may only want to
> >>> accept during periods of active monitoring. Thus the option to disabl=
e the counter assignment
> >>> mode.
> >>
> >> Sorry again for the soft-RMID/soft-ABMC confusion[1], it was soft-RMID
> >> that impacted context switch latency. Soft-ABMC does not require any
> >> additional work at context switch.
> >
> > No problem. I did read [1] but I do not think I've seen soft-ABMC yet s=
o
> > my understanding of what it does is vague.
> >
> >> The only disadvantage to soft-ABMC I can think of is that it also
> >> limits reading llc_occupancy event counts to "assigned" groups,
> >> whereas without it, llc_occupancy works reliably on all RMIDs on AMD
> >> hardware.
> >
> > hmmm ... keeping original llc_occupancy behavior does seem useful enoug=
h
> > as motivation to keep the "legacy"/"default" mbm_assign_mode? It does s=
ound
> > to me as though soft-ABMC may not be as accurate when it comes to llc_o=
ccupancy.
> > As I understand the hardware may tag entries in cache with RMID and tha=
t has a longer
> > lifetime than the tasks that allocated that data into the cache. If sof=
t-ABMC
> > permanently associates an RMID with a local and total counter pair but =
that
> > RMID is dynamically assigned to resctrl groups then a group may not alw=
ays
> > get the same RMID ... and thus its llc_occupancy data would be a combin=
ation of
> > its cache allocations and all the cache allocations of resource groups =
that had
> > that RMID before it. This may need significantly enhanced "limbo" handl=
ing?
>

For the use case of soft-ABMC that I'm aware of, it would be better to
disable llc_occupancy events and accept it as a limitation as we're
not using this feature. I don't want to slow down the rate at which
MBM counters could be reassigned. Over the course of a multiple-second
bandwidth measurement window on a bandwidth-saturated host, a previous
group's initial cache occupancy isn't significant enough to justify a
limbo period, especially when padded out to 1 second.

I would feel differently if my users were more interested in
llc_occupancy counts and it was possible for the LLC to immediately
notify when the occupancy threshold for any of a set of groups has
been crossed.

> To expand on this we may have to rework the interface if the counters can=
 be
> assigned to events other than MBM.
>
> James: could you please elaborate how you plan to use this feature and if=
 this
> interface works for the planned usage?
>
> Peter: considering the previous example [1] where soft-ABMC was using the=
 "mbm_control"
> interface I do not think it is ideal to only use the "t" and "l" flags wh=
ile
> llc_occupancy is also enabled/disabled via this interface. We should cons=
ider
> (a) renaming the control file to indicate larger scope than MBM, (b) add =
flags
> for llc_occupancy. What do you think? I believe this is in line with stat=
ed goal
> from [1]: "I believe mbm_control should always accurately reflect which e=
vents
> are being counted."

I should have said,  "I believe mbm_control should always accurately
reflect which _MBM_ events are being counted."

In general, MBM requires maintaining cumulative, running counts, while
llc_occupancy is only a snapshot of cache usage. This is why MBM
results in contended resources (counters) which must be managed by the
user. In the MPAM implementations I've seen so far, a small number
(relative to the number of monitoring groups supported) of occupancy
monitors is sufficient for a large number of groups, because it only
limits the number of monitoring groups' occupancy counts which can be
read in parallel and can be adequately managed within the MPAM driver
without user interaction.

Because of this, broadening the scope of mbm_control to include
occupancy would only serve to remind the user whether occupancy is
supported, but would provide no new information beyond what's already
provided by mon_features.

-Peter

