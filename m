Return-Path: <linux-kernel+bounces-229061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E71916A52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991C7B25E39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AE16C686;
	Tue, 25 Jun 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zmBgx1tw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272016C684
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325580; cv=none; b=oD8k5u53eKeFB84S4PTtSx4tuOB3XtSmJylLc+yAM/GvObaFtk+7vtaQF5dotqIv9Ggq31wb6YBcN7yt8G3iN5oUOc+/fqTZufx3GMOp5GZouacMiyclQ2AkeYyuIS4cDlicEyZvfBB2KQzZKeDZAhxW2HWrjb30bN56IOFABqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325580; c=relaxed/simple;
	bh=UBAehqCBvC3J8tMyhcNUF54AEy0mIS8da+jiNg/1Zw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtB1ptDSqbS/gq+Tu1xMb/bexIPPZLAluNApyNDKdLMlvDxelGVtw08tT/DWA1eTsn9gub0g3IC3/xXX/wtb79emAQlW+qwFeL9muhow5+sN9JjRzbaXhz2WCfFh+rTmip8iejuOiQm1FjU4qWqdxxWC6ZHefjcgmVloNf34zQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zmBgx1tw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso39420355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719325577; x=1719930377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV4CE0/NkRPUyACNkq6PofDWaP+2ii4ghj22mjGmlA8=;
        b=zmBgx1twI6ra8tu4yrY4ezFDG/cuaLjFpT7eANn7gtJCFrzAqcAUoExU6HKa7YcSKw
         IxXlJanOQRFEMV4Oa4InenYkns97xm+xdf8x8/ZZfkLSTYva4tpCXLRtSa75lI3pv94Y
         ZiIicjTUwZEKud+VEHkfaI+OzcTObYyQPaIosid6ruuf45DiMQVrqQ2o4TCZDRbd37q/
         cP55Sj/AYBTlQnlwkLe7NuHZ36w++PUzeJ/Iat4WX2t15h5eJ5NugFoWHJyMSMSkF3tw
         mSrxRcr2pjBdS3oTOs4nfBdtMJxbDJTRUqze9yTqhlibn2XD2sko7GHDxS2WozO5dpr8
         ChUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325577; x=1719930377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV4CE0/NkRPUyACNkq6PofDWaP+2ii4ghj22mjGmlA8=;
        b=r6wLbQV5t97keS0Elxzp/ItyYPeQzsgdV7fW+FMQeJWdxZEwrFM/9B6ebM+OemJVeE
         7kaBz/JcyZbE1lXSO3yQiEGpTMLo0CaeGsMW3XCP02i2A1eqcyelD4mUQ8ILvizrUauI
         vDugqHWrAjEHy7b8jLvJjs+9+Hrgr9rTCppItxcRk8VZBMUmQGsHus+3A2dPNs5qoztv
         4J5GtEl5E1JA4WglffpoKn/rWtan7zCVUKgfAMwObEb6SrUMFik75GzPvzRksHi7cL0E
         cS/6GmPZEKUxk0zFKRTo5WEi41eGhkZGqkBYDWdZYIt/PgEhFGjTaT1C2JPSm2wBCiS+
         vL/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbdDAEI9l6lMyTiwxlOpknGt/X76dbmmxN76PMDCGLG3MeNuUXT+RRV9id6vtOC77hSbHLncnmDJ7dGYC+YVHgfgr1Wigj29CVtzF3
X-Gm-Message-State: AOJu0Yzowev3IK+EP4V0At0TsUwK89crRRoKcKxpylFSQRlmS6h4nxBD
	8Thfzr+NcGKTxWWuUD3iv/1XxVaYdHfpv0kwa/Eh9kWSuKnXOfa0cAh4Ew0awqY=
X-Google-Smtp-Source: AGHT+IEVtt66qRDBgXfqzQWK/I+SwGGKWIhnesSejwYHsrjo/RZj+BSNt+XAKeYLuJg9PnW2qsOOIQ==
X-Received: by 2002:adf:f806:0:b0:362:56c2:adb4 with SMTP id ffacd0b85a97d-366e3294403mr7027132f8f.18.1719325577668;
        Tue, 25 Jun 2024 07:26:17 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm213770685e9.46.2024.06.25.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:26:17 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add prefix for lincoln
Date: Tue, 25 Jun 2024 16:25:48 +0200
Message-ID: <20240625142552.1000988-2-jbrunet@baylibre.com>
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

Lincoln Technology Solutions is a design services and LCD integration
company

Link: https://lincolntechsolutions.com/
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..dc7edf8c33c1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -820,6 +820,8 @@ patternProperties:
     description: Lichee Pi
   "^linaro,.*":
     description: Linaro Limited
+  "^lincoln,.*":
+    description: Lincoln Technology Solutions
   "^lineartechnology,.*":
     description: Linear Technology
   "^linksprite,.*":
-- 
2.43.0


