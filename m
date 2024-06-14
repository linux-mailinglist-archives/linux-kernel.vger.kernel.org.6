Return-Path: <linux-kernel+bounces-214965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8988908CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D4B24225
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307572BCF6;
	Fri, 14 Jun 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLOAr6tD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE934EED3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372877; cv=none; b=jXPbr79BhxE+yCEBbebalr0d9E/r8cTekKyDKxNIrkPdc8uF8p+PuEZzW+ilUvARuZygrzq3v4htNARxKrWu2BPtty6WuuOsy6B9D5DzCdS3lj6CHPEvA8GZtsa/FFGCuUUydS3wcVg/Pt2o9WnL899llLxQIduyqselfUaeZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372877; c=relaxed/simple;
	bh=jJFqlaJdKqU7Z/8dLxSiXJ8iFEYSgxcqV0Bzr/VH1dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmFmAtnjENTKHVsZ4bydKy5BBbBxNvaZqty/MG2eTfwAEHckTZWoJDqvfJWs9AkjToJnJAsSzLdX0u28fai5rDAA+QmLkx05tfPo2ZMMON8/LouxG/dcBCGksicyrMoNh4rLcYYe4E7ZXHPH2Y3GqMFETTBR8T2/Iju+KIRIJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLOAr6tD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718372876; x=1749908876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJFqlaJdKqU7Z/8dLxSiXJ8iFEYSgxcqV0Bzr/VH1dU=;
  b=VLOAr6tDjbiDaPyfHYPF4sQLjAH49aMqfFnWnmPGAHchpM80x/wZ4Vzx
   CFN6F/yZuHDscklWa7da8dvHZas5nCS5BS5Eqmt/RBX7ZO2aNgoOymCsR
   T1rXaFTLBj7Saiy6CFBQ9SYYmqjIPsLMWwohHxtLldwOrURxag2vyU6VX
   ECGE4MlkxBbtgUVor4e0rE6xEpQEgfE7cj0QEi49Yu8q6se/AiBYjY5GV
   egv5sFfUXTGH1dQuc3Y+l1FkGPg5z0rdKTFZU6Oyjyf921sPDJsq+V33K
   f3lbeyHWJvKFCHdvSeJVqPBUlsNymudBzSe2KNPyS//WpiP4XppzLQzYZ
   A==;
X-CSE-ConnectionGUID: vWDflc15Qg6N+11CyQhdsA==
X-CSE-MsgGUID: vqu0/whrQ/Wg4cAGNnBEiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19079175"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19079175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:47:53 -0700
X-CSE-ConnectionGUID: oZ/SNXioSFWQnJeFwVAFHA==
X-CSE-MsgGUID: xifLnIQaQ/WeX0ldZChrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40386690"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 06:47:52 -0700
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
	tim.c.chen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 8/8] perf/x86/intel/uncore: Support HBM and CXL PMON counters
Date: Fri, 14 Jun 2024 06:46:31 -0700
Message-Id: <20240614134631.1092359-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614134631.1092359-1-kan.liang@linux.intel.com>
References: <20240614134631.1092359-1-kan.liang@linux.intel.com>
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
index fbafc6ea198f..4d5933851895 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6162,7 +6162,55 @@ static struct intel_uncore_type spr_uncore_mdf = {
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
@@ -6186,6 +6234,9 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	NULL,
 	NULL,
 	&spr_uncore_mdf,
+	&spr_uncore_cxlcm,
+	&spr_uncore_cxldp,
+	&spr_uncore_hbm,
 };
 
 /*
@@ -6655,7 +6706,7 @@ static struct intel_uncore_type gnr_uncore_b2cmi = {
 };
 
 static struct intel_uncore_type gnr_uncore_b2cxl = {
-	SPR_UNCORE_MMIO_COMMON_FORMAT(),
+	SPR_UNCORE_MMIO_OFFS8_COMMON_FORMAT(),
 	.name			= "b2cxl",
 };
 
-- 
2.35.1


