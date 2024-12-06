Return-Path: <linux-kernel+bounces-434871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E69E6C37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D1018887EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A961F943B;
	Fri,  6 Dec 2024 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SU7A9n3c"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3E1FCD1E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480647; cv=none; b=l8hD/9iyjRRBwE4swg96DzehwCIpijJ6QxPkpcU5Oojr3d3e+UyofEXwBeH66JLilF8rNfFQPlPbmDK/WF0zWlii5gzAO5zOcSuCMVvfTX0XNi9WajE0CJ9PgGLo3Kyfo3DOOzftjpCs9WBC6nr+qBChZZcsUHtDR5YWvMoBsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480647; c=relaxed/simple;
	bh=tRfc9+Dw3s3DPWpSDxvIeRMbP/TKJ/og2SIB+waj9+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZOZkH52doizYALwEeiqjHXpiVoj3+o4zyIj2vlrFxZTW3Wqqegx5ZPMv7qmhb0Gzi1CUscLJiCLYE/FeCRLI8ww089CK8GQ/r0GbvaFURjShtfFVrVN2AXqj8u3bkC37xPWh7yUYg33/sjNLxFwSpe35m0tcUYQH6xqg+mcFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SU7A9n3c; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so2975294a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733480644; x=1734085444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLgwVeLvRNtO9bqicju9J1Pto2NkQrdmzIyUqJYEUV8=;
        b=SU7A9n3cP5P6Pe9ztMwZR6oUg9fHmQ1/F6HjN3ggcI4GyXUQzldy2R0hnoH4heQ+w2
         fY9bYc4YbAWUcnF4cAIN5vLcxKfNQVF5RfvsA8rv6B4TbnvisnEcR+XUMqR1TG+gBScE
         0BRaeW2rW8AUncvmwtIxABAGxzrx3Q9/qCFZg6VYn+ZkUkBQjRPW/bmEbh9brHDaX7lh
         KuCni6w9/11OzMUZHbS0+fbqJc+zWufTTa7tLS6E4fzgDcqgCjgmxlAKqHv+9/YO2HnH
         YAJud55rsKrjuIJGnN9FgsokPUJR4Ifx9ecNaqkBKtswkhVOse2qqG+uj2Ml6BZjQJdZ
         Y2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733480644; x=1734085444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLgwVeLvRNtO9bqicju9J1Pto2NkQrdmzIyUqJYEUV8=;
        b=rhaHnRuUEnlzhrzUKtljMz8ND725ftbqcALnyAh3Ir416gbuFRmZQHnNlOTfAbMDcx
         4RzsGyR6nGR2eqvKKvc+wucpw4RmqFPTg3Hu3v+Es6A8PCw3jsQRT6lF1fNYP0FA3Rw3
         YASkEZutnsmUJh2I3aDFySu5ATQjJlJ/KtoEVyBnEh2RbbGUru2hKp+Xb4wVVEQUkC6A
         DWEiZY2tUtGEiW6pa3kO8l7CAmO58C9dueIYfdK0NGDuVmNhAa4V76jlbY47OUIUgPtz
         DcSsPZoCb5Dgt8Y625WDsN49ZdKH1ERG270YEu49UnBMn5vsAX32z2wR1HgRdypOJUrX
         94gA==
X-Forwarded-Encrypted: i=1; AJvYcCVckShIDh9ZG4Nvit/zJ7Q9VByV6XqrSyNuv3FVpKi0dRzxpKTcbaM35SsWVYYw2D5QmtQGXI0Wx2wU800=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovmFBs32P6ZHDPQOAsy4Pir/cmKWYGjZg3rP+C2mqqybThx6T
	2UvZnKREKAgcrFHn5xVF8dcm31yF4pZ2xlLHVSXxc4BbvTEVdi1llt1aMAL9qoRJRjGK9xVaZag
	BlRJyAGAGziRj0XDpoB7dMlqtMThVukHwcVa4
X-Gm-Gg: ASbGncs3f7Iq/3arUaUbb1najGUNiSPshDDaNPOTB5LuH0AYJ60N9m9yBI0u9RYtbru
	OB7PQuh74X5K8sItA9ZwSzBWQLUXL4xOm+h/wtrtv6nxeo+7Jj4HIpaRy3llDTA==
X-Google-Smtp-Source: AGHT+IGKvsx2xWWNh3UHm3fPOR00Gf/Clm31KMJXm9Xn58PL2mc2A1jnoF5dmSvyfMx3jpdCZAKOMtspgRTkQeFmps4=
X-Received: by 2002:a05:6402:e81:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d3be6b506bmr2608560a12.10.1733480643959; Fri, 06 Dec 2024
 02:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-4-peternewman@google.com> <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
 <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
 <CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com> <2214f589-03d5-4037-8997-bbf78077a101@intel.com>
In-Reply-To: <2214f589-03d5-4037-8997-bbf78077a101@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 6 Dec 2024 11:23:53 +0100
Message-ID: <CALPaoCgSO7HzK9BjyM8yL50oPyq9kBj64Nkgyo1WEJrWy5uHUg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Fri, Dec 6, 2024 at 5:14=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> +Tony
>
> Hi Peter,
>
> On 12/5/24 7:03 AM, Peter Newman wrote:
> > On Sat, Apr 6, 2024 at 12:10=E2=80=AFAM Peter Newman <peternewman@googl=
e.com> wrote:
> >> On Thu, Apr 4, 2024 at 4:11=E2=80=AFPM Reinette Chatre
> >> <reinette.chatre@intel.com> wrote:
> >>>
> >>> Hi Peter,
> >>>
> >>> On 3/25/2024 10:27 AM, Peter Newman wrote:
> >>>> Moving a monitoring group to a different parent control assumes that=
 the
> >>>> monitors will not be impacted. This is not the case on MPAM where th=
e
> >>>> PMG is an extension of the PARTID.
> >>>>
> >>>> Detect this situation by requiring the change in CLOSID not to affec=
t
> >>>> the result of resctrl_arch_rmid_idx_encode(), otherwise return
> >>>> -EOPNOTSUPP.
> >>>>
> >>>
> >>> Thanks for catching this. This seems out of place in this series. It =
sounds
> >>> more like an independent fix that should go in separately.
> >>
> >> I asserted in a comment in a patch later in the series that the
> >> mongroup parent pointer never changes on MPAM, then decided to follow
> >> up on whether it was actually true, so it's only here because this
> >> series depends on it. I'll post it again separately with the fix you
> >> requested below.
> >
> > I'm preparing to finally re-post this patch, but another related
> > question came up...
> >
> > It turns out the check added to mongroup rename in this patch is an
> > important property that the user needs in order to correctly interpret
> > the value returned by info/L3_MON/num_rmids.
> >
> > I had told some Google users to attempt to move a monitoring group to
> > a new parent to determine whether the monitoring groups are
> > independent of their parent ctrl_mon groups. This approach proved
> > unwieldy when used on a system where the maximum number of allowed
> > groups has already been created. (In their problem case, a
> > newly-created process wanted to determine this property independently
> > of the older process which had originally mounted resctrl.)
>
> Could you please elaborate why users need the information that monitoring
> groups are independent of their parent ctrl_mon group?
> I understood from [2] that Arm can be expected to support moving monitor
> groups so I am concerned about userspace building some assumptions like
> "if the monitoring groups are dependent on their parent ctrl_mon groups t=
hen
> monitor groups cannot be moved".

It's to make the high-level decision of whether ctrl_mon groups or
mon_groups are to be used as the direct container of a job's tasks.

Given the semantics of PARTIDs vs PMGs on MPAM, the ctrl_mon groups
will always be chosen as the container for tasks, so I don't have a
use case for moving a monitoring group on MPAM.

Perhaps determining whether moving a monitoring group is allowed in
order to decide whether to use the model that requires it is
backwards.

>
> >
> > Also, this information does not require an active rdtgroup pointer or
> > CLOSID/RMID. The following will also work:
> >
> >  resctrl_arch_rmid_idx_encode(0, 0) !=3D resctrl_arch_rmid_idx_encode(1=
, 0);
> >
> > I propose adding a new info file returning the result of this
> > expression to be placed beside num_rmids. I would name it
> > "mon_id_includes_control_id", as it implies that the hardware
> > logically interprets the monitoring ID as concatenated with its parent
> > control ID. This tells the user whether num_rmids defines the number
> > of monitoring groups (and ctrl_mon groups) which can be created system
> > wide or whether it's one more than the number of monitoring groups
> > which can be created below every ctrl_mon group.
>
> Is the goal purely to guide interpretation of "info/L3_MON/num_rmids"?

Partially, I suppose. It is necessary to know how many monitoring
groups can be created.

>
> The "mon_id_includes_control_id" seems unique to a use case and if I unde=
rstand
> correctly needs additional interpretation from user space to reach the ac=
tual
> data of interest, which I understand to be the number of monitor groups t=
hat
> can be created.
>
> A while ago James proposed [1] adding a new "num_groups" inside each "mon=
_groups"
> directory, on x86 it will be the same as num_rmids, on Arm it will be the=
 maximum PMG bits.
> At a high level(*) I think something like this may be an intuitive way to=
 address this
> issue. What do you think?

On ARM, it would mean num_groups child mon groups can be created,
while on x86, it would mean between 0 and num_groups child mon_groups
can be created.

In either case, all instances of the file would return the same value
at any time.

>
> (*) If considering this I do think it may be more intuitive to have the f=
ile
> be at the top level of the control group and be named "num_mon_groups" (o=
r something better)
> to support the idea that it includes the CTRL_MON group self and not that=
 all monitor groups
> are within the mon_groups directory.
>
> Also please keep in mind that during the discussions about moving monitor=
ing groups
> there were some ideas of needing to provide additional information to use=
r space about
> whether counters are reset on a monitor group move. I think that if we ar=
e starting
> to look at these random properties as files in resctrl (like "mon_id_incl=
udes_control_id"
> and maybe "counter_reset_on_monitor_group_move") then we should consider =
some alternatives
> to present these flags to prevent resctrl's info directory from turning i=
nto a mess.

In the meantime, num_rmids > num_closids will probably be a good
enough heuristic to correctly guess the ID model.

Thanks,
-Peter

