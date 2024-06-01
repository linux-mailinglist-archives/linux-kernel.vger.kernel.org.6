Return-Path: <linux-kernel+bounces-197851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951BE8D700D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69561C2145A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C915251B;
	Sat,  1 Jun 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pO6OX9Oj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ADE1514D9;
	Sat,  1 Jun 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247590; cv=none; b=N29HviJAJFei+mOwVKMxBrnKlfJl0Rm4Lx9pr1cJrbg2C/gKI9B+AX9+wsI8qDQg9I40pIn9JCZr83/0uOvl2vaVIBcYNSbDILKZ3FxIIfhHUb5tYYO7FE9HabgnSdeOZ0lRujTtRt9HHp1tzrhrNqVCpqh7JrhX1DE0+BuVJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247590; c=relaxed/simple;
	bh=Potzyhce4Kbwz3ncwPjojzHRgtcLidd3K5wALNG0/oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnUFjHfp+/rmDP1R7mpCXeT6qKAd69OlSUQ2JRG/Zub/MWPrfVBVA9KhXso6ZqCz7DXP2dP2Vlq6Wm7dXijx8tfAGTWShiurKZHb65ACYs69bNSadWcf9BU7F+Np4ycL0Z7lcrTUAPy+JHbpJEayfI+emhefCg6x4454+eWimZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pO6OX9Oj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247582;
	bh=Potzyhce4Kbwz3ncwPjojzHRgtcLidd3K5wALNG0/oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pO6OX9OjOlVw2zgG4UMuwGPgr5eFHKPkM6BxwVf91cGAoBdeHPp/mHCOh5y209HHc
	 DE/TQtHE4PRl4TxnlN1oiKNv5ZHIa726dDR14f3edfE3W6DNBCXMkuF1lE6rwH5Ep4
	 zlG/G0IjilZe1HjP23lAhe7sXxlGRBNwtMIFQTQ1gI0hzbAhRcPerXFXqHVwsW6si0
	 AgW2jfWvrByf50eA/ftQEKmYSkWCJYYKT8kWH7N/LTwByntz/LlU8ugj5hn0m9erkH
	 4lbGM38X9d/wKUw8HGngoK2qTrPdcOejSgfGkVgyplAK4NsIU1G6Ca+XK0tWEsjRQg
	 utPcLRCnIjZPg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 02CEF37821EC;
	Sat,  1 Jun 2024 13:13:02 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 01 Jun 2024 16:12:25 +0300
Subject: [PATCH 03/14] drm/bridge: dw-hdmi: Commonize dw_hdmi_i2c_adapter()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-3-f6203753232b@collabora.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14-dev-f7c49

In preparation to add support for the HDMI 2.1 Quad-Pixel TX Controller
and minimize code duplication, export dw_hdmi_i2c_adapter() while adding
a new parameter to allow using a different i2c_algorithm.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h | 2 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c        | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
index 28e26ac142e6..ffd2ee16466c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
@@ -146,6 +146,8 @@ struct dw_hdmi {
 };
 
 void dw_handle_plugged_change(struct dw_hdmi *hdmi, bool plugged);
+struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi,
+					const struct i2c_algorithm *algo);
 bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi,
 			  const struct drm_display_info *display);
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b66877771f56..5dd0e2bc080d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -376,7 +376,8 @@ static const struct i2c_algorithm dw_hdmi_algorithm = {
 	.functionality	= dw_hdmi_i2c_func,
 };
 
-static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
+struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi,
+					const struct i2c_algorithm *algo)
 {
 	struct i2c_adapter *adap;
 	struct dw_hdmi_i2c *i2c;
@@ -392,7 +393,7 @@ static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
 	adap = &i2c->adap;
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = hdmi->dev;
-	adap->algo = &dw_hdmi_algorithm;
+	adap->algo = algo ? algo : &dw_hdmi_algorithm;
 	strscpy(adap->name, "DesignWare HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
@@ -409,6 +410,7 @@ static struct i2c_adapter *dw_hdmi_i2c_adapter(struct dw_hdmi *hdmi)
 
 	return adap;
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_i2c_adapter);
 
 static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
 			   unsigned int n)
@@ -3373,7 +3375,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			}
 		}
 
-		hdmi->ddc = dw_hdmi_i2c_adapter(hdmi);
+		hdmi->ddc = dw_hdmi_i2c_adapter(hdmi, NULL);
 		if (IS_ERR(hdmi->ddc))
 			hdmi->ddc = NULL;
 	}

-- 
2.45.0


