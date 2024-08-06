Return-Path: <linux-kernel+bounces-276868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463B949954
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E8F1F25065
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F7174EDB;
	Tue,  6 Aug 2024 20:42:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D51741C8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976926; cv=none; b=mNfMY1FWaGffIbD9yUNY0FhFs5qRplEVdqP+pAEXYl7JBaT6xIXPg5XFRh7J9F1Dykc65GKklM9Q4uzUWYmub7mXa2dS/zMXWFQiNUru9xMizi8yyzpAMH3ZlxNhK58g6YNg/l2wCUuCmuLNm/oVr3TXRSNN9f6u2sHVBslzfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976926; c=relaxed/simple;
	bh=NaEkcWzX62U7jWuo0fONBwei3gbLKiLjZb1KipY0ZfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3pEvzxWkoIlGpZWp0fv8nptbnnyc+QMphwvGXX8Rwzlk/zzs1bOKBgStF48bfdd/ha6nDhuclyY6AA+VRIfxdj5BWt8RMzkFN+9gbOQYm5yCpAhRgLS0lSqxQnsh+6S9r8yQk1tNQoHWRY7qEh1I+H6ml2L4M0NPCNfGkH+Mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D0981063;
	Tue,  6 Aug 2024 13:42:30 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D66583F766;
	Tue,  6 Aug 2024 13:42:02 -0700 (PDT)
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
Subject: [PATCH v1 9/9] perf s390-cpumsf: Remove the unused 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:30 +0100
Message-Id: <20240806204130.720977-10-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204130.720977-1-leo.yan@arm.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pmu_type' field is not used, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/s390-cpumsf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index a9b0dea199d5..3d6253a4c5cf 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -172,7 +172,6 @@ struct s390_cpumsf {
 	struct perf_session	*session;
 	struct machine		*machine;
 	u32			auxtrace_type;
-	u32			pmu_type;
 	u16			machine_type;
 	bool			data_queued;
 	bool			use_logfile;
@@ -1136,7 +1135,6 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->session = session;
 	sf->machine = &session->machines.host; /* No kvm support */
 	sf->auxtrace_type = auxtrace_info->type;
-	sf->pmu_type = PERF_TYPE_RAW;
 	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
 
 	sf->auxtrace.process_event = s390_cpumsf_process_event;
-- 
2.34.1


