Return-Path: <linux-kernel+bounces-172517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F48BF2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A07B21E31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D012F5BE;
	Tue,  7 May 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4WaEWPg"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C112DDA1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124540; cv=none; b=PHDUbdazwOhTgzYMSmhhAiQnxSf60NsomN4EPCgM8CcpR2vFLdF6eGRdso597jDmDTqvH0JrFP09Lkjaz54R2jBEC52ll/IyEZy7YfTrzLAWlaMcPB+VzCKhwReGibOZKibOFrLDpYsYXOMnG7EsfzZWeS7uI9Xw8wouphCxUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124540; c=relaxed/simple;
	bh=6N7YQ0tqw4GK3rBRagXlWIy9Y10OPMOiuDCFV37xTOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lGy5jx6IP2nUGRRxYxMOVIiBhh8vkHQxGLEGrP6ZCOAbXa73vaQGTfTVQpmRVZRKO3IA8RNRb+OKmiO5Xk2ITLCX9WR3tSmhYD89tgdBrDlrQoQuMUrBmnPi4isIw8GwKxBkgWY9+FHJUCV5XUIMyRmeHywJQuVqLunwAMBue+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l4WaEWPg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2df848f9325so43721031fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715124537; x=1715729337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZnivb6l1xDPNW5GpJEM2VTzatebi8iz4jebWhunJco=;
        b=l4WaEWPgsGXjk/8nafmVi310JcynF/KQatFvGiz6/dON5rfOjLwPgioNNbG2ftga2D
         0YceC5cqb5Liwh5wfwxFRkkI8CIiWLTG9cODSp5uE1nP1VjG4kY7LpJP08nM5CPBDWk5
         xZWMYqisdYMo5O2sZ3Dp+zKD3rqFTwsfDl6Gpuv/Y3LKRhQWKwFvHXoMZKeISmcJCg29
         FZcj4lmmxDmiiSUYL4DR+HWNApwFb4Bkt4qi/x6lBVQZSsZcQuUnvv2HIhFdOllN+ZwM
         aijbe2e/GfMhz84I2tKd9hI5jDZAFdvZ/3I8zhupt9h5YECXN3VBBzVZtmf77oSKQQa9
         tu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715124537; x=1715729337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZnivb6l1xDPNW5GpJEM2VTzatebi8iz4jebWhunJco=;
        b=OjEAjKd0LvA65p2GNfvk+QdnLBkyqn6ivVudg5pi2EsgMZz1fQ2+VOjUkhXvvUiPiH
         oAX2+62S50QQwLnMHkrjfnwvAhlu1WGtJ7naaFtB/Jhdw2eq7vjp3wqBe6eNHS2lCkif
         vLfXi3+KoJDY2lwPGjKJUG+/wKAw+nYG+88X4U51+TAaD59zrLIJsb++TpEs4ZjQoQMU
         EnKqkB0qvPN6miQ77iEn+61Cth2IkVZN3z9Kcxugim26TeWoV1vgTrbjtSQDNj7gU2ez
         38JSUR4o9OefKBN9JZexPgYzcRT1e3MwcwWvirNEb4k9yZskE+FYEOsxIF46AwkOdW7K
         guNw==
X-Forwarded-Encrypted: i=1; AJvYcCWaDf1vuNxQ6fGk4M6NU0TkrVmQqwNrFACoC0Jnllse/yLYc0zp4tZf1HdP9p6SpyEUymhoIKPZy12qP6PbJY051K4m8J/TOHcPGuyH
X-Gm-Message-State: AOJu0Yymyk1u3MTdKW//B2ST6gAeiCpzc2xPSOEG1muisLZro3lG7ue4
	fuoAoX547tve4m9a7qZ8ZAIQvS3VE1uwCydOTd/TmpIQz53g0upx0DPBmtlS/OA=
X-Google-Smtp-Source: AGHT+IEPiXoxSzLzRXgrv9XDV9vtUW/h06YqEXe8uksqmJa5e8EscDHKjV8RrPV7tXMeqhjdWBg8Yg==
X-Received: by 2002:a2e:97d7:0:b0:2e1:afa6:9291 with SMTP id 38308e7fff4ca-2e446d7a622mr6991041fa.8.1715124536837;
        Tue, 07 May 2024 16:28:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402195400b005725c56b35bsm6851841edz.71.2024.05.07.16.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:28:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] qcom: initial support for the SHIFTphone 8
Date: Wed, 08 May 2024 01:28:46 +0200
Message-Id: <20240508-otter-bringup-v1-0-c807d3d931f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC65OmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNz3fySktQi3aSizLz00gJdYwuL5DTjxETz5ERTJaCegqLUtMwKsHn
 RsbW1AHe6n1RfAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Martinz <amartinz@shiftphones.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=6N7YQ0tqw4GK3rBRagXlWIy9Y10OPMOiuDCFV37xTOw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmOrk2B/4XeVkV74lSsQlHo/KIqvv30KzVQVOou
 8C7/EL5ezKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZjq5NgAKCRAFgzErGV9k
 tpPHD/9xh8ILKiI6drHKQPf2GAlPWWACEWKpC70RqEBfpRSwCzDoC3nh7TupxrCt1UdFLeoN5i3
 rGDTOxM+BwP8AcvCIyVw6FUetbNQG0tm4BIgwFx0vNFi2znWY5TTm6rsuJh20C8Rd3x0fkN/ydf
 5arNFbKWVJfzfMkeRKqfE82ApbS4LMcOAcLTEq90Im7zJntJR/zrAPe0viHd6WBbBVx2NDMxYer
 niIKxCrCcZ/7O3AAO4UxHo2i0o7/SSBtauMKRHyGBLCg4IM11WTtp4yove9l72zncqMeRcPql6K
 IaIkjikjo/5mWnknEZ+G4/XOmpXaj0GfFhAZaVRTLagtG84Vs30C1AgzWtx+yBwRs8NmNmiMYxj
 v1cwR/3PaWllWKaG64ed7rn0Xph9OcabmLCN3S/ZiHaUjCwRY6DiWEDIPjrRpbDgCvTN54y6y6r
 g/6yeidUpEem04gM9N21mKt4mslDxxHNnrBwNebbV7GmqzrAH1j/WjjmPKFYORE58e98SAxxFRJ
 Ovn42MYMVniMc5q8X7fCsNxTzklVq4TpiuwQcspxW0L1b8MfXdN4IuL6zOC5VvwQoXihzE6cESV
 zGScL/5KTnRK+Wq8HLUlPGA22Mrr97xC3kPERcGAHKLXSzFzjWM6F2JJyHi7CvyU+lVF/jXKL5n
 5v73LqddEtOiaxA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

The SHIFTphone 8 is an upcoming QCM6490 smartphone, it has the following
features:

* 12GB of RAM, 512GB UFS storage
* 1080p display.
* Hardware kill switches for cameras and microphones
* UART access via type-c SBU pins (enabled by an internal switch)

Initial support includes:

* Framebuffer display
* UFS and sdcard storage
* Battery monitoring and USB role switching via pmic glink
* Bluetooth
* Thermals

Wifi is not yet functional due to a crash in the remoteproc
firmware.

The serial port on the device can be accessed via the usb-cereal
adapter, it must first be enabled by flipping the switch under the
display. Additional info can be found on the postmarketOS wiki page.

https://wiki.postmarketos.org/wiki/SHIFT_SHIFTphone_8_(shift-otter)

---
Caleb Connolly (2):
      dt-bindings: arm: qcom: Add QCM6490 SHIFTphone 8
      arm64: dts: qcom: add QCM6490 SHIFTphone 8

 Documentation/devicetree/bindings/arm/qcom.yaml  |   1 +
 arch/arm64/boot/dts/qcom/Makefile                |   1 +
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 938 +++++++++++++++++++++++
 3 files changed, 940 insertions(+)
---
change-id: 20240507-otter-bringup-388cf3aa7ca5
base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803

// Caleb (they/them)


