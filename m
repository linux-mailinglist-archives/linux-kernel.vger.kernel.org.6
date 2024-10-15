Return-Path: <linux-kernel+bounces-364875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1B99DA73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADEB283053
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34964B658;
	Tue, 15 Oct 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlrBSlu1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681D29B0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950526; cv=none; b=tEuiA6Wvdv8utoYav0NJrbIDvoIZjgDUbMxLwVcbmfVIllFyT1/e33EiQE+wlSl7e1W8TEkV96WNx5aNB9BCFEgbJi325Mou2uxhy910/yV0euC8eB2mrVI/77mTqxSK6bRfhptdARSlWJ3wfCGf0rwCtKW8LhyUNgf83HYYr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950526; c=relaxed/simple;
	bh=+rxryxOQHkZdgHYAqWw/VS2szzAnEupTKSmElKJsiNA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=T4rSoUX1RZBQAMkP0Ke4+Fb5Kd6EKQV1ASW4faOjvIvDNAz7vV35u/umTBPCPYf0BF1dWEcxapJqCxtZvD+SIku1jUtv+hEW4Cc8oMB7v6DYZMVswKuUDUhinKtk/x192w4VnTYUbkDuVAnnH1YqKnI9PZzVuLBX0zuDyWHKUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlrBSlu1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso40635517b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950523; x=1729555323; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpVYqTqakCwPUiKlO3zjPeSJzwD+j1X//3FbjHx6SHU=;
        b=hlrBSlu1y57MiMe1qAfFhZPi5XCjTvprPa/bMg8Rr0gVhVBhQnS1m2IOPV97p+FTB9
         P/vWM9DEhteFP4xcTBqsxHLllvTBgeqbwmkBwOmauuVPwaSHZk2Lbc2XfiFMFR5pTjZ6
         WXBMEINcBsjxK9pUiEGZdsg58EIHlU/oGb63baU3966TMIgdA6FlUA1/qu01523K/rGV
         rFZV5UBXT5lJ+9x+n4z5io+aX3+iunRXkreF38wzbHFu35BC+uR0oD8JiUmTV2wOvW4E
         2v9Dx+dP/NejOJbVKNxNhUgBytPzVLq3SzYIGut2xpOCKm/9mP1LpcGsNwMI+OMNx+1l
         aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950523; x=1729555323;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpVYqTqakCwPUiKlO3zjPeSJzwD+j1X//3FbjHx6SHU=;
        b=n+D4g7YYE8lMfVjbDXSBWADw1mWdcI5wPZyShNx7bw/W5z788UiCgpAaQ+Gvh+7iiK
         z+7sU4iJeVlircXEGX3vtKPVqGIuao6kiPmZ1QerqCN9NzG2Ltuo8Qa2GW7tbN+a3lkA
         gO8+v0NbYiQJE05I85+g/Qc/MDKL9CcLsAILUpICRyxT/3261adetGoLa9vLgbR7PMPU
         VpRas3plAgOLPIfuqrprnkChIWItEJ8Vqyrr172HrAHZzZ5CQkkjaTOjXnlB92VMLqcX
         97BZ9fn7kO8ng2NtU5XJT1L8R+JkJRrrwxTIs8Q1HbLdrshcMraAykrg4iclyg23dPFe
         5oow==
X-Forwarded-Encrypted: i=1; AJvYcCV8bl0lnRFD6xPs7HCieRVDNvF9zqCA88GvEz7te8FWyORWwi436SP7DIaflQnRO1NaDvwoyl2SUSS+x8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzMA25sApHl4GIvNLSfkzbBl4VhnzB0W1CyIaTbnmKjY6mcrC
	mYGXCVTN95p2PtnKhQ+34fdzeS1gdrRQhVBa8epQ0AldiJyUAZc+LJjUo+fsILnuC2nEpk55O+Z
	elHxnsw==
X-Google-Smtp-Source: AGHT+IFn7RW4A+NhhePaa6d8PAFoTugBI7glIea25mnv8/8OfaQ+Jv6KthT7fYH+cQj6brMY5eqzs2mw1EFl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f1f9:f6b6:68bc:5a14])
 (user=irogers job=sendgmr) by 2002:a05:690c:3588:b0:6e2:e462:e191 with SMTP
 id 00721157ae682-6e347c67c26mr3300437b3.6.1728950523426; Mon, 14 Oct 2024
 17:02:03 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:01:55 -0700
Message-Id: <20241015000158.871828-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/3] Make "Setup struct perf_event_attr" a shell test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Leo Yan <leo.yan@linux.dev>, 
	Howard Chu <howardchu95@gmail.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

The path detection for "Setup struct perf_event_attr" test is brittle
and leads to the test frequently not running. Running shell tests is
reasonably robust, so make the test a shell test. Move the test files
to reflect this.

Before, if you build perf like `make -C tools/perf O=/tmp/perf` then
run the built perf test for the "Setup struct perf_event_attr" it
skips (causing the tests to bitrot, fixes to be sent, etc.):
```
$ sudo /tmp/perf/perf test -vv perf_event_attr
capget syscall failed (No such file or directory - 2) fall back on root check
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

v2: Add __SANE_USERSPACE_TYPES__ to fix PowerPC build, Tested-by
    Athira Rajeev <atrajeev@linux.vnet.ibm.com> and Stephen Rothwell
    <sfr@canb.auug.org.au>.

Ian Rogers (3):
  perf test: Add a shell wrapper for "Setup struct perf_event_attr"
  perf test: Remove C test wrapper for attr.py
  perf test: Move attr files into shell directory where they are used

 tools/perf/Makefile.perf                      |   5 +-
 tools/perf/perf.c                             |   2 -
 tools/perf/tests/Build                        |   1 -
 tools/perf/tests/attr.c                       | 218 ------------------
 tools/perf/tests/builtin-test.c               |   1 -
 tools/perf/tests/shell/attr.sh                |  22 ++
 tools/perf/tests/{ => shell}/attr/README      |   0
 tools/perf/tests/{ => shell}/attr/base-record |   0
 .../tests/{ => shell}/attr/base-record-spe    |   0
 tools/perf/tests/{ => shell}/attr/base-stat   |   0
 .../tests/{ => shell}/attr/system-wide-dummy  |   0
 .../tests/{ => shell}/attr/test-record-C0     |   0
 .../tests/{ => shell}/attr/test-record-basic  |   0
 .../{ => shell}/attr/test-record-branch-any   |   0
 .../attr/test-record-branch-filter-any        |   0
 .../attr/test-record-branch-filter-any_call   |   0
 .../attr/test-record-branch-filter-any_ret    |   0
 .../attr/test-record-branch-filter-hv         |   0
 .../attr/test-record-branch-filter-ind_call   |   0
 .../attr/test-record-branch-filter-k          |   0
 .../attr/test-record-branch-filter-u          |   0
 .../tests/{ => shell}/attr/test-record-count  |   0
 .../tests/{ => shell}/attr/test-record-data   |   0
 .../{ => shell}/attr/test-record-dummy-C0     |   0
 .../tests/{ => shell}/attr/test-record-freq   |   0
 .../attr/test-record-graph-default            |   0
 .../attr/test-record-graph-default-aarch64    |   0
 .../{ => shell}/attr/test-record-graph-dwarf  |   0
 .../{ => shell}/attr/test-record-graph-fp     |   0
 .../attr/test-record-graph-fp-aarch64         |   0
 .../attr/test-record-group-sampling           |   0
 .../attr/test-record-group-sampling1          |   0
 .../attr/test-record-group-sampling2          |   0
 .../tests/{ => shell}/attr/test-record-group1 |   0
 .../tests/{ => shell}/attr/test-record-group2 |   0
 .../tests/{ => shell}/attr/test-record-group3 |   0
 .../{ => shell}/attr/test-record-no-buffering |   0
 .../{ => shell}/attr/test-record-no-inherit   |   0
 .../{ => shell}/attr/test-record-no-samples   |   0
 .../tests/{ => shell}/attr/test-record-period |   0
 .../{ => shell}/attr/test-record-pfm-period   |   0
 .../tests/{ => shell}/attr/test-record-raw    |   0
 .../{ => shell}/attr/test-record-spe-period   |   0
 .../attr/test-record-spe-period-term          |   0
 .../attr/test-record-spe-physical-address     |   0
 .../attr/test-record-user-regs-no-sve-aarch64 |   0
 .../test-record-user-regs-old-sve-aarch64     |   0
 .../attr/test-record-user-regs-sve-aarch64    |   0
 .../perf/tests/{ => shell}/attr/test-stat-C0  |   0
 .../tests/{ => shell}/attr/test-stat-basic    |   0
 .../tests/{ => shell}/attr/test-stat-default  |   0
 .../{ => shell}/attr/test-stat-detailed-1     |   0
 .../{ => shell}/attr/test-stat-detailed-2     |   0
 .../{ => shell}/attr/test-stat-detailed-3     |   0
 .../tests/{ => shell}/attr/test-stat-group1   |   0
 .../{ => shell}/attr/test-stat-no-inherit     |   0
 tools/perf/tests/{ => shell/lib}/attr.py      |   0
 tools/perf/util/evsel.c                       | 127 +++++++++-
 tools/perf/util/util.h                        |   7 -
 59 files changed, 147 insertions(+), 236 deletions(-)
 delete mode 100644 tools/perf/tests/attr.c
 create mode 100755 tools/perf/tests/shell/attr.sh
 rename tools/perf/tests/{ => shell}/attr/README (100%)
 rename tools/perf/tests/{ => shell}/attr/base-record (100%)
 rename tools/perf/tests/{ => shell}/attr/base-record-spe (100%)
 rename tools/perf/tests/{ => shell}/attr/base-stat (100%)
 rename tools/perf/tests/{ => shell}/attr/system-wide-dummy (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_ret (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-hv (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-ind_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-k (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-u (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-count (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-data (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-dummy-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-freq (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group3 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-buffering (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-inherit (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-samples (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-pfm-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-raw (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period-term (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-physical-address (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-no-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-old-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-default (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-2 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-3 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-no-inherit (100%)
 rename tools/perf/tests/{ => shell/lib}/attr.py (100%)

-- 
2.47.0.rc1.288.g06298d1525-goog


