Return-Path: <linux-kernel+bounces-314980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF7C96BBB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF57528B17E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C01D7E4A;
	Wed,  4 Sep 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T0MGXfu/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mZXwE9sr"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD21DC051
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451571; cv=none; b=rBWoge4xn/EKXg2xI5hjhTj8uruT/4dLKAzVb9bd2EmHkHXrnjh5eFs5KEsa/4wHqz5oTwFl7q0iWCyR0yEL2wGxh0oHX7gEiZ0uXnEs1oKlVUtY8m9SYPgoBSyZh0GBXae+vDXBviWGT+ZG6vceLIHy2qfGKdmot1gZ8HfrhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451571; c=relaxed/simple;
	bh=dwyFZOK7PN76ClG5q0V8YIcTXrsqKNvFopwLfgLFcos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IskKlakbyhKrzVr/aLhDIWBdts/anlTpi2+VcyMakjFN7DZY5THrYA5QI/ACl3UXbQ3CV21MQmfO8NlTOmpywYdiOY7E6yToNs2ZQtxkSqR3eAkKwV6VBqa+KFWva88THKmvyIZnYOIe/aMur/QA8jjmcfCo5Cd0ocxitQvPRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=T0MGXfu/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mZXwE9sr reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725451569; x=1756987569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5Md8bHzoNzLwbzoZBJBctmmy6rpnRNZXRRNsmdR80A=;
  b=T0MGXfu/F6oabNHCOpAPGsr0GahQPGTxtcrUjoxD4OZuYqWkH3fgdK3Y
   6aB/Sj+rOMoMntnuAMFDs1bgr5FpHIOeTTBnruYYaXqJl+JLb2qXr3PfX
   gahDz66uNXYibdBSBVU18iumyPA5zOQ9h1qwZ84ztYE+XpvW3JLkMkqtK
   V3FdPHUr9O7KsbwjBoPQLpG7CBaZFQXGkORLgxNo6QUuhG7DWedIAKZ7R
   IMaiA+Y5oIi6GgumbH+H4us2M9bGgKQAkdsWUiAhN+A67eUzg80V/6n61
   7HpZ3YsIzDE2uXjv/ZXHnw4fPkON8n+q2zO7rW2ZaiViF5YHFas8rhVAT
   A==;
X-CSE-ConnectionGUID: sGVoKHSITN6Yi/ND3hv12g==
X-CSE-MsgGUID: MeWdwC68Q7iKf38XIjDxpw==
X-IronPort-AV: E=Sophos;i="6.10,201,1719871200"; 
   d="scan'208";a="38762447"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2024 14:06:06 +0200
X-CheckPoint: {66D84D2E-1E-6568578B-E2E34638}
X-MAIL-CPID: 224E837B4563D50180A4D2595120254A_3
X-Control-Analysis: str=0001.0A782F18.66D84D2E.0133,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7C9B160024;
	Wed,  4 Sep 2024 14:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725451562; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=d5Md8bHzoNzLwbzoZBJBctmmy6rpnRNZXRRNsmdR80A=;
	b=mZXwE9srDpVPK4vusd1EIw1J/Nq/EsMxEb2XR2h9C55c1ibJAjgREedv9YoXLQHhj4mBUU
	DY98wSXReoqsw908xBedZtSSX8D8zX2cO1PQmuyOnqYbRn91N4Jsv3+DHFuMf/JEvy/xpD
	8Qudxn1jJep61CqBfh8GVI9xFIlya4I+up9rW7hVYJws5q0z4jfX9WIQXVJsKr3FEXxaYq
	n7CmQTVSL6uFRrQHdAWIPnoLFfjKtugL56Mwb/bHYntrP+ZiozVKwGIvu/W3dc+CVF/VD3
	cQ3KDx2USyvw12/P4WQHetuOGqjaVMYBsCnWGlEUEVu/vaL9ECqlBOYEs92t5g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/bridge: tc358767: Only print GPIO debug output if they actually occur
Date: Wed,  4 Sep 2024 14:05:44 +0200
Message-Id: <20240904120546.1845856-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
References: <20240904120546.1845856-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Currently the output the following output is printed upon each interrupt:
 tc358767 1-000f: GPIO0:
This spams the kernel log while debugging an IRQ storm from the bridge.
Only print the debug output if the GPIO hotplug event actually happened.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 5ef33ce33dcaa..1c42c8c6e632e 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2229,11 +2229,11 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		bool h = val & INT_GPIO_H(tc->hpd_pin);
 		bool lc = val & INT_GPIO_LC(tc->hpd_pin);
 
-		dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
-			h ? "H" : "", lc ? "LC" : "");
-
-		if (h || lc)
+		if (h || lc) {
+			dev_dbg(tc->dev, "GPIO%d: %s %s\n", tc->hpd_pin,
+				h ? "H" : "", lc ? "LC" : "");
 			drm_kms_helper_hotplug_event(tc->bridge.dev);
+		}
 	}
 
 	regmap_write(tc->regmap, INTSTS_G, val);
-- 
2.34.1


