Return-Path: <linux-kernel+bounces-215948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B6909924
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A81F22150
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AED6D1A6;
	Sat, 15 Jun 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="f5N9xyOm"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01916E61F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471127; cv=none; b=OKOknsXDuMgiBPhWV4EicYQCdd4VnyXfAhnhC67yIj14heK0AmG+ShXXC75Mii+VG6kutsVVagvwuycHD+iHLDd8Sdm/VN8+10fycTxS85APBfhk9GkejkFrKuFIpHyf/zDYvGWpaU7DT2lR0ZDSZAKunGsW9QSDXlP9N5o5U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471127; c=relaxed/simple;
	bh=55KT8CBRlrhWx1f9DqJlR7WdZielSE2zZrExFyMNyks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYtLuL0WXyodxUCPnw7LlIZupv7uUsKbrN9g2NExMkCTdEo5AKjUwcc4wuBM88WcrDc6+mDHMsUTj4egnAy106oCAQZSjBMnbksPIJN6RZmWYdSVLzilJ6xUle+JWEAIougy6a9UTzpPOfiysIUr/PbMMT8W9ApL6LcEiMQNUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=f5N9xyOm; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471109; bh=tr1oTKBW1hAs0ekTXTS14VMXssfmixvxHWASJNa7PTY=;
 b=f5N9xyOmyuhOFqSyEfVYr4k56ZXwDSRcyl9WJLspyEJtEJD6g80cFk6C3oNHLy6i2E7PLrIwX
 RvXlvhEkHeGYWN1iNkh8VQzHqbirIaVbYEkKaoPrYTYMD0iEmS/OyWkSem+rjOjHcYl/0p/0BDK
 SO5o2FqKI8o5wRNzXaaI58sUVuWC4oSaOgqb6Ge3QLkgo/l1Py1tYAGr6jZ3yLNxmGakqYkFQTE
 LZM7aqy6CZTl9tLem3n/vwpn8ex52yQWDcoKhkZa2X9yKtHI76ezv5GcDSO+4LvmVgMczKFB5tS
 I2lnYCcWR87hFLcZ52/Ygpxll78lp6XE1cjWnEIa7kSg==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, Nickey Yang <nickey.yang@rock-chips.com>
Subject: [PATCH 09/13] drm/rockchip: dw_hdmi: Add phy_config for 594Mhz pixel clock
Date: Sat, 15 Jun 2024 17:04:00 +0000
Message-ID: <20240615170417.3134517-10-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc9c124e0254b39804075

From: Nickey Yang <nickey.yang@rock-chips.com>

Add phy_config for 594Mhz pixel clock used for HDMI2.0 display modes.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 205cfe02079f..9d5bd7455180 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -206,6 +206,7 @@ static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	{ 74250000,  0x8009, 0x0004, 0x0272},
 	{ 165000000, 0x802b, 0x0004, 0x0209},
 	{ 297000000, 0x8039, 0x0005, 0x028d},
+	{ 594000000, 0x8039, 0x0000, 0x019d},
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
-- 
2.45.2


