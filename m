Return-Path: <linux-kernel+bounces-181103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EC8C7779
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14AF1C21B46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643791465A1;
	Thu, 16 May 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E1AgNavO"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95575147C72
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865613; cv=none; b=guiyqnrVqoKHp+cP74PinJKVdWEQZOdnuqlo+ZTK53SbtlvG7a+7P1hrliHRiZsIe4L/4HjHQ3PPxScyEWMatjTfOx0fU1Gz0xWtZYnrQ5FklWz1xwxRvBlxSA5fLMN+yrFTg9yY2ynFUfM7rG+JZUOfMLdOa8AKb96dL4wSqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865613; c=relaxed/simple;
	bh=Dpc70NziaxnrQCx0B5Ukpj1EKWrj914F9Ksg/Qy8Ihw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JvACUDxr5EkBgRXKdIgg6Ce/tgpo6PXYiXIJEG7nKyKJ6JFLb6lvwWTI/ecEVroYcP3ilWgM4gvqHVs+C2f1FtTCzvRMkLNyyvcjBMr4uSqiRPzYZTFiGhc8mBnCmCWHPgYNZ6nhiITw87VDU3rdO9lXI6ZvOn3uigcnF6K1Vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E1AgNavO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48FE01C0009;
	Thu, 16 May 2024 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ArYlTqNc6RWGmShff/lcwa9Oxf7clXXs2cm446Spw0=;
	b=E1AgNavOJfLHySqAlFp8KUaKYZnT2tBfV1qO4l7MXGQjjGq0hiGoi3oulzjYJVeM0ya6O8
	Kk7jxHzjM37NE9Y/fhJzHxoyWrisKR5M4/G4850+cC8rRGReok+GO84HF/jnmon1CP1FNZ
	4h56Fp6jGbWW5v3+9Ro7uKt0RTqNLkBYK8O+jIoF0gVDqTv5JT9fqn8dLHwyuzrUwoJfvk
	5Wd4nBn9FhKPGLI4Ijv+g7XOlOa12kNkxuN5+QvqZleRhAP5Y4IeuLubraCr15UTJOqp3a
	z+N3mwOKrbpgY5lUea2AiCeTPqDJ1QGcMZBC5YOX90o57B8DBeZky758abZzjg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/3] drm/vkms: Reimplement line-per-line pixel conversion
 for writeback
Date: Thu, 16 May 2024 15:20:04 +0200
Message-Id: <20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQIRmYC/x2MWwqAIBAArxL7nWBLVnSVCEnbaiksNHoQ3T3pa
 5iPmQcCeaYAdfKAp4MDry5KliZgp86NJLiPDigxl4goTs87mc7OemFH2tw/RZWXqpDKZL2yEOP
 N08DXP27a9/0A6hJi8mgAAAA=
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Dpc70NziaxnrQCx0B5Ukpj1EKWrj914F9Ksg/Qy8Ihw=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRggHSLSv2AbYO8SVcpvFqYDZK0xI2Wn0i1gTB
 68XbWyE6uiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYIBwAKCRAgrS7GWxAs
 4pY1D/9uuCQYR00dJIqjOdYWZe4UcthceV4K/kxpRCxeBNR4mgleY/t6rQvjrYH8wcWA62sUFYL
 ajkQuSQeL9MAEPQYJbnalmgdMK3IuQgZIEB6EQijAeCWfZztmJFvtewJx2Sl84k29JY0Mrto79g
 hkGsjXwvVWJJ8CMHh5zBvplyk5S+U33V3//zh3s6/QBklyt0hFwRCB3+4QBmXuvdZHctuKkVTF9
 rfPi+AhA1faT55RltIJ8FMFoo4m4QV6Uy5IvHSr0ZvrfXj7N+IkJCw6q/+i3yPDVZaRzXJ2745d
 xM3PIqkgavMz1oa4ae3GCkO3b68q9xe2HMqKra22S87kgWpj8ZEast1Nu1iqAlnBrnyk/PfXK1U
 KJ8hpXmMYuDmCP09vt1n0qjiNSpCDO7g/DcuRRyz0YzR2YEqQcIv3+iYn5bxtI/uIC0hy8NOy2r
 vG1/SVO6Q4qJqEkkME3FJpiMWKu4iy9cYnBrs5Lk0DD/dwKMEEBCAa1VrV5N+QCeYhv3ubNkZu3
 48oyeZs7EXppT0d/JJ6dXksiUFWYXWAuZmaTBPX8xy7kjRXmZtQBKL/s4Tj3Hd1If7D/0BswqpS
 czcGGJtIXbne1oAwAUMwg1VjYTyORvKg/+1VH+eTSdG3AkhzWquCPsAbyLqVhf5BNXqfjqnRauV
 Nh6MwTZkreneDxw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series re-introduce the line-by-line algorithm. This is simpler than 
the read part because no rotation/translations are involved. 

PATCH 1/2 is the re-introduction itself
PATCH 2/2 is a proposition to avoid code repetition using a "big" macro.

This series depends on [1].

[1]: https://lore.kernel.org/all/20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Louis Chauvet (3):
      drm/vkms: Re-introduce line-by-line algorithm for writeback
      drm/vkms: Add a macro for write_line functions
      drm/vkms: Add support for XRGB2101010

 drivers/gpu/drm/vkms/vkms_composer.c  |  18 ++++++
 drivers/gpu/drm/vkms/vkms_drv.h       |  20 ++++---
 drivers/gpu/drm/vkms/vkms_formats.c   | 104 +++++++++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_formats.h   |   2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |   6 +-
 5 files changed, 105 insertions(+), 45 deletions(-)
---
base-commit: 335e3c4175a113d1f5b089c4eb1738590d193fbc
change-id: 20240222-writeback_line_by_line-8475605b1d5c

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


