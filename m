Return-Path: <linux-kernel+bounces-315738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6496C65C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE25284087
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62C41E4130;
	Wed,  4 Sep 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d2kPm73O"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283B1E2025
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474414; cv=none; b=lzfZdTENUy9HrYDIWlgY7ePDbXX+Zpf7Z/eAtA6rNTH8vDGtFxbMVPkwJu4NLt2n/JtRIBzCYWpbVwcucKJprZp0y0o/40VNhrC9ghF4hB17E7hXFnnDVoPJOqX4Dgl8yOWtuDQGBz7D9/L3rSbgp1Ol+fJYXSW4YGxjP3lTRbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474414; c=relaxed/simple;
	bh=kqq8pT1LP3S6vactUZKET6rzd/7b2EFe9Eaj6lWU3G8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDPkF4DK1uRBxMCQ5i6Nyo9WIyW3/2In5/T0Pk74ZZmb716oQUcyXO35pZyoQ86KHCK/8ctQ935YxXMyMaxUd5aaGC0bDwJNeuzzm7UpAIfcYBzmaPRStIQGNbHbpiSS9R0dsr6jahgRnZkgYAVCbaMUfWZN4lRvZPNncHcXO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d2kPm73O; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484HZw48031921;
	Wed, 4 Sep 2024 11:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	u/70uB/NxGKFHpUpJGV5ZaNpkmJbpOla3Md1PvTZdM=; b=d2kPm73OGHBCyGwbo
	WZ8h4lDeCN5aCXCSMDudoEhCnKjI/ahEzbAij96qfF1CT/ctUILG1YMm7jTR/rol
	DYlasHVrFOj3Luclon+lvyqOAiBUbulrd3DiPhHeFN74Xg26XXOg+Ci0j2vPGjag
	m7GmZYSWEotkX+N2iNI7PotFdqFf9PkdP8Ffch+IJ9DjvFmnp8FC7BcdxJzRfW1p
	qnHHnrq2Y09yvz2ZPHdzdU88uOJGrZZxur4Bft8GOocArqhWARNskuenMG4Hn1BG
	gOEEMOvxGafdZmDnaVE4Xy0ycLcFFbTej7d4RAsI2HJ8uVgqB9191SR5qVqn3tKo
	Acj6g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ev31r6g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:26:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 11:26:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 11:26:40 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
	by maili.marvell.com (Postfix) with ESMTP id 3B3FF3F7044;
	Wed,  4 Sep 2024 11:26:37 -0700 (PDT)
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v7 4/6] perf/marvell: Odyssey DDR Performance monitor support
Date: Wed, 4 Sep 2024 23:56:03 +0530
Message-ID: <20240904182605.953927-5-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904182605.953927-1-gthiagarajan@marvell.com>
References: <20240904182605.953927-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PVWyhfnAQqs1xpAjfu6JLIc5FCJhIiUe
X-Proofpoint-GUID: PVWyhfnAQqs1xpAjfu6JLIc5FCJhIiUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01

Odyssey DRAM Subsystem supports eight counters for monitoring performance
and software can program those counters to monitor any of the defined
performance events. Supported performance events include those counted
at the interface between the DDR controller and the PHY, interface between
the DDR Controller and the CHI interconnect, or within the DDR Controller.

Additionally DSS also supports two fixed performance event counters, one
for ddr reads and the other for ddr writes.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---
 Documentation/admin-guide/perf/index.rst      |   1 +
 .../admin-guide/perf/mrvl-odyssey-ddr-pmu.rst |  80 ++++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 257 +++++++++++++++++-
 3 files changed, 335 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 7eb3dcd6f4da..d673ccfea903 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -14,6 +14,7 @@ Performance monitor support
    qcom_l2_pmu
    qcom_l3_pmu
    starfive_starlink_pmu
+   mrvl-odyssey-ddr-pmu
    arm-ccn
    arm-cmn
    xgene-pmu
diff --git a/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst b/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
new file mode 100644
index 000000000000..2e817593a4d9
--- /dev/null
+++ b/Documentation/admin-guide/perf/mrvl-odyssey-ddr-pmu.rst
@@ -0,0 +1,80 @@
+===================================================================
+Marvell Odyssey DDR PMU Performance Monitoring Unit (PMU UNCORE)
+===================================================================
+
+Odyssey DRAM Subsystem supports eight counters for monitoring performance
+and software can program those counters to monitor any of the defined
+performance events. Supported performance events include those counted
+at the interface between the DDR controller and the PHY, interface between
+the DDR Controller and the CHI interconnect, or within the DDR Controller.
+
+Additionally DSS also supports two fixed performance event counters, one
+for ddr reads and the other for ddr writes.
+
+The counter will be operating in either manual or auto mode.
+
+The PMU driver exposes the available events and format options under sysfs::
+
+        /sys/bus/event_source/devices/mrvl_ddr_pmu_<>/events/
+        /sys/bus/event_source/devices/mrvl_ddr_pmu_<>/format/
+
+Examples::
+
+        $ perf list | grep ddr
+        mrvl_ddr_pmu_<>/ddr_act_bypass_access/   [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_bsm_alloc/           [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_bsm_starvation/      [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_active_access/   [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_mwr/             [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_rd_active_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_rd_or_wr_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_read/            [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_wr_access/       [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_cam_write/           [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_capar_error/         [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_crit_ref/            [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_ddr_reads/           [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_ddr_writes/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dfi_cmd_is_retry/    [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dfi_cycles/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dfi_parity_poison/   [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dfi_rd_data_access/  [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dfi_wr_data_access/  [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dqsosc_mpc/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_dqsosc_mrr/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_enter_mpsm/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_enter_powerdown/     [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_enter_selfref/       [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hif_pri_rdaccess/    [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hif_rd_access/       [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hif_rd_or_wr_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hif_rmw_access/      [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hif_wr_access/       [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_hpri_sched_rd_crit_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_load_mode/           [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_lpri_sched_rd_crit_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_precharge/           [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_precharge_for_other/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_precharge_for_rdwr/  [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_raw_hazard/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_rd_bypass_access/    [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_rd_crc_error/        [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_rd_uc_ecc_error/     [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_rdwr_transitions/    [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_refresh/             [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_retry_fifo_full/     [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_spec_ref/            [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_tcr_mrr/             [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_war_hazard/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_waw_hazard/          [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_win_limit_reached_rd/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_win_limit_reached_wr/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_wr_crc_error/        [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_wr_trxn_crit_access/ [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_write_combine/       [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_zqcl/                [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_zqlatch/             [Kernel PMU event]
+        mrvl_ddr_pmu_<>/ddr_zqstart/             [Kernel PMU event]
+
+        $ perf stat -e ddr_cam_read,ddr_cam_write,ddr_cam_active_access,ddr_cam
+          rd_or_wr_access,ddr_cam_rd_active_access,ddr_cam_mwr <workload>
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 86e63a2b02d7..533e84f33a8f 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -16,23 +16,28 @@
 
 /* Performance Counters Operating Mode Control Registers */
 #define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define ODY_DDRC_PERF_CNT_OP_MODE_CTRL		0x20020
 #define OP_MODE_CTRL_VAL_MANUAL	0x1
 
 /* Performance Counters Start Operation Control Registers */
 #define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define ODY_DDRC_PERF_CNT_START_OP_CTRL		0x200A0
 #define START_OP_CTRL_VAL_START		0x1ULL
 #define START_OP_CTRL_VAL_ACTIVE	0x2
 
 /* Performance Counters End Operation Control Registers */
 #define CN10K_DDRC_PERF_CNT_END_OP_CTRL	0x8030
+#define ODY_DDRC_PERF_CNT_END_OP_CTRL	0x200E0
 #define END_OP_CTRL_VAL_END		0x1ULL
 
 /* Performance Counters End Status Registers */
 #define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
+#define ODY_DDRC_PERF_CNT_END_STATUS		0x20120
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
 #define CN10K_DDRC_PERF_CFG_BASE		0x8040
+#define ODY_DDRC_PERF_CFG_BASE			0x20160
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -57,6 +62,13 @@
  * program event bitmap in h/w.
  *
  */
+#define EVENT_DFI_CMD_IS_RETRY			61
+#define EVENT_RD_UC_ECC_ERROR			60
+#define EVENT_RD_CRC_ERROR			59
+#define EVENT_CAPAR_ERROR			58
+#define EVENT_WR_CRC_ERROR			57
+#define EVENT_DFI_PARITY_POISON			56
+
 #define EVENT_OP_IS_ZQLATCH			55
 #define EVENT_OP_IS_ZQSTART			54
 #define EVENT_OP_IS_TCR_MRR			53
@@ -106,6 +118,7 @@
 
 /* Event counter value registers */
 #define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
+#define ODY_DDRC_PERF_CNT_VALUE_BASE	0x201C0
 
 /* Fixed event counter enable/disable register */
 #define CN10K_DDRC_PERF_CNT_FREERUN_EN		0x80C0
@@ -114,18 +127,25 @@
 
 /* Fixed event counter control register */
 #define CN10K_DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
+#define ODY_DDRC_PERF_CNT_FREERUN_CTRL		0x20240
 #define DDRC_FREERUN_WRITE_CNT_CLR	0x1
 #define DDRC_FREERUN_READ_CNT_CLR	0x2
 
+/* Fixed event counter clear register, defined only for Odyssey */
+#define ODY_DDRC_PERF_CNT_FREERUN_CLR		0x20248
+
 #define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
 #define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
 
 /* Fixed event counter value register */
 #define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
 #define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
+#define ODY_DDRC_PERF_CNT_VALUE_WR_OP		0x20250
+#define ODY_DDRC_PERF_CNT_VALUE_RD_OP		0x20258
 
 enum mrvl_ddr_pmu_version {
 	DDR_PMU_V1 = 1,
+	DDR_PMU_V2,
 };
 
 struct ddr_pmu_data {
@@ -249,6 +269,85 @@ static struct attribute *cn10k_ddr_perf_events_attrs[] = {
 	NULL
 };
 
+static struct attribute *odyssey_ddr_perf_events_attrs[] = {
+	/* Programmable */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access, EVENT_HIF_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access, EVENT_HIF_RMW),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess, EVENT_HIF_HI_PRI_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access, EVENT_READ_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access, EVENT_ACT_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_wr_data_access,
+				 EVENT_DFI_WR_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_rd_data_access,
+				 EVENT_DFI_RD_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
+				 EVENT_HPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
+				 EVENT_LPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
+				 EVENT_WR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access, EVENT_OP_IS_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access,
+				 EVENT_OP_IS_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access,
+				 EVENT_OP_IS_RD_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge, EVENT_OP_IS_PRECHARGE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr,
+				 EVENT_PRECHARGE_FOR_RDWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
+				 EVENT_PRECHARGE_FOR_OTHER),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions, EVENT_RDWR_TRANSITIONS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine, EVENT_WRITE_COMBINE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard, EVENT_WAR_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard, EVENT_RAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard, EVENT_WAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref, EVENT_OP_IS_ENTER_SELFREF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown,
+				 EVENT_OP_IS_ENTER_POWERDOWN),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_mpsm, EVENT_OP_IS_ENTER_MPSM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode, EVENT_OP_IS_LOAD_MODE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cycles, EVENT_DFI_OR_HPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_retry_fifo_full,
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
+				 EVENT_VISIBLE_WIN_LIMIT_REACHED_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
+				 EVENT_VISIBLE_WIN_LIMIT_REACHED_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc, EVENT_OP_IS_DQSOSC_MPC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr, EVENT_OP_IS_DQSOSC_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_OP_IS_TCR_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_OP_IS_ZQSTART),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_OP_IS_ZQLATCH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_parity_poison,
+				 EVENT_DFI_PARITY_POISON),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_crc_error, EVENT_WR_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_capar_error, EVENT_CAPAR_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_crc_error, EVENT_RD_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_uc_ecc_error, EVENT_RD_UC_ECC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cmd_is_retry, EVENT_DFI_CMD_IS_RETRY),
+	/* Free run event counters */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
+	NULL
+};
+
+static struct attribute_group odyssey_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = odyssey_ddr_perf_events_attrs,
+};
+
 static struct attribute_group cn10k_ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = cn10k_ddr_perf_events_attrs,
@@ -294,6 +393,13 @@ static const struct attribute_group *cn10k_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *odyssey_attr_groups[] = {
+	&odyssey_ddr_perf_events_attr_group,
+	&cn10k_ddr_perf_format_attr_group,
+	&cn10k_ddr_perf_cpumask_attr_group,
+	NULL
+};
+
 /* Default poll timeout is 100 sec, which is very sufficient for
  * 48 bit counter incremented max at 5.6 GT/s, which may take many
  * hours to overflow.
@@ -306,20 +412,27 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
 	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
 }
 
-static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
+static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
+				     struct cn10k_ddr_pmu *ddr_pmu)
 {
 	switch (eventid) {
 	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
 	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
 		*event_bitmap = (1ULL << (eventid - 1));
 		break;
+	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
+		if (ddr_pmu->version == DDR_PMU_V2)
+			*event_bitmap = (1ULL << (eventid - 1));
+		else
+			goto err;
+		break;
 	case EVENT_OP_IS_ENTER_SELFREF:
 	case EVENT_OP_IS_ENTER_POWERDOWN:
 	case EVENT_OP_IS_ENTER_MPSM:
 		*event_bitmap = (0xFULL << (eventid - 1));
 		break;
 	default:
-		pr_err("%s Invalid eventid %d\n", __func__, eventid);
+err:		pr_err("%s Invalid eventid %d\n", __func__, eventid);
 		return -EINVAL;
 	}
 
@@ -457,15 +570,43 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 	local64_add((new_count - prev_count) & mask, &event->count);
 }
 
+static void cn10k_ddr_perf_counter_start(struct cn10k_ddr_pmu *ddr_pmu,
+					 int counter)
+{
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_start_op_ctrl;
+
+	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
+static void cn10k_ddr_perf_counter_stop(struct cn10k_ddr_pmu *ddr_pmu,
+					int counter)
+{
+	const struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_end_op_ctrl;
+
+	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
 static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	u64 ctrl_reg = pmu->p_data->ddrc_perf_cnt_op_mode_ctrl;
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
 
 	local64_set(&hwc->prev_count, 0);
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, true);
+	if (pmu->version == DDR_PMU_V2) {
+	/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, pmu->base +
+			       DDRC_PERF_REG(ctrl_reg, counter));
+
+		cn10k_ddr_perf_counter_start(pmu, counter);
+	}
 
 	hwc->state = 0;
 }
@@ -495,7 +636,7 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
 		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
-		ret = ddr_perf_get_event_bitmap(config, &val);
+		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
 		if (ret)
 			return ret;
 
@@ -524,6 +665,9 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, false);
 
+	if (pmu->version == DDR_PMU_V2)
+		cn10k_ddr_perf_counter_stop(pmu, counter);
+
 	if (flags & PERF_EF_UPDATE)
 		cn10k_ddr_perf_event_update(event);
 
@@ -640,6 +784,66 @@ static void ddr_pmu_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
 	cn10k_ddr_perf_pmu_enable(&pmu->pmu);
 }
 
+static void ddr_pmu_v2_enable_read_freerun(struct cn10k_ddr_pmu *pmu,
+					   bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_READ_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_READ_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_v2_enable_write_freerun(struct cn10k_ddr_pmu *pmu,
+					    bool enable)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = readq_relaxed(pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+	if (enable)
+		val |= DDRC_PERF_FREERUN_WRITE_EN;
+	else
+		val &= ~DDRC_PERF_FREERUN_WRITE_EN;
+
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_ctrl);
+}
+
+static void ddr_pmu_v2_read_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_READ_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_clr);
+}
+
+static void ddr_pmu_v2_write_clear_freerun(struct cn10k_ddr_pmu *pmu)
+{
+	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
+	u64 val;
+
+	val = DDRC_FREERUN_WRITE_CNT_CLR;
+	writeq_relaxed(val, pmu->base + p_data->ddrc_perf_cnt_freerun_clr);
+}
+
+static void ddr_pmu_v2_overflow_hander(struct cn10k_ddr_pmu *pmu, int evt_idx)
+{
+	/*
+	 * On reaching the maximum value of the counter, the counter freezes
+	 * there. The particular event is updated and the respective counter
+	 * is stopped and started again so that it starts counting from zero
+	 */
+	cn10k_ddr_perf_event_update(pmu->events[evt_idx]);
+	cn10k_ddr_perf_counter_stop(pmu, evt_idx);
+	cn10k_ddr_perf_counter_start(pmu, evt_idx);
+}
+
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
 	const struct ddr_pmu_platform_data *p_data = pmu->p_data;
@@ -751,6 +955,37 @@ static const struct ddr_pmu_data ddr_pmu_data = {
 	.id   = DDR_PMU_V1,
 };
 
+static const struct ddr_pmu_ops ddr_pmu_v2_ops = {
+	.enable_read_freerun_counter = ddr_pmu_v2_enable_read_freerun,
+	.enable_write_freerun_counter = ddr_pmu_v2_enable_write_freerun,
+	.clear_read_freerun_counter = ddr_pmu_v2_read_clear_freerun,
+	.clear_write_freerun_counter = ddr_pmu_v2_write_clear_freerun,
+	.pmu_overflow_handler = ddr_pmu_v2_overflow_hander,
+};
+
+static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
+	.counter_overflow_val = 0,
+	.counter_max_val = GENMASK_ULL(63, 0),
+	.ddrc_perf_cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = ODY_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = ODY_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = ODY_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = ODY_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = 0,
+	.ddrc_perf_cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
+	.ddrc_perf_cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
+	.ops = &ddr_pmu_v2_ops,
+};
+
+#ifdef CONFIG_ACPI
+static const struct ddr_pmu_data ddr_pmu_v2_data = {
+	.id   = DDR_PMU_V2,
+};
+#endif
+
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
 	const struct ddr_pmu_data *dev_data;
@@ -803,6 +1038,21 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
 			.pmu_disable = cn10k_ddr_perf_pmu_disable,
 		};
+	} else {
+		ddr_pmu->pmu = (struct pmu) {
+			.module       = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = odyssey_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add         = cn10k_ddr_perf_event_add,
+			.del         = cn10k_ddr_perf_event_del,
+			.start       = cn10k_ddr_perf_event_start,
+			.stop        = cn10k_ddr_perf_event_stop,
+			.read        = cn10k_ddr_perf_event_update,
+		};
+
+		ddr_pmu->p_data = &odyssey_ddr_pmu_pdata;
 	}
 
 	/* Choose this cpu to collect perf data */
@@ -855,6 +1105,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
 	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},
+	{"MRVL000C", (kernel_ulong_t)&ddr_pmu_v2_data},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
-- 
2.25.1


