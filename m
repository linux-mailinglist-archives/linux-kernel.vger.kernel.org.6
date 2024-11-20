Return-Path: <linux-kernel+bounces-415750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D759E9D3AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C7281EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FC1A704C;
	Wed, 20 Nov 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MNvVip2w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E21DFEF;
	Wed, 20 Nov 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106683; cv=none; b=RRnaFo0TE5A9WtJj8zLv0LjHJeQvYgDRCgWmhUk/zOVtjU+Adfvr2ogxfACtH5DmqLzUv9/sr9VOmAYHAK2znXwJXqkNv/FDY54iJ/f2XJcUgSG8T4evILCKqJcyym9R6FLTC2XpKIFKA7keVgxspsZv3muH61q6PQhYV5kTQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106683; c=relaxed/simple;
	bh=T7IOQ+7l/mtswWClwEG6ojzsVDbWhMYo3HEeYKoABqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwO1y246QkXuUFNWyaySmx79fYGQ4G/NL4SwUF3yj0KVY0BkF0v7J2G/tZhUr/WhOyDPBFx1JOYIy0+089KRnbyp4G3niaT1PbbOscl6R3FKnqIZpYJ4wvK2yvVAsMPXAzFOKUZg3cmNKdkdO+5Iu+49Waors4bQ/5/BfEB+ogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MNvVip2w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106679;
	bh=T7IOQ+7l/mtswWClwEG6ojzsVDbWhMYo3HEeYKoABqU=;
	h=From:To:Cc:Subject:Date:From;
	b=MNvVip2wFXvEdhkx/l5AuIYHV1wP/iI1G7wAOuMv8kp1doEWfu74YbZ4Eb+k3WIuO
	 cXQW0OSkTWetcV7sOJEmdOF2Cu8Zq0zbK8SeOFwANITa4QJO9k60C67cvGu+H7eseu
	 1mvi7trEyqlVHP2WBzRdWa8NB4B07VaKneMq5FFuWD6+IxCp7RVdE03aqksDLRxO2B
	 FjyeKLbtujpWTQsth+ybP2zUIbGCyC+bepGsImg+KN6d3ZRePBpBfUS67FtAmhMznq
	 q/uezROC7WHcLGgnnh8Hu3lHAjFlcDt7NShHirZyk1FvXqCPeHAo8AOZVms60Q3Ye3
	 h0LSuLFAH3+0g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61C2117E3661;
	Wed, 20 Nov 2024 13:44:38 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/6] drm/mediatek: dpi: Add support for MT8195/8188 and Pattern Generator
Date: Wed, 20 Nov 2024 13:44:14 +0100
Message-ID: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the direct connection DPI found in MT8195 and MT8188 SoCs.

Bonus in this series is the addition of support for the Pattern Generator
found in the DPI HW: since I needed this for debugging during development,
I had to code in the actual support bits and it looked like a waste of
time to just remove it.
I instead decided to clean it up and upstream it, as this will anyway come
handy for multiple things, of which the most important (imo) are:
 - Adding support for new SoCs in the future will be less time consuming
   as this driver already has the pattern generator in;
 - CI Testing might be able to make use of this to validate that the
   data that comes out is not garbled (so, to help testing display
   support in an automated manner).

AngeloGioacchino Del Regno (6):
  dt-bindings: display: mediatek: dpi: Add MT8195 and MT8188 compat
  drm/mediatek: mtk_dpi: Add support for Pattern Generator in debugfs
  drm/mediatek: mtk_dpi: Use an array for pixclk factor calculation
  drm/mediatek: mtk_dpi: Move pixel clock setting flow to function
  drm/mediatek: mtk_dpi: Add checks for reg_h_fre_con existence
  drm/mediatek: Add support for MT8195 Digital Parallel Interface

 .../display/mediatek/mediatek,dpi.yaml        |   5 +
 drivers/gpu/drm/mediatek/mtk_dpi.c            | 311 +++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h       |  10 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +
 4 files changed, 252 insertions(+), 76 deletions(-)

-- 
2.47.0


