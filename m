Return-Path: <linux-kernel+bounces-250532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22AC92F8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD201C23029
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB997158853;
	Fri, 12 Jul 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVEvXw+z"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767B156971
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779733; cv=none; b=eVR9UldAqR8iyWkIc9CWClsl693O247C9OTw3NWtOpbODNEwO563Scvn9SSiQ7UOaMernUR1c1XuWgLLzsPdB61OxorqvVIwdRw+JTZdJuRNAdAHOYkGUgd6EfUhT6Wj+f7tYYsuAKd0n3Jy2nFVJhSGfRJuZ20+8HCG4Wb0hbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779733; c=relaxed/simple;
	bh=tmKoEeL8UKVYGBSqWtk6NdcyUjOOxhwz9p9GVPL0ENQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSix5j+rFfuDcNr25vjbRALFqxHywgp6WEpTP7+OXh4VcCzSO49yZKHSYviJdq6qHOvoARzoKX6LkXQOkQzRXWzPWXxiEuGNK9lI5taOA+F4uciXtAhgQK2g+93o6BMic/L+N1LSpYMhP8qZIRZJnyKi4vdKC05sT9+HG9ycqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PVEvXw+z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36798e62aeeso1092208f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779730; x=1721384530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALilg+KON+JtrbVeCssAiCzq42HUqO9B/Chs+vLrqzs=;
        b=PVEvXw+zaVnc+pYj1MaPh7nKpVd/CgIEtindwHhQGDY7dFmXp37glemoxlren3C5yf
         vYX2xR8SlX92uStXEhSqsm7qmew7l9WgYvNTsp9yLugiYT9lUrxXN4Q+v5s+kQ+PVJQE
         6PrM2ZjMjsamG6OWCqajQgyZJeo41S2PTsuvJQs+tj7JzC2lWLzppV1sRQrUPQMaPOQs
         EI5y98zKlNXts9kLJ3psR6eMqzFDd/RgtkttCSRhaKj+sCh9bQLtUagdFyadb65gFxiu
         l7xkQsjeXFlDfi5k53RE8f8XA1J32fqDKkzuoVnnZNlA67IV8MtPiPO7l6pKFdhFiLUy
         30Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779730; x=1721384530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALilg+KON+JtrbVeCssAiCzq42HUqO9B/Chs+vLrqzs=;
        b=h8zWeewQmgiNvckhSqdPf/55bz8wIyEbmDcDAZinrCU0RzV64QOuZOf/dzF0GG52BY
         kHrv+8lbTMkTh7TQfb1G8ZG4NVPndCeMWo5/KYrszYC82hNkXAYPQOfpalCA1zA/O5xJ
         81/WyjNlLkwC3U6aNj87TVxJeZ7QdaeI54rZQecCCODJiYMa/FYhNiAvLdV6NaI0P4fy
         Hq5eF53VwrEL+g/4pW9fwqKxfPQMDj46nMxqQsS2PxJ1RXJE30Oyp2t4yOqsgGcsAQoK
         qF5zAYrpZ0CKlBuc2w62T62WKobBsNYc3zN+R3AJXf9V6njutceM00D+oVRe0cM7Di5b
         98Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVZNuQJSmd26cnsl6U/9DmVKL4Tp5urGWCLZxWLdTy2R9OEhteRJNbElgAuPxEY+i759Uuuh1BgJYjjUjviKDKTtlJmtPX7YI3MYSOp
X-Gm-Message-State: AOJu0YxvjzuQmP8adyIFbaqpQ1aAGHVCQNGG6LriZgkOuumNaQRX651i
	her5m8dZcttkjMvthZmzFNCFwV6Gk0x0oTnYa8eMP4AqSnpkNWFD96a/Mt/tbZk=
X-Google-Smtp-Source: AGHT+IHhnXF9CHwuRRW1Jpiy/j9GF8b8bDF/GunMNf0JkzJp9Qyr/tb7ZpPS7I6atPeMGO6ojTcBXQ==
X-Received: by 2002:a05:6000:4024:b0:365:8547:90b1 with SMTP id ffacd0b85a97d-367cea9629emr8446910f8f.39.1720779730434;
        Fri, 12 Jul 2024 03:22:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@linaro.org>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 00/17] coresight: Use per-sink trace ID maps for Perf sessions
Date: Fri, 12 Jul 2024 11:20:09 +0100
Message-Id: <20240712102029.3697965-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
as long as there are fewer than that many ETMs connected to each sink.

Each sink owns its own trace ID map, and any Perf session connecting to
that sink will allocate from it, even if the sink is currently in use by
other users. This is similar to the existing behavior where the dynamic
trace IDs are constant as long as there is any concurrent Perf session
active. It's not completely optimal because slightly more IDs will be
used than necessary, but the optimal solution involves tracking the PIDs
of each session and allocating ID maps based on the session owner. This
is difficult to do with the combination of per-thread and per-cpu modes
and some scheduling issues. The complexity of this isn't likely to worth
it because even with multiple users they'd just see a difference in the
ordering of ID allocations rather than hitting any limits (unless the
hardware does have too many ETMs connected to one sink).

Per-thread mode works but only until there are any overlapping IDs, at
which point Perf will error out. Both per-thread mode and sysfs mode are
left to future changes, but both can be added on top of this initial
implementation and only sysfs mode requires further driver changes.

The HW_ID version field hasn't been bumped in order to not break Perf
which already has an error condition for other values of that field.
Instead a new minor version has been added which signifies that there
are new fields but the old fields are backwards compatible.

Changes since v4:

  * Fix compilation failure when TRACE_ID_DEBUG is set
  * Expand comment about not freeing individual trace IDs in
    free_event_data()

Changes since v3:

  * Fix issue where trace IDs were overwritten by possibly invalid ones
    by Perf in unformatted mode. Now the HW_IDs are also used for
    unformatted mode unless the kernel didn't emit any.
  * Add a commit to check the OpenCSD version.
  * Add a commit to not save invalid IDs in the Perf header.
  * Replace cs_etm_queue's formatted and formatted_set members with a
    single enum which is easier to use.
  * Drop CORESIGHT_TRACE_ID_UNUSED_FLAG as it's no longer needed.
  * Add a commit to print the queue number in the raw dump.
  * Don't assert on the number of unformatted decoders if decoders == 0.


Changes since v2:

  * Rebase on coresight-next 6.10-rc2 (b9b25c8496).
  * Fix double free of csdev if device registration fails.
  * Fix leak of coresight_trace_id_perf_start() if trace ID allocation
    fails.
  * Don't resend HW_ID for sink changes in per-thread mode. The existing
    CPU field on AUX records can be used to track this instead.
  * Tidy function doc for coresight_trace_id_release_all()
  * Drop first two commits now that they are in coresight-next
  * Add a commit to make the trace ID spinlock local to the map

Changes since V1:

 * Rename coresight_device.perf_id_map to perf_sink_id_map.
 * Instead of outputting a HW_ID for each reachable ETM, output
   the sink ID and continue to output only the HW_ID once for
   each mapping.
 * Keep the first two Perf patches so that it applies cleanly
   on coresight-next, although they have been applied on perf-tools-next
 * Add new *_map() functions to the trace ID public API instead of
   modifying existing ones.
 * Collapse "coresight: Pass trace ID map into source enable" into
   "coresight: Use per-sink trace ID maps for Perf sessions" because the
   first commit relied on the default map being accessible which is no
   longer necessary due to the previous bullet point.

James Clark (17):
  perf: cs-etm: Create decoders after both AUX and HW_ID search passes
  perf: cs-etm: Allocate queues for all CPUs
  perf: cs-etm: Move traceid_list to each queue
  perf: cs-etm: Create decoders based on the trace ID mappings
  perf: cs-etm: Only save valid trace IDs into files
  perf: cs-etm: Support version 0.1 of HW_ID packets
  perf: cs-etm: Print queue number in raw trace dump
  perf: cs-etm: Add runtime version check for OpenCSD
  coresight: Remove unused ETM Perf stubs
  coresight: Clarify comments around the PID of the sink owner
  coresight: Move struct coresight_trace_id_map to common header
  coresight: Expose map arguments in trace ID API
  coresight: Make CPU id map a property of a trace ID map
  coresight: Use per-sink trace ID maps for Perf sessions
  coresight: Remove pending trace ID release mechanism
  coresight: Emit sink ID in the HW_ID packets
  coresight: Make trace ID map spinlock local to the map

 drivers/hwtracing/coresight/coresight-core.c  |  37 +-
 drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  43 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |  18 -
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          |   9 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 138 ++--
 .../hwtracing/coresight/coresight-trace-id.h  |  70 +-
 include/linux/coresight-pmu.h                 |  17 +-
 include/linux/coresight.h                     |  21 +-
 tools/build/feature/test-libopencsd.c         |   4 +-
 tools/include/linux/coresight-pmu.h           |  17 +-
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  11 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  49 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   3 +-
 .../util/cs-etm-decoder/cs-etm-min-version.h  |  13 +
 tools/perf/util/cs-etm.c                      | 625 +++++++++++-------
 tools/perf/util/cs-etm.h                      |  12 +-
 25 files changed, 645 insertions(+), 476 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h

-- 
2.34.1


