Return-Path: <linux-kernel+bounces-210195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370149040A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8457285DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C339FD0;
	Tue, 11 Jun 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lw8jFDwg"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E017573
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121686; cv=none; b=cXIfKtdveKfgNp68FhJcjsboI5RfvD/dzM9TIlxkpidaf1HYOF9n/xi4M/AJiWHYbKzL9V0YGeQjzuw1dm6MbKTISytiNkNHTJHD5vKMNULHq9/X2iH5S5LomdBXZE8Eou69+DAu2QXkl5PzJWdDqC1BXJj2C46RzmXaiMTvJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121686; c=relaxed/simple;
	bh=7pfp+sizd1qY3YGfw+h97mXb47b114LQiCfVfiIjPEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uK4+HLs2U7Se5hPmq8R6loDFHDmMH+d1Qr/C9sxvbr8use/V9hF3tqypHCNZWkohMKRHpOglK8ONSYmpFSlljuz8X5NEmM1TRER4yVFVYMcBeWa3tVYt310EDzkg8AOj8daAIOIxGs4LtidmyYrtsPo9a9JkwiJ4qszafV2IJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Lw8jFDwg; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1718121682;
 bh=I7oWEAwMzJYg1QixLY8LSRS5H8hWf0Fter8AOhPGR/A=;
 b=Lw8jFDwg6qDCtV07qf8YqddnAPL/h7HQp/ZTs1DParTTyZcs7fWnrqVukbyo81BRKO7jPp9LW
 4HpV0KyrIfy/qLGEIBLgWs8IPIs+R7SyG8Dd8JIdnUjMNzO97VsEljOIoQuIHelvA7ACzxaY/fA
 AF9/g+Z+HzYQtYt8+kXPSTIfPvzpYlZBkz898Uh35/AlZgOM1NMr7w1NbqMeaqTWpK8IlbU4XVn
 x20nI9ACQSundsIq/mGLJncdSY77A/er7xbiBfkjRzc62f10r1XNKeCtclTBicAmUdS6sg6pwZY
 FO4WPpb250iViboPKFmwmbsfsqnVwmDM6FkFrj7E1vOw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup
Date: Tue, 11 Jun 2024 15:50:52 +0000
Message-ID: <20240611155108.1436502-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
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
X-ForwardEmail-ID: 66687273b913b04293b6dc1e

This series ensure poweron/poweroff and CEC phys addr invalidation is
happening under drm mode_config mutex lock, and also ensure EDID is
updated (when the dw-hdmi connector is used) after a hotplug pulse.

These changes has mainly been tested on Rockchip devices together with a
forthcoming series that add HDMI 2.0 4K@60Hz support to RK3228, RK3328,
RK3399 and RK3568.

Rockchip use the dw-hdmi connector so this should also be validated with
a driver that use the bridge connector.

Jonas Karlman (8):
  drm: bridge: dw_hdmi: Call poweron/poweroff from atomic enable/disable
  drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
  drm: bridge: dw_hdmi: Fold poweron and setup functions
  drm: bridge: dw_hdmi: Remove previous_mode and mode_set
  drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
  drm: bridge: dw_hdmi: Remove cec_notifier_mutex
  drm: bridge: dw_hdmi: Update EDID during hotplug processing
  drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 145 ++++++----------------
 1 file changed, 39 insertions(+), 106 deletions(-)

-- 
2.45.2


