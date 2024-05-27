Return-Path: <linux-kernel+bounces-190314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580B8CFCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAAA282712
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE713A27D;
	Mon, 27 May 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SoLhD/G4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B12139D12;
	Mon, 27 May 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801920; cv=none; b=TCTf3HU6+bATMmW7jwWHY3mcaWJ8ipoBUJ5+gxoM1ZWT3xp/WWVmjs/g+x1pg9mGcsUKBIITs2ehSE7XhZXsTZda261UR/3GvqyI/uNk7z14gwFkEPi5y56bWPFLjv4879m8OmD2aIpXCGecCpK++N9Bkgyg3BluCkeWVHQadkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801920; c=relaxed/simple;
	bh=AjVXj1OoeM119VTDcnK+q4iv8gMO2nea9gJqqFXcka4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaf0WNUFIYTcMGMgQ8UIvfmuyyLiuU0/MUUVw2/T1IuQqIXDTqOC/qxj7WU4ssRQrJgy9OplNJ/Z1MsKOxwKv08ep3HVTHU0L0HZsy9yhostV2MZ3ZIu3Bk/s1HkyXb6qr1VJbcyOIe8GVmbe/EumWVI1TV0aMGqmRQrxUjc4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SoLhD/G4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716801916;
	bh=AjVXj1OoeM119VTDcnK+q4iv8gMO2nea9gJqqFXcka4=;
	h=From:To:Cc:Subject:Date:From;
	b=SoLhD/G4q+46qWolyFE5jDNvHg1xik37vKcdsBjlxf28588SbHgzgtAdmgjqvz/zb
	 Ai67IgeuACIJyaxzdIQ9xP5IRDVtZCgjF2V3NzTOj1+1lHQIdZ8hJ6HWp4HD8e2A7w
	 bnziQxSRIwx4MyuPXLCpD/YHQeqeFGOiRXRePNrMffMY+H5gcLFUN60HBT2tyaa1bM
	 jCf3yr45KS5yC1tO2pUksb1VrWW5RkfjnJ3nBt857ZeNQFd9znRR9PN/90OqXBwMoI
	 KgEMboBylqWYtMfz9MMRD9PDGC9AE5X8R6FvRFgNyMp8dr1oCMOT5tk8KdHCMdPp6y
	 wK0Rm7jtF4LQA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A021378203F;
	Mon, 27 May 2024 09:25:15 +0000 (UTC)
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
Subject: [PATCH 0/2] drm/panfrost: Add MT8188 support
Date: Mon, 27 May 2024 11:25:11 +0200
Message-ID: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for MT8188's Mali-G57 MC3.

AngeloGioacchino Del Regno (2):
  dt-bindings: gpu: mali-bifrost: Add compatible for MT8188 SoC
  drm/panfrost: Add support for Mali on the MT8188 SoC

 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml        | 1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c                  | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.45.1


