Return-Path: <linux-kernel+bounces-185063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96348CB00C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4492BB21C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B64D7F7C3;
	Tue, 21 May 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRf7c/mA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EB7F48C;
	Tue, 21 May 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300484; cv=none; b=qpNsJ+RQHjIMJ9fY9ZVT1R1iFgMDWta5AFWcr/RqUvZ103pxDlvXDe+WYpvwGRJfOB48Hmp/+XrDjFlZqhlh8rvrRvPt9vpwQkTJVeTmQE8mJa6RZO7G2xWt6CEwvzFDJnTtuUG4vPDWp6fkdYceaO8lGv47a9Gl4gb2RLFq/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300484; c=relaxed/simple;
	bh=tRs3Xc3i+74zhh0Ksrv2C+PgqwtmV5gpBRlD2RbhUis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJ28bhGaVHlvLFQ7r5LoXyIykuKMPdczas6ZOFAfam8d52XPBV481YkfewjWMXmAKuutCO1rdDrC/67IPrJ9L65unLxSG8ptN30AB84MwQWM3YK9MLg24JWBUCDKxXnU8D6YF2lpQHkJ6hlJ2MMh6MsuWyOnadcozBW84+hiKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRf7c/mA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716300482; x=1747836482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tRs3Xc3i+74zhh0Ksrv2C+PgqwtmV5gpBRlD2RbhUis=;
  b=lRf7c/mA5e20C/QIfS7AFVKZCIKMZQdeAEZ0BGuTeUTzvsxCqxi+GtEF
   FZ18AOEAk47ZGw/NRCvu0oOFzqoqHyLPrvexnsDf/Oiw6REL5hkNrl5br
   iIQqgem/n7mO4AYwogv/vMKxprQB7lJ9r3eHNmr2o/85TjfAEFTu/HE3N
   s3Jdxlb1HJGekhOS9XVY6TuGosVugm/yXtO6TuJhFpPLPD+9iUWxOoFIX
   jZUzpeE0dmZStPws8ARe33QZFYj51JB7H+5GcPIbKK37x1h66axsF5eGk
   sdbzQKMx4F5Ro8raBAnzSYGe6zlWfDMsGxXA6Gogmep3CUxzWyH1cmgus
   g==;
X-CSE-ConnectionGUID: OpnEGWRyRjC9oIeUW7qrQQ==
X-CSE-MsgGUID: CQ1hmVJSR/KgsC4Fk1wOdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12288021"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12288021"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:08:01 -0700
X-CSE-ConnectionGUID: Egn6sZOnRNaHLxP1HXoXZA==
X-CSE-MsgGUID: fk/Q2vykRby0dZWSBRpCDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33487386"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 07:07:58 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v4] cxl/events: Use a common struct for DRAM and General Media events
Date: Tue, 21 May 2024 16:05:08 +0200
Message-ID: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_event_common was an unfortunate naming choice and caused confusion with
the existing Common Event Record. Furthermore, its fields didn't map all
the common information between DRAM and General Media Events.

Remove cxl_event_common and introduce cxl_event_media_hdr to record common
information between DRAM and General Media events.

cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
cxl_event_dram, leverages the commonalities between the two events to
simplify their respective handling.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

- Changes for v4 -

	- Initialise cxl_test_dram and cxl_test_gen_media without 
	  unnecessary extra de-references (Dan)
	- Add a comment for media_hdr in union cxl_event (Alison)

- Changes for v3 -

	- Rework the layout of cxl_event_dram and cxl_event_gen_media to
	  make a simpler change (Dan)
	- Remove a "Fixes" tag (Dan)
	- Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
	- Rewrite end extend the commit message

- Link to v3 -

https://lore.kernel.org/linux-cxl/20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com/

 drivers/cxl/core/mbox.c      |  2 +-
 drivers/cxl/core/trace.h     | 32 ++++++++++-----------
 include/linux/cxl-event.h    | 41 ++++++++++-----------------
 tools/testing/cxl/test/mem.c | 54 +++++++++++++++++++-----------------
 4 files changed, 61 insertions(+), 68 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2626f3fff201..a08f050cc1ca 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -875,7 +875,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		guard(rwsem_read)(&cxl_region_rwsem);
 		guard(rwsem_read)(&cxl_dpa_rwsem);
 
-		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
+		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
 		if (cxlr)
 			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 07a0394b1d99..5a76f94accf4 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -340,23 +340,23 @@ TRACE_EVENT(cxl_general_media,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->media_hdr.hdr);
 		__entry->hdr_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 
 		/* General Media */
-		__entry->dpa = le64_to_cpu(rec->phys_addr);
+		__entry->dpa = le64_to_cpu(rec->media_hdr.phys_addr);
 		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
 		/* Mask after flags have been parsed */
 		__entry->dpa &= CXL_DPA_MASK;
-		__entry->descriptor = rec->descriptor;
-		__entry->type = rec->type;
-		__entry->transaction_type = rec->transaction_type;
-		__entry->channel = rec->channel;
-		__entry->rank = rec->rank;
+		__entry->descriptor = rec->media_hdr.descriptor;
+		__entry->type = rec->media_hdr.type;
+		__entry->transaction_type = rec->media_hdr.transaction_type;
+		__entry->channel = rec->media_hdr.channel;
+		__entry->rank = rec->media_hdr.rank;
 		__entry->device = get_unaligned_le24(rec->device);
 		memcpy(__entry->comp_id, &rec->component_id,
 			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
-		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+		__entry->validity_flags = get_unaligned_le16(&rec->media_hdr.validity_flags);
 		__entry->hpa = hpa;
 		if (cxlr) {
 			__assign_str(region_name, dev_name(&cxlr->dev));
@@ -440,19 +440,19 @@ TRACE_EVENT(cxl_dram,
 	),
 
 	TP_fast_assign(
-		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
+		CXL_EVT_TP_fast_assign(cxlmd, log, rec->media_hdr.hdr);
 		__entry->hdr_uuid = CXL_EVENT_DRAM_UUID;
 
 		/* DRAM */
-		__entry->dpa = le64_to_cpu(rec->phys_addr);
+		__entry->dpa = le64_to_cpu(rec->media_hdr.phys_addr);
 		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
 		__entry->dpa &= CXL_DPA_MASK;
-		__entry->descriptor = rec->descriptor;
-		__entry->type = rec->type;
-		__entry->transaction_type = rec->transaction_type;
-		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
-		__entry->channel = rec->channel;
-		__entry->rank = rec->rank;
+		__entry->descriptor = rec->media_hdr.descriptor;
+		__entry->type = rec->media_hdr.type;
+		__entry->transaction_type = rec->media_hdr.transaction_type;
+		__entry->validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
+		__entry->channel = rec->media_hdr.channel;
+		__entry->rank = rec->media_hdr.rank;
 		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
 		__entry->bank_group = rec->bank_group;
 		__entry->bank = rec->bank;
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 60b25020281f..1119d0bbb091 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -21,6 +21,17 @@ struct cxl_event_record_hdr {
 	u8 reserved[15];
 } __packed;
 
+struct cxl_event_media_hdr {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+} __packed;
+
 #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
 struct cxl_event_generic {
 	struct cxl_event_record_hdr hdr;
@@ -33,14 +44,7 @@ struct cxl_event_generic {
  */
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
 struct cxl_event_gen_media {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
+	struct cxl_event_media_hdr media_hdr;
 	u8 device[3];
 	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
 	u8 reserved[46];
@@ -52,14 +56,7 @@ struct cxl_event_gen_media {
  */
 #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
 struct cxl_event_dram {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-	u8 descriptor;
-	u8 type;
-	u8 transaction_type;
-	u8 validity_flags[2];
-	u8 channel;
-	u8 rank;
+	struct cxl_event_media_hdr media_hdr;
 	u8 nibble_mask[3];
 	u8 bank_group;
 	u8 bank;
@@ -95,21 +92,13 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
-/*
- * General Media or DRAM Event Common Fields
- * - provides common access to phys_addr
- */
-struct cxl_event_common {
-	struct cxl_event_record_hdr hdr;
-	__le64 phys_addr;
-} __packed;
-
 union cxl_event {
 	struct cxl_event_generic generic;
 	struct cxl_event_gen_media gen_media;
 	struct cxl_event_dram dram;
 	struct cxl_event_mem_module mem_module;
-	struct cxl_event_common common;
+	/* dram & gen_media event header */
+	struct cxl_event_media_hdr media_hdr;
 } __packed;
 
 /*
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 6584443144de..142333e63cdf 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -384,19 +384,21 @@ struct cxl_test_gen_media {
 struct cxl_test_gen_media gen_media = {
 	.id = CXL_EVENT_GEN_MEDIA_UUID,
 	.rec = {
-		.hdr = {
-			.length = sizeof(struct cxl_test_gen_media),
-			.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
-			/* .handle = Set dynamically */
-			.related_handle = cpu_to_le16(0),
+		.media_hdr = {
+			.hdr = {
+				.length = sizeof(struct cxl_test_gen_media),
+				.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+				/* .handle = Set dynamically */
+				.related_handle = cpu_to_le16(0),
+			},
+			.phys_addr = cpu_to_le64(0x2000),
+			.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+			.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+			.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+			/* .validity_flags = <set below> */
+			.channel = 1,
+			.rank = 30,
 		},
-		.phys_addr = cpu_to_le64(0x2000),
-		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
-		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
-		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
-		/* .validity_flags = <set below> */
-		.channel = 1,
-		.rank = 30
 	},
 };
 
@@ -408,18 +410,20 @@ struct cxl_test_dram {
 struct cxl_test_dram dram = {
 	.id = CXL_EVENT_DRAM_UUID,
 	.rec = {
-		.hdr = {
-			.length = sizeof(struct cxl_test_dram),
-			.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
-			/* .handle = Set dynamically */
-			.related_handle = cpu_to_le16(0),
+		.media_hdr = {
+			.hdr = {
+				.length = sizeof(struct cxl_test_dram),
+				.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+				/* .handle = Set dynamically */
+				.related_handle = cpu_to_le16(0),
+			},
+			.phys_addr = cpu_to_le64(0x8000),
+			.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+			.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+			.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+			/* .validity_flags = <set below> */
+			.channel = 1,
 		},
-		.phys_addr = cpu_to_le64(0x8000),
-		.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
-		.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
-		.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
-		/* .validity_flags = <set below> */
-		.channel = 1,
 		.bank_group = 5,
 		.bank = 2,
 		.column = {0xDE, 0xAD},
@@ -473,11 +477,11 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
-			   &gen_media.rec.validity_flags);
+			   &gen_media.rec.media_hdr.validity_flags);
 
 	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
 			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
-			   &dram.rec.validity_flags);
+			   &dram.rec.media_hdr.validity_flags);
 
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
-- 
2.45.1


