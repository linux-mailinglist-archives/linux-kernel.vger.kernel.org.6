Return-Path: <linux-kernel+bounces-368531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C729A10FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBAFB23487
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72D212F19;
	Wed, 16 Oct 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l61d1Rok"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FD20F5CB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101236; cv=none; b=ApVYaQ3R5Y2jgou3KdpLyOarZCrysgy1s47/ruw3MYAq9Kgrm3dRbTNMqlvytX6bMt9KEvP33NpI29Mp7c58saOb5RZ/lB+ZPoXEcBi58pvpwSjLVbKQbmmsnwSOpH1THw1t4t9fwvD5UcuuSK2zYaZSfuLnQ7/kdAHrbgZLW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101236; c=relaxed/simple;
	bh=mP0BhnZ65iq/HPsodGMtdMZDWlvRAEv+gP/8nZS4TqA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GHTkQxO3tPFV5OuQbQ6SlRX8xQJibsFqulKduXKlBfSKksggX/afbU1HTgHQHq1/WyxnuTiaCNwReyPLEfgzZJriwSeMtuGBOGHk+MbAtXMjpEdbP2L3CECAFfs/YluMjYtnCML0oUHtwdryjTKvv0dUU/AUfTnthW7EHBqyKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l61d1Rok; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e321d26b38so2946777b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101234; x=1729706034; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5I0yUocVSQTWgBj4GshX19jDkqItRp7W7iPjc0QjQU=;
        b=l61d1RokaQ0vtetkjWeJlKpm747FKCcmUaxvS136ExETWg2A2T8H8QQqnxq9tc+jiW
         Avw77VWU+KJR52lUn7A9EdLfr47BrCcaZCsiaQLRD0fZEzT3nsH0Zjw0GbpORjcBOLm/
         oSoixjzJipL0AzAoXK/MuoBcmlzReMASGx2msFiXyNlQfB59ffL1UaVwizVdZRxbNyCI
         oI9pz8ZWadAKmeWCwm5w92T209Qeq9B0iMms7a5JJrL4ZK/C721uwxzWXFBRKYxyqvan
         Rm4mncQtL78Og1tM/yKwgmTLWYmetgTANqXkMiqFoV5AB0mRYUDKDni2kD3mvHKCaWIu
         XlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101234; x=1729706034;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5I0yUocVSQTWgBj4GshX19jDkqItRp7W7iPjc0QjQU=;
        b=Bq538FEyxSPbWTiPjL0ZPXbItfoRF9fctVv4yPA2i2dB5mD6FkzRYwywGsjq2kQKck
         2URZ5PKTdDqF70FBriPHHh4h7ICmq+VrgtAt+rMCT8rlGsxcX/X832Yi88GQPz32gn9g
         V/nnuVYgRh9pssS0d8u2ABIlcnNJq21NcE6xr0QMKtFH6vs0lfjueyZjSeZFH2G69Ib2
         y4D1qu7MUvnAJ0HjvpnffMBd5J5i0DUgUypBUqREb2IcN6LUjddTUD7oPSs7ZYPhUNdl
         MNfal5XY8XcmfhHEJEUfYVEhtMp3JZbtU56rq3yb1dLmmF1tTe94Bvzf5w8pWOrQMarf
         Ollw==
X-Forwarded-Encrypted: i=1; AJvYcCWrPpwyWiFAhDwWtTaWv2/uVYz7wC5yC/sWC6BsMZH3QfwZqB7h58bikLlxRi4SbSPhsKvvM2Sa5JzPxzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQiZN7tlDoU/A9l568MLFEG8ETuXzXL5Msv4rQXh11j/eSUEg
	jMJHOpQtnV1YjzXxDPjUh7ECFlRbMkcvPWpkUMEKsnuRXKqCnkNLApjnbGgw3ntXzdHJT4oW3Lf
	LbrNpyA==
X-Google-Smtp-Source: AGHT+IF3zEWmhP0cidIac12WVyWKmGawNc5qt6VMMctNUjn+AavEI1j465jZIrXEmXEqPtiEYp+XrzoIDHfI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a5b:d0a:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e2978571bf3mr2700276.8.1729101233559; Wed, 16 Oct 2024 10:53:53
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:42 -0700
Message-Id: <20241016175350.116227-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants in a CSV column or json
dictionary value.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

v3. Rebase.
v2. Don't display metric-value for json output if there is no unit.

Ian Rogers (8):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Display metric threshold value in CSV output
  perf stat: Add metric-threshold to json output
  perf stat: Disable metric thresholds for CSV/JSON metric-only mode

 tools/perf/Documentation/perf-stat.txt        |   1 +
 tools/perf/arch/x86/util/iostat.c             |   2 +-
 tools/perf/builtin-sched.c                    |   2 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-stat.c                     |   8 ++
 tools/perf/builtin-trace.c                    |   2 +-
 .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/color.h                       |   9 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   6 +-
 tools/perf/util/stat-display.c                |  85 +++++++++---
 tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
 tools/perf/util/stat.h                        |  16 ++-
 17 files changed, 191 insertions(+), 111 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


