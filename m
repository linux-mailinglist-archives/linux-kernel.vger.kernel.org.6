Return-Path: <linux-kernel+bounces-518391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223CDA38E63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47143B0873
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B11A5BAD;
	Mon, 17 Feb 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ItSMsNHL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF7224F0;
	Mon, 17 Feb 2025 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739829415; cv=none; b=LpeMQdcBwBDa3DsbXhiwqGGOB6r3rkhyySC6zzArSGXzox6qlWHjQEdRrou6U2elvl4gr2Sd7cL8cWorfg+MONDrfCGg226hALnRz3X4jiT1d/EUcElH2fya30jMIIX0yD7J+grJOtLp6tgnKG6DXfXOXFPXq9GcE7dIDYi0PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739829415; c=relaxed/simple;
	bh=4VaQl0NtT63hn4RIkgnKAbuhy0jcZQTdg7q6kxOv9w4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsTBvjtqq/hapONLV4F+daZbNDt7TZ6gMIFBALoxT+JON8NnTNc/Gwt33Vjq5KTxvC9+MuGb9lEOsSa65zIWeG5g9BEHh6GbwtFD9PDweiQhUf89wenJlml6H5o6WKt6aHokqghRUjeCBPcOby9vdJ5HtdyObvUBXAcJmGLLOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ItSMsNHL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739829411;
	bh=4VaQl0NtT63hn4RIkgnKAbuhy0jcZQTdg7q6kxOv9w4=;
	h=From:To:Cc:Subject:Date:From;
	b=ItSMsNHLFu60POXzGfILeItDV8X97590ll35srQbAmVX16kSPDUODZdf6YAxnsN1M
	 KejkAQ6qv6fiX45IYVEGfQ+9XZP9r2U9WJimqPIeBCFZatdHkmwThy+bAgBvfOabPs
	 UhoA6D8C6zcWU/x7BJa9B5QulVfrJ2ZIEhPjn/RJKyve4M7+8SFLm66heJQ/+tL/dg
	 hgZIu110oCwxgZVRc3zHP822L/mW8SEmgVlh/bQMt7LuHIKs/ZPKY+3ow+o4lmLlEf
	 LWfdqrhgvrupjCMvruyKtLbk1dffm3Gbz1SwI52UlDhj8awzUQqHwAEjRiiWH9yc+c
	 doe5tyoH0nteg==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CEAE17E02BE;
	Mon, 17 Feb 2025 22:56:44 +0100 (CET)
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
Subject: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
Date: Mon, 17 Feb 2025 16:47:39 -0500
Message-ID: <20250217215641.372723-1-detlev.casanova@collabora.com>
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

This adds HDMI audio support for both HDMI TX ports.

*** Dependencies ***

Based on Linus' master branch, but also needs Cristian's dts patches for HDMI1
support [2], which depends on Heiko's patchset for
phy-rockchip-samsung-hdptx [3]. Patches will apply without [3], but HDMI will
not work (at all).

[1]: https://lore.kernel.org/all/20241224-drm-bridge-hdmi-connector-v10-0-dc89577cd438@linaro.org
[2]: https://lore.kernel.org/linux-rockchip/20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com
[3]: https://lore.kernel.org/lkml/20241206103401.1780416-3-heiko@sntech.de/

Changes since v6:
 - Fix arguments alignement (checkpatch --strict warnings)
 - Add hdmi1 audio support too
 - Move hdmi0_sound node under hdmi0_out_con

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
  arm64: dts: rockchip: Add HDMI audio outputs for rk3588 SoC
  arm64: dts: rockchip: Enable HDMI audio outputs for Rock 5B

Sugar Zhang (1):
  drm/bridge: synopsys: Add audio support for dw-hdmi-qp

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  17 +
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |  17 +
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |  16 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c  | 489 ++++++++++++++++++
 4 files changed, 539 insertions(+)

-- 
2.48.1


