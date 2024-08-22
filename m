Return-Path: <linux-kernel+bounces-297345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0695B68B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F050E2867A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B971CBE97;
	Thu, 22 Aug 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjwSVER/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2581CB31A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333154; cv=none; b=S3GB78dOKq9kHDgqcSTkWIH0ULQDb9a7zzcEubLP50H/Al4k1JqEO1B4Pma46v18sxH31kS5qOPnHKMCKMFNLAURJ4JGk2Enjw8bsvs1YT6cOyM+YC4AQ1F8IM4q1HRD2ZjUfftugsIo5A2/AbEVolyedVoiWVKTalK27ShBRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333154; c=relaxed/simple;
	bh=ErJ3PXGv/skF9b50GYcuQcl//6t7+z/FuUHZeNIH9N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OhgIv+h2jUhumpupIQucsZfL3WtTG9wXk9zj8+3DFMAeJWg/ArF7KtLuLVCaOGqdcJnoNuqmuSpEKyG6/AuawpMHh5Q/6A0mvIiln9nx39Ipj5d50oJt9tVwXCEQjloV7RPXRyUp2zXoGf8jNmM5/8UEfOri7oXWMUB4Tr5AMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjwSVER/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53346132365so1049828e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724333151; x=1724937951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVYh6l0wdwh6RU0hHASQqUlGh5BLnQN3l8zIGGlWmvE=;
        b=CjwSVER/pzzq6H9y6EAjW1GlEpwYks4Zg4Y58nMtJAeNX/gYdH7QrdYpo8fMeiLiP3
         LkKIdcd1r1bld9jzx26wzR7wV+agLQ1CNilK/4ZfXr28GYj9zleMkyXsz8MEa4rHh9+2
         OXihoX4q5NbNtCvU0hIOIufxIbKomASDbnJ5sy43vp8jlxt87w0yG3sLWqfBKFdx9Bwn
         axgtolYOvk2+dnq0HD5WoBR+ZE8kts9bUOMNhh2BDrnkKiTsOozqUvSe4/V8qbPzNuSD
         c1wja46MWOPwd6B3tEd0E9kL3PWn8llLQa/4Ju/I2Z6HQoA9L2yL4Xe/AY/AehpuwMr/
         /m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333151; x=1724937951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVYh6l0wdwh6RU0hHASQqUlGh5BLnQN3l8zIGGlWmvE=;
        b=pMPeuh/6pgRH6kZtyU6ZOzQF/Ut5Pbt2fNQOiuQHbZrU4luJTYNqvz9W6fIKrhUhrT
         tI5AQarnRmXdrkaM1wyEQkpxS7K0tNL/Oh3pGH2txgioAGd+RjZZ67yKWrfEJtpCBo7+
         9W1PrHkj7SCmWE1T/Xq8U1MeZUN9AeqB1GBoTx0/BanuWfqd0hAqstgWSoeBU9afF41J
         OnNAy0iWaKYpuPOMUEule4ZaxkIE6dyA1Qxrqx1AguPOT4+MIkS8QaOND4TKKnASWE9H
         rzzNKXXK/5Z4rkqtUQ1kItOwBCCGWCC1BguxNYIYaLwlQ1H3r+kGztovYJvyylMjWQS+
         rVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFZ8/+veQvXQY199OOrRIf3psyWwY+ASnvq+OaAjPCkxA1FmH190iQFO4q5pvVYOw9s/rYfmkEMazludI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc43AVX/J1eNMaLTQQefYzXGSF7kXF11sXwozBmAdjlAji5qRb
	Doj6CCciB6ULCJKl2IaNR3MoNNoRgy2AM0AB4mkMoAxuOOm9Osh1u6QieFemqmc=
X-Google-Smtp-Source: AGHT+IH2Hd5EohQNNHspV0Khzu+ugfgzCqg56GLkuDMisgMowNXBzMTMw7aZSsvqqFnpdN2jHChd0Q==
X-Received: by 2002:a05:6512:a90:b0:533:e83:c414 with SMTP id 2adb3069b0e04-533486085e4mr3547532e87.59.1724333150265;
        Thu, 22 Aug 2024 06:25:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4365a9sm119497766b.125.2024.08.22.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:25:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Event parsing fixes
Date: Thu, 22 Aug 2024 14:24:44 +0100
Message-Id: <20240822132506.1468090-1-james.clark@linaro.org>
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

There is one small difference where it now shows "stalled-cycles-..."
as <not supported> events, when before it just didn't show them at all when
they weren't supported:

  $ perf stat -- true

  Performance counter stats for 'true':

              0.66 msec task-clock                       #    0.384 CPUs utilized             
                 0      context-switches                 #    0.000 /sec                      
                 0      cpu-migrations                   #    0.000 /sec                      
                52      page-faults                      #   78.999 K/sec                     
     <not counted>      cpu_atom/instructions/                                                  (0.00%)
           978,399      cpu_core/instructions/           #    1.02  insn per cycle            
     <not counted>      cpu_atom/cycles/                                                        (0.00%)
           959,722      cpu_core/cycles/                 #    1.458 GHz                       
   <not supported>      cpu_atom/stalled-cycles-frontend/                                      
   <not supported>      cpu_core/stalled-cycles-frontend/                                      

I don't think that's a big deal though and could probably be fixed up
later if we really want to.

Tested on Raptor Lake, Juno, N1, Ampere (with the DSU cycles PMU) and
I also faked an Apple M on Juno. 

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
 tools/perf/util/stat-display.c                | 101 ++++--
 tools/perf/util/stat-shadow.c                 |  14 +-
 tools/perf/util/stat.c                        |   2 +-
 21 files changed, 348 insertions(+), 413 deletions(-)

-- 
2.34.1


