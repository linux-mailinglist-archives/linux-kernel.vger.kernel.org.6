Return-Path: <linux-kernel+bounces-546578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 355BAA4FC6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D23A9415
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DBE207DF5;
	Wed,  5 Mar 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agjdR7Rw"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28374207A09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171220; cv=none; b=CLRgs7tN5V3ACzdHwIM1fIEIKDiHxeyjrVpeA/MCEdJ0RZSgfUl9k0JSz14PORB9/8BF+a0iKSNSEpXkNnxLILAAs22AgQqb8YP6VRoDzGyPrA0TPo5Mnqo0cylAjcKf8AodXWioHVPAQNUrMFR3a2bp9S6OeruS+hKhSjAO40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171220; c=relaxed/simple;
	bh=JFvgq7ao/ymDU28XHKEnRDC0Mib0SgN3h70y90DKD58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/UYifbBj3WxdYPTykyicxSFMNxSnl0uQMAxlOlN1YLAOqlPn9yyZLS4xNyaLbY7sJz0nvUhxQWNbD32+XrrmxpvcI733e0yCfttpGSJAmryvg1KkYudZehnpmIlOpIikmeNQoMkCcoD2fDbjI3RDVknf3zW1Yk+UhJyc0lZi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agjdR7Rw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf5358984bso666391066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741171216; x=1741776016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJPeC7WGwlWYhB/uzB+1DEBtKYGH9tap2u2rbrtGD5k=;
        b=agjdR7Rwm8lOXN0KK5vYWWHk4kprIqzICl/Z0w0qoE6JUEV59ruAAe1OnSPYYE+egN
         VJ8TKQeJkRnuB+AplOwlwz8OTI5/w0asxQ+H9kLJQejBiUMw2PZFw0lEsT8d2GHgRT3s
         pzW3hzxwxYGcF8P2YRb1IeA2ysWNmgjDRA4igWd9JTJXkd+sCp8b4m0gPLg27IXo8qgz
         OtkwpbG+tN68uasOSlWSNbGAN2A/J8LsLDHB5SgurPuHs0krv8M+l4HlRXnzmU3EHnpS
         gNnqDq9XjYUMRmyzzJay/uLM0mDO/e15J/3Nz9V+D1Uha/X0LUTIHarvRgFj9s2Kt+S5
         iULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171216; x=1741776016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJPeC7WGwlWYhB/uzB+1DEBtKYGH9tap2u2rbrtGD5k=;
        b=dm+ux6XngEihOAHfZpRmbEhSnJF4DL/HWwRNQ/5P/35wzjBJeMV3IQnFf8YHxFiA6T
         DtKVAzqRG7IsZPKzw0ssfPAo5BXlQyw5w+aRjvrVlZhu4zp+2M2ZqbASfj3oGQcUUInw
         IajmfpB1b1Ztx1UsCBd0k3uqP9U/NMtWt83ZHNg+4rRkJMGm0GtpqoF7lGuQbtY72fmt
         GnIp9EqVtb4XUBZlQcjjv8g78yjuwHFLyGgexiTWT7sh0hzAjXJ+71sJaFjL58HxJeL8
         +CwMu+uzdmQYN8FkcKwxTWWszOWf2QOH8Y7y9YIdS6p+gN6TPDdc3QPS0CLwO8OkyDBd
         QYow==
X-Forwarded-Encrypted: i=1; AJvYcCW6L464tt3ktGbgPTDQjPgU/ydTrSfOl3q22vSL1ycy/7vM0LYxd/A5G8MmgP9DJD8LlCQ7tzbXAYUoENE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHdxjp0Rknj262rADb+leYmSznVxuYzaBbqAJxciMwpr/yUpz
	josWjv6Sd2qNg9+h0J8ldcMNvYwVzXnSEv3dnVnOFpAr0AATVVvTev5xzNeLLjJLyNqul+EdmSq
	3pYERxXPcEeHxz0KnP9W+9NNlyIQ940sQdbx+
X-Gm-Gg: ASbGnct9R7kznz1EcEtTxoD1TTYBR5SFoFLLjyuaQNff7gXgtNaPrt2F6YbF6EasW0L
	UyZaruibJLOnixbIvLar32cOiC91hUn6MAVY/ijivTdtfQ11U8SpA5+3B5M5voOv3Z62cd2gqD9
	bldq9i+GFHcaQUkTAW4O7XtqRPZDbmPO8c7gMIdlLfm58nbUFDGNQKaIw=
X-Google-Smtp-Source: AGHT+IFNcZPME2war2VRyPrCxxqPQYR5G2WucJc73GcnEZ2EKj1EJMiaBAsFyx2Ad7AfFcHrITY0w9Jam3jimjxY6i8=
X-Received: by 2002:a17:906:7950:b0:abf:4521:eb2a with SMTP id
 a640c23a62f3a-ac20db09298mr293383166b.49.1741171215889; Wed, 05 Mar 2025
 02:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737577229.git.babu.moger@amd.com> <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com> <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com> <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com> <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com> <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com> <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com> <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com> <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
In-Reply-To: <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 5 Mar 2025 11:40:04 +0100
X-Gm-Features: AQ5f1Jp2XjXUz1htmJKqxKcBSjIy7LONfvJmHEJ2buLZ8tf-PYo6uZ9pALohx8U
Message-ID: <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 10:49=E2=80=AFPM Moger, Babu <babu.moger@amd.com> wr=
ote:
>
> Hi Peter,
>
> On 3/4/25 10:44, Peter Newman wrote:
> > On Mon, Mar 3, 2025 at 8:16=E2=80=AFPM Moger, Babu <babu.moger@amd.com>=
 wrote:
> >>
> >> Hi Peter/Reinette,
> >>
> >> On 2/26/25 07:27, Peter Newman wrote:
> >>> Hi Babu,
> >>>
> >>> On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Moger, Babu <babu.moger@amd.=
com> wrote:
> >>>>
> >>>> Hi Peter,
> >>>>
> >>>> On 2/25/25 11:11, Peter Newman wrote:
> >>>>> Hi Reinette,
> >>>>>
> >>>>> On Fri, Feb 21, 2025 at 11:43=E2=80=AFPM Reinette Chatre
> >>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>
> >>>>>> Hi Peter,
> >>>>>>
> >>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
> >>>>>>> On Thu, Feb 20, 2025 at 7:36=E2=80=AFPM Reinette Chatre
> >>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
> >>>>>>>>> On Wed, Feb 19, 2025 at 7:21=E2=80=AFPM Reinette Chatre
> >>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
> >>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
> >>>>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
> >>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> >>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
> >>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chat=
re wrote:
> >>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger =
wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on n=
ew possible syntax)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the su=
pport of assignable counters.
> >>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can=
 be assigned with existing interface.
> >>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical lette=
rs for these events,
> >>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we=
 use possible flags of:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
> >>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
> >>>>>>>>>>>>>>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/m=
bm_assign_control
> >>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_rea=
d_bytes
> >>>>>>>>>>>>>>>>>> <value>
> >>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_byt=
es
> >>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes=
>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more =
than 26 events (no more flags available),
> >>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" co=
unters (unless this interface is defined
> >>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it=
). Would this be too low of a limit?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> As mentioned above, one possible issue with existing inter=
face is that
> >>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case lette=
rs are used). The limit
> >>>>>>>>>>>>>> is low enough to be of concern.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The events which can be monitored by a single counter on AB=
MC and MPAM
> >>>>>>>>>>>>> so far are combinable, so 26 counters per group today means=
 it limits
> >>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user=
 complained
> >>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiti=
ng their
> >>>>>>>>>>>>> investigation, I would question whether they know what they=
're looking
> >>>>>>>>>>>>> for.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
> >>>>>>>>>>>>
> >>>>>>>>>>>> It is impossible for me to predict what we will see in a cou=
ple of years
> >>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on =
resctrl interface
> >>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec t=
he event register
> >>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That =
does not take into
> >>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. T=
ony already mentioned
> >>>>>>>>>>>> that he is working on patches [1] that will add new events a=
nd shared the idea
> >>>>>>>>>>>> that we may be trending to support "perf" like events associ=
ated with RMID. I
> >>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements=
 to support their
> >>>>>>>>>>>> customers.
> >>>>>>>>>>>> This all makes me think that resctrl should be ready to supp=
ort more events than 26.
> >>>>>>>>>>>
> >>>>>>>>>>> I was thinking of the letters as representing a reusable, use=
r-defined
> >>>>>>>>>>> event-set for applying to a single counter rather than as ind=
ividual
> >>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of eve=
nts each
> >>>>>>>>>>> one counts. Wherever we define the letters, we could use more=
 symbolic
> >>>>>>>>>>> event names.
> >>>>>>>>>>
> >>>>>>>>>> Thank you for clarifying.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> In the letters as events model, choosing the events assigned =
to a
> >>>>>>>>>>> group wouldn't be enough information, since we would want to =
control
> >>>>>>>>>>> which events should share a counter and which should be count=
ed by
> >>>>>>>>>>> separate counters. I think the amount of information that wou=
ld need
> >>>>>>>>>>> to be encoded into mbm_assign_control to represent the level =
of
> >>>>>>>>>>> configurability supported by hardware would quickly get out o=
f hand.
> >>>>>>>>>>>
> >>>>>>>>>>> Maybe as an example, one counter for all reads, one counter f=
or all
> >>>>>>>>>>> writes in ABMC would look like...
> >>>>>>>>>>>
> >>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
> >>>>>>>>>>>
> >>>>>>>>>>> (per domain)
> >>>>>>>>>>> group 0:
> >>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>>>> group 1:
> >>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>>>> ...
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I think this may also be what Dave was heading towards in [2] =
but in that
> >>>>>>>>>> example and above the counter configuration appears to be glob=
al. You do mention
> >>>>>>>>>> "configurability supported by hardware" so I wonder if per-dom=
ain counter
> >>>>>>>>>> configuration is a requirement?
> >>>>>>>>>
> >>>>>>>>> If it's global and we want a particular group to be watched by =
more
> >>>>>>>>> counters, I wouldn't want this to result in allocating more cou=
nters
> >>>>>>>>> for that group in all domains, or allocating counters in domain=
s where
> >>>>>>>>> they're not needed. I want to encourage my users to avoid alloc=
ating
> >>>>>>>>> monitoring resources in domains where a job is not allowed to r=
un so
> >>>>>>>>> there's less pressure on the counters.
> >>>>>>>>>
> >>>>>>>>> In Dave's proposal it looks like global configuration means
> >>>>>>>>> globally-defined "named counter configurations", which works be=
cause
> >>>>>>>>> it's really per-domain assignment of the configurations to howe=
ver
> >>>>>>>>> many counters the group needs in each domain.
> >>>>>>>>
> >>>>>>>> I think I am becoming lost. Would a global configuration not bre=
ak your
> >>>>>>>> view of "event-set applied to a single counter"? If a counter is=
 configured
> >>>>>>>> globally then it would not make it possible to support the full =
configurability
> >>>>>>>> of the hardware.
> >>>>>>>> Before I add more confusion, let me try with an example that bui=
lds on your
> >>>>>>>> earlier example copied below:
> >>>>>>>>
> >>>>>>>>>>> (per domain)
> >>>>>>>>>>> group 0:
> >>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>>>> group 1:
> >>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>>>> ...
> >>>>>>>>
> >>>>>>>> Since the above states "per domain" I rewrite the example to hig=
hlight that as
> >>>>>>>> I understand it:
> >>>>>>>>
> >>>>>>>> group 0:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>  domain 1:
> >>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>> group 1:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>  domain 1:
> >>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>
> >>>>>>>> You mention that you do not want counters to be allocated in dom=
ains that they
> >>>>>>>> are not needed in. So, let's say group 0 does not need counter 0=
 and counter 1
> >>>>>>>> in domain 1, resulting in:
> >>>>>>>>
> >>>>>>>> group 0:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>> group 1:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>  domain 1:
> >>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>
> >>>>>>>> With counter 0 and counter 1 available in domain 1, these counte=
rs could
> >>>>>>>> theoretically be configured to give group 1 more data in domain =
1:
> >>>>>>>>
> >>>>>>>> group 0:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>> group 1:
> >>>>>>>>  domain 0:
> >>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
> >>>>>>>>  domain 1:
> >>>>>>>>   counter 0: LclFill,RmtFill
> >>>>>>>>   counter 1: LclNTWr,RmtNTWr
> >>>>>>>>   counter 2: LclSlowFill,RmtSlowFill
> >>>>>>>>   counter 3: VictimBW
> >>>>>>>>
> >>>>>>>> The counters are shown with different per-domain configurations =
that seems to
> >>>>>>>> match with earlier goals of (a) choose events counted by each co=
unter and
> >>>>>>>> (b) do not allocate counters in domains where they are not neede=
d. As I
> >>>>>>>> understand the above does contradict global counter configuratio=
n though.
> >>>>>>>> Or do you mean that only the *name* of the counter is global and=
 then
> >>>>>>>> that it is reconfigured as part of every assignment?
> >>>>>>>
> >>>>>>> Yes, I meant only the *name* is global. I assume based on a parti=
cular
> >>>>>>> system configuration, the user will settle on a handful of useful
> >>>>>>> groupings to count.
> >>>>>>>
> >>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express =
an example...
> >>>>>>>
> >>>>>>>  # define global configurations (in ABMC terms), not necessarily =
in this
> >>>>>>>  # syntax and probably not in the mbm_assign_control file.
> >>>>>>>
> >>>>>>>  r=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill
> >>>>>>>  w=3DVictimBW,LclNTWr,RmtNTWr
> >>>>>>>
> >>>>>>>  # legacy "total" configuration, effectively r+w
> >>>>>>>  t=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,Rmt=
NTWr
> >>>>>>>
> >>>>>>>  /group0/0=3Dt;1=3Dt
> >>>>>>>  /group1/0=3Dt;1=3Dt
> >>>>>>>  /group2/0=3D_;1=3Dt
> >>>>>>>  /group3/0=3Drw;1=3D_
> >>>>>>>
> >>>>>>> - group2 is restricted to domain 0
> >>>>>>> - group3 is restricted to domain 1
> >>>>>>> - the rest are unrestricted
> >>>>>>> - In group3, we decided we need to separate read and write traffi=
c
> >>>>>>>
> >>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
> >>>>>>>
> >>>>>>
> >>>>>> I see. Thank you for the example.
> >>>>>>
> >>>>>> resctrl supports per-domain configurations with the following poss=
ible when
> >>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
> >>>>>>
> >>>>>> t(domain 0)=3DLclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,Lcl=
NTWr,RmtNTWr
> >>>>>> t(domain 1)=3DLclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
> >>>>>>
> >>>>>>    /group0/0=3Dt;1=3Dt
> >>>>>>    /group1/0=3Dt;1=3Dt
> >>>>>>
> >>>>>> Even though the flags are identical in all domains, the assigned c=
ounters will
> >>>>>> be configured differently in each domain.
> >>>>>>
> >>>>>> With this supported by hardware and currently also supported by re=
sctrl it seems
> >>>>>> reasonable to carry this forward to what will be supported next.
> >>>>>
> >>>>> The hardware supports both a per-domain mode, where all groups in a
> >>>>> domain use the same configurations and are limited to two events pe=
r
> >>>>> group and a per-group mode where every group can be configured and
> >>>>> assigned freely. This series is using the legacy counter access mod=
e
> >>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG=
_n
> >>>>> in the domain can be read. If we chose to read the assigned counter
> >>>>> directly (QM_EVTSEL[ExtendedEvtID]=3D1, QM_EVTSEL[EvtID]=3DL3CacheA=
BMC)
> >>>>> rather than asking the hardware to find the counter by RMID, we wou=
ld
> >>>>> not be limited to 2 counters per group/domain and the hardware woul=
d
> >>>>> have the same flexibility as on MPAM.
> >>>>
> >>>> In extended mode, the contents of a specific counter can be read by
> >>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=3D1,
> >>>> [EvtID]=3DL3CacheABMC and setting [RMID] to the desired counter ID. =
Reading
> >>>> QM_CTR will then return the contents of the specified counter.
> >>>>
> >>>> It is documented below.
> >>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs=
/programmer-references/24593.pdf
> >>>>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
> >>>>
> >>>> We previously discussed this with you (off the public list) and I
> >>>> initially proposed the extended assignment mode.
> >>>>
> >>>> Yes, the extended mode allows greater flexibility by enabling multip=
le
> >>>> counters to be assigned to the same group, rather than being limited=
 to
> >>>> just two.
> >>>>
> >>>> However, the challenge is that we currently lack the necessary inter=
faces
> >>>> to configure multiple events per group. Without these interfaces, th=
e
> >>>> extended mode is not practical at this time.
> >>>>
> >>>> Therefore, we ultimately agreed to use the legacy mode, as it does n=
ot
> >>>> require modifications to the existing interface, allowing us to cont=
inue
> >>>> using it as is.
> >>>>
> >>>>>
> >>>>> (I might have said something confusing in my last messages because =
I
> >>>>> had forgotten that I switched to the extended assignment mode when
> >>>>> prototyping with soft-ABMC and MPAM.)
> >>>>>
> >>>>> Forcing all groups on a domain to share the same 2 counter
> >>>>> configurations would not be acceptable for us, as the example I gav=
e
> >>>>> earlier is one I've already been asked about.
> >>>>
> >>>> I don=E2=80=99t see this as a blocker. It should be considered an ex=
tension to the
> >>>> current ABMC series. We can easily build on top of this series once =
we
> >>>> finalize how to configure the multiple event interface for each grou=
p.
> >>>
> >>> I don't think it is, either. Only being able to use ABMC to assign
> >>> counters is fine for our use as an incremental step. My longer-term
> >>> concern is the domain-scoped mbm_total_bytes_config and
> >>> mbm_local_bytes_config files, but they were introduced with BMEC, so
> >>> there's already an expectation that the files are present when BMEC i=
s
> >>> supported.
> >>>
> >>> On ABMC hardware that also supports BMEC, I'm concerned about enablin=
g
> >>> ABMC when only the BMEC-style event configuration interface exists.
> >>> The scope of my issue is just whether enabling "full" ABMC support
> >>> will require an additional opt-in, since that could remove the BMEC
> >>> interface. If it does, it's something we can live with.
> >>
> >> As you know, this series is currently blocked without further feedback=
.
> >>
> >> I=E2=80=99d like to begin reworking these patches to incorporate Peter=
=E2=80=99s feedback.
> >> Any input or suggestions would be appreciated.
> >>
> >> Here=E2=80=99s what we=E2=80=99ve learned so far:
> >>
> >> 1. Assignments should be independent of BMEC.
> >> 2. We should be able to specify multiple event types to a counter (e.g=
.,
> >> read, write, victimBM, etc.). This is also called shared counter
> >> 3. There should be an option to assign events per domain.
> >> 4. Currently, only two counters can be assigned per group, but the des=
ign
> >> should allow flexibility to assign more in the future as the interface
> >> evolves.
> >> 5. Utilize the extended RMID read mode.
> >>
> >>
> >> Here is my proposal using Peter's earlier example:
> >>
> >> # define event configurations
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >> Bits    Mnemonics       Description
> >> =3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 6       VictimBW        Dirty Victims from all types of memory
> >> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA dom=
ain
> >> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
> >> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
> >> 2       LclNTWr         Non-temporal writes to local NUMA domain
> >> 1       mtFill          Reads to memory in the non-local NUMA domain
> >> 0       LclFill         Reads to memory in the local NUMA domain
> >> =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> #Define flags based on combination of above event types.
> >>
> >> t =3D LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
> >> l =3D LclFill, LclNTWr, LclSlowFill
> >> r =3D LclFill,RmtFill,LclSlowFill,RmtSlowFill
> >> w =3D VictimBW,LclNTWr,RmtNTWr
> >> v =3D VictimBW
> >>
> >> Peter suggested the following format earlier :
> >>
> >> /group0/0=3Dt;1=3Dt
> >> /group1/0=3Dt;1=3Dt
> >> /group2/0=3D_;1=3Dt
> >> /group3/0=3Drw;1=3D_
> >
> > After some inquiries within Google, it sounds like nobody has invested
> > much into the current mbm_assign_control format yet, so it would be
> > best to drop it and distribute the configuration around the filesystem
> > hierarchy[1], which should allow us to produce something more flexible
> > and cleaner to implement.
> >
> > Roughly what I had in mind:
> >
> > Use mkdir in a info/<resource>_MON subdirectory to create free-form
> > names for the assignable configurations rather than being restricted
> > to single letters.  In the resulting directory, populate a file where
> > we can specify the set of events the config should represent. I think
> > we should use symbolic names for the events rather than raw BMEC field
> > values. Moving forward we could come up with portable names for common
> > events and only support the BMEC names on AMD machines for users who
> > want specific events and don't care about portability.
>
>
> I=E2=80=99m still processing this. Let me start with some initial questio=
ns.
>
> So, we are creating event configurations here, which seems reasonable.
>
> Yes, we should use portable names and are not limited to BMEC names.
>
> How many configurations should we allow? Do we know?

Do we need an upper limit?

>
> >
> > Next, put assignment-control file nodes in per-domain directories
> > (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
> > counter-configuration name into the file would then allocate a counter
> > in the domain, apply the named configuration, and monitor the parent
> > group-directory. We can also put a group/resource-scoped assign_* file
> > higher in the hierarchy to make it easier for users who want to
> > configure all domains the same for a group.
>
> What is the difference between shared and exclusive?

Shared assignment[1] means that non-exclusively-assigned counters in
each domain will be scheduled round-robin to the groups requesting
shared access to a counter. In my tests, I assigned the counters long
enough to produce a single 1-second MB/s sample for the per-domain
aggregation files[2].

These do not need to be implemented immediately, but knowing that they
work addresses the overhead and scalability concerns of reassigning
counters and reading their values.

>
> Having three files=E2=80=94assign_shared, assign_exclusive, and unassign=
=E2=80=94for each
> domain seems excessive. In a system with 32 groups and 12 domains, this
> results in 32 =C3=97 12 =C3=97 3 files, which is quite large.
>
> There should be a more efficient way to handle this.
>
> Initially, we started with a group-level file for this interface, but it
> was rejected due to the high number of sysfs calls, making it inefficient=
.

I had rejected it due to the high-frequency of access of a large
number of files, which has since been addressed by shared assignment
(or automatic reassignment) and aggregated mbps files.

>
> Additionally, how can we list all assignments with a single sysfs call?
>
> That was another problem we need to address.

This is not a requirement I was aware of. If the user forgot where
they assigned counters (or forgot to disable auto-assignment), they
can read multiple sysfs nodes to remind themselves.

>
>
> >
> > The configuration names listed in assign_* would result in files of
> > the same name in the appropriate mon_data domain directories from
> > which the count values can be read.
> >
> >  # mkdir info/L3_MON/counter_configs/mbm_local_bytes
> >  # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
> >  # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
> >  # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event=
_filter
> >  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> > LclFill
> > LclNTWr
> > LclSlowFill
>
> I feel we can just have the configs. event_filter file is not required.

That's right, I forgot that we can implement kernfs_ops::open(). I was
only looking at struct kernfs_syscall_ops

>
> #cat info/L3_MON/counter_configs/mbm_local_bytes
> LclFill <-rename these to generic names.
> LclNTWr
> LclSlowFill
>

I think portable and non-portable event names should both be available
as options. There are simple bandwidth measurement mechanisms that
will be applied in general, but when they turn up an issue, it can
often lead to a more focused investigation, requiring more precise
events.

-Peter

