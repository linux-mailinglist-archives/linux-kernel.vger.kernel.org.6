Return-Path: <linux-kernel+bounces-215947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DA909923
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BD91F220E5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A016A340;
	Sat, 15 Jun 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="kgwOB6T9"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4576BFD2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471124; cv=none; b=XriwRcVLfY5g8GPTZd7avHyRfdmXzhsNXlsOJZ5SqG9XQw9g2lZg7yWdN8a40fozA/lpexmu6bkJHtK0UI5bDM6UmeTGlwtP4uWDa6WDjdy6cj6SQ4Uuy2x8l1ufKE/iAFQyaVIM4hvqsB+FAMnPwk5oXGpEoSTbQ37Q7yK934I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471124; c=relaxed/simple;
	bh=FaGxb6Oxbnm2wL0zClqTzPiAgKuIJ8QlVV/Emg9KgPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHubAT1rKhO7fFDghmiWMj2FkMiwBUwHO0MWfO0/q1kkvYT1Bisz3zSXd9l1WNVnzeHRNlBRej9z8FxcMBx8dDatvm0NnAkIV7wu8o/SABWrFtiF31QEHB9hFrRDQEZZdlWI+DJIxlzhQXB5/98Qd4hKg50Q9kZSVq4lEYDxtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=kgwOB6T9; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471104; bh=edw+pFynRH27QoyX9zOhxiRHTMZh2GXeD3zDbH9aM0s=;
 b=kgwOB6T9ULzOyWUr9ARhoa84VHR8MpP83DdZtBKx7BfN70hCPCQoh6eKUUhtLaDgxmSiWxrNS
 mYMQeiPPyuYUlA9Gx9Bu+TYqJCNO60ThAs6sSNkbp/bL3/c3VQm6QCnNmcWHYGc0LKxzVDesT+l
 jaekM0HuQ0zlKSmOqsDobkxiUkz2GkIlRngHoQy7HNmUdMt69Mgc9lMLRinQwbaIZS4ecpnTfTO
 e+H4/8XTXH6R6BF3jAqaWsH99x1/DfxzZALnFqL07VOtZepSfkp27prRW6EnnWtgMj4h00yr1/k
 Q6xtONoLwuF3fVdChuopAvi+jGBGkM5ekYoE2ZNwTu+w==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH 08/13] drm/rockchip: dw_hdmi: Adjust cklvl & txlvl for RF/EMI
Date: Sat, 15 Jun 2024 17:03:59 +0000
Message-ID: <20240615170417.3134517-9-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 666dc9bc24e0254b39804063

From: Yakir Yang <ykk@rock-chips.com>

Dut to the high HDMI signal voltage driver, Mickey have meet
a serious RF/EMI problem, so we decided to reduce HDMI signal
voltage to a proper value.

The default params for phy is cklvl = 20 & txlvl = 13 (RF/EMI failed)
  ck: lvl = 13, term=100, vlo = 2.71, vhi=3.14, vswing = 0.43
  tx: lvl = 20, term=100, vlo = 2.81, vhi=3.16, vswing = 0.35

1. We decided to reduce voltage value to lower, but VSwing still
keep high, RF/EMI have been improved but still failed.
   ck: lvl =  6, term=100, vlo = 2.61, vhi=3.11, vswing = 0.50
   tx: lvl =  6, term=100, vlo = 2.61, vhi=3.11, vswing = 0.50

2. We try to keep voltage value and vswing both lower, then RF/EMI
test all passed  ;)
   ck: lvl = 11, term= 66, vlo = 2.68, vhi=3.09, vswing = 0.40
   tx: lvl = 11, term= 66, vlo = 2.68, vhi=3.09, vswing = 0.40
When we back to run HDMI different test and single-end test, we see
different test passed, but signle-end test failed. The oscilloscope
show that simgle-end clock's VL value is 1.78v (which remind LowLimit
should not lower then 2.6v).

3. That's to say there are some different between PHY document and
measure value. And according to experiment 2 results, we need to
higher clock voltage and lower data voltage, then we can keep RF/EMI
satisfied and single-end & differen test passed.
  ck: lvl =  9, term=100, vlo = 2.65, vhi=3.12, vswing = 0.47
  tx: lvl = 16, term=100, vlo = 2.75, vhi=3.15, vswing = 0.39

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 4acf73b5692a..205cfe02079f 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -204,7 +204,7 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	/*pixelclk   symbol   term   vlev*/
 	{ 74250000,  0x8009, 0x0004, 0x0272},
-	{ 148500000, 0x802b, 0x0004, 0x028d},
+	{ 165000000, 0x802b, 0x0004, 0x0209},
 	{ 297000000, 0x8039, 0x0005, 0x028d},
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
-- 
2.45.2


