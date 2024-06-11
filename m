Return-Path: <linux-kernel+bounces-210201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887459040C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2780F285EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A784D8A1;
	Tue, 11 Jun 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="xxHZlJeP"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6908446AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121758; cv=none; b=hRzqqN6TQissBjSzcUsDlge/k5Rri76QG0ysNvF0rEJHvO/VWBjkKDvfElzuApTIIfeSIO96EQvpOm8HXwwTKOaxHvOWkkBQhF/0U5gV1e62uSJ/xnWvcHQeHKIhCsKsEKdk7vXpWNF1lVE5gCUDrOAJ9trAyQUC4lLOeZcM9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121758; c=relaxed/simple;
	bh=lC5OVFU9Qi7ZW5AqBnT0dzLkcAnr3s4trXkUyYPSO6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2q2Zug8FxPRdzxx7PQc7gnVXYA3w4p+dNC4mHIcWGY6Yal3f90jVKNyUsRPe0TIshXpbd3K54Hh3uwgxlyVO9c9Bx0NfamWU0zzmCHULdbkRFRtY3L5ZApTjSMdkCC0DyHbck0A6grRz6t5ZZioadRfOBTDzSFjzareE6iZ6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=xxHZlJeP; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718121749; bh=gBdN7nfT2KsJNoQBTFhnZ2+II985vPoMN7WbKf8ej/Y=;
 b=xxHZlJePZplB5OxOX0uLso2Q1b1vlgAnzccnyGpL9tm8QWAyGwgPgnilqV6d7v9WPmp+IpnxB
 eP5a9L+XVykjqwXmWRYt59PN1Ie4iU2BklHsX2ZMuUoEmBNnb/6f/D+EKSbsg+XPbq+sy2AxBiT
 Y/begZNJO7eQwGVRjigGq8ExH+fglEfhecumCuFcfxYJoGyMDlH2j71fe56b+MvrFdhVXaF5YmD
 UWiu85pzfVRzu41gaRePo64juwaZlbjglnNaa2NzJgA8yzgKgiHcFwoFHAv1NUmPW/fChjQE29G
 h7o32HI9SglHs2H94FkxF7r9WgbvvHLga5PdnK9urKXw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
Date: Tue, 11 Jun 2024 15:50:54 +0000
Message-ID: <20240611155108.1436502-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611155108.1436502-1-jonas@kwiboo.se>
References: <20240611155108.1436502-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6668727cb913b04293b6dc42

Use the passed mode instead of mixing use of passed mode and the stored
previous_mode. The passed mode is currenly always the previous_mode.

Also fix a small type and add a variable to help shorten a code line.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 34bc6f4754b8..ce4d4d06f758 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2241,6 +2241,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
 			 const struct drm_connector *connector,
 			 const struct drm_display_mode *mode)
 {
+	const struct drm_display_info *display = &connector->display_info;
 	int ret;
 
 	hdmi_disable_overflow_interrupts(hdmi);
@@ -2286,12 +2287,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
 	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;
 
 	/* HDMI Initialization Step B.1 */
-	hdmi_av_composer(hdmi, &connector->display_info, mode);
+	hdmi_av_composer(hdmi, display, mode);
 
-	/* HDMI Initializateion Step B.2 */
-	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data,
-				  &connector->display_info,
-				  &hdmi->previous_mode);
+	/* HDMI Initialization Step B.2 */
+	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data, display, mode);
 	if (ret)
 		return ret;
 	hdmi->phy.enabled = true;
-- 
2.45.2


