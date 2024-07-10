Return-Path: <linux-kernel+bounces-247986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F055E92D705
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21BD1F21CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B087194C71;
	Wed, 10 Jul 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANwSEYFm"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00071FA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720630977; cv=none; b=aJk7u7ancOdANR12+HpflwSZZI2/k4VSbci3rw0JYgcJcZa/gBZfEonlQgD/Qy9bDnhsvSUSKR4pD3ecsF242DDpBD8BF/V8ZqR1vOyYQ60ySWJlCYwnJ6mden18dA9Q86II1z0O5h8C1O092lW2mkT8ZyNnbfaDs45Z/7V9tRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720630977; c=relaxed/simple;
	bh=pXsKLT0GxA/tymfRBh1+fRBjRog6aN9JCp0sbEihXM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LHwWBNMTbyEjJNGuBoTPfHotsgL8qHJHbrpvdI33nFCnRG5+hQ1FhkGzfiWlmxHTnwIMhja2hqvdV/amqzK7wTTEJeUt+fxNzx8DOREVR4lVAO7Z7bcmvqvCN7HW7RAXgz+thsaEznGkrABluoJLkEnhTUM8s+sTpEqmcdUx/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANwSEYFm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4247096f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720630974; x=1721235774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WY9v7fPwC8/Kh/qND3MxqZoOqwJeAGg4mPbNYchqMJk=;
        b=ANwSEYFmFGHbWNxSb7kHdDIiatcLItQrKPBc8v9NPyGEgPNKUDfuDX4wLbxvUdVq/E
         AwuHfHWr0hi/FbCbAmZMuUDViB5AJwCFzIfjXY63UYcwYs6UpD4ZdHY8ALpp9Paox1SE
         GLf49/GhtTjMBU6UTXe66EMNSXP4XsMeCcVOABdzL8vg3weo9oZJoyBHd9FU9guLNSyB
         zDvwElGqXowdspE2evlYvQhCgZdU4pgf7UDMuYQMlNl5pvJJv7pu3JAErnPT011Ln7Fa
         Unsxqgm3oVP29wnDUXdJUlYHocczL6aMcBhUNjNrpzU59uD4ZMeWTlvIyRzcobeK1bE/
         qyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720630974; x=1721235774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY9v7fPwC8/Kh/qND3MxqZoOqwJeAGg4mPbNYchqMJk=;
        b=MOdTav+XLX5ZTzt8utYJ7lSL1OeHj9G0lzzCTj6wVj9I6x2ck1E61eW5dMnmbjE/W1
         xcsp3ufT8WWRbgzsDk4XTomERfv1Ggqy1LiijaRoflv762MqU/isI65OmBdndDZoBojK
         IATaWeLx0/zleMKo/UjrRs6riQZWtDhIGsuMYclKFLJwRzqiT7Q0Dp+2nPz0Icr2Khet
         JWWJpRrW7GFeHMdMXfUX8eOn5MPhir901c8m9x4FXAWs/aj3J7g0jhkmWKA85dZoPLbS
         /j1gAzxI8gzNisFH4OqrpF21hqWU537btHm0gbPRVwSY/W31HAMCFH2LkTOUcuTCey1H
         mN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2xZMe4KDKYXPJ9XR8FxR4ELY81wyret8kKl11lNTmMdNHE4eIj0hslWOBTt4o6AzGH/ZHOFFmkAyHWMt99qIAakj3L4IH6jpU9/CN
X-Gm-Message-State: AOJu0YypR3kHTcx54DGNcbkY7Q6stGvzARju81O0kMW1NJLSG3r1+obS
	VDI+8XUdU4S8MI/jZBszRlXrotqOcxGIizalKfGvBiSuwxJu81npu/Lz4EtnRI0=
X-Google-Smtp-Source: AGHT+IEI+1Wx5It+lbWkRbM01pbu3iBKGclgQSGDCuRgL18TTOyAQ/95EOxbxq5oh1RaMyp3qpgqSw==
X-Received: by 2002:adf:e44b:0:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-367cead1001mr4312364f8f.44.1720630973974;
        Wed, 10 Jul 2024 10:02:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8491dsm5805246f8f.45.2024.07.10.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:02:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Jul 2024 19:02:52 +0200
Subject: [PATCH] dt-bindings: trivial-devices: document the Sierra Wireless
 mangOH Green SPI IoT interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-topic-mdm9615-mangoh-iotport-spi-bindings-v1-1-3efe20cfea8a@linaro.org>
X-B4-Tracking: v=1; b=H4sIALu+jmYC/x2NSQrDMAwAvxJ0rsAKrrt8pfRQx2qigy1jmVII+
 XtNjwPDzA7GTdjgPu3Q+CMmWgbQaYJle5WVUdJgmN3s3YUcdq2yYE75FuiMeSi6oWiv2jpaFYx
 SkpTVkGJMwRN7F64werXxW77/1+N5HD+IFnjpewAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pXsKLT0GxA/tymfRBh1+fRBjRog6aN9JCp0sbEihXM0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmjr68CLfByopTepl78SucViyPVyFy5Z3HCS2dGAsK
 JPC/dEyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZo6+vAAKCRB33NvayMhJ0TQmEA
 Ci7oF27eAjv+M+mY7viqqmUYulOhW+WPeufr3tB8G9bb77dop5ow6YJAwliOzapPZg0JQHYy1io6/2
 ulXOdWOeeEP+D0dVBFbqDMpu6K5rr0gZXk/STtAlDm7c8kX85kYPNklYhIir9tUmljNWQyIcv87u8m
 KN8d7OomYgaY+8GDDLGX6YBtrnuTZ7m2RE5DAeN6sSifAXyn0Mm4q85RNERXrE9lhmDO++MBQceapm
 vpE/RNr+H9uARkwtLyR8en9OkpaO7lq7BOqOuJYImLK50J/RbMGKnZYhGdLjSuYDzH7b8ELmKuUcwN
 b2dSBFeMg6x80RGiDlHjCmdmaHWNRc4elswNgAxmDNXQ7afEthnn3hb6vVlZSrF19NS4n012BKK/Th
 +SEM8gybfz0FxqBJHq/SKriWVxhT95BkL4Hyk/1mM+TgEUlEsrLVVB/B7/IM0DtwJhMIHnLRwgalU+
 UQFoXtjW/1bzf3DOvKBqZLivu1kHoLcfb9HoTR3iE7P0Ero6oCkgE3tFPpPrC1FItOjas+Jg1kiuwC
 5kOdzqrf5pRh1mnfsNSbpQLil0ar0gKIjtcG3HCfS+fq9fzhypB+ZD4sK5pxrZymgeeRdmfTOc7ANb
 YKAFEK7zfKZ6eqaxyFhr1b7uTdEOgr/OmjMOOYN7HWBg3te0Cqn/dKg/MVvQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Sierra Wireless mangOH Green SPI IoT interface as a trivial
device.

This fixes the following check:
qcom-mdm9615-wp8548-mangoh-green.dtb: /soc/gsbi@16200000/spi@16280000/spi@0: failed to match any schema with compatible: ['swir,mangoh-iotport-spi']

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 5e58ebfab758..1451a9f68427 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -362,6 +362,8 @@ properties:
           - sparkfun,qwiic-joystick
             # i2c serial eeprom (24cxx)
           - st,24c256
+            # Sierra Wireless mangOH Green SPI IoT interface
+          - swir,mangoh-iotport-spi
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
             # Temperature Monitoring and Fan Control

---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240710-topic-mdm9615-mangoh-iotport-spi-bindings-1bbd641e4068

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


