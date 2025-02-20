Return-Path: <linux-kernel+bounces-523320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F0A3D505
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6687A97A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41141F12FF;
	Thu, 20 Feb 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNsLARMk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3C1F12E7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044541; cv=none; b=BMENT10LSoEQI5HN9SQymw9CU4y/VdhOHlwIx0/R2MVBVSfdReNX0l7lFkS6eANgWYrrdzMAxzMHGE89ZfqVfnw6eeE1ovdiqvVOdX2TLbxZ98IYh3S8dm57lg1MUaSYsESem0a38WcuqkPHhhIRgQOmu5hEQkiuP/s0/bBEMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044541; c=relaxed/simple;
	bh=XbTCKvIMDyl2DMpRiyDboA4ABVpbG+2OBuCevF1YKhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WnnS3azTB37wJ0BTqX50b6qBEArf+rFgXtNk2SLIuK28Hpu7uIBkEwzsELsrSYW2EfKE//YMlflpsd6tRdTHVJKgGRuplvaQd4VyX2p9cX+UJVl6uxEDCphFQcRSxFzml52aVOxBNzOhORX9BLqz6C/oQTB4iCNsWLu8CR26tQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNsLARMk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K70UB1016821;
	Thu, 20 Feb 2025 09:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ARB5psRXmL5x7dm7O2B78qjvJCsCcFRky0xfe+WKbYI=; b=GNsLARMkkwQ6ikwq
	MRlsngqC/C7iulpf5qLTVJbV7MjLAvPzp3rJaM645tilCQ8nJrXKKkAi1fEsE62D
	l0mrcxHeJOmVBFxIUFNrtAZTtkCLA1oyfB4fnwTSClFWslecxcj2dLU34V6UiqR9
	6hAqxOR9Qbvw+qbSp3YYPaLzXDwpAkVFjdewjh58sXVF1f9h2hEfVrCXvBql48iO
	5JUpu7z1xkAEf4t5/Tjq0hK2CN8OPyc+FCeN8gMs+uxrR2y+vhCbOlM/BWRtjF09
	UmFlPtIiiYh6J+EvurjtqmqNLUDVeLMdlnbJgcaXx/+ma7pNT3GwXzVGci8rGVf/
	OuE3ww==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0dkgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9g9Mh015743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:09 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:42:04 -0800
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Date: Thu, 20 Feb 2025 17:41:24 +0800
Subject: [PATCH 4/5] coresight-tnoc: add node to configure flag type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250220-trace-noc-driver-v1-4-15d78bd48e12@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740044514; l=2045;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=XbTCKvIMDyl2DMpRiyDboA4ABVpbG+2OBuCevF1YKhI=;
 b=Pqu1/3bbvFLUYjPvJZO5lWaJKO3UxVsRxm5FRBy/v11wJCsNnVjFVEza1AOLl89N6DJFrQ6kR
 CJSVyYpgEgPD3JGs3zsSfiXUyc/skejDe8T2qZYTCSeXzsjhSLZBsXr
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aZgUy1ru-dBazPNIbWun75JTrcoi3lnP
X-Proofpoint-ORIG-GUID: aZgUy1ru-dBazPNIbWun75JTrcoi3lnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=889 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200070

flag_type：used to set the type of issued ATB FLAG packets.
0: 'FLAG' packets; 1: 'FLAG_TS' packets.

Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 42 +++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 25962af3850af106f7a8b7e1738ad93d44b81ee7..3ff3504603f66bd595484374f1cdac90c528b665 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -26,7 +26,7 @@ static ssize_t flush_req_store(struct device *dev,
 	unsigned long val;
 	u32 reg;
 
-	if (kstrtoul(buf, 10, &val))
+	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val != 1)
@@ -73,9 +73,49 @@ static ssize_t flush_status_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(flush_status);
 
+/*
+ * Sets the type of issued ATB FLAG packets:
+ * 0: 'FLAG' packets;
+ * 1: 'FLAG_TS' packets.
+ */
+static ssize_t flag_type_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t size)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val != 1 && val != 0)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val)
+		drvdata->flag_type = FLAG_TS;
+	else
+		drvdata->flag_type = FLAG;
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+
+static ssize_t flag_type_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n", drvdata->flag_type);
+}
+static DEVICE_ATTR_RW(flag_type);
+
 static struct attribute *trace_noc_attrs[] = {
 	&dev_attr_flush_req.attr,
 	&dev_attr_flush_status.attr,
+	&dev_attr_flag_type.attr,
 	NULL,
 };
 

-- 
2.34.1


