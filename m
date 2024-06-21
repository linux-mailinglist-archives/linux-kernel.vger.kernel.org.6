Return-Path: <linux-kernel+bounces-224782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C519B9126D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FB8289309
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33C1EF12;
	Fri, 21 Jun 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZDWU4xD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE84AD5F;
	Fri, 21 Jun 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977237; cv=none; b=Neoj8WDydwL9G8nOdkxgqHMvA/Jf+ESAC0I4ShxQHQ53iGcR802zfZ0q/NyVyC2pPzRx5ebymjtKViDp/aiUy6TRE3z3jfbTWL4zuA5SC83c4e9NXcRaVJCCZyB3O18XBDdRQGb3d9vMBacu6FJ2Q7Dqm9b4Vn+067HC73WaqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977237; c=relaxed/simple;
	bh=olpEll0xeBm+S+FqzglB0o70tAlV3WjVhczzlRqzRPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofzJ+0alAg9yB+0y3uKxuSpsDUrrG3TOtPcCJ41NUBK6DGtcPOUW54HIahXN+xxufbvPMdqJBTd1/zq/tbG3UrOlOWwy+oNgWzilIvkcv4+fxoBuhdPXJurOw9NSo2QfkGUVhtnmuy8zxkXtwahenIGCsR+8v76peWZqwRpUKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZDWU4xD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cfe600cbeso2404939a12.2;
        Fri, 21 Jun 2024 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718977234; x=1719582034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99hmU1TBHiI3BIDRHYs/T4GfZVTtEzomHKojpOx+X/A=;
        b=YZDWU4xDRSBuNz00W21gNdUpbeCSVK+c1HasRjKBjVp4DfkY0Ix04qWMOyUdiGUNwb
         2fsOgQs1TUCkq18AguRbVLEfCoSz9MTqo2NsctnjX0RsR/FWErUOPhsCKcXQ0UvO4WLp
         yOcxTFHFAyp+TPWur0K25mkismfBC5pr6RygHpVAId50IFezMljoNglUqYGKeAyIMs58
         oosApnpHisQLlPBdXfvj10nuWVg3QSHCv27j3w+BRsSRAWOEtGUfneyPysMHvGfbxp1A
         Qus5lcTARzdzkHIjZvQgnXplvcJWvdOedFCgxmVuNK57fvKeedtp7M5+TTYrlPfw5muN
         vIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977234; x=1719582034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99hmU1TBHiI3BIDRHYs/T4GfZVTtEzomHKojpOx+X/A=;
        b=IusfFRoXZsfG8dCUtfza6OmxFAa3gbDq7UD6m5/iH47Bt45sbRZsKwyr2PP2eeNFRp
         tw4j1wnwkjmprezk1Ezg72jGdWadNKnSyt4ZQ3DrRDgXtq2c9i6EQwN2/qmuW77xh9oy
         i+ZLR5YAmh/uExSJfVlTy7gba8oqhACHH6tVij5avCFBrpQGoREt1nDjnd7BSHm+nr+0
         qu14yH+ZpFswYD5bagOTbeGHJZ9dIJuR66ab35oAnOyuIR9YV1+K34WsVk2n3bUaM+BO
         l76qHbmzRyKTU0Tkdr2Q0KyhP2X36XdXTNXQ/FMTHC0Ujl59+JEsf6dfyC3BFH/PopML
         ECMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdgVsApiuJBl8uwoY3DmaPEDQj9sOIee3o4lwYvqT/VZ/nkVPwH1O9N0TGCLdlyRgS6nWI5+F2Sl/YGoK6lty8D6p97llzqyyn8xd
X-Gm-Message-State: AOJu0Yzthwne4u5s2VT1RLP/WHv/mwgsrURk0R2wSn3tYctLVxg0GfBh
	5/v+KXfslHxu14Y2/OcgNtpxAXN6S6PkIAYFV3MY/g9BLGz5ERh/AiBJ
X-Google-Smtp-Source: AGHT+IGfTBh9ByRy0rKyLhNz7zC2uRU9ragOUbs6RwOFonz8+hz7N60ZZROooF3sFovnZw72JqMlQw==
X-Received: by 2002:a50:8ac8:0:b0:57c:8bdc:fddf with SMTP id 4fb4d7f45d1cf-57d07e8337amr4899211a12.20.1718977234191;
        Fri, 21 Jun 2024 06:40:34 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1b6a:5399:9a4f:7217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562cb6sm962059a12.83.2024.06.21.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:40:33 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Add Neardi LBA3368
Date: Fri, 21 Jun 2024 15:40:28 +0200
Message-ID: <20240621134030.243646-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621134030.243646-1-knaerzche@gmail.com>
References: <20240621134030.243646-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Neardi LBA3368, a RK3368 based industrial board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index eca0a42eb384..d2e887415d5d 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -634,6 +634,11 @@ properties:
           - const: mqmaker,miqi
           - const: rockchip,rk3288
 
+      - description: Neardi LBA3368
+        items:
+          - const: neardi,lba3368
+          - const: rockchip,rk3368
+
       - description: Netxeon R89 board
         items:
           - const: netxeon,r89
-- 
2.45.2


