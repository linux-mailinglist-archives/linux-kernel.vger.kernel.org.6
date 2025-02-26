Return-Path: <linux-kernel+bounces-533118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A315A455D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C643AA8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F926B091;
	Wed, 26 Feb 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bKN4Zgm+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120D19CD17;
	Wed, 26 Feb 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552040; cv=none; b=jcHPlaPzwrdPxugK2pd3D0Te4ANYYDt399sVxpHisUnvPbv+7xgXitcJnDWAWbFQTAf5gTa/lysbMJz3X17AUsYpwVbl4wtv4boqWv0thFCkuixhPhxkoebPkmwsUDbGrtFIV/sIcIj8xevfhf/X3E67j2WucY+eNRF0qkWSQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552040; c=relaxed/simple;
	bh=cbyWbxkgWmaV6ETAbjVklBUhjyNNWYdwmryvRn5CQqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsZ1qFMnngFQULpsxuSXq16/dG4J7zZq6/kbfG7vuE9eWLdKDkJTcNXEXJHuBcqI0+bX9jZjaiV7NZYdYhnqoSRjowCYrmcyhQTVZP3o9teCuYGW10QZe6rTVuh5j6ub7rItOaM6dropkW0vub8pqw7QF2g70ppk7vutRpctnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bKN4Zgm+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWqZk011850;
	Wed, 26 Feb 2025 06:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s2BPBqU5Zu6M25sEAyMrkD3eOY+9Ju/KpC7bmTFO4tA=; b=bKN4Zgm+wR9PpEGa
	jn3jrqQvaS7nNjJPlZdXp6pJ+XG7xfxn6u23AI5fl5Ck7ge1qLxslO3esyrGKJcB
	uD0EJrb77JWrD/iCHgUkEHBfV5/EDYE0mUE7Pd6VPYWFchC671UkpfmVpqr/uI45
	j/Z9AfMaAjwruKC6wZvwj+piajlWqf/NWJKlHUFISlUMl78LJDdN6fm2OuiD/adk
	jvUaZ9b6BiNwmNUVpTEfvxv1/cbomn3s994UUM3fPSGNH7gOV+6zkQcfe0oQcVEI
	ByACHvGjbtlEMqXquvdVHuakgnQYhtNxzTwOmRMPWQTSwentFhMixhgr10b8NYSq
	fcBfbA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prk90hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 06:40:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6eRKj024666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 06:40:27 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:40:26 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
CC: Tao Zhang <quic_taozha@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Subject: [PATCH v4 2/3] coresight-tpdm: Add support to select lane
Date: Tue, 25 Feb 2025 22:40:07 -0800
Message-ID: <20250226064008.2531037-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226064008.2531037-1-quic_jinlmao@quicinc.com>
References: <20250226064008.2531037-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jqImbic_HHBnwl0g2xY8MqtxfPFCZyDh
X-Proofpoint-ORIG-GUID: jqImbic_HHBnwl0g2xY8MqtxfPFCZyDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260051

From: Tao Zhang <quic_taozha@quicinc.com>

TPDM MCMB subunits supports up to 8 lanes CMB. For MCMB
configurations, the field "XTRIG_LNSEL" in CMB_CR register selects
which lane participates in the output pattern mach cross trigger
mechanism governed by the M_CMB_DXPR and M_CMB_XPMR regisers.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  |  8 +++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 51 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  |  3 ++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
index bf710ea6e0ef..547540e330c6 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -257,3 +257,11 @@ Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_t
 Description:
 		(RW) Set/Get the MSR(mux select register) for the CMB subunit
 		TPDM.
+
+What:		/sys/bus/coresight/devices/<tpdm-name>/mcmb_trig_lane
+Date:		Feb 2025
+KernelVersion	6.15
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(RW) Set/Get which lane participates in the output pattern
+		match cross trigger mechanism for the MCMB subunit TPDM.
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 9ec4322cd73a..c57f8da2962e 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -252,6 +252,18 @@ static umode_t tpdm_cmb_msr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
+static umode_t tpdm_mcmb_is_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (drvdata && tpdm_has_mcmb_dataset(drvdata))
+		return attr->mode;
+
+	return 0;
+}
+
 static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
 {
 	if (tpdm_has_dsb_dataset(drvdata)) {
@@ -1020,6 +1032,34 @@ static ssize_t cmb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(cmb_trig_ts);
 
+static ssize_t mcmb_trig_lane_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%u\n",
+			  (unsigned int)drvdata->cmb->mcmb.trig_lane);
+}
+
+static ssize_t mcmb_trig_lane_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 0, &val)) || (val >= TPDM_MCMB_MAX_LANES))
+		return -EINVAL;
+
+	guard(spinlock)(&drvdata->spinlock);
+	drvdata->cmb->mcmb.trig_lane = val;
+
+	return size;
+}
+static DEVICE_ATTR_RW(mcmb_trig_lane);
+
 static struct attribute *tpdm_dsb_edge_attrs[] = {
 	&dev_attr_ctrl_idx.attr,
 	&dev_attr_ctrl_val.attr,
@@ -1182,6 +1222,11 @@ static struct attribute *tpdm_cmb_msr_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_mcmb_attrs[] = {
+	&dev_attr_mcmb_trig_lane.attr,
+	NULL,
+};
+
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
@@ -1248,6 +1293,11 @@ static struct attribute_group tpdm_cmb_msr_grp = {
 	.name = "cmb_msr",
 };
 
+static struct attribute_group tpdm_mcmb_attr_grp = {
+	.attrs = tpdm_mcmb_attrs,
+	.is_visible = tpdm_mcmb_is_visible,
+};
+
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_dsb_attr_grp,
@@ -1259,6 +1309,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_cmb_trig_patt_grp,
 	&tpdm_cmb_patt_grp,
 	&tpdm_cmb_msr_grp,
+	&tpdm_mcmb_attr_grp,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 62a3fd5ddec7..932c5dfc89b1 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -45,6 +45,9 @@
 /* MAX number of DSB MSR */
 #define TPDM_CMB_MAX_MSR 32
 
+/* MAX lanes in the output pattern for MCMB configurations*/
+#define TPDM_MCMB_MAX_LANES 8
+
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
-- 
2.17.1


