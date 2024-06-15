Return-Path: <linux-kernel+bounces-215942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EEA90991E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB02A1C20ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0C5916B;
	Sat, 15 Jun 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FWXFcMP4"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38C4D108
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471110; cv=none; b=MMN7PHiIpxJ8LQ6fyjbVWWFlNMoAqU+xZVaYZfvlLu3HIhYRj4pxm+FUIs6h67H+unyAAtEbBXhmg2uHQC5e57mubcfetRfUbQnKpimuGqZkPW5F7MSd5bz76WKSFkhCKyAM6D1R6RMxhrMTblZ5Mko8oPuYRDOgq9ASEtmpWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471110; c=relaxed/simple;
	bh=A7yzI6p8iC7yPkOUr3PSzuBisKN32aaC2Ohaxi/CO+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1deovaUCcGljz1jUqANu0FpZge4JqbdCWf48vnoixJQ1/e3ViUVcfwrIxNaPliIfbGGHqYTNMqMFP+VWnidipbTHjlLjn9wlizXzI2pcIyU2QhWZhS5R8u8sHTCWxp7OjWh0e7B1Cf5D79x8Yn2BS572YgLDj8KgNtY6TuJ9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FWXFcMP4; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471093; bh=rE9asUiY4ZOTyebep+Vmd5NsRtFQtl4VkUu5CnexPvE=;
 b=FWXFcMP47lR8H8YxHNYa/fV6AxS1uFcmdCAZimBCRF0xVz31IkkUJckVerEyecHBog7vL1+NV
 ZiG3dqOJtrA/CGmGMtW8tlF3z9KiSOY/E1UvDY1kZmNPhdBWANgUzrwJKIzAwiN1Kqu7axM4DFS
 EZ04XIyEwgcYS62O+D7+1Cg69SrZ2JBnht/jp/MV7I0X67L7NN79ZNbJRNChzd5BjJpEtFhbT/N
 3Bhdp53pPmL7Nb5plZiF6FcxN1nIbS/Sj0H5IYsdHB5G+eGDx+4aDYqltHoQUAe89jcJ94devY0
 kX7tnZpOn0ZMaYisgs0zO+ZLwRBy1JjN/oGcIM71wmUw==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/13] drm/rockchip: dw_hdmi: Allow High TMDS Bit Rates
Date: Sat, 15 Jun 2024 17:03:56 +0000
Message-ID: <20240615170417.3134517-6-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc9af24e0254b3980402d

Call dw_hdmi_set_high_tmds_clock_ratio in phy init ops to allow support
of High TMDS Bit Rates used by HDMI2.0 display modes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index aae48e906af1..5df9c9a0d369 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -362,6 +362,8 @@ static int dw_hdmi_rockchip_genphy_init(struct dw_hdmi *dw_hdmi, void *data,
 {
 	struct rockchip_hdmi *hdmi = (struct rockchip_hdmi *)data;
 
+	dw_hdmi_set_high_tmds_clock_ratio(dw_hdmi, display);
+
 	return phy_power_on(hdmi->phy);
 }
 
-- 
2.45.2


