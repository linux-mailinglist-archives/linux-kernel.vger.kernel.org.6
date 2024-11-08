Return-Path: <linux-kernel+bounces-402220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F49C2522
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904361C20355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAA1A9B5E;
	Fri,  8 Nov 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e9yPG+j+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DE233D96;
	Fri,  8 Nov 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091951; cv=none; b=EyWzOlAORXEJ20xWrcWpQl1VA9TtlOpjg9dmYe8+sU8x/MFNjPcDazenIskzwnAKJvgkS7mKyptq9iGvRC56+5XF7QOk6GMGUYBy/9/Aa+V1SJJj6CKAOX1jI0bueZxnyO4NnlTGA2kSsFws0budBbnKtyE+0MlG2Pf84FtuAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091951; c=relaxed/simple;
	bh=L9PZiEX333+Du0NXmYmoMzUp2gsXJVu8bc+StkfIx1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m45TDsD0xP6i1McrX/ZyBYeW/nbhYHYEror1lIY/CXwnPdGVAVBoR6jmoB9beTrusEE9ZkAa3eiNIXEFuqH4DLjcfAnLGwedLau4uypa/i/Zoum4eLBHG48Y+xxSVi3RRpDv4NtFxNW6Bjnrvk9CbvKq5JY/vIAOz2UM5BnxCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e9yPG+j+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731091947;
	bh=L9PZiEX333+Du0NXmYmoMzUp2gsXJVu8bc+StkfIx1E=;
	h=From:To:Cc:Subject:Date:From;
	b=e9yPG+j+tbA5rv4eGyOBc65gC2rIW8aGsxtTc9tEA/EDmnlJSTPeqedHOMGE/qtvE
	 VFV5mJ3KU5wl1hez1BGe7Z24yN3t9gAIp2IE5zR9Du9rC4eTHovO2caopGpD6s2nFS
	 voNFKk8l0a0umITXRWRn23jlyl7M+GjNcWDXRmYujFQBAuwYqDg7qvHVXomWG0vksF
	 C+WDDA6e6t2wbaib40Xv+vqgT67Xhezt684ituQIMFvxRnMKb/tJhwM2Lc761Ba3L2
	 YNugjQnn/5mlBwa58HLzbkYbQz47qwflIebsA1Vt5VlNvfQ4V+tueJEuJ47GHV7V17
	 U3wtA5O+Ms4uw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8903117E376A;
	Fri,  8 Nov 2024 19:52:24 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko Stubner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/3] drm: rockchip: vop2: Add VP clock resets support
Date: Fri,  8 Nov 2024 13:50:38 -0500
Message-ID: <20241108185212.198603-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock reset must be used when the VOP is configured. Skipping it can
put the VOP in an unknown state where the HDMI signal is either lost or
not matching the selected mode.

This adds support for rk3588(s) based SoCs.

Changes since v2:
- Rebase on latest master
- Add details on how to reproduce the issue

Changes since v1:
- Add AXI and AHB clock resets
- Set maxItems for !rk3588 in vop2 bindings

Detlev Casanova (3):
  vop2: Add clock resets support
  arm64: dts: rockchip: Add VOP clock resets for rk3588s
  dt-bindings: display: vop2: Add VP clock resets

 .../display/rockchip/rockchip-vop2.yaml       | 40 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 12 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 30 ++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.47.0


