Return-Path: <linux-kernel+bounces-356307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907A3995F53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54E8B23C62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C5161320;
	Wed,  9 Oct 2024 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8WMYyfc"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AB4A3F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453615; cv=none; b=QN13fM8QitquNjUDeNdZZFxseUvpd+haRIGc1FkXSTH2GgsLYnqY7zewK9gvYCOhk6X4DBtlslO1ksQPY89ne7+Ftv2JWVZsQEpJV733pGaJAzSxBeCZ96t4uqpxyaZd70OglTqHkREJKeA/T31uxf8nsFpKj9LY7SgiDTEsPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453615; c=relaxed/simple;
	bh=asfLAxTRlC3cvobna5DTLB9nS5fce0f+CgO4/yo72Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDFys0ASWuBUspzZFERHBsH8VoV/eNxe83GCBkucSJj2Ah/wjsZ3uX/UhqPMMLN1X3bLo0lVMhi0aOXqYt4DXpdgIsnarbxaue8r4I4nWKYtQGGfdecseUpuUlez29u0A1XvU8nZG/p96zioKd+8OZ1wEbzVaph7/mmw7SSSNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8WMYyfc; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a376e3acfbso140255ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728453613; x=1729058413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpHjahOhe44ljzpZmc/RFBRO2RSewAslIJugtIjKYKw=;
        b=o8WMYyfc1g34x7U+kp3zJ8LeTQzoPgfh7NKCWnR4QcN52giX4CIFqhhjJpreo90Ghx
         uSx9k7rl/p4UZ+yn6+3gxeI84inadduf5d/l5AaAsT4xNYcVTsbmiFnM4B+iNaLn4dh1
         rfzcyQoopqIBXJ0Lk+1HIjEdgnjeVrnVcKx7DLeLgDhp+Ffd/fnnfmfIrIz/rdi5l5W1
         6oAzMztwQ20LCIXy10PUTk2RdvJ+dAL4rz/mJoMxQ5XfPTkCFnFhbGgo0d42htfaTIYs
         emzhOYHRTgJ0JoulnjcPKmOwZDLnFzSnhREOt3acrLpAVzSlGj4nme+WJmcvZkrpKti2
         Lx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728453613; x=1729058413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpHjahOhe44ljzpZmc/RFBRO2RSewAslIJugtIjKYKw=;
        b=MeZby+NCouQQ5SFXSMF6+yH/786PEZ9yPP2a/4twvIpM3tFE9IUZP1oRpLCzF4Psxq
         OeR77Dvzs4zr+eM5EKa6+7gG7l8xZ0Ob7uppWMPRpvNpqmX4KSjYdqIhxR90L5eZ4cXQ
         x0gWI1biuKPQEHWe4tdlu3Cp19qktfz2mx1kWrlEBtrYmEXrYeYOYwOFft1m2E5FHLtZ
         jKEM6aRcnzKjT7ncLMTp7dACgBmujH/+pMB01En4q4CWCoeqpNkSg3h1t9uGgH/YS9WA
         BflPhGvpA7msQgHX8QtujMQoEsiG1M9cab53Ldua2+Craj8BWGPzBhW8kiQD7BErux1o
         l+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXM9DTgsNDctTC/qgbyOf5js5ieC8AKpp2mGmMf1ZCtoCJWXI+R4n80J3I8BmubTDEdKsWRuTYHFrj2ZWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcJI96f9gUl+LBm6qc90az46gvjy0sYtEMr/JzW3SWJDQSl6A
	StajEpD5Xc7tnxSn3gpDcElTYeRW2nwN1jmzqUWHlOs/nxUXvnd0JZSX6yXEvipzgLtDgLVvwsW
	Dpzm1POqPVupHDcB1iNIPts+zURx9KOmrD1AF
X-Google-Smtp-Source: AGHT+IEjzEJWcyZzTrRX8fXUseSsnm7TAu51kVqymrvMQvouqmphMtczHwwVgD1+IDekxcUn/FY8R1K8SrVF43QTzT4=
X-Received: by 2002:a05:6e02:1c44:b0:3a0:8dbf:8298 with SMTP id
 e9e14a558f8ab-3a396f5ddc7mr2921975ab.0.1728453612498; Tue, 08 Oct 2024
 23:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001171950.233723-1-irogers@google.com> <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>
 <ZwYW54gKOfnUboeZ@google.com>
In-Reply-To: <ZwYW54gKOfnUboeZ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 22:59:59 -0700
Message-ID: <CAP-5=fUY8d4DN+ekpj5B58kvoksrPcWpZU=iZhs+=bFfpakK3Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Oct 08, 2024 at 11:55:29AM -0700, Ian Rogers wrote:
> > On Tue, Oct 1, 2024 at 10:19=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > The path detection for "Setup struct perf_event_attr" test is brittle
> > > and leads to the test frequently not running. Running shell tests is
> > > reasonably robust, so make the test a shell test. Move the test files
> > > to reflect this.
> >
> > Ping.
> >
> > I think this is worthwhile cleanup for the attributes test. It should
> > avoid problems like:
> > https://lore.kernel.org/lkml/ZroNTkdA8XDFaDks@x1/
>
> Sorry, it's not clear to me what was the problem.  Can you please say it
> again briefly?

If you build perf like:
make -C tools/perf O=3D/tmp/perf

Then run the built perf test for the "Setup struct perf_event_attr" it
skips (causing the tests to bitrot and fixes to be sent by Veronika):
```
$ sudo /tmp/perf/perf test -vv perf_event_attr
capget syscall failed (No such file or directory - 2) fall back on root che=
ck
17: Setup struct perf_event_attr:
17: Setup struct perf_event_attr:
--- start ---
test child forked, pid 806601
Using CPUID GenuineIntel-6-8D-1
---- end(-2) ----
17: Setup struct perf_event_attr                                    : Skip
```

The issue is around the path set up, the test has a few path
expectations but they are brittle as shown above. While we could
endeavour to set up the path in C code, it makes sense to migrate the
test to a shell test due to the tests smaller size, ease of
environment variable manipulation, existing perf test support for
better path setup, etc. Ie let's not reinvent the shell test
infrastructure that handles python tests for the sake of one C test.
After this change:
```
$ sudo /tmp/perf/perf test attribute
76: Perf attribute expectations test                                : Ok
```

Thanks,
Ian

> >
> > > Ian Rogers (3):
> > >   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
> > >   perf test: Remove C test wrapper for attr.py
> > >   perf test: Move attr files into shell directory where they are used
> > >
> > >  tools/perf/Makefile.perf                      |   5 +-
> > >  tools/perf/perf.c                             |   2 -
> > >  tools/perf/tests/Build                        |   1 -
> > >  tools/perf/tests/attr.c                       | 218 ----------------=
--
> > >  tools/perf/tests/builtin-test.c               |   1 -
> > >  tools/perf/tests/shell/attr.sh                |  22 ++
> > >  tools/perf/tests/{ =3D> shell}/attr/README      |   0
> > >  tools/perf/tests/{ =3D> shell}/attr/base-record |   0
> > >  .../tests/{ =3D> shell}/attr/base-record-spe    |   0
> > >  tools/perf/tests/{ =3D> shell}/attr/base-stat   |   0
> > >  .../tests/{ =3D> shell}/attr/system-wide-dummy  |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-C0     |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-basic  |   0
> > >  .../{ =3D> shell}/attr/test-record-branch-any   |   0
> > >  .../attr/test-record-branch-filter-any        |   0
> > >  .../attr/test-record-branch-filter-any_call   |   0
> > >  .../attr/test-record-branch-filter-any_ret    |   0
> > >  .../attr/test-record-branch-filter-hv         |   0
> > >  .../attr/test-record-branch-filter-ind_call   |   0
> > >  .../attr/test-record-branch-filter-k          |   0
> > >  .../attr/test-record-branch-filter-u          |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-count  |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-data   |   0
> > >  .../{ =3D> shell}/attr/test-record-dummy-C0     |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-freq   |   0
> > >  .../attr/test-record-graph-default            |   0
> > >  .../attr/test-record-graph-default-aarch64    |   0
> > >  .../{ =3D> shell}/attr/test-record-graph-dwarf  |   0
> > >  .../{ =3D> shell}/attr/test-record-graph-fp     |   0
> > >  .../attr/test-record-graph-fp-aarch64         |   0
> > >  .../attr/test-record-group-sampling           |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-group1 |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-group2 |   0
> > >  .../{ =3D> shell}/attr/test-record-no-buffering |   0
> > >  .../{ =3D> shell}/attr/test-record-no-inherit   |   0
> > >  .../{ =3D> shell}/attr/test-record-no-samples   |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-period |   0
> > >  .../{ =3D> shell}/attr/test-record-pfm-period   |   0
> > >  .../tests/{ =3D> shell}/attr/test-record-raw    |   0
> > >  .../{ =3D> shell}/attr/test-record-spe-period   |   0
> > >  .../attr/test-record-spe-period-term          |   0
> > >  .../attr/test-record-spe-physical-address     |   0
> > >  .../attr/test-record-user-regs-no-sve-aarch64 |   0
> > >  .../test-record-user-regs-old-sve-aarch64     |   0
> > >  .../attr/test-record-user-regs-sve-aarch64    |   0
> > >  .../perf/tests/{ =3D> shell}/attr/test-stat-C0  |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-basic    |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-default  |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-1     |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-2     |   0
> > >  .../{ =3D> shell}/attr/test-stat-detailed-3     |   0
> > >  .../tests/{ =3D> shell}/attr/test-stat-group1   |   0
> > >  .../{ =3D> shell}/attr/test-stat-no-inherit     |   0
> > >  tools/perf/tests/{ =3D> shell/lib}/attr.py      |   0
> > >  tools/perf/tests/tests.h                      |   1 -
> > >  tools/perf/util/evsel.c                       | 122 +++++++++-
> > >  tools/perf/util/util.h                        |   7 -
> > >  57 files changed, 142 insertions(+), 237 deletions(-)
> > >  delete mode 100644 tools/perf/tests/attr.c
> > >  create mode 100755 tools/perf/tests/shell/attr.sh
> > >  rename tools/perf/tests/{ =3D> shell}/attr/README (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-record (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-record-spe (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/base-stat (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/system-wide-dummy (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-C0 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-basic (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-any (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any_call (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-any_ret (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-hv (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-ind_call (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-k (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-branch-filter=
-u (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-count (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-data (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-dummy-C0 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-freq (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default=
 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-default=
-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-dwarf (=
100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-graph-fp-aarc=
h64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group-samplin=
g (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group1 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-group2 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-buffering =
(100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-inherit (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-no-samples (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-period (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-pfm-period (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-raw (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period (1=
00%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-period-te=
rm (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-spe-physical-=
address (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-no-=
sve-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-old=
-sve-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-record-user-regs-sve=
-aarch64 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-C0 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-basic (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-default (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-1 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-2 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-detailed-3 (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-group1 (100%)
> > >  rename tools/perf/tests/{ =3D> shell}/attr/test-stat-no-inherit (100=
%)
> > >  rename tools/perf/tests/{ =3D> shell/lib}/attr.py (100%)
> > >
> > > --
> > > 2.46.1.824.gd892dcdcdd-goog
> > >

