Return-Path: <linux-kernel+bounces-339362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD49863E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3E41F276AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FF79C4;
	Wed, 25 Sep 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9NRAJ1A"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3E17BD5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278980; cv=none; b=TUj/Bl67qaE/m+tPsxZcLIr+hFUeLg1NFZVHxMlAaorcgw5SJ+RvmOx4S5bFh+nfcqQm7sOyjUvWAjjKH/nqxCRltbtZNY/tDo2P/QIbOY+OJLOSrBISVE7S2itpq7IYoqLwVtJtA8ZVJ9ovDnGUgnIQk5c5FZf9RRv3QKGMff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278980; c=relaxed/simple;
	bh=mV011lLjGh5QUEeOXJ02JFFzg3GXgCu8+SSQahiHbas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u9AoC41XfbQ1sSdinzHoTmtovU5ZiBBmCr6KZjuuQX9FykDZy3QSXOyApPqZOboQMLUBsOwTMWyLI5W7292J1B9zTZheHz65YAdTZtX50ktOHKxmJsqKHnBw4sm2dC4sqT96+/AhvqXfDcNtFxIsyrHlHAicKNs2aMNXXylYd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9NRAJ1A; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d3cde1103so660671966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278977; x=1727883777; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgLjgsBATCSWM6XL4qorkL1lHK3PtUuXoapmBEAcGck=;
        b=N9NRAJ1AYXcWeVO344AaLqIaSvyO4/JQKyjZHiaP7+tpjl1Wr+93NnTjvYhEZI8Gvn
         daq3ndzuQQumvj6EbdRfL+NGiEboyOE5yGbjaQvDSmHQRMJLq2WgUSnE0FB6FhBebbV9
         fzI/iqTFz7MwTi2peyG5brDM/ouRrrbpRf2qAOyR36MYw6wgN8JCq2TwUpXlMe3bubol
         gOF2tS7LOq+O90vdwsdZ5zrArE/l53twfnnOzWv6b94q0CdDJwXYHP3dIFvaMVn8aCyT
         TophhcYsSzZ3H0dZYAEv+xWTUZ9WTVvwnha70362wivMPhVlZcSh2A1KXJ8PVSbhQghC
         KdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278977; x=1727883777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgLjgsBATCSWM6XL4qorkL1lHK3PtUuXoapmBEAcGck=;
        b=qnS1lJTMV5mvfMHye0YrzPJoT98Gc3bO4NLU1vn6iYmjSubHY0orVF+1laiR5jQWaU
         1LSgyx2PXwOP1AF19S5PEjEckfbQJb6vRUdJfpBwb0UBQCv8NcAfC2knxcABU9FlyMsG
         2V/VwRm4cDF+sML0uPxajKHYqPRb+QK+6nglo6ojFoCkDc6rayaDVY2mw6QYv2eoU3SP
         1xG7PEhq5isE06XI1vBXQYUKF0EtLE2FYlc5l5iAnI9xzZU1ejQGiV3xTuX9JxdDfdbO
         k9tC9bMuMQwioympeVWMVdO3Thc3o+e1PfH1CwlwulWISJQcPUsCFscUuQ3dQQecy/mx
         umjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDv6/9ksMgEaonm74NuNITmLhT/InH4kwyORpwPeFvl8QvXyFQmpeQ2fl5GgS6sriP8rTjmcShNwBWPKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1D7D/uqYpi6yuY1zEfFVh3lZlVTMgeQNVxuPNjVANrWXrYNi6
	omeZJtaH782/CL2CEoHGPFF5If1AbQ+pMYW6Im9V4pVK5SJ3oP9u
X-Google-Smtp-Source: AGHT+IFkZ1n37tP3Rc2/BMb8UIyY4klrs21gwIaq2A7G/dBjrAoB3ccE5EDVcggDj2gmdvtj2kWRUg==
X-Received: by 2002:a17:907:7da7:b0:a8c:d6a3:d038 with SMTP id a640c23a62f3a-a93a03e3095mr316176266b.37.1727278976983;
        Wed, 25 Sep 2024 08:42:56 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:42:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/6] drm: constify read-only regmap structs
Date: Wed, 25 Sep 2024 17:42:39 +0200
Message-Id: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8v9GYC/x3MTQqAIBBA4avIrBswK/q5SrQInWoWmowRgXT3p
 OW3eC9DImFKMKkMQjcnPkNBXSmwxxp2QnbFYLRp9Wg6dOLRniFdKLT7NWKj+83YphtcraFkUWj
 j51/Oy/t+aWaESWIAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=1173;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mV011lLjGh5QUEeOXJ02JFFzg3GXgCu8+SSQahiHbas=;
 b=myNkjRQ3PFvNNvW6MYUDscCs4qRnSff9r34U0SADdEuPuz6/EHK14GRk3jXV4EQhRuDrFFBYk
 q/5VY5I1EZoCwxtXU4F47W872f6MFmFLNx3SrzjZfC9qmsxNSZ5SlmM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_bus and
regmap_config structs under drm/ that are effectively used as const
(i.e., only read after their declaration), but kept ad writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (6):
      drm/bridge: dpc3433: Constify struct regmap_config
      drm/fsl-dcu: Constify struct regmap_config
      drm/mediatek: dp: Constify struct regmap_config
      drm/meson: Constify struct regmap_config
      drm/panel: ili9322: Constify struct regmap_bus
      drm/sprd: Constify struct regmap_bus

 drivers/gpu/drm/bridge/ti-dlpc3433.c         | 2 +-
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c           | 2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c            | 2 +-
 drivers/gpu/drm/meson/meson_drv.c            | 2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 2 +-
 drivers/gpu/drm/sprd/sprd_dsi.c              | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
change-id: 20240925-drm-const-regmap-307f2c358d10

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


