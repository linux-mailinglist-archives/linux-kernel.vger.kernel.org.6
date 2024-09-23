Return-Path: <linux-kernel+bounces-332689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C297BD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB90B281F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFE18B478;
	Wed, 18 Sep 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2WOVMHh"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08118B472
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666790; cv=none; b=R4HBSAk80ISROSbnwcKAwSX34VZ/TzFgDblJhvUwzqbRMyYiwu+KJTSPvzEYoWQc416h3Jgr0rPi3Au8Xm3xHFlOP4eVPPlRYVof+Zw/Q5Y38/JIzXd7cft9QoR+kQvhLXeazsbBokR3jXNzmmbAe+hmJ3p5kphDfkB8WdHlU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666790; c=relaxed/simple;
	bh=kxdRSG+oUl8jddKbzewCzouug6gCB0tzZXTQwZui7t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXq94gEAaIlmmNgYBbhsCX0nemwO+j83vC6e3QJsmKnsSarmCj2NUocDidUvz6HusY8pC4LIhkJrzKbDAM0C66w+ZY1Whj5H5NyJmSfy7kaw+CaapaeEMJePkdiUBaLWANs0zPK9VUAqugPI9kEH9R3hTESZmTK++RWunZ3EjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2WOVMHh; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a098a4796dso242375ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726666787; x=1727271587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spg0BjAJ5sUlHZkRnAdoV6vTNQRfPoA92Dsq1YO0UxQ=;
        b=J2WOVMHhRHW3kZkgWVBoa0o3+i81iSDHNuNuSFv8UVFrPsotWXP7HH9KSxZZDlGPiS
         OxLhOwp+Xo6I6kNAfo51Y01eouBu5SuYJCu9e+gl6UgwvZrNDtWQ+4SeVyFzFit8UBqU
         8M020YTnIMK6wElJyaNCn8c+RR9uyj6LyPxFsnG2zwpp82batlAiGxyVbDjUsInaSWIC
         rQkz5FrvGtZmx1KzxH/sVf1oK1WK87NAExEpGoiR91V26BTtrqqITTwvutsc2ns5E3Sf
         eDaRDyg8eOZLcC3jxgxYLZXWlS/RhR4JvRtyvQuVJ/JYmpBHEDb8S3pC108vOUQfUuQU
         gCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726666787; x=1727271587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spg0BjAJ5sUlHZkRnAdoV6vTNQRfPoA92Dsq1YO0UxQ=;
        b=RpN3duodCb9WyeVidHJ79g6ye7bZgVG5Rw9naW+f2QOsugmFrqdnmq280wNkd2KPcI
         UG3pRawA3QBAYjjBZLv5TBkPkneY9XEcSm21BuBXbdWcELX6m3WSF3o50AjbOAL4YsMh
         LHYmGdcEH1CRJPgiJgjhW/gcg/UGwn3X30/+WXSkOcYfUMCG7QE0nV3D05gUrXT5ERNQ
         TmafJpP6J3DtiiqSfOAhlyMoiGjDssB/udyUGvuTIFDMjOwUOR8rnqlyWF3S7J9XPHcU
         195vb+d505RCcsrbZ0FfikrsT8/4XDJX51llb3YsIY9ZjRT9fxKuuoeLTt+fkbsYickq
         2B0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6Itr7eYIuzOl/v5w4TPz5QF4zl4XNggRCxpOSB5MkEVIosuQsWaKH/Y18CybhM2HN+zbxfeOjpG8GN5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBFUqFX7Y1YcLuI1UTCk2nNBJNqchfwHbfbecOqpDRBBATVcR
	sf/3CYyVR0QFBpAyAzr7ZWYL/lejfgCL1FS0TD7u7GGiye4xkb0Ty4NY9GjsCWUaE7KkLE9Akd7
	32U+oisb3Px1SMrtAxa1dNVMsYBbER/lvrqdN
X-Google-Smtp-Source: AGHT+IHJqb+sNwcPI7MRI0gxmM+OBJcOj2pSBwpWCULTSSKiUDDIInFWfc+jeTglVVWPq60vUiAJmbNwJs448MmirzY=
X-Received: by 2002:a05:6e02:1d9b:b0:39e:6b18:da32 with SMTP id
 e9e14a558f8ab-3a0b8a7a518mr4027905ab.14.1726666787400; Wed, 18 Sep 2024
 06:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917222820.197594-1-namhyung@kernel.org> <CAP-5=fVV9wzp7L71VJxaqzuURFtr1LAg0Qmk5uqmzs3By1Exow@mail.gmail.com>
 <ZuqfmXairuIo_Px4@google.com>
In-Reply-To: <ZuqfmXairuIo_Px4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Sep 2024 15:39:31 +0200
Message-ID: <CAP-5=fUT-60ff-hPS9Anizq9XxiqAOJXYyQqeVoHBYzMvd0L=g@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf tools: Support deferred user callchains (v2)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Indu Bhagat <indu.bhagat@oracle.com>, 
	linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 11:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Sep 18, 2024 at 08:38:22AM +0200, Ian Rogers wrote:
> > On Wed, Sep 18, 2024 at 12:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hello,
> > >
> > > This is a counterpart for Josh's kernel change v2 [1] to support defe=
rred
> > > user callchains.  The change is transparent and users should not noti=
ce
> > > anything with the deferred callchains.
> > >
> > >   $ perf record -g sleep 1
> > >
> > > I added --[no-]merge-callchains option to control output of perf scri=
pt.
> > > You can verify it has the deferred callchains like this:
> > >
> > >   $ perf script --no-merge-callchains
> > >   perf     801 [000]    18.031793:          1 cycles:P:
> > >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kerne=
l.kallsyms])
> > >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> > >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> > >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> > >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms=
])
> > >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kal=
lsyms])
> > >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsym=
s])
> > >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.ka=
llsyms])
> > >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> > >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> > >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> > >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> > >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> > >
> > >   perf     801 [000]    18.031814: DEFERRED CALLCHAIN
> > >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-lin=
ux-gnu/libc.so.6)
> > >
> > >   ...
> > >
> > > When the callchain is merged (it's the default) it'd look like below:
> > >
> > >   $ perf script
> > >   perf     801 [000]    18.031793:          1 cycles:P:
> > >           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kerne=
l.kallsyms])
> > >           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
> > >           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
> > >           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
> > >           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms=
])
> > >           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kal=
lsyms])
> > >           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsym=
s])
> > >           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.ka=
llsyms])
> > >           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
> > >           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
> > >           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
> > >           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
> > >           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
> > >                   7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-lin=
ux-gnu/libc.so.6)
> > >
> > >   ...
> > >
> > > Notice that the last line and it has the __GI___ioctl in the same
> > > callchain.  It should work with other tools like perf report.
> >
> > Hi Namhyung, I think this is interesting work!
> >
> > The issue feels similar to leader sampling and some of the unpicking
> > of that we've been dealing with. With leader sampling it was added and
> > then the dispatch of events modified so that tools wouldn't see leader
> > samples, instead new events would be synthesized based on the leader
> > sample data. However, the leader sample event wasn't changed and so
> > now we have multiple repeated events and perf inject wouldn't just
> > pass through a perf data file.
> >
> > What I'm expecting based on this description is that a deferred call
> > chain will be merged with a regular one, however, perf inject isn't
> > updated to drop the deferred callchain so now we have the deferred
> > callchain event twice.
> >
> > My feeling is that making the dispatch of events to tools "smart" is a
> > false economy. Tools can add handlers for these events easily enough.
> > What's harder is undoing the smartness when it does things that lead
> > to duplicated events and the like. I'm not a fan of how leader
> > sampling was implemented and I still think it odd that with perf
> > script we see invented events when trying to just dump the contents of
> > a perf.data file.
>
> That's why I added perf_tool.merge_deferred_callchains flag to control
> the behavior.  I haven't implemented it to perf inject because it covers
> a couple of different use cases.  I believe the default behavior is to
> not invoke the callback for deferred callchains during perf inject and
> each sample will get the full callchains.  But you can add a new
> callback and set perf_tool.merge_deferred_callchains to false.

I wonder if there is a different strategy for handling this. Normally
with a visitor pattern you fail when you call an unimplemented
visitor, this is then a signal the (in our case) tool needs to handle
the new case. This avoids naively doing things like making perf inject
duplicate events. The equivalent in the perf code would be to
initialize the callbacks in the tool constructor to be to stubs that
abort, then explicitly initialize and use things like callchain
merging as appropriate. The whole booleans next to the callbacks feels
like a kludge and likely to hide bugs. It is also marginally less
efficient.

Thanks,
Ian

