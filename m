Return-Path: <linux-kernel+bounces-204064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3648FE38A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE951F21C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A517E8E9;
	Thu,  6 Jun 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddkwLcl3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9173444;
	Thu,  6 Jun 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667668; cv=none; b=Tb+pvkNFEl6tnnZK8ssAy5hz/KTUFlkWiOx/H0V6QKkgcDdCJxPTvcqibUlgRCzDrTvntf1SzV5onKGpRsbPtFtnHyeZeUgcbCJMbuukYmSrGSjB2JqrqiYuJZksYnX+bl/ijxlGbsa1+t5udedjZm7goNFLwORDqNXn+mR3jKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667668; c=relaxed/simple;
	bh=W0liS6l/IMX1KNzJs2URUcAemV2b4bSV/M1sWrYD9kI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFEamPMGBPtMpjIwdLiT2K0s7HR4KXaKaae8aDIQlxq/FGw1wxSgTrGdZfXy89Cmc3UEAPIiAM8bHrmynwHB8YGN0RvKrRCK1CUim7CwvvNPtxKFVCjyxyuQi7M64ENDaYoRVW/KgAEaPMcGSnKCAGD8w1aQSiNQzZRybrPtn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddkwLcl3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so9117485e9.1;
        Thu, 06 Jun 2024 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667664; x=1718272464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apHCWRIB7mRNBEtiZcbMzZM2Ta+6YdoOJz2/tCdUzps=;
        b=ddkwLcl3uJuO/eBJ6hA79op8Fek/l0dlcF9tPTzpc7hCTsBCZRE0uFDhnzS5mO15r1
         q1YW/GxwQWnFhRop0TPAAaSB+kU4b9vnkDDSe9GHyespk+rlJBl+Wss5Je9O5XC/wK93
         DDiWAAwOED+zltIo/AZFWONfik2xJHpl0EOA8xVVqIrxsTB0tDW9TyQDJrSA5mXf1i1b
         AJnbTOzaCXSXN0xuhp6UTmpQzdWHRtjaeSJt60PHwXsSsEjxdpCDqbcoFjPimEBgX2p+
         pGJ75nIBc0Ij+tTXC7ckT5NQLqugqW4Lt6rj38KVu4O0zpt7cIPeRdSlrK0Vgn7SAAi8
         1B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667664; x=1718272464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apHCWRIB7mRNBEtiZcbMzZM2Ta+6YdoOJz2/tCdUzps=;
        b=HAFssqc6qlkkJ6OG+6khR9fjBWidY98PRbnEQaq6SM+X2HFyKc9lws3jyFVLbXhohO
         Qe+noIdknwomocSCgIFY1QVaLh/5ndtyGFfXk6OeXavk2sYU5I5y6KIx30s9u4E2E8xo
         tpjGHrDivFKk0mBgECFPt9tTnr4e6ATA4zEjfzxVuXalS1Jw3s7oe4B0GyrBLvxzB6V+
         bnUjhTwVWyYZCkbcc0zbc+ED9cCfcZVure8EtaFdwGWMHF3YjXUs+/YVaHRsEZp1aZxN
         diqeBU70J1kqpBvxcf2vjoWHdX64cZxvKbcFto3BLmry5AG0HK4ldvDHMv9qYXoLR9M4
         s+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5xN0NUXZNATbx8i7iRIWsLq9gbF2m9QsNyM6BY1zGKBZEDsuD3VUai8qT30VGVedRXq8d0WpE6str/Xano4D3Kd+FEfbAm00y0Bn+YRrMDnhs9r+xBtbzsqLb93O0IBGXqgzCrcdaaA==
X-Gm-Message-State: AOJu0YwDQzLzxrP5F7dN6FP5vmbN+Qk01Dx0kTM/DF240PG8DXrd4KoU
	cjaPG6g6EiOxnb6euJF/95k1c5255pWCkFLylHAwKiGzsqLlRaKw
X-Google-Smtp-Source: AGHT+IESF+hF++itPBlS+1rbKuC2h+vYSYamsDEjJaYuGkc6F/FPJuj8oyrWs28c0E+zvST8Mj8jzw==
X-Received: by 2002:a05:600c:4f84:b0:421:5352:690e with SMTP id 5b1f17b1804b1-4215632d104mr37980375e9.25.1717667664364;
        Thu, 06 Jun 2024 02:54:24 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm51454325e9.38.2024.06.06.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:54:23 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add OSMC Vero 4K
Date: Thu,  6 Jun 2024 09:54:18 +0000
Message-Id: <20240606095419.3950015-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the OSMC Vero 4K Linux-based STB

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b39eb17abbba..0647851ae1f5 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -91,6 +91,7 @@ properties:
               - libretech,aml-s905x-cc
               - libretech,aml-s905x-cc-v2
               - nexbox,a95x
+              - osmc,vero4k
           - const: amlogic,s905x
           - const: amlogic,meson-gxl
 
-- 
2.34.1


