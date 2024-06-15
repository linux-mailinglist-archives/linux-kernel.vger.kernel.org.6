Return-Path: <linux-kernel+bounces-215956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E5909935
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EB3282135
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41E49658;
	Sat, 15 Jun 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="z3ghITGU"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C441E534
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471690; cv=none; b=nO9FkCrIZ3H31HwTZ2feIyp4evBlRu3Mi8xOzB0E6/kv2IYNCSJOVEXAcFFeSSytcilIeO/oicbVKsibavZ7GfaHNyZT8iNXuBS2gYfseOzNkUmUMixY6VbK/ZStyge+ckVua7HWOrRy4tYsiipT54J3FWo0pL4fZ8ah7Sfg6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471690; c=relaxed/simple;
	bh=YleysvIi0rPPXSXKtSglrM3w+jNb+eQuMHM9OaelI1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7TwfopAYfDsGaF1GuWL4DoI6IdmvDx0rsMmn2skui8CkS912yd7WahSXWs0aAb9gs+dunaEUoRSKqctxH4mpgL+s+FRdJst/2AhUdQ+c6jotZuHq+dg9T33ge7baVeBLifFj6vRJG9hEtg2obL94Y6W7avk2P09JAG+6d8XmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=z3ghITGU; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1718471683;
 bh=dLn2LLOIv7jBQg/04IBwQjzhef+lWuqMlW02SALqD2s=;
 b=z3ghITGUjKvYMox/h/1fTuc8dR8E07q21xq7oObMgp3XN1LJof2l2u1KaPS2LThjh2HA8dpu6
 sSPDAJTa1wkLpzyqbo2drwuw4I9sIhM9Qi0ICC9lTQawTwMMiMKXt+pL253tJpFEmMM1nPu4eE5
 arMU6HIrftF6NOygwu+fwgZr5bIaCgpOEdhfc7BnCIio5PFpEZSU11h9LLhwUCAwsavMPdTpw9l
 1eAYzCD/hhEdlqLVRRJPB49QcEaxR3oJ7DGUedqzFuHmVJ/MMyUUsvIdIv4WZIFPJr5yn9QL1ir
 KaPQKk2i878OixYuLUO/obAgPetMLNXTKf5CvQ7j/Cng==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/13] rockchip: Enable 4K@60Hz mode on RK3228, RK3328, RK3399 and RK356x
Date: Sat, 15 Jun 2024 17:03:51 +0000
Message-ID: <20240615170417.3134517-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc99724e0254b39803fcf

This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
RK3328, RK3399 and RK356x.

Patch 1-3 fixes some issues to help support use of high-resolution modes.

Patch 4 fixes reading of EDID on RK3328 when using a forced mode.

Patch 5-7 adds hdmiphy rate validation in mode_valid so that HDMI2.0
modes can be enabled on RK3228 and RK3328.

Patch 8-11 modify phy, current and mpll tables to match what ChromeOS
and vendor kernel use. These patches originate from old ChromeOS and
vendor kernels and have successfully been used in LibreELEC distro for
the past few years.

Patch 12 enables use of HDMI2.0 modes on RK3399 and RK356x.

Patch 13 help fix use of console at 4K resolution on RK3399.

This series may not fully depend on but was only tested together with
the series "drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID
cleanup" at [1].

I have tested 4K modes on following devices:
- Asus TinkerBoard (RK3288)
- Pine64 Rock64 (RK3328)
- Radxa ROCK Pi 4 (RK3399)
- Radxa ROCK 3A (RK3568)

A copy of this series can also be found at [2].

[1] https://patchwork.freedesktop.org/series/134727/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20240531-rk-dw-hdmi-v1/

Alex Bee (1):
  drm/rockchip: vop: Allow 4096px width scaling

Douglas Anderson (2):
  drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
  drm/rockchip: dw_hdmi: Use auto-generated tables

Jonas Karlman (8):
  arm64: dts: rockchip: Increase VOP clk rate on RK3328
  clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228
  drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
  drm/rockchip: dw_hdmi: Allow High TMDS Bit Rates
  drm/rockchip: dw_hdmi: Add max_tmds_clock validation
  drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk
  drm/rockchip: dw_hdmi: Enable 4K@60Hz mode on RK3399 and RK356x
  drm/rockchip: Load crtc devices in preferred order

Nickey Yang (1):
  drm/rockchip: dw_hdmi: Add phy_config for 594Mhz pixel clock

Yakir Yang (1):
  drm/rockchip: dw_hdmi: Adjust cklvl & txlvl for RF/EMI

 arch/arm64/boot/dts/rockchip/rk3328.dtsi    |   4 +-
 drivers/clk/rockchip/clk-rk3228.c           |   2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 173 ++++++++++----------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  23 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   4 +-
 5 files changed, 116 insertions(+), 90 deletions(-)

-- 
2.45.2


