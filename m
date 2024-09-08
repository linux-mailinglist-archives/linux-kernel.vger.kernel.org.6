Return-Path: <linux-kernel+bounces-320276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D778970846
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A6AB21446
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59337173328;
	Sun,  8 Sep 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="0E6pG1Zy"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25E172BD5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807360; cv=none; b=iNJrY3h/RqgbMIz7ngdLe8BA9K8AOSkQ9t8dzt2xUokoG4KpryMyQBxKi2TULwU7gmSYa3QUpQbS2QTrpiGJxsrO1XBT8txzMXa/EVO6yhIaKI+t/kFgkZUF2KDGbtCpH55rpMGhnlpACIa2z792iGZ/x+MQ8cznCdhJ8AM4RiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807360; c=relaxed/simple;
	bh=i+l41S3DZ0geQKv4DNbjFlROfjZrIxPPUIAUJ41DYew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToT2pIjHzpHP/R4twrXv35dzJkFM1fUuXNz6lU9Jhn4dy2oab8GmC+spLqna0sNCl4SFbcY3fBvoCsQK9fL7g8VU5Jvsr7XknaGTUba/GiAytMsmQt8m2iIjepaYLJhdOWCeub07fmCa6WteD3RwKU6BMhGzOmABwLLln3Y4lhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=0E6pG1Zy; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807337; bh=ayVVX1VNsu2ahinEz6B9K+t21YFAycF1+6CeV0lPdHk=;
 b=0E6pG1ZyTJEWWiA5yGSht//uI0NtsQbBQCvqzXVm5YjbainV6iPICFQ1iKCowP+Pq+CKw4j83
 mm0F3pW1ZxgFo9njfnmG+FJep0Ni8GSk5vzkUsShTYQJlDJRH6WqwYFCmZYGesUJI9fmeocXr/G
 +OjmcyEjG7PcMA0MMbFlsdazR2GeJWUcyHiKRKiPKl1+ghojdAy3HoPowwWO/N8zbvFO1iHM9l/
 VCzLFFqw3iaz+fiEcLJGZYrmSRQ+ocEpFIH8/Btfj0LiuFzL1ngUZucnaExyJTjKwg0pjjDkf/5
 zDSF/T5Onxl4g5O+6Edn2i1mxxzlDjWxwmxkFI/JzshA==
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
	Douglas Anderson <dianders@chromium.org>,
	Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v2 4/7] drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
Date: Sun,  8 Sep 2024 14:55:01 +0000
Message-ID: <20240908145511.3331451-5-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ddbae83c9877b459588ec0

From: Douglas Anderson <dianders@chromium.org>

Jitter was improved by lowering the MPLL bandwidth to account for high
frequency noise in the rk3288 PLL.  In each case MPLL bandwidth was
lowered only enough to get us a comfortable margin.  We believe that
lowering the bandwidth like this is safe given sufficient testing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index dffbae005a96..a050a65af8f2 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -179,23 +179,9 @@ static const struct dw_hdmi_mpll_config rockchip_mpll_cfg[] = {
 static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 	/*      pixelclk    bpp8    bpp10   bpp12 */
 	{
-		40000000,  { 0x0018, 0x0018, 0x0018 },
-	}, {
-		65000000,  { 0x0028, 0x0028, 0x0028 },
-	}, {
-		66000000,  { 0x0038, 0x0038, 0x0038 },
-	}, {
-		74250000,  { 0x0028, 0x0038, 0x0038 },
-	}, {
-		83500000,  { 0x0028, 0x0038, 0x0038 },
-	}, {
-		146250000, { 0x0038, 0x0038, 0x0038 },
-	}, {
-		148500000, { 0x0000, 0x0038, 0x0038 },
-	}, {
 		600000000, { 0x0000, 0x0000, 0x0000 },
 	}, {
-		~0UL,      { 0x0000, 0x0000, 0x0000},
+		~0UL,      { 0x0000, 0x0000, 0x0000 },
 	}
 };
 
-- 
2.46.0


