Return-Path: <linux-kernel+bounces-436187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCD9E8247
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D21884663
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2215886C;
	Sat,  7 Dec 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FuHnvg7p"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EBD27E;
	Sat,  7 Dec 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607181; cv=none; b=gVTIAItcw/4EThHtgjVWWbMnlZf9bznUnzyLrGEUtZxFmMWW+FFxu2nqw311t60dmBtetDlwPoKSHh23LlWlOI47WvYdHutkUYmvvJIt9QXmDFZEGeE/SWIDfhUVpc7ROGTmjCZYYnTcdcnfVabop1YxejFCxo4q8s3F02a7ZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607181; c=relaxed/simple;
	bh=e/F5YyK5MttfQZR5pjBEF/euITS0jR40bnuYvHJXw08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cvh6YcWOnhWP2uW8wynCwyOOtNEfl8phcde4xAN+Ep4IQnD0CQaKhzsdgb5kPIpsD8bQhBkFh0Q4F1to+TtuRru0TwHXleLpzTfcUG4Tuz2M0bggatGg22uWr9Qq7QDIYvVmEvq8Y+hbu9FIw4f4uJiF5i0KCeG4NTzK+csqyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FuHnvg7p; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733607171;
	bh=e/F5YyK5MttfQZR5pjBEF/euITS0jR40bnuYvHJXw08=;
	h=From:Subject:Date:To:Cc:From;
	b=FuHnvg7p9ZFYZBs0s2l+Qp4zdmkfmcQyewSCFvqLzzSfDjhJfQ8h8L7HRYNtUFCVe
	 QYMVe+Y97Fxscl1XjOasF8D8CmJCsXrD0gBU3TroAiMQILui7u4jSbq85oGY8ADPIj
	 lQnKPq9737QDNcudJqNCNXtRhbSM0/YVmMczW6RRtxOKLO6ZLgT22xOQRiRIiC1AcH
	 mWGJoSAWZvKoRU89qFyu6Xb+UPV4FqId5iG4s72Xm+PB31xZBcoFdemw1VfDsROBz9
	 vh5cFeJ18IXv51kmgIH4fqEbzRzGrnbPmXkUkeYVnFlz6DPjbCla7feF93twdg7KTf
	 j/58AyQV+Vchg==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 869D417E37FF;
	Sat,  7 Dec 2024 22:32:51 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/4] Add support for HDMI1 output on RK3588 SoC
Date: Sat, 07 Dec 2024 23:32:23 +0200
Message-Id: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOe+VGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNz3aJsY1MLC92MlNxMQ11zA5PkpCTz5BRz0zQloJaCotS0zAqwcdG
 xtbUA1V/m1F4AAAA=
X-Change-ID: 20241207-rk3588-hdmi1-704cbb7cd75f
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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
Cristian Ciocaltea (4):
      drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
      arm64: dts: rockchip: Add PHY node for HDMI1 TX port on RK3588
      arm64: dts: rockchip: Add HDMI1 node on RK3588
      arm64: dts: rockchip: Enable HDMI1 on rock-5b

 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi  |  62 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  42 ++++++++-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 119 +++++++++++++++++++-----
 3 files changed, 198 insertions(+), 25 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-rk3588-hdmi1-704cbb7cd75f


