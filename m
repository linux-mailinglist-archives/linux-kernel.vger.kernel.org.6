Return-Path: <linux-kernel+bounces-386635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D39B4632
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF281B226EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4451A205ABA;
	Tue, 29 Oct 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RqyHhxSh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8CB204091;
	Tue, 29 Oct 2024 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195760; cv=none; b=WQRmo58hsZUPhJgBak523cdf8sLDald1cKzONYkOwq4qvH67KUJTyUvosEViTfZ+ajNzsH44k8M4l/JSqwwfO9lZM0W9tRUiXqQnoNXVPOE5Ta7XdWK0CfTxjI1Hh5uv4zag9uKC//tCF+5SIu3CXtPH6q01zRGpMXsVmQM0heI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195760; c=relaxed/simple;
	bh=KuSK6yv8jISiEGH0rot5gVEQW5xwX37E3+QQhX1/l4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btY9SsoTYqSrGFKvJkraS2O64WcURVpG+ip9GHYQOpN0GDTkzAnyMlAV2VwVcDerJinUj+KVeuD5VYuqHVWws+/cCgn5MsgMVP6YAgQcK4g8JSazSY2Ac88vRVaKYaHn2I6atv+FreBcVFBodOYanJvyi+rHYD3BsBa4xyZHn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RqyHhxSh; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=YkP+h
	HuVKz3drYv66Z6ob+bBObbmmlMznGnxdNwYQgA=; b=RqyHhxShp7vkJw9Sxgz8r
	auzw7BM8Ffhibbz8hNslcMkmgFUB0dd9mJIUOqreCAOVZadE82V2lrU5p1fbZ+u7
	28eiBGec+S6TNBdvmH9RKpcbSli1s5AOpdo4TTf06FNEqE68WrrfB4JE4FVAMeUO
	sYhGdDie8sS6q27zNs0aiM=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nxoCsSBn8+3dEA--.3291S2;
	Tue, 29 Oct 2024 17:55:18 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
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
Subject: [PATCH v4 00/14] VOP Support for rk3576
Date: Tue, 29 Oct 2024 17:54:53 +0800
Message-ID: <20241029095513.391006-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxoCsSBn8+3dEA--.3291S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF13Gr4rAF48WrWUWFyUWrg_yoW5CF1fp3
	98CryrZrWxCFyjqrs7Jw1UCrWFvwnayay7Ww4fG3W7J3W5KFnrKr9I9Fn8ZrZxX3WxZF4j
	krs3X34UKFsIvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmZXwUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQyHXmcgr44a3QAAsd

From: Andy Yan <andy.yan@rock-chips.com>


Thanks for the basic work from Collabora, I can bringup a HDMI
display out on rk3576.

No big changes in this version.

I remove the patch that set dma mask to 64 bit in V3, as it seems
that it's not easy to come up with a suitable solution in the short
term.

Others are some typo fix and collection of Tested-by

PATCH 1 is a carryover from the working when add support for
        rk3588[0], is very usefull when some people want me
        help debug some issue online, so I really hope it can
        be merged at this round.
PATCH 2~4 are bugfix of rk3588 alpha blending which report and
        test by Derek
PATCH 5~12 are preparations for rk3576 support
PATCH 13~14 are real support for rk376

I test it with a 1080P/4K HDMI output with modetest and weston output.

The hdmi depends Cristian's work which get merged in drm-misc recently[1]
If there are some one want to have a try, I have a tree here[2]

[0] https://patchwork.kernel.org/project/linux-rockchip/cover/20231211115547.1784587-1-andyshrk@163.com/
[1] https://lore.kernel.org/linux-rockchip/172917428139.3344404.160573495360164649.b4-ty@kernel.org/
[2] https://github.com/andyshrk/linux/tree/rk3576-vop2-upstream-v4

Changes in v4:
- Fix some typo
- Typo fix: selet->select
- collection of Tested-by and Reviewed-by

Changes in v3:
- Split it from 10/15, as it fix a exiting compile warning.
- Add comments for why we should treat rk3566 with special care.
- Add hardware version check
- Add comments for why we should treat rk3566 with special care.
- ordered by soc name
- Add description for newly added interrupt
- Share the alpha setup function with rk3568
- recoder the code block by soc

Changes in v2:
- split it from main patch add support for rk3576
- Add platform specific callback
- Introduce vop hardware version
- Add dt bindings
- Add platform specific callback

Andy Yan (13):
  drm/rockchip: vop2: Add debugfs support
  drm/rockchip: vop2: Fix cluster windows alpha ctrl registers offset
  drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
  drm/rockchip: vop2: Fix the windows switch between different layers
  drm/rockchip: vop2: Support 32x8 superblock afbc
  drm/rockchip: vop2: Add platform specific callback
  drm/rockchip: vop2: Support for different layer select configuration
    between VPs
  drm/rockchip: vop2: Introduce vop hardware version
  drm/rockchip: vop2: Register the primary plane and overlay plane
    separately
  drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
  drm/rockchip: vop2: Add uv swap for cluster window
  dt-bindings: display: vop2: Add rk3576 support
  drm/rockchip: vop2: Add support for rk3576

Min-Hua Chen (1):
  drm/rockchip: vop2: include rockchip_drm_drv.h

 .../display/rockchip/rockchip-vop2.yaml       |   13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 1572 ++++---------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h  |  274 ++-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  | 1948 ++++++++++++++++-
 4 files changed, 2680 insertions(+), 1127 deletions(-)

-- 
2.34.1


