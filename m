Return-Path: <linux-kernel+bounces-284172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1194FDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CA32822D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5B433B9;
	Tue, 13 Aug 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSPYwpAA"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2513DBBF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530658; cv=none; b=lrd1cwSFIMrVePLxpCXQPGIXgNWB5WBseWevbaimaHE5mNnpTbOx9DrXbqvjSkJf3/uY2m5XxvSg0QranjNQjomg1zWwX7OCGT/v7VIt62V1vE24N64R6Vh6389M5iyVyewhVsBFYLlrhcq3D2nQGZ6n42B4iV0xh30cCEg/Hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530658; c=relaxed/simple;
	bh=O+dFhSSwMviCycogW/WqcduEniOW27fwihvWs/emkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca7VabNjhROX2oAKoDBzndAv/Apmo9nrV9a0dyAOG0HSwpwvxI5tq84yn7ZFQsEqdSEijZ19Ez2+/SQrZPiLLnv82J2mhU8VoiC3e0MVjcJLbe1cKzXiMOkTX0syCzq+nmP2ntCN/sNRSOub8taBFqXCPwON+jQ9BelYYgIpGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSPYwpAA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db22c02a42so3219307b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530656; x=1724135456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnhRO8oIbYzeyc2+UcIe5cCUCjnBIooF0x4NCKcs5c0=;
        b=hSPYwpAADm5LGYSxH2PV8wozURdP5T5wJaAVGq5NkI9GUlTOBGYcEYTWs/RqXxjSMH
         UE5OKWv6OOu+82MX1I5ZOpvoCvpiV/DeFq1IdVf9sfGQJxvGxT5tczQJuhSSJ8MV8S5x
         q3JduOWSC2lTNz+o2BFh3WUtQKMZqTxe2A6077NpOF3da9088+sxxpYCk+yv01VQB4//
         6uNnIvDT0QJ6ks9Eefva/+SxbnPUPXeszWYwA/2bJpg+F8niKOhfmMTqaYRjdolE4Oa/
         AWPxeuY26wVbli5OIc4nzpSB96A/nI5aZW2SqTtepNK4Hjw9tgjyKkwYOsKIljRffzkO
         4hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530656; x=1724135456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnhRO8oIbYzeyc2+UcIe5cCUCjnBIooF0x4NCKcs5c0=;
        b=ijGq3mqEYBC8fUUlzhCuPrtUzXnh+pXGTY/JBJIUd0goKGceholEaDZ4OXtBO95lIA
         E6Jm2+OUkChfFoYTmGyoSnlIEjPC2J4uZGTpjV9S6z1jtGP/fh5WU7jUS9M61gn3KRqa
         5YfF/gYcDLL/ZSHJu/rpIYePDJVAE963ISV/Ke0v67lHLh6z9s7QTjniGymWzRZ4vLPy
         EeO6tp9NhTIOztz2ALlsBxbsODuO4hqjUv5si6SbbSCFr17Lje6ZgAus+zf5uFgPq5+y
         S5dtGckobWg47yYNrl9zVdOvGN9dtkY1UeLIuL+Y5Mnd+rI4r5Pq4QKKRqrUUm/nKXq3
         7j2w==
X-Forwarded-Encrypted: i=1; AJvYcCX6dz6RH3rOmN/+mDXSgoIdpMO4JKxbWEcK9kaO9AG06Hx6C0YJGqt/CMF2v5uPH1t1jcdf4kAdOwOszytyUKub0qfOBlvJaS2HfCZf
X-Gm-Message-State: AOJu0YznvARk3RwrlwMeeZnPQkRBrreXsehh1jdQOXJAyhRsp68hlpnO
	Ld7m1wz/u5yRKhAKs0mC6K6kKA0d9yfSrYXtIN5gqOiBkxU0/wnib9vc1DhF
X-Google-Smtp-Source: AGHT+IGl8lpHE28XNKZxP+IXMifzfzU3TnIAs1cjru610NhqeJHIbTIlZ1khvSkQ6UxuCEbZ5iaDAw==
X-Received: by 2002:a05:6808:f8b:b0:3da:ab86:bfd7 with SMTP id 5614622812f47-3dd1edd2f60mr3438679b6e.3.1723530655907;
        Mon, 12 Aug 2024 23:30:55 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6325:9539:8b89:ebee:b1a0:5ff9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ef7sm4991965b3a.38.2024.08.12.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:30:55 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
Date: Tue, 13 Aug 2024 11:59:11 +0530
Message-ID: <20240813062912.467280-2-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813062912.467280-1-tejasvipin76@gmail.com>
References: <20240813062912.467280-1-tejasvipin76@gmail.com>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
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


