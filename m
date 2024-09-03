Return-Path: <linux-kernel+bounces-312696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CAD969A02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5911C230FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898561AD260;
	Tue,  3 Sep 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnxnQcQx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261B19F435
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358828; cv=none; b=VF2eSaHcl9EvQifL9+gPt1pcN9oRvQd20BSSafdQawujjOg9htN+GISLUd1a7fEAadgrAyji47D43ln+YcEf3QQX9mnYCnuMIYDSwKh6n9gq/4gnROQ5BY73vvujHJH3o7TE5/IOPoISxUO9ciNGXsfE94iBtt/re9V19U+YTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358828; c=relaxed/simple;
	bh=BPeL2yxwaX+v/9HQukw21j++tqBN5rJHE71dumN/Dc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=syH4DRymnpWMpgBTsLg6yQeMJO/rXs3EB4LKBJTrSChiMmvRmnUbOuD6ltItBlBc376zqmgBFr/HhvPMdFfa3p34XeHzi4115Qo/ZW0hPGFSPbQblH5Vaoa2JXm+mOQrsJFShA11TKj/3Glb6XJjTHnGUf0P7wRh51vDUSM7zBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnxnQcQx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso25292075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725358825; x=1725963625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7MCvZ5Fhe/+eOHMrrRYarXfsg8B1NR75imdENvlnHc=;
        b=hnxnQcQxTsromoIW3Zt2fzalFtaiGBkQ4zfPnqvlWSv/6TLL8ocmrzWDoR3Gldz8IZ
         mjycAOxPeL5vN6HppL8a/pY7p1EOtdoCn0cxuzoR5G+tFt4N74oTIPG51f7GZE8Ok7BL
         94gLFyuog058znDvrMTnRO3SSiVpQgxKPqefWrefaseOu4XkROm9uX3vhQvh6U+ZLqjw
         dj7n21Icn4j1s6wlOZxDyeI/iF5BQeeJNg6Fvb7PJI7xrqmEsg2KyHbJKewV72HaIs6Y
         VHVxGCb6OYf87RS4NXVSRiRDwNurtKrg8o9dr69lDfIDhCARuu+xDKFVxiIy//vFXEM6
         hnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725358825; x=1725963625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7MCvZ5Fhe/+eOHMrrRYarXfsg8B1NR75imdENvlnHc=;
        b=sGp2pKS45dStJ0iesh0eJV6e+ZVxdLJt0zCITuH4WOAuu3ET/mHpab2hVZiIOxAXtL
         AZdRaZcAmXvQeLQeRsqDEkDJP0W3bdNPYCFRpH20pCAHipgQmWMGhSlBoxomP+eLv6ua
         lkpkGkOQ6t1VceFfxnl7aImRMlsXHg7FZOwYyiHFvEg4DUye2aRMMEuBtl5v1x4DBl34
         PYLsMJo7kuYv4jfR158eniTJSBdQNnpIAozB4mJak4L2NPZXNNzagPFb1KzjwwnJ6GZc
         3e6TwaGKQ5FSpfx5fA4/ylC9GdjBbt5+Uc7a1A7Jt7mceP/yxLYFXkSjEY8A4RABwjqF
         YNIg==
X-Forwarded-Encrypted: i=1; AJvYcCVvM+1g1BAzVEHccirjuAqzSVOfeQ81ESh5oXHkmMIZqPO5Kq3Xs0juscAxQl9K7EUvMk4N+z8i0CZrgWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQl/XVd8Y5XHURP0+/nQtWyLw0eBNJmy7qYxZWjAO2AcGLo7zC
	lpyl/T7a1K0w6+PCzMo9Qrh2WLpyqZ3R0a5l+p5L9ZVQfRpnICu+HAHnRvhhJa0=
X-Google-Smtp-Source: AGHT+IGIRhFxfgT+AnDIMCr5Idq+CDt+OTG+ytIxS7mv+w/WEHRzrznSX+8/1l2ZXSAi8FDJzWB3iQ==
X-Received: by 2002:a05:600c:1914:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42bb4c4cbefmr100018935e9.6.1725358824235;
        Tue, 03 Sep 2024 03:20:24 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm168739995e9.37.2024.09.03.03.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:20:23 -0700 (PDT)
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
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] Event parsing fixes
Date: Tue,  3 Sep 2024 11:19:44 +0100
Message-Id: <20240903102005.78049-1-james.clark@linaro.org>
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
 tools/perf/util/parse-events.c                |  58 ++--
 tools/perf/util/parse-events.h                |   8 +-
 tools/perf/util/parse-events.y                |   2 +-
 tools/perf/util/pmu.c                         |   6 +-
 tools/perf/util/pmu.h                         |   2 +-
 tools/perf/util/stat-display.c                | 109 +++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 360 insertions(+), 413 deletions(-)

-- 
2.34.1


