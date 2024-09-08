Return-Path: <linux-kernel+bounces-320221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AD9707C3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1251C213D2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E58169AD0;
	Sun,  8 Sep 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="QbzNxNnw"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCA168C26
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802135; cv=none; b=mTTy9xg4+hrA7vOjYoeM2GrD7nNprTxsYdnncw8SNAL2txMtjfClvr+vSxtu/H270qjYoxh/wVQNVcM+Gxkq0bkYUQWeiiQsLdEfxus98QLXL1H0VzOmCI1enEsrfl6CyFjrckUTmHq3WpDbMADT/QiynAq+4XrxSLFi8S3CWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802135; c=relaxed/simple;
	bh=mcdmqRHDK0CCRxh9fA0BKSIVZhjMOYoKHUATixf26XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHpL70Me94o8qziyB6JDF6dfxfXcD6ucl6j+Dp1RHDE0iZUO+U0kp6Fxts6p+v8iwd72o+JV+G560CEkHgHC1wWV8iAgFxEmkHQRDxcAFkp8Wu4JlR+TiTgQ2FDpflqbsYFjWzvx8efLaY+0yBrw65/jINQyZhGWQMWTy7pqvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=QbzNxNnw; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1725802110;
 bh=GBZtSa7NV3xr9PArtmtkDJNem8kQ3e2llQ47ktafnlQ=;
 b=QbzNxNnwSbAb4TQ0yFDTzC/y6DCt00xusYXBD0R775cQFANiwsAxdsWUidwdgFnVI/q9VQAHb
 ecYAQkXR8UTg+RAoSPT39McuBqkm2XuMiEI6O8WMWJH7WT6VuTsSIMbVGeUKjPoqBWmxcRi5ZgP
 og27kIcMHxUjoxSfvSDRTfuBm6sY8wb+ttpc95L4LkPekY9rRqPb29dw6vIqMiBMFW2GGtoZoNt
 GS7xC0b94GAvEcaHrB65JqOK1rl0snStDeHcUwnY1/KHZAGUfJPToHdc6lSrEDQF0sdBm86uMk0
 uD315y37RqcRausvaNHsn+kHR2g2ipfTSt6MTiCsxOqg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Christian Hewitt <christianshewitt@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 00/10] drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup
Date: Sun,  8 Sep 2024 13:28:02 +0000
Message-ID: <20240908132823.3308029-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66dda67e3c9877b4595878e3

This series ensure poweron/poweroff and CEC phys addr invalidation is
happening under drm mode_config mutex lock, and also ensure EDID is
updated (when the dw-hdmi connector is used) after a hotplug pulse.

These changes has mainly been tested on Rockchip devices together with a
series [1] that add HDMI 2.0 4K@60Hz support to RK3228, RK3328, RK3399
and RK3568.

Rockchip use the dw-hdmi connector so this should also be validated with
a driver that use the bridge connector.

Changes in v2:
- Add patch to disable scrambler feature when not supported
- Add patch to only notify connected status on HPD interrupt
- Update commit messages
- Collect r-b tags
- Rebased on next-20240906

[1] https://lore.kernel.org/r/20240615170417.3134517-1-jonas@kwiboo.se/

Jonas Karlman (10):
  drm: bridge: dw_hdmi: Disable scrambler feature when not supported
  drm: bridge: dw_hdmi: Only notify connected status on HPD interrupt
  drm: bridge: dw_hdmi: Call poweron/poweroff from atomic enable/disable
  drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
  drm: bridge: dw_hdmi: Fold poweron and setup functions
  drm: bridge: dw_hdmi: Remove previous_mode and mode_set
  drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
  drm: bridge: dw_hdmi: Remove cec_notifier_mutex
  drm: bridge: dw_hdmi: Update EDID during hotplug processing
  drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 150 +++++++---------------
 1 file changed, 43 insertions(+), 107 deletions(-)

-- 
2.46.0


