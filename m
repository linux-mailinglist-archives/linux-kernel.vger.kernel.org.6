Return-Path: <linux-kernel+bounces-201978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2C8FC613
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AEDB24656
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C318FC93;
	Wed,  5 Jun 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lHou2wMJ"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CAA18FC73;
	Wed,  5 Jun 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575492; cv=none; b=U26+BIR/sIof/dnR3KUXCUWRwhi3MNfA/VTNy0Ed0PZ099k7HCa8MCFUuJ6kPZlLhTKVLzDqKxfbTOkiAISupfAxmK/A2iXgHxH178PKLnmkv48B3emYQhe5yNflVTw460MeqjE97T3xy1UtnYg1c4KLkc26+DZu+edZ4VYNHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575492; c=relaxed/simple;
	bh=T1jNIimVvsNXToVe+C7OSqugb5fDRJsa8cix4PcvxFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9DOwo9DnmjW8FINTYUp1AAPcpoJ1ptb0BxMsc1YDintEzuW52QwWUIzNSLccGtumqSAUcGwTKiwTlt2WiOFT8A08Yau0p5Wp6HKw1OlpJh4DZBGCsLCDF54txZHPsPfiTOEsbaYtorhaAP551puXLx5hwGdjoViIwBURb1czWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lHou2wMJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4554rxtv013268;
	Wed, 5 Jun 2024 01:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	9VVWICHZY5iZTSdEFRzo0dPB84R3sF5ECSXEN0geOM=; b=lHou2wMJfW8qYjYtL
	a2dcCuFSbjLMy8JHTWU605oWhNRO92yMcQXuCxGw4ihtLz4De94MvaAHfhp4tPml
	plGnJu+wDbbZV9bazVLH7BdiNPiKVpa9O/3bk6NCClT7bYhbHmwFX5tOZrBnSzIb
	0Isl5yP95MECpy6ivLDAeo/jtBIrNR1vgngA831F6WcsPLEjqDesH3r2xVrQkKST
	WO0QE2odwZuiUiA6D/1yuCrfpUetBDEeLih0oYB7gU6NMnOEg7x/vgxIAQHZ94OA
	ovqiJHJsOV2kQBfIpwD4brJETsykEiwxmw+RSS5N/S9uf3rEldbV4+Qw5q+wMcnK
	NrYKA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yjhd1gjc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 01:17:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 5 Jun 2024 01:17:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 5 Jun 2024 01:17:54 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 8CA533F706A;
	Wed,  5 Jun 2024 01:17:50 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v9 3/7] coresight: core: Add provision for panic callbacks
Date: Wed, 5 Jun 2024 13:47:21 +0530
Message-ID: <20240605081725.622953-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605081725.622953-1-lcherian@marvell.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lI2gk7hfc3MNsIuirRIi_ui1_8HosW0l
X-Proofpoint-GUID: lI2gk7hfc3MNsIuirRIi_ui1_8HosW0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Panic callback handlers allows coresight device drivers to sync
relevant trace data and trace metadata to reserved memory
regions so that they can be retrieved later in the subsequent
boot or in the crashdump kernel.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
Changelog from v8:
Added Reviewed-by tag.

 drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++++++++
 include/linux/coresight.h                    | 12 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fc6f6b863e0..c30b9f00d77b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -19,6 +19,7 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/panic_notifier.h>
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
@@ -1365,6 +1366,36 @@ const struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
+static int coresight_panic_sync(struct device *dev, void *data)
+{
+	int mode;
+	struct coresight_device *csdev;
+
+	/* Run through panic sync handlers for all enabled devices */
+	csdev = container_of(dev, struct coresight_device, dev);
+	mode = coresight_get_mode(csdev);
+
+	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
+		if (panic_ops(csdev))
+			panic_ops(csdev)->sync(csdev);
+	}
+
+	return 0;
+}
+
+static int coresight_panic_cb(struct notifier_block *self,
+			       unsigned long v, void *p)
+{
+	bus_for_each_dev(&coresight_bustype, NULL, NULL,
+				 coresight_panic_sync);
+
+	return 0;
+}
+
+static struct notifier_block coresight_notifier = {
+	.notifier_call = coresight_panic_cb,
+};
+
 static int __init coresight_init(void)
 {
 	int ret;
@@ -1377,6 +1408,10 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* Register function to be called for panic */
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &coresight_notifier);
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
@@ -1391,6 +1426,8 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f09ace92176e..6aa54cdb66a2 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -316,6 +316,7 @@ enum cs_mode {
 #define link_ops(csdev)		csdev->ops->link_ops
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
+#define panic_ops(csdev)	csdev->ops->panic_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -385,11 +386,22 @@ struct coresight_ops_helper {
 	int (*disable)(struct coresight_device *csdev, void *data);
 };
 
+
+/**
+ * struct coresight_ops_panic - Generic device ops for panic handing
+ *
+ * @sync	: Sync the device register state/trace data
+ */
+struct coresight_ops_panic {
+	int (*sync)(struct coresight_device *csdev);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
+	const struct coresight_ops_panic *panic_ops;
 };
 
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
-- 
2.34.1


