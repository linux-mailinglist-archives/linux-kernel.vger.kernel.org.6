Return-Path: <linux-kernel+bounces-291158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD97955E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7C1C20DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5FE14F125;
	Sun, 18 Aug 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3Vn1B5k"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45A155335
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002184; cv=none; b=ZIMPWJaBdKDX7YwTW7REtVb+Qj93kjLnSxJxDpkRQGhdb7SSGjR3A38qSaGbAFukuzMT1FSYMMQQyD78pTp1yhqXvuPAAG4KrSF0FOFWe31zFw+2qVPqA0gRIayxCNYOTNrUv0rXponsiZ34liVDyO8XW/1ldevAD3MbYp9Fujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002184; c=relaxed/simple;
	bh=wT29u47rBZnd+eOAZ9Aao79GPKzpk7JkMgcJbiYggYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmVK2OTjt0EKHHlrR4BzxbA87gJQqKntzOKw4/on3jNiaBJnsJLSTX8VqcnlQ4yanfBQCApzPcA2Iue9IqCj28DvmFesEG/YuFH8QoiOGXnzE1w+qfKOK48usTBZOlTjnUdpHO0NjE+DiygpERL4bMcz1rKTuHG470yuc6XhY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3Vn1B5k; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428178fc07eso26239555e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002181; x=1724606981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNrMs47YrzI3ntKwQJY72OBzs2W8lJO+5gbdR0uMa/w=;
        b=a3Vn1B5kFcBcQ+sAKvhAhk5sPKsozO4NrX0Oe4hT7iT6FtacgZFo+j7qXJXWhJJ5fb
         48UBjpO9UOhFZsslJEH7zaRov+QJsBBCDKRNN+NLdmzjvRJ0zh3hctgFEwXATEfWxELE
         k625peSDlCXunICdo6YRFmmV1qRbV4CgQtcyjGGbrxHNUDy5G+adeW8YHhTVfk0QjkTw
         2FYt4olYPB0B/alABFBcke/JmboXB9f/k8P/iytiGi1ngtOOBgbdqeX6JrgLeT5alBgI
         jvwPmJleiKwb4m/r/YDrcvYRsFH0CfWcO4JuMte+J7eezDMAHyPwfqdEAeTzewtYrqik
         db1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002181; x=1724606981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNrMs47YrzI3ntKwQJY72OBzs2W8lJO+5gbdR0uMa/w=;
        b=tanLkel4IpO9l5GgmHcjM5zLp3W3lE/Ym8DeVQW30wlKQRAZlE9a6O8PdzhsWmQQ4D
         OfT5UKhii3EkvmMKHBZFXVjvjiQiij82Nml1MT6o/TeGEVH+qyo+Oz4l7mjpJi3NRuj1
         ZPvWhoj/BiF2gYCZ7OhlJwqOsWvHydkwIHtIYxPMT9aBj7aHvhv6ihgZzK2SaHqLc0lj
         +/5Z8XCXUcePAtvFVY7jY2moLrPFVneAcLfauZt+6z1vuw2if8mYzEyiq/dIPrNTS3z2
         dyOh2ihIkYA5AgMk8VdkuPF968Wmif6J2z7yPCKg3jfiC5a0r8y03nJ4K3oTvZ3LysN3
         7QJg==
X-Forwarded-Encrypted: i=1; AJvYcCUA+gmhYfbUeH4IGkTGy1HYvhlY6lNO/ZnOrtL9Oe7yTwGq7k1g618BC5b6RSd5EzcXTXnRed6k/290Rg9z0z5V4KGkGP9BHCR67Lzl
X-Gm-Message-State: AOJu0YyaJsUGiOCz8X2G+VyKeHalWA6PXu7Vdhh4ShqScRTtViR4+K1Z
	iun4EgjwEufBivH9iEi2HRzLBzku6WbkxfDFIaWa6NEeVXnaXBpVkPlDqoX0ot0=
X-Google-Smtp-Source: AGHT+IGBJHL8YbRiNo+ZgCJ648ppfSDsnBUQwSpImZZjJsv5pvWD5d7o1z0TnG79wP1JL/Is5EaO9A==
X-Received: by 2002:a05:600c:1c24:b0:426:654e:16da with SMTP id 5b1f17b1804b1-429ed61fe76mr67118675e9.0.1724002181011;
        Sun, 18 Aug 2024 10:29:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded2931asm133974385e9.17.2024.08.18.10.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] media: dt-bindings: renesas,fcp: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:36 +0200
Message-ID: <20240818172937.121928-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks and clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/renesas,fcp.yaml    | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
index c6abe719881b..68c088821b22 100644
--- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
@@ -34,9 +34,15 @@ properties:
   reg:
     maxItems: 1
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 3
 
-  clock-names: true
+  clock-names:
+    items:
+      - const: aclk
+      - const: pclk
+      - const: vclk
 
   iommus:
     maxItems: 1
@@ -71,11 +77,6 @@ allOf:
             - description: Main clock
             - description: Register access clock
             - description: Video clock
-        clock-names:
-          items:
-            - const: aclk
-            - const: pclk
-            - const: vclk
       required:
         - clock-names
     else:
-- 
2.43.0


