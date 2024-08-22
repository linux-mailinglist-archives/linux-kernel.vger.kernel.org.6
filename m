Return-Path: <linux-kernel+bounces-297508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EC95B9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE412837D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3B3CF63;
	Thu, 22 Aug 2024 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mCiRi6V5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B917C8B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339731; cv=none; b=ZDXJTL9WQnMIexfyLXFmzSnVORxDXvjSe4HAPl30ikmkzts0HVz5dHnFqnFFfNgfezIEvPeU5Wz9KNhOfTOLSHmlS0BekwLChZZ95oNNe+9oAy7LhPWOWD/njQ+9Zc9K0Mn+qZOCombxys+KekF6+sZzI/PelQPXxdkEE9qmdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339731; c=relaxed/simple;
	bh=BUzcI7OukSS13o2EOotZtgvbOMnfxnRYGYS1AuA8RtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxgWlNeiKJuddnpBnsPl6QQH9OBbKSlNjZ8UPaXqtKXSHtGAs3snymkhu8RsTlEpavgydZkLqTC48me9Xi7j3bWv/8Y2acfZhov1nGqLk32SNWjtSTRrrK+lDxqkkEOw2MXnzjJvkBsqguMyYwYzbQlt1LnoSZqs8hXOUoWzcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mCiRi6V5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20260346ca1so216305ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724339728; x=1724944528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lck+dKvH8IO6d/hyhyQtHkkuQFQqgFpWof7AZCeNw9c=;
        b=mCiRi6V5OYD6/cIdWyohJ6kPWdgwZvAlWko3k2veUEhm5Un+tb2ilasYX3OZiOekDL
         Jmt0t3LvvdGvyMewB6QPtCyqSHxdAg7gW+Wojj0Wueo1UmD4mczMvIaDxhHfNhbiWGrU
         j5LVavgwHNWtfKy3FkJEqlEOQCrYccvHyXrIZJKcvtTEvLPZ1SzMjJA7WLeztJg67q8x
         UIAsDoQVvnLXVINfBI4l9GICF5+xINhwgf/FP0c+xw6wZnXCECFPso6RO8uX7rzKZKLC
         qYvLUXcuwBrnu5woJ37Cg0WSyhYXw17bajPya+xafziun1KIB90hRj4GBre/sXoNfkVr
         TXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339728; x=1724944528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lck+dKvH8IO6d/hyhyQtHkkuQFQqgFpWof7AZCeNw9c=;
        b=KxicmTFlDoBDzhIzEOPYz9o4mF7/dGB1sttT1tyEHJQnAwo9N5ffx4JCRe1LURLxpL
         6a8tPRfIJ6uP+n8w0pEk42Kz5FGbwVxmD44a/J0zWtSq4zbAStTqZBf1suLpj0wvRQgV
         oyniuPG16G3rrjPJKoXBVaM+of+zBYHZbONLSODj80Tt1PzYSs+N/jaP1Q3/djB2WbgB
         Pfzl2WnZKWaC7xG+6e/IU0r11wmS4oXYHz+LH3OJo8BXxUtuH2TEyM4qe3ziz0JfGS5+
         O5UpBYI3eFSKv2LSGasuu70QwX/yg3BOB9eRPfd4KQga4gBOvaPkYukEmykrJsxLEGMB
         IQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrF1q2kesQyszJ+/gbFB4pkNzipCYfIEGwDPRQqKO5njDEKtEystnryIEHtIOojAaok+WFfBptQvXQLP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wKWa2qxQw/PEs9NBXt4Mkn2n64VIH4R0uLdiw2RrCHUSWm+o
	O2EP4MARxbheL9mOPBxEfmR1SKRUx+wAqT072FKP/Q8XQyDCCRV7/tNvY/DeOW7ca6l8u2AbVAU
	xH/U5hBsEIKGHo/8nwZfdCAvc6MiOoynd63YQ
X-Google-Smtp-Source: AGHT+IHNIxkXRfs6rii3n8WwQKyCifwdGwWDQT62P2QnRmbheBcHUcPmp8diG+t5fKpMkFMff43JVN8PjuaoB4dtrLg=
X-Received: by 2002:a17:902:ec92:b0:1fa:fe30:8fce with SMTP id
 d9443c01a7336-203855b162bmr2936145ad.23.1724339727292; Thu, 22 Aug 2024
 08:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
 <CAP-5=fUndbBhSLb35_bL-+Xu3erB6ssx-sAEYaf7mgxPawNEbA@mail.gmail.com>
 <65A24EAA-A348-4E77-AF5B-933B41C9CAB6@nutanix.com> <CAP-5=fVTB5DUybd7KnX-qb8yau+onkscm1a13izuZLH_WdXiyw@mail.gmail.com>
 <067B5698-9C34-4283-888B-DC691F3462A8@nutanix.com>
In-Reply-To: <067B5698-9C34-4283-888B-DC691F3462A8@nutanix.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Aug 2024 08:15:05 -0700
Message-ID: <CAP-5=fVU_ngSOsDs_9Ma=pyOPzD3jr-MYQC9LeAirR--bfA-BQ@mail.gmail.com>
Subject: Re: Perf test failures for 10.2 PMU event map aliases
To: Jon Kohler <jon@nutanix.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:01=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Aug 20, 2024, at 11:17=E2=80=AFAM, Ian Rogers <irogers@google.com> w=
rote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Tue, Aug 20, 2024 at 6:54=E2=80=AFAM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >>
> >>
> >>> On Aug 20, 2024, at 1:41=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
> >>>
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>>
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Mon, Aug 19, 2024 at 7:06=E2=80=AFPM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>>
> >>>> Reaching out to the perf community for feedback on the following
> >>>> observed test failure. On 6.6.y, I see persistent failures with test
> >>>> 10.2 PMU event map aliases, complaining about testing aliases uncore
> >>>> PMU mismatches. I've included two outputs below, one with a bit of
> >>>> hacky print debugging.
> >>>>
> >>>> Using Intel(R) Xeon(R) Gold 6154 CPU:
> >>>>       10.2: PMU event map aliases                                   =
      :
> >>>>       --- start ---
> >>>>       test child forked, pid 962901
> >>>>       Using CPUID GenuineIntel-6-55-4
> >>>
> >>> Hi Jon,
> >>>
> >>> Sorry for the brief reply but I thought some quick hints might unbloc=
k
> >>> you on this. The CPUID lines up with a SkylakeX:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n33&d=3DDwIFaQ&c=
=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUs=
FD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DF-eXsmTASgRsptt5Gahro6fR=
yMwEQdjZ6PtY7vhzIKM&e=3D
> >>>
> >>>>       testing core PMU cpu aliases: pass
> >>>>       JKDBG: pmu nr total 3 pmu->sysfs_aliases 3 pmu->sys_json_alias=
es 0
> >>>>       JKDBG: pmu cpu_aliases_added nr total 4 pmu->cpu_json_aliases =
1
> >>>>       testing aliases uncore PMU uncore_imc_0: mismatch expected ali=
ases
> >>>>         (1) vs found (4)
> >>>>       test child finished with -1
> >>>>       ---- end ----
> >>>>       PMU events subtest 2: FAILED!
> >>>>
> >>>> Using Intel(R) Xeon(R) Platinum 8352Y:
> >>>>       10.2: PMU event map aliases                                   =
      :
> >>>>       --- start ---
> >>>>       test child forked, pid 1765070
> >>>>       Using CPUID GenuineIntel-6-6A-6
> >>>
> >>> This is an IcelakeX:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_mapfile.csv-3Fh-3Dperf-2Dtools-2Dnext-23n18&d=3DDwIFaQ&c=
=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661xzakrB42hsUs=
FD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3D6DwD4ZmywAtcwCnRjx7wRfmd=
W_G65wHIuyZJIc__2yc&e=3D
> >>>
> >>>>       testing core PMU cpu aliases: pass
> >>>>       testing aliases uncore PMU uncore_imc_free_running_0: mismatch
> >>>>         expected aliases (1) vs found (6)
> >>>>       test child finished with -1
> >>>>       ---- end ----
> >>>>       PMU events subtest 2: FAILED!
> >>>>
> >>>> Digging in more, looking at pmu_aliases_parse, I see that we'll disc=
ard
> >>>> scale and unit files in pmu_alias_info_file, which leaves us with 3x
> >>>> aliases in the uncore_imc_0 in the first case and 5x aliases in the
> >>>> uncore_imc_free_running_0 second case.
> >>>>
> >>>> # From 6154-based system:
> >>>> ls -lhat /sys/devices/uncore_imc_0/events
> >>>
> >>> The "uncore_" prefix and the "_0" suffix are optional, the naming
> >>> matching is case insensitive. In the event json the events are listed
> >>> here:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_skylakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext&d=
=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DRJx661x=
zakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DFpAgVwLmTyXUF=
QIMZ_gbPlH9aXvrmcJ8CZaW3tKIaj4&e=3D
> >>>
> >>>> total 0
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_read
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_write
> >>>> -r--r--r--. 1 root root 4.0K Aug  9 15:30 clockticks
> >>>
> >>> This should be 3 sysfs events (I don't like the term alias), note tha=
t
> >>> we load the sysfs and json events lazily to avoid overhead.
> >>>
> >>>> drwxr-xr-x. 2 root root    0 Jul 17 03:40 .
> >>>> drwxr-xr-x. 5 root root    0 Jul 17 02:52 ..
> >>>>
> >>>> # From the 8352Y-based system:
> >>>> ls -lhat /sys/bus/event_source/devices/uncore_imc_free_running_0/eve=
nts
> >>>> total 0
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 read.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.scale
> >>>> -r--r--r--. 1 root root 4.0K Aug 20 01:44 write.unit
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 dclk
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_read
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_write
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 read
> >>>> -r--r--r--. 1 root root 4.0K Aug 19 21:33 write
> >>>
> >>> This is 5 sysfs events, the json events are here:
> >>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_pub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-=
2Devents_arch_x86_icelakex_uncore-2Dmemory.json-3Fh-3Dperf-2Dtools-2Dnext-2=
3n134&d=3DDwIFaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3D=
RJx661xzakrB42hsUsFD1HhJczkgpaYur9lHVtl7j36__CBOqYfKf4Dnq0xdpBZl&s=3DMrHuUC=
ZFqrNrd05IPyq4fuZDH4_owkEw0xHcc7bvGvU&e=3D
> >>> Note, the "Unit", meaning the PMU should be imc_free_running to match
> >>> this device.
> >>>
> >>>> drwxr-xr-x. 2 root root    0 Aug 15 03:15 .
> >>>> drwxr-xr-x. 5 root root    0 Aug 15 02:42 ..
> >>>>
> >>>> Looking at the structure of __test_uncore_pmu_event_aliases, however=
,
> >>>> I'm not quite sure how this is supposed to work. I've annotated a wa=
lk
> >>>> through below to highlight where things are going off the rails.
> >>>>
> >>>> static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu =
*test_pmu)
> >>>> {
> >>>> ...
> >>>>       /* Count how many aliases we generated */
> >>>>       alias_count =3D perf_pmu__num_events(pmu);
> >>>>               // alias_count =3D=3D 4 in the 6154-based system
> >>>>               // alias_count =3D=3D 6 in the 8352Y-based system
> >>>>
> >>>>       /* Count how many aliases we expect from the known table */
> >>>>       for (table =3D &test_pmu->aliases[0]; *table; table++)
> >>>>               to_match_count++;
> >>>>                       // this is looking at aliases in struct perf_p=
mu_test_pmu
> >>>>                       // table, which for uncore_imc_0 is a single e=
ntry for
> >>>>                       // &uncore_imc_cache_hits.
> >>>>                       //
> >>>>                       // for the 8352Y case, likewise, we only have =
a single alias
> >>>>                       // in the table for &uncore_imc_free_running_c=
ache_miss.
> >>>>                       //
> >>>>                       // in both cases, to_match_count =3D=3D 1
> >>>>
> >>>>       // Compare 4 vs 1 or 6 vs 1
> >>>>       if (alias_count !=3D to_match_count) {
> >>>>               pr_debug("testing aliases uncore PMU %s: mismatch expe=
cted aliases (%d) vs found (%d)\n",
> >>>>                        pmu_name, to_match_count /* 1 */, alias_count=
 /* 4 */);
> >>>>               return -1;
> >>>>                       // we seemed doomed to hit this conditional al=
ways, no?
> >>>>       }
> >>>> ...
> >>>> }
> >>>>
> >>>> I did a walkthrough of the latest mainline code, and don't see a mar=
ked
> >>>> difference that jump off the page to me that'd correct this behavior=
,
> >>>> and would love a helping hand to point in the right direction on thi=
s.
> >>>>
> >>>> What am I missing here?
> >>>
> >>> I'll need some more time to dig into this. Hopefully the pointers abo=
ve help.
> >>
> >> Thanks for the quick reply and pointers, I appreciate it. The tricky b=
it still
> >> remains, as the code I posted to above seems to solely depend on the
> >> info filled into struct perf_pmu_test_pmu, right? If so, I don=E2=80=
=99t see how the
> >> dots connect from this test to the other events in sysfs/json=E2=80=99=
s.
> >
> > So looking at the test it is using the testcpu:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_tests_=
pmu-2Devents.c-3Fh-3Dperf-2Dtools-2Dnext-23n602&d=3DDwIFaQ&c=3Ds883GpUCOChK=
OHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DupMgwNSdGAw5sdDUTdoyvXhLy4KhFUYqP=
dxZKx8Ov-ZxDYERFVy8PU040wwDAYPp&s=3DerGg8kUByjl_j5R0D0PxRZjTZhvazxwC9KW8rOT=
9Pp4&e=3D
> > the json for that is here:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_perf_perf-2Dtools-2Dnext.git_tree_tools_perf_pmu-2D=
events_arch_test_test-5Fsoc_cpu-3Fh-3Dperf-2Dtools-2Dnext&d=3DDwIFaQ&c=3Ds8=
83GpUCOChKOHiocYtGcg&r=3DNGPRGGo37mQiSXgHKm5rCQ&m=3DupMgwNSdGAw5sdDUTdoyvXh=
Ly4KhFUYqPdxZKx8Ov-ZxDYERFVy8PU040wwDAYPp&s=3Dz535_TbF_oJLjEoRuhbbqzB9Xo5Mw=
WWmOcP0pgMulWY&e=3D
> > The names in the test are based on ones seen on real CPUs, so this may
> > be leading to the confusion.
>
> Hey Ian,
> I was able to debug this a bit more. The following diff fixes this test o=
n my system.
>
> Even though we were supposed to be using the test data only, the sysfs en=
tries
> from my systems, which happened to have similar names, threw a wrench in
> this test.
>
> With this diff, we just use the JSON aliases that were added.
>
> Happy to send this out as a formal patch, but wanted to get the list=E2=
=80=99s 2cents
> first, as I feel like I=E2=80=99m missing something :)
>
> Jon
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index f5321fbdee79..893dc7afee76 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -584,6 +584,9 @@ static int __test_uncore_pmu_event_aliases(struct per=
f_pmu_test_pmu *test_pmu)
>         const struct pmu_events_table *events_table;
>         int res =3D 0;
>
> +       /* CPU events come from struct pmu_event pmu_events__test_soc_cpu
> +        * and sys events come from struct pmu_event pmu_events__test_soc=
_sys
> +        */
>         events_table =3D find_core_events_table("testarch", "testcpu");
>         if (!events_table)
>                 return -1;
> @@ -593,10 +596,14 @@ static int __test_uncore_pmu_event_aliases(struct p=
erf_pmu_test_pmu *test_pmu)
>         pmu->sysfs_aliases_loaded =3D true;
>         pmu_add_sys_aliases(pmu);
>
> -       /* Count how many aliases we generated */
> -       alias_count =3D perf_pmu__num_events(pmu);
> +       /* How many events we gathered for this PMU in test_soc.
> +        * Note: we specifically do not use perf_pmu__num_events as that =
may
> +        * include spurious system events from the system under test, whi=
ch
> +        * may have similarly named PMUs.

Thanks Jon, should we just rename the PMUs in the test json files? For
example, rather than "CBO" here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json?h=3Dperf-tools-=
next#n10
we can have "test_pmu1".

Thanks for investigating this!
Ian

> +        */
> +       alias_count =3D pmu->cpu_json_aliases + pmu->sys_json_aliases;
>
> -       /* Count how many aliases we expect from the known table */
> +       /* How many aliases we expect from struct perf_pmu_test_pmu test_=
pmus */
>         for (table =3D &test_pmu->aliases[0]; *table; table++)
>                 to_match_count++;
>
> >
> > Thanks,
> > Ian
>

