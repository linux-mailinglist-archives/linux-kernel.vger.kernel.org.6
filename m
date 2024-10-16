Return-Path: <linux-kernel+bounces-368187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FB9A0C61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC8D1F22B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA820C00B;
	Wed, 16 Oct 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0AI9lLk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92FF52F76
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088241; cv=none; b=DbT0MnvTHCzEClfTwOu5Xl72eEo8aB4VrzVgGmvQt5QgMXErJr+nb4s5TiM012g307v8qGB4/fXa3skfQGf5I2pdVrxr/8ThtmkSwGta/H+2hCUzvyNGaY+PQVuKrBjAutTwzy4h+suw7LfjShmsLuChn1olAfTBCzUo0pVJL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088241; c=relaxed/simple;
	bh=RkfnvbTItgBER23gVByVBNHD6sByga+na5XXIkiUVzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hky3ZkVk5+1COD2xj9pSqU2MII6SvLF+jdFZl91UsLvSnwch6xGvsTvBowtIHIc4utxdQ6O68aIm3Pi4ttRnIAh8mtI+Up5XunuUlGSzR57I+yilPAwUzEFAnzkVMiuocwPQ0VnYk9cNafUL23IJ5fHO9NPKS2o3pXeBENCRds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I0AI9lLk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdda5cfb6so35073345ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729088239; x=1729693039; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVKER3hv6evoPvIqFuw9dG82LeQOTjgI9oXF+N5WCUE=;
        b=I0AI9lLklH6qiYkroz4lK52MYnVzoY080qMxDMH0o+DgbyGhVxLzr9K3+zrQktQIeV
         UCGP5geY69qe+O/O3RxlhMjdrASTHeV8y6vcp7Y2c720l1bDHbV65H/CaRwiGCZv0Ip9
         KHgkyNblAGQQRtABrj/OAPyL8eGBChvgcxS3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088239; x=1729693039;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVKER3hv6evoPvIqFuw9dG82LeQOTjgI9oXF+N5WCUE=;
        b=VibUEwsHsslWc7ISZXhINmXqtdum0v0MiB/gKSzEwG1ftFPNQL5aLYiKnLonUpDih3
         OuYBZ6XIST5qGHCrNuYTrkfFmjdv7nZ30CJJ/I3XuTZcA2x/nvg0UQqRoq8bCv4UEZJH
         +G0EBtusvlSGjDWmr4i7TtGVD2n363M5aO8aWHDxhfX+eXVbQa2anYLDvNqJqRRteo+6
         clwlUR1gUMGu28vvQpZWUeDHOd4BXHTUtAepvBhN2mros64lujXJyd1f8GKOYkmhuLtH
         uWmicrtrJk8Fv5QdVSPMNjtUMyZJaapa4ie5fyDLYxIS3EHsS7mPanegPBpoAh/tq8Ap
         reaw==
X-Forwarded-Encrypted: i=1; AJvYcCXv9ubEWn5zAOaxrHcjgtBU+2LpRorpivhLHkSphIAwYNPQxaZrBEcdNopJzgFgl0blvbq8prMAGGnmX9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxcs7Kgl6AsdHNagyc7fDtxZtO+8rAU02wXv/egstqIGpeQ07J
	59Q7Pn14aHqkQA0JqY0SZZZrqa/uuqyQ/2YsE0TocDBqbqNt8DIEQhg5RHDBRg==
X-Google-Smtp-Source: AGHT+IGZHtq9NBH/rxgUzuhq/wqmFAtg/Km4mXJX3jx3iEj2labIFGH9kDPhLj3+H6UaQUaFSyyVpg==
X-Received: by 2002:a17:902:ec83:b0:20c:5404:ed69 with SMTP id d9443c01a7336-20ca167bbbbmr242478095ad.31.1729088239049;
        Wed, 16 Oct 2024 07:17:19 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f844ecsm29243015ad.14.2024.10.16.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:17:18 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 16 Oct 2024 14:17:14 +0000
Subject: [PATCH v3] drm/mediatek: Fix color format MACROs in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-color-v3-1-e0f5f44a72d8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAOnKD2cC/12MwQqDMBAFf0X23JQkJlF66n+UHmJcdaEaSdrQI
 v57o1AoHufxZhaIGAgjXIoFAiaK5KcM5akAN9ipR0ZtZpBcKsGFZs4/fGAoucZKN0ZZC/k7B+z
 ovXdu98wDxacPnz2bxLYeC0kwwUrdcNFZbmtprm4IfqTXePahhy2S5L9ofqLMojJto11VW626g
 7iu6xcSdymQ1gAAAA==
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v3:
- Add missing Reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20241016-color-v2-1-46db5c78a54f@chromium.org

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


