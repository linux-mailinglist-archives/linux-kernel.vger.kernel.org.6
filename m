Return-Path: <linux-kernel+bounces-513890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A577A34FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE413AF130
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE4527126D;
	Thu, 13 Feb 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbWGyClu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62E270ED2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479566; cv=none; b=R8Awlemd1Q+zG++RrfahoeyWqGPrDlukhJzBjkLsXeic4U5ufU4npfKkobGn7EJpSFPAEaZIdUJD/sb3sKq+8soNvKdJdcssWwdEIytcRtfx4xe/34UeLgI3Vf6M2swWxfZpvr2fiIK2kKGqdUCafoLp9ZhnqJTmfBwEugeXwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479566; c=relaxed/simple;
	bh=+I+VRf68pub7QtDDgc2t195rQtaTteShHv9verWdpIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfA9rq4drGvbpD5FWCzmY/YnpYLkwD1JnepChW0tLHXdJAxzMo4fv4csDYQuRCkaUunzhFkuheww+TNckyi2xPGx5MrmoqnKxFLKP5VnU23/XrE/XH/XR5MonS2VWZP23PFKN9rBeJvvpTu+28jkK/EgyzS3BYbfrecrAOIhyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbWGyClu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJlrIKSurYkXvX4GL8/YLGu0FEvUvuu47DJYVtCqeOc=;
	b=LbWGyClumMrDbCOm1Ey07FyPA+mZfuyk8Ntvg0FNn4aXjzbN0+Ha4rRXyx7MBHm8Fryd9g
	2zhQJKoJym74VXw+JToua+OEWRHDrKeQ8JwmteJsFsAm5nr/HPqRo5uw1E+/rxRd98C9Td
	+Jrr8EOAk9XX766t08Kn9XbWxEfAQ64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-B7o60zkpPGSupJW3M0rBRA-1; Thu,
 13 Feb 2025 15:45:56 -0500
X-MC-Unique: B7o60zkpPGSupJW3M0rBRA-1
X-Mimecast-MFC-AGG-ID: B7o60zkpPGSupJW3M0rBRA_1739479554
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D1DC18E6952;
	Thu, 13 Feb 2025 20:45:54 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7BA219373D9;
	Thu, 13 Feb 2025 20:45:50 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 15:44:36 -0500
Subject: [PATCH 19/20] drm/panel: Remove deprecated functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-mipi_cocci_multi-v1-19-67d94ff319cc@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739479476; l=6569;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=+I+VRf68pub7QtDDgc2t195rQtaTteShHv9verWdpIw=;
 b=4f7vsxU2rR19xH91jp30oUsAOFAjhYShDY70+PUObTMl2wOBmiyGzINJrVwnB6hvTTnvteNZM
 EcvFuJEMyp9BUwRQQ2U3rDB7Vq5wHCLVAeCTD3lOFBq1HWgFBT3cueZ
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With transition to newer functions, remove
older ones that are no longer used.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 56 ------------------------------------------
 include/drm/drm_mipi_dsi.h     | 47 -----------------------------------
 2 files changed, 103 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5e5c5f84daacc6913a73f9dda0f49cc78f83479a..33f68d4057aadd772afe6cccbb7c27f1730b581f 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -768,34 +768,6 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
-/**
- * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
- * @dsi: DSI peripheral device
- * @payload: buffer containing the payload
- * @size: size of payload buffer
- *
- * Like mipi_dsi_generic_write() but includes a dev_err()
- * call for you and returns 0 upon success, not the number of bytes sent.
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size)
-{
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	ret = mipi_dsi_generic_write(dsi, payload, size);
-	if (ret < 0) {
-		dev_err(dev, "sending generic data %*ph failed: %zd\n",
-			(int)size, payload, ret);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
-
 /**
  * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write_chatty() w/ accum_err
  * @ctx: Context for multiple DSI transactions
@@ -912,34 +884,6 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
-/**
- * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
- * @dsi: DSI peripheral device
- * @data: buffer containing data to be transmitted
- * @len: size of transmission buffer
- *
- * Like mipi_dsi_dcs_write_buffer() but includes a dev_err()
- * call for you and returns 0 upon success, not the number of bytes sent.
- *
- * Return: 0 on success or a negative error code on failure.
- */
-int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
-				     const void *data, size_t len)
-{
-	struct device *dev = &dsi->dev;
-	ssize_t ret;
-
-	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
-	if (ret < 0) {
-		dev_err(dev, "sending dcs data %*ph failed: %zd\n",
-			(int)len, data, ret);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
-
 /**
  * mipi_dsi_dcs_write_buffer_multi - mipi_dsi_dcs_write_buffer_chatty() w/ accum_err
  * @ctx: Context for multiple DSI transactions
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 94400a78031f1b5f515c4a1519f604c0df7f3e0c..8d191d211f4fc67b8f8760571091885a1924310c 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -287,8 +287,6 @@ void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
-int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
-				  const void *payload, size_t size);
 void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
@@ -326,8 +324,6 @@ enum mipi_dsi_dcs_tear_mode {
 
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
-int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
-				     const void *data, size_t len);
 void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
 				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
@@ -380,27 +376,6 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 					  u16 scanline);
 
-/**
- * mipi_dsi_generic_write_seq - transmit data using a generic write packet
- *
- * This macro will print errors for you and will RETURN FROM THE CALLING
- * FUNCTION (yes this is non-intuitive) upon error.
- *
- * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
- * Please replace calls of it with mipi_dsi_generic_write_seq_multi().
- *
- * @dsi: DSI peripheral device
- * @seq: buffer containing the payload
- */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
-	do {                                                                   \
-		static const u8 d[] = { seq };                                 \
-		int ret;                                                       \
-		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0)                                                   \
-			return ret;                                            \
-	} while (0)
-
 /**
  * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet
  *
@@ -416,28 +391,6 @@ void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 		mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
 	} while (0)
 
-/**
- * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
- *
- * This macro will print errors for you and will RETURN FROM THE CALLING
- * FUNCTION (yes this is non-intuitive) upon error.
- *
- * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
- * Please replace calls of it with mipi_dsi_dcs_write_seq_multi().
- *
- * @dsi: DSI peripheral device
- * @cmd: Command
- * @seq: buffer containing data to be transmitted
- */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                               \
-	do {                                                                   \
-		static const u8 d[] = { cmd, seq };                            \
-		int ret;                                                       \
-		ret = mipi_dsi_dcs_write_buffer_chatty(dsi, d, ARRAY_SIZE(d)); \
-		if (ret < 0)                                                   \
-			return ret;                                            \
-	} while (0)
-
 /**
  * mipi_dsi_dcs_write_seq_multi - transmit a DCS command with payload
  *

-- 
2.47.0


