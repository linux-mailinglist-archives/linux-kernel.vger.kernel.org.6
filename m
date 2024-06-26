Return-Path: <linux-kernel+bounces-230903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16E091839A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4AB282718
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9891850A4;
	Wed, 26 Jun 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2PyIaZY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE81836FB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410630; cv=none; b=OpSZlrgnCRDS1PHcaMWRYZRFdLVYWCpSBy0R8i+aK5AJEIUa9aBIg7ZZqsK43mOjf/zQb0rDkRORAH6iOhu0jhaK9psNMFIG7bnEUB3loPGJxKpIcqr5RslIE3ZeYSuIFPRnwVxJusuNlwdD84Jmp1t8wJGIzrPS2Lq7RvI/ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410630; c=relaxed/simple;
	bh=COI46aH+Oz21UiiihC+d6U+SjKviU2OFSGC3UXQqAoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6bKcCGwXjghgvxYhTxaSJ6DiPU7mR+WREty+rh/sSDQ3FAtTOzcKRX8stCmF73Tn52ZmkTx/kWumh5LSex0+fBWt4AOvCtpIZEfboqEF8ZTwf9sUINSvAyUJv43g/in1A7/L7lqxSK1Ks0SC/qvTNf1Qrz6QcYErglPUY2rmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2PyIaZY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72517e6225so481483666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719410627; x=1720015427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILkkZlkgByt2QtoNrBiCHP9/+0JYt5yL7z1P95cPgl4=;
        b=k2PyIaZYRtYpls84/RuVCTiFEP9LT/zNiIS8Z7APKhci5oigSQt0HAFSoVXl49qVsi
         seXIUPbvqAH/TnwSX9r6Yp4kt/+UlSJsweSphu3xxpQlDFFfz1rp0c3U3k0UcNgxHIhH
         m5VPSc5tvtcUbAd1rEOZpSyeZlAcV57K0w1GhsXk+vF9GfdJncTrQOuzWJte8e9MvTwL
         N6azXC64ej/zOm+b+2leshi1/fMX6tghanVSYfVLM8THsGg9xEU/p7NZBI++bXgR5D8g
         5aFXbUBTYtj5ACC8NbO2BQH73FnkhNcVDdD3NHtuobCOlGlMLAHTULxciv4nH9yd20GW
         mCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410627; x=1720015427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILkkZlkgByt2QtoNrBiCHP9/+0JYt5yL7z1P95cPgl4=;
        b=n3v41x1KHLTJQdPpWItg51dJApTLISaL4os7SSJVM70x8jnBwr2IU8MbwjiwyoM9zL
         XiPxUweiSh6u8mQHlcX8zl3nW06gIB79efC4Xx9AeoXx2DiF3b3e1CkQ3Dwy09fDDaks
         /QQGes/CGb8n/NdGq2qwtyumeBWC5kv+gejhsWHzqeEKboMGojCN97VXPFMMn+oERdHE
         sBj/HTxN4VWuUxVLgL6XcAKHY+xoPoUs97FxF+tnk28ebmuZiQnIQbOpGKiRaJSw8tLW
         l7AxWTpEZj0BBAFs9fCKjrFoXlH4uPWdLtFIbcd/j+i8bNFaM/i5nj2u2UoDAFyLN56j
         UsBw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqLctzHW0yFN3L9qntdEGIZa5WRm9pe+/jIioMf+Rr9XpO2PH3KsoMF58pVgCeYi69fk0uzQt7SLI0iISzkVxdlJqpWg4ew8ue2Tu
X-Gm-Message-State: AOJu0YzdsH7bc4bgGS9llo6AhezRi/XIq7fZnVZsFIjQKtYUcIIAmGtL
	teZ3LyaVcjxhT4FFMIHV+7LtDZjfcZ8YKeOr7019N+/eHvzVbBOQs6qeN+b0Myo=
X-Google-Smtp-Source: AGHT+IFGMbQ3bZSqzpxQwUSibOZjfECKDvJLCQ/c8yX70LE2TwziAXTqVapVmNaU3h9mnedMTjfHXg==
X-Received: by 2002:a17:906:418:b0:a6f:5723:fb11 with SMTP id a640c23a62f3a-a715f9cbb00mr706825266b.58.1719410627472;
        Wed, 26 Jun 2024 07:03:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a726627e0dcsm207992466b.62.2024.06.26.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:03:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Rosin <peda@axentia.se>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mux: MAINTAINERS: drop ADGS1408 driver entry
Date: Wed, 26 Jun 2024 16:03:43 +0200
Message-ID: <20240626140343.145440-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Mircea Caprioru bounce:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

so clearly this driver is not supported anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c675fc296b19..2b561624df6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1290,12 +1290,6 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
 F:	drivers/iio/frequency/adf4377.c
 
-ANALOG DEVICES INC ADGS1408 DRIVER
-M:	Mircea Caprioru <mircea.caprioru@analog.com>
-S:	Supported
-F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
-F:	drivers/mux/adgs1408.c
-
 ANALOG DEVICES INC ADIN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	netdev@vger.kernel.org
-- 
2.43.0


