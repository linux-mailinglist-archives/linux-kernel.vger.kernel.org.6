Return-Path: <linux-kernel+bounces-202126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E468FC824
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729D7B2B683
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34719190071;
	Wed,  5 Jun 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/jZCjkL"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDC19006D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580233; cv=none; b=uhS8foHmnnCuuBLmt9VCiwFAWo+ePXHeWks1k3iphE8VMGlpAAieKEAsHFr101zxpNSlZLN9e2vm/3rzMrwt20acvyl1DddkCs3nxM3vf+A+6C3dMVTpnxygblL84O2I8uCGArCfZSJeLXj2LUkg9sK2NUvM2KSADpKJnqr0llA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580233; c=relaxed/simple;
	bh=oi2WvBkcuibAfXOROdiAwxHovEGXU0w54vU+XEWreVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qwkQ8GnMv1C/uqLxs833Rxejj1I9SDg0uCfRW2i1kqpVwhvfsMhlfORvYIA2JovCBIeJlAywjoFNc06jSjG8isHdusXRb1IEGu6e1Vtrf7YnupKQ8u1GmRYVT4wkOraHL/PxJcxdzR82JC3RMimuYFLdr49sT/fCBNcEgPkGmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/jZCjkL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421208c97a2so57895705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717580230; x=1718185030; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LSZI+79Ozf+tLjEjjKM/vl02OsbKzTxtYkNCBqG2m2s=;
        b=s/jZCjkLvjppfLVmWxBbvPvDbbCeP7nj2Uv3zFcpRXEg3crW/ZUsi/OC3WEV6l0iNO
         8dNqn7SASjwiLEoBt5IQzymgz+YYvg+Y0j/d4Bn7buuB3/eUIAMuNc58t04ooRQTxybE
         UFhOzYIg5wpEmpQTB7goav+A0uSZaXzsfIt+/oifyacwIHAqy+fnJriwTl4zDm21e3go
         /hVe1k/kNtqkqkgnWAKbh/4fF5BiMTHWgp9RNJBNDAhgcwOaMt+JO9I4cFOvZvQiYMch
         qFr8SP4MdDKAUyh6RYk4pqLDE10ozi/XFfphpcRHedNN02pjEfazSpDPkaaIcJdU4SV8
         mHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717580230; x=1718185030;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSZI+79Ozf+tLjEjjKM/vl02OsbKzTxtYkNCBqG2m2s=;
        b=g/duW810LrIKu++wcia40b9L+O9YL/3pg3il6HH5hXDCUw8d9ocSe/2T0xXzSTPt8N
         7EIScX9POwoY/s8k03HtGsT84xabMMWbUx4FisBqPwvvWLJLOIkAHKZxxiQ5UdepxlN4
         /YRbHVzm9sVP+zgxbrotvEAZNWDlm1nq8pFfazMMFCks9FO+gylCDz/pzKGLPSKPFPnL
         6lPMdzIL2EaHruGkkRE6IhcJP9G+85BAmrAPQZEgYbB1f2gPX3TKL6B6vMAt4lI/ncp/
         2nq7OG8fClZuTAkFOP2ps5tqx+krXOnJVjYjzx6Z9VHbAM5pRDoiBmJdmXl3pHzQGgto
         9D1w==
X-Forwarded-Encrypted: i=1; AJvYcCV2RzlvzKgCIv3jaOlF3hPbkbdyb+FX8ClfSbIGz8kQBqI9qoCoGnmk4e7uS+CZY+PfVpaVhITj8bRoHqC0ri0xKu+i5vb1Db8bnzYd
X-Gm-Message-State: AOJu0Yz6TzZrbjqOI9RNOHtIlKlA7mfHDDQSRECJNy67wykJuuBt27BU
	Sd+ukARibfngrhdLVudAl9XK1w+v94L/PgcqwZ1asmQjapBk7ldk6IJe1qaxFrizNUuqakCTcH8
	R
X-Google-Smtp-Source: AGHT+IGAjFy2U1Sr+dNT5Lezmn24SCXAPKGBu2lzxTmKU5abNAvO1losuUJ7PfnTYXCgDx0HUW4r9A==
X-Received: by 2002:a05:600c:46d3:b0:421:2adb:dd5d with SMTP id 5b1f17b1804b1-421562c7fa6mr15583975e9.8.1717580230396;
        Wed, 05 Jun 2024 02:37:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581016c6sm14510245e9.3.2024.06.05.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:37:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 05 Jun 2024 11:37:08 +0200
Subject: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add optional
 power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMMxYGYC/x2NSQrDMAxFrxK0rsA1daerlCzUWHEF9YCUDhBy9
 5quHg8e/69grMIG12EF5beY1NJlvxtgelBJjBK7g3f+4I4u4FKbTEj5WVPnq9miTBnvUqKUZDj
 Llw1b/bBirJmkGBpppAndfIne84lDOEM/aMr/uu/fxm37AUJHyVSMAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oi2WvBkcuibAfXOROdiAwxHovEGXU0w54vU+XEWreVY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYDHFLxSezg6MSIqYHnt3c+yfTVn70mG8pfNZ2oUF
 kJzSJT6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmAxxQAKCRB33NvayMhJ0bRND/
 9VWdftl4+ZipFhnGlqNjNwYhnqAPXR3Z0dbtvuMA7h/YrhUWK7oCzAcQM/xI+XK/HfPi9D1TKdstU3
 KL2F2FexCIHybxIBX76TWWAdT7C/hN8/Y9zXPj80wZLln4S2POzcAjiRRQ89IjZB3C+8LVDApKR/uC
 fozYKf3ofRX8YJXg5yojKqoBcB2wH2JOysdHma+e6i1JlQs6GSa7SS6iBwyZhFena7sh+hqTu+N3NV
 ezXtvolX/8fA5N7H4u0q2se2jxPsxqo4jc5awmDyLlcO86DSh2q8rK5E+fqB6I+hN4Jta2oj5WQ6fO
 WrIU1IzJXu9q84bFBPfeOIRXOaRI4UT/D7oC3NysuOYVNKHFinu6hshbdTcyQMsrICWcodXvAia8zp
 rfrdHW+tgck335MYJ7X3uTJXztALrOhB48enyC/8pk/eTzV+VyIJ3vf4pMm1CUToJEihZET5y/qshi
 7OWOZHGeOQSt7HQusRVZTAkmHx7tktOa0IPSKZd6essrqWBLamjpSD6D7BN/RJegC040YlSBV4Hc4C
 2/lrsFupoKccNtpaMrOb8djrXYpMF62TNkmRA5cCP/uUg51FfU9tZVl0IzeLwi14VwKLBkwFJLHg0j
 i8AcF8M73dcI7L/LbXTxXYzGYrLXDueA0365BDHWLs3FGCdHKCVkuyqzZvow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

On newer SoCs, the SAR ADC hardware can require a power-domain to operate,
add it as optional.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
index 7e8328e9ce13..f748f3a60b35 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -66,6 +66,9 @@ properties:
   nvmem-cell-names:
     const: temperature_calib
 
+  power-domains:
+    maxItems: 1
+
 allOf:
   - if:
       properties:

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-0f9d22e7e558

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


