Return-Path: <linux-kernel+bounces-229062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF1916A54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8511F224FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E717836F;
	Tue, 25 Jun 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uxbt5+xH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0516C69F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325581; cv=none; b=axrDe81mE98g72Ntu1wFxr3GceQQdyi6B6reXeNrJyt6YcZuQXCqztratmYAqgzubC6hAI+gAEzKoLBjh1s1C0zwqkg4i821By4/q5QDJZ1S0gHjm+nlcrGfMmdE+AbB69p1B+cgcgOK2lScTTBHRzNfq7zyh/ImjXR9RKcufUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325581; c=relaxed/simple;
	bh=2cBrz2de0gcB1aHlARfS7e5e/KSZ86bKclvP4BkwcZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZjxrvmclGDO+EZYrzmcvk4m3CFe2aIFPvGE1CiQK/2rqPcqn+GrBobtzPk5hypNwSu7fOgowc5u4yJ7neOc89Tj986zzLS/Xxgp1XyuX+6lWIoRoCSHpdDM5RCxAyIDz/OLUl+BQmzdjOjGbyAgqdVa91M33W75YMtthFLrizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uxbt5+xH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so42297705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719325578; x=1719930378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAD3098J3EzQuO5AqXKA8113KZcxKdLVMyyReKa0K3o=;
        b=Uxbt5+xH3P2qiRLzwsK+CfSfWKRhzU27I8lFyvxc9efvYcd3zDT0sCuWObzVGT9Wr7
         eK02JLmSTYCTUtrn8AcG79RPPlQUvxwQRgdKs3MLVIgjlkfQh6KJn0mC5MUUFvC3H1Q8
         9e9Tf2T2rhNUMMxfeuTHGB7P7RnefguXgfvfIaEV8zF7x9CGUud4iWWNu8avIGTmEoA3
         QTZbjkNMlXL/kUGPdS3iOIhtiwXc+P5Ewtq2pRBW6lj2y44Vu+3iUZIk6ZfhkAU3pjJP
         UuFiB/ESTNcL3Wd3i9OdMY/7yVk42SVH89oxkugc+mB3/Ok0K05ofBBe6wPKFUJXAbXi
         gcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325578; x=1719930378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAD3098J3EzQuO5AqXKA8113KZcxKdLVMyyReKa0K3o=;
        b=cm+eXRhGUn2xnUBRr/0goDQE1kcBodOESrM9rY7aq/5dwtluO7Y7Qm0z6tazKdllF7
         Jx1u45QqUhyzNyHAgkaeIj/Iw3R8NIuFrLgXyBp9eNsxPeKRLbY1qaPcLK2YuExuz4Ub
         GOhmUxoekWCRuRJxGVCK4u4Ba2Ss/XJF+Gq8Sm3W7IFgr8wKnGv+TiCrwI//kkOBnbkR
         qn6WHtNj9BuzWgrF0N+LhzsbjXNGSUNcZBfErM6+QFRVZSuDR9EEz7IhpE3x8JVSDGX8
         dfOoFQGtMR0YRV6FYB5mfnDSvzXjTzp2Wquf134igQoIrHjJv1Q0VVU45+V2qReRhwZN
         O8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbi2atPUiOkdaCWHnUyAdPGgJsd2r9GmmH5kPStnyGc50WInAY1awu4yKqWVUfOqme6kOSEo5SfhcyXhMW9+/cC73CX2qfs68sriq7
X-Gm-Message-State: AOJu0Yz4dFJxwTXUnDBQUUE6aIqXDwCM/pnjHKGy5fcUOKWqtdvlQnBN
	9QwAs6Ly5bGPVE+EG4V0NB7FQTggxrAm1tZeek1YbnAdFN7ZE6eSk4DYWZuTcNg=
X-Google-Smtp-Source: AGHT+IG1q4iSygl5TwD5tzeuhb2bcowzEjKMap1C16ElCtkJc9TyfhLNJ/t2ktFHMWB8CX1cWxHEjA==
X-Received: by 2002:a05:600c:1c1f:b0:424:8e3a:d02e with SMTP id 5b1f17b1804b1-4248e3ad244mr57788745e9.3.1719325578527;
        Tue, 25 Jun 2024 07:26:18 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm213770685e9.46.2024.06.25.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:26:18 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] dt-bindings: panel-simple-dsi: add lincoln LCD197 panel bindings
Date: Tue, 25 Jun 2024 16:25:49 +0200
Message-ID: <20240625142552.1000988-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625142552.1000988-1-jbrunet@baylibre.com>
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This adds the bindings for the 1080x1920 Licoln LCD197 DSI panel to
panel-simple-dsi.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index db5acd2807ed..49e663dd267d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -46,6 +46,8 @@ properties:
       - lg,ld070wx3-sl01
         # LG Corporation 5" HD TFT LCD panel
       - lg,lh500wx1-sd03
+        # Lincoln LCD197 5" 1080x1920 LCD panel
+      - lincoln,lcd197
         # One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2587-53ts
         # Panasonic 10" WUXGA TFT LCD panel
-- 
2.43.0


