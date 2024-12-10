Return-Path: <linux-kernel+bounces-440487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F459EBEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C771887DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616311F1917;
	Tue, 10 Dec 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N0sZit+X"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFE2451E7;
	Tue, 10 Dec 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872035; cv=none; b=l/q0Cf+LOUYlVOn+3TAhGSSLc1Mh6bGAqXu4fy/hvPbVAczMHWT2UlQyf4s7HNWtvuf9WYeP8ZW5Y6zNNY8SoUPx7ITgMNE8E8ET3U2JYZ5GY5YqTUSPlIy2l7tKN0SJyQh5YvLnf/d3C3pUHmTjbRAElX40yvj86ECICiKiAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872035; c=relaxed/simple;
	bh=tG+zEB9hq2JUdiypa3J0UW/bkrCDojHcflJ5SShtQyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WtjJPQD3uAZJs3PFjKXA3oJ7Yy6sEkrPhHWJxDplens+54VEX8MMJ+x0VF1KdxFrgAgth2oTRPHPiZY8ZkQpc9a0Krl5VfMSxrEBxWSdMV9c53CmF8KqqkXrHCi46OJ+Ze3QmtugbF9lM+oOHCq6mSMWV9U0gdVKmc4wjVJ3G6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N0sZit+X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733872031;
	bh=tG+zEB9hq2JUdiypa3J0UW/bkrCDojHcflJ5SShtQyU=;
	h=From:Subject:Date:To:Cc:From;
	b=N0sZit+XfJbADE8Df1vccR7w7qaJ0F2CVsi5uewEobNB/2/N5dLLjdxhmASn5OgTg
	 BJpvHwJRGPCvc1RcML7+PabPEXUgZ0AkTJhc3qTp62ispPwA5BN9OOwxtVAMVgKPYm
	 5LgB9LlsgSY0RzqBmYLktzuzPaoM8BwrWcOZQz1iePLHs+KFQDbunm33vbs6mr2U4G
	 lYpyoTFLsPGI+WIm7aJGYoHDi0ItzxkSQ6G2T48u1cHXe9LlgK4bh5E8V8JS8qrqZb
	 9ansLj0NeBkKnZwL7FaX1GHS+jJpOpQjMjJ4a5MAQGko92RlnlLokWvcp185F1pxQz
	 qqp/C7bX8VW3w==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 747F317E09AF;
	Wed, 11 Dec 2024 00:07:11 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
Date: Wed, 11 Dec 2024 01:06:13 +0200
Message-Id: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXJWGcC/3XMSw7CIBSF4a00dywGKJW2I/dhOuBVubEtBgzRN
 Oxd7Nzhf5Lz7ZBcRJdgbHaILmPCsNXgpwaMV9vdEbS1gVMuGKeSxEfb9T3xdkVGJBVGa2ms7Ga
 ol2d0M74P7jbV9pheIX4OPbPf+gfKjFBiVKuGQYuLEvRqwrIoHaI6m7DCVEr5ArNct7SsAAAA
X-Change-ID: 20241207-rk3588-hdmi1-704cbb7cd75f
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

The patches provide the basic support to handle the second HDMI output
port found on Rockchip RK3588 SoC.

For now I enabled it on Radxa ROCK 5B only, the board I've been using to
validate this.

** IMPORTANT **

The series has a runtime dependency on "phy: phy-rockchip-samsung-hdptx:
Don't use dt aliases to determine phy-id", a patch submitted recently by
Heiko [1].  Without applying it, the functionality on both HDMI TX ports
will break.

Furthermore, please note this is subject to the same limitations as
HDMI0 when it comes to the supported display modes.  The fixes provided
via [2] are not applicable to HDMI1, hence I will handle it separately
as soon as all dependencies are merged.

Thanks,
Cristian

[1] https://lore.kernel.org/lkml/20241206103401.1780416-3-heiko@sntech.de/
[2] https://lore.kernel.org/all/20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Override hdmi1 pinctrl-0 on rock-5b as it requires hdmim0_tx1_cec
  instead of hdmim2_tx1_cec (fixes a pin conflict when enabling
  CONFIG_SPI_ROCKCHIP_SFC)
- Link to v1: https://lore.kernel.org/r/20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com

---
Cristian Ciocaltea (4):
      drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
      arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
      arm64: dts: rockchip: Add HDMI1 node on RK3588
      arm64: dts: rockchip: Enable HDMI1 on rock-5b

 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi  |  62 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  44 ++++++++-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 119 +++++++++++++++++++-----
 3 files changed, 200 insertions(+), 25 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-rk3588-hdmi1-704cbb7cd75f


