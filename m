Return-Path: <linux-kernel+bounces-372950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881869A4FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F24328781E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CC18D65C;
	Sat, 19 Oct 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onXvAKGi"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2C14D71E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355210; cv=none; b=GWQF/sJG9RyTEhW94F4VBjmjcWDopQL9Omi9gy5DyFISTcEOXQPPr+I4uTLtMZZtPZpIeh8RPOqHSZp8DZe/m5MW4RpFz93jISs6ITIV26u5PvbB4jDvfbpoT+0JnTG2mZjtQdjVjDdHd97YNTvc2W5qWNxk4DwHkN/0bQtZLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355210; c=relaxed/simple;
	bh=wQjSFVoNISEHr8fCM0b1/pIc5deyH+KtST3UOANpAuM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMx7+Oe82CgaWZQMduSmvxMl0FTsfY5dNubXnRVO2Ea8ja+L0ZQmCqVeH8tF87F2p7ux4+BF+93+Fw/3zP3Q2Y7kDseod6XmqIxKGwAG26qnqe4yMP9HRRTpDcnbvH7cu5NJJTZNtIt8l50uCBxC8fkX2Czeecn88AdFXGhyooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onXvAKGi; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3136843e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729355205; x=1729960005; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYl7eAIn+5ESJxB2DQGxAO8WG66UPG/0HvfLLBVG0OA=;
        b=onXvAKGinYGvudZSlwE6nuMGEzIRT4yHJwi8osCEwSA+EVw3EWn2LZVKftq7lgPKd3
         aA5O8b2svvbHH+otum0nDakbFjRpDxBXdLiKY1FU038tt7u6XIAAvZTpTPUiCyPoJOEn
         7aJQi2lqZ/woKzFlWIjSOf1LZRZE/hYsp40UaVEtd9HVLF4NNsyiUEvz/JoEskNsxcaM
         TKOF0aHGsE0yi3SLv5KLJ5f7ixouN9HP98NTtNLKDfHhu2sgh6fo7tOgnsD/4PaFZOVz
         y0wfXQFnzAf1OHgtYwShAlCKcDXi99p2WyRseP7Kauj7iY8AKycixvtVfr2JrAZ2bLNc
         qPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355205; x=1729960005;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYl7eAIn+5ESJxB2DQGxAO8WG66UPG/0HvfLLBVG0OA=;
        b=rFbeYiZnFQ68zZpmukkh1f+XIwvu3HURWyMXUeXqdoWYwNsX+ZW2l5qT0AAJ3wwqW6
         2/zo3IcHo2NQDFl5E4ikLLqhKiQkXWloHvHqF2ncGhS8dZxUjpp4pS5iMCtoI/8hBLK1
         Dra6OEGnXikQ53YpQSyAStkAEF1YzXG7oDFvSlIuR9y21W/AiZ9mJVjObhgzTrpyyEKp
         Reze3VKuA5d3xHkm/nIX4Mm/fYjbKA4hsMECuQ5wiGMlvWzxsG3Euzc5SzOvsJMIj0hL
         aOCnvMkZfEtAInYjW+nqvivtPTWFdIkBzfKubKdz5QtR7ffj2nP+29A6MEh4gFfMaNpR
         UJmg==
X-Forwarded-Encrypted: i=1; AJvYcCWoSY8w40Ctk7CT73cJXxQiWR7VSG98kEnpVMZOO7PMDAtjop3JoUcZ5ZX11IZ05HYvXxDmXKm581krEaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRvLvY5tLwkDNEc4vLkLqWIRE6bcfIeQKHpBJF43mgTrALBxi
	xILxqRmGapwJiDhZ9iVceSgTzeFqN5kDP6aS8vgBEu1HDki3p+ims6Qw5UujsYE=
X-Google-Smtp-Source: AGHT+IGaqsyWbEz3DYvbfKc2AVUNk0v/sFDEs2rxAqu2ZG+qwEokm+7g41PFxuZFhVGGgfbRohwagQ==
X-Received: by 2002:a05:6512:3b07:b0:539:e4b5:10e5 with SMTP id 2adb3069b0e04-53a1520bd47mr3231756e87.9.1729355205017;
        Sat, 19 Oct 2024 09:26:45 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0c65sm576590e87.125.2024.10.19.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:26:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] soc: qcom: llcc: add support for SAR2130P and SAR1130P
 platforms
Date: Sat, 19 Oct 2024 19:26:40 +0300
Message-Id: <20241019-sar2130p-llcc-v1-0-4e09063d04f2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMDdE2cC/x3MQQqAIBBA0avIrBMcC4WuEi1inGpATBQiCO+et
 HyL/1+oXIQrzOqFwrdUuVIHDgro3NLBWkI3WGMnNOh13YrF0WQdI5E2ZB067z0Fht7kwrs8/29
 ZW/sA1H12Y18AAAA=
X-Change-ID: 20241017-sar2130p-llcc-0c2616777cde
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=wQjSFVoNISEHr8fCM0b1/pIc5deyH+KtST3UOANpAuM=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnE93B/pzn3+3LyTte+MrQ+DJyVAcJIg06gnE2K
 dwBryWzPxKJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxPdwQAKCRAU23LtvoBl
 uPN0EACG4R/xfuC/Ymp/C6RrnLUnozMOJpkoFWokjLwvmLHtV4OO+CshAhduqYBRXZTBsJoRiIk
 gjHnTPpf5uvoqUHSuDQrheNT+cqs3dcK6dONuxChUmnym3Y/oCn+qW2NmmeshICICCWOp1Gzg71
 H9dl+7TdAR9yWrnwiOy/Hb2cxm1Ngel6FIiscWmTG6PLRe+n5ZNQnECoJd4bftfHfxGyfwRYqWX
 WjKiJI4Dg33iKo8RYVd+ENArOnlxSBL4eWpDtlTlzm1Oo0mRwAo50zV1J7C89/QACTFRd34p+vS
 pQFGWZVpLMOrGl/aeeY/4T0GCCHwyDX5h/XcWr54QWWWHs1dxDu2ZAiHrPVdhe8E+zlexeJ03eO
 PdSQ4UIQ1jIeqkGOrNWP6V+r6zKndjySVocq5hYNtHizzkmv6qTTkYmYrrPIrz6EYnKzP69qWEi
 2Doh0tZFq2X0He74eTeYQkk8zSwyUQhEATEBQUcUkEZ2jlQDF5qO/nKm2kLn4g+K4QqucMPnJXm
 NqTYLGuXNgZ5O4hsiNRPITQyBVcF9LZImeO0DH7mVZKfjg2lCQk/4mXCA04xVoxM3aGM5bLZ4Pa
 RVlbF9DhMO9hJjGXlB07xoMlV83GRocxxi0lwvjW65u+IjbidMnsUq7KHVhiMYWgIVSky5SAdRI
 hCscbKxICLNMdUA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for LLCC programming on Qualcomm SAR2130P and SAR1130P
platforms. These platforms require few additional quirks in order to be
handled properly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      dt-bindings: cache: qcom,llcc: document SAR2130P and SAR1130P
      soc: qcom: llcc: add support for SAR2130P and SAR1130P

 .../devicetree/bindings/cache/qcom,llcc.yaml       |  28 ++
 drivers/soc/qcom/llcc-qcom.c                       | 468 ++++++++++++++++++++-
 include/linux/soc/qcom/llcc-qcom.h                 |  12 +
 3 files changed, 502 insertions(+), 6 deletions(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241017-sar2130p-llcc-0c2616777cde

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


