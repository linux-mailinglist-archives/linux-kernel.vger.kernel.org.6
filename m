Return-Path: <linux-kernel+bounces-215940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647FA90991C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2047F1C20A81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03949653;
	Sat, 15 Jun 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZfBioXxC"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A94F207
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471104; cv=none; b=ur/CWi8lPht9DqjCMMUH+KA89/aKhHcTuaHxt/o3Xwa+m16zihK9IPXZAQOwiUvPBVv5YkR5c+KMaTQJSEDmTi0YcPKFERJ7bshVlR7j7xjVCOrOe1FRa7bQQ8E4fYhFqVVaUbff0S3zoI5WFOFpz+8XREXEy/lQ1uBXMRxuBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471104; c=relaxed/simple;
	bh=BrAyv3tTQ7BWoPKoLKD4BTSjujDCwwYQ30XEWLgPbOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9Cd8KPcGf7O1PCNMIvrwiq3XC7KSbV3NtM+fpdugQKMewDoyQ2fQh1TqTgRmVcs4ibBQnSsVSavN0dS1Rb/RH+6amB+Q0HRVTlv3f238LeXUAaFuN144e1Gc+pFd2edcMlHwbGvwrIFIgHh2GxCGGiwcQQByqLFDY1+atlcEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ZfBioXxC; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471088; bh=ScLXL7bFS6O80CUAw7XPEvNboE3+OLzOZeGQt7f1YM8=;
 b=ZfBioXxC9wdsuv/hmnLGAyHS8SG5v8V3O90I14kxOVFdM9JNS3sWhXnQa69lmTpsh7uxLE06Y
 pUDefr+5stvFp0SzZOTVnmsF+exPTBti6EZkPTT1BGZk8/rRCBOTatX+vqcGsu2g8Zdlape3DBs
 YVVTNxUgJMyKJw2XvyQnybRE/NgQ1IXUeZj6+q49OuqugdPvDrCmmZKsWzxnm7ogB41EFF+imIk
 xkFOjfgLDSrDwJWRpcQg46DxkMBHfIqjd9mFVWuNJcSFZRKQIg4aT1bxbUUwONkUcvzrYh9YtiB
 0UqnVpCnxmtZ9owhF2Y6oSEei5zC1kUDe50iziSHUV2Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, Zheng Yang
 <zhengyang@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/13] drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
Date: Sat, 15 Jun 2024 17:03:55 +0000
Message-ID: <20240615170417.3134517-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc9aa24e0254b3980401b

EDID cannot be read on RK3328 until after read_hpd has been called and
correct io voltage has been configured based on connection status.

When a forced mode is used, e.g. video=1920x1080@60e, the connector
detect ops, that in turn normally calls the read_hpd, never gets called.

This result in reading EDID to fail in connector get_modes ops.

Call dw_hdmi_rk3328_read_hpd at end of dw_hdmi_rk3328_setup_hpd to
correct io voltage and allow reading EDID after setup_hpd.

Fixes: 1c53ba8f22a1 ("drm/rockchip: dw_hdmi: add dw-hdmi support for the rk3328")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index fe33092abbe7..aae48e906af1 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -434,6 +434,8 @@ static void dw_hdmi_rk3328_setup_hpd(struct dw_hdmi *dw_hdmi, void *data)
 		HIWORD_UPDATE(RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK,
 			      RK3328_HDMI_SDAIN_MSK | RK3328_HDMI_SCLIN_MSK |
 			      RK3328_HDMI_HPD_IOE));
+
+	dw_hdmi_rk3328_read_hpd(dw_hdmi, data);
 }
 
 static const struct dw_hdmi_phy_ops rk3228_hdmi_phy_ops = {
-- 
2.45.2


