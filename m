Return-Path: <linux-kernel+bounces-320272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E497083C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D43E1F2166D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2487170A31;
	Sun,  8 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wnDWPrL7"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6814D2B1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807340; cv=none; b=CC9AHzDvrGdzylg/ZvsUzAI3vHe8Vk3cjAq3MRmPWcb49gKTvx9XqWcyJHw+HALku/Yiz2m6MrzSf3NZPwl56wtaBlz7lKbXvEfKq2iV5h65N/FF1/cgYnLr3XkUejz8QcjAeI7m6RgByjHIixp3jxWfSxhpRPB16JL3NHFTdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807340; c=relaxed/simple;
	bh=Wz9jGRejHwRXvKuaCHkpLehwxuA1r6jQWjWJFZMHJkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHdGiMv817AZ9zZAYj0rwjolH2aLFeeXanqet218Q4QRjKDrFX8PfnK4gV0hXwZRLhg04u1nu1iA7537tN5yLL0vbd7BwtIV78b2X+aE10H8fjvvX12v9g6SdGtqJEE6NPdG2247HzqGfd9cbAr40W5pt9OK3yT5wtMoyeObTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wnDWPrL7; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1725807321;
 bh=p1MiGiCWJ1QFiMZG2+xqAuAwYxvAC3COp5/R/uwoMcw=;
 b=wnDWPrL7E5Q/8MDmUWbNIyghdyE1LnEmv5XRZxc6SWSfkiDhcVwXUv6+FIHKDCmzmV+EyVkxN
 Nn4HM+c24M3TddN6yZrXrhqUkpc420aNNvqpp4s8ogJLCW/50hX+Bpnfkrel0jwkOIO95oEwPAp
 PXSL/6vwKP9NKyIxGsLVb8vPbEBd/4B7Sr3CTU26DXvZ+LphL/aDdCC0T9R0UgSk4Hc/Oev/yGD
 DLUj5suRD6bnOVeLVvJtobPGZVXdcfLI65W3V6l/i5gqXgdM4PTJExz6JYnK7GxAejnzdW4Omfy
 G+oB6NYd5lo8NMG9p1oleZIwafkWa+lSIMwNTVHkjNrw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/7] rockchip: Enable 4K60Hz mode on RK3228, RK3328, RK3399 and RK356x
Date: Sun,  8 Sep 2024 14:54:57 +0000
Message-ID: <20240908145511.3331451-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ddbad73c9877b459588e68

This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
RK3328, RK3399 and RK356x. Support for 10-bit and/or YUV output modes is
not part of this series.

Patch 1 add hdmiphy rate validation in mode_valid so that HDMI2.0 modes
can be enabled on RK3228 and RK3328.

Patch 2-5 modify phy, current and mpll tables to match what ChromeOS and
vendor kernel use. These patches originate from old ChromeOS and vendor
kernels and have successfully been used in LibreELEC distro for the past
few years.

Patch 6 enables use of HDMI2.0 modes on RK3399 and RK356x.

Patch 7 help fix use of console at 4K resolution on RK3399.

This series may not fully depend on but was tested together with v2 of
the series "drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID
cleanup" at [1].

Changes in v2:
- Drop patches already merged
- Collect t-b tags
- Rebase on next-20240906
- Hotplug HDMI 2.0 to HDMI 1.4 scrambler issue was fixed in v2 of [1].

I have tested 4K modes on following devices:
- Asus TinkerBoard (RK3288)
- Pine64 Rock64 (RK3328)
- Radxa ROCK Pi 4 (RK3399)
- Radxa ROCK 3A (RK3568)

A copy of this series can also be found at [2].

[1] https://patchwork.freedesktop.org/series/134727/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20240906-rk-dw-hdmi-v2/

Douglas Anderson (2):
  drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
  drm/rockchip: dw_hdmi: Use auto-generated tables

Jonas Karlman (3):
  drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk
  drm/rockchip: dw_hdmi: Enable 4K@60Hz mode on RK3399 and RK356x
  drm/rockchip: Load crtc devices in preferred order

Nickey Yang (1):
  drm/rockchip: dw_hdmi: Add phy_config for 594Mhz pixel clock

Yakir Yang (1):
  drm/rockchip: dw_hdmi: Adjust cklvl & txlvl for RF/EMI

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 162 +++++++++-----------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  23 +++
 2 files changed, 98 insertions(+), 87 deletions(-)

-- 
2.46.0


