Return-Path: <linux-kernel+bounces-276859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FB949949
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AB21F228C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772F15688F;
	Tue,  6 Aug 2024 20:41:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62513A26F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976909; cv=none; b=Aa/VI/qz5b0jDFHQp5ya2zukDlLOnskhdyJ6JMlb8f+W0y9t+2TOX76NCJRKiL01ahVhjBNY4taQ2+PisBlfCgzHKXU/adQKbFLKIH/Svt0DRXFqwPPdt74dLjYToCgZWP8nvrNuaHqBI8oc/7um3Y8hZJAPq+fE+UfWtXs5GeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976909; c=relaxed/simple;
	bh=I2vTxt6IOCOAC4fph0B1fVWZt1m79QmAErY74lvAWkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDaSkbRO2932Je7MrHm4tBpU35ASwLRBHcBNhauSBPfSJAe0FbkxlkYymSpOR20FvLLp+0Xa5KlCMY8B0mJjvajbTZRg49dLtrtLlYXjszK2ovWTPsqBW88kQX6FbxFILy2pUESjQvM5+AyaKP+W/1cbprqSVhroe/xUcYf4Rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559BFFEC;
	Tue,  6 Aug 2024 13:42:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E983F766;
	Tue,  6 Aug 2024 13:41:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/9] perf auxtrace: Refactor with evsel__is_aux_event()
Date: Tue,  6 Aug 2024 21:41:21 +0100
Message-Id: <20240806204130.720977-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the evsel__is_aux_event() function can be used to detect AUX event,
it is not necessary for every AUX module to maintain a 'pmu_type' field
and compare it for detecting AUX event.

This patch series refactors auxtrace with using evsel__is_aux_event(),
and remove unused the 'pmu_type' field from every AXU module's
structure.

This series has been tested on Arm SPE and Intel PT.


Leo Yan (9):
  perf auxtrace: Use evsel__is_aux_event() for checking AUX event
  perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record
  perf auxtrace: Refactor auxtrace__evsel_is_auxtrace()
  perf arm-spe: Remove the 'pmu_type' field
  perf cs-etm: Remove the 'pmu_type' field
  perf hisi-ptt: Remove the unused 'pmu_type' field
  perf intel-bts: Remove the 'pmu_type' field
  perf intel-pt: Remove the 'pmu_type' field
  perf s390-cpumsf: Remove the unused 'pmu_type' field

 tools/perf/arch/arm/util/cs-etm.c     |  1 -
 tools/perf/arch/arm64/util/arm-spe.c  |  1 -
 tools/perf/arch/arm64/util/hisi-ptt.c |  1 -
 tools/perf/arch/x86/util/intel-bts.c  |  1 -
 tools/perf/arch/x86/util/intel-pt.c   |  1 -
 tools/perf/util/arm-spe.c             | 13 +-------
 tools/perf/util/auxtrace.c            |  8 ++---
 tools/perf/util/auxtrace.h            |  3 --
 tools/perf/util/cs-etm.c              | 17 ++--------
 tools/perf/util/hisi-ptt.c            | 11 -------
 tools/perf/util/intel-bts.c           | 14 +-------
 tools/perf/util/intel-pt.c            | 46 ++++++++++-----------------
 tools/perf/util/s390-cpumsf.c         | 11 -------
 13 files changed, 25 insertions(+), 103 deletions(-)

-- 
2.34.1


