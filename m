Return-Path: <linux-kernel+bounces-259843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215D939E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EA1C21ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECC14E2FB;
	Tue, 23 Jul 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLjiLbGh"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4E14D280
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727535; cv=none; b=JBLz8BYvwqSH3QgEdBODC+EmuWYM3ePQilv9rB2QdmQ3QPNLEghH2RGhI4Qy2dgRiWsMCLnBMpZnBSedwKQfKMEtxCgyKGcLOYNgZ2uZMkO4QXDp4VxYg8vNWBZq+/2dYDsdSGlBiRm8qFdsRkoobr2eyX0pjFpIi1GgzPUk4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727535; c=relaxed/simple;
	bh=V5cD+v01bU89IZjF8zWiQtINoORB56hD9c0ATcYUpFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n43NlSxCEmoGIoq+Wla8wczaSItgyhcSzSoNiqV0z4eZJDgCNZDaJcU9o/X+LqqayyR0iBRV0ezC57C1aROgBJm7HZ6m9wegMVqfW8kOd3QeTENQi+QEu4xvDG88lFsZytUju756We1BinPaejSS13oYF0lLKkSpzwPr0odJ9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dLjiLbGh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42797289c8bso39751985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721727530; x=1722332330; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT8KK8QFNLGrx2pEBPaEZTvQziPUaAsWcAU8RB5dc0A=;
        b=dLjiLbGhHMtq4WEb5QYChnGcSosR3slW7T6CRpYD9MUvNz6TK91dH2dSYJbcJjM9M9
         oBm/ye9td8uyurnbn+tYz9+x+i9fI4HcWpFMIYmvC7K1yoxS1TEHJ85e+j5u3xtV7oA4
         1cOPjqS4Ud5TfO2QK6wsB5QOT5vTd2JqOM9cNGX5fuQzZCM0YVODmxAa/UWpwFLFAvuY
         gyY9LzS77xjqBLKc800lDkidsL1l1tzuo6Pzd6kQKyAo2f+SxKuWZ9ZcJb+67AUzr9YC
         XwdnlUBfEaKU7g8XmVONYkEPUOXANsfmTO+HjaHngYQ5TQSlu3d2OVbUGMUD9bII1Mzg
         k1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721727530; x=1722332330;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT8KK8QFNLGrx2pEBPaEZTvQziPUaAsWcAU8RB5dc0A=;
        b=d1av73zrTbBKNnmZh9e/eGqyWq+owIi4LIW7CqjuESQM3sGwGGQ98DdGCzdDLP6HsN
         onI+BV1hukez/7Dr5rLi+vvqZ5euAKulFtRnJIvqWCY+so8lNobgZbOaS6q43UBl9Iny
         nzkWVvIfubtplTBxwBNBw/xc12oTuX63DI9ZM51ibb6ZqVzrdIDz1/1UDs4AlzKHAHzH
         MdP0PSTNAdPPTAuTz0q+idnE2t3FiZO3qBrZevMG4KWFClcYYeFVolizmyzPmcdQ99Ir
         /tKYT22D1j0WDskU/PGU9LrWhoGEY71oGnFACqD/nLrr4p2srkND1nzjykhfMYNoGm4h
         Bqng==
X-Forwarded-Encrypted: i=1; AJvYcCVIapEoJUsCKqKWEMFIU2vjwS+JhNXQDYkTYtLHm92vvqi0LEYnUC9QbNimwuzqB2FNKyCldD1iMcwPbyLKEenN0WPiRoIcXN0LJ7K5
X-Gm-Message-State: AOJu0YwBH4m8A+nLvtXx7YMql4VFrLk93spy/nrCXK+njo0wdPxVg6wO
	wn7HgzGXFT9iyNTV7ef5SpmhSK99/ui26K3qIErrWiH35fe28vbeWK4ighaiCgA=
X-Google-Smtp-Source: AGHT+IEXxB7K34amU/7o/fs6MOk5nRp6AFdaJrDuJKtFTJ2WdhTVm630EYls9qGTtKvnCVnpsnEcFw==
X-Received: by 2002:a05:6000:10c2:b0:369:9358:4634 with SMTP id ffacd0b85a97d-369dec15cedmr1538753f8f.19.1721727530111;
        Tue, 23 Jul 2024 02:38:50 -0700 (PDT)
Received: from [192.168.1.191] ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878694637sm10953345f8f.56.2024.07.23.02.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:38:49 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
Subject: [PATCH v2 0/3] arm(64): dts: qcom: fix dtbs_check warnings for
 qcom,spmi-pmic.yaml
Date: Tue, 23 Jul 2024 10:38:48 +0100
Message-Id: <20240723-pmic-bindings-v2-0-e1cd614f8c4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACh6n2YC/3XMSw7CIBSF4a00dywGrmC1I/dhOqC8ehOFBkyja
 di72LnD/yTn26C4TK7A0G2Q3UqFUmyBhw7MrGNwjGxrQI6S94hseZJhE0VLMRTWq7P16qK9Fgr
 aZ8nO03v37mPrmcor5c/Or+K3/pNWwThTSl0lTicjnbg9KOqcjikHGGutX4tNGRurAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rayyan Ansari <rayyan.ansari@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=rayyan.ansari@linaro.org; h=from:subject:message-id;
 bh=V5cD+v01bU89IZjF8zWiQtINoORB56hD9c0ATcYUpFA=;
 b=owGbwMvMwCXmtuJiX/SRuS2Mp9WSGNLmV2luYDOprvpQZ57TWs1/6caUxFldDf0rjj+7lxqwv
 0cj0oaho5SFQYyLQVZMkeVw05c1r7c7CV3ZXnUKZg4rE8gQBi5OAZjIr1aGv4KdbMnTrXbOmG5R
 tP/ur+a2G9cEvm7wu+tyzWP+u/T+L1KMDKeDF1o++bf6uX5MavpMzV2HwnjWiDxxrF+3hI3V2FN
 6BxMA
X-Developer-Key: i=rayyan.ansari@linaro.org; a=openpgp;
 fpr=C382F4ACEBB74212D4B77ACA46A8D18E5BC49D84

Hi,
These patches fix all [1] warnings whilst running
make dtbs_check DT_SCHEMA_FILES=qcom,spmi-pmic.yaml
on both arm and arm64 qcom device trees.

[1]: There is still one warning left that was fixed by an earlier patch
by someone else, which has not been picked up: 
https://lore.kernel.org/all/20240606181027.98537-2-adrian@travitia.xyz/

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
- Link to v1: https://lore.kernel.org/r/20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org

---
Rayyan Ansari (3):
      arm64: dts: qcom: pmi8994: Add label to wled node
      arm64: dts: qcom: pmi8950: Remove address from lpg node
      ARM: dts: qcom: pma8084: add pon node

 arch/arm/boot/dts/qcom/pma8084.dtsi   | 15 ++++++++++-----
 arch/arm64/boot/dts/qcom/pmi8950.dtsi |  3 +--
 arch/arm64/boot/dts/qcom/pmi8994.dtsi |  3 +++
 3 files changed, 14 insertions(+), 7 deletions(-)
---
base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
change-id: 20240722-pmic-bindings-756df58afa15

Best regards,
-- 
Rayyan Ansari <rayyan.ansari@linaro.org>


