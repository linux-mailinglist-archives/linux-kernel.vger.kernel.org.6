Return-Path: <linux-kernel+bounces-222059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF490FC46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F661C21684
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA533981;
	Thu, 20 Jun 2024 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MRj87NHJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB26386
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862437; cv=none; b=NgmYHmbYEQ+NlSS+E1+jULDi74CBSX69DVO9AqaB7b374F8DENQzf2MKB4WDljd/eAQnIPt4cgJFELMf+cCZI0E6J9gKz3zhbUnn0UZybgpgF4ChmllWqF4+BxBEMUA02qOkxuf/pvVbd4mvH89sBXH0HEBkLBxmbTRQQAPRB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862437; c=relaxed/simple;
	bh=dWoLBn4HKeZdbmOq8QNxipyUidyAKuFVNDIyboHJ+vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNAh+qHrkLDIjYpjOKWWdST2YesAGS1UsZec7Eo1ji0lkMam7RpR2iFhRV+cPhkDSQM0nQIderLgly4GBqxG1LZ9RtaYv5UKlQ00WyO3Z1utn7oT1MHpQ/yH2zWWnsjHQ7vqUDxnjSBtvRmJZDzLFfxLTdAoxmZYmO8pP72XSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MRj87NHJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70109d34a16so473992b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718862435; x=1719467235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNzrUnoT89Wnha0OC6N//7pV9rXMk5Grem520gIyQxs=;
        b=MRj87NHJW3MVwFzazIipUD5U4cp3KfX6w0suY2Q8FdbdZ02dlykBrPWvvS3ekiEuTW
         NovMB6UjPsiHJcYifd9clZ96Oca/l6S5NP2WIfk4pR2jjBPuCabl2FEkRBf4nAUzEpuk
         f8ohZ69pwGifL+hq7AfDi2B/4R6l3p/ohh858=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718862435; x=1719467235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNzrUnoT89Wnha0OC6N//7pV9rXMk5Grem520gIyQxs=;
        b=RkI/NssPZmQGbff+2o4CsllgdyFLyP+EP83kdT2/7TRGwmYv9jNP5JZ/oVLHqBD/fg
         +Mr7nQz2oE+E5OIWnAbKxkhabf4WvyMtcfxiU1qmHPMi0tZ558i2bUzV3Xgth5MI8zQ5
         thbACerH3LclWIYxB/6WyWTmWVgOG2k1UcJHZ53+RMP7rVlcGRGmWxJ3WPnt0dhr2V+M
         UQ0dldvMmRdmd+kLpUdkmGL8wVD2NfrTehfNtX698rV3buJkKbY0OTVrUV/nGiEPz4GS
         EXDwy9KyBmVIJil+ui5IeIQuv2KIVCn8gIZUpd1dyclWKUUr0MIcGxIzmU0k0m4pA+WT
         S7zw==
X-Forwarded-Encrypted: i=1; AJvYcCUoJlV/OWwapOb2zq4YTPeMS4p+F/Z8xHb0my8c5gFmP/wtdEByry8BG18IWeswS6KCtc36BGztvyIG+qISuKCn4gCIlDdy0VTXSBAZ
X-Gm-Message-State: AOJu0YzAURlK0hy/BHU3yL9wia1lc40GK6iVAv9bzlumPpEuC3/lga4D
	6Rn24kGTXIBpwRgbjBr4XdsuqcgnywBOTDuTZ+zZFF+Nn0RPdA4ghanq/1syuw==
X-Google-Smtp-Source: AGHT+IE2FF/BSNYYoA5CyxWSZxhSRVn0heb6yaE7ZZyCHXnLwSE/RVFQurgMXOXNAI+BaOP6s+Xb6w==
X-Received: by 2002:a05:6a20:4aa8:b0:1b2:b104:594 with SMTP id adf61e73a8af0-1bcbb40df3fmr3758328637.21.1718862435071;
        Wed, 19 Jun 2024 22:47:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee805asm127339535ad.128.2024.06.19.22.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 22:47:14 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
Date: Thu, 20 Jun 2024 13:47:07 +0800
Message-ID: <20240620054708.2230665-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the recent switch from fbdev-generic to fbdev-dma, the driver now
requires the DRM GEM DMA helpers. This dependency is missing, and will
cause a link failure if fbdev emulation is enabled.

Add the missing dependency.

Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The commit this patch fixes is in drm-misc-next. Ideally this patch
should be applied on top of it directly.

CK, could you give your ack for it?

 drivers/gpu/drm/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 96cbe020f493..d6449ebae838 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -7,6 +7,7 @@ config DRM_MEDIATEK
 	depends on HAVE_ARM_SMCCC
 	depends on OF
 	depends on MTK_MMSYS
+	select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
-- 
2.45.2.741.gdbec12cfda-goog


