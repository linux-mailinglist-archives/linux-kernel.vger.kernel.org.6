Return-Path: <linux-kernel+bounces-346404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900998C45C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC181C21B40
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A531CC14C;
	Tue,  1 Oct 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cg9UGy0I"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F71CB506
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803196; cv=none; b=UqIgghviFTjRpRMRILoDHTdqYkmurNZDi7DIaB+QTUYhZEi6azV32SIpSFWqMAavQNBfknySJZsv6TWh90EGzk3LGXdQlnxNTqBSU4mLVEUTwjk6p3ZQBzByJWRUg87vemr1Q7rtV2H0hzGK53WBhptWJndFJSCsX3FYCJySIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803196; c=relaxed/simple;
	bh=NxnoZ6/tzzbtpHrkvR2DVgKfOvOcRCt1P8/v5tpRuw4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Vaj+IXMjFUlUwoY8rrGFYVdEoZd0eYY70rEA22jli+7r61cBU3u3R0R++gwT0EOsf9+fmezRni6Cqpi0+s51pTJqLH1ZuOskMKhcdLUP5Rq8hrIToDv2UewfhqFk+bDdvK1fVvnhRpH0A+rDenwirxbEIc4qkJgQtUJA4mXnCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cg9UGy0I; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so101561547b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727803194; x=1728407994; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3Ziz/2RSKrrTFkDhDmouG4rotcQQY/mI+IqSuPhRUw=;
        b=cg9UGy0ITQ/Bzed8msBRtmDptSl+lB6hMvPMc/BcHXlK1BPKEp6uaQfMPPRamD5tXy
         xsp3w38WE/VA8CMk3QAw+flWrt8jaPGvrOqH1J3XI9172VQXAibnAE2EV3wJrGuwQ5PA
         4tHWREPfvTViCS0zAZWYUkbwP2UdB7rcToUDcIzIWSaWxB5SsPwahFIBXDOzKjZENnyD
         h3EJxJ7jHmsGqBidrJxqxTUEjrIQW0UwB9S/3CCLo9U5J8LCtwRNDpjIUFRZSZvWyI1C
         aTWqzGYcCx2WyLnlnZHQHb64ggCecb3i8+yOydW2mQ+i7u3D/fbUoWhPeUp81eR6GCtF
         GNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803194; x=1728407994;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3Ziz/2RSKrrTFkDhDmouG4rotcQQY/mI+IqSuPhRUw=;
        b=EEPfY8JoQViHAi4uY/MKmGEtjn5g/Qdwwu5ATSkE4eBsHzpzZ7LvO1uBqJOj0kfMUZ
         wa/L296lNy9au7UGQhUYDUekLg8p644SNqecqyGY5kOGOyETKeNQGz7GOqW1FmovgxYx
         +FCFisjsB+58GNVUSCG6S5wx2wVyasROIKwbLujOw2+OOw7k4o/zTBy7Sfx60EsQ0Xsu
         KeRHb63M/yyz+4xokbYliy/biGvNLDyesaIX/laSXwVF30LG/5NwvZXn6nb4B5ShKNrn
         VIAFCe/vSiN7RGvDoE1aQIgNNZf5T2lIaq4DrvPsRH+w+sYsCRHKaeeSEfQjm0xflycP
         IyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ULW4tDSov9X+6c+uDj/WUnYIqVfSNGMZ57JRCrkMx5+aP/5oDBI3q+9I4cdtnaaR9KvGFCUiUsAcwiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCt1/dHftYDBllV6FblOy/ZM+JM84NlvykAvIFuxu+uzV9NaH
	oTEtd8xa9dXY9pcJjpKfQJmi5OIqVaCiElC0sjlfCWVRP+ru8ez5f2aYgsXYN+vwq8AVeRkCun1
	2vhrP6g==
X-Google-Smtp-Source: AGHT+IHYOoRamD+RbhC4PKf9bHZ3wgWnoJWplCym1eBmcwC6TCmUSmJIgI1ymrQTzVVvBznnZpF9c0jt+4F9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a25:d804:0:b0:e0b:f69b:da30 with SMTP id
 3f1490d57ef6-e263842ea85mr1888276.9.1727803194291; Tue, 01 Oct 2024 10:19:54
 -0700 (PDT)
Date: Tue,  1 Oct 2024 10:19:47 -0700
Message-Id: <20241001171950.233723-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The path detection for "Setup struct perf_event_attr" test is brittle
and leads to the test frequently not running. Running shell tests is
reasonably robust, so make the test a shell test. Move the test files
to reflect this.

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
 .../tests/{ => shell}/attr/test-record-group1 |   0
 .../tests/{ => shell}/attr/test-record-group2 |   0
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
 tools/perf/tests/tests.h                      |   1 -
 tools/perf/util/evsel.c                       | 122 +++++++++-
 tools/perf/util/util.h                        |   7 -
 57 files changed, 142 insertions(+), 237 deletions(-)
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
 rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
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
2.46.1.824.gd892dcdcdd-goog


