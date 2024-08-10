Return-Path: <linux-kernel+bounces-281750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E394DAC7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E01C2112B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF13C9AF;
	Sat, 10 Aug 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovh12xhU"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388613C832
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265706; cv=none; b=GLffbSUu28SK/nsxQvE32w8crTGaCUhYTccjN9v7FmUU08eKtBqBGLeLOScrVlWKcuymhiNzbm0f37M6Hr0jXAKeRt3eh907NiotimKcKzfR04cYsrUh5MDQHyhc29HTozNqD34PvGDWzJUbYJrijC753qRXSS1XIKdlL7xpLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265706; c=relaxed/simple;
	bh=0G/Z/wVVwEAQeKnbFnydLmy+mhgn2ULLDkAD8G3p+5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqdpPpVGFbqy1yaClhsu8P6bWI2+mFqsicB110zLi+jUQ/4qswe0HppyfNqJcRmv3ajZv5Nk/Afg8y5h6W/IPgSOCPvDLWBTODXk7LsX80LbP++mnTPHxd85RjTMBiUjBAukMdPL4s3t/X1GBcVVD6ng9R+hQG0aFk1EwEaNrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovh12xhU; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db50abf929so2016963b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 21:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723265704; x=1723870504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS2eypZenlB0YB7xDQlNlol297l5Xqi9mIfw1aOttS8=;
        b=Ovh12xhUJKKNxnyIqAeDYVZ9dJmPL+NgYhxUzH7bNAv5U91v0lgIlzKBqcA0C+dEzS
         kIdiH3dIadaWBhAsGh5ozJ6l6qhNxvqvmEDfRXOgAUY04vzzYInW5xyCHtus3DRS/ZcG
         VNP2yXkJUWlJICeePYJrJ8mN1Pebm7yA0nvMuD5XeDlZ6rQ8/miugaqe9l5Srd9gUVCJ
         aOF9YImEpJvsmP12DQiiCf6nSXTNb+i9qJo5S4g1pnxwXtYt8/jsGD7VqMvBDQc4dBh0
         nLqB1QB7Z70Ut7E9gZv50EHTLEt+p5EGskxi59447yzH+l1/QxE2VoULLDxnNsl93mtc
         lSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723265704; x=1723870504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS2eypZenlB0YB7xDQlNlol297l5Xqi9mIfw1aOttS8=;
        b=U02rGK7dObyHXHfNwa6kaOymiBheMnbYGgFAIvDOXLQgU4USF6hi7o0ttrBF9R1vrE
         +ZMMDoV9Q3g5+raqfeiXOoiPT6h8vN42RkiiZYIFlP3z5LSGCf7XnfwmAX7PuBuXxivs
         u22xvenSOrXU3JlcK39n0cj98twky0e8FZzf6J2UnTIa392z70C8lVmso//fhVx26+C7
         NyeUQdrrknHZc4mufQ1CSdiORlQY3TDZ2zd4cu13feTNEBB85BaX36LsHNP+1+9yGVtg
         uKRNcV8l1sYDIINUfP57SMYFVOKJvvBJ6761HF1ZAn1+Buo8uvrljnZ8eSL6zsdCawBU
         6bFA==
X-Forwarded-Encrypted: i=1; AJvYcCUotRf0jZWE1zJ9qtM0r5bzMvjb0VfcqM2QmMjqVWS9YrjAH5HYZi4ITms8UkO2atXTpJOHyX2v2AGEXsGJ8NiYuhnNxI6NYgkQgAIp
X-Gm-Message-State: AOJu0Yzc+MLT8ifhHa3d9odzGH7d+sE00GECuY5ob1I1XOoJigKPETjf
	5kTACloQwy2+Zcs3IedRw7FYBxxoIbgD5NmseFyScj6CI81VoE2a
X-Google-Smtp-Source: AGHT+IHDNq0Y0g8CWga0ectmzl5Wbkm4MdbLEC+pLI0m00o5hpFZx9xFMZDa1UF7ISR8lw2Pl0kiiw==
X-Received: by 2002:a05:6808:6542:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3dc4166b4d4mr3997158b6e.10.1723265704323;
        Fri, 09 Aug 2024 21:55:04 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd82asm5227005ad.73.2024.08.09.21.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 21:55:04 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
Date: Sat, 10 Aug 2024 10:24:03 +0530
Message-ID: <20240810045404.188146-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810045404.188146-1-tejasvipin76@gmail.com>
References: <20240810045404.188146-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mipi_dsi_dcs_set_tear_scanline_multi can heavily benefit from being
converted to a multi style function as it is often called in the context of
similar functions.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 8d0a866cf1e0..b7ad18c148c2 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1339,6 +1339,9 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_pixel_format);
  * @dsi: DSI peripheral device
  * @scanline: scanline to use as trigger
  *
+ * This function is deprecated. Use mipi_dsi_dcs_set_tear_scanline_multi()
+ * instead.
+ *
  * Return: 0 on success or a negative error code on failure
  */
 int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline)
@@ -1833,6 +1836,34 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address_multi);
 
+/**
+ * mipi_dsi_dcs_set_tear_scanline_multi() - set the scanline to use as trigger for
+ *    the Tearing Effect output signal of the display module
+ * @ctx: Context for multiple DSI transactions
+ * @scanline: scanline to use as trigger
+ *
+ * Like mipi_dsi_dcs_set_tear_scanline() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
+					  u16 scanline)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_set_tear_scanline(dsi, scanline);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err(dev, "Failed to set tear scanline: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline_multi);
+
 static int mipi_dsi_drv_probe(struct device *dev)
 {
 	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 602be6ce081a..c823cc13ad1f 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -375,6 +375,8 @@ void mipi_dsi_dcs_set_column_address_multi(struct mipi_dsi_multi_context *ctx,
 					   u16 start, u16 end);
 void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 					   u16 start, u16 end);
+void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
+					u16 scanline);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.46.0


