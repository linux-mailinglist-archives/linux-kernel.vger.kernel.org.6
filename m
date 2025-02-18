Return-Path: <linux-kernel+bounces-520250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16046A3A785
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B00188FDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755011EFF8F;
	Tue, 18 Feb 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O5mVlsoo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CE1E8338
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907046; cv=none; b=T+JPASbFD2w4QhI1KdLd5IncuXVVkB0HbAwePozm8aeYyvDGJxIrl77fUKa0f26yyG2JUw9XMV+aDrtT8qVlGKsgcFehVvnI9gu6YKPoCfgpdZKSNAyj5dJVB3NjhIQH/0btuyQcn72RVpPiQk+1WZEzxMkBp2qdO5A9Pw+OL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907046; c=relaxed/simple;
	bh=KuxNBMyQg1p3DhiqEXTbWghcfYRAG9Z13aki2rWrd7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tG42T15zUScA3HIUvG7p8SMJEl9C+gzIiM+zrLQ99wbmsJR0XoXZEMqO5WoOAeiJKKlZP62D77z9OP7ly7RY1kL8aSV5pmGWJ0K5hvv7BDgZFcUVl46380DEUZHT6ahsBIN9K7kPfvwpT/0ctCr3D7FrF3xV+rhIuhFlZ11f7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O5mVlsoo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e04c044224so4701969a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739907042; x=1740511842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIVOEcwBRHvFCUubXKAVFbf42uXe9rpQsZU+xYDLrc4=;
        b=O5mVlsooyXOLoB8yEC738C6QeFamgJV2d7ph9W2DYX3D6TSYpWEEL49MfxZf1KECZW
         OaT0DwUoaq6yOLsELevORbkSOdjfX3dJGA2T3U3vSGUvUckZEKXJhv4lPORe2KtTlot2
         B8uAbbOdw6wbUoQFHtN9jU2PzGbznWRihmAfYIz95dtyAVPBy1cfJZVuHiFD5+xGtL4m
         toDW1MwI3QbGuDOnxFD8vM4APMmMzMaqqo/ZMypRYpDLFmc1/St0JsiKuk1eVAtxpRQb
         xbiHHIaOuI/7ITmTf48UHElj1vjTTjvbjRijbq7cdWQzCmxIrWitw94UAztq1owH8Zf5
         Ejlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907042; x=1740511842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIVOEcwBRHvFCUubXKAVFbf42uXe9rpQsZU+xYDLrc4=;
        b=TzdLLXC4MwR0PPoAsLzFLvfok+xOleOPkGqgKoTbcDCrGDxP1R3qAy3s1yGNPUTWWc
         NB7pBmnUlOqkc6Um01kjqH0w12rbTIa85SnM7PpqOHJF118L2lzHXFC9oHCXIz4HX0WP
         60kAO1jfPrrr7hjYwueh7TVwtd+/rSfo2KNitRRN5PZejp9GBtibAnHIrIyxIuG75Dhd
         //91JaRIqpN+zA64tJrvh/O9rhmS2SaUB0nCnZcxuZRNP0PpvoZGauBGwTwcMDBzej9l
         xV+xTozL/ozBA1dtOyGP53tURbTX0jXAchKi984wgLAnh5wOmfQfjFCuaHlA4Yb6xSou
         S/uQ==
X-Gm-Message-State: AOJu0Yxapft+gPflnX11dozcEwy8H1rHBim0bmD46gpoqe0zQP0FHZMQ
	Y0nZwf8S4AcABifDd7ie42BRCOqHbJuZyl9hwUdHuqFXJ9k+xvmGQzVnXuO2KwQ=
X-Gm-Gg: ASbGncunX3SnlE3g8tymZQVf1r1XspBsez0q8HnycqxpG9T2oEtQoOnPTVaM0C6kLKz
	Ob4QDhrNIkewelckcS46cVwVeLHKVch5/W6BxgLsHlHgl2QZHKLSc48RtiLbAL8p918Nc/mKaT+
	HhapuhULcIfqbYa6Q89qfctmqZqlBO2OpdPSe9tnxFj4otXmbbAMdN1GcCdi4XARJaKOQIdWK+1
	uWbYzK5E9ShCE1hRAXlI1F9crE3EB234NrtBHfa0YeQaG2C4PDkqU8l7QcrXarUfCzIpZKhC/dL
	J1KNobslWIoeRfwWS84Yp1zvJedk
X-Google-Smtp-Source: AGHT+IEaDlkCpMhhf2+mkMM5/OKTB8EFYwX98r88Q56bEpDWJea+Vb3RIYNYnlJJ1n7KeB3rfmfZsA==
X-Received: by 2002:a05:6402:13ce:b0:5e0:4a92:6b45 with SMTP id 4fb4d7f45d1cf-5e04a926cd7mr12713802a12.24.1739907042130;
        Tue, 18 Feb 2025 11:30:42 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:cbaf:af0:839d:fb4a])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c3ce5sm9338985a12.17.2025.02.18.11.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:30:41 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 18 Feb 2025 20:29:48 +0100
Subject: [PATCH v4 3/8] drm/bridge: ti-sn65dsi86: use the auxiliary device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-aux-device-create-helper-v4-3-c3d7dfdea2e6@baylibre.com>
References: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
In-Reply-To: <20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Danilo Krummrich <dakr@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Douglas Anderson <dianders@chromium.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=KuxNBMyQg1p3DhiqEXTbWghcfYRAG9Z13aki2rWrd7s=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBntN/R9RdbIU/LlFZOD+5ye18+mV/JIVvHg59Fc
 N2QSzq7j3+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ7Tf0QAKCRDm/A8cN/La
 hRT2D/9/+3m2izVFqHA9JNo66E9ppsPmq0HJSfSk8sVMTrgr6uyqpbKEpE6M6rPkiSX8366n+TD
 eCRkzB1L3/KYyK0Hb6qwNlKpqho+iKWAdXZV44t38LU4jLxy5upDUo9DvKN6ShNzojjGOTQLiUX
 0dP3xRvTlmnWLLr7cA75tOMTQzeMB4gX7ih7W7tsoc/5NyUZdYD1S6cQQMgskakyzZ4OSljy+1B
 urNGbxB+IGwSOEFGYqdRSUOC/bnk/G0Z8X05CINtg4TtcsyIBYA+vhcXrq8X7AXN+iukU8H7SLE
 XHUZl1EYgw1vcvyHPr0WaDPa6aP95wEZ8wLfGy/5xrWMdj9GFyWxILnDhvTipioT9+dSCjiwmRt
 w+sfi529OC67DfLep6PkVbY/1YyDl0NnfnGQjgIywgZ5lzCsOgmUtp3Yk5akbxJGwpC4qMyVH4Z
 VVqymYHalMIVWz01kgnbtplKww8u2ruISe4cz3VZDGxFEGf4oLHk+Ea9NwfdHyVGrOmjzKg2IPg
 ADyUwJ+eeALG/5zj8sK1Eo/GJ/P0kNStexXzQl5ui9MPUg8W4MvzbanzCj9sa8P7Hr/MZGIJ8iS
 ZKQjcj23BRTg2WVCsVgQlo7jSvCh8UYIz+56p2VIel0C3mW7uiq28FLbIqplEtAykScvdKcavs+
 l59DWERCtvYZUPg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The auxiliary device creation of this driver is simple enough to
use the available auxiliary device creation helper.

Use it and remove some boilerplate code.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 49 +++++------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 205bd0fde4f8b3400caa8507092308e50eb172b7..38bd18b14887a27a716c8798f6284649c77a761b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -457,23 +457,6 @@ static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
  * Auxiliary Devices (*not* AUX)
  */
 
-static void ti_sn65dsi86_uninit_aux(void *data)
-{
-	auxiliary_device_uninit(data);
-}
-
-static void ti_sn65dsi86_delete_aux(void *data)
-{
-	auxiliary_device_delete(data);
-}
-
-static void ti_sn65dsi86_aux_device_release(struct device *dev)
-{
-	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
-
-	kfree(aux);
-}
-
 static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 				       struct auxiliary_device **aux_out,
 				       const char *name)
@@ -481,34 +464,16 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	struct device *dev = pdata->dev;
 	const struct i2c_client *client = to_i2c_client(dev);
 	struct auxiliary_device *aux;
-	int ret;
+	int id;
 
-	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	id = (client->adapter->nr << 10) | client->addr;
+	aux = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, name,
+					     NULL, id);
 	if (!aux)
-		return -ENOMEM;
-
-	aux->name = name;
-	aux->id = (client->adapter->nr << 10) | client->addr;
-	aux->dev.parent = dev;
-	aux->dev.release = ti_sn65dsi86_aux_device_release;
-	device_set_of_node_from_dev(&aux->dev, dev);
-	ret = auxiliary_device_init(aux);
-	if (ret) {
-		kfree(aux);
-		return ret;
-	}
-	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, aux);
-	if (ret)
-		return ret;
-
-	ret = auxiliary_device_add(aux);
-	if (ret)
-		return ret;
-	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, aux);
-	if (!ret)
-		*aux_out = aux;
+		return -ENODEV;
 
-	return ret;
+	*aux_out = aux;
+	return 0;
 }
 
 /* -----------------------------------------------------------------------------

-- 
2.47.2


