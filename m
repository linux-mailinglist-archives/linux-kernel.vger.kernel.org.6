Return-Path: <linux-kernel+bounces-424257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D39DB227
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FABB230E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29113A24D;
	Thu, 28 Nov 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dD9XeIQX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F845025
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767999; cv=none; b=hDRyHmfsDUtZFXLbntOeQwhvonhs/lh2NsrXP3Lvx9XXWUxEE/bO1WFoQTi178EIqOQANWYHaiNVq4QY58DXnPLVjsAJ0PufqP/jR7TTYLOT45CDxTtUUE0SNDSvb3lr2FXMV+bbEg8Q4EnqERSK+FwqOlxyCooufKUppsrBaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767999; c=relaxed/simple;
	bh=wQmBhpaZkflxWhHgpRCNXR0O8vTWJ+J0iFv8bWASh6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbVv/1aZAyRRvNRJKa/jBYlmFPAEB6TG6BzRuyo9A1FojfiDNnSZl8vpNzH3AMKiKwPvOKJX2CdRqrk6fcNN7B/RO0y1JB8ko3sj1gUPctPtO/eVgQnDlWtOS7yAdYZk8cqwTGpYWchelX70VB6Q0YKH1EoQtNG6hkU/f1+U+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dD9XeIQX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732767680;
	bh=wQmBhpaZkflxWhHgpRCNXR0O8vTWJ+J0iFv8bWASh6s=;
	h=From:To:Cc:Subject:Date:From;
	b=dD9XeIQXksmNb/9F/I/M1ucSOdAP8lywD/6FnTBewTxPEMt6Ks3P75wrNl/6Ml1R8
	 QOTkdmAc1HXP/im1Oezki03snF/i/uoXCg8uWdAwGUQxOliHnvSqEdKoU4KpbR+8xa
	 aVwXiSyKQ0AKj14qZrodPrWeoxVevUiSRB/AltqcQpQW2l4R8eCuAxINvptVcYTaF9
	 5+fBI21hOGNU378jUPMOB+7pGy+7no/nGdcyTh8DXkYpCLU9BwwrkNqXKMGYMUjxOr
	 PTlayMMZgB1Iejzkst+DIp+GOSgnggA71MpcO6kMWTCUuK2BCWHCmwu4+MlTKjoYsk
	 RHjybs5WFCt2Q==
Received: from localhost.localdomain (unknown [171.76.86.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 175D117E0FA6;
	Thu, 28 Nov 2024 05:21:17 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	jani.nikula@linux.intel.com,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm/ci: uprev mesa and modify gitlab rules
Date: Thu, 28 Nov 2024 09:50:19 +0530
Message-ID: <20241128042025.611659-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprev mesa to adapt to the latest changes in mesa-ci,
including new container jobs and stages. Update the
lava-submit script to align with recent mesa-ci changes
for using LAVA rootfs overlays. Modify gitLab rules
to include scheduled pipelines.

Pipeline link,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1318024

Vignesh Raman (2):
  drm/ci: uprev mesa
  drm/ci: update gitlab rules

 drivers/gpu/drm/ci/build.sh       |   2 +-
 drivers/gpu/drm/ci/build.yml      | 104 ++++++++++++++++-
 drivers/gpu/drm/ci/container.yml  |  22 ++--
 drivers/gpu/drm/ci/gitlab-ci.yml  | 185 ++++++++++++++++--------------
 drivers/gpu/drm/ci/image-tags.yml |  11 +-
 drivers/gpu/drm/ci/lava-submit.sh |  99 +++++++++++-----
 drivers/gpu/drm/ci/test.yml       |  33 +++---
 7 files changed, 314 insertions(+), 142 deletions(-)

-- 
2.43.0


