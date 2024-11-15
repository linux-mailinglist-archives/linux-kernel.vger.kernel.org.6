Return-Path: <linux-kernel+bounces-410992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF79CF164
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D1D2940F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F461D5173;
	Fri, 15 Nov 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hmd/+CVz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6415A848;
	Fri, 15 Nov 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687695; cv=none; b=n9i4bDTmtYV0FhGH7+ca5xGyKeSGiuAGVSiGG6pLyl0b4WdyLZmwTUNbR0ckuGy9zuybusfwcdgED3gD38HhQgGVIbELM7hE5SR4UeFwNXV6mxNEA9gYFFb1h0Aw49lrNgfHhZLC9S29o9NkuU32AAp8JNFJH4Y5SVEOAbLXQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687695; c=relaxed/simple;
	bh=qQtgDiPyFIYE/RVlLSKOi/67cZnKV6qJu6S3Iy9AxRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWTn4htPM8+4+3D4myVsiBQ5Q95MlmFA8WCSNbvVeEkL6SXmTrQtrbrMeHpvb0sLuOfuo5Y9X4PIAnYcYiOIGTEqL2LJcd0YoyXg+lrmyXrW4MtuRi8IynZMcKPDBy1LM+TefIJz0+YaGhMwVWiwomE6UemAhNm8uzyyeDv/b/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hmd/+CVz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731687686;
	bh=qQtgDiPyFIYE/RVlLSKOi/67cZnKV6qJu6S3Iy9AxRU=;
	h=From:To:Cc:Subject:Date:From;
	b=hmd/+CVz/rsdlgI3i5EJhKz6xS8+rmVUawAX/d+cBv21FSGnEezB/GgAunwIR1Kgo
	 NKAIejQI+NRC8B0rWdJy3P+JPO0lMR2qw29lyUGn9LsOf4k4UoffIBVafjUXaOgzSP
	 LTlaCA6l/YoDM82smQC6kquhakhPnzSz6EtbEdlACBQFJFpQGvgGhIl37Nt8DD4VkW
	 CnOq7TJI9YpBqDgphKaHKXuGnmAuPFaAj+8NwmnlFySfj7M+lHRyAr8KYQfWvPiRWm
	 3zNHu7wS/oAVW0uxa/Ap+rkCqkYjskKVIBYdptcGtr0KrHwgriECX4X0ETwu+Am8oG
	 rZFZQpBBXLkrw==
Received: from bootstrap.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF98317E36CB;
	Fri, 15 Nov 2024 17:21:23 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 0/3] drm: rockchip: vop2: Add VP clock resets support
Date: Fri, 15 Nov 2024 11:20:39 -0500
Message-ID: <20241115162120.83990-1-detlev.casanova@collabora.com>
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

Changes since v3:
- Rebased on drm-misc-next
- Reword first patch subject
- Reorder commits for different trees

Changes since v2:
- Rebase on latest master
- Add details on how to reproduce the issue

Changes since v1:
- Add AXI and AHB clock resets
- Set maxItems for !rk3588 in vop2 bindings

Detlev Casanova (3):
  dt-bindings: display: vop2: Add VP clock resets
  drm/rockchip: vop2: Add clock resets support
  arm64: dts: rockchip: Add VOP clock resets for rk3588s

 .../display/rockchip/rockchip-vop2.yaml       | 40 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 12 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 30 ++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.47.0


