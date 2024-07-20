Return-Path: <linux-kernel+bounces-257988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44969381CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090821C210B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AB13D626;
	Sat, 20 Jul 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1hK7tJV"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685B3209;
	Sat, 20 Jul 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721489094; cv=none; b=Hu508zGIC23G1sOSbZj8JsUA9QnSP7gsGqo5zl9F42nRIacrt8E+tIqdKKscdLNtoJ/4w8ahvVy2IEFu7XIENP2tGZiWg176H+mQJZrtXL1Q5WEMjHADuk2iackUYGkzu0nae6ngNxUzqfD9LA24ikcf6W+VjfjXmLYsZVkZNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721489094; c=relaxed/simple;
	bh=0VOLU6r2loi8im6TEqHcJqNsE6n0wRDa0+UEkQmBJVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T1mToj7/Yov6aKldrFEMXfLY6HthkoEqLdA36BjISLYH30RUKvM7cWonQHFXc2YRQwjNKPE917AZej0MksICzhmLWGjTPBvxSZiTpc8lg9XRcPGMH4I7Z+kN+b745+ChE1ila9NwDe2AwDs7Kyk1bP7hYLi/5xGHXrdPnbNdZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1hK7tJV; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f50c673e83so213815e0c.0;
        Sat, 20 Jul 2024 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721489091; x=1722093891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8osbSZg73lAy8WNvoIihU4URXnwiHP8pcZuvQ5WSFoI=;
        b=F1hK7tJV/v2kaqASfYCOvQ4Isz/wvLSc0HxoHRV5X2psuIk38+GEfzsDJ7wkjWRTGO
         UhX/J2112QxngDjTFFCDab5NlcKel7Urct21NWXkxzxSplMyGTKP7oLwJHzVboGDxA8i
         c32aQBuVNARwxq+fOhI0Kt4GATYwEcqqaEAJlgBODufoYr3f4X9+1xqcjxghz965e6EI
         ZYYl3a3uEzZ0r4zyT2WVymKu3oAnhSInS7OufFf/HN2tA1c68hpLBZJRpmb4wQccd7em
         pXv8mV/6vnmbLja6DY4sWixz85ZVVEcXp9yBZp2G2NVLNydjqkqEL/YLMiNkkLvalXMk
         4lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721489091; x=1722093891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8osbSZg73lAy8WNvoIihU4URXnwiHP8pcZuvQ5WSFoI=;
        b=aVrJ+VToqMndAL0LZjkfaE4O+4qwAIw9rLjalSQQ52Das81scXLndlpZZV/s6Ol8gi
         bHjAuOIF8K0to/Z5FwiITAPPRqu03v+c2FxYpVdpT10FIJ3q0MiEHN+k1pmeQJBZOORq
         iCGCa4KZyIMAQK8JwIa8YjhXg65ywV2GbqhEd9yjK+hDiqqtZmaDsk053uK3UxI9Fxw+
         81rMVZgJP6Bv10nOC/4Ph0J6FYLOto2pmnsrV5y559QP6o/+vnbJa25HnfcwWBEckxZX
         VEXBPjZtbkobUnL7m9pNpw7F5mScLYmqit0Kl51FJYrNZoijs/diU1Ghnwzdi8m34XfU
         R4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ijgYl/irNP70uRv1YuVjYHf02HEDDKPGskZcr+I1430FDs5qK1TF4B2sM7BAcKwRhN12x3F8e2z+/RHbBX6WGZXOwjqfvjEhTl6wbVhDTcfdmlJJZxcOF0ta8isUkwe6hsSjMb0d
X-Gm-Message-State: AOJu0Yz6z634XCHLs24X5mBzczyMRTw1Vtik4yZ/vg75tSDBNLalaFcV
	NRupFyjCkf25JLFT1XXRiHKnUKF1VD3IvW73nRMoTvpvtU6Pv1Uw
X-Google-Smtp-Source: AGHT+IE5qce1dP74DEvxlnbA/wXSVRH18ghJgKGymPHSetCqpKn2eWfsdoUVoACITCbnQbq4Lafm5A==
X-Received: by 2002:a05:6122:46a0:b0:4ed:682:7496 with SMTP id 71dfb90a1353d-4f50683459fmr3261159e0c.12.1721489091368;
        Sat, 20 Jul 2024 08:24:51 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f4f9e85882sm444091e0c.28.2024.07.20.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 08:24:51 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: david@lechnology.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Hunter <david.hunter.linux@gmail.com>,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] da8xx-cfgchip.c: replace of_node_put with __free improves cleanup
Date: Sat, 20 Jul 2024 11:24:47 -0400
Message-Id: <20240720152447.311442-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of the __free function allows the cleanup to be based on scope
instead of on another function called later. This makes the cleanup
automatic and less susceptible to errors later.

This code was compiled without errors or warnings.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 drivers/clk/davinci/da8xx-cfgchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index ad2d0df43dc6..5ea0c072bfbe 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -749,11 +749,9 @@ static int da8xx_cfgchip_probe(struct platform_device *pdev)
 
 	clk_init = device_get_match_data(dev);
 	if (clk_init) {
-		struct device_node *parent;
+		struct device_node *parent __free(device_node) = of_get_parent(dev->of_node);
 
-		parent = of_get_parent(dev->of_node);
 		regmap = syscon_node_to_regmap(parent);
-		of_node_put(parent);
 	} else if (pdev->id_entry && pdata) {
 		clk_init = (void *)pdev->id_entry->driver_data;
 		regmap = pdata->cfgchip;
-- 
2.34.1


