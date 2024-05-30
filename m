Return-Path: <linux-kernel+bounces-194821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DC8D4287
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B06B241C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A287CA40;
	Thu, 30 May 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfOCw/vZ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4EE10A1A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030284; cv=none; b=ox7HlcqinmS/v6wuX+gCZK575gGLP/WjcHX4csSGACcjnVM1BUOgno1wnSKrv7rKMVV4B/rULKfRrigqs4sTU5gxMF+S9zZdvqE5yfKGr4j1UiZwRN+tM/RIYDZETfFn/5yMWZHAHDmNf6/KW6GVDMIkEAJDMwcTUAj7pf9uykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030284; c=relaxed/simple;
	bh=qSscqI2jnEaKNqN3eGGmydizc4eKU3xik0L5S+IZ06Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U5Q3djrx0kRbx8wZwSTGZo5uHEVDCAJbA58rJkk07MLPiSIRmc5JWFeoVh7+RPfaKfmCyN1MeLTwV3FjSfBYapJTuFzwyk/V3yeEzNVg7mH4crCA2XvavGRfMeMLtO58TslmMOUzN4ybeWkS3bR2KTs+2IqMU21NgfAJ0HhKNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfOCw/vZ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b119986f2so372750e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717030281; x=1717635081; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz7l99uPeINg02KJ5xTzBJjdXsp8Ze3vOgXKzSKH2IQ=;
        b=SfOCw/vZgONaXKqfUNbD5Cjd6GL7yLdt6oUMm+AXBf5ieM6UUdYwc1wJS1DmnrtO+I
         T/JjYvGZ8Otc9htnuv79MkCj3d1DAN5QQsP/XjJxFJKJIDdHJA6silbVQ5swEcWvXEwg
         UTcLBX62jsOhcQPHbwGkvF6TNQVXob0cbMcmhvJFV6d25LHbS/rbWdeYnjMqS0JpbvHt
         DjP9yvp4lnMYOAyQ34YF6i6YL29L0lcZxt3BjN44/LIm7rQdn1M74olvoWblwu7hs52A
         45LaIWTdoqrM57mihuqgIf1KO0rLZard/rVY7OlLxezVclPELt+3URrIuw/e38slf5FN
         0UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030281; x=1717635081;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz7l99uPeINg02KJ5xTzBJjdXsp8Ze3vOgXKzSKH2IQ=;
        b=rJhaNYHW4nHTM8tt4Ysm0em5r1y+kZWsrHnUKcgEeZTvzu9s1Jm7O0zoEglQoJEhLl
         krzsjDkYdfwShqBZKMxZ9yDdm4fmFEtXNV9blfq5Ha35wYyN4JBjAaV1nRYRpFlyrg35
         jB1ITCsG21NYmGoxGR8El4vPltNgURgxpfVqmX+WjW7/UrY7KB2VfdCUUFyzRvjyzNuQ
         wm0I2UYK43Jeu74Ec+DnlPFuh/lyPJO4DTnXN7nfjyyaGSUOpfF1tcMiDRgFhzyhIMm7
         e8Ay1zIuGLkqpMBrHIQGixwT/tuxYVMdSVQQc7mZigJsSqivjAYn63CEF48ODiaSxKJd
         QTMA==
X-Forwarded-Encrypted: i=1; AJvYcCXVvkOQFhZSQw22QYP8RYDInkRmCIZD+V2kroe5Xdx9iRAujsTMTK2QgXfbQpb7QlkLMoKFtuI33W1vntzxsvXkCF9jG6qrUCEvbNyl
X-Gm-Message-State: AOJu0YyNtvJdX8IlfAEmWZ5tZ0y+Nph8eeKAdb2ManCYtqfcwZxJHq1W
	jxPbiewwvxMZh1skiBlgiD/wQt4qlGike7QuSASESNQk05mBCfmmFCGzjoPGcgc=
X-Google-Smtp-Source: AGHT+IEIQngqhGpjdAJ/DjkazcW5Xs4Brbjw8XK/yqQEIjBE77nR1RptiDJjg9LmtRHYLmq1pdlJhw==
X-Received: by 2002:a05:6512:48c:b0:528:9d15:240e with SMTP id 2adb3069b0e04-52b7d47a523mr332225e87.43.1717030280909;
        Wed, 29 May 2024 17:51:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b233sm1396534e87.135.2024.05.29.17.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:51:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] arm64: defconfig: fix config issues on Qualcomm SM8350
 platform
Date: Thu, 30 May 2024 03:51:12 +0300
Message-Id: <20240530-8350-config-v1-0-d6e871236ed4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDNV2YC/x3MQQqAIBBA0avIrBNGzaiuEi3ERpuNhkIE0t2Tl
 m/xf4NKhanCKhoUurlyTh1qEOBPlyJJPrpBox7RGpSzsSh9ToGjVC6oxUwKiTT04ioU+Plv2/6
 +Hy4bV0hdAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=584;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qSscqI2jnEaKNqN3eGGmydizc4eKU3xik0L5S+IZ06Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV82Hcx4jM2awZXO5tVolhFR9cQtF7qsw9zQpb
 pYtL0c64LiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlfNhwAKCRCLPIo+Aiko
 1aRaB/4rYJXXzW3dj87Q9Rq+egkSpvErKwTcQlpQKJfS0VUhoXAO17JGwrDnFCH2nv0bdEG6Me5
 A1luxqzKPRw/m1/XCm9TgB9PQD1bPckn6PBerRIqRtIOInhcNJHzauMuGefcINd+b9E5qOjqA/H
 rLQErtAYXRVZNIpkXTirPKpmUs6Qu/eabg9dsRZhwt59T5zABx9J0nGtMzoP3Jpkn9en0uza80p
 o6cgSyazldAOF4G99sxxY8fE9RY8RGI5EjTWj07AXsbedlKWW/snoi9vIjhkLzxwdfGJVWc9C8H
 mUeB2dOkmPOLFhYv0vcC42y4A6I6c07zJEbyMSl/Ahe74XnB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues observed with the kernels using defconfig on the devices
using Qualcomm SM8350 SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      arm64: defconfig: enable CONFIG_SM_GPUCC_8350
      arm64: defconfig: make CONFIG_INTERCONNECT_QCOM_SM8350 built-in

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240530-8350-config-1af193610ee2

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


