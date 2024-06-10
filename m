Return-Path: <linux-kernel+bounces-208852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B39029DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804801C23A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F691514F2;
	Mon, 10 Jun 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjO6+gUh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46114C5BE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050677; cv=none; b=YnU10+JU+HTy7vX6GKtKPxNebliV7V92YRE92C+gutuXeyyGAr03B94+z+oc9BBnIR1dYNfBhGPEkfJtvBw8jHNc4syKEKPPjpzs5T72ViNhrPOlQf44jnAXjoTTINl+3nP8S+gI61bwpWX4SafsWey2/ikRFkmSzH7Nncbmr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050677; c=relaxed/simple;
	bh=wimvY5isq1Qjd2cAKH3TiSNl3khLuKHiYStMxXzBNrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpLs8mLjJgjaoYJij5pFGTEZ4i/bGou5kB3UfuDz1gxuJdL+9ezAd58dIYktvbfhf3nyvEjKQURrVcZEHGViOq1RPqX4LBkYbbknvmq78nU7kGKOb2/skWdJU9gEenmYHlcwotb+abo6QeAxtIbFUPNfwpH0CMDP1h0m/nuYVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjO6+gUh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050676; x=1749586676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wimvY5isq1Qjd2cAKH3TiSNl3khLuKHiYStMxXzBNrY=;
  b=DjO6+gUhCLUaCAtQYjZxCVoXQ0lGLR4YYEweApIjGGOpb/Tj5hYbKU94
   mcztjkm95gMR2PYr82Ow+ezYYLN1QYN+W1rIdwaJEhrT3vE2YfkUNnG+8
   2KqstjPxMejUdQYKU8xHIcMk+p1PriOL59jLkfrkgS74Xe+ltY2N8Dvix
   EkeZHUX3W2O6Sb0wOSlpnbc3/i3ec9u76Ztch6IxOEdvEoqzcLLCbI2go
   2TI0fQNjB1Yoziw6aWmzkvZTcSBiPoVwhuqbRJBBloQxug9v3BM4MxTdn
   n7ojg2+pC4RiIyzb7NNr7t//hl7Kd4FI+VGqbt9sLyxYzNmgVDn/+BBtY
   A==;
X-CSE-ConnectionGUID: mBMhNhc9SSyz1rPZeEhs9Q==
X-CSE-MsgGUID: 0M8lTslSQeaKbW0BHz3Low==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561541"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561541"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:52 -0700
X-CSE-ConnectionGUID: CQbSNOqcSpmI0knvizJOLw==
X-CSE-MsgGUID: IzcRmTPiRTS1AHHFJDeYmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39169109"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2024 13:17:52 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	yunying.sun@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 8/8] perf/x86/intel/uncore: Support HBM and CXL PMON counters
Date: Mon, 10 Jun 2024 13:16:19 -0700
Message-Id: <20240610201619.884021-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240610201619.884021-1-kan.liang@linux.intel.com>
References: <20240610201619.884021-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Unknown uncore PMON types can be found in both SPR and EMR with HBM or
CXL.

 $ls /sys/devices/ | grep type
 uncore_type_12_16
 uncore_type_12_18
 uncore_type_12_2
 uncore_type_12_4
 uncore_type_12_6
 uncore_type_12_8
 uncore_type_13_17
 uncore_type_13_19
 uncore_type_13_3
 uncore_type_13_5
 uncore_type_13_7
 uncore_type_13_9

The unknown PMON types are HBM and CXL PMON. Except for the name, the
other information regarding the HBM and CXL PMON counters can be
retrieved via the discovery table. Add them into the uncores tables for
SPR and EMR.

The event config registers for all CXL related units are 8-byte apart.
Add SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT to specially handle it.

Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 55 +++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fde123af9e3a..a7ea221f2f11 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6163,7 +6163,55 @@ static struct intel_uncore_type spr_uncore_mdf = {
 	.name			= "mdf",
 };
 
-#define UNCORE_SPR_NUM_UNCORE_TYPES		12
+static void spr_uncore_mmio_offs8_init_box(struct intel_uncore_box *box)
+{
+	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
+	intel_generic_uncore_mmio_init_box(box);
+}
+
+static struct intel_uncore_ops spr_uncore_mmio_offs8_ops = {
+	.init_box		= spr_uncore_mmio_offs8_init_box,
+	.exit_box		= uncore_mmio_exit_box,
+	.disable_box		= intel_generic_uncore_mmio_disable_box,
+	.enable_box		= intel_generic_uncore_mmio_enable_box,
+	.disable_event		= intel_generic_uncore_mmio_disable_event,
+	.enable_event		= spr_uncore_mmio_enable_event,
+	.read_counter		= uncore_mmio_read_counter,
+};
+
+#define SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT()			\
+	SPR_UNCORE_COMMON_FORMAT(),				\
+	.ops			= &spr_uncore_mmio_offs8_ops
+
+static struct event_constraint spr_uncore_cxlcm_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x02, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x05, 0x0f),
+	UNCORE_EVENT_CONSTRAINT(0x40, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
+	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
+	EVENT_CONSTRAINT_END
+};
+
+static struct intel_uncore_type spr_uncore_cxlcm = {
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
+	.name			= "cxlcm",
+	.constraints		= spr_uncore_cxlcm_constraints,
+};
+
+static struct intel_uncore_type spr_uncore_cxldp = {
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
+	.name			= "cxldp",
+};
+
+static struct intel_uncore_type spr_uncore_hbm = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "hbm",
+};
+
+#define UNCORE_SPR_NUM_UNCORE_TYPES		15
 #define UNCORE_SPR_CHA				0
 #define UNCORE_SPR_IIO				1
 #define UNCORE_SPR_IMC				6
@@ -6187,6 +6235,9 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	NULL,
 	&spr_uncore_mdf,
+	&spr_uncore_cxlcm,
+	&spr_uncore_cxldp,
+	&spr_uncore_hbm,
 };
 
 /*
@@ -6656,7 +6707,7 @@ static struct intel_uncore_type gnr_uncore_b2cmi = {
 };
 
 static struct intel_uncore_type gnr_uncore_b2cxl = {
-	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
 	.name			= "b2cxl",
 };
 
-- 
2.35.1


