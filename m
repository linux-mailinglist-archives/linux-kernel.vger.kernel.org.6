Return-Path: <linux-kernel+bounces-274402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201529477BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F23AB22D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6E15382C;
	Mon,  5 Aug 2024 08:55:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52727153800;
	Mon,  5 Aug 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848109; cv=none; b=F3j7NyubcJSiVhp5wArEVZ9stvKCg9f0pHcucViCQerJReCmxLiYaW3r3TZ6A1gyYDt/4tAgykvpKyy7punK+OMRqJD7OIbxmqoSaFKgMwfxOTi2SqO+lxrB7BaBkWwwlXXKyBnNshlS6OArHTvIpn7bwumk/AQMJJJV2KVG8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848109; c=relaxed/simple;
	bh=qEUzHgqrhY4W0WDTACqLQo9MWf0ZpD94wao15ztaDgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sO+7lArXmgTvpZ3YDgwY4rnQZDmZuB0I10Oc+ub/2KVUuMNgSJW8fEvmHvK5iWgS99HyXvAWyMCiznlNatlwo8//gTnt/yUx10uLP6vfK0DbwWhSJL1BeWdWpAqLno4xiOw7A7Iv5U7HtXY++SaWD1JgsVyNgQdQ5LkA+bSqoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B15D143D;
	Mon,  5 Aug 2024 01:55:31 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69ABA3F6A8;
	Mon,  5 Aug 2024 01:55:03 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v11 0/2] tools/perf: Support PERF_SAMPLE_READ with inherit
Date: Mon,  5 Aug 2024 09:54:56 +0100
Message-ID: <20240805085458.134195-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision of this change splits out the tools/perf changes requested 
by Namhyung Kim for my previous work to enable PERF_SAMPLE READ with inherit (see 
https://lore.kernel.org/linux-perf-users/20240730084417.7693-1-ben.gainey@arm.com/ ) 
as the kernel side changes have been picked up by Peter Zijlstra.

Changes since v10:
 - Fixed a formatting nit

Changes since v9:
 - Split out tools/perf patches only
 - Fixed system-wide mode in `perf record` to not set the inherit bit.

Changes since v8:
 - Rebase on v6.11-rc1

Changes since v7:
 - Rebase on v6.10-rc3
 - Respond to Peter Zijlstra's feedback:
 - Renamed nr_pending to nr_no_switch_fast and merged in nr_inherit_read
   which otherwise had overlapping use
 - Updated some of the commit messages to provide better justifications
   of usecase, behavioural changes and so on
 - Cleanup perf_event_count/_cumulative
 - Make it explicit that the sampling event decides whether or not the
   per-thread value is given in read_format for PERF_RECORD_SAMPLE and
   PERF_RECORD_READ; updated tools to account for this.

Changes since v6:
 - Rebase on v6.10-rc2
 - Make additional "perf test" tests succeed / skip based on kernel
   version as per feedback from Namhyung.

Changes since v5:
 - Rebase on v6.9
 - Cleanup feedback from Namhyung Kim

Changes since v4:
 - Rebase on v6.9-rc1
 - Removed the dependency on inherit_stat that was previously assumed
   necessary as per feedback from Namhyung Kim.
 - Fixed an incorrect use of zfree instead of free in the tools leading
   to an abort on tool shutdown.
 - Additional test coverage improvements added to perf test.
 - Cleaned up the remaining bit of irrelevant change missed between v3
   and v4.

Changes since v3:
 - Cleaned up perf test data changes incorrectly included into this
   series from elsewhere.

Changes since v2:
 - Rebase on v6.8
 - Respond to James Clarke's feedback; fixup some typos and move some
   repeated checks into a helper macro.
 - Cleaned up checkpatch lints.
 - Updated perf test; fixed evsel handling so that existing tests pass
   and added new tests to cover the new behaviour.

Changes since v1:
 - Rebase on v6.8-rc1
 - Fixed value written into sample after child exists.
 - Modified handling of switch-out so that context with these events
   take the slow path, so that the per-event/per-thread PMU state is
   correctly switched.
 - Modified perf tools to support this mode of operation.

Ben Gainey (2):
  tools/perf: Correctly calculate sample period for inherited
    SAMPLE_READ values
  tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events

 tools/lib/perf/evsel.c                        | 48 ++++++++++++++
 tools/lib/perf/include/internal/evsel.h       | 63 ++++++++++++++++++-
 tools/perf/tests/attr/README                  |  2 +
 tools/perf/tests/attr/test-record-C0          |  2 +
 tools/perf/tests/attr/test-record-dummy-C0    |  2 +-
 .../tests/attr/test-record-group-sampling     |  3 +-
 .../tests/attr/test-record-group-sampling1    | 51 +++++++++++++++
 .../tests/attr/test-record-group-sampling2    | 61 ++++++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  1 +
 ...{test-record-group2 => test-record-group3} | 10 +--
 tools/perf/util/evsel.c                       | 21 ++++++-
 tools/perf/util/evsel.h                       |  1 +
 tools/perf/util/session.c                     | 25 +++++---
 13 files changed, 271 insertions(+), 19 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
 copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)

-- 
2.45.2


