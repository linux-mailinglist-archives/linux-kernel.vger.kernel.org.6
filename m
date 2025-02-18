Return-Path: <linux-kernel+bounces-519272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA1A39AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B5F3A4F44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99A923FC60;
	Tue, 18 Feb 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="agMxwYXy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947D22D4C9;
	Tue, 18 Feb 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878146; cv=none; b=pCshpP8DhZGkGGF/lUCh0v80Jz+FmVu1nVKfVFDbWrXuqe8q5gGvfask4Ac7NReI0u5YqngA1cFXKkL+da43crGjS1t/cXNxJBFNJ8dMieXeoNnr6uI3oHUzU6kaB2CULetV+xYaTJ6WSdmPnhTi7CVaZfVkAj+X/U4u4/T6iGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878146; c=relaxed/simple;
	bh=NzHGktNLhBj4PWwF4dDHSjE4qG+QEflsUr1I55XIOAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQPt7ZEzJslXi9WhrQ/gLgoQv1afpH5zFIR5CLNEktvRtd0g1gao7JkgnZcGDzbzVYL7mMbYbRSbt8Xog2l4xxrT5fRhqvLisPEGNuAoAeNAuITC93Z1rwTP6wi9Uqp9ihOAlKpH6jMfsgjSB7ZhX6bPkElfwHPP7o7k/k3beoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=agMxwYXy; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Pb3n7
	l2tooqli9b1xrdoDDE+B//VOByVg4XLxTUVUsA=; b=agMxwYXymjYGRduJNDyFO
	ZBfvBrV/EU5OaQ+DvHRNTL5ZjWHWp13KuaTTtK/q5X9BA78Pes2xt2Sx0YRmQFPa
	qjbiFi1XUTKX9FSekVkTKpzuuhHhACUQ7+lECFn/jSJt+Ax2AvW+WCdnT6acuADG
	yOxVI7d86FfhJxfVSVxcFw=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD333uybrRnLIPUMQ--.34107S2;
	Tue, 18 Feb 2025 19:27:49 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v15 00/13] VOP Support for rk3576
Date: Tue, 18 Feb 2025 19:27:27 +0800
Message-ID: <20250218112744.34433-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333uybrRnLIPUMQ--.34107S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1DJr4xCr17ur4kKF43Awb_yoW7Gr4fpa
	95C3s8XrW8GF1jqw4ktw1xCr1SqanxJrW3C34fK3W7Ga1DKF17KrWS9F1Yyr9xGr1xZFWj
	9F4Yya13KanFvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UksqAUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBT3Xme0bEsvuAAAsO

From: Andy Yan <andy.yan@rock-chips.com>


PATCH 1~9 are preparations for rk3576 support
PATCH 10~13 are real support for rk376

I test it with a 1080P/4K HDMI output with modetest and weston
output.

If there are some one want to have a try, I have a tree based on
Linux 6.14-rc1 here[0]

[0]https://github.com/andyshrk/linux/tree/rk3576-vop2-upstream-v14


Changes in v15:
- Remove AFBC/AFBCD prefix of TRANSFORM_OFFSET register
- Remove redundant blank line before function vop2_lock
- Fix nr_regs arguments for smart windows register.
- Link to v14: https://lore.kernel.org/linux-rockchip/20250212093530.52961-1-andyshrk@163.com/

Changes in v14:
- Rebase on drm-misc-next
- Set maxItems constraint of clocks for rk3588 to 9 as a recently
  merged patch added two optional clocks[0]:
  [0]https://patchwork.freedesktop.org/patch/msgid/20250204-vop2-hdmi0-disp-modes-v3-1-d71c6a196e58@collabora.com

Changes in v13:
- Add maxItems constraint for clocks
- Remove constraint for interrupts in allOf block, as the current
  maxItems is already 1.
- typo fix
- Explain the function of this property.
- Use maxItems constraint for clocks in allOf block

Changes in v12:
- Only change the description method for existing SoC.
- Split from patch 10/13
- Split from patch 10/13

Changes in v11:
- Remove redundant min/maxItems constraint
- Remove redundant min/maxItems constraint

Changes in v10:
- Move interrupt-names back to top level
- Add constraint of interrupts for all platform
- Add constraint for all grf phandles
- Reorder some properties
- Move interrupt-names back to top level
- Add constraint of interrupts for all platform
- Add constraint for all grf phandles
- Reorder some properties

Changes in v9:
- Drop 'vop-' prefix of interrupt-names.
- Add blank line between DT properties
- Remove list interrupt-names in top level
- Drop 'vop-' prefix of interrupt-names.
- Add blank line between DT properties
- Remove list interrupt-names in top level
- Drop 'vop-' prefix of interrupt-names.

Changes in v8:
- Remove redundant blank line before drm_bus_format_enum_list
- Add a blank line before DRM_ENUM_NAME_FN
- Fix dt_binding_check errors
- ordered by soc name
- Link to the previous version:
  https://lore.kernel.org/linux-rockchip/6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf/T/#u
- Fix dt_binding_check errors
- ordered by soc name
- Link to the previous version:
  https://lore.kernel.org/linux-rockchip/6pn3qjxotdtpzucpul24yro7ppddezwuizneovqvmgdwyv2j7p@ztg4mqyiqmjf/T/#u

Changes in v7:
- Fix rk3588 dp+dsi maxclk verification

Changes in v6:
- Add a blank line after hardware version check code
-  More specific explanation about the AXI_BUS_ID register bit of
   cluster window.

Changes in v5:
- Add axi id configuration
- Remove the non-existent CBCR scale register.

Changes in v4:
- Typo fix: selet->select
- describe constraint SOC by SOC, as interrupts of rk3576 is very
  different from others
- Drop Krzysztof's Reviewed-by, as this version changed a lot.
- describe constraint SOC by SOC, as interrupts of rk3576 is very
  different from others
- Drop Krzysztof's Reviewed-by, as this version changed a lot.

Changes in v3:
- Add comments for why we should treat rk3566 with special care.
- Add hardware version check
- Add comments for why we should treat rk3566 with special care.
- ordered by soc name
- Add description for newly added interrupt
- ordered by soc name
- Add description for newly added interrupt
- Share the alpha setup function with rk3568
- recoder the code block by soc

Changes in v2:
- Add platform specific callback
- Introduce vop hardware version
- Add dt bindings
- Add dt bindings
- Add platform specific callback

Andy Yan (12):
  drm/rockchip: vop2: Remove AFBC from TRANSFORM_OFFSET register macro
  drm/rockchip: vop2: Add platform specific callback
  drm/rockchip: vop2: Merge vop2_cluster/esmart_init function
  drm/rockchip: vop2: Support for different layer select configuration
    between VPs
  drm/rockchip: vop2: Introduce vop hardware version
  drm/rockchip: vop2: Register the primary plane and overlay plane
    separately
  drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
  drm/rockchip: vop2: Add uv swap for cluster window
  dt-bindings: display: vop2: describe constraint SoC by SoC
  dt-bindings: display: vop2: Add missing rockchip,grf property for
    rk3566/8
  dt-bindings: display: vop2: Add rk3576 support
  drm/rockchip: vop2: Add support for rk3576

Heiko Stuebner (1):
  drm/rockchip: vop2: use devm_regmap_field_alloc for cluster-regs

 .../display/rockchip/rockchip-vop2.yaml       |   99 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 1472 +++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h  |  277 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  | 1798 ++++++++++++++++-
 4 files changed, 2377 insertions(+), 1269 deletions(-)

-- 
2.34.1


