Return-Path: <linux-kernel+bounces-355369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB799514F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9981C24D88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993C1DFDB1;
	Tue,  8 Oct 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OlykCxfw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1A1DF263
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397116; cv=none; b=C4ijKfrxrxBWonKSoMeFporQgDOktnZiUk7TH8KjzaAvPnaqP9++FSpvtUKSguIfJX4T5jB0sqTTmEVrEhLcUky7guJvVnq2erIMBA9eaAkDpuk3WHeVFR2dy7rSwxZaTo9htg2xCQblsLhKMYaLFh0qj9rYN/pLVY2OuAuljHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397116; c=relaxed/simple;
	bh=sm96UjPpbIF/phQCWE/RVSh5plSfPFMAnGA/yUzKtXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r/mADjIal/Fxv+tvHA7NkXNlONxo9G36EnkqHHbQubNL1x7wzyNJA65rclHxb5XyliW8qM9vBabOXKnnHnMVSvQhaznIMhR5bNxW7EhSXkUaqKEYe07UqBvja1v98XdbeZDDRfZ9zcCjAnqTqCNPKFwBGwIyWRn5fpqlKYwLV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OlykCxfw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DcYNm000671;
	Tue, 8 Oct 2024 14:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dLXUKvf19OCq2OCwG0iSsemRAtBC635XS9ZR1rdZt80=; b=OlykCxfw+8EcR55R
	4HDMQ7edF1+due3lPNSYe+GVMZtB8INl1D936KYlGPLdcpbANvxdy9NPzZcjm4DC
	lC+k6STuQFIH61SL0u57glHnyajQM6VmGcShFfVXm8gYXnECn4AIkv8O69zSPCaq
	Oe383iM2ZGn7ZRXcy/Kh1PiVBvAva4D4TqSKC4r8MJfzLiJoIW4hGbcbuuURLuSv
	4n9iswxed4rWycPfqe71doITF2TFk8UmCdTZ96OV7bqgZjC+wSE+xH+5y3N6Fiji
	f6ayo3Ar4qshAoNURor1maZtd5tYd33ou5zao65qokUGA2PkUMYVbjTMS5nN+jjr
	489Q+Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wgs1k43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:18:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498EIBC9017948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 14:18:11 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 07:18:11 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Tue, 8 Oct 2024 07:17:39 -0700
Subject: [PATCH RFC v2 2/3] drm/dsi: Add API to register simulated DSI
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241008-jz-test-sim-panel-v2-2-d60046470e6c@quicinc.com>
References: <20241008-jz-test-sim-panel-v2-0-d60046470e6c@quicinc.com>
In-Reply-To: <20241008-jz-test-sim-panel-v2-0-d60046470e6c@quicinc.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg
	<sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Jernej
 Skrabec" <jernej.skrabec@gmail.com>,
        Simona Vetter <simona.vetter@ffwll.ch>
CC: <quic_abhinavk@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728397090; l=2166;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=sm96UjPpbIF/phQCWE/RVSh5plSfPFMAnGA/yUzKtXw=;
 b=H+w25gIqV43zYojzRDSIgEa2Zec+hgUoT8p1pH09KY8l5A80jd+eWdUs1i2zVNei0eXrBzs3O
 HAVrBC7lyCGCMd4vGjZK6OWpyR3AaOVejUJTfKpkwFu2/qqvYfSl/8U
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jK50yDp_27Oo2ONaGj8Wst4tL5dKI75Q
X-Proofpoint-ORIG-GUID: jK50yDp_27Oo2ONaGj8Wst4tL5dKI75Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080091

Add new APIs to register a simulated DSI panel.

If the panel_simulation module is enabled, the DSI host will register
the sim panel instead of the physical panel.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 2bc3973d35a19fc7dff7d578636821a1059bb7f9..95498b9bb8953066b0b1e9cfaa99d0b5b53e6cc8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -153,6 +153,24 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
 	return device_add(&dsi->dev);
 }
 
+#if IS_ENABLED(CONFIG_DRM_PANEL_SIMULATION)
+static struct mipi_dsi_device *mipi_dsi_device_add_sim_panel(struct mipi_dsi_host *host)
+{
+	struct mipi_dsi_device_info info = { };
+
+	info.channel = 0;
+	info.node = NULL;
+	strscpy(info.type, "panel_simulation", sizeof(info.type));
+
+	return mipi_dsi_device_register_full(host, &info);
+}
+#else
+static struct mipi_dsi_device *mipi_dsi_device_add_sim_panel(struct mipi_dsi_host *host)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 #if IS_ENABLED(CONFIG_OF)
 static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
@@ -324,10 +342,28 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node)
 }
 EXPORT_SYMBOL(of_find_mipi_dsi_host_by_node);
 
+static int mipi_dsi_host_register_sim_panel(struct mipi_dsi_host *host)
+{
+	struct mipi_dsi_device *ret;
+
+	ret = mipi_dsi_device_add_sim_panel(host);
+	if (IS_ERR(ret))
+		return -EPROBE_DEFER;
+
+	mutex_lock(&host_lock);
+	list_add_tail(&host->list, &host_list);
+	mutex_unlock(&host_lock);
+
+	return 0;
+}
+
 int mipi_dsi_host_register(struct mipi_dsi_host *host)
 {
 	struct device_node *node;
 
+	if (!mipi_dsi_host_register_sim_panel(host))
+		return 0;
+
 	for_each_available_child_of_node(host->dev->of_node, node) {
 		/* skip nodes without reg property */
 		if (!of_property_present(node, "reg"))

-- 
2.34.1


