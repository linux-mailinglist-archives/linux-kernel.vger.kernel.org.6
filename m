Return-Path: <linux-kernel+bounces-222541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569F910373
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05631F235FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FD15E5C4;
	Thu, 20 Jun 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="hySU/xsc"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A241AC234
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884384; cv=none; b=H3mhuW8ZkJoZhXlVD74EtYxdmBkFQRQXOlbu2gDOz5LdQmFWomNvlqcGkQcrz7yjSiQsZQhGi6ZJnmfQ6SzSB0jjqTvgiEyMIXvG3DvnNIuGzpyUEPTl4WLxc9ft6BtO2y2NEwIoOV+CaEPlK+MYN3m0ccgoGxq0ec1BTwgtUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884384; c=relaxed/simple;
	bh=cn33yzbuHsD4XHvHkWif+lhgLxTCLFn5SfcYDICYlcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xuy3BbT1NhNJPBeev9T0HnsBV20HuCgi/R8tVeZcy4rEVebGgUPPqM+jJntkmqnjeM6t6GTo+rtCsWQE+VT5rhkBHuWdFVnh37GEdIfE/xYmUAQFbpNKWJ/8y+EnckLZAWSC+kyQezXeTyPx+83hE86zik9eo0R2pJlL7N2WNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=hySU/xsc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c348a263easo1382722a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718884382; x=1719489182; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZOfcyLKgj+yv+ED942rapRmAvPkDAxODQtfckKPepA=;
        b=hySU/xsclDHcauoHn/mGk66dWx0JrhrJxOBBLG9Egk0u8qTM+k5ks+90XF4hRwmZWF
         vww+5jMnF9nuuF+mSua3Bzkr3eFeZFdaFiWq9u+Ivb9VzCv0cdQs78PgAC1A5LAOBxJT
         NyLijmpArBN1S7NXTER4gz5l4DsMpebx44T/5ydoJOqJQqLRIJDHDkwRB/uwaRLJIhjQ
         D3fWDmIc/k76uRIEIeCyo1Z2O/aGkhQV+/AgKlS7FWTKtbasEMROmcx7ozEW7F/J+fob
         HBaCgRkfc0s8MJDluDJSEYHhM8ZXWCu9Znpe1CGqPtUVHHMgm82bxznz4OTpSJnVIcU5
         a31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884382; x=1719489182;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZOfcyLKgj+yv+ED942rapRmAvPkDAxODQtfckKPepA=;
        b=hyVejhpMFnFhgJy1po/5W5Zgyc7/5xAWhWJwEK/L1hqFElG7FfEK3mVJ7AJSyudTKw
         k7I0mXF13XkR7givlsq3dI7zVjEDVjzQUFEQty0zzbsUKSSLEu31HisbDBq6sr2K5Y0c
         Xj2OQC2YMM9LovBLKjzd9t4cXukSisZiSUr3PWPNwCiBNkyIE+R0CsZopeJzOe7eyDFt
         Y/T2cLWgF5MeU/Ce6aqriSFX8ir3p5/chFHak/tB/XSUJyzkLeq3AXRtzh2zD7Dn3u27
         vvHTBN0w0oGnaqEmM8HmuXMLPIpWbmH6ZiFs5LU2oWoSkt7+BM1rTDxOaFwLaQEN1WhT
         cHMw==
X-Forwarded-Encrypted: i=1; AJvYcCX1f+TquZ+zW8m5f8l9jcBoF7AzfGXVaACOonNc7RJUw2f8UXIVlpXO6c11VQfJtLy9E6OT8qsUZHZFhwj8TN1a7h/9hQF3KO8MzJ7H
X-Gm-Message-State: AOJu0Ywllio7uY44aVsEyxlNFdGiMAuHyHKvjyj85DVDIF9akJsNIJMc
	Sv1Hv4fBLyr0mCwaOtwJGu9hecX0ww7jjIG3SUMfkpYU+ZJN8drSDX8VdYR0FkY=
X-Google-Smtp-Source: AGHT+IGMNnTgKPsfl8aIi5r8uzi6bXKkR5QprrMn7nZuUrBC67TYRolWeSqdoOUgVCP9/FJ/JCF9Jg==
X-Received: by 2002:a17:90a:69a4:b0:2c7:45a:d237 with SMTP id 98e67ed59e1d1-2c7b3b0eab9mr7321636a91.12.1718884382279;
        Thu, 20 Jun 2024 04:53:02 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e64a1da9sm1486316a91.53.2024.06.20.04.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:53:01 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel-simple-dsi: add Starry-er88577 DSI panel bindings
Date: Thu, 20 Jun 2024 19:52:44 +0800
Message-Id: <20240620115245.31540-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This add the bindings for the 1280x800 TFT LCD Starry-er88577 DSI panel
to panel-simple-dsi.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V4 and V3:
-  1. Move positions to keep the list sorted.

v3: https://lore.kernel.org/all/20240614145609.25432-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Separate the Starry bindings from kingdisplay, and add it to panel-simple-dsi.yaml

v2: https://lore.kernel.org/all/20240601084528.22502-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Add compatible for Starry er88577 in Kingdisplay kd101ne3 dt-bindings.

---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index db5acd2807ed..f67059d44bde 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -58,6 +58,8 @@ properties:
       - samsung,s6e3fc2x01
         # Samsung sofef00 1080x2280 AMOLED panel
       - samsung,sofef00
+        # The Starry-er88577 is a 10.1" WXGA TFT-LCD panel
+      - starry,er88577
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
 
-- 
2.17.1


