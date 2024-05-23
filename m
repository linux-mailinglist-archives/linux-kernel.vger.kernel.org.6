Return-Path: <linux-kernel+bounces-187507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B388CD2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454241F22F12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965EB14EC64;
	Thu, 23 May 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+cqyRPw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70714D712
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468578; cv=none; b=Qb/dY0EW8GYsfTYBgfy8JRyb56G93Z/QzaqYsAuAVKrqTAxF4H8J3hR/lKqWXkdrSHJJ04nuNIm3S+TWOhAmxXMWZEbf7zRCWrzMZQUH9//5PX04/1VaxnMhHSY58qcBwu8g/bFgLFufBUJroPWUTg3GLu3nmccyX9aHRVnTSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468578; c=relaxed/simple;
	bh=ofsgAkx0Hd1eRdaHM58268obvfR9196ltfSHKJAspXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLk8gH9+jF8FcsBh4B11sNApyWno0F2b3XQKrlbR9vix3V/lySD3jkqHzyrqfrOM55q1DIeKrcth4vQ+0O2m+jwJcYUZ9Yw9gQ3gevCstyqvbPivbGRapuiPvk/x6znPH3H42Z5RZ1uzEDnSOSuUQ09xgyYas6Ehe2qbtwh7fR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+cqyRPw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so1001209f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468575; x=1717073375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaynX4CLsc9MHihMomyw8yza7pwT0BGnTWcRWzqsy6w=;
        b=c+cqyRPw8Vi45+NGxoYrYyheBjZCf2hhfFbTQT9D7tDGRXxP2umaelrPVOOHmxyS6v
         jYTUp7mH45q5x+h5Bswhd93MdHDE9RyxxnVVHb/I88klPPwCUjIflFXKIEZ13XXZqVDB
         tslbpwh2D8IctHn3rzCNmH44jlO2Cb6kfGko2BaWsZM/sM/uqZa/2YT/W5pj7TPebns4
         3HL2V3Nt1+tYT0zZvt2E8UX8bPHX0bUJA1piBSY5CAuTYxKvpHujco1bWOBUJ4gpEgqB
         DVT1w4AWx/PtFW46Cbp/9CRx4BbJwOPnkZabVMJnjY1Rnknu7zOUE0lmn/2wamVB1Jyw
         b/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468575; x=1717073375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaynX4CLsc9MHihMomyw8yza7pwT0BGnTWcRWzqsy6w=;
        b=fiXG8GcSms1a83lOiqiFu0YHFj0MJaSC6l6MMrMUJUEawwkslc1DAWMv7ByKxq16xi
         AZN/rKSuje0gC5aNlSVBZ/4kXgmICXlHBxfzFa/QaQfX15bMkI6Z20oH5h3MYa2vCyUh
         /rcaLVfJKoYrLrY25tfFheh+eGdhIawVW06i4dQugqI3BUie4Q+ucknlgy6/588Kx4UU
         JovPlT0vNste4LWYOhR3CDhw8+ByAaUpIEGlTuygqffQu8sMpm90ICy15otU/0t46K2D
         tGU9Ry4B8Z9WJiN9/0hdQeJDpUwud1bWR228LgeQ6r9y2IMFrcMgLTbMQlBNAIUqGuGB
         TAiA==
X-Forwarded-Encrypted: i=1; AJvYcCUG5vq1FpZ6rp32+HRPk1hq+dECWoMyG61Mhya2OaRYGWY8EGTgpmBBR8P9gyFtSVEA4yu4HnP9N0t/FeBxfZaXN62NqGr3ZNmkRdVc
X-Gm-Message-State: AOJu0YwVUSLqHP2iE4o045RBDjVNKxGf3L+ij3eEgYQG3pBe+nw5CI66
	Baw3+DAeyrv+GTn9jTz4xUgItmI43Fsk93qDU7WVlUzFc/kUOzekRxztIoDM9GQ=
X-Google-Smtp-Source: AGHT+IHrxKVIn+Ah4T60PhRTqB3+VWnYaiGrW6bwaLsVu7Mv9Ph1QZoghW7iJVxfZBri7m2KYPvfcA==
X-Received: by 2002:adf:a456:0:b0:354:eb35:a02a with SMTP id ffacd0b85a97d-354eb35a23bmr2884242f8f.70.1716468575603;
        Thu, 23 May 2024 05:49:35 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:35 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:20 +0200
Subject: [PATCH v4 07/15] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-7-ed82eb168fb1@baylibre.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ofsgAkx0Hd1eRdaHM58268obvfR9196ltfSHKJAspXE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTCd5N4Za7TkELJ09Q0aesgnC7TN8Qoc+T5A0V
 knVQ1uKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURTLbD/
 91F9gMAuFOYgmF+MAGvE/cY6jranhCAPq8fzGOEdtuqzJ0p7AOpHHhHXC/kZ+OIZabzd3pf02nCIOn
 XfCymikLALbvweG6G5T5fM0OQkbYANV3defBGV6hFEMjjh5+LZNLSiofRDeGELdRtHc1HtMC2OESWU
 rDVqy8dLnMYO3MdwpHahhTpT/KAkgOR5uGW6TxFpzYJsNjqPPObt6YadpJiH/RoEY8SgrQ5yI1wlro
 EpO80JbZqdH9bDyMVh+NxuN22stpZSh9E1ag3pBuAxW6O7/kVG6nvcsQz84BkZH4H4dZ5xAbziAFBo
 zqe4BxJnDoqiq3iDkE9yC5+pa+1W11RCh8o833mRoz7++dYlU7mmP7kxT24M7OxnReGfOUl+uoJv3g
 lZuVZvMtv1j/eg6pPRSKC+lkXo5esu+YST/8MJ+fhPW/9GdgzQ+ZJDtcMlyjH8MjwrIW9b7UBoHEAC
 UOaZvloM4OTolWKfTSswUU4PCvUhvz4WcOOAX4CLj3PzO6KPNjMawmZJcpAGMCV8Of+ouSJo5jAoP3
 XFpQuf5bzMOMrHSwFfe/uXvejPpv5LTWaKFO99pcG+Y52JYDWO1mZvrDJltWEsY6XSZGPe+O2AtMh4
 eXpg6UyLhdqHp72CcnTYXFaKbknfZkhCtEoFjXk5X1wmbLUl95NOMErcdEtA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add dt-binding documentation of dpi for MediaTek MT8365 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 169d054d81ff..21b93f356901 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -31,6 +31,10 @@ properties:
           - enum:
               - mediatek,mt6795-dpi
           - const: mediatek,mt8183-dpi
+      - items:
+          - enum:
+              - mediatek,mt8365-dpi
+          - const: mediatek,mt8192-dpi
 
   reg:
     maxItems: 1

-- 
2.25.1


