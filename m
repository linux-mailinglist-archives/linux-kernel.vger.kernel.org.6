Return-Path: <linux-kernel+bounces-367895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFB69A0811
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C2F284DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C682076A7;
	Wed, 16 Oct 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Asw3Ep7U"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257C207200
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729076929; cv=none; b=TZ8VtW9RB1wIswTEkN0sCG0uDG6yFj5sICw/n6Iy1z+DYLKpVOOUO8TKooyuuUt++Yb5Zp3LYTEf+nsCUbcf21FwwHttAtbA33/dLEDgZapzMb0r4yKuJKAA9zol32UUA31Av/PbDiWT/ZvanLIkHpYlFX4tatTzMPT6XO7tHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729076929; c=relaxed/simple;
	bh=117oV/Fdsnisrrdieh3F7T0J7TJ1cxxT8CI2vcEQTlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tzIi7INV+aDCSQ5zLKWSlJkwjK6FbENamv8GIo8DIcYDzoK/V1NUt24sE7FRMpvzc4qHIuHpzO5l8ItMGe+HCoMEuv3kJVSHq7Id1byE0/Kk+wab6jDwAe+6H1kWJY3J+yN2xOusbbDWhf0kJ2X6KGiZ/N2cqYXe3k3yJDszkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Asw3Ep7U; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5611484a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729076927; x=1729681727; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4u1X+4asBMPU91TR1WAl6Ub71JuEkCWwBm90GJmfMc=;
        b=Asw3Ep7UtbUQRi5Z2KFQ+/lVxEFdlKSX3r7VkFC12zy5RO2NgLwlRuDY9d2wR3T4HR
         +UfzQRGbepmPXbCA1VYgJEr8O+dsSfQ7r3lJhFiGs9e1cDkVrCbuMMdvimA1RNeGA3GP
         /n7eOXwlwv5dEg38YGsJkihCF8hDaBx9bXV8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729076927; x=1729681727;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4u1X+4asBMPU91TR1WAl6Ub71JuEkCWwBm90GJmfMc=;
        b=WIoGOYHamf4xvUIhHUebDoHZhxt2nfXxYzkdHwEdT0BP467jNpSkTC9OgwG5d7UeJI
         Cole0G2PVrEVWqTB4sKQk9jAM5UgVm1DPQaFilng2unpq0hs2tH3ZjxaKwY1hKdk/hCa
         Le2x2JuhkPEKTTC9Zl93bCEF1FU18fulLe8wtu25wZ4Dan5EyhgP4ixyrGAzignl2zNd
         gpnp89+0SBo39BBMxW77LsQEftArvMoC8VcahZRQLF0o9hwuRr5Z4Nxb+vGwJ3qgIbjP
         Q0O7g65QHgiNfqqyKnXVXPIRti6YYOlPoai0QXroUgdc/QmXGK7ISGGK2dnfW4y4cuHb
         0LJw==
X-Forwarded-Encrypted: i=1; AJvYcCWAa7z4YdewYZe2r8+mkbaMJXYP21JgVUqsmXVQsa42HtrzVcTH91gsBqsqZFvdUq5l7ogcxVq/mUoiZ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywka+E0gVR/rrB07YjTu8NpFXC5VHY4aOm731/JrLe7KLqwpmwa
	S1CQ4TChu8AllUB6ZcUCtwAZclKhI9er9AOUg8uM3Nf+NIuHh5abBx6RdyUcVw==
X-Google-Smtp-Source: AGHT+IGbiRRm9/GVZ2H2pkAbe5Hh0MuXI6tyXwqFg8lOcZTaM/hUsZa8Rxc3qKSg6bWgPyMziv1sPw==
X-Received: by 2002:a05:6a20:d504:b0:1d9:542:8d40 with SMTP id adf61e73a8af0-1d905e99a58mr5466764637.5.1729076927053;
        Wed, 16 Oct 2024 04:08:47 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773b13a0sm2826188b3a.77.2024.10.16.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:08:46 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 16 Oct 2024 11:08:39 +0000
Subject: [PATCH v2] drm/mediatek: Fix color format MACROs in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-color-v2-1-46db5c78a54f@chromium.org>
X-B4-Tracking: v=1; b=H4sIALeeD2cC/13MQQrCMBCF4auUWRvJxKaKK+8hXaRx2gzYRiYal
 JK7G7t0+T8e3wqJhCnBuVlBKHPiuNQwuwZ8cMtEim+1wWjTokarfLxHUWS0paMdutY5qN+H0Mj
 vzbn2tQOnZ5TPxmb8rf9CRoXqYAeNo9PuZLqLDxJnfs37KBP0pZQvRosOf50AAAA=
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
switch statement more concise. That commit was intended to be a no-op
cleanup. However, there are typos in these formats MACROs, which cause
the return value to be incorrect. Fix the typos to ensure the return
value remains unchanged.

Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Clarify that the commit get fixed was intended to be a no-op cleanup
- Fix the typo in tag
- Link to v1: https://lore.kernel.org/r/20241015-color-v1-1-35b01fa0a826@chromium.org
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


