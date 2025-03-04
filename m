Return-Path: <linux-kernel+bounces-543997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436FA4DC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CFA178900
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DE202C4E;
	Tue,  4 Mar 2025 11:13:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A0C204F7C;
	Tue,  4 Mar 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086789; cv=none; b=BiVCyyCiFL4SCfYunJSeqedJw1GcSn42rxNNnZi+VzeHVvlft8iD7+nEkbtgmYezYNWLCP8TyWq+3y1Z6u1G+5llUMG5zPaT2qoLUFOm08YbgflykRWCMZql9/Piy+4Xg8063QdCGtf+w5LESJKBxRhp2Ibqe3qH/PAPttJbrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086789; c=relaxed/simple;
	bh=w8c5p/0eH9XySzVR5LkRGe//0ZjFFicuESB+QRP+4+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjulqVJK25hr75QtCXfLdoG1IZ1lKEoUncoGk9GPZYhe/U4V8C9lzvI2Nc8+2WnVPQ8ICfpLVxEGyFyYo1zxcfVNgOBygnxzC979cwnnNV11uH2pkyrwGN2EsMFn0qMtzFWpjH6lFqUgfOwFZtbpfpVWaFU46y/WofAJRZs0gyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16B3DFEC;
	Tue,  4 Mar 2025 03:13:21 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B72E3F5A1;
	Tue,  4 Mar 2025 03:13:04 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 07/12] perf arm-spe: Extend branch operations
Date: Tue,  4 Mar 2025 11:12:35 +0000
Message-Id: <20250304111240.3378214-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304111240.3378214-1-leo.yan@arm.com>
References: <20250304111240.3378214-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Arm ARM (ARM DDI 0487, L.a), the section "D18.2.7 Operation Type
packet", the branch subclass is extended for Call Return (CR), Guarded
control stack data access (GCS).

This commit adds support CR and GCS operations.  The IND (indirect)
operation is defined only in bit [1], its macro is updated accordingly.

Move the COND (Conditional) macro into the same group with other
operations for better maintenance.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 12 +++++++++---
 .../perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h  | 11 ++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4cef10a83962..625834da7e20 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -397,10 +397,16 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 		if (payload & SPE_OP_PKT_COND)
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " COND");
-
-		if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
+		if (payload & SPE_OP_PKT_INDIRECT_BRANCH)
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " IND");
-
+		if (payload & SPE_OP_PKT_GCS)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GCS");
+		if (SPE_OP_PKT_CR_BL(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-BL");
+		if (SPE_OP_PKT_CR_RET(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-RET");
+		if (SPE_OP_PKT_CR_NON_BL_RET(payload))
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " CR-NON-BL-RET");
 		break;
 	default:
 		/* Unknown index */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 464a912b221c..32d760ede701 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -7,6 +7,7 @@
 #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
 #define INCLUDE__ARM_SPE_PKT_DECODER_H__
 
+#include <linux/bitfield.h>
 #include <stddef.h>
 #include <stdint.h>
 
@@ -116,8 +117,6 @@ enum arm_spe_events {
 
 #define SPE_OP_PKT_IS_OTHER_SVE_OP(v)		(((v) & (BIT(7) | BIT(3) | BIT(0))) == 0x8)
 
-#define SPE_OP_PKT_COND				BIT(0)
-
 #define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
 #define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
 #define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
@@ -148,7 +147,13 @@ enum arm_spe_events {
 #define SPE_OP_PKT_SVE_PRED			BIT(2)
 #define SPE_OP_PKT_SVE_FP			BIT(1)
 
-#define SPE_OP_PKT_IS_INDIRECT_BRANCH(v)	(((v) & GENMASK_ULL(7, 1)) == 0x2)
+#define SPE_OP_PKT_CR_MASK			GENMASK_ULL(4, 3)
+#define SPE_OP_PKT_CR_BL(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 1)
+#define SPE_OP_PKT_CR_RET(v)			(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 2)
+#define SPE_OP_PKT_CR_NON_BL_RET(v)		(FIELD_GET(SPE_OP_PKT_CR_MASK, (v)) == 3)
+#define SPE_OP_PKT_GCS				BIT(2)
+#define SPE_OP_PKT_INDIRECT_BRANCH		BIT(1)
+#define SPE_OP_PKT_COND				BIT(0)
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.34.1


