Return-Path: <linux-kernel+bounces-352689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1E9922B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2390D1F21EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D867107A0;
	Mon,  7 Oct 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9R8ezC8"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99A1078B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728266631; cv=none; b=M10QU0BzMVfNHbpXSU3S0mnA9EtV7qJ7JRDhhg70PKHrLK9DKGzW8DiToEhdnhQxQF6rpKyezALOQF0Y5eGEU961mPiJ1Mz2crdXrl/64+3q0Tf3SAcnkgABfJQQmQ7yg/NgMAZhF0VAVK/EtL2bLbJcai4E1eBlX7OOJzM8kxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728266631; c=relaxed/simple;
	bh=sG+JPZ4pxbl8B/u+IZusjl8tD7o7nVq8LbrQ5YajAl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u23QOLiOhNMYwojQdwYusvwZgvgZprMfjx++eFVxTG24UfRdboek6j6tueShDDw0iSqYxMG0LEqq9YSYYgu2Qi9oJ2Ew0DCg/efiqXek/tsLLfkRFKncoN1KK6yOsen8bRazVb/f5qUJlPw7obQWVzdCfBnFzoJNipb1ydNHgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9R8ezC8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2531786a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 19:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728266629; x=1728871429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hH8n23sDEKbwaTmLkfdoZ+DyRO45NetuWgQWtqCNa5g=;
        b=K9R8ezC8wrwxP+3coaDlS8gRpXHj0MjHU2GxuHiI+Lg0y3OoUfqb0vu5okTYcipfqu
         OAx0jKip90BtOJccfpYbAfuB7zFyphIqmXKwBXiVjFvrzug+1kPaIWJFFGSl5In4Wc/p
         4Dxp0Xec/yGoUrykHJkoX/5sD4CVaDS+Zoij2o8srjs8Lu3lMHlMe6JgssR+UZefQ0bC
         CqKC9g4RSj8yyKYhPVpfuiv5ug/FyuqC1EcsjUDRJ9FF9WHBkd0omWXXFd+zH7f0SJrQ
         tyjdRvqdKqJZG3Vg6McR/qsgSylD2+LE/Jb5AszV1SeKZ+grqvKkkhrbop9uHaQsRJOj
         VsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728266629; x=1728871429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH8n23sDEKbwaTmLkfdoZ+DyRO45NetuWgQWtqCNa5g=;
        b=vJ9c32qF626wDCna9e79YBQuOcBF2suUm3+uFezTEmiX+/DjCYqhB6p9q645RM+8Zh
         FHaYUz9LgWrfENOrU5/chACW5ofXB/cbd755PtRI6Miqh4+oFMnTcYUEEfGivkXBNr7h
         UXej+O6DeZ4Xpd5S1tGbXvz1ZNEnpmNJouarpOmAx+Y50hBrQzlOpih2wBksxalS36zP
         cHHZixV3ML96NQW3BxhxviZK1daXNThlkGlnGxI2iCkNkEuCKer/RwRPwhI+rS1ghVLL
         IUvseZba1mhbKBkP2QvKjqO2zcSGymLUsFIw0wCUCgMjSi3DIuA1KzR69EekwvNKclPh
         WYTg==
X-Forwarded-Encrypted: i=1; AJvYcCW15ZD5fj6IGV5SnhUvBVeFM1yjLGtxuozKyrusWk73DiN3m4IFjYH06xqkgwqadItzNpzCEs8uKz7UsNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaa6wTb0xDQ6tBkQvPbeWztoEQt/du3LFjbgYC5zcVpgtmpkg
	XupyUKzHxPdBvcZh1qIIGQXy9tisKIbx9VZX1OF9VR8KfReDiBhs
X-Google-Smtp-Source: AGHT+IFmL2pAxARWCe0kDikhq0H2GuyhDlOp6loTG4gTtUTjS9cAkcIXigtrDoSH6+5HD+N8M7QCUA==
X-Received: by 2002:a05:6a20:841a:b0:1d6:e227:c34 with SMTP id adf61e73a8af0-1d6e2270c35mr14526492637.0.1728266629071;
        Sun, 06 Oct 2024 19:03:49 -0700 (PDT)
Received: from raven-lpc.. ([158.62.27.110])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0d65283sm3470369b3a.146.2024.10.06.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 19:03:48 -0700 (PDT)
From: Raymond Jay Golo <rjgolo@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Raymond Jay Golo <rjgolo@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Chuwi Hi10x
Date: Mon,  7 Oct 2024 10:02:23 +0800
Message-ID: <20241007020258.2202786-1-rjgolo@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Chuwi Hi10x uses a panel which has been mounted
90 degrees rotated. Add a quirk for this.

Signed-off-by: Raymond Jay Golo <rjgolo@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 0830cae9a4d0..2fe1e85b97bb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -234,6 +234,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Chuwi Hi10x */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CHUWI"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 X"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Dynabook K50 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),
-- 
2.46.2


