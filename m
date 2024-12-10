Return-Path: <linux-kernel+bounces-439646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CC9EB225
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F2816B939
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE05474C;
	Tue, 10 Dec 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="q6bh+dZK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A826AF6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838417; cv=none; b=CvB72qtg7tX7opvkGtAjsEDpQldhd6MaWapbzeM1A2f5IeGPPPRW2m6rAKa527a1pdPdaMobcpQyPiRuXyu38ZqI6hp14uMfUQ+xaCyCniKAmROHh43gg1ydQjLIHeocWJ0/OcPigSY7ItJVdP2X7vvzzQL2sWep8Tpv7DeGiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838417; c=relaxed/simple;
	bh=P+FJMUW6dhvTydtfcR0bDyrwofhtTXu6HDBL5CWwY94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2bHdjMir0luONbEiIuf/c0Yr8YV/xFWK/AjEuevpTz5kEtzTLacTPtNsxyw8pq+StzIClqZmmsfpyKwTkGPoy1LIgJ+zyT2jZIdJcAgD3KzjZDo65tiPtQ7jupXd02LUnL1iTn4eeGAl9QJapiOTy9X4TBj9RDrbHUcn14a9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=q6bh+dZK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAbOaF025829;
	Tue, 10 Dec 2024 14:46:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	oAn87QHJepSxFgirg8GRxK9W/hXFqtjZBsb7YLbCrvk=; b=q6bh+dZKfuIAAHvX
	if+YpWF2HMiPOZcERvVA4rG8dV6NP0qd4fqzIVRi0lTt3BM4Br8F2d0Y3GkNjyP2
	FcHRd9XrOHOSZx5bmmODTlNsahtGsmmgwHOYajL3tPKZbZL9GH6A9FF+13/EOrK9
	t8lJ32/8Tro7jqrxo0hSkjtJ66Ap/cNcMgIGkdS+CpHaSx20mQsoblHwB8ybaByl
	Hy+sVpZOSKg8Fjlxnv37wbbL++Qy+74Wlo3wGXkPhoTLB6ksTApUHAVwt1g5djHH
	gq3TIsFV0dcq/zDNgylSUQ7msaE06uhnphMb+kkRYFL0sl97EIZ65wjH4vWWP5Cr
	KZ1Daw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43d0t5aq7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:46:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3FBA74004A;
	Tue, 10 Dec 2024 14:45:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6FC9C24A15B;
	Tue, 10 Dec 2024 14:44:09 +0100 (CET)
Received: from localhost (10.252.12.81) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 14:44:09 +0100
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
Subject: [PATCH 2/3] drm: bridge: adv7511: remove s32 format from i2s capabilities
Date: Tue, 10 Dec 2024 14:42:53 +0100
Message-ID: <20241210134254.2967524-3-olivier.moysan@foss.st.com>
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

The ADV7511 chip allows 24 bits samples max in I2S mode, excepted for
direct AES3 mode (SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE format).
However the HDMI codec exposes S32_LE format as supported.
Adapt ADV7511 HDMI I2S format list to expose formats actually supported.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 28ae81ca3651..ce6eda87bfe0 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -232,6 +232,9 @@ static const struct hdmi_codec_ops adv7511_codec_ops = {
 
 static const struct hdmi_codec_pdata codec_data = {
 	.ops = &adv7511_codec_ops,
+	.i2s_formats = (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |
+			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE),
 	.max_i2s_channels = 2,
 	.i2s = 1,
 	.no_i2s_capture = 1,
-- 
2.25.1


