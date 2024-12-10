Return-Path: <linux-kernel+bounces-439648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4C9EB227
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44822168DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B71A9B5C;
	Tue, 10 Dec 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="467cU4cV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D335674D;
	Tue, 10 Dec 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838454; cv=none; b=msp2/1y2iIXjrL1A8YYdKHsvRmoOSh+L3KektijHslGsr5E4cdM5IHvYdffcxnVghE5G7iU6aGZpveEpuSdtNz/UW/z+cc3x44cZS6Yi+J6ruh/mijkpbVaNIJucBO6OqvLVOLdVU17De8OLif8tEPwSqSvNX8hGltl16qikTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838454; c=relaxed/simple;
	bh=K7sk1vkQi/GqD74GV5HPjfBdvvJbVKJiJD1JRJoC/UU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a7nDbJgqlhhvRWa60GOvcs2vzp+p+xyCOSDMGMDy0hpjZJvgszLv4GUHL6cDdxNxwjWn5/t1Mb505+7AYUKXso6DvsAGEGt+dmXWmaJCeToKtiWPwC6R87fkXYdpB2ohsRxSb8ME7xwzKICSxphHPjzC+uKKNTu7nB535d+KVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=467cU4cV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9RBJX019832;
	Tue, 10 Dec 2024 14:47:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=DQ1nTIBSftquwVYBQvoMKW
	HK26DZ8j8jxi/28l/0eEY=; b=467cU4cVsZlGtR9yEG9BYm4eiBhH1IsFCd/+oJ
	l7KFFQKsEgkujfFSIxl5yuW8A/lGF0aWqgKQFWPKS22mXCGmdW0z7aBrr6isTqAj
	sudyFjIPSpDQb4O4AgkA9ulojWqNOxaKaVz8k6pJbnCm8W10/RPge93ogWZR1jqf
	TL9ZYSlt4J7mH08SmNyxST/kK3jZV+Dy69Tx5g/tMoyEynK8QdmREP4Ub6DmL8jQ
	CdgKCf53Ym+j/HV09WrL9HqW2UU3FmcXxIvcQUhKQk8T/BYv8cj3rjCF003ZAZto
	ZCEd9eqUwgOtHxgBNzQRs2hetdZZLjM0U0s1zetUsILJYFGA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43cek1vwt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:47:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 268394004D;
	Tue, 10 Dec 2024 14:45:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56EB925853D;
	Tue, 10 Dec 2024 14:44:07 +0100 (CET)
Received: from localhost (10.252.12.81) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 14:44:07 +0100
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
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: Olivier Moysan <olivier.moysan@foss.st.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH 0/3] drm: bridge: adv7511: refine actual capabilities
Date: Tue, 10 Dec 2024 14:42:51 +0100
Message-ID: <20241210134254.2967524-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

The STM32MP257F DK board features an ADV7535 HDMI bridge,
which belongs to the ADV7511 bridges family.
At startup the Pipewire audio framework parses the audio devices to
discover their capabilities. The capabilities reported by the ADV7511
driver are not accurate enough, which results in warning messages from
Pipewire.
Adjust the capabilities reported by the ADV7511 driver, to more
accurately reflect its actual capabilities.

Olivier Moysan (3):
  drm: bridge: adv7511: fill i2s stream capabilities
  drm: bridge: adv7511: remove s32 format from i2s capabilities
  ASoC: hdmi-codec: allow to refine formats actually supported

 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 4 ++++
 include/sound/hdmi-codec.h                     | 1 +
 sound/soc/codecs/hdmi-codec.c                  | 4 ++++
 3 files changed, 9 insertions(+)


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.25.1


