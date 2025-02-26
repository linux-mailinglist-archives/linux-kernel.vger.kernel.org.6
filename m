Return-Path: <linux-kernel+bounces-533616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C741A45CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BD57A782C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D51A08A4;
	Wed, 26 Feb 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MsWjkChb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498A213E63;
	Wed, 26 Feb 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568014; cv=none; b=LmmlbVnAVEP5rXXXrpvg9v5Xwygs3EOhElr91PXddpi0BjNkZRVSwiFDXeTWZYW3uZnAoOlA76wvaIwPKweMlf5FyLiEEyw4HHA4jjc8TDoMuGuyIYZH2RGTFpKSvSAQWvTDBh0bahwbkL2/sm4vVi9nf4rDDLALMQ+o7tFwA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568014; c=relaxed/simple;
	bh=eMP4dVcf6TBARmAN2VHv8KKSRKhmUUMlpK2P04AEDf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kTZMAsQAceR2DDB+AF9LMac/jhLj74etUiUBhr0R8fJDJhvIrMPzabALJ9uFlqbgCaHSdcYUwGUy+XYst900YNUMagPPD5KGs7+koOe7t/FYO6zInU5RQA3zMqasDOLkD6UD0ymuLZesSUT5vrdM/NlCepe1IwRe7QBy2Pb1tao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MsWjkChb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9rKp7025767;
	Wed, 26 Feb 2025 11:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yPZfaLoaDBeJ/1iE3r6S9VZ8m7Tyn0Rz3khqWZ08eYc=; b=MsWjkChbyXJCGIex
	Ure3D9mFKSz//XRo0Tz5WUvXbOa50BgTEOofC8SWIrqnqQ43S2dXxosqYMrBlOs+
	EOHREOsyg5AEkkQTJPowo97qM27WiwBbx1KP7mkKaxiNZqLGzOhW+86/n0rCxBf6
	SGjXgcs9LySjrtHO6dp1RTEhgHeCsAfuRw1YQVHXtP868O8LyqomlRnDSVA37K+w
	Vjg1Ev2xNW06tt87cXO3wP86SJQg3BfRhCIUdgMF7jmV5bdxbAe9kMOj7dGARWDo
	IuHBkT/HvVe2qfm+V8xCFViHnll9tB/C/6UcBk/e/Yj0JzDLg5fVtgWKJgUuo36/
	YBaqZg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmhqrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:06:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QB6bcX013117
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:06:37 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Feb 2025 03:06:31 -0800
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Date: Wed, 26 Feb 2025 19:05:54 +0800
Subject: [PATCH v2 5/5] coresight-tnoc: add nodes to configure freq packet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250226-trace-noc-driver-v2-5-8afc6584afc5@quicinc.com>
References: <20250226-trace-noc-driver-v2-0-8afc6584afc5@quicinc.com>
In-Reply-To: <20250226-trace-noc-driver-v2-0-8afc6584afc5@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@oss.qualcomm.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740567972; l=3505;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=eMP4dVcf6TBARmAN2VHv8KKSRKhmUUMlpK2P04AEDf8=;
 b=KajF8tNVEbsS6z2G5qwonkX+NmN940K1wN8uf+f4ZPRs++UQcx1oy0NzT9d6ot9Cd1BxXCY0J
 SGuuSJag4MUC0jydKl63M4z35nAs9angFkCSuEY0vfhHYkGsprFWgVn
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qoXj96ZHDZLGuxOtsz3RLrNhIWPn7gDi
X-Proofpoint-ORIG-GUID: qoXj96ZHDZLGuxOtsz3RLrNhIWPn7gDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260088

Three nodes for freq packet config are added here:

1. freq_type: used to set the type of issued ATB FREQ packets.
0: 'FREQ' packets; 1: 'FREQ_TS' packets.

2. freq_req_val: used to set frequency values carried by 'FREQ'
and 'FREQ_TS' packets.

3. freq_ts_req: writing '1' to issue a 'FREQ' or 'FREQ_TS' packet.

Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 97 ++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index ad973749250644760adc4dfd855240026d0a744c..24b1add4c921866b944d756e563d50b4172d583a 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -112,10 +112,107 @@ static ssize_t flag_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(flag_type);
 
+static ssize_t freq_type_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", drvdata->freq_type);
+}
+
+static ssize_t freq_type_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t size)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->freq_type = FREQ_TS;
+	else
+		drvdata->freq_type = FREQ;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(freq_type);
+
+static ssize_t freq_req_val_show(struct device *dev,
+				 struct device_attribute *attr,
+				char *buf)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", drvdata->freq_req_val);
+}
+
+static ssize_t freq_req_val_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val) {
+		spin_lock(&drvdata->spinlock);
+		drvdata->freq_req_val = val;
+		spin_unlock(&drvdata->spinlock);
+	}
+
+	return size;
+}
+static DEVICE_ATTR_RW(freq_req_val);
+
+static ssize_t freq_ts_req_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct coresight_device	*csdev = drvdata->csdev;
+	unsigned long val;
+	u32 reg;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (csdev->refcnt == 0) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	if (val) {
+		reg = readl_relaxed(drvdata->base + TRACE_NOC_CTRL);
+		reg = reg | TRACE_NOC_CTRL_FREQTSREQ;
+		writel_relaxed(reg, drvdata->base + TRACE_NOC_CTRL);
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(freq_ts_req);
+
 static struct attribute *trace_noc_attrs[] = {
 	&dev_attr_flush_req.attr,
 	&dev_attr_flush_status.attr,
 	&dev_attr_flag_type.attr,
+	&dev_attr_freq_type.attr,
+	&dev_attr_freq_req_val.attr,
+	&dev_attr_freq_ts_req.attr,
 	NULL,
 };
 

-- 
2.34.1


