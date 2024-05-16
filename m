Return-Path: <linux-kernel+bounces-181095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF38C7766
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A225B2161E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F91474A3;
	Thu, 16 May 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F+ojAwUo"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900C6BB4E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865510; cv=none; b=CVo0LuNluDh/2TM6yOC1qNfpVp8MTcruOES5v2N1FWGFNKUG5xIiwJ4YFOCV7mP5z6+qnNv4XEHIptX3Q9w+KtqNfr5FGnFJ5d73CgaW/jSmbw2BslF2ANDeKG4jTbT4j5+cn3xkVhiiHCNTMQWSI/UioKA9UG/MY0rT/kFuJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865510; c=relaxed/simple;
	bh=tpNWq4ftrFqRCR+aYnNeh53y/OzEFOCXCa12GAa39cc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pdvunweZiMtsOx3CyjUPa0tgJeUpNtkVpBD6dKa6m1KRlYpJKHpz1e0dSD3s/7Mb07LxeiXoKTvG6qamWkrpAlnhZG1VQZQFgLTX7MqXGCdjYAPwvY72RW6eSVMWCQHqvmgNIgvnuqp2ceshiwwNZODiFGM6dnoQJs7WMhiS+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F+ojAwUo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 208996000B;
	Thu, 16 May 2024 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715865506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r38SkWJT02vzVpsmmgCroScC+y7qjcBjpOzpqydv7Sw=;
	b=F+ojAwUoeZ2cK2lcdDB8q9C4mA4HBH28l76bKz9J5pBIbSvs3pO9Lbe/CbESvDEz6HR7hw
	R4aINJV/+DVgznc7mndYkPQml1gurnSgpgIYVd2rEnN+AImSiFrHLAUxkLzge1XIhN1mQu
	42wFbvuqHmJNC4eSZxaIbRalZGHvaoHzZWfb2C41ZsrEb26qprAo41nmTAWPJcAmxNFvep
	AlrdPVBRNjRxYfJW8Ld2ELdYijS/AnGhS0OicysjOEYkgO35sFGmtGRPgnZpCTeXR+bv/h
	TeGTSf9XaRzQfMbb4pYOBBHV6NxssX+Zh70w4qWA4/uhtS262+EolzdVahC6lA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/5] drm/vkms: Add support for multiple plane formats
Date: Thu, 16 May 2024 15:18:16 +0200
Message-Id: <20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgHRmYC/x3MQQ5AMBBA0avIrE2iJYKriEVbg0loZSpIxN01l
 m/x/wORhClClz0gdHLk4BNUnoFbjJ8JeUwGXeiqKJVGW6GnC11Yg+AUZDNHRGWpHeumsVoZSOk
 uNPH9b/vhfT/vQ0jzZgAAAA==
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=tpNWq4ftrFqRCR+aYnNeh53y/OzEFOCXCa12GAa39cc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmRgee9I8KcghLcV1lL784C81VLb+SXgvfsg1PV
 WNGQ4bKygeJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZkYHngAKCRAgrS7GWxAs
 4mjsD/9ZxGZ7N4ptv1rZ0ieeGNM2Tm4ozk7M1neTAKtDdvtHH5f5f/rsBZzRDYUhul94NC5snLQ
 tqvJGWRntfXxV8qzzl/aBkaFx27yqySocjszW74+tGOX4ngo9JzRzXwc3lPXhK4ih4zavJNIrQd
 vsFdyxg9fqThh+wHpecC0Ok8cATeDAANUPq55jqT+SVgluBRuUEv6irCFiQHPm3zKJsJrnrBbJn
 Y3mjvSLyZmSJMoAjIW8NyoovvL9PXFu0QpbyUTnJknOGPspQPg+CM4giVQmkqtp/uDr8/YHujrX
 TRopciFXnzXpmzr2bc5auiDmGunqhHtjN81vXdDgau/W5+YBN/uibv4fL4HgMkLfc8tUQB9+FSj
 7RQjdd62s31SfACqrMlgPLIXmdWJXFQPyEMQq9GCuM32SLAM4ms3JVmZvsVTz5LS8I5z2RWwu9/
 tA4x4e3HFFvhhJVoftiJkPpHCSXLzlpHGJMKMFI8lv6JYYZVbjEV0Ag5vunGtc89DA3c3nsyyYz
 lOrCKJJD3/5/2Iq1QkvYTOZiBIraOjoR7tW0KsQr8XjDoazLwNhGId12A+qqDvyIzEdU4LYt6LU
 qUkwDU2Tr+40+l+okzACkjG/+QXQPH+g1/Y7Qb6BF2CGtcij27LaD5PB5q9THiyQ+bsENQDBR1u
 5CJpsZl+INcY7HA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series introduce a macro to generate a function to read simple
formats. It avoid duplication of the same logic for similar formats.

PATCH 1 is the introduction of the macro and adaptation of the existing
code to avoid duplication
PATCH 2-5 introduce new formats with the help of this macro.

This series must be applied on top of [1].

[1] https://lore.kernel.org/all/20240516-yuv-v8-0-cf8d6f86430e@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Louis Chauvet (5):
      drm/vkms: Create helpers macro to avoid code duplication in format  callbacks
      drm/vkms: Add support for ARGB8888 formats
      drm/vkms: Add support for ARGB16161616 formats
      drm/vkms: Add support for RGB565 formats
      drm/vkms: Add support for RGB888 formats

 drivers/gpu/drm/vkms/vkms_formats.c | 218 ++++++++++++++++++------------------
 drivers/gpu/drm/vkms/vkms_plane.c   |  11 ++
 2 files changed, 123 insertions(+), 106 deletions(-)
---
base-commit: 96b4d11bd9ea36c20bd3428e0932c209ce2e2d36
change-id: 20240312-b4-new-color-formats-1be9d688b21a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


