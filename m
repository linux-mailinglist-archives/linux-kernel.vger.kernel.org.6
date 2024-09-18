Return-Path: <linux-kernel+bounces-332822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1D397BF41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A975D2826F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751781C9DF7;
	Wed, 18 Sep 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBEIM030"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEE210EC;
	Wed, 18 Sep 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678226; cv=none; b=pE6Vbsu+sZwUvQTBX6VwYjNDuBUd/+Kt8WBq8KmVwDCAuhMWqAi3Mz6EDqLRPlexYhOsATG5+VuR5TP1cJ6suaNY+FOcinJIGBpoqgk98QVT89jF9vYjM0Z2rchiC4I2lQ0/BPaSzqYRH50Ypkb/PtqzjBnjgwJ7/J9z1FOabAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678226; c=relaxed/simple;
	bh=eWTRhppnSOMPx9KmBt2ybSuqaXc6q9HvmC7y3M5CTfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtLby/zQPtxGLctxF1AvGkIh04PThATv1DKUqxA7WpgvoTqhZRWxXcwGT4mfB8Sbu6sJvVKrR0d+AfNp5o3tjHMikUowQs93Z0DI5xd3OmKdk99kFwWwyV4Qj7e2nA0xxxTrAgmaJnBCz9xfwvpom8wURXMAlHA9ErZAleT79Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBEIM030; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20549ca1fe3so4048685ad.1;
        Wed, 18 Sep 2024 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726678225; x=1727283025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqTNSLFZ7PSrKudzN6DYiBhUjY8chO7f1kKqbO7sK/E=;
        b=HBEIM030z+6P2YYqNM1XA55/QChgyen+3uqOp9c0VJB8jgrrpIRAEaZye33CW0EdNW
         mBB0AuoVpB3MaxfGOUrvUmtqKRBTcJYdvTHBslSFl8xncyVUz9M+yA/rFoe9qNcbp1Ay
         t4X30JZKFdi7ZzqudYYVnzjVCXui8J0dLeNhzfULswIMSgh5Lnh0yEoYu1p/XpWeEQwM
         /GVsgdehS/N06Wknmy+jIv6XxOX4wSrrLCFEqQsu6X9Gr14bhjzmoPEawHaODBpkL8sa
         6azDarDVWJ4Do8ofJjbRaoVg0NjzcbbPWe7kPMprXx0/nbZnKrkfv5fY67jQhY3nEOuy
         HfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726678225; x=1727283025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqTNSLFZ7PSrKudzN6DYiBhUjY8chO7f1kKqbO7sK/E=;
        b=jIxMSMZkntF2lB4eMTUihYUNUam20zV4AW0/ycHDWmIjGH0utmk73jhRAjzyD3Qqzh
         eBfArBiNYUqkmRa9qxcs1ATTjI1pTkIlmwShlWdUL0dQ6xbObqUXf0fT0hTK781OBz2N
         v2dRtvMo8Pr/KWe8w7SQDxeaEUS0NuVIj/3VAW6LipZECfW9WEaVCqzd6GrkIhXVX7WY
         ou2ZvQvpZdMWZk4LyKMCya0G/vnEqi/8JQGs6nRU2Tng6bqH7V2pnmwI31r4sLiwWZ5i
         0NSH5mBz+QTd1GF8xTEAKS3HDxGl0DDeX1lY2Oo/lWGimpZg+xoyPZV/FanlKhYAE3wb
         7UXg==
X-Forwarded-Encrypted: i=1; AJvYcCVIs1BnJQmN/Emqyt8WK+YZgn/sUQnToGgBjDUXLaT5gBe1IT8rSOgNIBIGfpHXW9rE+sDpTmyxzDX6PX4y@vger.kernel.org, AJvYcCXRqI8YTr51eqH5UmQUa9DOc1fTOJd+5RdktdcMOdWSmCqv9hRMZ9qoBloJgFFrurWc3SmDaSmdKqdN@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnk+WpILXucWwIM1TY1tWJxLAJYAQ2C7ceSdD+Ht8G2Mz/3pm
	/J+hT+uoXhubLoexJRODwQ+MLUUlZI/wfE7rsio/fPKXVBLcVHyoS0bHtDqv
X-Google-Smtp-Source: AGHT+IFrFAiMmodBWF4D4eTrbCyBjSX2g4S9JUQwga5Rowen6566QJZTJem0n2pqzofblmcJDXHO8Q==
X-Received: by 2002:a17:903:183:b0:207:6dc:b6d7 with SMTP id d9443c01a7336-2076e37a943mr139270815ad.7.1726678224653;
        Wed, 18 Sep 2024 09:50:24 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f9eb2sm6696123a12.23.2024.09.18.09.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 09:50:24 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
Date: Thu, 19 Sep 2024 00:50:06 +0800
Message-Id: <20240918165008.169917-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918165008.169917-1-liujianfeng1994@gmail.com>
References: <20240918165008.169917-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LM7 is an System on Module made by ArmSoM based on Rockchip RK3588.
This SoM is used by W3 Board.

LM7 features:
- Rockchip RK3588
- LPDDR4x 4/8/16/32 GB
- eMMC 16/32/64/128 GB

Add devicetree binding for ArmSoM LM7 SoM.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c2..1ed72df971c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -54,6 +54,13 @@ properties:
           - const: armsom,sige7
           - const: rockchip,rk3588
 
+      - description: ArmSoM LM7 SoM
+        items:
+          - enum:
+              - armsom,w3
+          - const: armsom,lm7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
-- 
2.34.1


