Return-Path: <linux-kernel+bounces-368438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFC9A0FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24105B225AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F329210C01;
	Wed, 16 Oct 2024 16:34:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8F18595F;
	Wed, 16 Oct 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096464; cv=none; b=NGqsu1ghpoUuGvLvHhgRubFxTYLmC0QTKeD0kY23yLshTEI0JT1aULyFbhH4eBcfu0g1lWBlq64rENOH49rwkmDziKZ1fFvQkOebArwQy8ZIxUohVdNpzEZWqq27EfJbeKiVnKkCvbXzhuCoi4F8qu3w9kiAdouRQkKkzeLIxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096464; c=relaxed/simple;
	bh=CybjSsK2ttQSpxaGXY44oKM7FjwDzJW9ttjmGxFi5U8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or7PT599SEyCXphB+CuL1DGQQ61fbjh1qUO7zKjfnOGnmnN8BgLnj63nh/xPVwC52JNPqK6qVRWN/2gXsTFkv4OLgl2mlos+MrmUD17bZ2RZx1ZVvDqv3SlHd0TJcARQHtydZrGg3cM9Hh5EpIcXfQ6cIwiKcjN3H+K2z5zhRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGkF6dvZz6J9Tw;
	Thu, 17 Oct 2024 00:33:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A9C5E1400DB;
	Thu, 17 Oct 2024 00:34:19 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.191) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 18:34:18 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/4] cxl/events: Updates for CXL Common Event Record Format
Date: Wed, 16 Oct 2024 17:33:46 +0100
Message-ID: <20241016163349.1210-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241016163349.1210-1-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
updated with Maintenance Operation Subclass information.

Add updates for the above spec change in the CXL events record and CXL
common trace event implementations.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 13 +++++++++----
 include/cxl/event.h      |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 8389a94adb1a..7305974e2301 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -166,11 +166,13 @@ TRACE_EVENT(cxl_overflow,
 #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
 #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
 #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+#define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
 #define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
 	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
 	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
 	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
-	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
+	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	},  \
+	{ CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID,	"MAINT_OP_SUB_CLASS_VALID" }	\
 )
 
 /*
@@ -197,7 +199,8 @@ TRACE_EVENT(cxl_overflow,
 	__field(u16, hdr_related_handle)			\
 	__field(u64, hdr_timestamp)				\
 	__field(u8, hdr_length)					\
-	__field(u8, hdr_maint_op_class)
+	__field(u8, hdr_maint_op_class)				\
+	__field(u8, hdr_maint_op_sub_class)
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev);				\
@@ -209,17 +212,19 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
 	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
 	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
-	__entry->hdr_maint_op_class = (hdr).maint_op_class
+	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
+	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
 	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
 		"len=%d flags='%s' handle=%x related_handle=%x "		\
-		"maint_op_class=%u : " fmt,					\
+		"maint_op_class=%u maint_op_sub_class=%u : " fmt,		\
 		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
+		__entry->hdr_maint_op_sub_class,	\
 		##__VA_ARGS__)
 
 TRACE_EVENT(cxl_generic_event,
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 0bea1afbd747..e1d485ad376b 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -18,7 +18,8 @@ struct cxl_event_record_hdr {
 	__le16 related_handle;
 	__le64 timestamp;
 	u8 maint_op_class;
-	u8 reserved[15];
+	u8 maint_op_sub_class;
+	u8 reserved[14];
 } __packed;
 
 struct cxl_event_media_hdr {
-- 
2.34.1


