Return-Path: <linux-kernel+bounces-449364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28209F4DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C467C16BE02
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1651F666A;
	Tue, 17 Dec 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iFNOpBKp"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D51F4E49;
	Tue, 17 Dec 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445945; cv=none; b=YwCimALkW6uLOEv60rROZTJLj6XIv7koaChsYf46yR+2Y42M3dJSq89l6mMEMjJywW4YstWgx6WQHF4aNoYpXCd7bVI7uNtTI/r7CcB9LdAcofgmeCbdN8QgK1tL923iBWDeTlPYLfnXwGZiEaSLL+dOb5DmyCAklC9d9CPy3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445945; c=relaxed/simple;
	bh=VLfxt9Vn4SdA//0US3p8UFYh52K6j7PQw8HXk0ew4ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAOQNivSNO4eaK+pOHkSMGI9nYtYnkz6FfZFDYXwq9uVRmc1pyT1urBnnWt8BsA0sFIQn9e6y9rWtsigrn1gjRvU3pTjniMOptqve7dOAPJfzAK+8+xPS6fReJZOEzEsepmqW+HORajpXFLg9JEQXbyOXY6sVkDvdvevRnyyGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iFNOpBKp; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BEB8E1C000C;
	Tue, 17 Dec 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734445941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RJk9qBtezG93whbc4qcM7rABQiYrdK5pxBplOn1zues=;
	b=iFNOpBKpS32h7qqai9Zn0/dxy6KYb0atFUdgcfFCy5B2vm8+BS9yeQPXRQwgLfJ4yJ1A5g
	3aullRb7dbf/GVFAF1Nr0nIhFHIXtbRTmjKjW0Al2Xm+iidCvcz1zGigsv50bV/RxBBxJQ
	iYhqTMRBKpvrE/u5KS1/4FrAVo5YdWBIvNiyd3xa//xuMBiGhZjpuYH8XGNBQAECIJFKbD
	UclH+990s8FZJc7ENQ6HQyhvpu4ytGd9iuk/OPfdoXYkvunydIiEKPwG5sCk9P5k9E2s6s
	kTNVwu9wFyXmsq5QnJW1b+4qq3LLNJeln2Kqz3alj7h4wEhU9FHKe38Bs+lzWg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/3] Add support for errors recovery in the TI SN65DSI83 bridge driver
Date: Tue, 17 Dec 2024 15:32:12 +0100
Message-ID: <20241217143216.658461-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

Usually the TI SN65DSI83 recovers from error by itself but during ESD
tests, we have some cases where the TI SN65DSI83 didn't recover.

In order to handle those cases, this series adds support for a recovery
mechanism.

Compare to the previous iteration, this v2 series mainly:
  - Rebase patches on top of v6.13-rc3.
  - Reset the output path where the bridge is located instead of the
    full pipeline.
  - Add more information in a commit log.

Best regards,
Hervé Codina

Changes v1 -> v2
  v1: https://lore.kernel.org/lkml/20241024095539.1637280-1-herve.codina@bootlin.com/

  - Patch 1:
    Add 'Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>'
    Add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>'

  - Patch 2 (new patch in v2)
    Introduce drm_atomic_helper_disable_connector()

  - Patch 3 (patch 2 in v1)
    Reset the output path instead of the full pipeline.
    Update and add more information related to the bridge in commit log.

Herve Codina (3):
  dt-bindings: display: bridge: sn65dsi83: Add interrupt
  drm/atomic-helpers: Introduce drm_atomic_helper_disable_connector()
  drm: bridge: ti-sn65dsi83: Add error recovery mechanism

 .../bindings/display/bridge/ti,sn65dsi83.yaml |   3 +
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 142 ++++++++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c           |  67 +++++++++
 include/drm/drm_atomic_helper.h               |   2 +
 4 files changed, 214 insertions(+)

-- 
2.47.0


