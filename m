Return-Path: <linux-kernel+bounces-404062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308C9C3EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0376128119E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABF19DF66;
	Mon, 11 Nov 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OYn4TRZn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274319F13C;
	Mon, 11 Nov 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329321; cv=none; b=hrYtlYnUmSAeAQqFJqWFPCp1pjoPZWpxObzCA3Nplu6upiX0rY1jTtgDrGbtCmpUxMRpJWOiCZzKKVj12iCtJpoHqCfVSjYnUy3LoYaaux/Goj6n/NXctbQQ2J6bezYSN3Xs+dxL9848WwyubrMtbTBNSMzzjQlB95PEgT0akCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329321; c=relaxed/simple;
	bh=USIVZmZKbg1POhsk7+VY+qyrT8ByuiLJZDemvMVjVgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNHEAX7y84Aqeb1D/0oDQOvYCqbllHUmVgWq0WPWErOKa/BlPH3zmuQwCbQzjX4g/6G5kjYAV02rh3eouUFL80ZbA1A2loxp2zM60/jV7GYkk3jJpMnGpTWctsjVDVbvfrzYIdNN7jjE29+U/+frwJsjBP97mzCzBlGfiOknW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OYn4TRZn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9jYIQ008763;
	Mon, 11 Nov 2024 04:48:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	z8X//ziohEQT3Yu2OgeeJObGvInTm5oJALdqzTGRdA=; b=OYn4TRZnmCoLeq/Vy
	CJ2/6vB29pX8Y+p9GTkjFncuz3ov2BO/0OEJqjPfdpYYpn3S3E5ev/cGTdbqNbdw
	3Hx3b+pHZsvWvpqT22ZHsGXpt0BjXwby69o3vk02kxgNiBXmmpkbhnPuv6wCOPP3
	nJ8YqJ439J+oGqo7s0JQvD0iGpVwmt7Sx2/ezFNPcVh5AAM4CvHqRHeYBrd2bkey
	k9HNFBAe879UKsrhgsaaLvzSIyCwawRdSXxC0KcMVq6OonYJpKdcH9DIXQjEP8/k
	/S7pAxZPz42BXCj5Mc6ESRRU9NzikGwzkCMQ9qS7/nSSb6mWKRJl12+VH2eCAGvp
	sMT7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42t84pjw91-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 04:48:28 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 04:48:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 04:48:27 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id AB21A3F70AE;
	Mon, 11 Nov 2024 04:48:22 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v11 6/8] coresight: tmc: Stop trace capture on FlIn
Date: Mon, 11 Nov 2024 18:17:44 +0530
Message-ID: <20241111124746.2210378-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111124746.2210378-1-lcherian@marvell.com>
References: <20241111124746.2210378-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pInpFiJMGGZ0_wIqubjnWxwQhyg3Dmk-
X-Proofpoint-GUID: pInpFiJMGGZ0_wIqubjnWxwQhyg3Dmk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event based on sysfs attribute,
/sys/bus/coresight/devices/tmc_etXn/stop_on_flush.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v10:
No changes.

 .../hwtracing/coresight/coresight-tmc-core.c  | 31 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 12 ++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 12 ++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 ++
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 5f3789314c4d..3d3a2df4303b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -540,9 +540,40 @@ static ssize_t buffer_size_store(struct device *dev,
 
 static DEVICE_ATTR_RW(buffer_size);
 
+static ssize_t stop_on_flush_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%#x\n", drvdata->stop_on_flush);
+}
+
+static ssize_t stop_on_flush_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	u8 val;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtou8(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val)
+		drvdata->stop_on_flush = true;
+	else
+		drvdata->stop_on_flush = false;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(stop_on_flush);
+
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
 	&dev_attr_buffer_size.attr,
+	&dev_attr_stop_on_flush.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0f9155a10ac2..bdc3a7e9ba06 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -19,6 +19,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	int rc = 0;
+	u32 ffcr;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -32,10 +33,12 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	}
 
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
+
+	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
+		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
+	if (drvdata->stop_on_flush)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -225,7 +228,6 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = true;
 		drvdata->buf = buf;
 	}
-
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 18752f58dfa6..e64b98c8f44c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1060,7 +1060,7 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 
 static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
-	u32 axictl, sts;
+	u32 axictl, sts, ffcr;
 	struct etr_buf *etr_buf = drvdata->etr_buf;
 	int rc = 0;
 
@@ -1106,10 +1106,12 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		writel_relaxed(sts, drvdata->base + TMC_STS);
 	}
 
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
+	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
+		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
+	if (drvdata->stop_on_flush)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
+
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2ece44e09911..589087682626 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -218,6 +218,7 @@ struct tmc_resrv_buf {
  * @pid:	Process ID of the process that owns the session that is using
  *		this component. For example this would be the pid of the Perf
  *		process.
+ * @stop_on_flush: Stop on flush trigger user configuration.
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
@@ -249,6 +250,7 @@ struct tmc_drvdata {
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
+	bool			stop_on_flush;
 	union {
 		char		*buf;		/* TMC ETB */
 		struct etr_buf	*etr_buf;	/* TMC ETR */
-- 
2.34.1


