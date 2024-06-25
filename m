Return-Path: <linux-kernel+bounces-228937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE3E9168DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FF7284ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381DB15EFC8;
	Tue, 25 Jun 2024 13:32:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560A14F9E0;
	Tue, 25 Jun 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322334; cv=none; b=iNamAtYybMwFLX80PujIdzTC5MOyBa3aA3fqFXNknB37iqxH6nDPsZ+373Fz2lx5QLwwb+LExWveC79Gvi77hMf9PmNucAnCi2rDp9CMUPnQFIb8bYWxHMHCT5SlZWlAMAIptx84NLLNhJJIMX5RTX2ZH9pycCqMOGZ1irOayRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322334; c=relaxed/simple;
	bh=8u1Yyn8Ivy3533Lcg5+kHKeSUfm2OL9UIzbXQEAX55U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IZNZhPPA9bhwQExHjyNYubHxb5rzlYbGqKVTVsRclAn5U1m+J3FTFY/rf9Amskc/XMAStizQwsqrd+CGYcwUgyAFLBckS+Sy8Wo98NrWx5Lau+Kq23FSM8MCgHM9yctsJ2LlQrMXbwfEAGzhiUBFutHyw1Q27E5SNme4/MXJdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23728DA7;
	Tue, 25 Jun 2024 06:32:36 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB16F3F73B;
	Tue, 25 Jun 2024 06:32:07 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com,
	jszu@nvidia.com,
	bwicaksono@nvidia.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v4 00/17] coresight: Use per-sink trace ID maps for Perf sessions
Date: Tue, 25 Jun 2024 14:30:43 +0100
Message-Id: <20240625133105.671245-1-james.clark@arm.com>
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
 .../hwtracing/coresight/coresight-etm-perf.c  |  36 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |  18 -
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          |   9 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
 drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 133 ++--
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
 25 files changed, 636 insertions(+), 473 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-min-version.h

-- 
2.34.1


