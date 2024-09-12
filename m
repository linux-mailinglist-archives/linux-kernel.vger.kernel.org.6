Return-Path: <linux-kernel+bounces-326588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF263976A79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7991F2455E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D81AD264;
	Thu, 12 Sep 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XOL+xtlq"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF61AB6DC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147530; cv=none; b=NhoE7drftglbZN2sqht1v+stujWToAmKeDkVhnZnlD1YkPgyV0ZNfGOxHt+EbrXUFOWysO/EBJj/kugKjNYzkhpzc6m8CkHz/AKyoH0UBHFK84evO37Fm/y9h+5u+AQJVyXAHnZtXWG62YjeX2NinAFpPoEFSwwz2Zg4pzkIZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147530; c=relaxed/simple;
	bh=HqLDT2kDdULA6wIcAVsiwZrhSN52t305f8ag1ydTtms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4JhzAkcLtOaHqgkCC35vbT+21gp4AJ1wiY04kbV97ZR8bgrTJ54SYPhHcdP08AtpcNfop7w80wmg96o5N37+0AP6QBU2587ft/WzOgTpregqBohUjr9gkC2g3CJiHN6/UV+6Eo+l9/PJ2yBZ60zWMSbQuQRP09anBzNu8KDjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XOL+xtlq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5DC640004;
	Thu, 12 Sep 2024 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726147521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpsUVuEinW8EH03g2sq6CYyNt8DLqEZWlJ6lw4FIIPs=;
	b=XOL+xtlq+3fW3c90nkqTHAkDg05uAloEPpZwAvKKEXlPviuxzF74NJUPA7KqceRTJ8orz5
	eu6zmn/EPORKMPNt8N0VDKfeVMntOnw/1Qi+vzzlRN2lQ2FL7HUtLrEW0ienFElTH9VXxy
	+7yAhf+rdVSvRMYaDVf0MxC7N4b4DpH3HxZkIs7H0/0tkK2yX2P/bzMEoiO45u1j/qC4+q
	UyDkiDDOymUszEzzVjwWf5EF5IHXvBEnpAJTbLAe71pt1wtnS15yJx6jRIgNLae0Bup705
	Lsb1nDZevhVTacGn3xoL9tAtAP6092NZXGkJWuM0H0DVrPMyjT61RslXtGZxFQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 12 Sep 2024 15:25:17 +0200
Subject: [PATCH v3 4/4] drm/vkms: Switch to managed for writeback connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-google-vkms-managed-v3-4-7708d6ad262d@bootlin.com>
References: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
In-Reply-To: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=HqLDT2kDdULA6wIcAVsiwZrhSN52t305f8ag1ydTtms=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBm4uu8HmEzwmBUqDedxhCpcmLkeGIsQmnbc78CJ
 gD1o3ASgxGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZuLrvAAKCRAgrS7GWxAs
 4hOUEADPaf75OVqrMBKKKcdS+p3NTt7BeEqESVcTeUu2oeqy6UA04saIrLTEYeepHPof/5s/OEt
 8km3IzxHuXgab7DlPzD+2etQSepvFoYz6KQ6evbM3QsGP5QBeGctSDqH//MwFxJvLQ5NUDT9glT
 HVKes/lvoTu3U+HPEsAi0WfYmG+5jA2AoRFeDiXdpwPsD5t/Ed9ei18q2Rj3Xyt44CqUFxqgbVo
 8kUNfAvX5u/Xp8I8fT7PfUJrT2lOb8IoPAkmo2meR2jzk+9doaFsRAW6nCmxSzNx5gqzaHbHwKk
 RaIFbmnhH7O38wksRjHod0Lti35fVeQkMYXyUq/AG/prQe4sgwijieXBU0szRcKIr6VJy7gXzxv
 29k9em18r3gEjMMTlBXIA4bSBuXHTwjVwBPy74DjPIWbcFFdUoPWeGSYPbVQ4p6oLtOFpH9Oh0a
 TZUhTNLEgzLt1jphWgglWgA3VGY87jkSwWqSA7kSb2OfLFvur7cdyC4tXQ8An20QEUXwuasaUMw
 8OCShttF8LHm+7YmvVXZdPDgKxquDxKWI3QyQb/FQes22v6wtf9Ay6GG+xC9o1k26CLIPZ2k8A2
 Cbtl6CX4Qly7E5wzw1dwuWkff2ttkYPhEMl90KD5L8F1kDFeoT1tcqiK2FnSCTfNVdE9rnNtmia
 hVQAp2sKRM1K5Iw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current VKMS driver uses non-managed function to create
writeback connectors. It is not an issue yet, but in order
to support multiple devices easily, convert this code to
use drm and device managed helpers.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_writeback.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index bc724cbd5e3a79705bdc091a7a13430f67ecf65f..a948f4598764efef971f76e1016fc1a963fbbba7 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -24,7 +24,6 @@ static const u32 vkms_wb_formats[] = {
 
 static const struct drm_connector_funcs vkms_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -174,10 +173,10 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&vkmsdev->drm, wb,
-					    &vkms_wb_connector_funcs,
-					    NULL,
-					    vkms_wb_formats,
-					    ARRAY_SIZE(vkms_wb_formats),
-					    1);
+	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
+					     &vkms_wb_connector_funcs,
+					     NULL, NULL,
+					     vkms_wb_formats,
+					     ARRAY_SIZE(vkms_wb_formats),
+					     1);
 }

-- 
2.44.2


