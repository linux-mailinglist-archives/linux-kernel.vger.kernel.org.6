Return-Path: <linux-kernel+bounces-365542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A753C99E3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E84E1F23B43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998351E378C;
	Tue, 15 Oct 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUGnI3Jf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B11E8845
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988226; cv=none; b=NhFc2PB3WyFSBoBuULeJ8cIN8Dcs4YqcDkUN5v9r1JIFXWxWOvM27LaiAeoWwKZvA+fXt27TzMzQBQBuWMUlQu+78LZMewqEx4HXE5gwkr0m++qcTD7DB82K0XKSvV3qmZpfynYGhMathli1CGd/lH7oIPncj5bGbKgQm/CyWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988226; c=relaxed/simple;
	bh=Ia82g+53Q2XJBKpVg8RvNe+cQnDwdlkQPQWCwfZKGZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZmGbnpB4vhySqsSc9O27j5pyZREGpwaoX9ImpCury1pliRVQ4D61oaqJsX/oEo1rUxa2UZIVswcRmyG3BMVLBExQ5RDvh1SqHC2QL6Fn0KnRWEPAuTgnJn9oon/R40sZk92+0zC9vYCcXq2KACA3XXpNA4sT93WpD6Jr+pTXags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUGnI3Jf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e72db7bb1so817617b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728988224; x=1729593024; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2rr896UjJZIJvHhd5U5Pr+M2ve1yVZw4BPOf1jkh5k=;
        b=DUGnI3JfzU9e2urvq8NQlgfY61pcF73scG0D5WIvgGloh+RS7ZgiKLGw+dr84qgdmw
         kARgZYfThmd0+HRRSq7pJEjBr+JNROkKPNvCkmOCOYuKAG5L8fSX92b34SIv7fp/B/eW
         3XhvHVi5jgbAkLj8JvHTaNgjv3FXSZfDYjf9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988224; x=1729593024;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2rr896UjJZIJvHhd5U5Pr+M2ve1yVZw4BPOf1jkh5k=;
        b=TRpa3knaarMdPbowjp6gd87RC9Slz2KDb5vZe8YPdNPrCkdbbsTaFLq+JstmQ42QIh
         DFW3VS8LZlD5CZOErE/9xjP30/xt+0l/aB9Xd1a/8FvFWd0pr4ngsXfKR370Tv2JhA1s
         /wumv+Xnch/M6GGGyDoITbg4xKHydngFxv656d4CoTaL1+Jnsdoh0WUqsnrEtGc0JhIZ
         s2yEw2oJO5my6IbOGD+1SjfCROeO1gllb2FHEp+g+wx7XiDB/CuxmUsOjhWy+KtV4fTX
         Icyu9XYREDHC/OXhiQqhYphYFUVkg/mB4s8tB8rDSNUOv7jR36u7CUH0Ee66b14wXqGv
         DBig==
X-Forwarded-Encrypted: i=1; AJvYcCXHzmmQrDyK4LgsPjGdRoCn8fQd+O96Xh2o/OsdIfxRhAMr+r1dXjqzWClLACTY/u9Nx/MMys9zkqrVZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/W/jOjBYxw1tHIUTPgjC+3D49W3OoNKLd/e2ZbmLLMRSDHejq
	Da2+E2cHoUrz6IIa6QGzuyj6zzsM6rxUD8G5ccNb5xcsqA25I8MEfRzpCBLzZZn/Ep9KeeGMbui
	rNQ==
X-Google-Smtp-Source: AGHT+IFkLsd54kJuLGI+OOJF3TglxLq80CdGHR32sS02YQTnE9EsV0U9q3MfLsv+EAG7yVeyofCtWw==
X-Received: by 2002:a05:6a00:4b12:b0:71e:6c65:e7c4 with SMTP id d2e1a72fcca58-71e6c65e883mr5595571b3a.26.1728988223751;
        Tue, 15 Oct 2024 03:30:23 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370dfdsm946011b3a.42.2024.10.15.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:30:23 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 15 Oct 2024 10:30:19 +0000
Subject: [PATCH] drm/mediatek: Fix color format MACROs in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-color-v1-1-35b01fa0a826@chromium.org>
X-B4-Tracking: v=1; b=H4sIADpEDmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0NT3eT8nPwi3VQjA9NUc9MkM5PERCWg2oKi1LTMCrA50bG1tQBJIzI
 UVwAAAA==
X-Change-ID: 20241015-color-e205e75b64aa
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dianders@chromium.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
OVL"), some new color formats are defined in the MACROs to make the
switch statement more concise. However, there are typos in these
formats MACROs, which cause the return value to be incorrect. Fix the
typos to ensure the return value remains unchanged.

Fix: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 89b439dcf3a6af9f5799487fdc0f128a9b5cbe4a..1632ac5c23d87e1cdc41013a9cf7864728dcb63b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -65,8 +65,8 @@
 #define OVL_CON_CLRFMT_RGB	(1 << 12)
 #define OVL_CON_CLRFMT_ARGB8888	(2 << 12)
 #define OVL_CON_CLRFMT_RGBA8888	(3 << 12)
-#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
-#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
 #define OVL_CON_CLRFMT_UYVY	(4 << 12)
 #define OVL_CON_CLRFMT_YUYV	(5 << 12)
 #define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)

---
base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
change-id: 20241015-color-e205e75b64aa

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


