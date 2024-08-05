Return-Path: <linux-kernel+bounces-274859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF6947DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30857B247AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1452B149DFC;
	Mon,  5 Aug 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8uullYj"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7E3F9D5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870628; cv=none; b=apVSBYHSIxW10f+RGkh2Di+HOfnTvLIl32+kGWoESKPdg1bjF510a3twq8TrIDkCIRM0m+W4vlLEj362eXjSidWdvdT8cDLGlcD0vhwPE2jnAaUEgUgytpzVRz4UbI+g9PzX4uqfa3yUNwOMzhqB1GS18hR5bQOBbU6epxVw9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870628; c=relaxed/simple;
	bh=KScPjohjbhyyE6Unt1xkdQUQ0WABmDePhEc4uGcahCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFsjHUBXP7m1DvliTxlCKLn9bf2jweiOdKBNu48H6mRYetuyf+AH37s3nAW1iINzdHprR0L2rYDiLOoxnzz9KdGp6qZVWzKdiOee3/Drn8sOn2nAh2UvAgdWgzLrBXGHJFhnZIwOiLMoThmXbx+uNwDbqdGx2yOnVJEQH1J0tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l8uullYj; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4518d9fa2f4so836631cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722870625; x=1723475425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cliPh0WiWvhjAhJbOyi+/6Y4aMCNN/jaTH5lyyuz2Ds=;
        b=l8uullYjwmsiydD39Q2xbrFtgjz++9u7CDR70w/EvUMSiJaeVJQJSvf8O07R4h9BxD
         tu4t61MfQ8RASBeTKVmT8QK3YBFrNCE0qfDR6+rWq/sqpAVrOEVm2/kNUAywCQVk2VXm
         fLjc3+p8qFUBIzP/C0BNChCDBuvW3GrCNzkJX0wF3pHIiX9I1o6ufhxmADJ29NjVglsq
         E8iZlcUOwFnJQ9rlUzxdeBF07DuenUB4uUcLhVeNnIiDJeU2jfM3KMSfL2LPb89odNEe
         cizneooKeJ01nVNqmU3AbxBm6g43BbpFX0pzQ+j+RF9dMiX3BKfEWHPPPp2lvHS6MA1R
         BxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870625; x=1723475425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cliPh0WiWvhjAhJbOyi+/6Y4aMCNN/jaTH5lyyuz2Ds=;
        b=b78xD7lD1oGFIofGCo6IBQIuCbXOERnE+oC8Zdfo+eyDZbVIjpGG9ET4KnHP2gN6D5
         Dq76E6WCZ0bd57ch6s0zhyvv3/Wbo2Yea35uXcikEocUy+DDzIP5mVV6A8ZEhE8gLevp
         caF6rQ18jWFXxvzJl4lTX1ZYwhwXR8/krT9DaOg4VsIITTkNAF6yTRX0CYtTzxOEghXM
         g7cNPvJcr8pOHH+3k6Ps5z/vla1z0bYUe286G6GHaTqlcsun9ZYpdwvr6pMNk2nH/gSy
         1EZROFNCArC6h9bgqYePds/4a2zR71gdasFt6j6ZKUS919AuAGlOTedq/C/XzpIgOwhW
         rcUg==
X-Forwarded-Encrypted: i=1; AJvYcCU2R1cXB6QS+c9GpyUb/l1HqoeR9ccOUwfRZ12oNJtQvAaeOophARr/17glw/CyjAqrlX45evEcZM9upr2R95aC2H2LbU5b8Krpte9w
X-Gm-Message-State: AOJu0YybrPbayuKSynpsrbi9FpDlbjsNpyG27CVu9seXtbeRlHqGFeUr
	1LdYPQ8ld9f0ukcgnup9mrFdbgTpldhBWBNxOdKeTeAEF6ML/qWNFvxcQLhPiShI6ozyGp7yl3L
	kiJY8Vz0dB9LYxQH7NjKjx0JrAqE+l4By2sSr
X-Google-Smtp-Source: AGHT+IFijdGhgOF6LxfiS+kMgCTkAqfv1SMmw6/Yu5tfWCrV1MznIh1MToqxUJv1IafptMwMQqU72ywvaj2j2EO21TU=
X-Received: by 2002:ac8:7e8d:0:b0:447:d78d:773b with SMTP id
 d75a77b69052e-4519ad01864mr4780151cf.6.1722870624911; Mon, 05 Aug 2024
 08:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com> <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
In-Reply-To: <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 Aug 2024 08:10:12 -0700
Message-ID: <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: Namhyung Kim <namhyung@kernel.org>
Cc: weilin.wang@intel.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello Weilin,
>
> On Fri, Jul 19, 2024 at 11:21=E2=80=AFPM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Change in v18:
> >  - Update to exit 2 in TPEBS shell test when not on Intel platform.
> >  - Several updates to use EVLIST_CTL_CMD_ENABLE_TAG, EVLIST_CTL_CMD_ACK=
_TAG, and
> >  etc.
> >
> > Changes in v17:
> >  - Add a poll on control fifo ack_fd to ensure program returns successf=
ully when
> >  perf record failed for any reason.
> >  - Add a check in the tpebs test to only run on Intel platforms.
> >
> > Changes in v16:
> >  - Update tpebs bash test code and variable name.
> >  - Add a check to ensure only use "-C" option when cpumap is not "-1" w=
hen
> >  forking "perf record".
> >
> > Changes in v15:
> >  - Revert changes added for python import test failure in v14 because t=
he code
> >  works correctly with the new python build code.
> >  - Update the command line option to --record-tpebs.
> >
> > Changes in v14:
> >  - Fix the python import test failure. We cannot support PYTHON_PERF be=
cause it
> >  will trigger a chain of dependency issues if we add intel-tpebs.c to i=
t. So,
> >  only enable tpebs functions in evsel and evlist when PYTHON_PERF is no=
t
> >  defined.
> >  - Fix shellcheck warning for the tpebs test.
> >
> > Changes in v13:
> >  - Add document for the command line option and fix build error in non-=
x86_64.
> >  - Update example with non-zero retire_latency value when tpebs recordi=
ng is
> >  enabled.
> >  - Add tpebs_stop() back to tpebs_set_evsel() because in hybrid platfor=
m, when
> >  the forked perf record is not killed, the reader thread does not get a=
ny
> >  sampled data from the PIPE. As a result, tpebs_set_evesel() will alway=
s return
> >  zero on retire_latency values. This does not happen on my test GNR mac=
hine.
> >  Since -I is not supported yet, I think we should add tpebs_stop() to e=
nsure
> >  correctness for now. More investigation is required here when we work =
on
> >  supporting -I mode.
> >  - Rebase code on top of perf-tools-next.
> >
> > Changes in v12:
> >  - Update MTL metric JSON file to include E-Core TMA3.6 changes.
> >  - Update comments and code for better code quality. Keep tpebs_start()=
 and
> >  tpebs_delete() at evsel level for now and add comments on these functi=
ons with
> >  more details about potential future changes. Remove tpebs_stop() call =
from
> >  tpebs_set_evsel(). Simplify the tpebs_start() and tpebs_stop()/tpebs_d=
elete()
> >  interfaces. Also fixed the bugs on not freed "new" pointer and the inc=
orrect
> >  variable value assignment to val instead of counter->val.
> >
> > Changes in v11:
> >  - Make retire_latency evsels not opened for counting. This works corre=
ctly now
> >  with the code Namhyung suggested that adjusting group read size when
> >  retire_latency evsels included in the group.
> >  - Update retire_latency value assignment using rint() to reduce precis=
ion loss
> >  while keeping code generic.
> >  - Fix the build error caused by not used variable in the test.
> >
> > Other changes in v10:
> >  - Change perf record fork from perf stat to evsel. All the major opera=
tions
> >  like tpebs start, stop, read_evsel should directly work through evsel.
> >  - Make intel-tpebs x86_64 only. This change is cross-compiled to arm64=
.
> >  - Put tpebs code to intel-tepbs and simplify intel-tpebs APIs to minim=
um number
> > of functions and variables. Update funtion name and variable names to u=
se
> > consistent prefix. Also improve error handling.
> >  - Integrate code patch from Ian for the :R parser.
> >  - Update MTL metrics to TMA 4.8.
> >
> > V9: https://lore.kernel.org/all/20240521173952.3397644-1-weilin.wang@in=
tel.com/
> >
> > Changes in v9:
> >  - Update the retire_latency result print and metric calculation method=
. Plugin
> > the value to evsel so that no special code is required.
> >  - Update --control:fifo to use pipe instead of named pipe.
> >  - Add test for TPEBS counting mode.
> >  - Update Document with more details.
> >
> > Changes in v8:
> >  - In this revision, the code is updated to base on Ian's patch on R mo=
difier
> > parser https://lore.kernel.org/lkml/20240428053616.1125891-3-irogers@go=
ogle.com/
> > After this change, there is no special code required for R modifier in
> > metricgroup.c and metricgroup.h files.
> >
> > Caveat of this change:
> >   Ideally, we will need to add special handling to skip counting events=
 with R
> > modifier in evsel. Currently, this is not implemented so the event with=
 :R will
> > be both counted and sampled. Usually, in a metric formula that uses ret=
ire_latency,
> > it would already require to count the event. As a result, we will endup=
 count the
> > same event twice. This should be able to be handled properly when we fi=
nalize our
> > design on evsel R modifier support.
> >
> >  - Move TPEBS specific code out from main perf stat code to separate fi=
les in
> > util/intel-tpebs.c and util/intel-tpebs.h. [Namhyung]
> >  - Use --control:fifo to ack perf stat from forked perf record instead =
of sleep(2) [Namhyung]
> >  - Add introductions about TPEBS and R modifier in Documents. [Namhyung=
]
> >
> >
> > Changes in v7:
> >  - Update code and comments for better code quality [Namhyung]
> >  - Add a separate commit for perf data [Namhyung]
> >  - Update retire latency print function to improve alignment [Namhyung]
> >
> > Changes in v6:
> >  - Update code and add comments for better code quality [Namhyung]
> >  - Remove the added fd var and directly pass the opened fd to data.file=
.fd [Namhyung]
> >  - Add kill() to stop perf record when perf stat exists early [Namhyung=
]
> >  - Add command opt check to ensure only start perf record when -a/-C gi=
ven [Namhyung]
> >  - Squash commits [Namhyung]
> >
> > Changes in v5:
> >  - Update code and add comments for better code quality [Ian]
> >
> > Changes in v4:
> >  - Remove uncessary debug print and update code and comments for better
> > readability and quality [Namhyung]
> >  - Update mtl metric json file with consistent TmaL1 and TopdownL1 metr=
icgroup
> >
> > Changes in v3:
> >  - Remove ':' when event name has '@' [Ian]
> >  - Use 'R' as the modifier instead of "retire_latency" [Ian]
> >
> > Changes in v2:
> >  - Add MTL metric file
> >  - Add more descriptions and example to the patch [Arnaldo]
> >
> > Here is an example of running perf stat to collect a metric that uses
> > retire_latency value of event MEM_INST_RETIRED.STLB_HIT_STORES on a MTL=
 system.
> >
> > In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sa=
mple.
> > Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p count and retire_late=
ncy value
> > are all 0.
> >
> > ./perf stat -M tma_dtlb_store -a -- sleep 1
> >
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.000 MB - ]
> >
> >  Performance counter stats for 'system wide':
> >
> >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  =
tma_dtlb_store
> >          3,195,608      cpu_core/topdown-retiring/
> >         40,156,649      cpu_core/topdown-mem-bound/
> >          3,550,925      cpu_core/topdown-bad-spec/
> >        117,571,818      cpu_core/topdown-fe-bound/
> >         57,118,087      cpu_core/topdown-be-bound/
> >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> >               0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0
> >
> >        1.003105924 seconds time elapsed
> >
> > v1:
> > TPEBS is one of the features provided by the next generation of Intel P=
MU.
> > Please refer to Section 8.4.1 of "Intel=C2=AE Architecture Instruction =
Set Extensions
> > Programming Reference" [1] for more details about this feature.
> >
> > This set of patches supports TPEBS in counting mode. The code works in =
the
> > following way: it forks a perf record process from perf stat when retir=
e_latency
> > of one or more events are used in a metric formula. Perf stat would sen=
d a
> > SIGTERM signal to perf record before it needs the retire latency value =
for
> > metric calculation. Perf stat will then process sample data to extract =
the
> > retire latency data for metric calculations. Currently, the code uses t=
he
> > arithmetic average of retire latency values.
> >
> > [1] https://www.intel.com/content/www/us/en/content-details/812218/inte=
l-architecture-instruction-set-extensions-programming-reference.html?wapkw=
=3Dfuture%20features
> >
> >
> >
> >
> > Ian Rogers (1):
> >   perf parse-events: Add a retirement latency modifier
> >
> > Weilin Wang (7):
> >   perf data: Allow to use given fd in data->file.fd
> >   perf stat: Fork and launch perf record when perf stat needs to get
> >     retire latency value for a metric.
> >   perf stat: Plugin retire_lat value from sampled data to evsel
> >   perf vendor events intel: Add MTL metric json files
> >   perf stat: Add command line option for enabling tpebs recording
> >   perf Document: Add TPEBS to Documents
> >   perf test: Add test for Intel TPEBS counting mode
>
> Thanks for your persistence!
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Ping.

Thanks,
Ian

