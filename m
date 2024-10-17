Return-Path: <linux-kernel+bounces-369639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43F9A2033
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE603284AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8C1DC06B;
	Thu, 17 Oct 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kID0Kicp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C11DBB38;
	Thu, 17 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161497; cv=none; b=un8mm+gsUJq/XT9Fix5p4/aw42Epx3QTxqXf0UD1xSD9VSHTRMZE5stR17OCp0B4658C5kTrGQ04DJjLNO9+n2eGKy1UEKp26tTsLrUq40BgQRlUdoFCjIQG8TE6RRJZK3OHtd6uJL5S6l0iEK5LkFdUyi0OLfi9MRnSORRtE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161497; c=relaxed/simple;
	bh=jXiDkFoZYCjQNU0227vK4uN8/5Y4t0+E87GfULGImjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTNCamVMC4G14l7o3pxMvLActV/ldS/byB1WA9TtQDK63xO43hUDRt/ICiXwQ57u/MSaVrmCs2mm5wlGFZDhOUzJTTQukVvkgTdg8qVtcfw4jxbUdMxRI4kAq3waVHk4oMyK7tDz7DruxC8P4G+oWKT5V63weipyRik0VzLKKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kID0Kicp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729161493;
	bh=jXiDkFoZYCjQNU0227vK4uN8/5Y4t0+E87GfULGImjI=;
	h=From:To:Cc:Subject:Date:From;
	b=kID0Kicp7MkG1YqnMnQstNhlL2WgIpma4aOl1TEzxkF9mthFzjzhmGrU76DXUdsKa
	 6X4n+X9LHWZIcUs84HoSr5BhZPenYbcuuZc4TWPQKZwLRPPl0QuEg0eeGOH4ymJS6f
	 4cLvMlaV2fGI5JIr1/tqqo9mOy4k7z0s/5Hjygm3GxguSD3Jy+TYGOQsmSTa4fh3ZV
	 +ZjWiQUNJC5yJ8ShA2dwGHV1xd9PKEdX/rkLxu/99wedlenDnzwzSojYV/zdBhsoW2
	 p50K1KujDYOPqwNEWlDmH7lBZWkyLF/dApGcU3KjD0jmAUizIUTa81Xm57WdTPfsxn
	 X2Z5pjHSIYVsw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C31CA17E13A2;
	Thu, 17 Oct 2024 12:38:12 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com,
	sui.jingfeng@linux.dev,
	michael@walle.cc,
	sjoerd@collabora.com
Subject: [PATCH v13 0/3] drm/mediatek: Add support for OF graphs
Date: Thu, 17 Oct 2024 12:38:06 +0200
Message-ID: <20241017103809.156056-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v13:
 - Added comment in commit description of patch [1/3] to warn about
   new port scheme.
 - The series is now fully reviewed, tested, hence *ready*.

Changes in v12:
 - Added comment to describe graph for OVL_ADAPTOR in patch [3/3]
   as suggested by CK Hu.

Changes in v11:
 - Added OVL_ADAPTOR_MDP_RDMA to OVL Adaptor exclusive components list
   to avoid failures in graphs with MDP_RDMA inside
 - Rebased on next-20241004

Changes in v10:
 - Removed erroneously added *.orig/*.rej files

Changes in v9:
 - Rebased on next-20240910
 - Removed redundant assignment and changed a print to dev_err()
 - Dropped if branch to switch conversion as requested; this will
   be sent as a separate commit out of this series.

Changes in v8:
 - Rebased on next-20240617
 - Changed to allow probing a VDO with no available display outputs

Changes in v7:
 - Fix typo in patch 3/3

Changes in v6:
 - Added EPROBE_DEFER check to fix dsi/dpi false positive DT fallback case
 - Dropped refcount of ep_out in mtk_drm_of_get_ddp_ep_cid()
 - Fixed double refcount drop during path building
 - Removed failure upon finding a DT-disabled path as requested
 - Tested again on MT8195, MT8395 boards

Changes in v5:
 - Fixed commit [2/3], changed allOf -> anyOf to get the
   intended allowance in the binding

Changes in v4:
 - Fixed a typo that caused pure OF graphs pipelines multiple
   concurrent outputs to not get correctly parsed (port->id); 
 - Added OVL_ADAPTOR support for OF graph specified pipelines;
 - Now tested with fully OF Graph specified pipelines on MT8195
   Chromebooks and MT8395 boards;
 - Rebased on next-20240516

Changes in v3:
 - Rebased on next-20240502 because of renames in mediatek-drm

Changes in v2:
 - Fixed wrong `required` block indentation in commit [2/3]


The display IPs in MediaTek SoCs are *VERY* flexible and those support
being interconnected with different instances of DDP IPs (for example,
merge0 or merge1) and/or with different DDP IPs (for example, rdma can
be connected with either color, dpi, dsi, merge, etc), forming a full
Display Data Path that ends with an actual display.

This series was born because of an issue that I've found while enabling
support for MT8195/MT8395 boards with DSI output as main display: the
current mtk_drm_route variations would not work as currently, the driver
hardcodes a display path for Chromebooks, which have a DisplayPort panel
with DSC support, instead of a DSI panel without DSC support.

There are other reasons for which I wrote this series, and I find that
hardcoding those paths - when a HW path is clearly board-specific - is
highly suboptimal. Also, let's not forget about keeping this driver from
becoming a huge list of paths for each combination of SoC->board->disp
and... this and that.

For more information, please look at the commit description for each of
the commits included in this series.

This series is essential to enable support for the MT8195/MT8395 EVK,
Kontron i1200, Radxa NIO-12L and, mainly, for non-Chromebook boards
and Chromebooks to co-exist without conflicts.

Besides, this is also a valid option for MT8188 Chromebooks which might
have different DSI-or-eDP displays depending on the model (as far as I
can see from the mtk_drm_route attempt for this SoC that is already
present in this driver).

This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
NIO-12L with both hardcoded paths, OF graph support and partially
hardcoded paths, and pure OF graph support including pipelines that
require OVL_ADAPTOR support.

AngeloGioacchino Del Regno (3):
  dt-bindings: display: mediatek: Add OF graph support for board path
  dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
  drm/mediatek: Implement OF graphs support for display paths

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |  28 ++
 .../display/mediatek/mediatek,aal.yaml        |  40 +++
 .../display/mediatek/mediatek,ccorr.yaml      |  21 ++
 .../display/mediatek/mediatek,color.yaml      |  22 ++
 .../display/mediatek/mediatek,dither.yaml     |  22 ++
 .../display/mediatek/mediatek,dpi.yaml        |  25 +-
 .../display/mediatek/mediatek,dsc.yaml        |  24 ++
 .../display/mediatek/mediatek,dsi.yaml        |  27 +-
 .../display/mediatek/mediatek,ethdr.yaml      |  22 ++
 .../display/mediatek/mediatek,gamma.yaml      |  19 ++
 .../display/mediatek/mediatek,merge.yaml      |  23 ++
 .../display/mediatek/mediatek,od.yaml         |  22 ++
 .../display/mediatek/mediatek,ovl-2l.yaml     |  22 ++
 .../display/mediatek/mediatek,ovl.yaml        |  22 ++
 .../display/mediatek/mediatek,postmask.yaml   |  21 ++
 .../display/mediatek/mediatek,rdma.yaml       |  22 ++
 .../display/mediatek/mediatek,ufoe.yaml       |  21 ++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   1 +
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  43 ++-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  21 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 253 +++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  14 +-
 23 files changed, 712 insertions(+), 25 deletions(-)

-- 
2.46.1


