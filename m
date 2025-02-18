Return-Path: <linux-kernel+bounces-519653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D00A3A03A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB3F1899F56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834C26A1D1;
	Tue, 18 Feb 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K8zv11Px"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F8286A1;
	Tue, 18 Feb 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889601; cv=none; b=pRoEi0HvtTnu8jQs74imEKD8IHJCl1iNzJcSLLWp2K+NlF/nmcSevxG1qRa/Z5OCilCUyPCWIYOQZih3q5b/F+ZfTZXRxE2XxkbQXwn7otGIH6oGwdyLaWPI5YMOhyS/nftBgFY0c6Ggd0Nsuvt5eMbSJu4GdmXhHe2XPcErYKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889601; c=relaxed/simple;
	bh=Ee9P6EhDUoFPXug91QeqALw1knWAZkKxsmgqWLX3oJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuMhr31rMpQ4gZj24LgQZiSpcVGuciLjArN9z7P4kj52YEphouE5Mb9E70+yBi4J7Ze0vXlA92z1v+fYN7/1jdlxdM6gQe+zX3DC5+Hc7Wx3fqCo5oDP7lyanQV2D4sKutN00l0L73OHajwm2urXySVQe+JMQwvWUVfIdEK/1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K8zv11Px; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739889597;
	bh=Ee9P6EhDUoFPXug91QeqALw1knWAZkKxsmgqWLX3oJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=K8zv11PxDk6e2NkrzoE7sN9oT/97HPZbAZPTquwQyyq10STWUcM2J6K8rm6F4/xoH
	 DFPajFGCkhlx90hpAy3uCIN3L8nEsjO+SAytrqNUaGdq7MTb0nY84HlvJaxUhd1+Bq
	 RdsCXtITrY9CW+d3pngFJQP9Eq4ROZ4udy5KCEUlp/hDcUcr5tShT5ZIYwX9bK0ZbX
	 2UY6dowfR02DPE/1uaJNJN+mDTBZl3Bhs20E4Dl0jvTbNy0f5KMJ/dHAifDjUl7jPA
	 vgQdMYJpi6av1VGBOP3HUl6CefY094hgX2sL4FEGQ35bIxVs5VtS273o2lAsmTsxxf
	 tlgLZ/OHS6MFQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E505217E0391;
	Tue, 18 Feb 2025 15:39:56 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v2 0/2] Add driver for Himax HX8279 DriverIC panels
Date: Tue, 18 Feb 2025 15:39:50 +0100
Message-ID: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Removed unneeded mipi_dsi_device_unregister() call for secondary
   DSI: as the driver is using devm, that's not necessary (CJ)
 - Removed superfluous if branch as pointed out by CJ

This series adds a driver for DSI panels using the Himax HX8279 and
HX8279-D DriverICs, and introduces one panel using such a configuration,
the Startek KX070FHFID078.

This panel is found on the latest hardware revisions of some MediaTek
Genio Evaluation Kits, and specifically, at least:
 - Genio 510 EVK
 - Genio 700 EVK
 - Genio 1200 EVK

This driver was tested on all of the aforementioned boards.

AngeloGioacchino Del Regno (2):
  dt-bindings: display: panel: Add Himax HX8279/HX8279-D
  drm: panel: Add driver for Himax HX8279 and Startek KD070FHFID078

 .../bindings/display/panel/himax,hx8279.yaml  |  74 ++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx8279.c    | 905 ++++++++++++++++++
 4 files changed, 991 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8279.c

-- 
2.48.1


