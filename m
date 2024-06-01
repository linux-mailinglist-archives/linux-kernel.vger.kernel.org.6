Return-Path: <linux-kernel+bounces-197895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB0C8D7076
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93AF1C212C9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA3315253D;
	Sat,  1 Jun 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrHwblnR"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6C152184
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717252879; cv=none; b=P+hX39zHdp8gPSyTr9723wxngZGIklBHqDYSWs+IijzYcoDgIChVXOCsf5G2LRIYAykCELlO6e0EuKC7WmHbNSy4JiMMj+racpqvXu6mMraEBaaSHft6N59HABJezMpgwp737aEHtDNvNDR1OgnYx+iLWZsECvTABHoB6kcKYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717252879; c=relaxed/simple;
	bh=IdPQV3gjMitZEqvPmXcYQN4F99m8ZuqyDu8rv8Lu6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft6y1VFok72OGO9wr5829Mzf9yhyXlMv52EtQaIVGXcLJHy5oHVt5dkHRRQyHtxekihsTVt8xQb0ZiFXdG+Wvq6sAbh1aZLxitQVzImXKS/82oQ2lWvm6Vv3o9v39qtHNVbKDUaBTbZdshETnRnh5ta2HmxGA/5wbvRatusLKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrHwblnR; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1fcd2662cso131910339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717252877; x=1717857677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nvodmy/+o1CpqrThX4vjzT04rOZoUfiprza2mHo3aIg=;
        b=GrHwblnRRfF65tzzcQSEEM3bvKlGwDDcdiasPYQlYd6gQCeK1gk0iQu9KZanZK57Mb
         flkwbSNphLKXm0Wyxyka2UqIrnPrwgOL1ROM+8bm+rBJOZ9DtCvND13Zokc7KBbnmjKO
         bKOaCok4S0fhUPRfqW+RyB2OzDMkpWcAUTP7ypKUv2LKR+wpzLt/XC1zS6Ot3/liwdQa
         eTD2xFuKKaLFtedV5133qm6D6E8S8Se7GTRrh/BONNxnV+2IvM/p5xx2OChaL/l3gdcR
         VdYDIlYPehCIZKRrgeFzQ18Mmzq1NtiWfJTnUE1V12a6DwEqe5buLPnGCP4lT6NnuKJ8
         94nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717252877; x=1717857677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvodmy/+o1CpqrThX4vjzT04rOZoUfiprza2mHo3aIg=;
        b=sS55lywELTWEVvSsor9JSW0ozWafuN1Ip+YAtG3YgEdR+oLWoH6tkw7rtM+Mw2ecNu
         Wy6sYChIE+4ZVPuxeZP3g++Hy7XyvxgaSkpQNmcEpuV3mEyb3eU7fp6Tl90MdNmHAK2Y
         NcDQZu4Pxfmi2a86AqRz66XANZlF6u9irMBWtgkpBQzWiIml5mXfFbLgd8+cwPxU8a/+
         GobjFqiY3fRlhiwWDaCsGkLQm4tNypx00pJYJGbVeu7rqwYmTZr/mXAyWSyUkrGrI+z2
         0mSn7iNZlyKnbDBMQLMNoSH6KoOpXFpX/b3jVKNGFeQRSI6TCXlb3Bq1BvJjO9uE2o8M
         1o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1x32KXeMSeoN5iCLDgmBWEs3an8u0FYhyoOmL9+XGnivldt+HXVDs4O+uSuidiitp/NsugU5djyjKGteWLRey8w3WEMzdwDAvVsMU
X-Gm-Message-State: AOJu0YxvMLOY3ifJahFTiwSalWjda7tWiMp0ngZfZ03IevGtpPdHDeKN
	hn7e1jRtMqoR6PqjJgNIQ0vHrpsmAsB2OUNUjN0pY/P451NHvEOm
X-Google-Smtp-Source: AGHT+IGKx2NnzelycSxOsglojmYMn4Dyp9V7bQrXTzRbMPzofddfZdHsxjMHGmD35Kk02nnsH0La3g==
X-Received: by 2002:a05:6602:1541:b0:7ea:faad:74c2 with SMTP id ca18e2360f4ac-7eaffea6e2emr587615639f.9.1717252876833;
        Sat, 01 Jun 2024 07:41:16 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7eafe603e5bsm107424639f.52.2024.06.01.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 07:41:15 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Inki Dae <inki.dae@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation rounding
Date: Sat,  1 Jun 2024 09:41:02 -0500
Message-ID: <20240601144103.198299-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240601144103.198299-1-aford173@gmail.com>
References: <20240601144103.198299-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VFP, HBP, and HSA are divided between the available lanes if
there is more than one lane.  For certain timings and lane
configurations, the HFP may not be evenly divisible. If the HFP
is rounded down, it ends up being too small which can cause some
monitors to not sync properly. In these instances, adjust htotal
and hsync to round the HFP up, and recalculate the htotal.

This allows 720P-60 to operation on an i.MX8MP with a four-lane
configuration.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No changes
V3:  Remove the MIPI_DSI_MODE_VIDEO_SYNC_PULSE conditional as
     requested by Marek Vasut.
     Removed the Tested-by from Szyprowski because I don't know
     if removing the conditional will impact his boards.
     Update commit message

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 8476650c477c..e7e53a9e42af 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
 		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	}
 
+	/*
+	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
+	 * the available lanes if there is more than one lane.  For certain
+	 * timings and lane configurations, the HFP may not be evenly divisible.
+	 * If the HFP is rounded down, it ends up being too small which can cause
+	 * some monitors to not sync properly. In these instances, adjust htotal
+	 * and hsync to round the HFP up, and recalculate the htotal. Through trial
+	 * and error, it appears that the HBP and HSA do not appearto need the same
+	 * correction that HFP does.
+	 */
+	if (dsi->lanes > 1) {
+		int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
+		int remainder = hfp % dsi->lanes;
+
+		if (remainder) {
+			adjusted_mode->hsync_start += remainder;
+			adjusted_mode->hsync_end   += remainder;
+			adjusted_mode->htotal      += remainder;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0


