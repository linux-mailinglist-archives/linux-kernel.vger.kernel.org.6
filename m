Return-Path: <linux-kernel+bounces-176604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A98C3220
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8961F21879
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E25647B;
	Sat, 11 May 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NUHlM+Le"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B61E526
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441488; cv=none; b=T51Bk42qaBWi8XdGH3rnaoqWFGEd3FP3LEZX5w8DutqsOXVUkb4gwkbr6ziGl75b1NGbgpfmqve7rBSRyqPsvBsMxlkq3k7EdEFBwv4ybOV6sTPdAb4U6qx5CvZifo9bM4380AiiVXEQR0V8ara2W5yHDieH5RzW7y9gybs6j1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441488; c=relaxed/simple;
	bh=5bPKUIefG+SidF/ytOOZmWgXAJbR8a44r8C9bst2cXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D1rknC2D9jTkhWVv5EPWk8A8c2RHX7Cm1d09D+zPtnR9kENNL9E1FjNoT4yQJVKF4MQck+PpDWNuCMUFDanWAZqYCRgdkhWzFIQz8qRpe5/5jex6a6mrWvhPy0Vlw81YAbbJhbxRD27SVyRE8i/O2rG19WT6wmeMRkYMU5S62xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NUHlM+Le; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUrIa024638;
	Sat, 11 May 2024 10:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715441453;
	bh=fgSiUiyv+xpJe+wBVVFMUseyZYSFfR7/ITsPxN9R9DI=;
	h=From:To:CC:Subject:Date;
	b=NUHlM+LeTfbGoqpC5jccAxMyGXILJhzrA4BCxQYnkpw8eiTw+0itb/gfyg3E7SrFa
	 QNCMm7qGfd/JhF6KGO3zYZPHms+Y2LTnNO62uxQRa/c/+GwEY70vgSiTL7hjfVNVBm
	 lmwZttqUSx6S0hg6iZfRUjOYcen2tT/LunIZcprU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44BFUrcp017845
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 May 2024 10:30:53 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 May 2024 10:30:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 May 2024 10:30:52 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUqUO074704;
	Sat, 11 May 2024 10:30:52 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Jyri
 Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Boris Brezillon
	<boris.brezillon@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH 0/7] drm/bridge: cdns-dsi: Fix the color-shift issue
Date: Sat, 11 May 2024 21:00:44 +0530
Message-ID: <20240511153051.1355825-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

This series provides some crucial fixes and improvements for the Cadence's DSI
TX (cdns-dsi) controller found commonly in Texas Instruments' J7 family of SoCs
as well as in AM62P.

The cdns-dsi bridge consumes the crtc_* timing parameters for programming the
timing parameters. A patch has been added in tidss to make sure the crtc_*
timings get populated.

It further adds support for "early_enable" and "late_disable" DRM bridge hooks.
These hooks are same as the existing "(pre_)enable" and "(post_)disable" hooks,
except that the early_enable hook gets called before the CRTC is even enabled in
the display pipeline and the late_disable hook gets called after the CRTC is
disabled.
The cdns-dsi controller requires to be enabled before the previous entity
enables its stream[0]. It's a strict requirement which, if not followed, causes
the colors to "shift" on the display. Since the previous entity is TIDSS in this
case, which gets enabled via the tidss_crtc hooks, early_enable/late_disable API
in the cdns-dsi bridge is the way to solve the issue.
The early_enable/late_disable APIs also help with the OLDI TXes available on the
AM62/AM62P SoCs, which will be a part of separate series.

This spec also requires the Clock and Data Lanes be ready before the DSI TX
enables its stream[0]. A patch has been added to make the code wait for that to
happen. Going ahead with further DSI (and DSS configuration), while the lanes
are not ready, has been found as another reason for shift in colors.

All these patches have been tested on TI's vendor tree kernel with more devices,
but for the mainline, these patches have been tested with J721E based
BeagleboneAI64 along with a RaspberryPi 7" DSI panel. The extra patches can be
found in the "next_dsi_finals-v1-test_rpi" branch of my github fork[1] for
anyone who would like to test them.

Thanks,
Aradhya


[0]: Section 12.6.5.7.3: Start-up Procesure [For DSI TX controller]
     in TDA4VM Technical Reference Manual https://www.ti.com/lit/zip/spruil1

[1]: https://github.com/aradhya07/linux-ab/tree/next_dsi_finals-v1-test_rpi


Aradhya Bhatia (7):
  drm/tidss: Add CRTC mode_fixup
  drm/bridge: cdns-dsi: Fix minor bugs
  drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready
  drm/bridge: cdns-dsi: Reset the DCS write FIFO
  drm/bridge: cdns-dsi: Support atomic bridge APIs
  drm/bridge: Introduce early_enable and late disable
  drm/bridge: cdns-dsi: Implement early_enable and late_disable

 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 91 ++++++++++++++-----
 drivers/gpu/drm/drm_atomic_helper.c           | 67 ++++++++++++++
 drivers/gpu/drm/drm_bridge.c                  | 84 +++++++++++++++++
 drivers/gpu/drm/tidss/tidss_crtc.c            | 11 +++
 include/drm/drm_bridge.h                      | 73 +++++++++++++++
 5 files changed, 303 insertions(+), 23 deletions(-)


base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
-- 
2.34.1

