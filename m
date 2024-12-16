Return-Path: <linux-kernel+bounces-448261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEE9F3DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C76716AA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527031D8A0D;
	Mon, 16 Dec 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nl/1ALuF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF61CDFD3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389686; cv=none; b=RopcSLdwJwfnS+yzojJdzhIHi6EPia6UKK2RuPkLQMf1inbcgxSxtdFdx6t5QkN9ZfCIr2zJnKRBRl646rdydlBc7wrkoZ8rlfGOl5YnTMxhA1VHOJ7dKTc5VyNGE2NSg/LXgiCOroeAZ+zX8xJj1aesi/q+xCciYMSv6/6vxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389686; c=relaxed/simple;
	bh=NH3AgonOJDLYtaMkD1sV08KHOIcuLuMJl/JutU6HH7U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rNREka1orbUrId+lb7gr69nPt4s0gG7Ps3FCGgzC1MNTC+V8Y19BgVhO0I4rpDaqlnYk/YQc3SSY3QDRVukZYTKjxYjV/69dYRVufouHLAJWdCSOlc47SInrWCHPP4H75xJK8MJOHx/55LLLusjmxOlk0aXr03+hEieJ4hJ+gIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nl/1ALuF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734389682;
	bh=NH3AgonOJDLYtaMkD1sV08KHOIcuLuMJl/JutU6HH7U=;
	h=From:Subject:Date:To:Cc:From;
	b=Nl/1ALuFWj3sUR3E4s/v6QMzrysbxrVcF5j3O7Wd2Y3monQfvs6cMST3MZT2wMggZ
	 CWUqDl+pGrrVsF6m7H6I0jq/iwAElHQ0v8Q/JxDOv5iEm6YJjpJWEmDTGoyYtoKpJF
	 4QNfLEWdHwdc4WjY0Jv2HR5tInnWGQJfgBKaN0Vw0rRlbGH6NMowkE2mjw1dj5uCPu
	 CAi7OIJTUXm0LupMHNwfDgw9ww0wWlB6TzCDh5j/DwenGXyzpP64L+VslCxpqcIjnJ
	 QbiFNytHL246GcB873p9TW+bqIgJJ8MOjJ8qetYJF76rh++0Qw3Uz6DwUIWfn4lbA9
	 too6snvtzUTeQ==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9430217E3830;
	Mon, 16 Dec 2024 23:54:42 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/2] Fix ycbcr_420_allowed inconsistency for HDMI
 bridges
Date: Tue, 17 Dec 2024 00:54:06 +0200
Message-Id: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6vYGcC/4XNTQrDIBAF4KsU17U4Gn/aVe9RuohGGyHRoEFaQ
 u5ek02hUMqs3oP3zYKyTd5mdDksKNnis4+hBnY8INO34WGx72pGlNAGgBGsk+9qa2II2I0znpK
 P2HCQBhoibcdRnU7JOv/c2du95t7nOabX/qXA1v4BC+B6jdBCMAfSsauJw9DqmNqTiSPa0EI/E
 CXiB0QrpLhRIDk9a6W+oXVd31MPNtsFAQAA
X-Change-ID: 20241130-bridge-conn-fmt-prio-c517c1407ed5
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Bridges with DRM_BRIDGE_OP_HDMI set in drm_bridge->ops are expected to
rely on drm_bridge->supported_formats to advertise the supported
colorspaces, including HDMI_COLORSPACE_YUV420.

However, when drm_bridge_connector gets initialised, only
drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
the drm_connector->ycbcr_420_allowed, which effectively discards the
formats advertised by the HDMI bridge.

This patchset tries to address the issue by prioritizing
supported_formats over ycbcr_420_allowed.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Simplified the inconsistency handling by overwriting ycbcr_420_allowed
  for HDMI bridges before adding them to the global bridge list
- Added a 2nd patch to check if supported_formats matches
  ycbcr_420_allowed on HDMI connector initialization (Dmitry)
- Link to v2: https://lore.kernel.org/r/20241206-bridge-conn-fmt-prio-v2-1-85c817529b88@collabora.com

Changes in v2:
- Wrapped HDMI_COLORSPACE_YUV420 flag in the BIT() macro to properly
  check its presence in supported_formats
- Ensured YUV420 gets removed from the bitmask passed to
  drmm_connector_hdmi_init() when ycbcr_420_allowed is not set
- Link to v1: https://lore.kernel.org/r/20241130-bridge-conn-fmt-prio-v1-1-146b663f17f3@collabora.com

---
Cristian Ciocaltea (2):
      drm/bridge-connector: Prioritize supported_formats over ycbcr_420_allowed
      drm/connector: hdmi: Validate supported_formats matches ycbcr_420_allowed

 drivers/gpu/drm/display/drm_bridge_connector.c | 8 ++++++--
 drivers/gpu/drm/drm_bridge.c                   | 4 ++++
 drivers/gpu/drm/drm_connector.c                | 3 +++
 3 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241130-bridge-conn-fmt-prio-c517c1407ed5


