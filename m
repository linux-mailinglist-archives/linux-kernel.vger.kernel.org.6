Return-Path: <linux-kernel+bounces-325253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E19F9756EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC70F2847BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6C1AB6F0;
	Wed, 11 Sep 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYrTzcCt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EF19EEB4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068284; cv=none; b=HjhvogGi5YWBaoPlRzl3nehi+1teQSwGsjDffPggTrw8kapHwMplVxmlTHqPf2xpXdj7gdmwePCLU1ElfvJPjN8hKKGII6tw3jWe2xUz/crPL3lvV+1eVi7f/l1D/Pur5iQFGJdugth7NII3X2QPxlpL9Ec8ZsJW7ZWPobrK9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068284; c=relaxed/simple;
	bh=hyNz8ycs6mdBf/G5zzSRFgMbH82N2rmJ36hb7hnbrjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CUki9zx/NYOjnB82ebdCIP1FDoKimAnnNAjqeeC+pJe1JI5S+g9eDZJwuXoQjxcFXwQDoyHfi4eSw+uDHXxC1FEWrL+CX1ZS1EkAfPQz9JVp3LMdA059MuSGblKEgQHdanelzihzydvijmsoHh/MFHgQO3e1GlNBuqAF3dtHCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYrTzcCt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so54219935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726068281; x=1726673081; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+mCSuRCrN7G0xa97gx2nmqcmwFAHLUOOdWHh3hum0Q=;
        b=jYrTzcCt2Ah81RntTls2MOP5knZyB7h2jP8vNHNSFSXcGAeIdktk+2RP+CF8PNgmxt
         Z74/xjAEb5NlMcYIiRHHsVyshHI0SiintggJLFYvczpXFauMlsbxecwTAWqCNtC1Jhqm
         TnGlYgyve6phUR4EeYSuYmPlXDbu0cqbqUGWmgTj5nEzBL4Vx0f3b1JqWMm/QVPmQye3
         y9TVP14EGWL7O/sU++Yi9NHrKFVQueo78r4k/VQfNNm9YaApANeXUQA7llmW4Erl+jgf
         LFdrht86j9lU+L9H3b+VnFUW8j1xY8DSChtglCS4OdV/TnRMGzCLZVmiDwdayezV6Qp7
         S33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068281; x=1726673081;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+mCSuRCrN7G0xa97gx2nmqcmwFAHLUOOdWHh3hum0Q=;
        b=tj2piBUEd/865ebx9ER87Kj2491ao3eqzY/UCS2bK+u2Ccfa29mLUtHzDfaOC9La5g
         aBG6Etu948tWGjxqBMaVLiPkiOgs4qX833P5AMEk8K1v/uyg0AFzT/SxpIDhVeY4xp06
         C6fa9kXnKQWYGa552Eda3OWgRapDuodrBHLydiIJpb7OemeJJvawMhieQfisyqQoKZwO
         gqlxqNBBYEENrND4nAE1P+WRYUo3u/wZ3OmVU9NtcmnEXgwhSDD7Iv9yq2rTCq17bxmx
         ogMYfvIuYnlYRujQLNkmFYvD5FuT0EM6Yi0PZRZOtD2kUFZxwG4jXB56utYv5Kd4bulG
         AdIA==
X-Forwarded-Encrypted: i=1; AJvYcCVOC4vxSrMr1AaATZzHCehS4Wpb9+dtwpJuvhOxcenm62LGII/tAniFLb2gojXlNyCP0b2luEw3oU9TXE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbyqKaVHLT1MHG21yW3jbRFkhc9BuxyfrxlWsULGA97kKSSQu
	ukrvsD7G5SbDVnp3i02QAxV89lnZPqf5BtX8J0oHJNSGR8yCsg2qNAD0QqMB7/g=
X-Google-Smtp-Source: AGHT+IH3bhy7rrynnSP3WCYSZqF6fCC6X1A4QkpxIgE9RiMpq1DgaTlfKY5xsL76vGVw+m2ARIt66g==
X-Received: by 2002:a05:600c:1c86:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42cadb6a2d2mr113109605e9.33.1726068280849;
        Wed, 11 Sep 2024 08:24:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca87acf26sm164304205e9.10.2024.09.11.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:24:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 17:24:38 +0200
Subject: [PATCH] dt-bindings: pinctrl: amlogic,meson-pinctrl: lower
 gpio-line-names minItems for meson8b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-meson-pinctrl-gpio-line-names-v1-1-4345ba336ea4@linaro.org>
X-B4-Tracking: v=1; b=H4sIADW24WYC/x2NQQrCMBBFr1KydqBpra1eRVykyTQOJJOQiSKU3
 t3o6vP4PN6uBAuhqFu3q4JvEkrcQJ86ZZ+GPQK5xmroh3N/1RpqymTBxJD8b0scB3hlqQVNhJX
 YEXuBjT4oEFESQya2tQTwmRIEYgQ27YFVz9MyLZfRbbNqvVzwr7Xc/XEcXxDCTZObAAAA
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hyNz8ycs6mdBf/G5zzSRFgMbH82N2rmJ36hb7hnbrjo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4bY3y0ovqRmR5JO2MMnOOjcrBM0eWoMKWJwlSyd0
 hlhIkq+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuG2NwAKCRB33NvayMhJ0SsTEA
 ChLVb5KP1AYQAi2rQoRidUAiaDPlgHeS81UQho+taQxth0L0CQTdIDznKwGqL9ptsjlSjpfFpZJASi
 U/wVhjj/MNbUrdJydrcqzne6gu0uxHVS5m5L7HpZGcARVuMIeDk9DQh8LtLvietA2OrgfjQbhLlDcv
 0I9qwNd0RXFIX/usl7SdgVEDQ9dc+/2NIJj+4x3FD9/rNuEUMzU16Ycm3+mdw13BoqEfT2o0QcgL5N
 AIF7RVx3+aHULmADabg6URgZdv6alPYsMLxTTrdE3e4eujDVt/1Es2n3gOn7cch0//Dx8hThN/bMNT
 Wu1q5Y8uQS35+wkIeRfzRktsBuTfae/c7VhTN4unJcwtZIbajnCpL3DQjr36W+uxoGAGJjQhyb9BY0
 QmZZnQ4Qxcev0ScWPo+5Qnik8PXEAzmjXWeAdac7Gb12FAGRvsJxy6mR56Q7znnE/px5QZl21tXX5P
 7wfddbkDsaUFZfAkaSzs9xDZnRiqtK+yGQyZ3dZlG0yr/VQ5sP9mdjnWVnJiJo4hZPF01FLbf+6UCx
 jw+LF+ja3NYCCO1Yi0iYKEX5LyWf2uFsRU8djB8q9B4U4fM1qLrk2/tAJ3/iUBrJMl/9SdVBTnwXDp
 XsPadyeH8zxeY3l4NZy4Nq10tcrFuFkp6Nhe0SKiNQ+MIjQxTxqLfnYKB5FQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Amlogic Meson8b SoC has 83 CBUS GPIOs, thus lower the minItems
for gpio-line-names to account for it, fixing DTBs check on Meson8b
based boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
index 412bbcc276f3..c954761e0150 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson8-pinctrl-cbus.yaml
@@ -46,7 +46,7 @@ patternProperties:
           - const: gpio
 
       gpio-line-names:
-        minItems: 86 # AXG
+        minItems: 83 # Meson8b
         maxItems: 120 # Meson8
 
 unevaluatedProperties:

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-meson-pinctrl-gpio-line-names-b17585863df7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


