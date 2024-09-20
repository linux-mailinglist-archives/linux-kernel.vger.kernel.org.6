Return-Path: <linux-kernel+bounces-334082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41797D264
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33F62865E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E077E107;
	Fri, 20 Sep 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ozpUVoE1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D232770E2;
	Fri, 20 Sep 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820281; cv=none; b=n7KVoEZ6uvvnIgP/XjQTaAW//dvLyuS3T5LlAqWelI2ZGc3ixoWh5VdYJ+l6RgutY84UcWIC82QELuy+VGIxq0MYrthEmGIpc5JJ0OIam20VfyBS0aszrAFjPZfv79UWINu2TsB2/dg1L0nuy7YQRNUX9dWy0uYksV1IeyRCNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820281; c=relaxed/simple;
	bh=hWGgq2pgUIxxCz3y0vgKfzl/6h1fW4m3X1VA+6U0VK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYFL8i0/BeJ9fUvLyrkDZxBRntga1DgosqN5j03hnoYeprpQ/1OnwonAyDaEHvLoKPRscIaSzPAB+RXdAPrRomb65EMoy/57KFuVYpVMmwnT1gX+/AZNVSpWH4D2YWSEe6Vt0m63I3e2FlIL5lIBkyCnNONZPkPTnB5g81v3u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ozpUVoE1; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=BEGbI
	sQTh+g3JWARPrbSM2LwRVGpbQaDzPpAvAWnYdQ=; b=ozpUVoE1zCGAMAElO+FjF
	7W546U8aTZ/CJ5ZAnPWfvtDwxgN/J3QY97pwAlZ+/hDFquX3CvAfBKQUSublpUf+
	HPVqUAhC3AsArLTLL79QLl3Ta+KV8siJ3WOnAPpRxvGU/jRxiiNMCoD/8L1LcDlM
	i/1mUFLODpYvVFW0pUtzHg=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnr2yIL+1mqL21Gw--.53445S2;
	Fri, 20 Sep 2024 16:17:16 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 00/15] VOP Support for rk3576
Date: Fri, 20 Sep 2024 16:17:10 +0800
Message-ID: <20240920081711.6493-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <.patch/rk3576_vop_upstream_v3/0002-drm-rockchip-Set-dma-mask-to-64-bit.patch>
References: <.patch/rk3576_vop_upstream_v3/0002-drm-rockchip-Set-dma-mask-to-64-bit.patch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr2yIL+1mqL21Gw--.53445S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1fXF4UAF4UGF13uw4UArb_yoW5Xr15p3
	98CryrXrZ7CFyjqrn7Gw4UCrWSqwnayay7Ww4fG3ZrA3WSyFnrKr9xuFn8ZrZIq3WxZF4U
	Crs7X34UGF4IvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtWrAUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqR5gXmVODBG+xwABsH

From: Andy Yan <andy.yan@rock-chips.com>


Thanks for the basic work from Collabora, I can bringup a HDMI
display out on rk3576.

PATCH 1 is a carryover from the working when add support for rk3588,
        is very usefull when some people want me help debug some issue
        online, so I really hope it can be merged at this round.
PATCH 2~5 are bugfix of rk3588 alpha blending which report and test by
         Derek
PATCH 6~13 are preparations for rk3576 support
PATCH 14~15 are real support for rk376

The hdmi depends on WIP patch from Cristian[1]
I test it with a 1080P/4K HDMI output with modetest and weston output.

If there are some one want to have a try, I have a tree here[2]

[0] https://patchwork.kernel.org/project/linux-rockchip/cover/20231211115547.1784587-1-andyshrk@163.com/
[1] https://lore.kernel.org/lkml/20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com/
[2] https://github.com/andyshrk/linux/tree/rk3576-vop2-upstream-v3

Changes in v3:
- Add comments for why we should treat rk3566 with special care.
- Add hardware version check
- Add description for newly added interrupt
- Share the alpha setup function with rk3568
- recoder the code block by soc

Changes in v2:
- split it from main patch add support for rk3576
- Add platform specific callback
- Introduce vop hardware version
- Add dt bindings
- Add platform specific callback

Andy Yan (15):
  drm/rockchip: vop2: Add debugfs support
  drm/rockchip: Set dma mask to 64 bit
  drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
  drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
  drm/rockchip: vop2: Fix the windows switch between different layers
  drm/rockchip: vop2: include rockchip_drm_drv.h
  drm/rockchip: vop2: Support 32x8 superblock afbc
  drm/rockchip: vop2: Add platform specific callback
  drm/rockchip: vop2: Support for different layer selet configuration
    between VPs
  drm/rockchip: vop2: Introduce vop hardware version
  drm/rockchip: vop2: Register the primary plane and overlay plane
    separately
  drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
  drm/rockchip: vop2: Add uv swap for cluster window
  dt-bindings: display: vop2: Add rk3576 support
  drm/rockchip: vop2: Add support for rk3576

 .../display/rockchip/rockchip-vop2.yaml       |   13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 1572 ++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h  |  274 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  | 1948 ++++++++++++++++-
 5 files changed, 2683 insertions(+), 1128 deletions(-)

-- 
2.34.1


