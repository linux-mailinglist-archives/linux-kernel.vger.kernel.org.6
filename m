Return-Path: <linux-kernel+bounces-349469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7504D98F68B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60FC1C22DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA101ABEAC;
	Thu,  3 Oct 2024 18:53:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C31C0DD6;
	Thu,  3 Oct 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981632; cv=none; b=mFzBuLhRKlssItspTzyzAU+GsI0VNg6hXQQ03baBq0MwtLKWYRu5HTHkwbpOcTdqzpdwEiZURmBdxvJpwQ/qZpIq+rNDNXLRU3zJyM+CrYMx+Ize3olYYK7AsdHTkPwR0ygp6shasf+AQ419euE0N5AL8LtrjaCjmgTIsdpuuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981632; c=relaxed/simple;
	bh=hKO/B15J995VtpURcUXXxTlAjV8SBjlKHuMwCb1tRsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWC2u7xYoCADMlzV969zThKoJoiq0E0w3g9weIMfc2u8Zjnv7QELzh6NvJaxWNn9r9pJ4s5FEKVHFPGgvy7iiGajW8bC9n+WdBFU/7oe40Np5dc2SZpGSzaicD2eI9N6dla5Z9MaKbeC1ilZX9ZT2EhdGW5KhAeNohgWEv7XdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE7B339;
	Thu,  3 Oct 2024 11:54:20 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C23143F640;
	Thu,  3 Oct 2024 11:53:48 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 7/7] perf arm-spe: Add Cortex CPUs to common data source encoding list
Date: Thu,  3 Oct 2024 19:53:22 +0100
Message-Id: <20241003185322.192357-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Cortex-A720, Cortex-A725, Cortex-X1C, Cortex-X3 and Cortex-X925 into
the common data source encoding list. For everyone of these CPUs, it
technical reference manual defines the data source packet as the common
encoding format.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 5c34a9ae3862..c424e5b9a11d 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -428,6 +428,11 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 }
 
 static const struct midr_range common_ds_encoding_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-- 
2.34.1


