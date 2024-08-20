Return-Path: <linux-kernel+bounces-293606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6109581E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975CD1C2411B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563A18B49E;
	Tue, 20 Aug 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isTGbhnk"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D74018C357
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145373; cv=none; b=etg//MNRaxqkWXkU1QSh+GAuZNcPJRsa9NP7e7fDGyfwJbB2gnJoksP/KxMCwxbudknSe8tnr1do1fYRKN78IOwxe64Ia0j2Ze+dyeA7uiymy6T21ADaX10LUm1tUbJtiEW4tn2nxe+lhPl3wliIVHLZnpzlNtsOemHfizPI9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145373; c=relaxed/simple;
	bh=JP6ycWIyFf5oZnrrWUruhTrcwbcT8MN0vawnvH+k0O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFxA2yR3MsrHKXXfSw1cePmR9X50oQTeG6HFBQ7V8yaJlp70B0UUFlOVlD6C7ZcPPxkYEkOHyT3+jE3bmmpzgSGMTxEOuMi/tJH6la68uIBqU705YkIqyNxrTP5RtdkG0ZzHh78DeapN+mt205kzZwcamuRGT2p9IFAGxpUpvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isTGbhnk; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db16a98d16so3177490b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145371; x=1724750171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZnaHK4EX6IXmSa9S9DVv4ypDChh4Hz7REiF4MLYT2E=;
        b=isTGbhnk4+RTYMGYtukhhHCyT3PJWbFzxE8+j6XT9Jj/3t91cz8ATYj8UROGQvZuc9
         RADiwuLhQr4c8AqPBQXESe4bU28SBhy6niJXw9Sd69+uMz6xV5zCYR+cF0X71MzaG5Ki
         6blFCxkO0JWngQe6V9ZnPccaog8/DJLNlkZn1ZhPOWumL5gLAiGBwogmukd2jIWcg7sH
         NxNoRLi2n02vZAvmWOnAkPVfrYxZiLDjQR1uJh6vn6fcMva7LnHSo/GpD1laWPh9+lVA
         6Mfr0AyWjUxa8Soy1w9AUxMCcJsi7cfOo06VAevqj9rzjO92zZ/0d6Spmgpaknz2lSn8
         KOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145371; x=1724750171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZnaHK4EX6IXmSa9S9DVv4ypDChh4Hz7REiF4MLYT2E=;
        b=QBJGVDmIxpJxmQHjTlR1sGqUVxo7l5mrzKqROFzDuwO2XYUvWRoSWpJhjBF996cKzr
         wfWE+dM+fLim6kE+IpBOgryNhAfaKqYr1W2xAI2jeDXGn8v0a4rBPsJZXe58Z7L0PaCH
         +NnMmsC1SXZmDt5rMGMwFwWxgrnexj3HEpUhBfIoGwfr/EXOOnwPhkUNStiydH72SxlH
         DJ57irza320EjWqEHh3/0HRRw3lwUXGBy27hdfhmsCEUmUF6r1VSEAwxIXvdnA2UmjIf
         V7Gg+MnX7FUgPLzWCycKmqeLB36CKNzTLpdFRrCvftdez8nKAs+RsO+bkrLRPwi/sfIP
         CvGw==
X-Forwarded-Encrypted: i=1; AJvYcCWDiPN/qjhpywleOyhHJzHC/lk7Uh6CYOy37WJIJ0Cti/9PLF8NP7Z02b614zW48zUGRh5CA0fyGXE+MqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFGt004xvvlb2lXA/ErMq66+Uc28jaMKsPKW2oO4aWVYDAUL9
	z/068FeaRYVm6Dp+teDx2BrkdCOk8xsZN2bDAHC31RX0uk48SZMp
X-Google-Smtp-Source: AGHT+IElZDUwhMSDH0FDHumsr9AKfUYm79jWusnz6NH1EUP4PLg/jLaGdGff1MfL5CxZm62Q+HYkWQ==
X-Received: by 2002:a54:4e8d:0:b0:3d9:3f51:f351 with SMTP id 5614622812f47-3dd3acec2ecmr12843378b6e.11.1724145371166;
        Tue, 20 Aug 2024 02:16:11 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6f12sm8998575a12.35.2024.08.20.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:16:10 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: agx@sigxcpu.org,
	kernel@puri.sm,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 2/2] drm/panel: mantix-mlaf057we51: write hex in lowercase
Date: Tue, 20 Aug 2024 14:45:54 +0530
Message-ID: <20240820091556.1032726-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820091556.1032726-1-tejasvipin76@gmail.com>
References: <20240820091556.1032726-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converts uppercase hex to lowercase hex for cleanup.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 2a365eaa4ad4..4db852ffb0f6 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -23,7 +23,7 @@
 
 /* Manufacturer specific Commands send via DSI */
 #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
-#define MANTIX_CMD_INT_CANCEL           0x4C
+#define MANTIX_CMD_INT_CANCEL           0x4c
 #define MANTIX_CMD_SPI_FINISH           0x90
 
 struct mantix {
@@ -50,18 +50,18 @@ static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 	/*
 	 * Init sequence was supplied by the panel vendor.
 	 */
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a);
 
 	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xA9, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x03);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xa9, 0x00);
 
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x09);
 	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
 	mipi_dsi_msleep(dsi_ctx, 20);
 
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
-	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xa5);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2f);
 	mipi_dsi_msleep(dsi_ctx, 20);
 }
 
-- 
2.46.0


