Return-Path: <linux-kernel+bounces-355370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B58995150
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CF21F225A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F31DFE05;
	Tue,  8 Oct 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g0u2p575"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBB1CEAAA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397117; cv=none; b=Zx59xzA6GKIpxi/Zjxa+AvHL+WINuBUMzW3ByqamftNsV1yGg4+DM7W0iDzDK0jQMDnq/QMJsd6NEj0lr1xjfi7UhEI+M5KOiY1oWKRGpLDYxrydUM9eUsqPxCFQhfwda0UbTtKScrA8DKL7OPFuHyoM8emL5Kas6Y9L5I7xlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397117; c=relaxed/simple;
	bh=ighNPneJJEoZIQOc3id4SokXbTnEytF2OF2Fhme/9+A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=moBHz5+J9IPuSmFu2OTDI4KDw0yqxBiOhdLSHdjoLVA99toU+eEcnDaN74BKNg7Pm8QuGaFlicQYYNH5acrrlPCQXVWV/5Gj9WvrsdxSTiwysSC2GKibadfWFrGdXtNmFNSZYFTG6VCE4LTZ9AN1ciVcNdqRcxVQJFuDkqiHZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g0u2p575; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4987Hm9L022594;
	Tue, 8 Oct 2024 14:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mKcFKKtcx9HS3yB8+up2fd
	e7YYFYgEm/1MbSp4O0/Fs=; b=g0u2p575E+jjV+xyocdYWxx9W52OihzItvkHsU
	WZLPyZMNOgd5J30xsK29zMaFq8CAnNOTzFbHctmrv0/iuXrBNWvBTBtcrIu6wPLF
	93baCey1DiUG58jAgAb+mlBo2+t7GC8sGMrmSwnsneXsk46g6J91BLibTvO6nFHs
	V8+Q5tOoiG3ubFXkVNO1hMQf7/DVVRlX9l6o4wzRHNBwbkB5x/7XhXaEc3jK29Co
	oV+5i+m9QNpF9jbNljkyGoq0bV69/ttYboBZfTv3blm7BaTthqJbcEtLA3lQQh34
	5mpfePCHrKAP7c5ARurVAyX0a2HEWwCUuu2CQL0ur9FCIVKA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424kaetv2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:18:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498EIAfa026035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 14:18:10 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 07:18:10 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH RFC v2 0/3] Support for Simulated Panels
Date: Tue, 8 Oct 2024 07:17:37 -0700
Message-ID: <20241008-jz-test-sim-panel-v2-0-d60046470e6c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAE/BWcC/22NwQ6CMBBEf4Xs2TXdBkrwZGLiB3g1HEhdZI202
 CJRCf9ug1ePbybzZobIQTjCLpsh8CRRvEugNxnYrnFXRrkkBq10rkhpvH1w5DhilB6HxvEdS7K
 UN4UpyTCk3RC4ldfqPMPpeIA6hZ3E0Yf3+jPRWv2UZP4oJ0KFbVUQtbmxlS33j6dYcXZrfQ/1s
 ixfSx55g7kAAAA=
X-Change-ID: 20240102-jz-test-sim-panel-71c14a56716e
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728397090; l=2313;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=ighNPneJJEoZIQOc3id4SokXbTnEytF2OF2Fhme/9+A=;
 b=1lQPVx1euRnffM4NVhtz2ysaiyU81ajo65PST6yF4dS/I1Pfvr1hBxLTTaU32vE1FYhPHRTOU
 k8Q+TBY2BowA+tRtttffiFYP6Ar7kUgIW2GaS3gNZIrHUXJ4G5C/+0I
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xIPZZzAyOpQiH2tjgnMzx-wywoLMlU7W
X-Proofpoint-GUID: xIPZZzAyOpQiH2tjgnMzx-wywoLMlU7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080091

This series introduces a simulated MIPI DSI panel driver.

Currently, the only way to validate DSI connectors is with a physical
panel. Since obtaining physical panels for all possible DSI configurations
is logistically infeasible, introduce a way for DSI drivers to simulate a
panel.

This will be helpful in catching DSI misconfiguration bugs and catching
performance issues for high FPS panels that might not be easily
obtainable.

To configure and bind the sim panel, the user must:

1) modprobe the panel_simulation kernel module after the device boots to
   shell
2) Mount the configfs and create a test panel config group within the
   sim_panel configfs
3) Configure the sim panel
4) Enable the sim panel by writing the DSI device name to the `enable`
   node

Currently, the sim panel driver supports configuring the supported DRM
mode and DSI mode flags. Eventually, we would like to add more
customizations (such as configuring DSC, dual DSI, etc.).

TODOs once a general agreement has been reached on the configfs design:
- Add documentation
- Allow users to specify multiple supported DRM modes

---
Changes in v2:
- Use configfs framework for panel configuration
- Move sim panel framework API calls from MSM DSI driver to
  DRM framework
- Rebased to latest msm-next
- Link to v1: https://lore.kernel.org/r/20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com

---
Jessica Zhang (3):
      drm/panel: add driver for simulated panel
      drm/dsi: Add API to register simulated DSI panel
      drm/panel: Introduce simulated panel bridge API

 MAINTAINERS                              |   5 +
 drivers/gpu/drm/bridge/panel.c           |  28 +++
 drivers/gpu/drm/drm_mipi_dsi.c           |  36 +++
 drivers/gpu/drm/drm_panel.c              |  33 +++
 drivers/gpu/drm/panel/Kconfig            |   9 +
 drivers/gpu/drm/panel/Makefile           |   1 +
 drivers/gpu/drm/panel/panel-simulation.c | 371 +++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h                 |   1 +
 include/drm/drm_panel.h                  |   1 +
 9 files changed, 485 insertions(+)
---
base-commit: 2023aaa11289cab27f69cf7e8111fd233cdf3170
change-id: 20240102-jz-test-sim-panel-71c14a56716e

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>


