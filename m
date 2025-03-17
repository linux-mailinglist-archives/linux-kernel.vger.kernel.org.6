Return-Path: <linux-kernel+bounces-564598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F7A65800
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C817165ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4058119F420;
	Mon, 17 Mar 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDM0Tjw0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F317A2E9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228883; cv=none; b=rR4m5FbsrufkgCMoeeOAip3Fo/VIrzGV37ZYmNPtLoc5kGfzDba9iAk/DCtr96Zop097FBMAdqa67+YkmhobVJrWdXsqYwNJPiDfTkj0u5KNaVCNHJCa6FgXsNqQsTlkYJPhbPPO5KlHLM9nGHzw/9p0NE3Pn3vt4Tg10AbQX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228883; c=relaxed/simple;
	bh=+xbA11YoBCM0APVgE1HmJiBC1pDnDh5yw515L6QByLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EO3l5R3jPVF85MPVn3O2ELBBfQhEkUF9HVGcKUUFd4wFWL2cVRe+BQIhog4AIg1RZBMM6f9aIn2Qifyb/oS4UDja3a5BkFuWTKpW2pS15Cz23zuf5blPKO2Pcr4prRclXpGpJtJstQlTXAxLza4dV5GgKbHwigPmC4335tXJNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDM0Tjw0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso7905921a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228880; x=1742833680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89fD89Q6T2OKDuYNg82lPgYyR9ous0ateN1XpH9BsoA=;
        b=dDM0Tjw0N/onVGEaa/V+FpXuChPIpSG36ZiVBEwoSDp3+Birn9bTufYQhi+CkfCmbw
         jsvK+FxE6vB/JfBooIOw6NbuXuJiF7ulLG5U2nGizQ5wG6PWZvqmnxRG1KaBVnBGWk4+
         d4MBbX8u0ATQPT+Yq2c1xzkJTQCNuW+TcxvcPlq4PsbWDzXyilJ33uWhM/Tk4SJDX00n
         FkuEY3/Wm814f7g1BeSe+L7RYanumIIMz+pCx+xRglbOpgvs/ITXUE0OR65JvBDKIJKk
         KPRImI4sT5wYMokKM0isBgvGozuRBoTMR+1RGGvDKaOFkjOdWLB9Cj8RmVPe+HMtbNZG
         jg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228880; x=1742833680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89fD89Q6T2OKDuYNg82lPgYyR9ous0ateN1XpH9BsoA=;
        b=NVJflf1uNcOyTA3TZU//yrZOs7f5eEX6KuGoWT1yTiOSyWndkQSdid529GqjMhkoP7
         rKUtgYfjhVT+UEaz9eeve9doetP3vfV3JRRdwxndrkN8eUzPacGEtZbNxNaYYWsHdq8a
         hLT4TbTSfQ3uNhIukAnhPKGEg2xrQngP3qplYGky3Am4CKc2nkGyIUdOuyo7MHCmCl4h
         PmKDL+cCnP16nnPLy156vlhidPeUgdsZC38DhUy+L+YTakRDANUvEgpvKaKPX96B/goF
         mLDM/UeN528SbBs+VxUH4D+WLChXemdcreYmN0Z/6AUzb+5QnWLApwPXZDBhHiVac07a
         Vy/A==
X-Forwarded-Encrypted: i=1; AJvYcCUwTPq7YNGQIA8PCHF4qgwnQ+skRVGOy5TFC2hsxjsyVTRVDMe+oBkc0oOisZQ5TysRPElr9OzlVaX1FJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhFLjj+6URQmXFfWIJjgBUy66goh97D7OUaIC3K5HbJX1LLHK
	KRRBmvr7TKviUMPjcgJ4D7jguR4Oqgwet3MEaGcRyFdrEjnV/CyRs11et1F5rQVqzW43xmJ7/Dh
	YOvPjtNDSCR6qpQ0tCkPBbDxVu4ZQThf6G3uB
X-Gm-Gg: ASbGncsuYet7GwS+uJOBS273eoK6NNtiBO5MpuRbG9WWFUimPh0yeCxh9RCALXO55aS
	Ry64wMxoOdJyVNpEVf0smSNfePr/GLVVrDwd0rKV8XsFraB6jqZlK3GGJipr5QNlQSyR2dKzPQx
	UiMhvTCpUTuPt5Jxme/6yjgFLfJNJ22LRrH6fwhyq9bxSlOttpqHKgTmQxQEG7mM2w1g==
X-Google-Smtp-Source: AGHT+IGFFcNVZoBalAn7/3OPYvWx4kWbHEWQNDXbKx96snWH45JMXiSL+Iev2blxLMZFP9U29bNgAZYh4i+cmODElXE=
X-Received: by 2002:a05:6402:84f:b0:5de:dfd0:9d22 with SMTP id
 4fb4d7f45d1cf-5eb1df95fdamr261706a12.22.1742228879633; Mon, 17 Mar 2025
 09:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com> <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com> <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com> <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com> <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3> <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com> <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com> <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com> <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com> <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
In-Reply-To: <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 17 Mar 2025 17:27:47 +0100
X-Gm-Features: AQ5f1JoIXqgG0M4QrynyU6Ipgs01SNdbTiTvENC9YJAFCysT9dUjqv8f75ycOjM
Message-ID: <CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, "Moger, Babu" <bmoger@amd.com>, "Luck, Tony" <tony.luck@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com, 
	rostedt@goodmis.org, xiongwei.song@windriver.com, 
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

On Thu, Mar 13, 2025 at 10:22=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Babu,
>
> On 3/13/25 1:13 PM, Moger, Babu wrote:
> > On 3/13/25 11:08, Reinette Chatre wrote:
> >> On 3/12/25 11:14 AM, Moger, Babu wrote:
> >>> On 3/12/25 12:14, Reinette Chatre wrote:
> >>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
> >>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>
>
> > Here are the steps. Just copying steps from Peters proposal.
> > https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=3DkVLBzhfNo0SFqt4kQGw=
GSGVUqvr2Dg@mail.gmail.com/
>
> Thank you very much for detailing the steps. It is starting the fall into=
 place
> for me.
>
> >
> >
> > 1. Mount the resctrl
> >    mount -t resctrl resctrl /sys/fs/resctrl
>
> I assume that on ABMC system the plan remains to have ABMC enabled by def=
ault, which
> will continue to depend on BMEC.
>
> How would the existing BMEC implementation be impacted in this case?
>
> Without any changes to BMEC support the mbm_total_bytes_config and mbm_lo=
cal_bytes_config
> files will remain and user space may continue to use them to change the e=
vent
> configurations with confusing expecations/results on an ABMC system.
>
> One possibility may be that a user may see below on ABMC system even if B=
MEC is supported:
> # cat /sys/fs/resctrl/info/L3_MON/mon_features
> llc_occupancy
> mbm_total_bytes
> mbm_local_bytes
>
> With the above a user cannot be expected to want to interact with mbm_tot=
al_bytes_config
> and mbm_local_bytes_config, which may be the simplest to do.

How about making mbm_local_bytes and mbm_total_bytes always be
configured using mbm_{local,total}_bytes_config and only allowing the
full ABMC configurability on user-defined configurations. This could
resolve the issue of backwards compatibility with the BMEC files and
remove the need for the user opting-in to ABMC mode.

It will be less clean implementation-wise, since there will be two
classes of event configuration to deal with, but I think it seems
logical from the user's side.

>
> To follow that, we should also consider how "mon_features" will change wi=
th this
> implementation.
>
> >
> > 2. When ABMC is supported two default configurations will be created.
> >
> >   a. info/L3_MON/counter_configs/mbm_total_bytes/event_filter
> >   b. info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >
> >   These files will be populated with default total and local events
> >   # cat info/L3_MON/counter_configs/mbm_total_bytes/event_filter
> >     VictimBW
> >     RmtSlowFill
> >     RmtNTWr
> >     RmtFill
> >     LclFill
> >     LclNTWr
> >     LclSlowFill
>
> Looks good. Here we could perhaps start nitpicking about naming and line =
separation.
> I think it may be easier if the fields are separated by comma, but more o=
n that
> below ...
>
> >
> >   # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> >    LclFill,
> >    LclNTWr
> >    LclSlowFill
> >
> > 3. Users will have options to update the event configuration.
> >    echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
>
> We need to be clear on how user space interacts with this file. For examp=
le,
> can user space "append" configurations? Specifically, if the file has
> contents like your earlier example:
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  LclFill
>  LclNTWr
>  LclSlowFill
>
> Should above be created with (note "append" needed for second and third):
> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> echo LclNTWr >> info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> echo LclSlowFill >> info/L3_MON/counter_configs/mbm_local_bytes/event_fil=
ter
>
> Is it possible to set multiple configurations in one write like below?
> echo "LclFill,LclNTWr,LclSlowFill" > info/L3_MON/counter_configs/mbm_loca=
l_bytes/event_filter
>
> (note above where it may be easier for user space to use comma (or some o=
ther field separator)
> when providing multiple configurations at a time, with this, to match, ha=
ving output in
> commas may be easier since it makes user interface copy&paste easier)
>
> If file has content like:
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  LclNTWr
>  LclSlowFill
>
> What is impact of the following:
> echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>
> Is it (append):
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  LclFill
>  LclNTWr
>  LclSlowFill
>
> or (overwrite):
> # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  LclFill
>
> I do think the interface will be more intuitive it if follows regular fil=
e
> operations wrt "append" and such. I have not looked into how kernfs suppo=
rts
> "append".

I expect specifying counter_configs to be a rare or one-time
operation, so I think ease-of-use is the only concern. I think
multiple, appending writes is the most straightforward to implement
and invoke (for a shell user), but I think commas are easy enough to
support as well, even though it would look better when reading back to
see the entries on separate lines.

I believe you can inspect the file descriptor's flags from the
kernfs_open_file reference: of->file->f_flags & O_APPEND

I haven't tried this, though.

-Peter

