Return-Path: <linux-kernel+bounces-446822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239489F2998
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178081886281
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD781C4A2C;
	Mon, 16 Dec 2024 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kJwEsZ7T"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779931CEE83;
	Mon, 16 Dec 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327075; cv=none; b=ezMIRlagEzSa+UXOAnb/iIetK412kODUogxzg+rG7+kUMAqmeZzwNRC7qXpuTKpdPAftbSyicm0VWXbhPlSB6ZORm/y7yIdYpuu9hrq1qQ5ifn/2lvBZ9XwsSWN6/ogfbLJhers7D7mpRKUcxAuM8wOc3vTWvNJTbJmFgQHQW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327075; c=relaxed/simple;
	bh=078MRie5Jz3ejPm1RskSTXvZrzJOMjzRmdDA0vPT3Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/H0mzRvb1ExXoCoJDIlghlvkyBTBIit5Y0kBizO79ozi2fGu1zrupyC2vNy03c7iNiV1u/TRXOX6VsiGBV+xFxoR1g39xGK650TY/2RivuUFs6nnk28H7zXVhDadUN9f9fI64/jyrRyqJQTm2P13t+cZxK0ArOkATYmZEHA45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kJwEsZ7T; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4A1gE017561;
	Sun, 15 Dec 2024 21:31:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	GdvtXVH4G3Wvv5uZEhQDV9wpmwHRDq+raChqu127EA=; b=kJwEsZ7TqLsF1V6MF
	OFnoYrQ8UQMrRMWufVldCFxipPpKxjXHWUumt0UVOhfe2QxrQfhthLfmqcv+War8
	FV0DLYDzQtQHQexH5JPYRW1cMoR1gNxPYLHdLNW4TM3OOHu4+hfqwTfBULowNHLX
	JgVyB0DhZfPochy1ZvmBzLxZhaIcOTMba3/rb6z+Q7dejhy3m5W9iCfv5YX0E/T2
	8//+AiHr4Q5s1MpIcYY6n1EcXan/BRBHRER+lEmiPMeWRRkT7ze6MM2lQWaxROpk
	SvVtN2+MSAmcz1887BB/j+KUxrxCvHv5hfAUtT2nzkDKti4G5B/YN+oAadK5nwvI
	068+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jcxgr7d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 21:31:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Dec 2024 21:31:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Dec 2024 21:31:05 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 2374A3F704A;
	Sun, 15 Dec 2024 21:30:59 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v13 6/8] coresight: tmc: Stop trace capture on FlIn
Date: Mon, 16 Dec 2024 11:00:12 +0530
Message-ID: <20241216053014.3427909-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216053014.3427909-1-lcherian@marvell.com>
References: <20241216053014.3427909-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2HdW_hlETtpTBRxxfwua5sjIhIZWIn6F
X-Proofpoint-ORIG-GUID: 2HdW_hlETtpTBRxxfwua5sjIhIZWIn6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event based on sysfs attribute,
/sys/bus/coresight/devices/tmc_etXn/stop_on_flush.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v12:
No changes.

 .../hwtracing/coresight/coresight-tmc-core.c  | 31 +++++++++++++++++++
 .../hwtracing/coresight/coresight-tmc-etf.c   | 12 ++++---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 12 ++++---
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 ++
 4 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 6ef68b56de22..7cd138c9af6d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -521,9 +521,40 @@ static ssize_t buffer_size_store(struct device *dev,
 
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
index 0ca01d5c9581..bd7279a2dbd3 100644
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
index e3707b69abff..482a425faa41 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -220,6 +220,7 @@ struct tmc_resrv_buf {
  * @pid:	Process ID of the process that owns the session that is using
  *		this component. For example this would be the pid of the Perf
  *		process.
+ * @stop_on_flush: Stop on flush trigger user configuration.
  * @buf:	Snapshot of the trace data for ETF/ETB.
  * @etr_buf:	details of buffer used in TMC-ETR
  * @len:	size of the available trace for ETF/ETB.
@@ -251,6 +252,7 @@ struct tmc_drvdata {
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
+	bool			stop_on_flush;
 	union {
 		char		*buf;		/* TMC ETB */
 		struct etr_buf	*etr_buf;	/* TMC ETR */
-- 
2.34.1


