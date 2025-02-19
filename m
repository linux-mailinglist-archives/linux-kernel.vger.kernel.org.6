Return-Path: <linux-kernel+bounces-521402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA84FA3BCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512207A7D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253A1DEFEA;
	Wed, 19 Feb 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEDbgivr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD171DEFDC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964511; cv=none; b=rTY2r4gUqngSxtKU9jddV1c54hYzuwhP8cGDhQiQvpbrEMMEIldq9jU+HNBiz8/PdiQ1NSYslCOJiKnJULnhUezmsQoBDXfbKeCmixZFlxJK0VYBRIbTtLkKqot48YFI/XL8PnTzkBbH0RH76MDHGnWDNtU/8/VZjdatdtKlq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964511; c=relaxed/simple;
	bh=u04IQISYLjCMofqQ3QpQiAxrQZB8WL69dEdlPjDMpVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZAdDP51bXRoxiCwO1+fxJ8b0HMhPn2t7JB2Z+/nD4kRC5XJG0O9lZCHwktZ+6FI/Gdh5AVc2/SwAVez/NFEKR1m0eHRMscJTzAxSXxYS/gRFgjaUvvk/hlmMhjXRNmhBW8YO9pmtfhcls5TRNkCfsJpeftf4AVxKSRZgkJqLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEDbgivr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbdc4a0b5aso75022966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739964508; x=1740569308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u04IQISYLjCMofqQ3QpQiAxrQZB8WL69dEdlPjDMpVs=;
        b=IEDbgivrUe9oU+qy+QUfrEkxewhOE33ZAueniz6SGvdrhDsjy8cNpOmnoAm36xc+Bu
         oLq5yO4JgwjaaSRO1bgmoS5bjHo6EFmns+mptetjq6bXWuY0SkK6ITkcyZlTDZnedLLZ
         Fxi9DfW3MM6kAevmO6PDR1mVnF8LNbhxdQEkT2QPuVKh/bfUqd1qI52FJkcOtGpFLV9q
         oXCyIQY0Bgx9FVa1A+L0OiUORP2fV2n3oYvjkmz+aOwTjtRtV4f7R1jWBBXOl8WZwkIe
         wvjQqFvJnulkNDIXmpFnM0dM8vNB42bFAFUG24HtrX2jpJG20oHtbfhbDXgsf5VDcY3W
         sG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739964508; x=1740569308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u04IQISYLjCMofqQ3QpQiAxrQZB8WL69dEdlPjDMpVs=;
        b=FH2uvqnNT8s8sACtwyJcfvkvO1lXx7srlHeOOVg0Isvl+L4djkaUAEEQHZJVlL5mTr
         7weB4EEhIk20WhM9aspuLLKk9gIqp7ODVfrctqgWnk1MpcNR6OEQe3CyLD4Rqk6LVVYb
         F7saRxEiVwpE4KPIY6ohGjgitAnbZc0fqzIKKnh8kKwtwla9WUm7wYBAW6ntzlBrhAow
         pIf2cuGIB4oBHF37E5pjeyhV6VRDRREJE8AAhdDriTAyqmd/8hnldSwAOkddLAuKJNq3
         zkAhugInL/SItDkincVjYKeRf3YnSmIWh0E1ikk06hPA358qPlhH+jJA9UgAENfx1s37
         apdw==
X-Forwarded-Encrypted: i=1; AJvYcCWa42HzDvbPpN5FGNRtZBaM8LPVkhcxsWu2+wuse6Ev135Pj9EYxa/EzJP/3fQQQn1GTALB5AmJDiRNa1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4qhRRZymIcqmoxbKlHtlTIpHf71UltLMhRbbmqKPPsLatsEG
	quFerUsWk4CDYZeIfbjrPqf/i2eW2o7QikSndQEp3k2YUByMQ03l703KZrMACldsRCSwqwfdoCS
	q2jrLtAboiuwZm5vv1cV/FVXymi57KzAtb+e9
X-Gm-Gg: ASbGncukraPEMEbnL+cUQ7HMj+VwQUMqPOpqzY1VYf/Q0zc2KEH/YuzsXkJ/GQihUCP
	qAdodnsZ6L7B8IAVfzaO8caWcH/w/N5zA1XGQxYpY917/xmgVln6yVf+0zOPUP4rnOIsYdHbu0s
	zhAG0NP15GMl34w1WCvF69yUmpnA==
X-Google-Smtp-Source: AGHT+IFL52lnenWGTW7oL6dts31qk9OG+Soh9kwzHUZQ5Np2XKnPToSu2WGVEC4v36VmQqo5ZuJMvvYrs075LQvqc84=
X-Received: by 2002:a17:906:318c:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abbcc653f77mr306072566b.17.1739964508215; Wed, 19 Feb 2025
 03:28:28 -0800 (PST)
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
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
In-Reply-To: <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 19 Feb 2025 12:28:16 +0100
X-Gm-Features: AWEUYZmWoH5-nb_-0SCae4RnH3JlkVydGrohy3tJyf8cfqh-Cd4pRJxy2oPdR58
Message-ID: <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 6:50=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Peter,
>
> On 2/17/25 2:26 AM, Peter Newman wrote:
> > Hi Reinette,
> >
> > On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
> > <reinette.chatre@intel.com> wrote:
> >>
> >> Hi Babu,
> >>
> >> On 2/14/25 10:31 AM, Moger, Babu wrote:
> >>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >>>> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
> >>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> >>
> >> (quoting relevant parts with goal to focus discussion on new possible =
syntax)
> >>
> >>>>>> I see the support for MPAM events distinct from the support of ass=
ignable counters.
> >>>>>> Once the MPAM events are sorted, I think that they can be assigned=
 with existing interface.
> >>>>>> Please help me understand if you see it differently.
> >>>>>>
> >>>>>> Doing so would need to come up with alphabetical letters for these=
 events,
> >>>>>> which seems to be needed for your proposal also? If we use possibl=
e flags of:
> >>>>>>
> >>>>>> mbm_local_read_bytes a
> >>>>>> mbm_local_write_bytes b
> >>>>>>
> >>>>>> Then mbm_assign_control can be used as:
> >>>>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_assign_co=
ntrol
> >>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> >>>>>> <value>
> >>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>>>
> >>>>>> One issue would be when resctrl needs to support more than 26 even=
ts (no more flags available),
> >>>>>> assuming that upper case would be used for "shared" counters (unle=
ss this interface is defined
> >>>>>> differently and only few uppercase letters used for it). Would thi=
s be too low of a limit?
> >>
> >> As mentioned above, one possible issue with existing interface is that
> >> it is limited to 26 events (assuming only lower case letters are used)=
. The limit
> >> is low enough to be of concern.
> >
> > The events which can be monitored by a single counter on ABMC and MPAM
> > so far are combinable, so 26 counters per group today means it limits
> > breaking down MBM traffic for each group 26 ways. If a user complained
> > that a 26-way breakdown of a group's MBM traffic was limiting their
> > investigation, I would question whether they know what they're looking
> > for.
>
> The key here is "so far" as well as the focus on MBM only.
>
> It is impossible for me to predict what we will see in a couple of years
> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl inter=
face
> to support their users. Just looking at the Intel RDT spec the event regi=
ster
> has space for 32 events for each "CPU agent" resource. That does not take=
 into
> account the "non-CPU agents" that are enumerated via ACPI. Tony already m=
entioned
> that he is working on patches [1] that will add new events and shared the=
 idea
> that we may be trending to support "perf" like events associated with RMI=
D. I
> expect AMD PQoS and Arm MPAM to provide related enhancements to support t=
heir
> customers.
> This all makes me think that resctrl should be ready to support more even=
ts than 26.

I was thinking of the letters as representing a reusable, user-defined
event-set for applying to a single counter rather than as individual
events, since MPAM and ABMC allow us to choose the set of events each
one counts. Wherever we define the letters, we could use more symbolic
event names.

In the letters as events model, choosing the events assigned to a
group wouldn't be enough information, since we would want to control
which events should share a counter and which should be counted by
separate counters. I think the amount of information that would need
to be encoded into mbm_assign_control to represent the level of
configurability supported by hardware would quickly get out of hand.

Maybe as an example, one counter for all reads, one counter for all
writes in ABMC would look like...

(L3_QOS_ABMC_CFG.BwType field names below)

(per domain)
group 0:
 counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
 counter 1: VictimBW,LclNTWr,RmtNTWr
group 1:
 counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
 counter 3: VictimBW,LclNTWr,RmtNTWr
...

I assume packing all of this info for a group's desired counter
configuration into a single line (with 32 domains per line on many
dual-socket AMD configurations I see) would be difficult to look at,
even if we could settle on a single letter to represent each
universally.

>
> My goal is for resctrl to have a user interface that can as much as possi=
ble
> be ready for whatever may be required from it years down the line. Of cou=
rse,
> I may be wrong and resctrl would never need to support more than 26 event=
s per
> resource (*). The risk is that resctrl *may* need to support more than 26=
 events
> and how could resctrl support that?
>
> What is the risk of supporting more than 26 events? As I highlighted earl=
ier
> the interface I used as demonstration may become unwieldy to parse on a s=
ystem
> with many domains that supports many events. This is a concern for me. An=
y suggestions
> will be appreciated, especially from you since I know that you are very f=
amiliar with
> issues related to large scale use of resctrl interfaces.

It's mainly just the unwieldiness of all the information in one file.
It's already at the limit of what I can visually look through.

I believe that shared assignments will take care of all the
high-frequency and performance-intensive batch configuration updates I
was originally concerned about, so I no longer see much benefit in
finding ways to textually encode all this information in a single file
when it would be more manageable to distribute it around the
filesystem hierarchy.

-Peter


>
> Reinette
>
> [1] https://lore.kernel.org/lkml/SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@S=
J1PR11MB6083.namprd11.prod.outlook.com/
>
> (*) There is also the scenario where combined between resources there may=
 be
> more than 26 events supported that will require the same one letter flag =
to be
> used for different events of different resources. This may potentially be
> confusing.

