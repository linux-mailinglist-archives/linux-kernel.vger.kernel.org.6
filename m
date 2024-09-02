Return-Path: <linux-kernel+bounces-311747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3375B968D01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587CA1C22D6A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598FE1C62C3;
	Mon,  2 Sep 2024 17:52:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229061AB6F6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299549; cv=none; b=SsVl0Qonjm39Cdun9BkJZK1SkiF/NpSXvIeu6RIchGnxsyb7qnTD4NWsN195JXyQfWcDS2avn7AggR4UjqtpcWb9S8HfACWAvZ3rZFUPD2uTNUAayfK4bndLP68DUXVIokKHwN3E/bw4J1BbY+vXo5Yd0Ftp3DExODei9egmBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299549; c=relaxed/simple;
	bh=0HAqXu3+tGd3VTfFSb8mBMPMbtKNpNTh/fTGF+eP2cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIqkqKRgk30R4RCP5629DWy6urTrCQUoyjGKewcSkWh/KJeWrsygLw6i7K+PqE3DG/ceCUiQL40G6Zi4CeOBo+j8MPxJXNlVTR8Pbd7Ct20Qby/25ux2W6EpUlgzTbGuZeB7sDLVV0KwGBcH/xcIDj+LWeSQTkbfBb3KVSCagOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7ADFEC;
	Mon,  2 Sep 2024 10:52:53 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAB553F73B;
	Mon,  2 Sep 2024 10:52:26 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2 8/8] perf/arm-cmn: Support CMN S3
Date: Mon,  2 Sep 2024 18:52:04 +0100
Message-Id: <2ec9eec5b6bf215a9886f3b69e3b00e4cd85095c.1725296395.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1725296395.git.robin.murphy@arm.com>
References: <cover.1725296395.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMN S3 is the latest and greatest evolution for 2024, although most of
the new features don't impact the PMU, so from our point of view it ends
up looking a lot like CMN-700 r3 still. We have some new device types to
ignore, a mildly irritating rearrangement of the register layouts, and a
scary new configuration option that makes it potentially unsafe to even
walk the full discovery tree, let alone attempt to use the PMU.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 119 ++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 43 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ac7dd4c352e8..0266ff041e0b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -45,24 +45,28 @@
 #define CMN_CFGM_PERIPH_ID_23		0x0010
 #define CMN_CFGM_PID2_REVISION		GENMASK_ULL(7, 4)
 
-#define CMN_CFGM_INFO_GLOBAL		0x900
+#define CMN_CFGM_INFO_GLOBAL		0x0900
 #define CMN_INFO_MULTIPLE_DTM_EN	BIT_ULL(63)
 #define CMN_INFO_RSP_VC_NUM		GENMASK_ULL(53, 52)
 #define CMN_INFO_DAT_VC_NUM		GENMASK_ULL(51, 50)
+#define CMN_INFO_DEVICE_ISO_ENABLE	BIT_ULL(44)
 
-#define CMN_CFGM_INFO_GLOBAL_1		0x908
+#define CMN_CFGM_INFO_GLOBAL_1		0x0908
 #define CMN_INFO_SNP_VC_NUM		GENMASK_ULL(3, 2)
 #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
 
 /* XPs also have some local topology info which has uses too */
 #define CMN_MXP__CONNECT_INFO(p)	(0x0008 + 8 * (p))
-#define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
+#define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(5, 0)
 
 #define CMN_MAX_PORTS			6
 #define CI700_CONNECT_INFO_P2_5_OFFSET	0x10
 
 /* PMU registers occupy the 3rd 4KB page of each node's region */
 #define CMN_PMU_OFFSET			0x2000
+/* ...except when they don't :( */
+#define CMN_S3_DTM_OFFSET		0xa000
+#define CMN_S3_PMU_OFFSET		0xd900
 
 /* For most nodes, this is all there is */
 #define CMN_PMU_EVENT_SEL		0x000
@@ -195,10 +199,11 @@ enum cmn_model {
 	CMN650 = 2,
 	CMN700 = 4,
 	CI700 = 8,
+	CMNS3 = 16,
 	/* ...and then we can use bitmap tricks for commonality */
 	CMN_ANY = -1,
 	NOT_CMN600 = -2,
-	CMN_650ON = CMN650 | CMN700,
+	CMN_650ON = CMN650 | CMN700 | CMNS3,
 };
 
 /* Actual part numbers and revision IDs defined by the hardware */
@@ -207,6 +212,7 @@ enum cmn_part {
 	PART_CMN650 = 0x436,
 	PART_CMN700 = 0x43c,
 	PART_CI700 = 0x43a,
+	PART_CMN_S3 = 0x43e,
 };
 
 /* CMN-600 r0px shouldn't exist in silicon, thankfully */
@@ -258,6 +264,7 @@ enum cmn_node_type {
 	CMN_TYPE_HNS = 0x200,
 	CMN_TYPE_HNS_MPAM_S,
 	CMN_TYPE_HNS_MPAM_NS,
+	CMN_TYPE_APB = 0x1000,
 	/* Not a real node type */
 	CMN_TYPE_WP = 0x7770
 };
@@ -408,6 +415,8 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
 		return CMN700;
 	case PART_CI700:
 		return CI700;
+	case PART_CMN_S3:
+		return CMNS3;
 	default:
 		return 0;
 	};
@@ -415,6 +424,11 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
 
 static int arm_cmn_pmu_offset(const struct arm_cmn *cmn, const struct arm_cmn_node *dn)
 {
+	if (cmn->part == PART_CMN_S3) {
+		if (dn->type == CMN_TYPE_XP)
+			return CMN_S3_DTM_OFFSET;
+		return CMN_S3_PMU_OFFSET;
+	}
 	return CMN_PMU_OFFSET;
 }
 
@@ -468,9 +482,14 @@ static const char *arm_cmn_device_type(u8 type)
 		case 0x17: return "RN-F_C_E|";
 		case 0x18: return " RN-F_E |";
 		case 0x19: return "RN-F_E_E|";
+		case 0x1a: return "  HN-S  |";
+		case 0x1b: return "  LCN   |";
 		case 0x1c: return "  MTSX  |";
 		case 0x1d: return "  HN-V  |";
 		case 0x1e: return "  CCG   |";
+		case 0x20: return " RN-F_F |";
+		case 0x21: return "RN-F_F_E|";
+		case 0x22: return " SN-F_F |";
 		default:   return "  ????  |";
 	}
 }
@@ -779,8 +798,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	CMN_EVENT_ATTR(CMN_ANY, cxha_##_name, CMN_TYPE_CXHA, _event)
 #define CMN_EVENT_CCRA(_name, _event)				\
 	CMN_EVENT_ATTR(CMN_ANY, ccra_##_name, CMN_TYPE_CCRA, _event)
-#define CMN_EVENT_CCHA(_name, _event)				\
-	CMN_EVENT_ATTR(CMN_ANY, ccha_##_name, CMN_TYPE_CCHA, _event)
+#define CMN_EVENT_CCHA(_model, _name, _event)				\
+	CMN_EVENT_ATTR(_model, ccha_##_name, CMN_TYPE_CCHA, _event)
 #define CMN_EVENT_CCLA(_name, _event)				\
 	CMN_EVENT_ATTR(CMN_ANY, ccla_##_name, CMN_TYPE_CCLA, _event)
 #define CMN_EVENT_CCLA_RNI(_name, _event)				\
@@ -1138,42 +1157,43 @@ static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_CCRA(wdb_alloc,			0x59),
 	CMN_EVENT_CCRA(ssb_alloc,			0x5a),
 
-	CMN_EVENT_CCHA(rddatbyp,			0x61),
-	CMN_EVENT_CCHA(chirsp_up_stall,			0x62),
-	CMN_EVENT_CCHA(chidat_up_stall,			0x63),
-	CMN_EVENT_CCHA(snppcrd_link0_stall,		0x64),
-	CMN_EVENT_CCHA(snppcrd_link1_stall,		0x65),
-	CMN_EVENT_CCHA(snppcrd_link2_stall,		0x66),
-	CMN_EVENT_CCHA(reqtrk_occ,			0x67),
-	CMN_EVENT_CCHA(rdb_occ,				0x68),
-	CMN_EVENT_CCHA(rdbyp_occ,			0x69),
-	CMN_EVENT_CCHA(wdb_occ,				0x6a),
-	CMN_EVENT_CCHA(snptrk_occ,			0x6b),
-	CMN_EVENT_CCHA(sdb_occ,				0x6c),
-	CMN_EVENT_CCHA(snphaz_occ,			0x6d),
-	CMN_EVENT_CCHA(reqtrk_alloc,			0x6e),
-	CMN_EVENT_CCHA(rdb_alloc,			0x6f),
-	CMN_EVENT_CCHA(rdbyp_alloc,			0x70),
-	CMN_EVENT_CCHA(wdb_alloc,			0x71),
-	CMN_EVENT_CCHA(snptrk_alloc,			0x72),
-	CMN_EVENT_CCHA(sdb_alloc,			0x73),
-	CMN_EVENT_CCHA(snphaz_alloc,			0x74),
-	CMN_EVENT_CCHA(pb_rhu_req_occ,			0x75),
-	CMN_EVENT_CCHA(pb_rhu_req_alloc,		0x76),
-	CMN_EVENT_CCHA(pb_rhu_pcie_req_occ,		0x77),
-	CMN_EVENT_CCHA(pb_rhu_pcie_req_alloc,		0x78),
-	CMN_EVENT_CCHA(pb_pcie_wr_req_occ,		0x79),
-	CMN_EVENT_CCHA(pb_pcie_wr_req_alloc,		0x7a),
-	CMN_EVENT_CCHA(pb_pcie_reg_req_occ,		0x7b),
-	CMN_EVENT_CCHA(pb_pcie_reg_req_alloc,		0x7c),
-	CMN_EVENT_CCHA(pb_pcie_rsvd_req_occ,		0x7d),
-	CMN_EVENT_CCHA(pb_pcie_rsvd_req_alloc,		0x7e),
-	CMN_EVENT_CCHA(pb_rhu_dat_occ,			0x7f),
-	CMN_EVENT_CCHA(pb_rhu_dat_alloc,		0x80),
-	CMN_EVENT_CCHA(pb_rhu_pcie_dat_occ,		0x81),
-	CMN_EVENT_CCHA(pb_rhu_pcie_dat_alloc,		0x82),
-	CMN_EVENT_CCHA(pb_pcie_wr_dat_occ,		0x83),
-	CMN_EVENT_CCHA(pb_pcie_wr_dat_alloc,		0x84),
+	CMN_EVENT_CCHA(CMN_ANY, rddatbyp,		0x61),
+	CMN_EVENT_CCHA(CMN_ANY, chirsp_up_stall,	0x62),
+	CMN_EVENT_CCHA(CMN_ANY, chidat_up_stall,	0x63),
+	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link0_stall,	0x64),
+	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link1_stall,	0x65),
+	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link2_stall,	0x66),
+	CMN_EVENT_CCHA(CMN_ANY, reqtrk_occ,		0x67),
+	CMN_EVENT_CCHA(CMN_ANY, rdb_occ,		0x68),
+	CMN_EVENT_CCHA(CMN_ANY, rdbyp_occ,		0x69),
+	CMN_EVENT_CCHA(CMN_ANY, wdb_occ,		0x6a),
+	CMN_EVENT_CCHA(CMN_ANY, snptrk_occ,		0x6b),
+	CMN_EVENT_CCHA(CMN_ANY, sdb_occ,		0x6c),
+	CMN_EVENT_CCHA(CMN_ANY, snphaz_occ,		0x6d),
+	CMN_EVENT_CCHA(CMN_ANY, reqtrk_alloc,		0x6e),
+	CMN_EVENT_CCHA(CMN_ANY, rdb_alloc,		0x6f),
+	CMN_EVENT_CCHA(CMN_ANY, rdbyp_alloc,		0x70),
+	CMN_EVENT_CCHA(CMN_ANY, wdb_alloc,		0x71),
+	CMN_EVENT_CCHA(CMN_ANY, snptrk_alloc,		0x72),
+	CMN_EVENT_CCHA(CMN_ANY, db_alloc,		0x73),
+	CMN_EVENT_CCHA(CMN_ANY, snphaz_alloc,		0x74),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_req_occ,		0x75),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_req_alloc,	0x76),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_req_occ,	0x77),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_req_alloc,	0x78),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_req_occ,	0x79),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_req_alloc,	0x7a),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_reg_req_occ,	0x7b),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_reg_req_alloc,	0x7c),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_rsvd_req_occ,	0x7d),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_rsvd_req_alloc,	0x7e),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_dat_occ,		0x7f),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_dat_alloc,	0x80),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_dat_occ,	0x81),
+	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_dat_alloc,	0x82),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_dat_occ,	0x83),
+	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_dat_alloc,	0x84),
+	CMN_EVENT_CCHA(CMNS3, chirsp1_up_stall,		0x85),
 
 	CMN_EVENT_CCLA(rx_cxs,				0x21),
 	CMN_EVENT_CCLA(tx_cxs,				0x22),
@@ -1779,7 +1799,8 @@ static int arm_cmn_event_init(struct perf_event *event)
 		/* ...but the DTM may depend on which port we're watching */
 		if (cmn->multi_dtm)
 			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
-	} else if (type == CMN_TYPE_XP && cmn->part == PART_CMN700) {
+	} else if (type == CMN_TYPE_XP &&
+		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
 		hw->wide_sel = true;
 	}
 
@@ -2266,7 +2287,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_23);
 	cmn->rev = FIELD_GET(CMN_CFGM_PID2_REVISION, reg);
 
+	/*
+	 * With the device isolation feature, if firmware has neglected to enable
+	 * an XP port then we risk locking up if we try to access anything behind
+	 * it; however we also have no way to tell from Non-Secure whether any
+	 * given port is disabled or not, so the only way to win is not to play...
+	 */
 	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
+	if (reg & CMN_INFO_DEVICE_ISO_ENABLE) {
+		dev_err(cmn->dev, "Device isolation enabled, not continuing due to risk of lockup\n");
+		return -ENODEV;
+	}
 	cmn->multi_dtm = reg & CMN_INFO_MULTIPLE_DTM_EN;
 	cmn->rsp_vc_num = FIELD_GET(CMN_INFO_RSP_VC_NUM, reg);
 	cmn->dat_vc_num = FIELD_GET(CMN_INFO_DAT_VC_NUM, reg);
@@ -2425,6 +2456,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CXLA:
 			case CMN_TYPE_HNS_MPAM_S:
 			case CMN_TYPE_HNS_MPAM_NS:
+			case CMN_TYPE_APB:
 				break;
 			/*
 			 * Split "optimised" combination nodes into separate
@@ -2610,6 +2642,7 @@ static const struct of_device_id arm_cmn_of_match[] = {
 	{ .compatible = "arm,cmn-600", .data = (void *)PART_CMN600 },
 	{ .compatible = "arm,cmn-650" },
 	{ .compatible = "arm,cmn-700" },
+	{ .compatible = "arm,cmn-s3" },
 	{ .compatible = "arm,ci-700" },
 	{}
 };
-- 
2.39.2.101.g768bb238c484.dirty


