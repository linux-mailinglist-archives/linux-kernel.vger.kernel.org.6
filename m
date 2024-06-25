Return-Path: <linux-kernel+bounces-228641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090C89163E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A2B27DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE5149E03;
	Tue, 25 Jun 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yneEkd9N"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D98148851
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309089; cv=none; b=GfEofFqVzYZPSJ1dG5j/E/u54AyY6AltagimsEt4N1hc5e4HvM9kZizssz7bN3xYLDW1YDlZQ626bQk3Id5yD7KmqH9Gvzdnq3tefn3xxHfhnyYUo099wvhYcyXNovb2cIM7tlkZgZSTfZ/8H57GFkmYtk+OeHDh5tiq6kLO9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309089; c=relaxed/simple;
	bh=B4W3npsQqWsNe71waP9UxXWJ75KMgfRdLtiNZrBsKtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hd5AJnxHArq2P69dQ4FV7Ga8/vQwHwff+qfFzG+MP2h6E9UyhQwXWO0GQ9LcKdYZXR4YWfdFOrAebst96Ks8aBQw5GGe4Xmgn5woZgwJnjnkKjVTKi08xplkCJAAEveaMTyzO+eUs7Cc4CrymGuwdYQVhRbNfb3d7cq0exhoh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yneEkd9N; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45P9opYp100324;
	Tue, 25 Jun 2024 04:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719309051;
	bh=GpCCOPLHRWQFDvg6W/jqIEVVoGNYbgT+7gouRoV8IG8=;
	h=From:To:CC:Subject:Date;
	b=yneEkd9NEdZVD54gHUSsK94f21pp+h37tlEhkr6emxByq5/tkL2e1q9m4lw/ORlgM
	 aUI5GefF2tQxwB5sloUPac3ytu74AX81QGiKnOheesaGequPgbuz5Ak2Wa7ug3L+dO
	 upzk4/2m89Beu+dci4LXJz1P3DhwfDvoZnNBXgBo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45P9opq7029790
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 04:50:51 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 04:50:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 04:50:51 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45P9ooV3083186;
	Tue, 25 Jun 2024 04:50:50 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg
	<sam@ravnborg.org>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>
Subject: [PATCH] drm/bridge: display-connector: Fix atomic_get_input_bus_fmt hook
Date: Tue, 25 Jun 2024 15:20:49 +0530
Message-ID: <20240625095049.328461-1-a-bhatia1@ti.com>
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

The display-connector acts as a pass-through bridge. To truly reflect
that, this bridge should accept the same input format, as it expects to
output. That in turn should be the same as what the preceding bridge has
to output.

While the get_output_fmt hook does exactly that by calling the same hook
of the previous bridge, the get_input_fmt hook should simply propagate
the expected output format as its required input format.

Let's say bridge(n) converts YUV bus format to RGB before transmitting
the video signals. B is supposed to be RGB and A is YUV. The
get_input_fmt hook of bridge(n) should receive RGB as its expected
output format for it to select YUV as its required input format.

Moreover, since the display-connector is a pass-through bridge, X and Y
should both be RGB as well.

    +-------------+            +-------------+
A   |             |   B    X   |             |   Y
--->|  Bridge(n)  +--->    --->| Display     +--->
    |             |            | Connector   |
    |             |            |             |
    +-------------+            +-------------+

But that's not what's happening at the moment.

The core will call get_output_fmt hook of display-connector, which will
call the same hook of bridge(n). Y will get set to RGB because B is RGB.

Now the core will call get_input_fmt hook of display-connector with Y =
RGB as its expected output format. This hook will in turn call the
get_input_fmt hook of bridge(n), with expected output as RGB. This hook
will then return YUV as its required input format, which will set X =
YUV.

This is where things get off the track. The core will then call
bridge(n)'s get_input_fmt hook but this time the expected output will
have changed to X = YUV, instead of what ideally should have been X =
RGB. We don't know how bridge(n)'s input format requirement will change
now that its expected output format isn't RGB but YUV.

Ideally, formats Y, X, B need to be the same and the get_input_fmt hook
for bridge(n) should be called with these as its expected output format.
Calling that hook twice can potentially change the expected output
format - which can then change the required input format again, or it
might just throw an -ENOTSUPP error.

While many bridges don't utilize these APIs, or in a lot of cases A and
B are same anyway, it is not the biggest problem, but one that should be
fixed anyway.

Fix this.

Fixes: 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks")
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 40 +---------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index ab8e00baf3f1..eebf1fbcdd23 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -131,50 +131,12 @@ static u32 *display_connector_get_output_bus_fmts(struct drm_bridge *bridge,
 							      num_output_fmts);
 }
 
-/*
- * Since this bridge is tied to the connector, it acts like a passthrough,
- * so concerning the input bus formats, either pass the bus formats from the
- * previous bridge or MEDIA_BUS_FMT_FIXED (like select_bus_fmt_recursive())
- * when atomic_get_input_bus_fmts is not supported.
- * This supports negotiation if the bridge chain has all bits in place.
- */
-static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
-					struct drm_bridge_state *bridge_state,
-					struct drm_crtc_state *crtc_state,
-					struct drm_connector_state *conn_state,
-					u32 output_fmt,
-					unsigned int *num_input_fmts)
-{
-	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
-	struct drm_bridge_state *prev_bridge_state;
-
-	if (!prev_bridge || !prev_bridge->funcs->atomic_get_input_bus_fmts) {
-		u32 *in_bus_fmts;
-
-		*num_input_fmts = 1;
-		in_bus_fmts = kmalloc(sizeof(*in_bus_fmts), GFP_KERNEL);
-		if (!in_bus_fmts)
-			return NULL;
-
-		in_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
-
-		return in_bus_fmts;
-	}
-
-	prev_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
-							    prev_bridge);
-
-	return prev_bridge->funcs->atomic_get_input_bus_fmts(prev_bridge, prev_bridge_state,
-							     crtc_state, conn_state, output_fmt,
-							     num_input_fmts);
-}
-
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
 	.detect = display_connector_detect,
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
-	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
+	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,

base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
-- 
2.34.1


