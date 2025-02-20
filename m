Return-Path: <linux-kernel+bounces-523319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39DA3D513
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F93BBDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE541F12EA;
	Thu, 20 Feb 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ErKZYffj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A41F0E4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044539; cv=none; b=rD1xEQgHRcPQvqh18JNFtLGzUicx5XN9YKZn0bPMoL85+ssxlwk+gTOS6pXJ6L4vEbXujdIiLL2/5qrYHKBIor7IhVgKo+LRxv1kS9DEJaX9XxmsJhWDQp5e+J5WZjz7VkWUF3b+rZ2hsYcZeBGS/GUMW9XBO9xTEs0zAjOJdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044539; c=relaxed/simple;
	bh=4xpCXsw560jg661+9z67aa65t2gjEDVQA3Nb8Phphnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Zla1kK+K35wUS+nHCqFm1pI5M7TZBnMHXV4fsumUQdARHZm2rbLBQfYCtQkDZiAQtfA4nZoSUbLhxCHWZIK3jdy1/NkZD/TJFx64AUAKL8aPTrS6tKsTMy0IYn0nBNWpvlywPQHnOQRVxib9mXAwXDTLG+0//3QZ2TDAK9iB68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ErKZYffj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6MkEF022493;
	Thu, 20 Feb 2025 09:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyE9hYqgwJ+fwXKcYbnbNKN+dKoR1uUu7EJFvLAMv7w=; b=ErKZYffj6MYLS5nJ
	7mMs8ARqeJ5Djt6dtp82viBEo/OFAiwPqh3aUIooNj4wtfGJalIGK4tg3pYyQzxd
	ZUIGWg1CWhNqZ01cHjn0II044VkY4e+BFuSommZL53SsrA75zEnsls7vJ3GrGCU1
	eDFjnM0/w+x/2nxPHbSpKlidO6+ljZMGoBqZETf13qY0ScuQ6P0Kxm4Oscu+VjnR
	dtjvKHhZZpXi0Wka7kIyvTbyVyiSqkWCWvH9xQXzz14DVhn715U+GGTQSmA4u3IO
	Z7iSxuU8KWYAlVXyZjqzwNUDIZvRhZjLLdiksAvxHb3rauYm90hb0SSdJGGycGfr
	+Ka0yQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3nqwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9g6a7006128
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:06 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:42:01 -0800
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Date: Thu, 20 Feb 2025 17:41:23 +0800
Subject: [PATCH 3/5] coresight-tnoc: add nodes to configure flush
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250220-trace-noc-driver-v1-3-15d78bd48e12@quicinc.com>
References: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
In-Reply-To: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740044514; l=3878;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=4xpCXsw560jg661+9z67aa65t2gjEDVQA3Nb8Phphnc=;
 b=uOzxLRvex8Zd5KHr2UE9SQGZ/OHJhbBj88bqDb0Hhz2orG6eGlHSPGlO/K1yuxM1ZxnivzLja
 ewe2A07pdMLAR8LgltRYg9OiSdjNB1I6149atv2uo79546lb5F3P7Uj
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UPNWhsCoj6tvrlSx9TxUtJZZunB1TKYS
X-Proofpoint-ORIG-GUID: UPNWhsCoj6tvrlSx9TxUtJZZunB1TKYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200070

Two nodes for configure flush are added here:
1. flush_req: write 1 to initiates a flush sequence.

2. flush_state: read this node to get flush status. 0: sequence in
progress; 1: sequence has been completed.

Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 73 ++++++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tnoc.h |  4 ++
 2 files changed, 77 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 11b9a7fd1efdc9fff7c1e9666bda14acb41786cb..25962af3850af106f7a8b7e1738ad93d44b81ee7 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -16,6 +16,78 @@
 #include "coresight-tnoc.h"
 #include "coresight-trace-id.h"
 
+static ssize_t flush_req_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t size)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct coresight_device	*csdev = drvdata->csdev;
+	unsigned long val;
+	u32 reg;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (csdev->refcnt == 0) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	reg = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
+	reg = reg | TRACE_NOC_CTRL_FLUSHREQ;
+	writel_relaxed(reg, drvdata->base + TRACE_NOC_CTRL);
+
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(flush_req);
+
+/*
+ * flush-sequence status:
+ * value 0: sequence in progress;
+ * value 1: sequence has been completed.
+ */
+static ssize_t flush_status_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct coresight_device	*csdev = drvdata->csdev;
+	u32 val;
+
+	spin_lock(&drvdata->spinlock);
+	if (csdev->refcnt == 0) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	val = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
+	spin_unlock(&drvdata->spinlock);
+	return sysfs_emit(buf, "%u\n", BMVAL(val, 2, 2));
+}
+static DEVICE_ATTR_RO(flush_status);
+
+static struct attribute *trace_noc_attrs[] = {
+	&dev_attr_flush_req.attr,
+	&dev_attr_flush_status.attr,
+	NULL,
+};
+
+static struct attribute_group trace_noc_attr_grp = {
+	.attrs = trace_noc_attrs,
+};
+
+static const struct attribute_group *trace_noc_attr_grps[] = {
+	&trace_noc_attr_grp,
+	NULL,
+};
+
 static void trace_noc_enable_hw(struct trace_noc_drvdata *drvdata)
 {
 	u32 val;
@@ -142,6 +214,7 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
 		return ret;
 
 	desc.ops = &trace_noc_cs_ops;
+	desc.groups = trace_noc_attr_grps;
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.pdata = adev->dev.platform_data;
diff --git a/drivers/hwtracing/coresight/coresight-tnoc.h b/drivers/hwtracing/coresight/coresight-tnoc.h
index b6bd1ef659897d8e0994c5e8514e8cbdd16eebd8..d0fe8f52709ff4147d66dbf90987595012cfaa4e 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.h
+++ b/drivers/hwtracing/coresight/coresight-tnoc.h
@@ -10,6 +10,10 @@
 
 /* Enable generation of output ATB traffic.*/
 #define TRACE_NOC_CTRL_PORTEN	BIT(0)
+/* Writing 1 to initiate a flush sequence.*/
+#define TRACE_NOC_CTRL_FLUSHREQ	BIT(1)
+/* 0: sequence in progress; 1: sequence has been completed.*/
+#define TRACE_NOC_CTRL_FLUSHSTATUS	BIT(2)
 /* Writing 1 to issue a FREQ or FREQ_TS packet*/
 #define TRACE_NOC_CTRL_FREQTSREQ	BIT(5)
 /* Sets the type of issued ATB FLAG packets. 0: 'FLAG' packets; 1: 'FLAG_TS' packets.*/

-- 
2.34.1


