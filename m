Return-Path: <linux-kernel+bounces-512779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10170A33DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41C97A21BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07A21D3DA;
	Thu, 13 Feb 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctHLYeM1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4621D3C2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445517; cv=none; b=ZadubUKQ2tIdGomJwE/M2kqrgNBu+bMKLvva2v3OmP8USEH9PftaS5HDKhs6kZ+J1vbgq/v8cKWTFXAKtB5FFW0gVeqifN0O/pNrsq72Xr8PjcGyDRfhgSkN1BTpYWX5hYP0nXt2aNXLJWt6qNHLi++vFz3A/c/77WzHWDOo8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445517; c=relaxed/simple;
	bh=yZykid4Tnvw6uTxZTfPXzibToPkb2UoxKH9qc3uHcNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=swK/AzbeHU1VUiIek4Jh7eUrnkyTLbqEwf2afZwriEkgkbeLjij0nMPzZSUU8KjXHsiHVdzTG1/z3QipcyIWfzouZt9b+6mDqF8HBaNL2B2VYo3c1dvfBwSLR45MT47Aux9VI6SfAkrra+7z+Kr7tjQ/23EiG9JCpXIflxmOcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctHLYeM1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec61d0f65so187145366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739445514; x=1740050314; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcwZpuTU02sMJrS+Mjy6fqoBX8jKwW0TxWQW8Ahv3FY=;
        b=ctHLYeM1IfEkck3J3Cxo6hb6m9Siv2hYx9JCDXSnCzVT2barqfiz2NkOTh5nOUrGRj
         /QDcxe5yroQxerUUKt2ruc1Tm7VWG34mEvowk6GHu/sFNOUW+HiE1J7WwEgJye/8FUC4
         U7OuJ/gMWyLGHcoHNDEar45unT8hFTEUU2FiJfzpJ0cOGVV5ZE9osjyBtqjdaN9we4Oq
         lRHDaOVc0zsDGemru95jMv07M//qxqgatAsA7R437xf5UTENksmSeQ/FopyvfhMfBdQ4
         98/ub44F9MBv9MlyT5jN5gpy9Qz6+VvHG7eVHwZSi2ayRPJs/JKoO/gPtIX67AgvQURb
         6HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445514; x=1740050314;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcwZpuTU02sMJrS+Mjy6fqoBX8jKwW0TxWQW8Ahv3FY=;
        b=dDO1hv7cynrXWp4TBY48ZEnRCyTSaYd7BY+FmkvsOPVXJFZlX0n2/E0GmduSTWPR4l
         zFmstDeXZUh38GYzyNWJBjQ5pWwZZnUI+8otxt2mxMdAJEcVN/V1MDkkhGJI6gxBz7ee
         VDA6eitiwzXNoYtPxNNGuZmnYWPmrywH6hv7qMwwwgMh+jPtmYxvay40oSTnaLaoWBgh
         zsmVR7TfITvH8SoZ/FzEKUgv44N+XLyiRjQz3JnyhHZdrwlIIqRaRJjJpIuokgVpKbEo
         wfICQ4RwwDLcF2B9uGIBzL9vSynEYKiQ+A/R6Ua516LHEUTb25Heg/lIaufJlT+03jtX
         HXgg==
X-Forwarded-Encrypted: i=1; AJvYcCV4wXECrBoYkT2zOa9UzvPhH3/91y3bSZiHkeRa2RUlRwQxBzYpFoJetglP1YLpiWMNUzNtmB35iTmmsQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqWOCxalJb7DasIXzpqTYDnZioNDwi0murv1orxuOmYOL6aaY
	U95qQAcxuKNBmmsm3I7T9+nUW6nHgjA8+Tn0E5+iod/UTiSO+qA78kpzn05pMbc=
X-Gm-Gg: ASbGncvsMqZrzhz+h4MVAmZBDDZXGAq0qir+OvoP502RR79dIdmYwKy2JfS4SqGPBH6
	pAlyxerXk647Hx7NFFv9Oz/f1WLsWXMG50LmY4R5kQ0yligmmBQ4BpUQjO5QVRiZw9qJPecEDpb
	MmJWtOjvB1OD6tNF1TViUA5+4R6Tti7q6MEPjT0aG9vjg0fbMkagpvjSdxXl+dTCd5S+j40eGTs
	VMHrB2VP2Aa6M4yTciasQAPTwsv/zJiatNj+EXqFAVnQ4b7gcnW+4PsEUMV3Ii/uwBFAoS2PB5q
	1xIy7WONpnPPqfwDrhH+CcMR+lFEjn4tSelgBKfMtBP+qLPLjiJT5bUNl0oONWHosNG6+eUbMDQ
	=
X-Google-Smtp-Source: AGHT+IFqhBKKdWnQWpVYsZu06h2i4EkJM5xC3kZZLUKj1tfy2dbaEBJKgl9UFEL/OvS6Ziz5q2en9A==
X-Received: by 2002:a17:906:730f:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-aba501a9d85mr265032166b.47.1739445513994;
        Thu, 13 Feb 2025 03:18:33 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532832dcsm110618866b.85.2025.02.13.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:18:33 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 13 Feb 2025 11:18:30 +0000
Subject: [PATCH] power: supply: max1720x: fix a comment typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-max1720x-typo-v1-1-9c88611cac34@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAXVrWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Nj3dzECkNzI4MK3ZLKgnxdEyPT1MQUg2QzY+NkJaCegqLUtMwKsHn
 RsbW1APaP83ZfAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

mesaurment -> measurement

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max1720x_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 11580e414713..2c9aea4f5d7f 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -302,7 +302,7 @@ static int max172xx_temperature_to_ps(unsigned int reg)
 /*
  * Calculating current registers resolution:
  *
- * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
+ * RSense stored in 10^-5 Ohm, so measurement voltage must be
  * in 10^-11 Volts for get current in uA.
  * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
  * So: 102400 / 65535 * 10^5 = 156252

---
base-commit: 808eb958781e4ebb6e9c0962af2e856767e20f45
change-id: 20250213-max1720x-typo-425ead0c633c

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


