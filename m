Return-Path: <linux-kernel+bounces-320222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F839707C4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AB81F21360
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6DD16B381;
	Sun,  8 Sep 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WOBmAzsb"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C2169AE3
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802138; cv=none; b=aMnOAMvt2Ho1nHKQ70C/sYjXQGVOT9wySo4aGZDiD4zaOQTOldjWvN4ZjAiC3xvnoYCaLebQZebUKBRlIzU2HNLFPjJAiDnj1UVqDW9o034pdLyOH/25SNWnE8vU8vWp5qAlrPHVhJsUDDqae/LbiAhSfrbbzxTTSp30+fBpeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802138; c=relaxed/simple;
	bh=GrI4opR+kr4AsJ6Etg/Qjdy9EfwwwJ5+46y3TO7YBKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSoLAj7Xqpap4RY0gASYz+uhHCttun0M4kMWpJCcj4f5nt4V/G4S/goqgZFbW2VqNPLVh6qKBbgBCxoTPPyHQxPqppxNJJBNZfYFUQ7FRTGVFasOdLZM+/EZpCZ/C9MmpOvKnN04Pfr8aivRc/2J01VhwxwDytsUVx40jEz5Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WOBmAzsb; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725802115; bh=hy/enUDFhn7EYrNY9bdwQkDRAdMM4VCr4M1zQdlFbcA=;
 b=WOBmAzsbKeEJgWFKLw7VqUnKlD7/EROqP8iVaIy7FXDzXG0YyUgzgk3+Ik+zRxgmF1jUjPmyn
 1b9gca1la+9OP7m7ZMWo657t3/lDrd0vBDCP6XJmh1kqt50GCduS3Dnkrg+RzdYtS3A9oR1e6xg
 F0bZpixiAB+AjZs6d8IGzp1GE11EJiI0HOM+Xm6Vf2ZtGD3tfN877sqmFY+OWo0gY60kArNXkz7
 E6MyqLPgeyDPkL0ALAjquoIAUxyUtLeVo5PNgOyXn4neSg5A0Qe1Jmmm/INjMP2NrO0Q84gZI9Y
 Kg5XK0Yd7rLk0Le6objUdVkCMpah6TM9xJWXePKuoJzg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] drm: bridge: dw_hdmi: Disable scrambler feature when not supported
Date: Sun,  8 Sep 2024 13:28:03 +0000
Message-ID: <20240908132823.3308029-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908132823.3308029-1-jonas@kwiboo.se>
References: <20240908132823.3308029-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66dda6823c9877b4595878fc

The scrambler feature can be left enabled when hotplugging from a sink
and mode that require scrambling to a sink that does not support SCDC or
scrambling.

Typically a blank screen or 'no signal' message can be observed after
using a HDMI 2.0 4K@60Hz mode and then hotplugging to a sink that only
support HDMI 1.4.

Fix this by disabling the scrambler feature when SCDC is not supported.

Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
Reported-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0031f3c54882..9e7f86a0bf5c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2117,6 +2117,8 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 				    HDMI_MC_SWRSTZ);
 			drm_scdc_set_scrambling(hdmi->curr_conn, 0);
 		}
+	} else if (hdmi->version >= 0x200a) {
+		hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
 	}
 
 	/* Set up horizontal active pixel width */
-- 
2.46.0


