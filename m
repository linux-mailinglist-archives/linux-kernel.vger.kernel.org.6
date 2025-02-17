Return-Path: <linux-kernel+bounces-518299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD813A38CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1A53B350E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198923F27A;
	Mon, 17 Feb 2025 19:59:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526823ED70;
	Mon, 17 Feb 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822386; cv=none; b=h8NoKzh51bCGKBAhWh0JthlVUB3EOzUCPZQxKBv88OAEt/Ho4yJzMo6ROQrVJaI8wMnLbeUBT8YbQkdjyykegYYiUUaoqKfpWM2+0rcmhwg5mVykemuolGhTlNkvwEhYFAEcaDD6Qf/CnE5xheGVWTWoS1+NK7uvelalvK2XnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822386; c=relaxed/simple;
	bh=JmX+pNnBd5ujLMKBhz0/lK6qpXQCaVTMEgH07jU7nww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBFeGsFFiOqoPrr4LTdFQTEsW848SvcNiY7UurvZUpTLIhNiTn7AQke5mjqVZwXqPS78xe+fvvuAbAAvUphYuD7tTkTaWy5QK5yhTySzsE5GJkeF2NGQA9dSFR0iEE0fF5NLh+UURMmgMscKSXISxTaYNIReoQG7TQdfZKu3BDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F371A152B;
	Mon, 17 Feb 2025 12:00:03 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B0A63F6A8;
	Mon, 17 Feb 2025 11:59:42 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 10/12] perf arm-spe: Set sample flags with supplement info
Date: Mon, 17 Feb 2025 19:59:06 +0000
Message-Id: <20250217195908.176207-11-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217195908.176207-1-leo.yan@arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the supplement information in the record, this commit sets the
sample flags for conditional branch, function call, return.  It also
sets events in flags, such as mispredict, not taken, and in transaction.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 0e8e05c87fd7..daecf9e1017a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -484,6 +484,26 @@ static void arm_spe__sample_flags(struct arm_spe_queue *speq)
 
 		if (record->type & ARM_SPE_BRANCH_MISS)
 			speq->flags |= PERF_IP_FLAG_BRANCH_MISS;
+
+		if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
+			speq->flags |= PERF_IP_FLAG_NOT_TAKEN;
+
+		if (record->type & ARM_SPE_IN_TXN)
+			speq->flags |= PERF_IP_FLAG_IN_TX;
+
+		if (record->op & ARM_SPE_OP_BR_COND)
+			speq->flags |= PERF_IP_FLAG_CONDITIONAL;
+
+		if (record->op & ARM_SPE_OP_BR_CR_BL)
+			speq->flags |= PERF_IP_FLAG_CALL;
+		else if (record->op & ARM_SPE_OP_BR_CR_RET)
+			speq->flags |= PERF_IP_FLAG_RETURN;
+		/*
+		 * Indirect branch instruction without link (e.g. BR),
+		 * take it as a function return.
+		 */
+		else if (record->op & ARM_SPE_OP_BR_INDIRECT)
+			speq->flags |= PERF_IP_FLAG_RETURN;
 	}
 }
 
-- 
2.34.1


