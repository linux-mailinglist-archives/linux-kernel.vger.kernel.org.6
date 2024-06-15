Return-Path: <linux-kernel+bounces-215949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE74909925
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5A21F21884
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E905381E;
	Sat, 15 Jun 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fpxvUNDu"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71226ADB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471159; cv=none; b=QlyRLLX1H+7MnwhoZLihaXO66UgAyO6G+ZvBEm4oLXeSSl3XFrFWP1tDWSeebd7ui+nN1P94LywrqvR7/gWuzlJ4jiSBqmSbb7cREe87/s0c9B3w058qeyKOQE/HrFqn8zXu0QkO5wKexoMpNvqIjpaD0zSUUaeEFYYvQnYEd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471159; c=relaxed/simple;
	bh=0po/VlP8wIaeHZ8Cs5hJRY83Q/3uLYYUN7+0BDrTefw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cP6stgZKH03FvCzbsT+0UUiUYb/hUW0o4h68p7CCN4G9rSYurT2pEHfOP+PdN1SL81tfajjtpUnHo97xhemRiV8sFR+q3fY07cqqpbqnU28buC5RdtFKBv6M9EuhmmqfYDq0ktfA1x4QJvelTyDbBpA9hwSg9lUgOTNIa66nR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fpxvUNDu; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471114; bh=t8rcPDPG/alK7F2ckRMvaDdLQI5mciZmFUWfAp+FcPg=;
 b=fpxvUNDuuEp84NC90qwfRnnAR6A/t/A6V0Lgx9cgzCpw0UU/gsO5wYM6lxujHQzM17PZ5Xy5g
 MuY2HKuM4DnTfISREX76uzSbB2uK4a7B7bxO8VyQndMuIumxLk2z4v23P2BfGHQKthZ29V7w8Dx
 plR0k8WGuMMTlWnm6uphUjTS+PExXMpkDPcVjTM/PSfHB+FO6hYdLyAS8AkOb57aH7KHn7Xcc12
 02Xm+URxJznZS3mHvBGD8SDbYGMZTQdPaoBPNq2bdYDCoa5ORvr4LQfcIiUVgbvZaFuSFyt/E6y
 ZuMPxU3z7GpXNpqYlk3o/SuxN6gA6GO1p7pOspvgGoTQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, Douglas Anderson <dianders@chromium.org>, Yakir
 Yang <ykk@rock-chips.com>
Subject: [PATCH 10/13] drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
Date: Sat, 15 Jun 2024 17:04:01 +0000
Message-ID: <20240615170417.3134517-11-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 666dc9c524e0254b39804087

From: Douglas Anderson <dianders@chromium.org>

Jitter was improved by lowering the MPLL bandwidth to account for high
frequency noise in the rk3288 PLL.  In each case MPLL bandwidth was
lowered only enough to get us a comfortable margin.  We believe that
lowering the bandwidth like this is safe given sufficient testing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 9d5bd7455180..e532c6d294dc 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -181,23 +181,9 @@ static const struct dw_hdmi_mpll_config rockchip_mpll_cfg[] = {
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
2.45.2


