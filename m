Return-Path: <linux-kernel+bounces-209531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25D90373D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196B61C21E47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90901176221;
	Tue, 11 Jun 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EXoraPiE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75420174EEB;
	Tue, 11 Jun 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096169; cv=none; b=NPxK2S20xFo+bHDzc6Az9FfxC3cS46BrFcwY1hwu6ce4ah0hmlBfrtDV//BeZlUUSldsBw+WY+VJJb5hGmTWUaG+ClcpRSIrQP8ZVmU/Wuwf4YII369yo4CGJS3QGDWiQgFbRSBhe3OCpmHodN/vtd+oaZbP9b0KdmS2ECbqHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096169; c=relaxed/simple;
	bh=jyXZ6Jmf602HyTlI6R8H2s9bUCikY0FkUQKhwDBS4eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuN3cPFe+IG7HQkknF4PmS0EzUD0qs0cM9IUCxSrn3T1H9rrAn27+9thAkd6scmdU7AYsvLYtG0CUDNhsc33Gk7Cv03+AAzkWWpfwSrMRl68uS9RbOSz2Qjk5AgnBEKmMxw4y1ntSzX4nH+ikOpfeDWzr7PU6mcFV3yE+WUp2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EXoraPiE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718096166;
	bh=jyXZ6Jmf602HyTlI6R8H2s9bUCikY0FkUQKhwDBS4eE=;
	h=From:To:Cc:Subject:Date:From;
	b=EXoraPiEN270DmvqR7ysOyaTy9JXeBNGVwFlanfv/WHqUC2RULZGc6Mgz77ahE6Vj
	 p2E4Eml5aApaJ+fFwaBuBIAlySQc8Iuj0y8c9wDWps/O0hlse2GlUQ+rn4OLDhb3iM
	 mRshvN0fNDbVom4oWFIod6+u1peB+B2asyb3hGmu4g1CgYHQc3KjIMZ7EHpeqKFHCD
	 ncnU9QRe20Oj1Gbvm/Mhz7schrzmNyDo3F+pJL2207yfnqf/hiuuSO/6IvmOJLPES9
	 h4B8Lw3R9VLuTJO15Xw85/qupnYsBaJv2BrFL3ME/AeBtSqH/F5+NN1BKWtncPhORe
	 nK7yE+iJhevoQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 832AD378020A;
	Tue, 11 Jun 2024 08:56:05 +0000 (UTC)
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
Subject: [PATCH v3 0/2] drm/panfrost: Add MT8188 support
Date: Tue, 11 Jun 2024 10:56:00 +0200
Message-ID: <20240611085602.491324-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Added comment stating that MT8188 uses same supplies as MT8183
   as requested by Steven

Changes in v2:
 - Fixed bindings to restrict number of power domains for MT8188's
   GPU to three like MT8183(b).

This series adds support for MT8188's Mali-G57 MC3.

AngeloGioacchino Del Regno (2):
  dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
  drm/panfrost: Add support for Mali on the MT8188 SoC

 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml      |  5 ++++-
 drivers/gpu/drm/panfrost/panfrost_drv.c                | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.45.2


