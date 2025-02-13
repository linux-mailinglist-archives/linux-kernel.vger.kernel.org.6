Return-Path: <linux-kernel+bounces-513885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB1A34FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9858118872D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9526FA6B;
	Thu, 13 Feb 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVtrSsEJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422C26FA5D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479552; cv=none; b=opZZSq+R2QB0JA0SNuwsQ1IDXKw+2eynErLZ/jlLFmQyI5sa4J7EhKUlgcbtrVxbyiyf/RjNWHS0RFbmWurOXlDp9ANFvh9uZ4qynj0n46Y/zHZX53/e24BfT+SVDDNb3HKs/9NcnsqYK4L4+8tqOqeXL1i+o+ZJ7yn/D0f/YMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479552; c=relaxed/simple;
	bh=d0oAIIWg/RTKSm7WCgHGjb6bJKeS/RBtfAxq0fSwTv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSBn46c/OW1SemYJaE2m+/hc/LhrGe1lj/zrK3RsulX8uDReZ2YCZ4UnhBC+6DBfGdYAYBf7H6F9nUB5dzVZRDSyvmT1j8j35dR4s88WVbjTMfFbQGSlhbB5mE/Z7mN9/FqZ69vsegTntQg0CCt4qdMROl1vI5kco+bfAkam7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVtrSsEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hn8JqP8NmtJjwg+vh/7+5DBeA6eSHQ9B0cbVf3SIEUY=;
	b=ZVtrSsEJod9Yc0oRZX45LM61d0JJ6h167liKQd6E52BjDmLbsZjH3fnOU0pcVfP8uaRhfD
	PXhcgBh6NSHD9W1SoI61v3uhhS6NnIKDHNu+secZvO3hIdHXzLnbJ7lb7qgzdPIfmjgxqo
	Bi7fUsN6ES8AwYLFTQzijJmpqfnbiuQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-cretByX9NY-hIkwjJaZkSw-1; Thu,
 13 Feb 2025 15:45:45 -0500
X-MC-Unique: cretByX9NY-hIkwjJaZkSw-1
X-Mimecast-MFC-AGG-ID: cretByX9NY-hIkwjJaZkSw_1739479543
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3747018EB2CB;
	Thu, 13 Feb 2025 20:45:43 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFC27190C54A;
	Thu, 13 Feb 2025 20:45:39 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 15:44:33 -0500
Subject: [PATCH 16/20] drm/panel/ls043t1le01: Move to using
 mipi_dsi_*_multi() variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-mipi_cocci_multi-v1-16-67d94ff319cc@redhat.com>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
In-Reply-To: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739479476; l=3329;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=d0oAIIWg/RTKSm7WCgHGjb6bJKeS/RBtfAxq0fSwTv4=;
 b=aMhRqAiveTQdxQO0l/HFWpmvh7ujA/2H0yoYf92b2Q1cLnvnLl9UkORhXDpFmpAr/AYLue9ge
 jzHxOTBFVxbC2PDAJTk944mPsgwJMfTwLt+e7hb6/7wGWaNlwJnfnA1
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stop using deprecated API.
Used Coccinelle to make the change.

@rule_3@
identifier dsi_var;
identifier r;
identifier func;
type t;
position p;
expression dsi_device;
expression list es;
@@
t func(...) {
...
struct mipi_dsi_device *dsi_var = dsi_device;
+struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
<+...
(
-mipi_dsi_dcs_write_seq(dsi_var,es);
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
+mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
+mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
|
-r = mipi_dsi_dcs_set_display_off(dsi_var)@p;
+mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
|
.....//rest of the mipi APIs with _multi variant
)
<+...
-if(r < 0) {
-...
-}
...+>
}

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 28 +++++++++----------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 729cbb0d8403ff7c0c4b9d21774909cc298904a2..38df40d05ca0a786b11bc9a3b11b2c39b16bc987 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -36,13 +36,12 @@ static inline struct sharp_nt_panel *to_sharp_nt_panel(struct drm_panel *panel)
 static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
 {
 	struct mipi_dsi_device *dsi = sharp_nt->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
 	msleep(120);
 
@@ -52,10 +51,9 @@ static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
 		return ret;
 
 	/* Set both MCU and RGB I/F to 24bpp */
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT |
-					(MIPI_DCS_PIXEL_FMT_24BIT << 4));
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,
+					    MIPI_DCS_PIXEL_FMT_24BIT |
+					    (MIPI_DCS_PIXEL_FMT_24BIT << 4));
 
 	return 0;
 }
@@ -63,13 +61,11 @@ static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
 static int sharp_nt_panel_on(struct sharp_nt_panel *sharp_nt)
 {
 	struct mipi_dsi_device *dsi = sharp_nt->dsi;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
 	return 0;
 }
@@ -77,17 +73,13 @@ static int sharp_nt_panel_on(struct sharp_nt_panel *sharp_nt)
 static int sharp_nt_panel_off(struct sharp_nt_panel *sharp_nt)
 {
 	struct mipi_dsi_device *dsi = sharp_nt->dsi;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	return 0;
 }

-- 
2.47.0


