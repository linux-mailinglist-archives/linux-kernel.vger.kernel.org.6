Return-Path: <linux-kernel+bounces-280332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1794C8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D656BB24399
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77011804E;
	Fri,  9 Aug 2024 03:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkZM0vGv"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB317BCE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173848; cv=none; b=hBHKxa+TPdVHs7iK/TCEeC8SdLHFOrvip3SQQyiPLAeX9nDs0pZyzaiPj0BOgC9l5yDhGo/YLsR9TrG2aLsJ2dN9UgYs5Q+TnKZfgMG+pYLj2vw9HLnlAWqEpPGWrm8OiuTZBAncLRhQe3d91EBMrSQh6sYUJFLqWFe1JGDwnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173848; c=relaxed/simple;
	bh=IYAJ7WHW/yozr5fM9uxmyZfm3sJIvldTjgLKHshYTr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I0aMPRFf5A8oxLH5AeD2s7CvZ+yueEranDs1Jt348MWqP75I59H+IPdcLn5c4gMHOcaD/ke3i9PvLh5+aNTa9oNc7SF/RGdMKT9ARuizakWjbmYHfi7wf7SKm3uPgRNQSMmqL2NE9aGyu1bMGWZKUOFawTRw3IBeQT1wJlCFO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkZM0vGv; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260f057aa9bso1013487fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723173846; x=1723778646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFOK/hAUa0fw7FuOJzaSSnTG1BQkQ3YWl0HKcCK5k/Y=;
        b=lkZM0vGv4Htyfj19E7/T9EKHYKVxKHCnSxT6ogS3KifzfnLgCGfWTQbw26OUXtNjnL
         YSWC89sw197ThIhHAatN6mGYT3oRrsjBvGUhGJe7X0NEm+Yc0dYvOJoah6595/9k6WSR
         8gfvdRvXfffsUC3/UtF9I85dsds1IBNLeqIFke46l2cXbSnAKA2tbNpusI41uhww5ORo
         XfbWnGvJ/motJ6BnQl8ZNvWrSGUe+ixIkT0K+jHezcsCh6eB5or15PfmRZoKtNF2a1mb
         RUngd1/xvxLeI4rI34abf1+2LE+/JCoWA0sGIflBiuRgO6WGKPMcVmrj04WLqg7Xli7R
         Lbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723173846; x=1723778646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFOK/hAUa0fw7FuOJzaSSnTG1BQkQ3YWl0HKcCK5k/Y=;
        b=K4cBYSMiPRJSFGtZUtSbIGKTGxpCJBgUqKPOxvPwxTomzKEJZFWS1srFn+EwNymlDP
         FCFm9TgBAlZ0fjwzNX+duqT0mb2brSAodLEWN2PR7+6Pjgu1eVIJ0j7gr5MGtRQK/k7t
         vKu/0aBgaOCtilNWCAZlbAY5ij04IQ1TFHVIWeEnA8zUKWuCjJ8wYbBLlNiNFgnKRFIE
         VVYp7TTKj1CNhYHGBQiTeoxUSdW6Py3sJcrkbUPBYzkLLeMj4tlejeOg1x6XaikDK/aH
         EWYj+ZbIvFI2jyOGlQTwIjQaFuCesgkNNNfdbsWbvkjEIXgwRNQjYyh12Hx9Me2xWZus
         z1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGzd4SFP2qGDmhm2A8iZNv1zM0SSh2i+XXJJTElf6VlTK+LoMAWslyR1MZRtKL5B7RGuxW6X8cX/r+9g7M36dNWZ8gwh9StsAkCjcC
X-Gm-Message-State: AOJu0YxXtZwfWJzlPxTRUf2VBgcmpeJzC2Gs1IxCxV5mKm6p/S1ei9Dt
	wmlo7z89amWpynk0k/mclEYQapA+WnICXiTXTotsYwhYhc5BSBHB
X-Google-Smtp-Source: AGHT+IEjse90ATIO4w5F4sCUoF9JSdEdyJCL9sLs5MTq81S3LQ9AqIZ0nZ4JFQ9tE25/41wFjdz25g==
X-Received: by 2002:a05:6870:3282:b0:261:1339:1cb9 with SMTP id 586e51a60fabf-26c62f21d48mr379004fac.35.1723173845724;
        Thu, 08 Aug 2024 20:24:05 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-147-99.hsd1.ca.comcast.net. [76.133.147.99])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb20af7csm1840447b3a.19.2024.08.08.20.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 20:24:05 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: skhan@linuxfoundation.org
Cc: danielyangkang@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kerneldoc: Fix two missing newlines in drm_connector.c
Date: Thu,  8 Aug 2024 20:23:50 -0700
Message-Id: <20240809032350.226382-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808084058.223770-1-danielyangkang@gmail.com>
References: <20240808084058.223770-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the unexpected indentation errors.

drm_connector.c has some kerneldoc comments that were missing newlines.
This results in the following warnings when running make htmldocs:
./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2344: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2346: ERROR: Unexpected indentation. [docutils]
./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2368: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
./Documentation/gpu/drm-kms:538: ./drivers/gpu/drm/drm_connector.c:2381: ERROR: Unexpected indentation. [docutils]

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---

Notes:
    v2: added "Fix the unexpected indentation errors" line to description.

 drivers/gpu/drm/drm_connector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 80e239a6493..fc35f47e284 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2342,7 +2342,9 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *
  *	Default:
  *		The behavior is driver-specific.
+ *
  *	BT2020_RGB:
+ *
  *	BT2020_YCC:
  *		User space configures the pixel operation properties to produce
  *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
@@ -2366,6 +2368,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *		range.
  *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
  *		driver chooses between RGB and YCbCr on its own.
+ *
  *	SMPTE_170M_YCC:
  *	BT709_YCC:
  *	XVYCC_601:
@@ -2378,6 +2381,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
  *	DCI-P3_RGB_Theater:
  *	RGB_WIDE_FIXED:
  *	RGB_WIDE_FLOAT:
+ *
  *	BT601_YCC:
  *		The behavior is undefined.
  *
-- 
2.39.2


