Return-Path: <linux-kernel+bounces-411854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0D9D0075
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893E8282C6F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B233196D9A;
	Sat, 16 Nov 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zq3gKsIC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973F2B2F2;
	Sat, 16 Nov 2024 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731781371; cv=none; b=Zny5p2cJeXxtldLiqQkFZUKREyC3t9PQHEXB1eexoxuB+c4uOI6NTsopWCPzhgKRnpf4ca0mU1N1Ar0Yx0jV5mVRJFfTA6G9op5C/pnNOKm/QwnqtHLLTq2pT1r56d34GLtA9ho2ty4c6OaqJF+qEms2eeSnW8PEyX8ER53CvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731781371; c=relaxed/simple;
	bh=zuX+BjEd47Ipzf1ZvUKylfVmmbKCdRyf5jawLe5SYXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jGISvB+BpZAMKBLXD0uxoiX40OJQLdZY8q6r+VO1pKbwriJFWP5GAT4To7FZl6JlB+fePXGiBBH11jf8MdlQCrBCv/rYmSCJdZayoXTJaiLvnBDKGhoBtqLRZR4qPszpYCNxnponCrWtEhu2RjgXOVE/D5VoV2lJ2PJnH1iyqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zq3gKsIC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731781361;
	bh=zuX+BjEd47Ipzf1ZvUKylfVmmbKCdRyf5jawLe5SYXY=;
	h=From:Subject:Date:To:Cc:From;
	b=Zq3gKsIC5JS8Sp48f3xdnKFMZUaNaEtdnbFLPSywsymPzhFlEpF7HCIx+FcqPU+40
	 7lQIr9MFUA9ThajqAD4csskaVLkGO78B5/B3y+qNRHzsuis1hoovc4wfNwDe5pMZxr
	 6c4gC0NR9dedLJ4K9hRX27SkBu/glMnXz/koqI/YiZ28slciehC72n8zAshNbY3q+4
	 eOK88mLFP2h9ZT1oF3JYr0gTXzx8UNW9X6uYZS/3PmJYJ8GvSQyC64zQ23BYv+JsAf
	 NkFKloeM4gke3eTs+fui6IgaBV+eMTHaxqPtsBn9XgkrkOeuMgul4m217jLb3uFlsc
	 VYV1Rp2reZJ7Q==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 644F417E3768;
	Sat, 16 Nov 2024 19:22:41 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/5] Improve Rockchip VOP2 display modes handling on RK3588
 HDMI0
Date: Sat, 16 Nov 2024 20:22:31 +0200
Message-Id: <20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfiOGcC/x3MPQqAMAxA4atIZgOmSv25ijiojZpBWxoQoXh3i
 +M3vJdAOQorDEWCyLeo+CuDygLWY752RnHZYCrTEJHF2weDhzulQica8PSOFZe659pS39pug9y
 GyJs8/3ec3vcD9X76MWcAAAA=
X-Change-ID: 20241116-vop2-hdmi0-disp-modes-b39e3619768f
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

VOP2 support for RK3588 SoC is currently not capable to handle the full
range of display modes advertised by the connected screens, e.g. it
doesn't cope well with non-integer refresh rates like 59.94, 29.97,
23.98, etc.

There are two HDMI PHYs available on RK3588, each providing a PLL that
can be used by three out of the four VOP2 video ports as an alternative
and more accurate pixel clock source. This is able to correctly handle
all display modes up to 4K@60Hz.

As for the moment HDMI1 output is not supported upstream, the patch
series targets HDMI0 only.

Additionally, note that testing any HDMI 2.0 specific modes, e.g.
4K@60Hz, requires high TMDS clock ratio and scrambling support [1]. The
patch is usable but not yet ready to be submitted - I will handle this
soon.

Thanks,
Cristian

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-next-20241115

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (5):
      dt-bindings: display: vop2: Add optional PLL clock properties
      drm/rockchip: vop2: Drop unnecessary if_pixclk_rate computation
      drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI0
      arm64: dts: rockchip: Enable HDMI0 PHY clk provider on RK3588
      arm64: dts: rockchip: Add HDMI0 PHY PLL clock source to VOP2 on RK3588

 .../bindings/display/rockchip/rockchip-vop2.yaml   |  4 +++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  7 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 36 +++++++++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)
---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241116-vop2-hdmi0-disp-modes-b39e3619768f


