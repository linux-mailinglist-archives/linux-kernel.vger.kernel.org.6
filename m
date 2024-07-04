Return-Path: <linux-kernel+bounces-240541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD7926E95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6738EB23683
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1224AEC6;
	Thu,  4 Jul 2024 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Mro+f5Tw"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415044C7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720068635; cv=none; b=fFapODbxaD6gmV4Ka5/jeRAHwig9Q7o3Poyedp/NWD3M32SYP9D2T3UaVCZeEHlRb6w7EvgZSzK78DFrdoy6dkZauqeoe6iQKCS3sZreuByj3mH/XVhEXjiq2SL5wTBtdefO3KKK2XNE6t7gPoYtayPejfsuAfRw/eqsbA49410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720068635; c=relaxed/simple;
	bh=fhnljkER/rKLYYjAYG0JmZE2KxKUuMBrGF5Jyu106aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLVi1Waf5u+5a3lcN6hnpO9bmFa7iKbu168o/318OSgEscwj1GRTeZblsFnI6Cgjs6KxTT4kvJKc6jIdgV1CHtRL94pBdlP8jSM5WNqMySKjp/Y99Nw6J59qI4jtUG1J4wpwV2hh4ML1P/fR1bFf3IQmL8+ad/spnxDIkXpbK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Mro+f5Tw; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6519528f44fso2215957b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720068633; x=1720673433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsBn5YIFgQujACGaG7/CDDGw57w//+UBPY3qWDxgZNw=;
        b=Mro+f5TwZC7uZUc5wAV0V7gjLMQdccZlKPowVkC5NxftLjQijeSQ2OH2vgYg7aF7x9
         OXIH2qs+3kkZlh2bEwDZKAojfjxrSso0aCtCS3fjBa2K26xEwQnci7/AD3pzjrM5DXa4
         OrS3eELRJGEGHR7g+R3NDrTUsHQiCYdtngTAlNtCx5WPlQWWaLFCuukDe617op51F0kS
         R5mkttewdSQDccFzxjhMCIQLcEZhfAQ/FxXRTWLGynjMSEzGveJP8+xZz+53n1VccHZR
         pqhnkhWIaZUwX+z3iHkV/JBgXD/qNrYsleADxvFFWvq/59kfp9dYTWb5mMspd0jjcZXG
         F7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720068633; x=1720673433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsBn5YIFgQujACGaG7/CDDGw57w//+UBPY3qWDxgZNw=;
        b=pUuJxezdFKGd6C4Wmy8PhndtpK8whh6yKzsmYFm1uqSRHpRvaOlXwQ5DT/RuWJjYRj
         ooGsIdHgUkqdlwLoXSH0wRXzG53i651kUDhVdiSO7ZMNzYJkgT8ORAeCoTIUSz5OMjj7
         der9dehEO4Qh6jR+P0v0hob+boGAdJglXDEeFyp+0eb2HzHsF/6SVIQnqW8eAJY9C/89
         QAPg55Crprhp4CENj0NcezoJi04Em5SfLM3ZQmsLaPsrGkN6/+H24TuNZKjFuAt1FyC/
         VBbOyPNAoMpulOnGKRMnPdkE/Z8mahniQYJ9knyERnnUjhJkYzyR8n5tG0DH50T0yqOi
         M1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXDio4KmEx9+aa0DjmmFBzP2enKIQTiz8gD7Ipdz2A/ps9md7Vc/6V6B00Ux/ZaeKneGGTJ1P8jdmPeD1ia3AwDmVRzmoTbNM34PyTX
X-Gm-Message-State: AOJu0Yz6xoPsxxVazHAc9arvgeyDa6htPNFBG+ftzYPOJOlMr33yKO8f
	G0zmdzDZIV8lvd08WQ1iA3RBg8u0l0P6fqFxQarTlxvvmCw8TGJ5iJ9TS6YyhfA=
X-Google-Smtp-Source: AGHT+IGwWXLEPd6j1SIUqzU+gfofpiqClC0+U9lppd9lNrJyoW9Y+Q7h2ChaL82zLrx8UHmV9t1tHg==
X-Received: by 2002:a05:690c:45c5:b0:61e:a26:c1b2 with SMTP id 00721157ae682-652d767d0a7mr7287207b3.17.1720068633205;
        Wed, 03 Jul 2024 21:50:33 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8ec1asm11291826b3a.188.2024.07.03.21.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 21:50:32 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	swboyd@chromium.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: display: panel: Add compatible for melfas lmfbx101117480
Date: Thu,  4 Jul 2024 12:50:15 +0800
Message-Id: <20240704045017.2781991-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Melfas lmfbx101117480 is a 10.1" WXGA TFT LCD panel with jadard-jd9365da
controller. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index 3d5bede98cf1..b8783eba3ddc 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - chongzhou,cz101b4001
           - kingdisplay,kd101ne3-40ti
+          - melfas,lmfbx101117480
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
       - const: jadard,jd9365da-h3
-- 
2.25.1


