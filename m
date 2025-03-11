Return-Path: <linux-kernel+bounces-555917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0AA5BE55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAB93AF7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15671253B47;
	Tue, 11 Mar 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kljBNlpA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB872250C1F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690685; cv=none; b=Ynm9Cm/7Lb/AVfLZLjxVnP8IuheUsrqQRcaXSPW2Sq5EolbMOK4hjqg2emqe2ONE0IqxN/esSYPmFOoVkJt0VX2Zm5l2GZJFDzVElX9aZ7q6yrPKw5MtF8nFWtGuYxbuVvZ6yfP3YSYclFJkFxvqfF9Wq9xgia0gqbu1w3bZuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690685; c=relaxed/simple;
	bh=88Q5Crz8ll9pMIicvSy47jAlIDzAG4dg2qig73FeZ4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfA13wGAzAwngIbL+8buDI7DhoJxQl+Php2qqNpGATUGUaivPGY/6TKTNbq2buR3FrX50FXtEYl70UW4s9gcNqq9H/JQ69U/1JhBf1Ow8v42eSh2hwREUUoJ0Kht654llIWg+LcPdyXeJjCQbQ21Rbh7V+7juLB+FKsWw8EETLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kljBNlpA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741690682;
	bh=88Q5Crz8ll9pMIicvSy47jAlIDzAG4dg2qig73FeZ4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kljBNlpAYRrA2eo8hS+sBychs95FS38Rb7QNmx71wflTDgQPHapATfiY9yB2plJdt
	 MnNGkwDtadulgPbYjv5wQTUxdrG0faoi/isfKdQ8xRlcQ2QiicQFCvlvsMKeoxTx5J
	 93ThW3Kwsd1xNTMA8zcNK0Uwt8jINv5Bji/3Hho/2FsDNIpP6GzmxUso3/crJmAa0b
	 P+8eiZVNvcR25aLzhAMxuP6llxBMlWSH2bTYzGEloqSUWgDNeimqB3ssyhPz27EHuV
	 SsbUytjxzxToWDGT0Jh2ua3myD3m6WpJIWbeABwRrccXa0IeKadINv+KGvqEEyJlQd
	 WOql55xNxdNVA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E047E17E14FB;
	Tue, 11 Mar 2025 11:58:01 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Mar 2025 12:57:35 +0200
Subject: [PATCH v2 3/7] drm/connector: hdmi: Improve debug message for
 supported format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-hdmi-conn-yuv-v2-3-fbdb94f02562@collabora.com>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
In-Reply-To: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Add the missing 'bpc' string to the debug message indicating the
supported format identified within hdmi_try_format_bpc() helper.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index e99d868edc1854eddc5ebf8692ccffb9e2338268..a70e204a8df3ac1c2d7318e81cde87a83267dd21 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -305,7 +305,7 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
-	drm_dbg_kms(dev, "%s output format supported with %u (TMDS char rate: %llu Hz)\n",
+	drm_dbg_kms(dev, "%s output format supported with %u bpc (TMDS char rate: %llu Hz)\n",
 		    drm_hdmi_connector_get_output_format_name(fmt),
 		    bpc, conn_state->hdmi.tmds_char_rate);
 

-- 
2.48.1


