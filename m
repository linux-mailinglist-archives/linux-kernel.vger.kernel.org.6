Return-Path: <linux-kernel+bounces-214559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E5908669
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F4CB24ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29783190079;
	Fri, 14 Jun 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiBYYl9A"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A37190044
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354140; cv=none; b=IsJ/kDSVJwNp6l+tE1BjQO3wQpnz6EViVz9sUhTH2ttD4yHYzyNjKZW46lrUlIGRIaG2EDiqgdjOGYD7+28nODYW+oLYG1GB9Bmdba2/L/p7Y2r7TBd+BShXAszlIPkx5zYHuqkGcGbuU9mTzFK3eowSe9vw46ylWVbup90pPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354140; c=relaxed/simple;
	bh=aXVVMd280kDEU99slp/goCJdHS5H7XE36h5Z2IJXkXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XchTNt95ovjs2d77XfxtALufeNTh3Nuwko9y4Cd+Zx7d5JqZytjRQztMWj/b4sE3OSVK4WLHULOLI+OKxJBgmRDDpUz327p4db7phFaOXxVF0tc4yGHu62BqrZsIP+8f6Xw5FedhYgss1bRwXuXhXFD2pbckd7UgtU5QRzVIZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiBYYl9A; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so2132621e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718354137; x=1718958937; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DHzKRpXg9J/TD6lO3tM3V685Xzbxz5fbjLyyBJ38qc=;
        b=AiBYYl9AgQSz78/B36T40zgA5eWZZ7WDFadxFYnp4Xie2QDx7P/VW696SF+11v4NwM
         tD36IOs89OtP9xBJYCp4YPmQwemb2rNnLBm6uORCTgT5QXZh6SEivgmAgBUR0zyc1VZv
         nz/Jz/RZwiq18hkb9Vdw65WS3NZZz2TE/Uv98FSYkQQVDOCXfJJmTt96oI5CU1ZMhCt+
         7TVJ7mgXTlnlMeYjNmBDNcJ/78BTrRPvQl6Cc0nee9kOdghXRHhhan+0dNNF5GoVsUBS
         kZH2gamR+uUmFDDnO866H6lvGcJ58kbcnR+wMtvaFbfawGfHp5iyrbA4F1QDGEG+pISx
         vY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354137; x=1718958937;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DHzKRpXg9J/TD6lO3tM3V685Xzbxz5fbjLyyBJ38qc=;
        b=C97hsgJuooPKDU40D5df+PGfr4O6qo7sVuOnuxRHwugUV1ymuquMT50lQhbgFpzSl9
         dgA8XJMSES19eYlCkfr90xDPHT1oDSkFHnFLqxGJreQQuRI7mpzjq5OUH2CyhwMt4mHW
         Gf4n1aa7x+ppkb/uboQmOt4hV2n+VDIVvrzyDQ4PvwQxKJlSyYiTn49pBvHklavEncut
         0EBd6k01LgBNQT3C3fki7qYA6V3pnY9ewMhsXhXsMJPdKw10+ufNR2H0KKitVPqT9pkj
         /zGoLH8aj3sVoadIiTpKvWEDI4V4HIKUtV1JX0GDVbgIwCJG+dDnrEgiT6ENEvSEI3mU
         XcXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX25ba64IeIrTbSiIrroz4HEMbNwo/J1jHaqMh7hJ1cVPmGVT8rpaTyTGeg3TNC9BeyeZwJ582pPTlonSGL8GbtFumfljmU+qE1jj83
X-Gm-Message-State: AOJu0YwXMzjKU/CAtcNO+5Vuo1R8rfGTMH1EMiNr5F+I4VMf7zBLH114
	i32v8xAbxa5b2TLUmJImeDfJLI51Z+sKraeXhS2nLw0S44LC0RNwyuxisWfgPru1LXOoN4XMMKa
	nVCw=
X-Google-Smtp-Source: AGHT+IEQYII1Qj2KahNl20kfi6Kd0iMIEGFVS/P375Teoc/Ydgcxx2q5cNcvZc4KM7O23+ZS+5UwLA==
X-Received: by 2002:ac2:5929:0:b0:52c:9ae0:beee with SMTP id 2adb3069b0e04-52ca6e90a58mr1297191e87.49.1718354136880;
        Fri, 14 Jun 2024 01:35:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f1dbsm444776e87.110.2024.06.14.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:35:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] phy: qcom: qmp-pcie: drop second clock-output-names
 entry
Date: Fri, 14 Jun 2024 11:35:33 +0300
Message-Id: <20240614-fix-pcie-phy-compat-v2-0-990863ea53bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUAbGYC/32NQQ7CIBBFr9LM2jGA1FRX3sN0AXTaTqKFQENsG
 u4u9gAu38//7++QKDIluDc7RMqc2C8V1KkBN5tlIuShMiihtGiVxJE/GBwThnlD59/BrGjFOGi
 y+moHA3UZItXaYX32lWdOq4/bcZLlL/3vyxIFdsZo2dqbuoju8eLFRH/2cYK+lPIF25jAkLcAA
 AA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=aXVVMd280kDEU99slp/goCJdHS5H7XE36h5Z2IJXkXg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbADXrUm9cJ44C/Qoh4AWATZBW3PHxHeKo1RHh
 gPK0/xfq4WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmwA1wAKCRCLPIo+Aiko
 1QuOB/kBXJliWLone1Vftys+maL+YWswmOnQbrJaQc6CEa3Mie9hAeLIx8NBcEIIXS5NYMOuOOd
 UCghRsR0hPuJmF0uhQZ8fSVchGAjzz01YWZbj7PVsdM0EX20qN5EWZAPhrUY5n23FqZiVnujqL7
 lwh+pD6jiErEGx4UZWJS6/4SHCK7h8Grzgi+h7Gsvl5TKrmwIXG6CxIcgTJeux46gUm/ak5tjza
 qUc3JlGHT4cAKtobXjt7QAqIVGDxSH7OQrnBYIN3WUnWP0wK/v8WbYwZVF4xuEqjXQ89NLYOhzb
 6aM5Mwg1u1mmPX4hmyuh3856QQGpinpPcwVipkAywFo8+ZVF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While testing the linux-next on SM8450-HDK I noticed that one of the
PCIe hosts stays in the deferred state, because the corresponding PHY
isn't probed. A quick debug pointed out that while the patches that
added support for the PIPE AUX clock to the PHY driver have landed,
corresponding DT changes were not picked up for 6.10. Restore the
compatibility with the existing DT files by dropping the second entry in
the clock-output-names array and always generating the corresponding
name on the fly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Fixed generated AUX clock name (Neil)
- Link to v1: https://lore.kernel.org/r/20240521-fix-pcie-phy-compat-v1-0-8aa415b92308@linaro.org

---
Dmitry Baryshkov (2):
      phy: qcom: qmp-pcie: restore compatibility with existing DTs
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: drop second output clock name

 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 7 +------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                         | 9 +++------
 2 files changed, 4 insertions(+), 12 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240521-fix-pcie-phy-compat-b0fd4eb46bda

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


