Return-Path: <linux-kernel+bounces-233744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E194C91BC75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5B61C23CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FE155C90;
	Fri, 28 Jun 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FRWMruCg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F5156231;
	Fri, 28 Jun 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569578; cv=none; b=YHAzntijzonh99SNXKPLjPJ024+JWkZNiSct2C3p0y3jyi1FCV6LVXaDD2jLEMAUXEcf6ZsIhaIG1O8WyP+FC3gmnnkrY5erNhXshLAaijh5Wnw+y6Fsbb1z4GDEwOw9S/8PCjLalq8IJbrjoNMwhLFodQXjxEIkzr36uz3NppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569578; c=relaxed/simple;
	bh=e/K5DLqwZF68Cf9NR8aDxrmhZ3pI2bNegpaOGpFjPG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDG2KA9Kqsj9peWJHiz3yRNzywSo4V5P8ga8GU+kSHjxruMYI3HKlQ+EsiRatlNxCZKIrqeB9aeMyM1/kzzIW4FXtSImo23wA4JTxU6moXSZjUCp18Jsz5HzAbMdJkizT4ivLZMPdBQbuCAzC5IsXw/ff1oNJo9YjQMYYg9uDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FRWMruCg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S7r3m4004831;
	Fri, 28 Jun 2024 10:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jUdu0OXWdnMlFo2C/icf7Grfb2WaYTs3izYGeOnqbx8=; b=FRWMruCgQ6LQ3MWW
	oDnFQ9VNxidrGXNm9Xnn4AFWDA0DsjphnVjYZFxrXXmibvI3ubyJrruqUukW1qM/
	HWrudteNdg8BRRMVsoZ6nIoiaRxwREAQrcvTiwJT8ndUNMkjLdqBTeRmMTue2G1z
	v0CjAQEMnGfVwAQDnwZ5MAprolRnvwjtP3qoDm5j5YrIrR+nU0ZSX1/LqAGDdOUI
	6AObAEb34eWPVaAU/tSwILQqL7D13v1vEUc+DM5l8ey2ZJZaZFJNr02W2soRVA7x
	KXkYSOKWNS8SjnAZyFDWWhHDM0Ia+XG0bQK/ic6OEZf5eB93mYpRXcLx1CJnxgN8
	G7ASKw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf7y4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SACkgR028733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:12:46 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 03:12:43 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Prasad
 Kumpatla" <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik
	<quic_mohs@quicinc.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
Subject: [PATCH v1 1/3] ASoC: codecs: wcd937x-sdw: Fix Unbalanced pm_runtime_enable
Date: Fri, 28 Jun 2024 15:41:41 +0530
Message-ID: <20240628101143.1508513-2-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628101143.1508513-1-quic_mohs@quicinc.com>
References: <20240628101143.1508513-1-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XrCqWpkM4IZ9aHpsf1_bf1A01L1FS3zW
X-Proofpoint-GUID: XrCqWpkM4IZ9aHpsf1_bf1A01L1FS3zW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=858 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406280075

Fix the unbalanced pm_runtime_enable! in wcd937x-sdw soundwire slave.

Fixes: c99a515ff153 ("ASoC: codecs: wcd937x-sdw: add SoundWire driver")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/codecs/wcd937x-sdw.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index a24d6c620dba..3abc8041406a 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -1067,13 +1067,15 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 		wcd->ch_info = &wcd937x_sdw_rx_ch_info[0];
 	}
 
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 
-	return component_add(dev, &wcd937x_sdw_component_ops);
+	ret = component_add(dev, &wcd937x_sdw_component_ops);
+	if (ret)
+		return ret;
+
+	/* Set suspended until aggregate device is bind */
+	pm_runtime_set_suspended(dev);
+
+	return 0;
 }
 
 static int wcd9370_remove(struct sdw_slave *pdev)
@@ -1082,10 +1084,6 @@ static int wcd9370_remove(struct sdw_slave *pdev)
 
 	component_del(dev, &wcd937x_sdw_component_ops);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-
 	return 0;
 }
 
-- 
2.25.1


