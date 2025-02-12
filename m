Return-Path: <linux-kernel+bounces-510864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F1A322FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA67188A315
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13C52066C5;
	Wed, 12 Feb 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SHFSoU8S"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356041F8692
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354422; cv=none; b=pUK8X11ld/4G8GvfwK+uUeJqqnw7hA99HRTE8SbMhhv0Snt2zHtJGdfSvqWeTI3aoSfxcjJoYtxc1K4BGQdLaE4I2TpME2K4fxXVcBTHAYT6P3A1VxKwVou5d4nXbhhQPO3pI/S1HwiYx1loS5WIbveM10xWpCltRpRwL0Nkm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354422; c=relaxed/simple;
	bh=aSxtnqMqCweFDRTEVAHslns1++X/x1STVDRpwl2IRds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iu+IEgJpjwd4uXo8msI+zfN/wMCXoFVI1obA9b1MHKTRLRRBdSPieIjTekJRvNccQYEIzfedobEYM+tC/oZnPLGvhz+beuuGlk3LgIAh+ogv7kLSBITLcGIPKUEwYd27NfmeyL1YT3SOxAwTFq/31CyEJ/idg+gx8GNJ2RozoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SHFSoU8S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354418;
	bh=aSxtnqMqCweFDRTEVAHslns1++X/x1STVDRpwl2IRds=;
	h=From:To:Cc:Subject:Date:From;
	b=SHFSoU8SH2wWtWhxlxt5uJpTSl37cEDO3r0gvX3/OvZ/zXPoXp08cwMQQGVDgSqvO
	 dQaKFU/lRMhCMvLSIL7nEtptEJqgD7yg1c/TAewXQl3TMN+4X2Xjm6xPIIOfs5bIOh
	 STlCxT4xUeVUp+fWiXMJPuclRV58Pbfl3oDz+h5Hkwx5vjHJRdf3sw9y78m4dsGrb4
	 cU/dnnde0UzE3TS6jNR9LCxXUbAl1JgG2uUatYopAW/H0BqoeUu3XcvnH/q26ZI/t9
	 qh9D3Cjsb8wGsozW3uuTG+idJ5wYRulAg9IQHromyWkyQs/PKD2UUoszwzQCBpd1iT
	 rX6x2Vx3pGoNw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 839AB17E0C9D;
	Wed, 12 Feb 2025 11:00:17 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	fparent@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pablo.sun@mediatek.com,
	kernel@collabora.com
Subject: [PATCH v1 0/8] MediaTek mmsys/mutex fixes and improvements
Date: Wed, 12 Feb 2025 11:00:04 +0100
Message-ID: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the missing DPI1 SOF/EOF to the MT8188 mutex tables,
required to support output through DPI1->HDMI Transmitter, and also
adds a few fixes and improvements to the mtk-mmsys driver and tables
for all SoCs.
For MT8188, in MMSYS, this adds the DSC path for the display
controller, and fixes the current DPI1 one to actually do something
meaningful... and speaking of mmsys....

In particular, since I've found multiple basic mistakes in the mmsys
tables for more than one SoC, I've identified a strong need to do
something to prevent that from happening again in the future.

That was done by adding a macro that performs a compile time check
to make sure that the in/out selection bits do actually fit in the
register mask, and converting all of the current mmsys drivers to
use it (because pre-existing code is usually taken as reference to
write new one... hopefully!!!!!).

Of course, the fixes that I performed to the MT8167/MT8365 are
relative to issues found while converting their mmsys tables to
the new macro... :-)

AngeloGioacchino Del Regno (8):
  soc: mediatek: mtk-mutex: Add DPI1 SOF/EOF to MT8188 mutex tables
  soc: mediatek: mtk-mmsys: Fix MT8188 VDO1 DPI1 output selection
  soc: mediatek: mtk-mmsys: Add compile time check for mmsys routes
  soc: mediatek: mt8188-mmsys: Migrate to MMSYS_ROUTE() macro
  soc: mediatek: mt8167-mmsys: Fix missing regval in all entries
  soc: mediatek: mt8365-mmsys: Fix routing table masks and values
  soc: mediatek: mmsys: Migrate all tables to MMSYS_ROUTE() macro
  soc: mediatek: mt8188-mmsys: Add support for DSC on VDO0

 drivers/soc/mediatek/mt8167-mmsys.h |  31 +-
 drivers/soc/mediatek/mt8173-mmsys.h |  99 ++---
 drivers/soc/mediatek/mt8183-mmsys.h |  50 +--
 drivers/soc/mediatek/mt8186-mmsys.h |  88 ++--
 drivers/soc/mediatek/mt8188-mmsys.h | 266 +++++-------
 drivers/soc/mediatek/mt8192-mmsys.h |  71 ++--
 drivers/soc/mediatek/mt8195-mmsys.h | 632 ++++++++++++----------------
 drivers/soc/mediatek/mt8365-mmsys.h |  84 ++--
 drivers/soc/mediatek/mtk-mmsys.h    |  14 +
 drivers/soc/mediatek/mtk-mutex.c    |   6 +
 10 files changed, 581 insertions(+), 760 deletions(-)

-- 
2.48.1


