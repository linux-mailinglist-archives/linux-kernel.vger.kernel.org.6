Return-Path: <linux-kernel+bounces-247989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D837992D710
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A351C20307
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16A195B3B;
	Wed, 10 Jul 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGsgaows"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB631953B9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631118; cv=none; b=B4jotpaHczmBKhytnW06d+tSyo77V8cng9wPKcTlxhKDJ2T6CTUVlwcSR8nkezmbiQZKEdfuSoxv/7UClMEBxKNdl7zG8sitbvh8WUCzpqhAOjmQlopIi/dlwngc/0o7wRJPC4lx6mDsY9gL6G5v2fPqtyStmsni7DTkdJy+cLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631118; c=relaxed/simple;
	bh=y3mPP+gIzqE00dgxHNQadnkkTkyDIlA2uQAKtot/hqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FyguxsU7aoxu+zbwIxnicFm1J4idaVfayS671V9moTgNpOlElyXziaXCZGEpRaFwc/WefCGhDEMswxFNWX6uhC59bQGnv2zDiCjiikO1WIifY08a9mLj7pjURyqbtkl3v/U0abkEps8VnnKGaZrWTBUWyv+owMSEndPGSdnTO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LGsgaows; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so17209325e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720631115; x=1721235915; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO6/lK5/7C6XDmsvIs3cVH295usofusy4WKu+UT3LKI=;
        b=LGsgaowsX3M8QYqgcgDSWCJOKe7jb81lRQ25UGmbb1uAUaL8QMvGE9rYLR94cCkUO6
         I4G0HnsJH41LA2vkBUTAtPxobrAQtzOndR2a6+Wdbpo3EE98Kvyu3aU/gK2JoAeC9wmz
         cWFvXu03aYw66M7Y8xGcRzIH150Xi5WGkoL5aSDnT/Udo76NVJL6N7HL/OfA4F2uCHiv
         OndGp+BqwWZJ94cGYL0pHxsMww3pVary4wvLB6d+E1rnwSLbaMpktxh4g61C4QoXSoBw
         iHjFdzCOWqsfUxYDFPomv8qYOlaHmwQNuFiKZF/hL05APMd7NR+D1SpgA1sd5gf+x8hR
         xzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631115; x=1721235915;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO6/lK5/7C6XDmsvIs3cVH295usofusy4WKu+UT3LKI=;
        b=N/gOCh9Z5SdV9KrWdBq9NFlH8CWycaRwkq9jWvwAEwIn1/IpuPUOBUkx65IHtBju1/
         X5JuXfWksz8RC6+/iT2DX0GolBWW8xCdCNexOBDHnM5yaa9k/IwmBToTFnUQYWJ8jWyR
         8sFGjlgeO9XTFRZo1xd0A14fmpZTfGZR81Pl91jfoK8HBCzJuXlr8BI46349NeW0tN0M
         EmxtK9NjpTx9nfmG4omgc/JX0NbjhBAAfAjLyMPVMWGXwlDO1ANEXgLInJHwP6tuQ/5K
         zUoRDXMzrd48G042KUSAkTYJRyOjsDSpsCSqiTLxlJ1i6xJt7TECqypRMVGo39nogVWZ
         6m+w==
X-Forwarded-Encrypted: i=1; AJvYcCX2zuQ7G4a6IE/+xo2/7B4G+Bm530nwHK8VpzQnXioyMibPtlEUWteBj2TlgiYhnqDqBIoNykG/iglRkTqpCHzcMD0+awbdMLaY71gW
X-Gm-Message-State: AOJu0YxIz/KyV6XgkN7wLfc5uT/AObTurgtpNdXwCIripo15ij9D4XfE
	iqfjZSpvsIEfKq7VvecNKi0lmNZvAMahCmKxahIZfo6FJKFvUoqkTublEjgYxjw=
X-Google-Smtp-Source: AGHT+IEZ/vduzwwhO5K4kQPX85w5VJ3dB+TYQDHXeHNJPj2YvvMVSizSFMwuGwYgtxvCPlkuMJjVQA==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id 5b1f17b1804b1-426707d8a90mr42891675e9.16.1720631115301;
        Wed, 10 Jul 2024 10:05:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:65e6:93ca:5f80:ea9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dedfsm5838446f8f.24.2024.07.10.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:05:14 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/5] drm/panel: atna33xc20: Fix the Samsung ATNA45AF01
 panel
Date: Wed, 10 Jul 2024 19:04:56 +0200
Message-Id: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADi/jmYC/x3MSwqAMAwA0atI1gbSKv6uIi60TTUoKq2IULy7x
 eVbzEQI7IUDdFkEz7cEOfYElWdglnGfGcUmgyZdUq0IH8UNKSI03uI0mnWTebmwKrRrJ9cWFTt
 I8enZyfOP++F9P56MXmJoAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The backlight of the Samsung ATNA45AF01 panel used in the Qualcomm X1E80100
CRD does not work correctly with the current display panel configuration
and drivers: It works after boot, but once the display gets disabled it is
not possible to get it back on. It turns out that the ATNA45AF01 panel
needs exactly the same non-standard power sequence as implemented for
ATNA33XC20 in the panel-samsung-atna33xc20 driver.

Move the ATNA45AF01 panel from the generic panel-edp driver to the
panel-samsung-atna33xc20 driver and fix the panel configuration in the
x1e80100-crd device tree to make the panel work correctly.

The DT changes are included here for reference and easier testing, I assume
Bjorn or Konrad will pick them up after the DRM panel changes were applied.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (5):
      dt-bindings: display: panel: samsung,atna33xc20: Document ATNA45AF01
      drm/panel: samsung-atna33xc20: Add compatible for ATNA45AF01
      Revert "drm/panel-edp: Add SDC ATNA45AF01"
      arm64: dts: qcom: x1e80100-crd: Fix backlight
      arm64: defconfig: Add CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20

 .../bindings/display/panel/samsung,atna33xc20.yaml      |  6 +++++-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts               | 17 +++++++++++++++--
 arch/arm64/configs/defconfig                            |  1 +
 drivers/gpu/drm/panel/panel-edp.c                       |  2 --
 drivers/gpu/drm/panel/panel-samsung-atna33xc20.c        |  1 +
 5 files changed, 22 insertions(+), 5 deletions(-)
---
base-commit: 523b23f0bee3014a7a752c9bb9f5c54f0eddae88
change-id: 20240710-x1e80100-crd-backlight-632f9bf936ef

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


