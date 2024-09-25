Return-Path: <linux-kernel+bounces-339211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A30986168
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A933F1C257E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81064185082;
	Wed, 25 Sep 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJ59CkWf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B218452E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273693; cv=none; b=tFR77l1IbYVQOZonReZRUQO1xg5kpvOxAijQk3VFEVjf/0ZRuLZEiBhGRUBIt1AVTPq3IGEhGe2NimyS4qM+9uYSVLdT+PiwIrCj3eCC2McjDuw988p9jP9ugqCS0OW2UyEOYeC83NKJx5gCNGHyXTClmZWJ5cmTNhinT3HHAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273693; c=relaxed/simple;
	bh=ESR62zXXNpXavnpwJYYLUfvSmq/V+/hwaSqoyXHU6VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l1DZ9BnWxoMezB8MPh9W13zRgpiS19oiukHuyKZYNQesTHgoIGMrWyVpcYieo53yQNL5rYnzpTtzVcIG7F2qaDt7Pa2D3EF8PYuEwpaZFjUwjdSRCGnN5+3U8dEkymt7PMchmB9pcAu2xjZTly0+hRwnHP+HTJkg9l6pmnpnb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DJ59CkWf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c874f6f119so266302a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727273690; x=1727878490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sesiBu62rHetQsj28pc3tOlFDm0+dlVJOIL+Kb7A19c=;
        b=DJ59CkWfYIAevbzo8fTpq1L4wLkbSGJzVKAs6Vw8hAavtmN7Tb5LOSZQntT4/jpaQK
         GX81x7Jk5GocbpbLGcyAeRO6VpXs2i6VzSgviSZbixie5lcwwzn2Q/xxwm8rqvn60ZvK
         4dEKgcpY3oeV3J0Atlcu1cchLHMqQQoc9FqXT5o83GJwB1iXWIzssl8lXfUZhL92qIdj
         mrcOInmkFMK1n6rkHjc0kjistDtXiULOhrOhqnOmBsilBpAQzfKD4Rm0ueGYpEXjbBCU
         SkHBliMFrTuWLgewJxWYX0gn6vvzzg3VW3ONylJEFNbDjEVhMZNNMp/xfSo90LZWdbzh
         XZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727273690; x=1727878490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sesiBu62rHetQsj28pc3tOlFDm0+dlVJOIL+Kb7A19c=;
        b=OPnQ7gA4RvLpktqQ5Adl8/czBY+oqcPKdHvUO/9AMNjqNne/vzCvDXsipi8gqIE/+o
         CD+fyLuC4xnqmnCw6wgFs/4wqJ8SjJJP6ZvOG/KFR9aB8QQB/319EtOyzvApTrVEPH84
         HAGWswTgMJvWzcCcY4z9AwzzjxhpX+ZX2xTm0BErposy6fm9WCZIrEHzqqlC+pDatxwd
         kU2SVHr+pRDFMJ95qlv5+D3s0ys9nA5E/Y2MX492MxA+ExkSP+eJLJbLgmGpoIg+ggrm
         BBrD7ssoDa/MB3rjAzdX+ZrxBnRKTTAInUAjsK/VJ3I01EupaiZXjI8M5A0Cy0oVFi+l
         +KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK7YpNmkEY3Ahqv6F32vLVFuSk4lfZBQytTZgXS4lf7hQtVIIvVd9tWyIRGg9gQKWVTCekznUZzIOpgW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMHLbswXQAAQhShXuBU1JmzYFLDPE9L3CZN9AMKcltx2JmjWl
	yq596ssdCu9UP0vUTJgmvQvyuqv9nPu2m789cYANzlhbLreIIf7gUNfHFFSEmtM=
X-Google-Smtp-Source: AGHT+IHB6BzhvZDjkJhqBhSrJ8vPdz3dBWJ/QOw30aK8v7iUqTyYvGv/Z//zSYzMts4FtvL3GOGbAQ==
X-Received: by 2002:a05:6402:1ecf:b0:5c5:b646:945b with SMTP id 4fb4d7f45d1cf-5c72073c7fcmr2443326a12.22.1727273690323;
        Wed, 25 Sep 2024 07:14:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4968f4sm1888005a12.27.2024.09.25.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:14:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/7] Event parsing fixes
Date: Wed, 25 Sep 2024 15:13:38 +0100
Message-Id: <20240925141357.1033087-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I rebased this one and made some other fixes so that I could test it,
so I thought I'd repost it here in case it's helpful. I also added a
new test.

But for the testing it all looks ok.

There is one small difference where it now hides _all_ default
<not supported> events, when previously it would only hide some
selected subset of events like "stalled-cycles-frontend". I think
this is now more consistent across platforms because, for example,
Apple M only has cycles and instructions, and the rest of the
default events would always show as <not supported> there.

Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
cycles PMU) and I also faked an Apple M on Juno. 

Changes since v7:
  * Resolve conflicts and rebase onto perf-tools-next 1de5b5dcb835
  * Fix build error by using the new perf_pmu__is_fake()

Changes since v6:
  * Fix empty PMU name in perf report
  * Rebase onto perf-tools-next 003265bb6f02

Changes since v5:
  * Test on x86 non hybrid
  * Assume 1 PMU in the test when no PMUs expose /cpus file

Changes since v4:

  * Hide all <not supported> default events when not verbose
  * Remove previous note about <not supported> behavior from the cover
    letter and replace it with a new note about the new behavior
 
Changes since v3:

  * Rebase onto perf-tools-next 6236ebe07
  * Fix Intel TPEBS counting mode test
  * Fix arm-spe build
  * Add support for DT devices in stat test
  * Add a new test for hybrid perf stat default arguments

Ian Rogers (5):
  perf evsel: Add alternate_hw_config and use in evsel__match
  perf stat: Uniquify event name improvements
  perf stat: Remove evlist__add_default_attrs use strings
  perf evsel x86: Make evsel__has_perf_metrics work for legacy events
  perf evsel: Remove pmu_name

James Clark (2):
  perf test: Make stat test work on DT devices
  perf test: Add a test for default perf stat command

 tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
 tools/perf/arch/x86/util/evlist.c             |  74 +----
 tools/perf/arch/x86/util/evsel.c              |  35 ++-
 tools/perf/builtin-diff.c                     |   6 +-
 tools/perf/builtin-stat.c                     | 291 +++++++-----------
 tools/perf/tests/parse-events.c               |   2 +-
 tools/perf/tests/shell/stat.sh                |  37 ++-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
 tools/perf/util/evlist.c                      |  46 +--
 tools/perf/util/evlist.h                      |  12 -
 tools/perf/util/evsel.c                       |  28 +-
 tools/perf/util/evsel.h                       |  22 +-
 tools/perf/util/metricgroup.c                 |   4 +-
 tools/perf/util/parse-events.c                |  60 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   8 +-
 tools/perf/util/pmu.h                         |   3 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 363 insertions(+), 415 deletions(-)

-- 
2.34.1


