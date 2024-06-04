Return-Path: <linux-kernel+bounces-200615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A48FB270
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D618B26164
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64E146D65;
	Tue,  4 Jun 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n6zvlhQJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E63146598;
	Tue,  4 Jun 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504769; cv=none; b=GXhxjQUJQN4HXK37QCGb1Wr3e/eItmeLoWHyqvGij8CUZwlEmoMF5MywrqJKgn7wjq6A7dLpRPtQ6wxX4C9NEvydkYxxi7ZPHop8QaqLdxsMPWDPa1MKNjigP5nI3j5IZ8EGqILw00r580f4SEf/eZ0tTdMvPjjZbraPRgFcDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504769; c=relaxed/simple;
	bh=neyavww+fmoXtsq8dOJETlMstKR82zPDydDGrfHscoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLKhyxDF07MsFHjLUrNYzfRIKHb4lgz2C9/w6Pk9vPiorbf/d7DhmNA1NiIVGFfmCni990wM0xSfrz/W5GMYsgggLYwVgXo+OcMZzT4PRFUbk9QRkOrapzW/JkQEUU6ULQopANOqGv9d4RnmxrzoAq7aPMXm9b7Aceaf7RJ8An4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n6zvlhQJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504766;
	bh=neyavww+fmoXtsq8dOJETlMstKR82zPDydDGrfHscoE=;
	h=From:To:Cc:Subject:Date:From;
	b=n6zvlhQJC6+IwBALtX7My3wR3eEKc19cyRlxukQVC0fDN8oCxD2DTC4y1HK08oO8b
	 ZISIgVpR1FxiqqPT3sjOhLtJDyOwjSLNJjLkctM+j9duvxD9Vl2V+x39qI2KFfpiaj
	 79oL6Hqy50WnIqKLg0oddv0Nxm8aS0ye6dpIp+86S3OaU6FCI09lsoCSFJq8w9Vb9K
	 OkNCnbClVMXKR89hT1wxN/4kUNorECTC57Ds/GqQTIuoyWLxMxNT0AFyS2D95VNYwJ
	 cOqTSKG7xS8aNzx0EBVlaQIBNN3n/M38k6WO7ikHZnUnAdKzWTxLto3BV9pUksop2n
	 FAhph6kGZjonw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DBEAC37821A8;
	Tue,  4 Jun 2024 12:39:24 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: boris.brezillon@collabora.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steven.price@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] drm/panfrost: Add MT8188 support
Date: Tue,  4 Jun 2024 14:39:20 +0200
Message-ID: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Fixed bindings to restrict number of power domains for MT8188's
   GPU to three like MT8183(b).

This series adds support for MT8188's Mali-G57 MC3.

AngeloGioacchino Del Regno (2):
  dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
  drm/panfrost: Add support for Mali on the MT8188 SoC

 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml        | 5 ++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c                  | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.45.1


