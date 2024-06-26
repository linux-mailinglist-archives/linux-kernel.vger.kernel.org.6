Return-Path: <linux-kernel+bounces-230926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8959183DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A73B23C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB847185091;
	Wed, 26 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zj9hJnTJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA2185090
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411755; cv=none; b=MjAt8Yb4hrCTZsS10YJ92I0ueKQfjaoe1/jGV5Plt3D0iVdD1CjQj5e+h6BCXim1mYNEqhY+Q2F1po+v8Ifnnn6XeXJPUzxor1ilz7nH/MoeFMzocDcaktXvJll07Qso8ddbh1/Fth1GswzqxDJ0aMsgsubB1/xeMdx8Mod9/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411755; c=relaxed/simple;
	bh=5HrqjCRmHr4XZRjBZJ7uKfrQ2XERtmB9cF8mR7toIbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErpwO032OZS0kthWXqpp/CIbB5zzovykR7rF3hEd45Cn/bcwxgkdEbc38YjTfML/TZw2hCFnQBHWdvUlWcGuw9SuuzR3Ptl4ALytS+PeRliXcoUYVZ0wBJqoX93JKtO7qdVu7NJzoDSVUq4QUz6Sm3ZCVqFu+HdC81OtwFIqJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zj9hJnTJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso83043801fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719411751; x=1720016551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5oTyiTDE2zoIXFxITRpatG4bTgLxE9dmxO/uASRAFU=;
        b=Zj9hJnTJPhykEjd3U/CPP54ZOkIGOgqipr7/lXc9ipK7xC/eMY1ZwK80m+m0sd2UEv
         yVOKB9OEbj4qPydlfQn29BE4D2U5bU6guACassa0Y3kOGmXJ2EMg6oalGwQUHjpUn2Sa
         KCGSiU2qV8rvKhQ+PVDZEe85sq57j6enSSdSp5SVS7sBC3JoFq/zd8TJs5Fc8tZOAM3N
         3gwMXGmqZ5egCVX83C99GgTf22JE6Af4U5mPA735bgiPmWdeeMZSPoCFxOZME1XuZhTt
         2jfXE9HjBxqxujs8MmiEleXeKnund3MWpSwyG8RKS1bAieT5dVYM8qOS7TIudz2pl+LU
         bDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411751; x=1720016551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5oTyiTDE2zoIXFxITRpatG4bTgLxE9dmxO/uASRAFU=;
        b=g43hCId6Ons2WsGRwfFkyPO7qL+QE2nY5oRUD+T+CzPTX4STRxOoAzaZnpGYufmJVM
         r4/vpGC7nNg6LSvIvZI+ospVOP5K1duQbUF0nk/oMfqmZWU91sdfQi/ijT6emv84wfG+
         uKuWcC0DwHA++2VaJSGrsiKSbIbRHmxrtwIItyYvX0krGtYEZwXTxtFXrLpoEyQENsAN
         3anV88eV6ZvcdgHGpBngaUv233Qk+Kzb5UpVQM/5g5yP/b6xAF4m/2FX+E+wa07HvoVr
         O7owntAN01Wjf1sj/TvePrJPdQRNGIKg+SKjwUjkAEfbV4Qe8oPqJVoDGSOw1PVbqwv0
         Q2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Bseh8wDSGT9I+sejnnyZypyAHNEa3EWjvCT+LpUMz5XucsENLdNTxZZPd489K0Wcck+wRUvX2VkuVP4f7KYxpW2whCmB+rnDcdiw
X-Gm-Message-State: AOJu0YxjBKlnC5RJYBs5ZMjT0y180Xcibm1pkSefTa6bas2odA+BCHsL
	bwx59wGY9muxbPlxa+X55M2JluDq01zmf7sPYQNZxK/3wKzpRRWXel+Ym2rToBw=
X-Google-Smtp-Source: AGHT+IGYquuMgMSS+n+tk71AQ/4ysAbKByUybNfZEzAp4mLOcPd1ahbXpUz6gx3baLFJyiijvhFKpg==
X-Received: by 2002:a05:6512:402a:b0:52c:e184:3dd6 with SMTP id 2adb3069b0e04-52ce1843fe7mr9156435e87.0.1719411751338;
        Wed, 26 Jun 2024 07:22:31 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:7be7:aef1:af9e:fff6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm27141105e9.5.2024.06.26.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:22:31 -0700 (PDT)
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
	dri-devel@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: panel-simple-dsi: add lincoln LCD197 panel bindings
Date: Wed, 26 Jun 2024 16:22:07 +0200
Message-ID: <20240626142212.1341556-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626142212.1341556-1-jbrunet@baylibre.com>
References: <20240626142212.1341556-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This adds the bindings for the 1080x1920 Lincoln LCD197 DSI panel to
panel-simple-dsi.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index db5acd2807ed..9b92a05791cc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -46,6 +46,8 @@ properties:
       - lg,ld070wx3-sl01
         # LG Corporation 5" HD TFT LCD panel
       - lg,lh500wx1-sd03
+        # Lincoln LCD197 5" 1080x1920 LCD panel
+      - lincolntech,lcd197
         # One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2587-53ts
         # Panasonic 10" WUXGA TFT LCD panel
-- 
2.43.0


