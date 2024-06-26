Return-Path: <linux-kernel+bounces-231268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D1918A02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9BE1F227FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5E18FDBA;
	Wed, 26 Jun 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GG2nXX1a"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E017FAAE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422576; cv=none; b=bEXlUX90GfcIGjbfMGEvDnAm0b7XSc6x+7ibiYePYzObVh585J9HAHnb719lgV0v1zBFfa8LN98DLEPdgNxzr5u/xAP60LhYd4kTFu5ShzW2RmPA3lOcwPGbO03U8xvcTkPKG7Ilxk14tB+NN5QJNEqSP3SO7/kjEKc6HNjrqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422576; c=relaxed/simple;
	bh=VkvMWkHV9aKEfKELl2m1US5V3WSkvL9M+S9Ohre03+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvUDAf9riCzKkSMWcEz45m+4VOSjPbrS5Lbr99V2lSCF2r1YW7RILeM+zsESD7uZ2YrGDHLw+OphpGgXq7ZxlVLhZHrj4YkQd8FZF77APb39OxaOXl2gIqeH/0KfPmfwTKrGbXydx04gfvpctCWworVWs/PWTTKJ1gZWugXhHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GG2nXX1a; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37624917c2dso8615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719422573; x=1720027373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeXOJjjn1nhah8Sj1GnBVp3rxV9JZOPvw26TUKGjYNU=;
        b=GG2nXX1aO5N7BfyyR45fjdDd6TKcPK1HYRgbDORzL9KbC4xF632XW2wgKlOLNB97+2
         vkC4xipF0l7ML1BW5mIHQXkPr+t4HM6afKKSo6XOHrXaUAoAqV0RFhKwnE1ziwHbhfXv
         m1TsjIhKChklIYlzjof+ZMKYhJsvha+ACUTBVHHqkYlT2/ZYykIR0io7IewFWwwCHY3+
         /YUtoDmXqxtvSuV+VyO4S02t2j19BA3GJSvq7KUadn63Z3miCIwONnSz9D01d2FEWguJ
         CpAZwoEqEvTM6ILxFxcI6RC1HTymTzk8geePrT0qmAHNAUn+jhmYuSCHh42QcNS0+jLi
         Pk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422573; x=1720027373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeXOJjjn1nhah8Sj1GnBVp3rxV9JZOPvw26TUKGjYNU=;
        b=Rfm9Vd3sULB7b3pyDDR6ZlhJASe76g/9BGP1aD/jT+DfwH0zQiiHPdAqAKZL75S5hz
         BzKkzPNflafCV+NvYtTnLAF8aT7wSCEeHeLASSXy2dkwKVKR3b4XtKUau5XUaSjaVD7R
         SjTqcJNI63ivmWnuLX59zRHsHDUw+OMh7/7ALVOU2aV7rQJYacYBbDfR6IegajIPI59J
         lrwxBQnql7t15nglj6UyY9O0E/hS2RWSQxjPhAsDpMOmGUM8sdffEsGcXQFCQ3W2TK+Z
         aegOAIaUQEOTLWotDMczbEUfkX312LCSZ92jo5EOC23DpjMwulgq0WhVu9wMewfjSfeF
         uUcA==
X-Forwarded-Encrypted: i=1; AJvYcCWkPlqcRLNb/QsdSOKAJNv7uVvkeya5x1P4jocMLbTdo5WfiQvhW58dtihdjtEoPRogClVOU4LKcvst/aVYyv9gdKjLwNQcm15x7NBu
X-Gm-Message-State: AOJu0Yxlsg5FVrkbRF4tylnLT/v4u6s2ICkWWG15quw1fKhiBwZv6Xbn
	8+8cEGXKcCc445kMm3SUK3tdeCixMdrU8WfpwV0D0C4XR+nlRUJlfM5Yyw8z0dQWYSSAO+e0VnH
	pw+I5ec7QjXEt3epaB7sIY9P3pcGRSh3+WS84
X-Google-Smtp-Source: AGHT+IFUwvlljXV409yXQZs3gHjsMmGoiegYHBgNB3piCBa5EHhEl+1g81owC/xxicpSA2QuZOuTU2w13RoEjSH57rw=
X-Received: by 2002:a05:6e02:184b:b0:376:3725:e2c7 with SMTP id
 e9e14a558f8ab-37962575b0amr115755ab.19.1719422573437; Wed, 26 Jun 2024
 10:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625182256.291914-1-kan.liang@linux.intel.com>
 <CAP-5=fXvmDSPVOWhcNzSZ7icBh6PhdgpbopFCZgzZWYk_kGadA@mail.gmail.com> <2a4a8ef5-a292-42a8-80fa-a2e8373ab375@linux.intel.com>
In-Reply-To: <2a4a8ef5-a292-42a8-80fa-a2e8373ab375@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Jun 2024 10:22:41 -0700
Message-ID: <CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com>
Subject: Re: [PATCH V2 00/13] Support Lunar Lake and Arrow Lake core PMU
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:11=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-06-26 1:20 a.m., Ian Rogers wrote:
> > On Tue, Jun 25, 2024 at 11:22=E2=80=AFAM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Changes since V1:
> >> - Add x86/intel_pmu_max_num_pebs/counters/counters_fixed()
> >> - Rename model-specific pebs_latency_data functions
> >> - Rename V6 counter MSRs
> >>
> >> From the core PMU' perspective, the Lunar Lake and Arrow Lake are the
> >> same, which are similar to the previous generation Meteor Lake. Both a=
re
> >> hybrid platforms, with e-core and p-core.
> >>
> >> The key differences include:
> >> - The e-core supports 3 new fixed counters
> >> - The p-core supports an updated PEBS Data Source format
> >> - More GP counters (Updated event constraint table)
> >> - New Architectural performance monitoring V6
> >>   (New Perfmon MSRs aliasing, umask2, eq).
> >> - New PEBS format V6 (Counters Snapshotting group)
> >> - New RDPMC metrics clear mode
> >>
> >> The details for the above new features can be found in the Intel
> >> Architecture Instruction Set Extensions and Future Features (052).
> >> https://cdrdv2.intel.com/v1/dl/getContent/671368
> >>
> >> The counters may not be continuous anymore. Patch 1-2 converts the max
> >> number of counters to a mask of counters. The change is a generic chan=
ge
> >> which impacts all X86 platforms.
> >>
> >> Patch 3-4 supports all the legacy features on LNL and ARL.
> >>
> >> Patch 5-7 supports the new Architectural performance monitoring V6.
> >>
> >> Patch 8-11 supports the new PEBS format V6.
> >>
> >> Patch 12 supports the new RDPMC metrics clear mode.
> >>
> >> Kan Liang (13):
> >>   perf/x86/intel: Support the PEBS event mask
> >>   perf/x86: Support counter mask
> >>   perf/x86: Add Lunar Lake and Arrow Lake support
> >>   perf/x86/intel: Rename model-specific pebs_latency_data functions
> >>   perf/x86/intel: Support new data source for Lunar Lake
> >>   perf/x86: Add config_mask to represent EVENTSEL bitmask
> >>   perf/x86/intel: Support PERFEVTSEL extension
> >>   perf/x86/intel: Support Perfmon MSRs aliasing
> >>   perf/x86: Extend event update interface
> >>   perf: Extend perf_output_read
> >>   perf/x86/intel: Move PEBS event update after the sample output
> >>   perf/x86/intel: Support PEBS counters snapshotting
> >>   perf/x86/intel: Support RDPMC metrics clear mode
> >
> > Fwiw and beside the nit:
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks!
>
> >
> > It seems some of the behaviors could have tests upon them, would it be
> > possible to add them skipping the test on older and non-Intel
> > architectures?
>
> I think only the two features (Architectural performance monitoring V6
> and the RDPMC metrics clear mode) add new formats, which impacts the ABI.
>
> The perf tool has a "Sysfs PMU tests" case to verify the event format.
> It creates a fake sysfs mount to verify all the possible format
> definitions, rather than the real format on a given machine.
>
> I think the test case make sense, since it's impossible to test all the
> formats. As long as all the possible combinations of the format
> definition are supported, the perf tool should be good.
>
> The umask becomes non-contiguous in V6. There is already a case in the
> "Sysfs PMU tests" to cover such format definition.
> The current perf test should be good enough to cover the ABI changes.
>
> 9: Sysfs PMU tests                                                 :
> 9.1: Parsing with PMU format directory                             : Ok
> 9.2: Parsing with PMU event                                        : Ok
> 9.3: PMU event names                                               : Ok
> 9.4: PMU name combining                                            : Ok
> 9.5: PMU name comparison                                           : Ok

That's good. I was thinking more about leader sampling testing. We
have an attribute test and an event parsing test, but nothing that
currently tests leader sampling actually works even if it is just a
coverage test. We could do something like this:

```
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/reco=
rd.sh
index 3d1a7759a7b2..9b61e2d01c9e 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -190,11 +190,29 @@ test_branch_counter() {
  echo "Basic branch counter test [Success]"
}

+test_leader_sampling() {
+  echo "Basic leader sampling test"
+  if ! perf record -o "${perfdata}" -g -e
"{instructions,branch-misses}:S" ${testprog} 2> /dev/null
+  then
+    echo "Leader sampling [Failed record]"
+    err=3D1
+    return
+  fi
+  if ! perf script -D -i "${perfdata}" | grep -q "sample_read:"
+  then
+    echo "Leader sampling [Failed missing output]"
+    err=3D1
+    return
+  fi
+  echo "Basic leader sampling test [Success]"
+}
+
test_per_thread
test_register_capture
test_system_wide
test_workload
test_branch_counter
+test_leader_sampling

cleanup
exit $err
```

But it'd be nice if we had coverage of things like fixed counters vs
generic, the improvements now fixed in LNL, etc.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >>  arch/x86/events/amd/core.c           |  26 +-
> >>  arch/x86/events/core.c               | 123 +++----
> >>  arch/x86/events/intel/core.c         | 471 ++++++++++++++++++++------=
-
> >>  arch/x86/events/intel/ds.c           | 288 +++++++++++++---
> >>  arch/x86/events/intel/knc.c          |   2 +-
> >>  arch/x86/events/intel/p4.c           |  12 +-
> >>  arch/x86/events/intel/p6.c           |   2 +-
> >>  arch/x86/events/perf_event.h         | 105 +++++-
> >>  arch/x86/events/perf_event_flags.h   |   2 +-
> >>  arch/x86/events/zhaoxin/core.c       |  14 +-
> >>  arch/x86/include/asm/intel_ds.h      |   1 +
> >>  arch/x86/include/asm/msr-index.h     |   6 +
> >>  arch/x86/include/asm/perf_event.h    |  27 ++
> >>  include/uapi/linux/perf_event.h      |   6 +-
> >>  kernel/events/core.c                 |  15 +-
> >>  tools/perf/Documentation/topdown.txt |   9 +-
> >>  16 files changed, 839 insertions(+), 270 deletions(-)
> >>
> >> --
> >> 2.35.1
> >>
> >

