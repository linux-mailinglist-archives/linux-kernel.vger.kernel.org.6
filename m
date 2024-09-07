Return-Path: <linux-kernel+bounces-319918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254999703B2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD31C20DD1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD416630A;
	Sat,  7 Sep 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrSf4eKe"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8A4F20C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734903; cv=none; b=Kuo8L0M2NOjfeuv4y8usjF5ooZQW86Lh2Pv+m4pT1bzeX7uia0wF3cJgpzcIYEGffR3EYxP7et3GEIE2UpueS3gXTyvcK2l4TPmoSIIQ6woCIpBZpOI9xrURzbiRA9gwR+pnWd9Tt5WTgLxfHRbQq6Pt6gFjE9JPw0u224yeDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734903; c=relaxed/simple;
	bh=j2MGhLcuLoVLWg4I2MuE84ebYpICQobwJaU/0pV8mPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pr6P5vZECtsRZkAFZzBHEun3+UOKa+s9faU71pB5TnqUFKaIFHczDngqtT7B387O0lvncRvN1PxJd2PzJaqbSyTgrLWi7Rf/s7N9hAi1VI+nPHTzM2Fn0dEWzI2zz3UopUJoS8Yg6SvgLZFQi+eW+u6nUrYOz9UwdNE3AXfRey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrSf4eKe; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75a81b6d5so7986261fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734900; x=1726339700; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp2f3Cd3xUZZx5mV8or2w5DKaQxEUtdkX4okocf5JKQ=;
        b=lrSf4eKeCGw0Zbt9xC6Ytpy9WweIfTbF0LE9YUJF3knYkZoIf92YhVPTjIasxJEywT
         uVI8f64tnmx6Y8y4WgVBmtGjyAeHAbvjsqcyzii7N/YUIrPmGedJ3ooh9rbTl+XDu5QA
         4Lzgmw/7AkVXaS2ZKIGDvdNbNL+8gjj0s/83IweZtq48F3seUjrpxxkxZ+Cg0PDcB/DW
         d8oXE3dX8+CZYkGRaM1IKmi8rzKYdJSuYkz17UakWFLkOsfkNdgNbCcAXXr7BDx3/fmm
         EwhzXBH7nPrSdNA6IXHwva5FQhpc4dW4Q+YWcPrImzP5FDjmMI5PJQOo1JkKq/puRUro
         Kxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734900; x=1726339700;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bp2f3Cd3xUZZx5mV8or2w5DKaQxEUtdkX4okocf5JKQ=;
        b=mf6Frbwt2w3TNIgIK1DGl4fg5CLnfso8YnLCnxsIitqfF5923e/ah7wDsw5Qh2RHSW
         hXu3Ptk5PSDwFL1yNh9bfhpNwD8AET7WZJJZGtaa8+o6QFnCTeuGJNEkQxOfiMKBzrfF
         tMUSrj3ECua0mWLbyhpUvuUxHXhDNS9phb/TzddgHSNal0+48KtM0V0bhkB/7wvc8k6v
         eIXDZi+McJr5O0sNFK6omB6q2jstqVnunb3P04e1zfwW4Fd8H46LxLIoR+1HAq7AWp17
         RVwaAbGj+9KUA4T6gJFvtUMb/Qhv9ovrAvBXc7yhI28CtNGaJFdBQq0Eak7mSRYmNTff
         dnUg==
X-Forwarded-Encrypted: i=1; AJvYcCXShGZuWR2yxjTLi2+1zVmjk5fcjI9VLUv7cASxueSRIg7n3qC7NW/7COUKTsWNHVPeC2QSR7mTo0S1QKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHr4vSpreMy/a9iLQr4HGsKS1KyMspX18QQEOJZExXM7lEYRw
	Auv2mgvmV5/jVjkZmNhIBD6BXMFhlfF3Y109W+k5nNfj/qD22woTkbPaVrm4PUg=
X-Google-Smtp-Source: AGHT+IGO0WNu0PFOcRrTUtNd5FKi2izDYAt1p3P/Gtjx0bVcVZuQjc3v0I9yiOFDdx9qV8/gFlWDQg==
X-Received: by 2002:a2e:4c19:0:b0:2ef:2c0f:283e with SMTP id 38308e7fff4ca-2f751ec89bamr35682181fa.12.1725734899190;
        Sat, 07 Sep 2024 11:48:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/7] arm64: qcom: sda660-ifc6560: enable GPU and WiFi
 support
Date: Sat, 07 Sep 2024 21:48:11 +0300
Message-Id: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuf3GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwNj3eKUXDMzA93yzLRM3URTi1QL8ySLNPMUQyWgjoKi1LTMCrBp0bG
 1tQAf8W+jXQAAAA==
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, ath11k@lists.infradead.org, 
 Kalle Valo <kvalo@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=j2MGhLcuLoVLWg4I2MuE84ebYpICQobwJaU/0pV8mPM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/s3aD3giiWStxq0Uq71R3ZAHngRAI9exh4S
 gvabAQfWrKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf7AAKCRCLPIo+Aiko
 1WpICAClKoPTaFjA24SOWFpGheQP76MScFD8h1Cc7JoNZyGlm/c9t3JtblTAopntkVLPeWJ3e/R
 weoly+63q++LVTgHBNDieyj/sKCanLvE/GbQdmsaQfZUhorPpYC2nivqtNLjxEduVwDZNQ0Oivd
 e2g9mjU/97PGn+LIx9M4O8IzAYqd5z125QWqX2An9MwNmzZZkfYd1NsuKzQMFqXSPl0oSU8CnfQ
 RdgDEKYZJQfPFWInCTMpMc6D68DYCBhrkvC/z0jyFvcOeuXdAGl2xFzObLWF4eK4cWmETcQseuC
 NgOMqyDQ4aXXsSqhzTnVB0VWFvFE5f7tVAq6VeA9Z2nrxz51
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the MSM8998 example and limit num_context_banks on SDM630 /
SDM660 platforms. This allows Linux to make use of the A2NOC and KGSL
SMMU, making it possible to enable GPU and WiFi on those platforms, and,
in particular, Inforce IFC6560 SBC.

Note, while WiFI starts up and can work for a short amount of time, MSS
starts crashing with the following message:

qcom-q6v5-mss 4080000.remoteproc: fatal error received: dog_hb.c:266:Task starvation: diag, ping: 4, triage with owner(d.dump 0xde5825

Note2: DTS changes should be applied only after IOMMU chages get merged.
If it is not possible to get IOMMU changes into 6.12 in its last days of
the merge window, I'd kindly ask for the immutable branch from the iommu
subsys to be submerged into MSM tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (7):
      iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660
      arm64: dts: qcom: sdm630: enable GPU SMMU and GPUCC
      arm64: dts: qcom: sda660-ifc6560: enable GPU
      arm64: dts: qcom: sda660-ifc6560: fix l10a voltage ranges
      arm64: dts: qcom: sdm630: enable A2NOC and LPASS SMMU
      arm64: dts: qcom: sdm630: add WiFI device node
      arm64: dts: qcom: sda660-ifc6560: enable mDSP and WiFi devices

 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 32 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               | 38 ++++++++++++++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 11 +++++++
 3 files changed, 73 insertions(+), 8 deletions(-)
---
base-commit: f70cb2e8ce3f8883a526a28f93b7744d1a1a9ce0
change-id: 20240403-sdm660-wifi-a58e87b8f7d1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


