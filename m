Return-Path: <linux-kernel+bounces-184653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F258CAA19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B6FB20CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11456B9C;
	Tue, 21 May 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pw0ZRPHA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E26E2AE
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280512; cv=none; b=Ie/STVm5N5bTs7Er3l+jgAj7wYtnJfeLSQaPlJOlggq1bpWgr8Vbd4dYSGqVhR6P/9UZBAsr+Ojd54ZHqweJORkyV/4xHhJcF3BQTYm759/ULQE2jFERVCMTQb3he8DSaocGC0zHmWxl88EGZ5wOgAST3+qrxHBm/QqDDL1QcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280512; c=relaxed/simple;
	bh=9k25ZsPTf+WrTiK8qVLkskl+r232la4YhtO+5MWY/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGBY3ZAEFJLV+cjubz+G3FzoGKAviU+YH0/i5MWeEtnws7OpawyNXe2WJO01+ffYGKkLm3ce1kdEh2W8ZzgXR+n03dxjpUJoDgn682F9oZOMq9EwE8HyXYKlr1/q8IbyX2snWr+UnSkx2D8J7ADZwytDq08IFIBl39kB39+wI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pw0ZRPHA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5a2c05006aso439593866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716280509; x=1716885309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=Pw0ZRPHAzzYC6/ONfa/PFJAWG0VTChASjdFU7viYyzKJFfXJ7ZZILcW3K6/Fn9Duy7
         v9Lz8RjRhe9B4t2P1PNnScM/xgTszJnxy4QRqiujEcc8rJcA6wyW/rb7TXOhDmNVhHCS
         CjEhYD23i+9G64QHuCNZFzXE4vOxC0s6iyYxjgWFnDciOTq/lkGMPFBbrCHUaCuWOzo3
         w+n9MQltA00m38xLboWecFJzaIH7OFSdKl9lrxk6IxBVwJ1qhLc7bWXmNGfU+aImaYn7
         OaXUY6yT8GEZfys2Rld6QIUEPBUDpIz1q4j4tzrCu2uehlUerS8FAqeNbdozRuX3+D02
         voJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716280509; x=1716885309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=WxmOQ6CFcbmFS7AwUybBFuI7XoChglx0QH8bxGlViJS1nnzRd7NIzzZklJn1vV0AiY
         siYl/K6JFuQsMG6wJrpPIv+pxy8uU1QG2zyslOspDnTWQmdlMd2NiSkv9T8kDDwMFPqA
         nbLf8xqVD601HC3dBD7okeUsrOGfS38TSNCyg57/A32ZTD2OBCcSTQyBjpjeAWlQtwLD
         q1dKo/vWcf4W1chQvN3ka20fx3VlZxuqXKR9tkkT6IbNZLAoK/A/EAi//kjh8ZAjkxtx
         kVKnvKlthJaW5XCLnERO8WKeVtyjPBCsvDux2AJIkMQIqJeZ+RaGfz/l76JnTwjD7+fD
         Bnog==
X-Forwarded-Encrypted: i=1; AJvYcCUrSCV4hbVPuXHLEMB/qyTCneU9NgXvYp+pJB95TxTzl7EXJkBE/HHkYNnPBpxZbBkhWhcERM3R4qPNCz30KvCCA9nz1EMVDwrLZ6Jh
X-Gm-Message-State: AOJu0YzgrjZ6bLBe3aquS00iT+tfkqpMqpexTTypewgYQzWrDJFSzqjZ
	c1HLbiM+RspWzJ2mOTPqQrrlyyqFxbcxQEGSO3eV0Mt8E7AlAQfSdkwADIPWsmo=
X-Google-Smtp-Source: AGHT+IFdOJDaXxwt3G/XzqPJASfDE2cQLEMIY3fQlL8rVbF4b17JPtcvYhCbyKk+sH7uacDvaHu6OQ==
X-Received: by 2002:a50:d518:0:b0:575:2ccc:13c1 with SMTP id 4fb4d7f45d1cf-5752ccc14damr6751138a12.9.1716280508952;
        Tue, 21 May 2024 01:35:08 -0700 (PDT)
Received: from localhost (host-87-18-209-253.retail.telecomitalia.it. [87.18.209.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c63bsm1577804466b.51.2024.05.21.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:35:08 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Zyngier <maz@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Tue, 21 May 2024 10:35:13 +0200
Message-ID: <b852cf1fc20db8fb7fd81900b6df0498f1086008.1716277695.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716277695.git.andrea.porta@suse.com>
References: <cover.1716277695.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3


