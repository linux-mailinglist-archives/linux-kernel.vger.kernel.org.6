Return-Path: <linux-kernel+bounces-358088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577D997A18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458D21C21A10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BC11712;
	Thu, 10 Oct 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3nf6voTD"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6B8837
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523300; cv=none; b=WupWzZxj8f4zK7/e1Fi+yW5Ou9JxpZZ3Ifp9EE87NiVwYuxSMH5jrfvRBqk0KRIPH1ecdFTThJ4oI0VDgLjzcwoYJhkrate2SWCASidKe99ugNUcYOFr416s/oQNBelhZH9lgz5Mrpu5FnjqlXnO6AX09IUKWP7BOCde2JO5J7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523300; c=relaxed/simple;
	bh=t7+Xm23rFntNT72tJU+PBupmwVOBnjMLS0/HU1OJPLY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=D0cJpYS2xvlkfrU2wG9VUUUHWQ3ErEwGh3gNpkIiD9YTu3TGvONfIyDAWEMcZnC44BeJ5PSY1z3BDUjY6BulRmbKsSYo9SRs6qe7Ldtdi27XCd5S2KilDprcUmH1p4sH6UjQD+wPO13E4YpJRmWsOI5QtZkViWXVwZtBa18SHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3nf6voTD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2d287f944so10814127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 18:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523298; x=1729128098; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4EsSfgvjieiysBAaZRmDwmuXhJUeXONObNB3pTJ5ow=;
        b=3nf6voTDYiUqfFtbM0kC2c8u8FUONokLvGmEGEBmXV4656MGFp6phnCYu+1UXQI5M5
         ZoHAYYUMDxKhoOCq4I3u4IzX12pWMA+5+rfq7SXjKI38SrmS1EK7dylfnLmFs5+/ilqL
         liu9w/8d7hGfjmaAsV82TzfSyR+0sN7SkWoOurfx2VI2ca74h9G3wTheSsujeFIMcHXh
         RyIs1B7aBqCGUTLgD891uX4G/S28PPyAVRPbHAHkC+yv/mTFLoEIkQxa2uHbAn1eZk3e
         IkQToHpUtmoi25zeBuHniU4puIUmW8uwWMLrDRwpaqCo3rOvY3vO0HPgKD9vK0VTkTr5
         Nj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523298; x=1729128098;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4EsSfgvjieiysBAaZRmDwmuXhJUeXONObNB3pTJ5ow=;
        b=MdavVNvdtdTgL2IFCmVSYO1P4RrbQg/RWUJAYiGjiwn/gmqDdJOnftXvozBerFKS7+
         Uhj+aJxr2cR5PMb9Bg8dJCpR5uasqKM+hR7FN/5dLMOOc5VIQgEbiLlawWFpWKvSd/yQ
         uC387ekRLV9cy59U+qGXbE8IyV+TIjClDVl5VQ4NMwF++zEqrh0cE8PCgHssO/w0dMKy
         lgBcoXVLHBeyUyMqMnp+c08XeziKnNnZ/20XMAqtI7B7faLU/3nAYtWoC2tr2ZqhjdAO
         J5mebubXDNUYHRUTH0rnbUT51Tl57KXei7oU6jkgO1K8dbOJ2sAmWtjn+Oo+qEYXtiot
         6IMg==
X-Forwarded-Encrypted: i=1; AJvYcCU30FuWQLoI0lxqeO97pJq6h9ObqtV2iY6cnutzlsMFgEY09gRlD/6KJKNBQg/pGp29wBFH3tVdFLPd8p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+5OnQ1LSkh22ZZR9ANdFLNu3J6ty6glZ6/EB0xovUt5bE7Tr
	/ix21SGTfeXhL7OyCrRlayAFKULI1rCBvah5iiiSMFxjkj7nhFlcui2FURUgosGcS1QDUiZuRJb
	MEoOWNw==
X-Google-Smtp-Source: AGHT+IGD/HNw5pjcSUi+MRAd6uz661d5qjMFSjFtSyfUyURc5nnXQbawJ032cuCC4+gdDmJUtcghlm5nssP/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:d817:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e28fe379330mr75895276.5.1728523297988; Wed, 09 Oct 2024 18:21:37
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:26 -0700
Message-Id: <20241010012135.1272535-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/8] CSV/JSON metric thresholds, fix printf modifiers
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

Resend. The first send cut-off patches 7 and 8. Sorry.

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants in a CSV column or json
dictionary value.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

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
2.47.0.rc1.288.g06298d1525-goog


