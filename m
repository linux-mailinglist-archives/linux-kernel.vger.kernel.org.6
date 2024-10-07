Return-Path: <linux-kernel+bounces-353037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8247599278F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293CF1F215FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47918C341;
	Mon,  7 Oct 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="JcBNGQ4E"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319B18C038
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291157; cv=none; b=lfpcQgGLw9B1KNIJTKS75kxgckFRypCumeSEWW/COCr8ceuuHASQ03qj3p7Rsz1C6vwlmFuKEwVv/J+MZx6CzY+a9FIVxmPw/3MAzeKhOgHw+snEs5or5Hh6EOFEL2hewAnJPIMZE7rFH0PyQwsH864JeRJNCJmsJIMZtkZYyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291157; c=relaxed/simple;
	bh=qfX2mnxYzZwssLTi9cs/IUEE0ltOc7Ron8lKo7nhlE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIFe2weBwGDek98fphuCjsbu81jZRIQSxzNcJ5VDNBAnBqLu0bNXC8daoe1ZPZFBoXN6yVTQZ6tF/pKZF6IDPHM7edXglFe61kSnNV8iAFZ+QkzfyGv7xr2IkuZ+NY4H8/HvIPFDZk/piNqN3qrrs51bVzpfIOdZuk/HKcmTiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=JcBNGQ4E; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1728291142; x=1730883142;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qfX2mnxYzZwssLTi9cs/IUEE0ltOc7Ron8lKo7nhlE4=;
	b=JcBNGQ4Ewp1MmoWvHDphoeP69//P0Nl21U2IAuWKiG6ktloufWjCahD4UhxLv4XJ
	/fjPnXRS8sgVpusL82O8/LhBy1UTaG8zY4cqVt70Y9u0qN+vCuwNVHv+Gx6/YqMJ
	UPa7x0mzUKR13tVEuGIsXGeGErdqTQqqt+RvS7W9rSw=;
X-AuditID: ac14000a-4577e70000004e2a-f7-6703a14655d5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 84.A0.20010.641A3076; Mon,  7 Oct 2024 10:52:22 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 7 Oct 2024
 10:52:22 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<bbrezillon@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
	<robh@kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 2/2] drm/bridge: sii902x: Set input bus format based on bus-width
Date: Mon, 7 Oct 2024 10:52:13 +0200
Message-ID: <20241007085213.2918982-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007085213.2918982-1-w.egorov@phytec.de>
References: <20241007085213.2918982-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWyRpKBR9dtIXO6wZYPEhYnri9isri/+DOL
	xeqW6YwWa/aeY7KYf+Qcq8WVr+/ZLJ7PX8docfLNVRaLl7PusVl0TlzCbnF51xw2i4Uft7JY
	tHUuY7V4v/MWo8WkeTdZLf7v2cFuMfvdfnaLLW8mslp0v1N3EPbY+20Bi8fOWXfZPWZ3zGT1
	WLznJZPHplWdbB4nJlxi8rhzbQ+bx7yTgR73u48zefR3t7B6bD5d7fF5k1wATxSXTUpqTmZZ
	apG+XQJXRs/HR8wF74Uqnu6xaGDcwN/FyMkhIWAi8eXkfRYQW0hgCZPEjb2RXYxcQPYjRon2
	J0+ZQRJsAuoSdzZ8YwWxRQT8JG592ccOUsQssIlZ4vPr3WAJYYEQicU/TgHZHBwsAioSJ7ea
	goR5BSwlTnU8ZYJYJi8x89J3dhCbU8BKYvr9KcwQiy0lvp/dxgRRLyhxcuYTsIOYgeqbt85m
	hrAlJA6+eAFVLy/x4tJyFpiZ0869ZoawQyWObFrNNIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZ
	qUWZ2XoFGZUlqcl6KambGEFRLMLAtYOxb47HIUYmDsZDjBIczEoivBFrGNOFeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MPpX2C/cvDGoW2fW6vqsb1Wa
	905P3fPIr6u8++6Cyp99PCFSb90+fRA+tPuF0PrvU6t//l0TnFrI85V3vmX2i42vXr9ffu7n
	wm1tqbNKi7SYTHUdJ+5ee8HKcMsV7a0bHJ38lzxJVoiR7q+z7bj74oVHk2HLzovecxe7c86Q
	O/pprulZk8aDQtuVWIozEg21mIuKEwFdqLjL0AIAAA==

Introduce a bus-width property to define the number of parallel RGB
input pins connected to the transmitter. The input bus formats are updated
accordingly. If the property is not specified, default to 24-bit bus-width.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2:
  - Use bus-width instead of data-lines as suggested by Krzysztof
  - Handle default case separately as an error case
---
 drivers/gpu/drm/bridge/sii902x.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 7f91b0db161e..3b9e4e1dec45 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -180,6 +180,8 @@ struct sii902x {
 	struct gpio_desc *reset_gpio;
 	struct i2c_mux_core *i2cmux;
 	bool sink_is_hdmi;
+	u32 bus_width;
+
 	/*
 	 * Mutex protects audio and video functions from interfering
 	 * each other, by keeping their i2c command sequences atomic.
@@ -477,6 +479,8 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 						     u32 output_fmt,
 						     unsigned int *num_input_fmts)
 {
+
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
 	u32 *input_fmts;
 
 	*num_input_fmts = 0;
@@ -485,7 +489,20 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
-	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	switch (sii902x->bus_width) {
+	case 16:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	case 24:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	default:
+		return NULL;
+	}
+
 	*num_input_fmts = 1;
 
 	return input_fmts;
@@ -1167,6 +1184,15 @@ static int sii902x_probe(struct i2c_client *client)
 		return PTR_ERR(sii902x->reset_gpio);
 	}
 
+	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
+	if (endpoint) {
+		ret = of_property_read_u32(endpoint, "bus-width", &sii902x->bus_width);
+		if (ret) {
+			dev_dbg(dev, "Could not get bus-width, defaulting to 24-bit bus-width\n");
+			sii902x->bus_width = 24;
+		}
+	}
+
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
 	if (endpoint) {
 		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
-- 
2.34.1


