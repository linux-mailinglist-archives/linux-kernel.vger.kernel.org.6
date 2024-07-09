Return-Path: <linux-kernel+bounces-245850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35A92BA73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43761F214FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFB015FA67;
	Tue,  9 Jul 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCCCS8KB"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BC15F3E8;
	Tue,  9 Jul 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530257; cv=none; b=Nuqg0dEoFpBbq5ADvCboCjhA78pmxC6z9VICe587A08DJf4pO2ao48c2OzpXBZ0LN8Neuj+oHoanObcD9kI4vovjfy37PXi3GIaEQD1RN0F4eHVzsohxDpFMaLSTZYSkK2s0DnO6E/fFt+N+7J1E8QTXTnKHfH4cUDQygliAuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530257; c=relaxed/simple;
	bh=3AqQ6rQbpTCvoAvcKGmJOdgsZSrhu1/nQOnM8PzJYa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqRkmw/boKg/qft5hKqxKODHBRk6uqxFnPNsGJnf2MnBLpSLQq/XphqQSzalkZIExCDNBf17qKV5Qk6cLazjQECgvANOPYnRoHBxLz5h3WaBCW5aby369uxnPhlAowBR3+nc1DUcJwxx+wN63qN8InFUoF3q2y7my/r9Wytuxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCCCS8KB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRCjIxxlVUsZSRY4Vf+rUKFCfBfbcJNcq5M4wid/7sU=;
	b=RCCCS8KBfUSfQW8acoRakZWci/X0yneda1Zaacwl8UweCKvjItcLUIhm3i5wa/2a4jMAcp
	ZjoiAsdv1FeizyMK/sPXkC/ndX0cKYldnhZsRJhS1Pmr5ukbCkm5hOHrRycwManoVrtiZN
	5ox7plCXf8pg+Oj8omEDP4ZrmXyXuqo=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 3/7] cbd: introduce cbd_segment
Date: Tue,  9 Jul 2024 13:03:39 +0000
Message-Id: <20240709130343.858363-4-dongsheng.yang@linux.dev>
In-Reply-To: <20240709130343.858363-1-dongsheng.yang@linux.dev>
References: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The `cbd_segments` is an abstraction of the data area in transport. The
data area in transport is divided into segments.

The specific use of this area is determined by `cbd_seg_type`. For example,
`cbd_blkdev` and `cbd_backend` data transfers
need to access a segment of the type `cbds_type_channel`.

The segment also allows for more scenarios and more segment types to be expanded.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_segment.c | 108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_segment.c

diff --git a/drivers/block/cbd/cbd_segment.c b/drivers/block/cbd/cbd_segment.c
new file mode 100644
index 000000000000..855bfa473b4c
--- /dev/null
+++ b/drivers/block/cbd/cbd_segment.c
@@ -0,0 +1,108 @@
+#include "cbd_internal.h"
+
+static ssize_t cbd_seg_detail_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct cbd_segment_device *segment;
+	struct cbd_segment_info *segment_info;
+
+	segment = container_of(dev, struct cbd_segment_device, dev);
+	segment_info = segment->segment_info;
+
+	if (segment_info->state == cbd_segment_state_none)
+		return 0;
+
+	if (segment_info->type == cbds_type_channel)
+		return cbd_channel_seg_detail_show((struct cbd_channel_info *)segment_info, buf);
+
+	return 0;
+}
+
+static ssize_t cbd_seg_type_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cbd_segment_device *segment;
+	struct cbd_segment_info *segment_info;
+
+	segment = container_of(dev, struct cbd_segment_device, dev);
+	segment_info = segment->segment_info;
+
+	if (segment_info->state == cbd_segment_state_none)
+		return 0;
+
+	return sprintf(buf, "%s\n", cbds_type_str(segment_info->type));
+}
+
+static DEVICE_ATTR(detail, 0400, cbd_seg_detail_show, NULL);
+static DEVICE_ATTR(type, 0400, cbd_seg_type_show, NULL);
+
+CBD_OBJ_HEARTBEAT(segment);
+
+static struct attribute *cbd_segment_attrs[] = {
+	&dev_attr_detail.attr,
+	&dev_attr_type.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_segment_attr_group = {
+	.attrs = cbd_segment_attrs,
+};
+
+static const struct attribute_group *cbd_segment_attr_groups[] = {
+	&cbd_segment_attr_group,
+	NULL
+};
+
+static void cbd_segment_release(struct device *dev)
+{
+}
+
+const struct device_type cbd_segment_type = {
+	.name		= "cbd_segment",
+	.groups		= cbd_segment_attr_groups,
+	.release	= cbd_segment_release,
+};
+
+const struct device_type cbd_segments_type = {
+	.name		= "cbd_segments",
+	.release	= cbd_segment_release,
+};
+
+void cbd_segment_init(struct cbd_segment *segment, struct cbd_transport *cbdt, u32 seg_id)
+{
+	struct cbd_segment_info *segment_info = cbdt_get_segment_info(cbdt, seg_id);
+
+	segment->cbdt = cbdt;
+	segment->segment_info = segment_info;
+	segment->seg_id = seg_id;
+
+	segment_info->state = cbd_segment_state_running;
+
+	INIT_DELAYED_WORK(&segment->hb_work, segment_hb_workfn);
+	queue_delayed_work(cbd_wq, &segment->hb_work, 0);
+}
+
+void cbd_segment_exit(struct cbd_segment *segment)
+{
+	cancel_delayed_work_sync(&segment->hb_work);
+
+	segment->segment_info->state = cbd_segment_state_none;
+}
+
+int cbd_segment_clear(struct cbd_transport *cbdt, u32 seg_id)
+{
+	struct cbd_segment_info *segment_info;
+
+	segment_info = cbdt_get_segment_info(cbdt, seg_id);
+	if (cbd_segment_info_is_alive(segment_info)) {
+		cbdt_err(cbdt, "segment %u is still alive\n", seg_id);
+		return -EBUSY;
+	}
+
+	cbdt_zero_range(cbdt, segment_info, CBDT_SEG_SIZE);
+
+	return 0;
+}
-- 
2.34.1


