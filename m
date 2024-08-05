Return-Path: <linux-kernel+bounces-275470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F1948621
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718841C21D1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989B16D9DD;
	Mon,  5 Aug 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRZJ8M1W"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8215383D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900839; cv=none; b=D+e+4zJoxF+bQ9HOMD0N70s0W0lV3m/ZfJlZSxeTNeWFt7dzaLpY3C3fRg77ZivNO8Ona6BwrgmOY+Au+O0kvFzTsDnV/sNKM0F3x+ttINwyea0KyzQKDOyT+/rMlcJblQGQZgE/RlD0S4jDtY0fI5Ms+9bMuOprcp6rl6Ab080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900839; c=relaxed/simple;
	bh=QTRSPPSONXMEbcP0kHZene++54R2NDacJavt0//7Wlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5CkXzijAoi9WZRdHtg1VRd6k/5z5HiDZVxl+Yp9tHb7m6I/Pz8tR60gp7f4aqUtiiEjGvDUDGYEds+uLBmHCOX0hGKkkICaZLhqQ36zmDl7lQoxA9SqsPkWABN/VeXrWEpZVUZobcByAiFklCRCFxRO8nOZk6OhIRJFzTKPor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRZJ8M1W; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b368a636cso39835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722900836; x=1723505636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqZSYteTSQcaJ4WUUtb0semnsEdWUPVp/rULAK+a2jU=;
        b=SRZJ8M1WBAcNJrI+Pa2hDV0cuqcAaZQI2cT4j3TsJ5YqEB0ZOGx4tds9UC9hSM4PAn
         xYW68A3m5a7v8mcaQjW/uGSpeDZs+bb4SezJyzmPA5HX+13JwOFdTBLEZqSxxUXODyiW
         jlQ29W7ktO39qRMzKAtZEiRrmJCo0OjSwjUmmS7NDD30EXXrs7A/mkF6mWqMTSV+Pzbi
         XAtXSZtV/l1KNl4DlqsYZxqXnUJZ8W3YY2U///oSZHLh8mLXGin3nh33EVXTYUmo/LAr
         p0RkUbIouywBWlgN4Z6G/WHiNJIaMKXy8T6J5j+okIkZU3iSvMZmC5gKP5izfTpMfTvH
         q3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900836; x=1723505636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqZSYteTSQcaJ4WUUtb0semnsEdWUPVp/rULAK+a2jU=;
        b=QFUstVeRZGxEfzNlzBHl7LU38215M0fWnmwRlngGjvo04Jnnggv/EbrJd10+VxQ+9O
         71znFOmWcLlkJ08+1EMCrpcWu8fk68/trHrW/PCYPYl3UUTPLjkgPgboeWPkzCmBUqj4
         M2fxg/b5mkOQf3JqXVipequ72MG77KCR3gnyYR2Rf4UokC0FS2FpWW3lUINyvdAJvg/j
         9t/FFZB6FUxBnHKHb0/nuiEG+vySZi4b9oCtYd6Cn2/Kx8ja+j+GTbGcdl0avc7ikYlz
         6J5MAzh62OaFZiEvwIw0D1accDcEdLt++cwGM1BQClwxMGhPvczSTz85qpq404ojOj2Z
         Qbww==
X-Forwarded-Encrypted: i=1; AJvYcCXbSFC1MS6ugDfIcuvBhA9zvdyplQunM0InkB8zOf2RbOZ2dgZ05wgmqV/zR1cN7V+SS8MXIvz3WBXkRXaZA6CfTjMmjZZjflT8ESCK
X-Gm-Message-State: AOJu0Yxb7B/U3bxJ8uuEm5wbPp3jUbPQEiZQpNga+wi5Cbx0SZ2DErjC
	BXORvVETQJejcXEiLzUPOOMqwExhOOILGBkla5yfPLPTbgAmHPvDpnHcY4kWOD4c41ZGTQ34883
	zoKX5aWYTFCFIVEpRZU/fPeNaIKUV56e87rAW
X-Google-Smtp-Source: AGHT+IEibqFIXNMOsfTyowWCk0MrSVZRo1Z5RyYUsk7QJNZfWD9BuRRl9Bvn5iTz1jeqxUrQT0drknsvnjcFVWD2pQc=
X-Received: by 2002:a05:6e02:20ca:b0:377:bde:8f1d with SMTP id
 e9e14a558f8ab-39b484700cbmr1305875ab.2.1722900835976; Mon, 05 Aug 2024
 16:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com> <ZrEpJxtm5zlp5rbo@x1>
In-Reply-To: <ZrEpJxtm5zlp5rbo@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 16:33:44 -0700
Message-ID: <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:34=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 05, 2024 at 08:10:12AM -0700, Ian Rogers wrote:
> > On Mon, Jul 22, 2024 at 10:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > Hello Weilin,
> > >
> > > On Fri, Jul 19, 2024 at 11:21=E2=80=AFPM <weilin.wang@intel.com> wrot=
e:
> > > >
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > > >
> > > > Change in v18:
> > > >  - Update to exit 2 in TPEBS shell test when not on Intel platform.
> > > >  - Several updates to use EVLIST_CTL_CMD_ENABLE_TAG, EVLIST_CTL_CMD=
_ACK_TAG, and
> > > >  etc.
> > > >
> > > > Changes in v17:
> > > >  - Add a poll on control fifo ack_fd to ensure program returns succ=
essfully when
> > > >  perf record failed for any reason.
> > > >  - Add a check in the tpebs test to only run on Intel platforms.
> > > >
> > > > Changes in v16:
> > > >  - Update tpebs bash test code and variable name.
> > > >  - Add a check to ensure only use "-C" option when cpumap is not "-=
1" when
> > > >  forking "perf record".
> > > >
> > > > Changes in v15:
> > > >  - Revert changes added for python import test failure in v14 becau=
se the code
> > > >  works correctly with the new python build code.
> > > >  - Update the command line option to --record-tpebs.
> > > >
> > > > Changes in v14:
> > > >  - Fix the python import test failure. We cannot support PYTHON_PER=
F because it
> > > >  will trigger a chain of dependency issues if we add intel-tpebs.c =
to it. So,
> > > >  only enable tpebs functions in evsel and evlist when PYTHON_PERF i=
s not
> > > >  defined.
> > > >  - Fix shellcheck warning for the tpebs test.
> > > >
> > > > Changes in v13:
> > > >  - Add document for the command line option and fix build error in =
non-x86_64.
> > > >  - Update example with non-zero retire_latency value when tpebs rec=
ording is
> > > >  enabled.
> > > >  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid pla=
tform, when
> > > >  the forked perf record is not killed, the reader thread does not g=
et any
> > > >  sampled data from the PIPE. As a result, tpebs_set_evesel() will a=
lways return
> > > >  zero on retire_latency values. This does not happen on my test GNR=
 machine.
> > > >  Since -I is not supported yet, I think we should add tpebs_stop() =
to ensure
> > > >  correctness for now. More investigation is required here when we w=
ork on
> > > >  supporting -I mode.
> > > >  - Rebase code on top of perf-tools-next.
> > > >
> > > > Changes in v12:
> > > >  - Update MTL metric JSON file to include E-Core TMA3.6 changes.
> > > >  - Update comments and code for better code quality. Keep tpebs_sta=
rt() and
> > > >  tpebs_delete() at evsel level for now and add comments on these fu=
nctions with
> > > >  more details about potential future changes. Remove tpebs_stop() c=
all from
> > > >  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpe=
bs_delete()
> > > >  interfaces. Also fixed the bugs on not freed "new" pointer and the=
 incorrect
> > > >  variable value assignment to val instead of counter->val.
> > > >
> > > > Changes in v11:
> > > >  - Make retire_latency evsels not opened for counting. This works c=
orrectly now
> > > >  with the code Namhyung suggested that adjusting group read size wh=
en
> > > >  retire_latency evsels included in the group.
> > > >  - Update retire_latency value assignment using rint() to reduce pr=
ecision loss
> > > >  while keeping code generic.
> > > >  - Fix the build error caused by not used variable in the test.
> > > >
> > > > Other changes in v10:
> > > >  - Change perf record fork from perf stat to evsel. All the major o=
perations
> > > >  like tpebs start, stop, read_evsel should directly work through ev=
sel.
> > > >  - Make intel-tpebs x86_64 only. This change is cross-compiled to a=
rm64.
> > > >  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to m=
inimum number
> > > > of functions and variables. Update funtion name and variable names =
to use
> > > > consistent prefix. Also improve error handling.
> > > >  - Integrate code patch from Ian for the :R parser.
> > > >  - Update MTL metrics to TMA 4.8.
> > > >
> > > > V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wan=
g@intel.com/
> > > >
> > > > Changes in v9:
> > > >  - Update the retire_latency result print and metric calculation me=
thod. Plugin
> > > > the value to evsel so that no special code is required.
> > > >  - Update --control:fifo to use pipe instead of named pipe.
> > > >  - Add test for TPEBS counting mode.
> > > >  - Update Document with more details.
> > > >
> > > > Changes in v8:
> > > >  - In this revision, the code is updated to base on Ian's patch on =
R modifier
> > > > parser https://lore.kernel.org/lkml/20240428053616.1125891-3-iroger=
s@google.com/
> > > > After this change, there is no special code required for R modifier=
 in
> > > > metricgroup.c and metricgroup.h files.
> > > >
> > > > Caveat of this change:
> > > >   Ideally, we will need to add special handling to skip counting ev=
ents with R
> > > > modifier in evsel. Currently, this is not implemented so the event =
with :R will
> > > > be both counted and sampled. Usually, in a metric formula that uses=
 retire_latency,
> > > > it would already require to count the event. As a result, we will e=
ndup count the
> > > > same event twice. This should be able to be handled properly when w=
e finalize our
> > > > design on evsel R modifier support.
> > > >
> > > >  - Move TPEBS specific code out from main perf stat code to separat=
e files in
> > > > util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> > > >  - Use --control:fifo to ack perf stat from forked perf record inst=
ead of sleep(2) [Namhyung]
> > > >  - Add introductions about TPEBS and R modifier in Documents. [Namh=
yung]
> > > >
> > > >
> > > > Changes in v7:
> > > >  - Update code and comments for better code quality [Namhyung]
> > > >  - Add a separate commit for perf data [Namhyung]
> > > >  - Update retire latency print function to improve alignment [Namhy=
ung]
> > > >
> > > > Changes in v6:
> > > >  - Update code and add comments for better code quality [Namhyung]
> > > >  - Remove the added fd var and directly pass the opened fd to data.=
file.fd [Namhyung]
> > > >  - Add kill() to stop perf record when perf stat exists early [Namh=
yung]
> > > >  - Add command opt check to ensure only start perf record when -a/-=
C given [Namhyung]
> > > >  - Squash commits [Namhyung]
> > > >
> > > > Changes in v5:
> > > >  - Update code and add comments for better code quality [Ian]
> > > >
> > > > Changes in v4:
> > > >  - Remove uncessary debug print and update code and comments for be=
tter
> > > > readability and quality [Namhyung]
> > > >  - Update mtl metric json file with consistent TmaL1 and TopdownL1 =
metricgroup
> > > >
> > > > Changes in v3:
> > > >  - Remove ':' when event name has '@' [Ian]
> > > >  - Use 'R' as the modifier instead of "retire_latency" [Ian]
> > > >
> > > > Changes in v2:
> > > >  - Add MTL metric file
> > > >  - Add more descriptions and example to the patch [Arnaldo]
> > > >
> > > > Here is an example of running perf stat to collect a metric that us=
es
> > > > retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a=
 MTL system.
> > > >
> > > > In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORE=
S sample.
> > > > Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_=
latency value
> > > > are all 0.
> > > >
> > > > ./perf stat -M tma_dtlb_store -a -- sleep 1
> > > >
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.000 MB - ]
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6=
 %  tma_dtlb_store
> > > >          3,195,608      cpu_core/topdown-retiring/
> > > >         40,156,649      cpu_core/topdown-mem-bound/
> > > >          3,550,925      cpu_core/topdown-bad-spec/
> > > >        117,571,818      cpu_core/topdown-fe-bound/
> > > >         57,118,087      cpu_core/topdown-be-bound/
> > > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> > > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > > >               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0      =
  0
> > > >
> > > >        1.003105924 seconds time elapsed
> > > >
> > > > v1:
> > > > TPEBS is one of the features provided by the next generation of Int=
el PMU.
> > > > Please refer to Section 8.4.1 of "Intel=C2=AE Architecture Instruct=
ion Set Extensions
> > > > Programming Reference" [1] for more details about this feature.
> > > >
> > > > This set of patches supports TPEBS in counting mode. The code works=
 in the
> > > > following way: it forks a perf record process from perf stat when r=
etire_latency
> > > > of one or more events are used in a metric formula. Perf stat would=
 send a
> > > > SIGTERM signal to perf record before it needs the retire latency va=
lue for
> > > > metric calculation. Perf stat will then process sample data to extr=
act the
> > > > retire latency data for metric calculations. Currently, the code us=
es the
> > > > arithmetic average of retire latency values.
> > > >
> > > > [1] https://www.intel.com/content/www/us/en/content-details/812218/=
intel-architecture-instruction-set-extensions-programming-reference.html?wa=
pkw=3Dfuture%20features
> > > >
> > > >
> > > >
> > > >
> > > > Ian Rogers (1):
> > > >   perf parse-events: Add a retirement latency modifier
> > > >
> > > > Weilin Wang (7):
> > > >   perf data: Allow to use given fd in data->file.fd
> > > >   perf stat: Fork and launch perf record when perf stat needs to ge=
t
> > > >     retire latency value for a metric.
> > > >   perf stat: Plugin retire_lat value from sampled data to evsel
> > > >   perf vendor events intel: Add MTL metric json files
> > > >   perf stat: Add command line option for enabling tpebs recording
> > > >   perf Document: Add TPEBS to Documents
> > > >   perf test: Add test for Intel TPEBS counting mode
> > >
> > > Thanks for your persistence!
> > >
> > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Ping.
>
> I guess Namhyung's reviewed-by should suffice, but since you're pinging
> and I saw previous comments about this serie, would it be possible to
> get your Reviewed-by as well?

I'm happy with most of the changes and they can have my reviewed-by.
I'm not happy with:
perf stat: Fork and launch 'perf record' when 'perf stat' needs to get
retire latency value for a metric.
so please leave it off there.

Context: originally the patches aimed to abstract everything inside of
the evsel, now builtin-stat is manually starting and ending the
sub-process and has to be aware of TPEBS. There are ugly architectural
dependencies. My reviewed-by was correct on the earlier version, as
you could make a tpebs evsel just like any... other, open, close, read
it, etc. This would be useful say in a python script. This version to
my eyes is worse as all TPEBS dependencies are made explicit and the
caller needs to be aware of TPEBS. I understand Weilin was asked to
make some of the changes, and there was a desire for efficiency, but I
think things were better in earlier versions.

Thanks,
Ian

