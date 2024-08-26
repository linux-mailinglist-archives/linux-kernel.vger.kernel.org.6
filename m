Return-Path: <linux-kernel+bounces-301838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727E95F656
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B287F1F22336
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE1194AE2;
	Mon, 26 Aug 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOjnfhhJ"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B23194A40
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689262; cv=none; b=hmUDfvUA3nCn3k5ZaEUoldwrZrHfMAAdeC3wsz/aNMW2x92plWQwWYEU/Z4WKQJjuIkUlryRxXwVw83MRkglAzGQdnT9xafS7KKXiSGrBNJK8pk/mNkEc7mRWbvLDBwy2DnpVWcQwWgfaINkQeZSTbWrBPzoKUHC17nGcDOxtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689262; c=relaxed/simple;
	bh=65mwwAzTqveSbIVeRdWT+IRD9chpaIVji0wmTNJwTs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCIs6f9GzKAknjOAWuQVg27VXxb6Vkv21nda+w3dJvSz67lZThorYBRYY7gZldwgDpzN4vkMGUd0mHml0osTggEejhfzreWusxbrxPb4CZfVKrgBqLDj3TSqfSFJwF3Wjtjb6p23P8ma66b/9cugbNKbzWBo1RTZGo1RpMxGjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOjnfhhJ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2703967b10cso3242142fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689260; x=1725294060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AslJABVo00gPblnVR8gYUn7zUqkgg9WhvvpyeH5H28=;
        b=fOjnfhhJ0iXx11HM/5Ac+bV7TZWV+EadARIzFjLS/OxtlLZM+DmYxpuPLnVdwwhD4G
         ujkYJeen5lukd6GRZTVyjKI5ijCZ/ZAOEDGUolMeBZGfxknO+HEBAPXa6+JIW5M1jM+d
         XxItPpVtx3YazXLFLgmYILJ+SWYwwsWjkl9AmtCq4qqgk9ldBcc6flWdvrSf/doFHBoM
         VvsXpuj1NJXYMj8/IsqK5yQjnlDy8gOjBG9OtLPUbDhFn5RHHoChZ0Bs8vw9U8F9eiex
         WBw04ETRBAgJvhqPrzXMD38O8tlQ0FF4QP/Kh7JlnLbmXn4je4jygX9ROpkMkB8je+KF
         wxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689260; x=1725294060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AslJABVo00gPblnVR8gYUn7zUqkgg9WhvvpyeH5H28=;
        b=alwQ8ZbsAre1yUHX3T7Ik1Hso/CjB8YnrCtBdvPBxnEB3ph/JyyYVWK0PB5mA9MYGq
         Nj4ELRoHDf8Vx9ThTalNop/b8q+vniIh9zmYruHJ/34VyHyuu0EliV5qIgeWd2nT0VsM
         GwnijVnT5vb9QMWZ0NL9dFA9E/qVsepYIJb70lihCr4f6nbsRVNVRmFYMrYqd2RKqbMq
         2y5G6vz+XdibWxUO02TU8PxGfnmWX9SJ7Cw5hbVykCvBfNzAdplCbnH3k4/XM5PfHE2U
         Gd1A7u6aqgt4sgoqgNTtw6jx77sPnlOLHj6IKYqKdm+iyiTF4yEa0vqcjnzzwb3YdfSa
         MMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWRNJXaA1RPKB7+8ZLTGYivW5YmPWYDA+dYT0hkhuPzeFR/bIGTOIWHFJPe69pBgzeWTf0qKqYvoQ+eOSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSrNYqZRDoWtuIMvj5q6nFlegKmeEH6sc4O9rf2GjkLJOWPZt
	4sKXULJ7oK/tJe64IwdTzlHXxeRqTEWIl/shpnSd4TgE9fe8LW+4
X-Google-Smtp-Source: AGHT+IHmikhzl0qq17V3DT9TnvIBp3tik8f35GSxDiprCSyIs8GKTKsExxUf5g1DWQ+fSIxEePrWcg==
X-Received: by 2002:a05:6870:2250:b0:261:142:7b95 with SMTP id 586e51a60fabf-273e654b961mr11669552fac.25.1724689260094;
        Mon, 26 Aug 2024 09:21:00 -0700 (PDT)
Received: from embed-PC.. ([106.222.235.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm7830742a12.42.2024.08.26.09.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:20:59 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: agx@sigxcpu.org,
	kernel@puri.sm,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: mantix: Transition to multi-context write sequence
Date: Mon, 26 Aug 2024 21:33:28 +0530
Message-Id: <20240826160328.12685-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated 'mipi_dsi_generic_write_seq()' macro
to 'mipi_dsi_generic_write_seq_multi()' macro in mantix_init_sequence
function.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index ea4a6bf6d35b..f276c65cc9bb 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -49,22 +49,25 @@ static int mantix_init_sequence(struct mantix *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct device *dev = ctx->dev;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};

 	/*
 	 * Init sequence was supplied by the panel vendor.
 	 */
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);

-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0xA9, 0x00);

-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
 	msleep(20);

-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
 	msleep(20);

 	dev_dbg(dev, "Panel init sequence done\n");
--
2.34.1


