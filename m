Return-Path: <linux-kernel+bounces-305119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5104A9629CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A2D282B67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE218952B;
	Wed, 28 Aug 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZaZQ4CT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955F16B386
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854084; cv=none; b=WYWDA1byWCa7gU7vlareLcsTCw/3wSYeN0l8s/+oL7fchRm6AsV4SonfH5cAQvNPzqf/RhB5GgiNSO5783dyyN8HOJdpTBhbG288FJojQH2Ivr2YgBoUZTuQjwmbsR9+nJ1qVFm48/SXEvaHoOx4OREadB9f2iOvlyUBtAeV/cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854084; c=relaxed/simple;
	bh=4xE/vzrw3jJwfmxRQTphStFe7kpYvfTa09+FdtD4X0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j2Irxkyog13TErM2YG1LUn9GmZ+jUjEV9CUz4h8a1fVi5Z8LcvCcnlcoR4lpyjBLgijpPfbIrndYuQqLycbTNFaS7mvsi1uYa4C9IuyIQlOUmhVqcErp34JlFRJRa8d07FfW0DXlrRATyE+QgLeQCbrqwfEL4MSPnudI4pts7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZaZQ4CT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e9db75b9so236223066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724854080; x=1725458880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aAwIVJgVIh1Hv8hW6DlJQ9xqCzcxOReEhk3tFKI30U=;
        b=yZaZQ4CTACX1VlFrjY6HMvytN0DdXUUgzz2/HtKCuDmiuP3DXn0mvw8N4hby1ii6iS
         8I2VDKYwvevKuJrybcG06V62TlRI+9jgG0maFuqImWk6fu9FVaUXdyFfzmXj1Q22iRLA
         B5BP6nL/Or9e1c88GgRWwRkaN8SuLx3mEdtNZAfOtQS7V2/FL195TXGUr0l1XMcc4YAQ
         3KdRLyRgL4DOOjJ+wWZYGPP4UQ8JGDO2QenjQiBW61pVyOIbfbMgnIgSOrFXFbyRC8Xq
         wKctHG5kmirJgPlq+s/FGKzjkXI1+FJL7Pw8OY5emyLGAcdFPaJA/U1ELQ7Nhw3XOw7e
         n1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854080; x=1725458880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aAwIVJgVIh1Hv8hW6DlJQ9xqCzcxOReEhk3tFKI30U=;
        b=TZDVbHr5MzVe7BujU7m4GAEzCXDdnizP9ETIB8MaBxWftDyJsVRd4rCBu7HZF5kkrs
         qaexOzCA6UHkdADP6bISW1kD1Claj549DsbjX6wh7gnQ4WaEVlDtB9GSAKzx7WnSXgaV
         0IhWkekjLhFr7YZ62NzTrARbZjHjvGVdEBpFXr9632+CAcd4lRIuaDP1VhSaMdCX5mR/
         /tiyfQrXTaXjuo8kRxO2GG7Fj4FAV+tcpNd0SYls3GyTiCvxuRdDUjvzOuqBMKX1nJBo
         lZbuiyjWuWPuLMZ2T939mcZThC4S3aT8WV1b0avfzAlE//T6drqHi2cl6itsB6+riQeh
         VNzw==
X-Forwarded-Encrypted: i=1; AJvYcCVMEdAcp+It0RRSCua58GndKwaPqm9+nZqAltgoRbrpQlM2ktHgLeHbP42Mr5U8k+X+tjw72RkKLMuV/YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfsIhJYNENJUkTK5o5pG5OevnA5Xzg9PX2+Fp/n7FrPdZq/2WH
	TZa46qBngfC5SvyX6z4K2Y4sBPFReE9ohZko6axJYYRqJJQn3pXOdZERxhsvGP0=
X-Google-Smtp-Source: AGHT+IEoC5n0vdz3tJYOdnNb4XTomlnmxEipp/sr7m19JHJooP7z4Rm7SltooV8l5QLlj4Ott0pVNQ==
X-Received: by 2002:a17:907:1b1e:b0:a86:e9ab:f6c6 with SMTP id a640c23a62f3a-a86e9abfe01mr432673066b.68.1724854079782;
        Wed, 28 Aug 2024 07:07:59 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5832855sm251302666b.130.2024.08.28.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:07:59 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Event parsing fixes
Date: Wed, 28 Aug 2024 15:07:14 +0100
Message-Id: <20240828140736.156703-1-james.clark@linaro.org>
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

There is one small difference where it now hides _all_ <not supported>
events, when previously it would only hide some selected subset of
events like "stalled-cycles-frontend". I think this is now more
consistent across platforms because, for example, Apple M only has
cycles and instructions, and the rest of the default events would
always show as <not supported> there.

Tested on Raptor Lake, Juno, N1, Ampere (with the DSU cycles PMU) and
I also faked an Apple M on Juno. 

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
 tools/perf/tests/shell/stat.sh                |  33 +-
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
 21 files changed, 356 insertions(+), 413 deletions(-)

-- 
2.34.1


