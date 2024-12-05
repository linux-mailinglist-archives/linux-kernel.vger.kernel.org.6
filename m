Return-Path: <linux-kernel+bounces-432444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F19E4B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F09188158C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF2AFC0A;
	Thu,  5 Dec 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2VeiSE+"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7D23918B;
	Thu,  5 Dec 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359249; cv=none; b=ctVeIO8yK+e4Bg+L/yYnN3eTmPevSO+Q7URENXDMceo5821Qc6ANIXhjzP96Ep0jBrqDYSVJLd1ZfkycxFlfU6hXhD0YP4Omqw/QXQfp51O6BpiPuCIgJjxWqvsc3Rkx5W8dEVUqspU0xRoeP1apXLlyRvMIe8OWakO3tS4MwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359249; c=relaxed/simple;
	bh=kPSO1E/lLVtN6yh+rrWnGkXwFSNkrrG+jVBuQloc4cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVZpPqiNS22xzWpJKIuva7KmELq0OuxxnkdSupINqaZfNsEesKUnpcectBm9pkKfekZqeb9Bey0cTCpQ+Qe08Y2ZP3fn2NoCLwj0tGnFkaUdE0OA6vpefu5vUeDEgzfONAcTo+ASBk7A6oIJpE4F4rRXOyg2RDA0c3RrUw+23HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2VeiSE+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724f0f6300aso456437b3a.2;
        Wed, 04 Dec 2024 16:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359248; x=1733964048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0t/W1hlV7cvper6FsrFCx1e0KVtudw1c2F0t95m3C0=;
        b=S2VeiSE+SDZUebVR8lDYbg4s4C+g66P6kLtNKdbzHVcpkWSiVnQ9F6+rW2AG7P0aam
         Ltxd7Iz+6Z+U3IHQXtv/gIQrLgy8RbVjH3rnqFXrphAWGZXHDjQ6D/F71Kj6nXy0+3Sl
         P+hwGN9eh/4uBkp5LmkrtAX+cuJGfcG46iwwZRcuFRWB8EXElMeFD6uP3V5J6IsVojcq
         PKLnb3tPOHhoTxatKvA1Maqt7fTcT7Yq6EWVhyqWNfbFsnQK38KV0Jm//aC9MUWpnYOi
         e0q/wel0JKgpFbEdx7viOEwJYbbP9n0UljrUQR5XBJ0c3Dc1D8TI0S3ka/iM64gDDWDT
         w5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359248; x=1733964048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0t/W1hlV7cvper6FsrFCx1e0KVtudw1c2F0t95m3C0=;
        b=KeHCeccwHSOlNUNfVvjeXn+5TUubAghZQt7PqA8hy12XiTn/QEhVpka5cNS4dhoJ8Y
         l9ifCkzOOX+8ZEKl8XZgxIBMOdiXErfwNZVoOLjLTs5ZxNwYiWNvNBINzqCKVpE7S1LB
         qh27sQcbN5ypIJMCM9XZqRoXeeTCkNGVLXfISA52aHkGhEex/gpc2e1tY5f2M82I6pKC
         vxMm06sBfe6lQpuxPdzOVxT0vuCXEh3dV0qtMcdtZeIQWScjy4xeJqmLBF+hqDshJbnW
         nTn9cyU8FQlmozJV8uJguf69t2e9rsDB3I5WB7bdUzYjWLFt/8uTEru/d2sOIXfeF2zz
         cJSA==
X-Forwarded-Encrypted: i=1; AJvYcCV23/ZSxLq2TaX1leHhBhFB15inKuakgV71e6WwIA2i1bbiJCh9goqc9qWpaErwcUYxMGjp+F+gVlPPzD4=@vger.kernel.org, AJvYcCXYFza+AOxsrT6kLltUMi8w+l86NM6hv3P2DPcDCfIGvern4DAycij+tde6jJQ1szywansCQNo0kM/HprQnLm2f2IW1DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAw32Pt+kATkCOACPBsIlwiUizJeczZ4V2IRgC7rehaVBuJ6y
	ifCyfwW0ZdVJVB+jA0pXmF/8ub8KY/YpVE3TLu9pXVdw/PTQclP8
X-Gm-Gg: ASbGncsc9Nf5rUOpEEVKSHFeUIJmHLAU3S7vJ4rjmsV5cSCnHI7te6KaRUAGVocW73B
	T1UFevaX3u5c2y8igapL6nFjTVo4A5M8A0DnAyW2+s5LfnHnGHt4A68Ot262mTrCaU8c/fdbruf
	vTs89NBlYTq6AZ/g8f1WX+vZ0QHuuZQCeb4AsYaoQfTkBrPZ6jsVwWKshfWlhOekNAk6cY7zAMo
	OtvYWBQjGCfmfis1Rs6h+gvu4xORL3yxPW4zrYvUAmUPiMyTjVh5z1Kd/0V935wTnV/uVTNA4Z9
	WU0OpFM6fFdSw+HsYYg=
X-Google-Smtp-Source: AGHT+IEDFvqC395HWoYIlU7UqoUVGWpXGJ1nTH0OWh/4JFA6a2gVPJex9Pl8pZYd31foDETfkKCiBw==
X-Received: by 2002:a05:6a00:3c88:b0:725:973f:9d53 with SMTP id d2e1a72fcca58-725973fa0b5mr3891300b3a.15.1733359247613;
        Wed, 04 Dec 2024 16:40:47 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5719sm104068b3a.27.2024.12.04.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:40:47 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 06/21] alienware-wmi: Add state container and alienfx_probe()
Date: Wed,  4 Dec 2024 21:40:38 -0300
Message-ID: <20241205004037.2185104-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a state container and initialize it on the new alienfx_probe().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index fa7bbbb07b86..ea848937b579 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -409,6 +409,14 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+struct alienfx_priv {
+	struct platform_device *pdev;
+	struct led_classdev global_led;
+	struct color_platform colors[4];
+	u8 global_brightness;
+	u8 lighting_control_state;
+};
+
 static struct platform_device *platform_device;
 static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
@@ -1121,6 +1129,32 @@ static void remove_thermal_profile(void)
 /*
  * Platform Driver
  */
+static int alienfx_probe(struct platform_device *pdev)
+{
+	struct alienfx_priv *priv;
+	struct led_classdev *leds;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	platform_set_drvdata(pdev, priv);
+
+	priv->pdev = pdev;
+
+	if (interface == WMAX)
+		priv->lighting_control_state = WMAX_RUNNING;
+	else if (interface == LEGACY)
+		priv->lighting_control_state = LEGACY_RUNNING;
+
+	leds = &priv->global_led;
+	leds->name = "alienware::global_brightness";
+	leds->brightness_set = global_led_set;
+	leds->brightness_get = global_led_get;
+	leds->max_brightness = 0x0F;
+
+	priv->global_brightness = priv->global_led.max_brightness;
+
+	return 0;
+}
+
 static const struct attribute_group *alienfx_groups[] = {
 	&zone_attribute_group,
 	&hdmi_attribute_group,
@@ -1134,6 +1168,7 @@ static struct platform_driver platform_driver = {
 		.name = "alienware-wmi",
 		.dev_groups = alienfx_groups,
 	},
+	.probe = alienfx_probe,
 };
 
 static int __init alienware_wmi_init(void)
-- 
2.47.1


