Return-Path: <linux-kernel+bounces-382033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B124C9B0818
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60581C20D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994301B0F3F;
	Fri, 25 Oct 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5Im6BRW"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0718991A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869783; cv=none; b=F97Ap/cUfRjYaq3t4cmrswR9dgH7oGKRdRdND3P4RE/2NzVkJB+wL+IwjIv7xTas3+cw4p89d6VRZi2O29aIythVdMFuwLHjRVvJRuADcvrpQp8craajeZ8+0snewiuxjSwCXLqFqImZj1FVkr6A1bcjvPItEY/pxYTaI1PZg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869783; c=relaxed/simple;
	bh=t6vW7esTKKmCQ5gKp9sRNwB5Hta5OAGLFMYVeJjvrYg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fras2V6q2LCOI8jMs6d3pBrMYz5axb7psrwvDxgKWBoVPzE1LiySJHhlk+uRGOPrwMl4nwhy1QpDrXbPw889xqKnZBEuhCUVLeBWNVxF3jXd+IIVuwb/zKHqt2WQhH5Qea/OFhs0+PjBhs2vzi8RdlzATD8m05pjCoZkb6B1iOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5Im6BRW; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso17744031fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729869780; x=1730474580; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6xnxINu7F5AfefZRExBAL+P3KgC8iTCdmrpKhLqDtI=;
        b=j5Im6BRW8ArfxvIk27uwNrKTLtSusgHEnPzGuEfsF5pvm6LHwV1ZE+Me1is+M9u/FC
         jvnR2f4+SlpsidsxuW+uD4XXJE/+76urK4MqxM/gYp+bjCS1ziaX3kHCBuJS0u9WTfiZ
         /duGx0ATYTJH0eZxG780pzyjIEaNgH1tLUAHKzJPp4BLhMEu6uhIh5K3b7C8VuwsoXAb
         FdW7Hv9UqyV10JlhXsebqrPwLwxkbhPWBSQPM+/lNMIRy6IXoI6mMbM07uF5Ay1O8AF6
         BQHuQsJM86UUEsX2KFDzBzjU7SHRuPShonxRwUzGzDvnIr1sl9FKcGKv0QrUrQp8bBNl
         YcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869780; x=1730474580;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6xnxINu7F5AfefZRExBAL+P3KgC8iTCdmrpKhLqDtI=;
        b=NSbxiCLs2gETOWdI0ToMppZ5HsQFsdLSwGxrkkIT6pkL+jPJHlZC0EbkshxWwDkdzW
         K6lMHT/JvYF0P98tR+tcv5XzR8DtOi21NoUhbnkSh9xnraIzT7uibhjdETh7SYMriC5L
         Xi0bswuXh2+wb+414lPn/JBNIdJ8QWHZIb1gTEu6ce6Nvup7aYkCrLwFEPv7P4jG+PZx
         EBHEQt0cEIlmFHsna7R6S6v3MN9CNQHfw4aX+73PG/9mcEzOJDS5eqvpQiT0aw/qVJi8
         uGe9/5naE5Pf1wA0AtQ+5Lwli7cI+RAw8NvyJBJEUfMCqt6j8k01uv6nI5vyofGCgi1J
         7LQg==
X-Forwarded-Encrypted: i=1; AJvYcCWFhg4+xpG41zPvOLeSnJwBYaamYGbzm5MnIY1GLFMaZkLIKqu5Mt6a6KSf3Riu6f/ke6ybu43BJ90Rk3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YysIZow1WPQGsDh424yzGn0xqH/BH3Aau0aLgH1pXmnTHqkimEr
	8f2/KNqHhioES/4eNyCQk0GMBLbW3kNx4QssHKNSJUr7FN1zE4OU+mHSMXqLOKg=
X-Google-Smtp-Source: AGHT+IG8UWU8mQEYw02sf+q2EHvJQ0gEOv4YZ3llUOQMk3UH65PUjT+rFNs1yy4uZG3lYNPBuRjl1A==
X-Received: by 2002:a2e:f11:0:b0:2fb:6277:71d0 with SMTP id 38308e7fff4ca-2fc9d365e3dmr48935291fa.22.1729869780061;
        Fri, 25 Oct 2024 08:23:00 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb46017bdsm2135721fa.104.2024.10.25.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:22:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/2] soc: qcom: llcc: add support for SAR2130P and
 SAR1130P platforms
Date: Fri, 25 Oct 2024 18:22:52 +0300
Message-Id: <20241025-sar2130p-llcc-v2-0-7455dc40e952@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMy3G2cC/13MQQqDMBCF4avIrJsyiWKwq96juAjJqANiZFJCi
 +TuTYVuuvwfvO+ARMKU4NYcIJQ5cdxqmEsDfnHbTIpDbTBoOo3aquTE6BZ3ta7eK/Sm17211ge
 C+tmFJn6d3mOsvXB6RnmffNbf9ScNf1LWClVHOGDfBuwmc195cxKvUWYYSykf9nZ98KsAAAA=
X-Change-ID: 20241017-sar2130p-llcc-0c2616777cde
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=t6vW7esTKKmCQ5gKp9sRNwB5Hta5OAGLFMYVeJjvrYg=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnG7fOU/jJgvn1bphhdetUiO3KzHSiHZFEtfDR5
 LvsxZyGLy6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxu3zgAKCRAU23LtvoBl
 uKalD/93Jml5KyBpgxq+1UKYiKfOxTD3Izlaua1ck2mRK8sMZTTd8Sf65tF1xqd3alDhzZyhlQO
 r6m4p9YGuBOmTfv1/NwunRiG/HYloT31bnHUxAPH/qHXgB8SR1bMKd8fQ6KQRxEhmmfZvL5ae+6
 sRASohrekzkGzT1vI1bfdmSmOdiDU0zCv4CvMd2Dz+cqCsBn0UD8haLWJBbqqjfa7wuVdMAIIbr
 lu5PSAfnEqVjCWiSJ69tuK2nEW44Qc+T3JxgaeEGkTmO8hPXzPusDzl7DOmTy7T4RXYhbLRZM46
 RYZqNIhQn3Ijq1vkfpB2CSjLmUB7r425zucZoWHfpZAB+ixUvTOliTMyr9enrDCPnddxm3kez68
 i65srphbmMxH4rgF8rkyJjP4Qql+A3Wgcr5hF1+f6aHhJk5YQdgg8goi+lWWbmFXFpoZfVRbqPi
 AskGibSEOgyjmMd6Eh5VYBTaU7nl2MEZNYLeYvmEqxA2TE4nvtvvMIrUcL1lxRvFzrWWwc34czS
 u5JgLjDpaVG/4cdjmFH+FmatIbZiTnIr1Kc+Ic0+ORitYXHHnIXydj5yO+4xaR4LwC5zKDPogmS
 eL/3bTgSDbU0x48yt4qRWc6gUKHjIAUt1RDajR1Robkwkx1hC51cpbq5Hey89VAH1vlwzn9FXSl
 HnnAabarPlM55AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for LLCC programming on Qualcomm SAR2130P and SAR1130P
platforms. These platforms require few additional quirks in order to be
handled properly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Added max_cap_shift and num_banks to struct qcom_llcc_config (Konrad)
- Link to v1: https://lore.kernel.org/r/20241019-sar2130p-llcc-v1-0-4e09063d04f2@linaro.org

---
Dmitry Baryshkov (2):
      dt-bindings: cache: qcom,llcc: document SAR2130P and SAR1130P
      soc: qcom: llcc: add support for SAR2130P and SAR1130P

 .../devicetree/bindings/cache/qcom,llcc.yaml       |  28 ++
 drivers/soc/qcom/llcc-qcom.c                       | 460 ++++++++++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h                 |  12 +
 3 files changed, 494 insertions(+), 6 deletions(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241017-sar2130p-llcc-0c2616777cde

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


