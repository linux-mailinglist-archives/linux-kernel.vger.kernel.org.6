Return-Path: <linux-kernel+bounces-190192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860288CFAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2564E1F21465
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9583BBE5;
	Mon, 27 May 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iItfvI9T"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7B481D3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797262; cv=none; b=kyYCRrgmcl8kGADHR8RB8ND3ruULklROzAY2t5xuHuY/D6c32DxKw4FJfWDt1iuzCmQBQLPyU4nZGP39TfPBipjCqVfE30VGFsPCJUlaA0xXrO+NqZDkRH7top8mhe/ht+sZb+h1r34gnEQUWd7pe7Y1PxWXo40LgE0smOB+SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797262; c=relaxed/simple;
	bh=E+iR5tlEAlfZnC+rVQBreVq5lRgwSbM9WiLxsmrAANo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kP2OQb5TXRFr9qB4WVP8X6n8u6sba71GkSnzOGtjBbf9UtwUWJXKR06wecuobcHnpp/Arn5V8u7MAj2NlkEmtdE3cfJri2GCOg0Ao+ygRgaTbhh4dHqx5R/u5Q6mQs384eAwL2n/xWbD0xb+wXRKzbpCAzpd89ZCKOPDkQ5+hJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iItfvI9T; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5785fc9c543so2887071a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797259; x=1717402059; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8rlmpxzwNzMUQ8cA/pfzM58szawS5DW3DfVRwdGJXE=;
        b=iItfvI9TXIWjjrY6b0LL2TfQYv10/KrMGtgedQK1UUa3gYUg2BUXBeT7ISQsLfJwGp
         PKN1Mf4jel1i0+mKPXHLgYf3sFKYaJRIVZ6B9bwPxN2nvtKxvTTxnLCLAyH/2DiKQOEb
         sj5i/yXKE58r1TEFij51hmYTPkY6eYF9CJw8Hjuk3cJ6EePZJP7xsVEkOYOXdx/MK0KO
         eD7b6k96iEJ8iuHd4eYRECstrMfj+9urZ+btRUaIqNCD9IoZBXeoqY9O1oZbX36Y032c
         tNawZcN4mPdRusmQZRI3lx1RtoVcfpocsmXwfIVNl7bIwbdTIa/Gp0xO6I7SUsQAJQVh
         KoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797259; x=1717402059;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8rlmpxzwNzMUQ8cA/pfzM58szawS5DW3DfVRwdGJXE=;
        b=lBEGPrTBMpwNpgYLzPoDB+Tj0xQ4cBEfVIG1dd2YtFVgdSu350Oh6bmCKgT4c6V55i
         Lv0Hl2TFQr8y6PQIMDSpnANzdP6Er2KJoPRHTz/2sqPa7NEpvn3n9AqxHJAe9ASq/EIC
         h6WnCuq6v/FqxZZZx+I03x3H8WARGIh9NUiP8Twb9IuEJKehjccXE7+A+yyAjkmHjEUy
         zoDotocCuXWF+aI9pJKz5pjvMbq3UffZwMbf9rjWyzj5n8FjxOmHE90GYde4ueNAeix0
         HrP/x+JnEOQ0OLNkM0AJpH+xv5uiOFD8u9BmT9PLeki3RCSU5g3ryO9f2QsO3eBuIO5c
         rGzA==
X-Forwarded-Encrypted: i=1; AJvYcCVFXew6/YlDy0BRBlRHlZBCypntoYGCpq1K9zPw3GfnP9u4WVNcqh9bxpjzi70BHlG9ojQldoD+pdictPocstqVXPaO2WJsI1kQ3bXD
X-Gm-Message-State: AOJu0YwBZ8BnjApUOyeTMwF/fRUwcJKkHmB3tMHvGBfITKgz+t4DN/3T
	oltWrslouwSGXFvpW/Agyup6SqEEr4l1NVfuQihC1WfyCEyjlpSw+luu02wCUek=
X-Google-Smtp-Source: AGHT+IH7JMLlmgqGQvgmqktxPO4JX1Od8jFxsW9kC/IQAwOqRR0lAJm7NmqmY1A3Q7P5kaVCUe7+Zw==
X-Received: by 2002:a50:9986:0:b0:572:a073:a39a with SMTP id 4fb4d7f45d1cf-578518fecdbmr8736126a12.5.1716797259506;
        Mon, 27 May 2024 01:07:39 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d30b82a8sm1240893a12.79.2024.05.27.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:07:39 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: x1e80100: Describe 3 USB Type-C
 connectors currently used
Date: Mon, 27 May 2024 11:07:26 +0300
Message-Id: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4/VGYC/x3Myw5AMBBA0V+RWZukU+r1K2LhMZigpBWRiH/XW
 J7FvQ94dsIequgBx5d42W0AxRH0c2snRhmCQSudkKYUb+JCkVI4nB6PTXqcVrELZoYTQyYvu6K
 DUB+OR7n/c9287wd2tbqDaQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=E+iR5tlEAlfZnC+rVQBreVq5lRgwSbM9WiLxsmrAANo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVD9AK8L+kFgiFD8Hy+8QcuHfmTkjukM3T8Fv0
 MgJiDcyHjWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQ/QAAKCRAbX0TJAJUV
 Vr0DD/43cs6Rpj8hXHU8OPCwNdM9ikBNarL0NXfTejkbD75lmJwofYWvdEawCgDf9KPK7dpaSAF
 eh+MvDnLYfwUrMPK8f8fKp8mm1xppN/Lw8HZKGTvUrNME4exR5wxgmnCkKSfU8I1Qnn8lpM6gHB
 DLKFuVc2rKgH3UaNfjTBNb0EVMOQxRNohEhVGn8QsQZOh5s6rmh2Ay0CzgCYaqz85GUN1uXElf0
 esw328gGhuez3BfWq+SyWolllBbViTypVW5tUtsebN02dyrsa/xPWKDADHtfZutmutiBvwGT/2L
 K/mRUclDu55sM6J1fSLsYqkK10sJD1IH5j9sRiWbmZdjyX4xXM9PjO0+HRMdRPIUJUQv1d+RN0d
 Rid6WDT3TIT134uyvJxjcefjtH+1ycncGJgFRUc0qp/gOnbcGg/m+QEA4mB5y6JPc+B2KMG6ELU
 ir2jTCN6rose/B3eUnl70/q8qYpUkeEEbfKHFn+4AbHPJEM3jayTWgt9vo016ayeybVoOcqYFWf
 fY11qQpIZD+TY7ulOkOcMZ8kZP6hKuyr22BnVUGYivP4DarONyi0+ngbpCFt8RNFmjNdTTu784+
 yjnFZs06s53tZBMt5y4qCEpUPyNZOd6VMLgIwramqdg2Bnv9ISi0YReKafUDSe6GfejSEgGMI26
 Bu4nm2oQbGvIpAQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Both QCP and CRD boards using X Elite (x1e80100) make use of 3 USB
Type-C ports (USB1 SS0, SS1, and SS2). Describe the graph for the USB
part of each one of them for now. The DP port will come at a later stage
since there are some muxes/retimers involved, depending on the type of
board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      arm64: dts: qcom: x1e80100: Add ports nodes to USB1 SS[0-2] PHYs and controllers
      arm64: dts: qcom: x1e80100-crd: Add pmic-glink node with all 3 connectors
      arm64: dts: qcom: x1e80100-qcp: Add pmic-glink node with all 3 connectors

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 143 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 143 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 123 +++++++++++++++++++++++--
 3 files changed, 403 insertions(+), 6 deletions(-)
---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20231214-x1e80100-dts-pmic-glink-65e351579b8b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


