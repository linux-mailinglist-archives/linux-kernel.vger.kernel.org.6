Return-Path: <linux-kernel+bounces-320274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A828970844
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB93F282D8D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2335C171E70;
	Sun,  8 Sep 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="cKDElm8h"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C3171E4F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807353; cv=none; b=MR3SZX+nLrA+mzTPZRN05P5T83bFRzaT9i3NIc7Iprkigr9V2sdBkeCtUba3a3UBOrifMFHJ7BcHKjKxX+BV6di2AVLuvgSxfhKxa4HV8JA1KgemnP3drkGyu/PuXf0n7VTQ5PV5Pq2OQwEZKopAj0v3BGPhj2ejiKi7fJ9p1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807353; c=relaxed/simple;
	bh=eHTkdr7y77ghbU7+/Khvq9iSPwLUxOqI2Sp0bsjqUWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukYIOgkOVaC2W8qaZKFreVs86XHwh5y6rtl9Ybudxh16w4EmXMnHunYwqLh/ssHDNP353Br+Mh2wDrXZhy/IBFVLf9ZoTAo6F4/ER1kjFggw1xhv62pD9XU6OdC/GA9NGkXcNmTZRjo0sRJkkorchVSVZxxXi3g7IfaQhiHUpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=cKDElm8h; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807332; bh=ctgViwAoHsdszvG54A8azRGdEh0njwBKxxYrSAjOB98=;
 b=cKDElm8hkD5z4aDRmrjf1JCNcgRL4B5pCSs5R0UJigy1xpP45jYyDXBkE1nFaYhrYUs/2FKWA
 L+HlkMoh6YbZhuoHrmwJVurpAmo3teK3NvylohUiM6c8xYZ2kYc8xwOI19K/YOQUQ/QilKDn4b6
 BZtF+DqgGwoTkm/GFo0vPOJ0ZNMb7YHWjRUf36CBF9/FEywtBbvL/q/SGTw7PORtSjIU1axCQml
 GEWtk4VViZ/vrXBYPmeuP79/7Iecsv6LM3wEXjt6gn/qVHwTre7M3+6360b2rwa75eDyJRgA9pG
 GJxJdXUxKZtD+3en6+sVA/flh8HTI6qSPAqG9x3wsg7g==
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
	Jonas Karlman <jonas@kwiboo.se>,
	Nickey Yang <nickey.yang@rock-chips.com>
Subject: [PATCH v2 3/7] drm/rockchip: dw_hdmi: Add phy_config for 594Mhz pixel clock
Date: Sun,  8 Sep 2024 14:55:00 +0000
Message-ID: <20240908145511.3331451-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908145511.3331451-1-jonas@kwiboo.se>
References: <20240908145511.3331451-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ddbae33c9877b459588eac

From: Nickey Yang <nickey.yang@rock-chips.com>

Add phy_config for 594Mhz pixel clock used for HDMI2.0 display modes.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index fc5e87285a91..dffbae005a96 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -204,6 +204,7 @@ static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	{ 74250000,  0x8009, 0x0004, 0x0272},
 	{ 165000000, 0x802b, 0x0004, 0x0209},
 	{ 297000000, 0x8039, 0x0005, 0x028d},
+	{ 594000000, 0x8039, 0x0000, 0x019d},
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
-- 
2.46.0


