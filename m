Return-Path: <linux-kernel+bounces-398060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67199BE4C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AC7286158
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163131DFE09;
	Wed,  6 Nov 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JOOw3ts1"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B241DED73
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890130; cv=none; b=bNF0lm4LOa+jDSSKaXryvVgk21aUoo98Au23c+FTWFwSsuTdiNN23VUTa5t9qYg6iuw7NNAdDnBsx80GMOmtsjy6raZ2PQvCoWGq5E7ByzlBNnQLlLvkFsz5C+DX6z4ZovBDsGIxHWQKprb5yRchbYg3/Hg+sYpnU0cL9Za5HWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890130; c=relaxed/simple;
	bh=kYn+tc6pK4Dk+lN2t5x9co8Nw7fiX0sfDQW4g4HBXX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6QPlbpRqazjYlMQLDavra1F9c8D9dL/G3IJk3GkoddobniKqCduq+UnuwPgqlNlAfC+A/1u//RyOdfLof/nKpKk6wK28FRgGJl38+GjOGxuMGTsgpjesu4IqVjmUSksJfujYF+kHR7hrcSlYQZbFp90MvDZ+TzSyXzQzHGiOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JOOw3ts1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2403360002;
	Wed,  6 Nov 2024 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730890122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qQtv4VNS8GSV+B6ud5SuNizwVsMdAG4YsmaGw7hcdAk=;
	b=JOOw3ts1T2+jEEJzyarhzDU3+/RZ+Laym8+gunVhWUr7nQe3PgIxootN9IkgEO0+vP6T25
	kPAISDCM1Grfrx/kFyqZLr2sVAiZL9kiWoLQBoZ9mCbJ3h+AtxMss2l9R9d9p3fCP+vr4i
	ynbBaAgUXOeBDPw2r/0GMWiHb4Xbs+n3dlyz/RornfkeXtf0kV3028JTACAanaoef6Zc70
	N1SOcSN5MSwzQUamkJc6dzLjOf7xlWglnNtf0vRPitUzac+HvRAd7suvcu4m6THh11G36H
	0IZt//A7+ebXtpF6Z4XWWNhOrtYrYkfDamVfIOdgmnkBeGtX3gNOzFjcWmPYTQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/4] DRM: small improvements
Date: Wed, 06 Nov 2024 11:48:23 +0100
Message-Id: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdJK2cC/4WNQQ6CMBBFr0Jm7ZhOJQZceQ/CAodRJqEtaUmjI
 dzdygVcvpf89zdIElUS3KoNomRNGnwBe6qAp8G/BHUsDNbYmgw1OEaHyQ3zjOqWGLI48WtCGsn
 UzGRsY6CMlyhPfR/hri88aVpD/Bw/mX72bzITGmS+0FVoaBtu748Q1ln9mYODft/3L6uivOO+A
 AAA
X-Change-ID: 20241018-drm-small-improvements-1d104cc10280
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

This series brings small improvements to the DRM documentation, logging and
a warning on an incorrect code path.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- Added patches 3 and 4
- Updated reviewed-by tags
- Link to v1: https://lore.kernel.org/r/20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com

---
Luca Ceresoli (4):
      drm/drm_mode_object: fix typo in kerneldoc
      drm/atomic-helper: improve CRTC enabled/connectors mismatch logging message
      drm/mode_object: add drm_mode_object_read_refcount()
      drm/connector: warn when cleaning up a refcounted connector

 drivers/gpu/drm/drm_atomic_helper.c |  5 +++--
 drivers/gpu/drm/drm_connector.c     |  6 ++++++
 drivers/gpu/drm/drm_mode_object.c   | 20 ++++++++++++++++++++
 include/drm/drm_mode_object.h       |  3 ++-
 4 files changed, 31 insertions(+), 3 deletions(-)
---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241018-drm-small-improvements-1d104cc10280

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


