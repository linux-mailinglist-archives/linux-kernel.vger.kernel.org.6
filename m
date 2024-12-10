Return-Path: <linux-kernel+bounces-439647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9A9EB226
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39665188AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BD1AA1EC;
	Tue, 10 Dec 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VTij4G94"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EA5674D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838417; cv=none; b=uIbq/d93JqF9PKIDNeeJfmptRnk4N+V8xPecg8wKqKDncEkZJzZkNSZo3roLBtAY3Tf2C/so9tPBpbBG6gOQ6AMPQaLco3zlXGThSxDyiE8WxcKxkHgfMHQYfsTnPdqRYNOUz2oWyVPPO/PlqiTQotrW41lNe656ZUiMXWkNYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838417; c=relaxed/simple;
	bh=wyzV1BQL4C01kVePczNFq0iJWvjrnyRm9K3W89hBsSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao/Wck4PkRE4Zeuw2y763GCgx0omr9uNVsmcciH2s1YBXQtFmIrXaUY61SLNyqq9Ha2svZesKvKyFCfBUvXE0q7T4hObYhNBThzJHDVYGBrVVeB3E0HbPSXoEP3cUjlhGP2tD2bdavngOvoJJQT+vUGdmdb1tOU5ta6SWwp5OV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VTij4G94; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAA1ErD020594;
	Tue, 10 Dec 2024 14:46:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	B88LI0a9Jttf2T4vTgk1R/W8xNzBmhzuueRUVJ5fXx8=; b=VTij4G94oiwG6nVs
	kAOhyaddTScvF0XJY6Owefa8LEB0JtyABva6XNVZlRrDA7mFQjbFr/5xhO8Q1Wgv
	MABJhtVAV1GsZPCrORnP17UsBLwTW6/A4qye+a586WqtsI62ydPo47XKvOU99tws
	qMkIh4o86OReclYJKD8KUig49P4B3tNDHegejsf8kp+YB0u8MXC3rcig9dN+YKWz
	sxT9QgBwEgRtV193dK+0ZV1C4/DTDdUYbAqHS4X4VBpc07oPP9K4SdQjH6WjrViS
	dty40BRrRlGJ3zfNbFFzOhhY32XfbgY52mI0D43M/A9XECl7jBEiHVxsMh/m34zG
	WrMiRQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43d0t5aq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:46:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3FAB040049;
	Tue, 10 Dec 2024 14:45:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 62071258555;
	Tue, 10 Dec 2024 14:44:08 +0100 (CET)
Received: from localhost (10.252.12.81) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 14:44:08 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Olivier Moysan <olivier.moysan@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] drm: bridge: adv7511: fill i2s stream capabilities
Date: Tue, 10 Dec 2024 14:42:52 +0100
Message-ID: <20241210134254.2967524-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
References: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Set no_i2s_capture flag in hdmi_codec_pdata structure to report
that the ADV7511 HDMI bridge does not support i2s audio capture.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 61f4a38e7d2b..28ae81ca3651 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -234,6 +234,7 @@ static const struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
 	.max_i2s_channels = 2,
 	.i2s = 1,
+	.no_i2s_capture = 1,
 	.spdif = 1,
 };
 
-- 
2.25.1


