Return-Path: <linux-kernel+bounces-514835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B41A35C56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466021891107
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3A262816;
	Fri, 14 Feb 2025 11:19:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF7261587;
	Fri, 14 Feb 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531991; cv=none; b=GFzBMDJCLfrH40w4NRszX4XbmsaxorDj8gfSPGJBYeDyV4qpmFz0iD7iiKYuw1jvenP0pJr2DmMrs0p8pp/f9HD7K6pjRmX5yJSqrRuWkkwKzh1oMc+Y6Cxj+VuwdmRshwmGcH2XEyyg7jmU6swuYaralTyNBb2rH1sqJhlI/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531991; c=relaxed/simple;
	bh=xrJFP4gZpFO39JXDabkBg/r4dX5C0Ww2B5X7sdvBXzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RjhTgDf89UEqzMImX+oX2IMkCQ7a/IeyE8Awg8dFPzEX9ROcj2PVe71fHqFNG72EAN74JC6OvIZ9yKMfdqw6MXjRm5gQ4zxDANMZakE41BDU6bYLwFlWJ9n8gIFrIv2ilAzVq/3R5QZN62PPQxSNloxVeJyhCzkxIweBARAYNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA651596;
	Fri, 14 Feb 2025 03:20:09 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 148673F6A8;
	Fri, 14 Feb 2025 03:19:45 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 01/11] perf script: Make printing flags reliable
Date: Fri, 14 Feb 2025 11:19:26 +0000
Message-Id: <20250214111936.15168-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214111936.15168-1-leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the generated string of flags.  Print out the raw number
if the string generation fails.

In another case, if the string length is longer than the aligned size,
allow the completed string to be printed.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-script.c   | 10 ++++++++--
 tools/perf/util/trace-event.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d797cec4f054..2c4b1fb7dc72 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1709,9 +1709,15 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
+	int ret;
+
+	ret = perf_sample__sprintf_flags(flags, str, sizeof(str));
+	if (ret < 0)
+		return fprintf(fp, "  raw flags:0x%-*x ",
+			       SAMPLE_FLAGS_STR_ALIGNED_SIZE - 12, flags);
 
-	perf_sample__sprintf_flags(flags, str, sizeof(str));
-	return fprintf(fp, "  %-21s ", str);
+	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
+	return fprintf(fp, "  %-*s ", ret, str);
 }
 
 struct printer_data {
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index ac9fde2f980c..71e680bc3d4b 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -145,6 +145,8 @@ int common_flags(struct scripting_context *context);
 int common_lock_depth(struct scripting_context *context);
 
 #define SAMPLE_FLAGS_BUF_SIZE 64
+#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
+
 int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
 
 #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
-- 
2.34.1


