Return-Path: <linux-kernel+bounces-268656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5394276A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D143B23E83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC81A4F01;
	Wed, 31 Jul 2024 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iSziX4iK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F131A4F15
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409553; cv=none; b=krK7tgKGEyvWPCrKtwNc8TxI/+WqRIWoQ05Y2dmq8lzkRAde2r7ZydPEqEJlgDxvhRs4AAL1hNza0aZDB9TP9+xDWZrsU5mpUl/rDEyWGGXUxQVJKLoKTO16BzLTuCY55v+lM1/dcBiFGa5RVj3VkIo793rx1Z7u4CH/ME4neMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409553; c=relaxed/simple;
	bh=CVeeM9agMlhOuzB//PVeugDjFr+JlKm6KzovrQHMqX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s25lwufuiphs3jhh+s6G4sSg+wbNgJrOGWH3IzBB9OdLsC28VR5uQnqLRZbm4GYifc18ehCWqq+FHaOAqZy7UqTr1t27hnMypJ4SeX5oooVa2nFwAA9iu+PEbG8r2wXniRYMUrwa+fn/aUkTrYyx9rKYZDh9DKgEMeaI72gWXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iSziX4iK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so34247865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409549; x=1723014349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFCuIz7C9sKLND6RuCsZOq0lXreIYCfstfjNtwHxLOQ=;
        b=iSziX4iKBzQ/BtWR7pcIVTQ4O8pnQHYw0R85Zj1PUNfh7p3S2OKFggaKwkW4UYiOQY
         yUcLolZv/e4GkqTZtKbO9+uWUmAYGlGgQgWGR9YiO+N+YJA/621dQveMorlHNc69bccu
         wtLlA/NQWi+rfN9k7FAY3fMPI5zZzvwf3GCXtdfOjlPqU8UndERB2MHneenSeqdnnX9g
         WA2c2V7YykmTB5wm6//740qxmCczpvBtp438uZUuCeC0CQ1c7HKtGR0Fn14G9VuOYWJR
         6KPkFaSChq+FTZGMHDLTVAKpLMbeW3lRNVsJUX54x9uKPlM9tXPTH7gECeHr5uXNz336
         j9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409549; x=1723014349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFCuIz7C9sKLND6RuCsZOq0lXreIYCfstfjNtwHxLOQ=;
        b=aoTezMqKSNYdCIOpl9OAPZnooEKXAmDUBSl+zuvlRTi6fg3sCKD1tNgTdcNDddWiQ0
         lyhLMgaEu7lW9bqNDfDxGrl/uog359FBimWJZSdL50YcJElAb9XmsZUd8imApJtQugFk
         /qLmHKOLOy73pAPBqy3gdht7Mt3VBh5vNW5aAe4Tm3epRv68oInDHFfPXEFOd0EjX+2+
         FZDpSaI3Z6MRqmlq3ov4tOwVl3z7xOd1cE9HeDMaR+ZikiB855nCOCdzzUmVwKLG8QE3
         NTaIv25NY9+71bsVdzw6vghyMcxQJvMuDhzkak0Ag9bZNYgxUFlJUzsZxUbpTIZTT8tu
         o8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX0xWf9DJgoN0PlLerM54QRBIUNU0GYP5WHHmhvqOSz4+rXTdaMHgniuAL0BfPgE/I+Ef+QmufI9KvwQRWMF2ujibearPWWc58Na+C5
X-Gm-Message-State: AOJu0Ywo5Q9ib2TiTS2zlf6HDRkAOT6PjFJFRVr7y7Ot/q7wBFDn76kp
	G2L+MzBXXsc08uyKEHfuX4roFZ6FqVc3P8b247Pe5uzYbBuljIfcXwxNS7AymcA=
X-Google-Smtp-Source: AGHT+IGetKYVTW5hZ9jxdlylMXS0vLE2omCWqfpv9It70piPrSEHFmOVA4GtdWvPtzBnHg0b0GPogQ==
X-Received: by 2002:a05:600c:1e26:b0:426:5b84:86d2 with SMTP id 5b1f17b1804b1-42811da946fmr100643465e9.20.1722409549382;
        Wed, 31 Jul 2024 00:05:49 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 31 Jul 2024 09:05:42 +0200
Subject: [PATCH v2 1/7] dt-bindings: iio: adc: ad7380: add single-ended
 compatible parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-1-cd63bf05744c@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
In-Reply-To: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Adding ad7386/7/8 single-ended compatible parts, and the corresponding
ad7386-4/7-4/8-4 4 channels.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 899b777017ce..bd19abb867d9 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -15,10 +15,17 @@ description: |
   * https://www.analog.com/en/products/ad7381.html
   * https://www.analog.com/en/products/ad7383.html
   * https://www.analog.com/en/products/ad7384.html
+  * https://www.analog.com/en/products/ad7386.html
+  * https://www.analog.com/en/products/ad7387.html
+  * https://www.analog.com/en/products/ad7388.html
   * https://www.analog.com/en/products/ad7380-4.html
   * https://www.analog.com/en/products/ad7381-4.html
   * https://www.analog.com/en/products/ad7383-4.html
   * https://www.analog.com/en/products/ad7384-4.html
+  * https://www.analog.com/en/products/ad7386-4.html
+  * https://www.analog.com/en/products/ad7387-4.html
+  * https://www.analog.com/en/products/ad7388-4.html
+
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -29,10 +36,16 @@ properties:
       - adi,ad7381
       - adi,ad7383
       - adi,ad7384
+      - adi,ad7386
+      - adi,ad7387
+      - adi,ad7388
       - adi,ad7380-4
       - adi,ad7381-4
       - adi,ad7383-4
       - adi,ad7384-4
+      - adi,ad7386-4
+      - adi,ad7387-4
+      - adi,ad7388-4
 
   reg:
     maxItems: 1

-- 
2.45.1


