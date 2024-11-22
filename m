Return-Path: <linux-kernel+bounces-418509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D805C9D6261
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D31608E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA371DF250;
	Fri, 22 Nov 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IiQIUBUJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A115E5B5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293317; cv=none; b=pCcWuX0kZgbCY36fWrYjtdYgfG7EgU89Zy2tYgNHvgN1w8euymTOiUpgtCYhD6F07DJTzQN0p5AECFYLVmW1ZIrO6Scr4RDdV8AZO+51H4jtbVgrb9wHQa5TOiFxO2RCQi8PL69CgATU53FIbfkpau6DZWnWOHCT4cW1hkc2jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293317; c=relaxed/simple;
	bh=5/hbZ+E9BqSb3A600Iqwyv3NoK2rcGUGx/rP095HNXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D6EI7virMDQy8yirqGunaH8HWwgNwWlXnP7bz31Kw4fpk0351qSOyQ+RaEHVhcWsaykCgylOyLVkiESArZepoKukAnIGJ7zXA7PIYGj984zzVbtWFwkGsVABg2neClD6pi8et2/jN4NNnsTxsCEMDhTbzKN5Oknk/G/b6ugfxcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IiQIUBUJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B3D8E0006;
	Fri, 22 Nov 2024 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732293313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EU4DnaB/CA53h0OcQFrCX75CUQhx9xDEfk3liT83+mA=;
	b=IiQIUBUJZfuwhDaagzN1rvoElRm17ZsDCI994fGk4ih6fjKYXieFtSRjAH+6j2ILusupUf
	Du9BEzs7oxb4EBFBlrDf+799Kd7jpbYsNOCronuY8dNNFAWoZRcRrymup6Z76nFI49EXz0
	rIOIUuLz4H14z4Y8NUXZEvighRXmxL5wka/5fJ4ErBK/KCoevhLFoxGVk5wp2gCZZDFviJ
	XLQc/9El0GE26ezzk4rEzVA7mpuwXGyGmln56hBvcQ5x53Wiuem/zxyi24WTvHIoXBTOSn
	hv+TIgZP2zWfwusFYesBGB4Kc8cLIdOoCweTPqaAVPYjjoTGqEtYBbgKXS8XuQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 0/4] drm/vkms: Switch to allocated for drm objects
Date: Fri, 22 Nov 2024 17:35:08 +0100
Message-Id: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyyQGcC/22PQW7DIBBFr2Kx7rRAcVSy6j2iLgZ77KAaSIGgV
 JHv3omtLiqVFX8Qb96/i0LZUxHH7i4yNV98ihz0UyeGM8aZwI+chZbaSCstOAPtMxTAZUkDVhr
 BTn0v3ybDBwX/u2Sa/G1jnj72nOnryui6D4XDQjCkEHw9dmMOEHwZXn4vEOlWH6BApeBmwEK8X
 ymtYU5pXmh3CBj5fYTWgwSF7iCNfCV7kO8upbr4+MxLxMPh7EtN+Xur2dQmsTdS+p9GTTFPW3Q
 OURmc7F/euq4/bJBrOjgBAAA=
X-Change-ID: 20240909-b4-vkms-allocated-9f5508f4444a
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=5/hbZ+E9BqSb3A600Iqwyv3NoK2rcGUGx/rP095HNXA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLK+FwJVDvWLWMSXnTlA1WdOzqsB3odboUWnl
 sgdOkeP6jiJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CyvgAKCRAgrS7GWxAs
 4l8WD/4rqL7I83iwPXi5DARD+/5Y8ahY9RxM4auBKuphvVgJ/UUGoq7UXFWLsXYMlIlvjgJD+Ly
 S9w/4IoVdW4XNIpLJsSSTpfdHqaI8vyN/74TYbxTG64AsS2eUCHKFZFP7WUVUCsfEaqi5GwzhcS
 5yGf0vC0O5346goPJDoU2e/TwgrCpkZeOMc7CkIXxGvER1bCqt4trgo2Horw/ZE1fY7kkqQCYe6
 hpYOAAqgmZI2uKqVz1nDKu9fJFvSXyjkYBtQnOBG6oNA0GTQXm2W4/7Xl5msvK3IqrnBCnByITX
 JA6ukL2bhUdcvTDBPhVhOexrKzGvmozH430Jdsq6rAzhR+lp8sOdfWyxLVSIeL8o9Cxv9MQFeC0
 wnHn8KCwJp15ef/7cZYds3nKEftffD36VPgfM2AN0QpRg8YBbGg+waugWwOJsi1D9kiXx/OQiwr
 D5K+GYvCW7fmmEN2qanbdaYe3lvBMkJ0AqFWKmA275GmmhYlFoBBRESr0RS+eC/8p5x1GuaRyiy
 DshZRPfuJCqkUjOrLWJx8/5No6pVTqhWslQLdW9oG9SCXIsmLYbjBcCJ3Y3JYHp21BLLjg2V9b7
 p1kUvKySFJQsqwGJPOB23gEJnK6313WoD7Qu1+AEJcBMsqksVkxEmjbpd5FD5LCGCCJdxiMSnzd
 5Sg17qrSO5DkPhQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Specific allocations for each DRM object is not strictly needed in VKMS 
right now, but in order to implement dynamic configuration of VKMS 
(configFS), it will be easier to have one allocation per DRM object.

There is no need for a dynamic allocation for the writeback connector as 
there can only be one per CRTC

No functionnal changes are intented in this series.

This series requires [1] to switch vkms objects to drm-managed objects.

[1]:https://lore.kernel.org/all/20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- Rebased on drm-misc-next
- Apply comments from Jose
- Link to v1: https://lore.kernel.org/r/20240912-b4-vkms-allocated-v1-0-29abbaa14af9@bootlin.com

---
Louis Chauvet (4):
      drm/vkms: Switch to dynamic allocation for connector
      drm/vkms: Switch to dynamic allocation for encoder
      drm/vkms: Switch to dynamic allocation for CRTC
      drm/vkms: Rename vkms_output to vkms_crtc

 drivers/gpu/drm/vkms/vkms_composer.c  |  30 +++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c      | 100 ++++++++++++++++++----------------
 drivers/gpu/drm/vkms/vkms_drv.h       |  21 ++++---
 drivers/gpu/drm/vkms/vkms_output.c    |  41 +++++++++-----
 drivers/gpu/drm/vkms/vkms_writeback.c |  25 +++++----
 5 files changed, 118 insertions(+), 99 deletions(-)
---
base-commit: 98efdd02e220fea84c1491012d7292749a71faeb
change-id: 20240909-b4-vkms-allocated-9f5508f4444a
prerequisite-message-id: 20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com
prerequisite-patch-id: b608594ad493a41000ee703792eac4b23f9e35dc
prerequisite-patch-id: 5697aa87c44bbf3eda8a1ba424465dc792545d4c
prerequisite-patch-id: 223d59c407ce28dacf3f563b5c0148d2398303f1
prerequisite-patch-id: 720b75b21d06ce3d3f060fb9238f7903834da0e1
prerequisite-patch-id: 30a1e033fa43241ca6a43006fd4f29f8e9217224

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


