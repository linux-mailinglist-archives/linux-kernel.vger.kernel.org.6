Return-Path: <linux-kernel+bounces-286097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB96A95167A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E595B230A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFF13D28F;
	Wed, 14 Aug 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KeUKsbMG"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DC20DF4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623590; cv=none; b=Nn2QIeo8zJuDs/zkF+s1Ig1/z2IEzC689c1yTaep4zmpgrXhRe3r7ItxyRpxwCsPgSYHIZkQfJgcrhiwAGsnbh8amy5ZIBZA6nJ9/R/RVwxrawAX3Lnrai3YgqGCz5eG3sB4sYAeDCJpkQQ7TikobKm7Pbw3cLEOds8Zk+s9QPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623590; c=relaxed/simple;
	bh=ZPC3atLxXoEtrqJl2fA9luVfBUd/q7A8/GXQUFWKIdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pbqi6Nf/kQNolA6J4apzPtds/iuIUIq57FCtNSI1cy1NPnVBhCxDqGh50XWD3fB0IwCqcHIScEI+Ps7ixQ/um7iaRNkX81bKgTcnb11nQDX9e4SJF81Hvf2hDHplIGaCsYOkXjkPbO0v5jUMBIYND2uNPCn6rks5ExeQWUaYI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KeUKsbMG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CADADC0002;
	Wed, 14 Aug 2024 08:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723623585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXT2OR2U85EEVIw4IJJAjl0CcFk1v3cp4pbVQDnQAik=;
	b=KeUKsbMGUDtukmZwyEB0BSkwD6YKMr3zhQOX9674T/VCti625uoCsK5GcEidnitUu0KZtc
	I+NJbTKh9D/za6CV/OiaquAZsydID85v+JE2t290fgKx8S6OOsorIdYFM/GRzEF5QrhR5/
	LdLUsqrj2t7V701k0pIS9kZUzEuenDIVy1t/8/nVn0Bo6SPL3DCu9S8LDVTEAhhNrhcSv+
	PeZwUvuxUqCENdO9eQ/Nv2fBjWInpuk79Koe1CYPgNZkEum8jl0ZbSEK5HnrcMdskTAB3+
	AedWrEA4gyHfAfumoYS6YfBT9mFhSp3+DJ4hfqAv1yJI3uB9V6eY9m6zJTrRbg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 0/8] drm/vkms: Add support for multiple plane formats
Date: Wed, 14 Aug 2024 10:19:33 +0200
Message-Id: <20240814-b4-new-color-formats-v2-0-8b3499cfe90e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVovGYC/22PQW7DIBBFr2Kx7qRAHLCtquo9oiwADw1SMC0QN
 1GUu2diq4tK3c0fad77c2MFc8DChubGMs6hhDRRkC8Nc0czfSKEkTKTXLZ8KyTYFib8AZdOKYN
 POZpaQFjsR9V1VgrD6PQrow+XBbs/UD6GUlO+LpZZPLcrcCfU/8BZAAfdOt975Hor9IdNqZ7Ct
 HEpssN9dWT8PlPjuoqYNQWJE2OoQzPmCDEU9/o7kOVSn+UilmKWx4bmbanR8R6u55msnLTCaKd
 VK5Tyf7Tv5L0/AFRNKzAxAQAA
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
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 20240809-yuv-v10-0-1a7c764166f7@bootlin.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2913;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ZPC3atLxXoEtrqJl2fA9luVfBUd/q7A8/GXQUFWKIdA=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmvGierxBxuguWDbOTC16U0701DGMEr4t1blwOc
 6dlN8CWSHGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZrxongAKCRAgrS7GWxAs
 4ueID/wJB8hfh94MPCNBMm4UMK/PvYWcNT3ZTiAuctqndMPBc4pr2XZ3Gn+NnsStuBXlwFiGhMf
 J8d8lOVf6fhw4IhY6V9YjzUB5GwfpPj7gemV33AwyOEszmz8hz225Pr+4Al4kGlNM5bslh4TxG2
 FcmHxIy2wMPNTJSCph7YLjEkFYoMw2zxq58W2+CK9h01C1oYaBChHVkGMy0BQTfmcU2V6mqJUac
 AFxV6nm0OKEowfIChKbrtJdNKyZsml9pKiG0DSm6iWHJ0VH1gbij45V1z3BPFkmpDMAz/7adnSI
 M40HkDirtZ6qhK40aSl+96HIWjXlXyEUCZFG21SG32NRwhr3+okQXgSq72sC3tl44nTF4ikleV+
 Norvuv3aKfSx6r+D6USatmVxzaKE/JyMBRTaAwV021Y24HLZUtWoNaaFay+8G8hpEsdWgHPMbkG
 fZt+nTM5FewAa1c1XMy+ouUVBop6GchCnuDJuncASQHDomtTDg9RwkYrO52IfWQnPbZvZEMxGlx
 aLSiXVOkZ9IDPi+g12KSaAv+0kUqm1o+JyuRsLCsO14gxdtlwScZsLs5mzYjLxLq0EFTRamJ9V+
 sgdQKEuXpAhQxuUN3AkON3zUDbbJyuIczjf7l0hT17nWoipoYUqx6WCI5v2X2xCAhFN9U8XyBrl
 7wI9wax7g4VamEg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This series introduce a macro to generate a function to read simple
formats. It avoid duplication of the same logic for similar formats.

PATCH 1 is the introduction of the macro and adaptation of the existing
code to avoid duplication
PATCH 2-6 introduce new formats with the help of this macro.

This series must be applied on top of [1].

[1]: https://lore.kernel.org/all/20240809-yuv-v10-0-1a7c764166f7@bootlin.com/ 

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- Add proper casting/type to __le16 when needed to avoid warnings with 
  sparse
- Change the function argb_u16_from_yuv8888 to argb_u16_from_yuv161616 to 
  support 16 bits values.
- Add support for P010/P012/P016 format
- Link to v1: https://lore.kernel.org/r/20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com

---
Louis Chauvet (8):
      drm/vkms: Create helpers macro to avoid code duplication in format  callbacks
      drm/vkms: Add support for ARGB8888 formats
      drm/vkms: Add support for ARGB16161616 formats
      drm/vkms: Add support for RGB565 formats
      drm/vkms: Add support for RGB888 formats
      drm/vkms: Change YUV helpers to support u16 inputs for conversion
      drm/vkms: Create helper macro for YUV formats
      drm/vkms: Add P01* formats

 drivers/gpu/drm/vkms/tests/vkms_format_test.c |   3 +-
 drivers/gpu/drm/vkms/vkms_formats.c           | 320 ++++++++++++++------------
 drivers/gpu/drm/vkms/vkms_formats.h           |   4 +-
 drivers/gpu/drm/vkms/vkms_plane.c             |  14 ++
 4 files changed, 195 insertions(+), 146 deletions(-)
---
base-commit: 219b45d023ed0902b05c5902a4f31c2c38bcf68c
change-id: 20240312-b4-new-color-formats-1be9d688b21a
prerequisite-message-id: <20240809-yuv-v10-0-1a7c764166f7@bootlin.com>
prerequisite-patch-id: ae2d8b2efbbaa9decce56632c498c87e708288b3
prerequisite-patch-id: c26b6d4867eaf6566195aa0002765357d4f69f8c
prerequisite-patch-id: 8791d34a6f3148dc518da5249453067e40d346e3
prerequisite-patch-id: 26ec7cd5a449004bcfd6ce483671f87655f8635c
prerequisite-patch-id: 2e855ba871f2e99d4b6b7d85da2ddac6bb32262e
prerequisite-patch-id: 82523a917646793deeec7cdcc7ff286bd924fd21
prerequisite-patch-id: 0e355e5316281f53ab5e97ab6e63b0a682f3eb9e
prerequisite-patch-id: 7a63d245a377d5f5283f48e8f52421b912811752
prerequisite-patch-id: dda6bf4692cd1795c489ff58e72c0841ea8ffbc4
prerequisite-patch-id: f70e535b6086cc587975fbfa75741f485f679a32
prerequisite-patch-id: 6c2aa2645c7d854951608aa4d15a02e076abe1fe
prerequisite-patch-id: dc61c6d3db73053fc36e115af561e0c42b467de2
prerequisite-patch-id: deda292af6d8bbf6762b0bf4d351ffd2225995d8
prerequisite-patch-id: 18554f49b53cbcfd4a8ca50dc83b17dd3cf96474
prerequisite-patch-id: 5633292e10132d29be2467812e6e2e824cfedb67
prerequisite-patch-id: 43f37e9c1bc041d491e41dfb59548ed258a1e071

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


