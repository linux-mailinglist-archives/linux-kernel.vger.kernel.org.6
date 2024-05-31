Return-Path: <linux-kernel+bounces-196245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E88D5958
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AA282A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F97CF3E;
	Fri, 31 May 2024 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZsUEzc/9"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB757C097;
	Fri, 31 May 2024 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129719; cv=none; b=nMqdndMp1NnNE7JzGVDJWOmTgUCBNsKAnythGBFowTceywhQrIvPklediI8cCgWjQSOH1tz7D7Csa/p9n3Mtdnj45TGcDwdIW0XxMWlHgQQqZlgTLOlLfp5zL3OCnZYYet5Wx3cn15ouqhZs/tlBYwWN9FfnWPXNqLHdktxWa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129719; c=relaxed/simple;
	bh=VwGPySWFxCNRR2t0D3pggR4b57fc2BDIbP056fwsIHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1j5UsFz1B01d0sKyP4XZoNhNqWsPgOBKPBaoaEHs9Z6W+JqZFrXnbkfnN4yeWgkT8KgVdPsvLBv0gBcWaBPTfzkhALA9dZVLNC2EPnk1bcHytxyu8neJy2ywW++63K5oJ3ItWQuWM2AX4JIouQh/c7dmtiE7ih8gQHH5qdgG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZsUEzc/9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UHMRI8026563;
	Thu, 30 May 2024 21:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	c437aA/V3a8ymFK/DrEJ8NuZ36XitV7hVCsmYHjQ8A=; b=ZsUEzc/9X+2l9vEag
	z/lxJR3kFWeiLtzQK4ndINJjHH35FYi4/2oq3DdittLztNfTbiHeZZRAG59i8eKQ
	dfRAGXXAM286Lp81bxfARganNIfQsFnIxMtbG6wE9fdcPWInxg8phYXCsi+dldc1
	zBhAjWqxsO1B+0twhdIWqm5u2yOpSYbxtelJoXqV8ZWZrXY4sr0l4+g05m0AZ0Yf
	JhQX2cKwUBMmkOWW1FJ70HqXHpr4b3s1waK0ES+wZdc3Qt5bpJDmzlilDlL/2yqn
	OoSV6JNXIpxMJ5q9O6sA2hj4BGv51we8Rk18hO9kXvzYifqavJqC5a4fZyHY8ObO
	6MZdw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yewt3a0w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:28:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 30 May 2024 21:28:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 30 May 2024 21:28:23 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 2715E3F7085;
	Thu, 30 May 2024 21:28:19 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v8 6/7] coresight: tmc: Stop trace capture on FlIn
Date: Fri, 31 May 2024 09:57:44 +0530
Message-ID: <20240531042745.494222-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531042745.494222-1-lcherian@marvell.com>
References: <20240531042745.494222-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GCfXJTLqCf0AABJBNxITpHHdmDybH_eI
X-Proofpoint-GUID: GCfXJTLqCf0AABJBNxITpHHdmDybH_eI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event based on sysfs attribute,
/sys/bus/coresight/devices/tmc_etXn/stop_on_flush.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v7:
* Honour stop_on_flush sysfs attribute for perf sessions as well.
  This allows user to start trace sessions using perf method as 
  well to use the Coresight kernel panic support.

 .../hwtracing/coresight/coresight-tmc-core.c  | 31 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 18 ++++++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 18 ++++++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |  4 +++
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index aaa9de9f4cd2..24edd9d750c3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -452,9 +452,40 @@ static ssize_t buffer_size_store(struct device *dev,
 
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
index 655c0c0ba54b..1529b9cc210a 100644
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
+	if (drvdata->stop_on_flush_en)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -225,7 +228,8 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = true;
 		drvdata->buf = buf;
 	}
-
+	if (drvdata->stop_on_flush)
+		drvdata->stop_on_flush_en = true;
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
@@ -288,6 +292,8 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			break;
 		}
 
+		if (drvdata->stop_on_flush)
+			drvdata->stop_on_flush_en = true;
 		ret  = tmc_etb_enable_hw(drvdata);
 		if (!ret) {
 			/* Associate with monitored process. */
@@ -349,6 +355,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	tmc_etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
+	/* Reset stop on flush */
+	drvdata->stop_on_flush_en = false;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 74f53972ce3c..bf2d0932e205 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1059,7 +1059,7 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 
 static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 {
-	u32 axictl, sts;
+	u32 axictl, sts, ffcr;
 	struct etr_buf *etr_buf = drvdata->etr_buf;
 	int rc = 0;
 
@@ -1105,10 +1105,12 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 		writel_relaxed(sts, drvdata->base + TMC_STS);
 	}
 
-	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
-		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
-		       drvdata->base + TMC_FFCR);
+	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
+		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
+	if (drvdata->stop_on_flush_en)
+		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
+	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
+
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
 
@@ -1313,6 +1315,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		goto out;
 	}
 
+	if (drvdata->stop_on_flush)
+		drvdata->stop_on_flush_en = true;
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
@@ -1758,6 +1762,8 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
+	if (drvdata->stop_on_flush)
+		drvdata->stop_on_flush_en = true;
 	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
 	if (!rc) {
 		/* Associate with monitored process. */
@@ -1808,6 +1814,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	tmc_etr_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
+	/* Reset stop on flush */
+	drvdata->stop_on_flush_en = false;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 528174283ecc..81eadb384b83 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -205,6 +205,8 @@ struct tmc_resrv_buf {
  * @spinlock:	only one at a time pls.
  * @pid:	Process ID of the process being monitored by the session
  *		that is using this component.
+ * @stop_on_flush: Stop on flush trigger user configuration.
+ * @stop_on_flush_en: Stop on flush enable flag
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
@@ -238,6 +240,8 @@ struct tmc_drvdata {
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
+	bool			stop_on_flush;
+	bool			stop_on_flush_en;
 	union {
 		char		*buf;		/* TMC ETB */
 		struct etr_buf	*etr_buf;	/* TMC ETR */
-- 
2.34.1


