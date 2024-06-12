Return-Path: <linux-kernel+bounces-211925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8869058F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7352838E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13A181335;
	Wed, 12 Jun 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL8kzMO/"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91516F295
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210434; cv=none; b=dY/wr4Qz2xwjwbE5fqRVFSx1Q5GlTur4r0T5xN0GaCH57C+ZyD8HEdAj7C9KQzIr1LIFwOenQkQwkSCKVruquHKF6oFk9d+WmcKIO3sSjAhal1nEnKbccvVZsmTBW74/o2oNEpM600KDi+rjsQioAaeAmTwxYI/9I/0W5lOW0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210434; c=relaxed/simple;
	bh=yQfm4fTI1kU8oTLuDRVYh96VK9rTEhFZBrFHJJ0QC5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYn9Y8KaHsPxjpBi75hLyt1/N3+XcL7lY5xVLR1YP/w1w/OV9HJp5+nMr9+vLg24QjD5bhiMsxKA1/HHBQTW/2YDyRRP9/hgIn1VbYaBnRx1nWKmSfRh47mraAeAAj/bRxpEDp3vRkFjQVBa9aIFfcpbGbr+LmUea42GfI50hzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL8kzMO/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627f3265898so478197b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718210431; x=1718815231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIz169PpZV9T7G/7oNgdKMkmMf+7MFt49ljIJTorYiA=;
        b=DL8kzMO/ommv7aQxT3TZLMmP4q3azFHzRAbPAoJApEOgqkj8+WhS0hBDzZhScWotmL
         flhaYVu07aWmahmd7K4ZIznqSzf3dWpXglbSz1pfcIv8WUdihhfxQEb/XnJFTgbumZx0
         YSATQM3+Q0w0vikvXZ84wOqhCTB1KbXq9/hNsan08tVlGw1Nqm4p2l7JIbKyswFBU93r
         u8eZ5qoyAC6f1RLLOLCD9ooqcLh2EhiEAvwn5RWlNlCZhiiw3ED25TkPdpj2QnoqwjZl
         qU061Yf4uqBIKtsq4Bp4Jgdlwv6fN3NwT0ZmfMYqjK6D5WyJFcZXCGxKg7CLveP1f44f
         +ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210431; x=1718815231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIz169PpZV9T7G/7oNgdKMkmMf+7MFt49ljIJTorYiA=;
        b=nbgQJy8wLS8Q5rzmc8t7S3biO+bVcWh55TKz/1K7+GSE8HRYAutKw3sWYDwIVU3SDe
         Gd9/sSULNxpiPUBSh9A30vyt4LovATgXMwFX+KaVck7fAvupYqfHRfLG+9K/0L8UhC26
         4ymG4gaU6p0XLVl/LTC7THw0sLOi422JodxW0C3LDr6DcynlHl2TKwu+TVfabunRmyCN
         Ka37nZ3eH+yiF9gugosMGr3dWq5zYr7RqwMiUaC3jslC8bUd3s/lfKmvKLMdM5Vf+3AO
         SOCtNsiExVLO+Ra7+jGulfurbWXVhBcBYsI/yhKAv6B0ZWX+drSgjwQe5w7qSn9/cmyO
         Cm2w==
X-Forwarded-Encrypted: i=1; AJvYcCXs9l63QLs1oJwcfaxR9pJvSekb4ieRwj05GneUUkFAKa9PLebivJWozpc5wUeY6XG4BIhfOxRkOgSH0gA+E8RLyUl14cTVOrqx1xL2
X-Gm-Message-State: AOJu0Yw3DH044Oyx8l44sy2M8IGOeWOydRPAitEz5LpfXmlsPX2MlH90
	n0yiDz6fO6OJ1sFs7KjmB+NEJzCoecTOdRS2OpPXkcQ+SaZPYSHW
X-Google-Smtp-Source: AGHT+IG7+pdqAs8AKo6B8zNylr3faApsWCB77bEKKii1y8GOvV0FxkrvG9s07bxTFRvZBpjz1NFN5Q==
X-Received: by 2002:a05:690c:f15:b0:630:8c44:24db with SMTP id 00721157ae682-6308c44956dmr10375327b3.22.1718210430553;
        Wed, 12 Jun 2024 09:40:30 -0700 (PDT)
Received: from distilledx.localdomain ([103.246.195.195])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccace6542sm24469047b3.36.2024.06.12.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:40:30 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/panel: truly-nt35521: transition to mipi_dsi wrapped functions
Date: Wed, 12 Jun 2024 22:09:42 +0530
Message-ID: <20240612163946.488684-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") for the
sony tulip truly nt35521 panel.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v3:
    - Fix code style
    - Changed calls to mipi_dsi_msleep

Changes in v2:
    - Fix patch format
    - Fix code style

v1: https://lore.kernel.org/all/485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com/

v2: https://lore.kernel.org/all/3288287d-8344-4b37-a333-722cf12fef13@gmail.com/
---
 .../panel/panel-sony-tulip-truly-nt35521.c    | 433 +++++++++---------
 1 file changed, 207 insertions(+), 226 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
index 6d44970dccd9..4b5088b95861 100644
--- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
+++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
@@ -44,248 +44,229 @@ static void truly_nt35521_reset(struct truly_nt35521 *ctx)
 static int truly_nt35521_on(struct truly_nt35521 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xff, 0xaa, 0x55, 0xa5, 0x80);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x11, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x20, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x21);
-	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x01, 0xa0, 0x10, 0x08, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x01, 0x02, 0x0c, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x11, 0x11);
-	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x09, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x09, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x8c, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x8c, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xca, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x04);
-	mipi_dsi_generic_write_seq(dsi, 0xbe, 0xb5);
-	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x35, 0x35);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x25, 0x25);
-	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x43, 0x43);
-	mipi_dsi_generic_write_seq(dsi, 0xba, 0x24, 0x24);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xee, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xb0,
-				   0x00, 0xb2, 0x00, 0xb3, 0x00, 0xb6, 0x00, 0xc3,
-				   0x00, 0xce, 0x00, 0xe1, 0x00, 0xf3, 0x01, 0x11);
-	mipi_dsi_generic_write_seq(dsi, 0xb1,
-				   0x01, 0x2e, 0x01, 0x5c, 0x01, 0x82, 0x01, 0xc3,
-				   0x01, 0xfe, 0x02, 0x00, 0x02, 0x37, 0x02, 0x77);
-	mipi_dsi_generic_write_seq(dsi, 0xb2,
-				   0x02, 0xa1, 0x02, 0xd7, 0x02, 0xfe, 0x03, 0x2c,
-				   0x03, 0x4b, 0x03, 0x63, 0x03, 0x8f, 0x03, 0x90);
-	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x03, 0x96, 0x03, 0x98);
-	mipi_dsi_generic_write_seq(dsi, 0xb4,
-				   0x00, 0x81, 0x00, 0x8b, 0x00, 0x9c, 0x00, 0xa9,
-				   0x00, 0xb5, 0x00, 0xcb, 0x00, 0xdf, 0x01, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xb5,
-				   0x01, 0x1f, 0x01, 0x51, 0x01, 0x7a, 0x01, 0xbf,
-				   0x01, 0xfa, 0x01, 0xfc, 0x02, 0x34, 0x02, 0x76);
-	mipi_dsi_generic_write_seq(dsi, 0xb6,
-				   0x02, 0x9f, 0x02, 0xd7, 0x02, 0xfc, 0x03, 0x2c,
-				   0x03, 0x4a, 0x03, 0x63, 0x03, 0x8f, 0x03, 0xa2);
-	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x03, 0xb8, 0x03, 0xba);
-	mipi_dsi_generic_write_seq(dsi, 0xb8,
-				   0x00, 0x01, 0x00, 0x02, 0x00, 0x0e, 0x00, 0x2a,
-				   0x00, 0x41, 0x00, 0x67, 0x00, 0x87, 0x00, 0xb9);
-	mipi_dsi_generic_write_seq(dsi, 0xb9,
-				   0x00, 0xe2, 0x01, 0x22, 0x01, 0x54, 0x01, 0xa3,
-				   0x01, 0xe6, 0x01, 0xe7, 0x02, 0x24, 0x02, 0x67);
-	mipi_dsi_generic_write_seq(dsi, 0xba,
-				   0x02, 0x93, 0x02, 0xcd, 0x02, 0xf6, 0x03, 0x31,
-				   0x03, 0x6c, 0x03, 0xe9, 0x03, 0xef, 0x03, 0xf4);
-	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x03, 0xf6, 0x03, 0xf7);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x22, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x22, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x05, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x05, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x05, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x05, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xba, 0x53, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x53, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x53, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x53, 0x00, 0x60, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x00, 0x34, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x00, 0x00, 0x34, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x00, 0x00, 0x34, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x00, 0x00, 0x34, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x60);
-	mipi_dsi_generic_write_seq(dsi, 0xc5, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x05);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x17, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x00, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xba, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x02, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x02, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x03, 0x03, 0x00, 0x03, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x0b);
-	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0xc2, 0xa6);
-	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x05);
-	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x22);
-	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x07, 0x20);
-	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x03, 0x20);
-	mipi_dsi_generic_write_seq(dsi, 0xca, 0x01, 0x60);
-	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x01, 0x60);
-	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x00, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xcd, 0x00, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xce, 0x00, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xcf, 0x00, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xd1, 0x00, 0x05, 0x01, 0x07, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x10, 0x05, 0x05, 0x03, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x20, 0x00, 0x43, 0x07, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x30, 0x00, 0x43, 0x07, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xd0,
-				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd5,
-				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-				   0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd6,
-				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-				   0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd7,
-				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-				   0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xe5, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xe6, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xe7, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xe8, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xe9, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xea, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xeb, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xec, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xed, 0x30);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x2d, 0x2e);
-	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x31, 0x34);
-	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x29, 0x2a);
-	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x12, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x18, 0x16);
-	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x08, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xba, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x31, 0x08);
-	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x03, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x17, 0x19);
-	mipi_dsi_generic_write_seq(dsi, 0xbe, 0x11, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xbf, 0x2a, 0x29);
-	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x34, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x2e, 0x2d);
-	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x2e, 0x2d);
-	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x31, 0x34);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x29, 0x2a);
-	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x17, 0x19);
-	mipi_dsi_generic_write_seq(dsi, 0xca, 0x11, 0x13);
-	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x03, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x08, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xcd, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xce, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xcf, 0x31, 0x08);
-	mipi_dsi_generic_write_seq(dsi, 0xd0, 0x00, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xd1, 0x12, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x18, 0x16);
-	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x2a, 0x29);
-	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x34, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xd5, 0x2d, 0x2e);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xd7, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xe5, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xe6, 0x31, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd9, 0x00, 0x00, 0x00, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xe7, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x47);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x0a);
-	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x02);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x17);
-	mipi_dsi_generic_write_seq(dsi, 0xf4, 0x60);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xf9, 0x46);
-	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x11);
-	mipi_dsi_generic_write_seq(dsi, 0xf3, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd9, 0x02, 0x03, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x6c, 0x21);
-	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x80);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x11, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0x20, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x21);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x01, 0xa0, 0x10, 0x08, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb8, 0x01, 0x02, 0x0c, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x11, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x09, 0x09);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x09, 0x09);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x8c, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x8c, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x04);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbe, 0xb5);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x35, 0x35);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x25, 0x25);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x43, 0x43);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba, 0x24, 0x24);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xee, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0,
+					 0x00, 0xb2, 0x00, 0xb3, 0x00, 0xb6, 0x00, 0xc3,
+					 0x00, 0xce, 0x00, 0xe1, 0x00, 0xf3, 0x01, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1,
+					 0x01, 0x2e, 0x01, 0x5c, 0x01, 0x82, 0x01, 0xc3,
+					 0x01, 0xfe, 0x02, 0x00, 0x02, 0x37, 0x02, 0x77);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2,
+					 0x02, 0xa1, 0x02, 0xd7, 0x02, 0xfe, 0x03, 0x2c,
+					 0x03, 0x4b, 0x03, 0x63, 0x03, 0x8f, 0x03, 0x90);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x03, 0x96, 0x03, 0x98);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4,
+					 0x00, 0x81, 0x00, 0x8b, 0x00, 0x9c, 0x00, 0xa9,
+					 0x00, 0xb5, 0x00, 0xcb, 0x00, 0xdf, 0x01, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5,
+					 0x01, 0x1f, 0x01, 0x51, 0x01, 0x7a, 0x01, 0xbf,
+					 0x01, 0xfa, 0x01, 0xfc, 0x02, 0x34, 0x02, 0x76);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6,
+					 0x02, 0x9f, 0x02, 0xd7, 0x02, 0xfc, 0x03, 0x2c,
+					 0x03, 0x4a, 0x03, 0x63, 0x03, 0x8f, 0x03, 0xa2);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb7, 0x03, 0xb8, 0x03, 0xba);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb8,
+					 0x00, 0x01, 0x00, 0x02, 0x00, 0x0e, 0x00, 0x2a,
+					 0x00, 0x41, 0x00, 0x67, 0x00, 0x87, 0x00, 0xb9);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9,
+					 0x00, 0xe2, 0x01, 0x22, 0x01, 0x54, 0x01, 0xa3,
+					 0x01, 0xe6, 0x01, 0xe7, 0x02, 0x24, 0x02, 0x67);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba,
+					 0x02, 0x93, 0x02, 0xcd, 0x02, 0xf6, 0x03, 0x31,
+					 0x03, 0x6c, 0x03, 0xe9, 0x03, 0xef, 0x03, 0xf4);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x03, 0xf6, 0x03, 0xf7);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x22, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x22, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x00, 0x34, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x60);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0xc0);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x05);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb7, 0x17, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb8, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x02, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x02, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x03, 0x03, 0x00, 0x03, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x0b);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x09);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0xa6);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x05);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x22);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x03);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x07, 0x20);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x03, 0x20);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x01, 0x60);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x01, 0x60);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x00, 0x05, 0x01, 0x07, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x10, 0x05, 0x05, 0x03, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x20, 0x00, 0x43, 0x07, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x30, 0x00, 0x43, 0x07, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7,
+					 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe8, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe9, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xea, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xeb, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xed, 0x30);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x06);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb2, 0x2d, 0x2e);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb3, 0x31, 0x34);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb4, 0x29, 0x2a);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb5, 0x12, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb6, 0x18, 0x16);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb7, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb8, 0x08, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xba, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbb, 0x31, 0x08);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbc, 0x03, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbd, 0x17, 0x19);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbe, 0x11, 0x13);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xbf, 0x2a, 0x29);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc0, 0x34, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc1, 0x2e, 0x2d);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc2, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc3, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc4, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc5, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc6, 0x2e, 0x2d);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc7, 0x31, 0x34);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x29, 0x2a);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc9, 0x17, 0x19);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xca, 0x11, 0x13);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcb, 0x03, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcc, 0x08, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcd, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xce, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xcf, 0x31, 0x08);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd0, 0x00, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd1, 0x12, 0x10);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd2, 0x18, 0x16);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd3, 0x2a, 0x29);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd4, 0x34, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd5, 0x2d, 0x2e);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd7, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe5, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe6, 0x31, 0x31);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xe7, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0x47);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x0a);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf7, 0x02);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x17);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf4, 0x60);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf9, 0x46);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x6f, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf3, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x35, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd9, 0x02, 0x03, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb1, 0x6c, 0x21);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x35, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
 	usleep_range(1000, 2000);
 
-	mipi_dsi_generic_write_seq(dsi, 0x53, 0x24);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x53, 0x24);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int truly_nt35521_off(struct truly_nt35521 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(50);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(150);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 150);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int truly_nt35521_prepare(struct drm_panel *panel)
-- 
2.45.2


