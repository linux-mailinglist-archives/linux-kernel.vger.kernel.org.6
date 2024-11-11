Return-Path: <linux-kernel+bounces-404519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A39C44B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905F31F21B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF031AA1CA;
	Mon, 11 Nov 2024 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmhxaNdb"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0C136E28
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348891; cv=none; b=bgThKS+KUtDWaD2L71vFVmCoJWOe0IcTK37mWKW2CuJWmcXdRa17ATWyWG1YkfcvPQymNUVFZvRniW+pFl5Q7ZMRsGuoFvRduRONGec0n38Bwawqj0kAPA1lMwBGWAExYRNf9iQAF7KVkyoIsz5ZcNyE+9wz0bIV2HYIiN6BXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348891; c=relaxed/simple;
	bh=2TXJ1EmXXe6JGcHq0islC06ZuiS7W6be+KOSVMPiOMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WTQf+6R2ctTCUO4SbSkcU/rN1XvFq/bWa+IVFYfvhV+qo5uBG7u384RZPRT+/gStgW7sBIgo3g+mGwVPI10+N4NU1zeTUO0maB0NWEiBEfGxVUEa6Bqk4vJQugw2ZI5tQjX316MF4s70JnyfLgnVqNe2yf8gx9tDzt0DXNWQy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmhxaNdb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3757311b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348889; x=1731953689; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcG5Ghtfgj5GW/5qfLw7yewkg+yGj/V/bjMocxCMdSQ=;
        b=SmhxaNdb5d/QVQlKjYfiIcDvX0kDS3N0T/NpvL4/q7nGixg3C/+NtBZfu+3+uVFJ+x
         Iw428P5mg83jF3HyuevY8WVncxhQgngd762FQ3g3wutOZQqOBvOyoV96z2gHWWw2svGx
         Da4QlTnMcRVV7sPk0Ugv+U0GrJV6YFD0uVLX9rQkS+G/S3Shg1evrv1mDrFQPNvSbmFO
         xgnh7Bw3UUA7cK+fZfo6xrThMwFL+Wf2Qclgri8meHkJeDL0DGmU3NHojVOxNdF/xNYR
         dH4qaJoTUXECApVURs9YD6jNI/CUkmma5T3VwkHGXlSzUjnuQB+iUjgak//jEma8HBwR
         l/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348889; x=1731953689;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcG5Ghtfgj5GW/5qfLw7yewkg+yGj/V/bjMocxCMdSQ=;
        b=KkGlmnI5Ou3ha59+l4OtIhQCHi0SENkti5UIvv8HtBuCqtRtiRhFKJ1zGq7G2O4auj
         WGDybb6h6ppEBqyYlWmRCPV+WZDzOnywkMVQuzOXfECvJdjse1hQ3WA3kgGThIdtRHRb
         hBW1y6hR2n7Lx6xZAJeYR75FhmkyWU2WbuYjnGfXO+NLmCVv3PWg1RVL+NJ6/Pt9nIQJ
         aeg1z//9JpTFRnvAzdujL17zwDnRqArxYItYLJwuIBX8nDqSW4YoLyTCAgsU5pgrVN46
         8roD3tjfN15tgIa7SMMo/1/5HBKLvGhX53mh3BQv9rfoU01bY9/w6LIUVUZWPMNUtIKB
         tdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmzaVR/VrXLOo4RUaOceLl3QCoq3UcMrFEXZO5A3ktPk/YT91pO7xhnXTJf/v72VL84gb3aYdrgxveRmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UsLVxE4deEGEGN8oYympBkgGuD4Sk27vJ05ilVsC6/U1NLus
	VI4y7tCE+H7OppyrwhF5kOroazl4+5w0/9IlPCV3BKv56msOKSrN
X-Google-Smtp-Source: AGHT+IHRY0yX/5Z9BgqASQU4ZZ39SI5JUr83H/XUjHQ21anzAVa6uoUX7kOFpkJY9khvsfngWxmH4g==
X-Received: by 2002:a05:6a20:a10e:b0:1db:ebf4:2cb8 with SMTP id adf61e73a8af0-1dc22b38e98mr19023560637.38.1731348888950;
        Mon, 11 Nov 2024 10:14:48 -0800 (PST)
Received: from Emma ([2401:4900:1c94:38cd:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5d9460sm7537614a12.35.2024.11.11.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:14:48 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 11 Nov 2024 18:14:43 +0000
Subject: [PATCH] drm/mediatek: Initialize pointer before use to avoid
 undefiend behaviour
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-uninitializedpointer1601557-v1-1-7d03668e8141@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJJJMmcC/x3MQQqDMBBG4avIrBtIotG2VxEXxkzrDzJKYoso3
 t3g232bd1DiCE70Lg6K/EfCLBnmUdAw9vJlhZBNVtvK5NRPIFjRT9g5LDNk5WhqbZxr1OupS99
 Y52sfKB+WyB9s973tzvMCtI1RQm0AAAA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Sui Jingfeng <sui.jingfeng@linux.dev>, CK Hu <ck.hu@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731348885; l=1580;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=2TXJ1EmXXe6JGcHq0islC06ZuiS7W6be+KOSVMPiOMY=;
 b=XnSsGvh9arXwU0TzFneIvfBvnhGG3ywcwXCrVXSmtOIjjRf655y5J6qAlm7chmE39XOFBDzZe
 nUFfZpHEs26DRSdOnEKnl4vOjiv5k/rnxZz0tZkMGvmD1Uwys+tKhXs
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Initialize the pointer with NULL as mtk_drm_of_get_ddp_ep_cid
function might return before assigning value to next pointer
but yet further dereference to next can lead to some undefined
behavior as it may point to some invalid location.

Fixes: 4c932840db1d ("drm/mediatek: Implement OF graphs support for display paths")
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity Message:
CID 1601557: (#1 of 1): Uninitialized pointer read (UNINIT)
3. uninit_use: Using uninitialized value next.

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/10043/11354?selectedIssue=1601557
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9a8ef8558da9..bc06c664e80f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -900,7 +900,7 @@ static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path
 					 const unsigned int **out_path,
 					 unsigned int *out_path_len)
 {
-	struct device_node *next, *prev, *vdo = dev->parent->of_node;
+	struct device_node *next = NULL, *prev, *vdo = dev->parent->of_node;
 	unsigned int temp_path[DDP_COMPONENT_DRM_ID_MAX] = { 0 };
 	unsigned int *final_ddp_path;
 	unsigned short int idx = 0;

---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-uninitializedpointer1601557-9803b725b6bd

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


