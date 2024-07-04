Return-Path: <linux-kernel+bounces-240753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21AE92721B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297F4288133
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181B1AAE27;
	Thu,  4 Jul 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTjRO2m6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE11370
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083143; cv=none; b=mwzdq1+fCeFtuRAHKNNEneUx0ONkYYJmG69gfYh62dhmCwea6Q2XZZM3lHPENQhqpfxchl2EeTEeSdS/MFDfSLlZ6pYSe5328ioG8x75tHz66e4+QevwNT9J4nwvulBs9gzgybM9czD8+MslIZVRE6OtCAdPOHkbuICT38nZ63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083143; c=relaxed/simple;
	bh=msMUHdwmfo/xfcbLPfmoqnDcJZxTp37M9X1aU/HHt64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RXSTrhLWRJuEAJAD2HIvVglovzZjzmaXHvI8iq5SNEJKKnllJrciufN9cls2+Bwm5tk+z1J3qkH2Y9rccWQ+y3aTAvDXRb5mZqPRhIm/BZpFQTn+aYHbi2oLGV8lIM+QO2kmBjjFNJwT5fwQCGEVEOKYXjTgseZdUg5j+FcOHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wTjRO2m6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4256742f67fso2472885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720083140; x=1720687940; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owtkn1JZViROHRyq0OPRHeVCIxCBljvpg/PQP6ulIbQ=;
        b=wTjRO2m6HT7SU/SJcir+JwmX9khT4JEBG8CqXQCeAury5jHUufSIC3VqtiLxVFhZ8M
         /Ol2WqhAJoOhbuMw2VgE7EkcbWU+cD1IjUTETFPrxRYvo3s3S4QS6ZKZrKN2k70Ixa5J
         8ET13de0XYWMdSvvMpk3J7MVuMT8UgeNl3FCRPczXRdlQhsGVR0B/TPnV1HMRBVBK5Wa
         4syTKjN/zwcngejdqqZpV3UMtv8hix7pt1mCnLLf3TXrJZqLVFn4TIsjNvrjHrwbioaK
         9Rsh2gq3HVze2C94f/+MxnSYr9kI4OIzOa+EJQrjF5YPYxy9JUToDThZMRw6r74SJ72+
         RAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720083140; x=1720687940;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owtkn1JZViROHRyq0OPRHeVCIxCBljvpg/PQP6ulIbQ=;
        b=RaS7+w2X15JcH1gx0juEnjial89jtI++wOnKuB5IIHU3FTxakWi+Rpi4NI6Ie153ei
         DTRWWzlWOkDfheiB/W6N9BZFfLRYkRg/7sJrtj4xU7wT9qdgWd6O6wBcEO1WrdguVvQK
         QwOToEVFFaEwS7GSQbfaVQ8Xyy3y39QHhEupz+bHwbDrkZVD2UMz/M16Vzoye94pzXV8
         UAjQs4SZa6xQqSnsUmoN8rxofDdGHaW0eJUThiZk91eAeFKWo9dHS1FiJmQwTPHF1Ao5
         X1N/ENJRDkFyKSLr75HuBQQlynes6w69k5V/PsOPHs0/i0fONYlC8UPtCpqo2UvIDNcp
         y2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+BvyQlFkwlTKTmHVhRFLg/McLcKKmPXNVA2TDWnX7nbBDinjMHVvPvmKGvkSOBWds1xIMQG5Yy23Gr8JgC9vEWdVR//FZ4zmv041I
X-Gm-Message-State: AOJu0Yz/ASqNTwk4CNI/P1D33e4vkXoKe6GMxLQIOCTeXb71cLFoaKJk
	BV1UrkrLnQTwyDqTO7LurdiWB1nLzANeJ6C3m0m0ZZFlhOhwpYrKhKuW/AvQH90=
X-Google-Smtp-Source: AGHT+IEKfbZg35nXOhYy2lKG9e+Vhb3VIC97OxLgHXyJIZPolH1wsLGFTnb4R/XR/J0+8n9tMHcb1Q==
X-Received: by 2002:a05:600c:6a99:b0:425:68a3:f6e0 with SMTP id 5b1f17b1804b1-4264a3d692cmr7479305e9.9.1720083139646;
        Thu, 04 Jul 2024 01:52:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f23f9sm14773225e9.26.2024.07.04.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 01:52:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Jul 2024 10:52:08 +0200
Subject: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
X-B4-Tracking: v=1; b=H4sIALdihmYC/x2NQQqDMBAAvyJ77kIiNpF+pfQQ7ap7SAybtZWKf
 2/wODDMHFBImAo8mgOEPlx4TRXsrYFxCWkm5HdlaE3bGW861DXziCX2+93glosKhYgT7zgE1Tg
 LKsWM+sNvkITGe+tc7yxNA9RoFqruNXy+zvMPK2zxZYAAAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Rhyland Klein <rklein@nvidia.com>, 
 Anton Vorontsov <cbouatmailru@gmail.com>, Jenny TC <jenny.tc@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=msMUHdwmfo/xfcbLPfmoqnDcJZxTp37M9X1aU/HHt64=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmhmLC3GIAm/IY+flJvbi3VHvb6P9YrFTIq0uMMYEf
 VBSh9ySJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZoZiwgAKCRB33NvayMhJ0U1JD/
 9NO+kScylVLDMfeKXVFP+OUUlVeTPI9AZGbf4DxR5mqKt9zgrQngmQKMv53XR0PkQOHa+VliOslQvV
 vRazmjM5Sr72dd2yMPruHs9hvLCCNB63+W0yU7V13js59lgzuUnOAQs7o/zsqwMHxPPGbkYlmIFHqk
 e6kx+8WM50gNAI7DW1z223hpYE8ed8O9qGOXHIsoNIJHESwi5/6JG4BdwQNXBwm9IovnmMBVVn0Y4e
 pKS8mgFUjxeKuFvQUvXNDQhWmX4eS3vZ5IhJJQV/54hxCdgfQufaaHpuFfcQBxfFWRyA5MZxZewn6t
 DGWSqeeXgjeMu314yqJpA1QTPD8LyKrH+nhfhF0PLuYLpHKgxMhmGnqCpt6/AhQDgXhCvhEy6IuCK2
 onrhCBv4pzj1d+8SGtkL8HHjlBAXaYcVphHtGrCbkRTWMcx98CRMQy8jWkDD7SVnuuV+OTZXPbdthB
 S2q6hfV63oB3XYgqk1jjGpn2/TMd2G5jR0q8QZhm8stzYHpQvnlfqDMwQYxeENL6kMm/Rptrj3nScF
 KA/79i3M97SGCKlS0lBAh7v918HYanXAKbYtdbW9R6DipWUodg6XMwjzt/XFll4+PmQB+XSrYvY78T
 Sz2sJ0qbQR69BYcNwe91BPT2wnE7qCpdCMHF24eJyr7ltLXsnlfztNsn7Tkw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

If the thermal core tries to update the temperature from an
uninitialized power supply, it will swawn the following warning:
thermal thermal_zoneXX: failed to read out thermal zone (-19)

But reading from an uninitialized power supply should not be
considered as a fatal error, but the thermal core expects
the -EAGAIN error to be returned in this particular case.

So convert -ENODEV as -EAGAIN to express the fact that reading
temperature from an uninitialized power supply shouldn't be
a fatal error, but should indicate to the thermal zone it should
retry later.

It notably removes such messages on Qualcomm platforms using the
qcom_battmgr driver spawning warnings until the aDSP firmware
gets up and the battery manager reports valid data.

Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
Fixes: 5bc28b93a36e ("power_supply: power_supply_read_temp only if use_cnt > 0")
Fixes: 3be330bf8860 ("power_supply: Register battery as a thermal zone")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..b38bff4dbfc7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1287,8 +1287,13 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
 	WARN_ON(tzd == NULL);
 	psy = thermal_zone_device_priv(tzd);
 	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
+	/*
+	 * The thermal core expects -EAGAIN as non-fatal error,
+	 * convert -ENODEV as -EAGAIN since -ENODEV is returned
+	 * when a power supply device isn't initialized
+	 */
 	if (ret)
-		return ret;
+		return ret == -ENODEV ? -EAGAIN : ret;
 
 	/* Convert tenths of degree Celsius to milli degree Celsius. */
 	*temp = val.intval * 100;

---
base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
change-id: 20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-077166861efb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


