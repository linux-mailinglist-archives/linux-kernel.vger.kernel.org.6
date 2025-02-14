Return-Path: <linux-kernel+bounces-515343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95293A3637E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB2170C76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF848267AFD;
	Fri, 14 Feb 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pNEiFYbR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29177267703;
	Fri, 14 Feb 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551627; cv=none; b=QFSeNVRKED95jjiaep/v7IGPEnwElJG2LS0tdcbktla+EfDgz3UApGcAP0DyoieF5bUMiOC/n9aN5eDJwYNL7gBvEI0rA2+1RUSBww/CzT0HXpBqI1dr3OVGBQICMzEB4yRfpiwPMXet5DVcqFksygxH/3DpXJ14zOmCI3IMJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551627; c=relaxed/simple;
	bh=e93WMTX324UPBYpzF8zp+DIsYjQOE6P2V+HVCGC9Dvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VE0qZA7f4/h0HJO2IUS/XGukyfkqkbzrFbcKB99HGz/ks6ZIvBk0oA5u+qWWgD1mUTQOO8tnOaFCwdtcxzj28O8EpyQBOPtSpk696UE6Vw5MOJ0buRwyLd/MNOBmx7qMpPuQUc7pnYDKSWlSiwB8SdwbymIpfeQITxLwqr8mUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pNEiFYbR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739551623;
	bh=e93WMTX324UPBYpzF8zp+DIsYjQOE6P2V+HVCGC9Dvk=;
	h=From:To:Cc:Subject:Date:From;
	b=pNEiFYbR4xbtlhNmC3ZBXWgXW4ymzif8S2mhPyUzPkZGMGLqqP0wkp7wa2ZdisR3X
	 T+PAVkg9aBZOZOJzZEdNCBgP2YpWB9gpgalb5DfMFzSCco1GDgLO3vlCbyvf8t+uXD
	 TOMpZlbTmEMGAmHpmPuJQ24QgluhyLtEC6ISv8YCSNzv7N6CE5fQwwop337htcUnrk
	 piAFL37JB2tkvqWmIHiMVZcBnwqByf0niUJ55c/6crcqBbi4d6Bma0+NP+oyrPbVXf
	 hYBd8jBXTpPHc80UMPeeu4NP/ViYix9VcNGpR8KZYZCFlYQtUoOjewbHR3NVHhX2Z1
	 YKtaFJu4jSeuQ==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 901DD17E0FDF;
	Fri, 14 Feb 2025 17:46:59 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Niklas Cassel <cassel@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Algea Cao <algea.cao@rock-chips.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	kernel@collabora.com
Subject: [PATCH RESEND v6 0/3] Add HDMI audio on the rk3588 SoC
Date: Fri, 14 Feb 2025 11:43:59 -0500
Message-ID: <20250214164528.534278-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support HDMI audio on the rk3588 based devices, the generic HDMI
Codec framework is used in the dw-hdmi-qp DRM bridge driver.

The implementation is mainly based on the downstream driver, ported to the
generic HDMI Codec framework [1] recently merged in the master branch.
The parameters computation has been kept as is and the data stored in the
dw_hdmi_qp struct as been cleaned up.

The table for the N values has been edited to reflect N recommended values
as well as CTS recommended values.

The downstream kernel also implements a machine driver for HDMI audio but
it is doing exactly what the simple-audio-card driver does, so use that
instead in the RK3588 SoC device tree.

Based on Linus' master branch.

RESEND because of a network connectivity loss at the wrong time.

[1]: https://lore.kernel.org/all/20241224-drm-bridge-hdmi-connector-v10-0-dc89577cd438@linaro.org/

Changes since v5:
 - Simplify audio math computation for N
 - Move hdmi0-sound node up with other address-less nodes

Changes since v4:
 - Moved hdmi0_audio node the rk3588-base.dtsi
 - Enable hdmi0_audio in rk3588-rock-5b.dts

Changes since v3:
 - Renamed function to start with dw_hdmi_qp

Changes since v2:
 - Also clear the audio infoframe
 - Write AUDI_CONTENTS0 to its default value in case it gets overwritten.
 - Store tmds_char_rate in the dw_hdmi_qp struct in atomic_enable
 - Clear tmds_char_rate in atomic_disable and only write registers when
   tmds_char_rate is not 0.
 - Do not use connector_state duplicates

Changes since v1:
 - Remove useless audio_mutex (was used downstream for multiple drivers access
   to audio functions)
 - Let hdmi_codec build and setup audio infoframes
 - Only access audio registers when connector is connected
 - Rebased on master branch

Detlev Casanova (2):
  arm64: dts: rockchip: Add HDMI0 audio output for rk3588 SoC
  arm64: dts: rockchip: Enable HDMI0 audio output for Rock 5B

Sugar Zhang (1):
  drm/bridge: synopsys: Add audio support for dw-hdmi-qp

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  17 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   8 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c  | 489 ++++++++++++++++++
 3 files changed, 514 insertions(+)

-- 
2.48.1


