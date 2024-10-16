Return-Path: <linux-kernel+bounces-367506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5979A033D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4F1F21C58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD01D1F5A;
	Wed, 16 Oct 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6wlyl30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484F1D14EC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065253; cv=none; b=GE0H2Cym2S6p7V5uBUEMoASMXjrX2mStksU79XBnLOMgb139oOaAAEo0hLx8QHcGpusWZI7oUOOvN13XCmuMmLobEL45loPYb7olbbyIXY8Vg26vj+VcFvZxALoGE76ARYBAplQSFBGnQWGUQKqn+G2UhfdWtJLRmdgUdt6FgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065253; c=relaxed/simple;
	bh=KPrIiUCCJvcpVV496icokuhP6hghnoZ7VLpEGBD0vAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQ8Yyed82FF0X2OIM73hjW7EpdpkkkixmwvgWVsgEJa58nkVTxS65safOsml3UnNsRr9JRQwtNvxtXFm7///K+IQGzzlNHbaadSA7o/SGkeQhAWTbCo3sP7Kc8wxLIWypX3xCcrdpVRZIPNOZ0El7cb7YCXGBRP07wmupwh+VOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6wlyl30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4145C4CEDA;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065252;
	bh=KPrIiUCCJvcpVV496icokuhP6hghnoZ7VLpEGBD0vAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s6wlyl30aTN6Sb6cBsi4iXTnSgAHhTp7FgL+Dx4+B8S8pWQmGVw5TciicJHEXZ9KP
	 d2PilA1apRW27J0mRBLNq6GxccaOOuVJrqT+VaeLBV8bu0m1goRjcGEh7Pt+3h8UQL
	 G9cEWfed+ElahOe+1+Kzg4TYA5Qc1u/nETUvA8QNoqL6x4p0/rMog+UA4s88Hn9KW2
	 Di6afsDhTUeElkn72LRuhWZfAGduw1+tCqtxu1trYxNxNnkr3t2YO5G1iVH8RawXDX
	 3zralsVdjOc63PlPBmkuH0XlbAvRh6ftyPvJuAzzE6gWSdlMhSlbccol1Zh+iYEuP7
	 jXgOYejNa6s9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF90D206B0;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 16 Oct 2024 15:54:17 +0800
Subject: [PATCH v6 05/10] drm/bridge: it6505: fix HDCP Bstatus check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-upstream-v6-v6-5-4d93a0c46de1@ite.com.tw>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
In-Reply-To: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729065263; l=1511;
 i=Hermes.wu@ite.com.tw; s=20241016; h=from:subject:message-id;
 bh=Hdhgn2iSLeVVknrOzDCehQJFmQa5IML+EAJRH7ql5B0=;
 b=KmiRnZAqgwt29C/uSmasEHlJzvn/1X8tZctI0vzUChO5ZLG8v2pd4zYAzfN1XZAiGCBhWY0zq
 0wY4lvw6MsOBnsVkZLVHChV4MzV+JiRPb1y36wmMynqpZjfi8yTsBDe
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=kV18uQEXox+1WccdQceCbMlJKN+BBNUk3N8VsoULcQ0=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241016 with
 auth_id=250
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When HDCP is activated,
a DisplayPort source receiving CP_IRQ from the sink
shall check Bstatus from DPCD and process the corresponding value

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 1159725f6871e5912aa6c2660823bee67115143e..65c17e53e05f3bc2a647474cba7d9d7e737f11b8 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2322,14 +2322,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
 
 	if (dp_irq_vector & DP_CP_IRQ) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
-				HDCP_TRIGGER_CPIRQ);
-
 		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
 		if (bstatus < 0)
 			return bstatus;
 
 		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
+
+		/*check BSTATUS when recive CP_IRQ */
+		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
+		    it6505->hdcp_status == HDCP_AUTH_GOING)
+			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
+					HDCP_TRIGGER_CPIRQ);
+		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
+			 it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_start_hdcp(it6505);
 	}
 
 	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);

-- 
2.34.1



