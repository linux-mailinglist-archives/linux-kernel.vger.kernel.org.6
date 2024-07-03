Return-Path: <linux-kernel+bounces-240097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9C926919
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698E028413B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61E18F2D4;
	Wed,  3 Jul 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+kV18s9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6D181BAE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035913; cv=none; b=nBAkDBCSebVwD2v2NCNTstCAztejl7DPQ54HTt1JSbCaLDzmkX17/T7mZoB/L5NH4QyRQL5gtSt+Y+jKj/cKKCtJ/lHEWV7mIYnbhpobbyrNEGDCpEypP2Ws79MZ1l3xcD6er25oWRHBRicEGWMlg7IMs4VLECE42tt7ypszlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035913; c=relaxed/simple;
	bh=rtwo49zOlUeEmABXHSMYlDZNT7gyuyCDvtWvca3r8QQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pyd7dPOVtmFw+EaCZ0UZWjsMkAFO+yqWt3WaW5stBPiihHkN99SnwjBg1ioLDinMLQA9hG9rLqQUc5KRdpVOwHoC1L1wWEAVLKMiPwhF/RzjcOto47FYIUb5R2VLCAJLbIxDouqYgUtjMQv7PJRda1ar3Oq8PvhTAVY/KNtSHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+kV18s9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424acfff613so51461255e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720035910; x=1720640710; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtISt9Ugedo7GkZ6UKUNJblVSJjOVv8XR48t6Yf8Hng=;
        b=c+kV18s9JNObLaGB1gDJbG5+AGQL6EY/s4cwTZuyb03JCLD4hT2MJNVsmO4oF0P3Ha
         I/KTQjHSTiXyI1pwH93yCqguBPErD6yTGm+c8SEx8E1wYNHSMEBlsGdZv29It4MzrL6C
         DtAYeyCtW7FtgHpowOib+q2MI9Gj+OgXZvfEFQBQXC37NXm29IlYDrtAGILchj5/sh3k
         r1iMZVrUXtc3EvpqEtqJwWzLHaueUkZ/5PAH/rgqxbM0gPmxwAKZ3UXYKnakfjqWoHcw
         OKS0w22MoRePrfypmsiftAe9S1tX2zOEyI3IHIjZgZR+robzsW5CWv7btYZzvKSvkur/
         G6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720035910; x=1720640710;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtISt9Ugedo7GkZ6UKUNJblVSJjOVv8XR48t6Yf8Hng=;
        b=Ul4LDkJL+i09AWEGqvFeIxp12tdf9CAOXzIjHUQ6vdsBdeyV1jwXL+r6w+QwklqlOK
         kmXqrAPn5ppsqxXvptkmZCxrDQF6aYhgLbuiSdTojuZEcm7DKwKpAOKdBbDxZky26MWa
         bqKawPOqLaIJtPXnfgxbgd+Fjt93E+SH1NuwD2PjGVzRtu2WvyoB4qlUO3J7DVRa2GFL
         8x/tKSNKkemB7sHO3wKb+EsTzddbqjIwi9kuaBUttY0sbdY+KZzyyX0I+wJJK6GhtgnF
         fyCmNOcjMLwaIqV25UVOELxQxv8Rp/lWsp3elZ7KTtGNz+8gIXq95kE+dZkSpe7Gh28M
         AoDA==
X-Forwarded-Encrypted: i=1; AJvYcCVi0w2PaPVS2PGQTLKZrVn7HYRPTZRA6fMJB+xECzO6fhVdQ7KnFc82aXcYSe58VtngrFV+hPFwoVS0Y6WE88M0wBFLLZ8dz+3uC++Y
X-Gm-Message-State: AOJu0YyNLMwLB0G8l8Dgak2j6pE8KultHK9IXMhsRdOtseaogPl1GRf8
	Ztn+nexQk3i3FDJeTwcKZ4U0idFA5KLcEM2A8RZ+EWsbO1XhfRzxRCAd7IlcdGI=
X-Google-Smtp-Source: AGHT+IHszyAU2EIXZ5zl5dt+NjyejqLRqE1vIESg/SSAXke3ROSMsf1mELzpMld4ZmPMBcgpXDJg1Q==
X-Received: by 2002:a05:600c:33a8:b0:425:6976:f5d6 with SMTP id 5b1f17b1804b1-4257a026ed4mr97896565e9.33.1720035910499;
        Wed, 03 Jul 2024 12:45:10 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0642acsm260617905e9.25.2024.07.03.12.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:45:10 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] arm64: dts: qcom: x1e80100: add Lenovo Yoga Slim 7x
 support.
Date: Wed, 03 Jul 2024 20:45:04 +0100
Message-Id: <20240703-yoga-slim7x-v2-0-3b297dab8db1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECqhWYC/22NQQqDMBBFryJZd0qMWqGr3qO4mMSJDtikTEQU8
 e6Nrrt8//N4u0okTEk9i10JLZw4hgzmVig3YhgIuM+sjDa1bnUFWxwQ0sSfdoWqoYeztqGyQpU
 Ni4nACgY3no6PAoHW+by+Qp7XK/TuMo+c5ijb1V3Kc/2fWErQ0CLWvm98T45eEweUeI8yqO44j
 h91j3fEwgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: robdclark@gmail.com, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=rtwo49zOlUeEmABXHSMYlDZNT7gyuyCDvtWvca3r8QQ=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmhapFyoXsxrteeCqyky992ZTArO/SiQu1w3On+
 jAhYB/CXpKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoWqRQAKCRB6of1ZxzRV
 NzeXB/927P7qy2nmqiMU9osgmChAelJIGvtFAgJzQhFNcJGhcxp/LtD3odvyQsHFLIEFPadE4XL
 pcU9Mnt9QsTB3QlkbRpQs+AYBT0cX6tRP8gJtzrTxVuwK8Mb85rxkmdO1mh2WfZmVzipxA53/4l
 9UTz9kLJCl1IvvvlFngEKD2iCmSnLsA0Nb6pHn/KWRlft8L2SaL1xO6HC38wMG2wb4rzP+DiU8R
 xn4uGT/6N7oL8S+CBUYoLrUn3YZxeszSnjLY0HsDnmVxspPR6l35UVDVS/v5s7Wkv7QR697IDQz
 cNU9Jj2JW5Ho75ly0FnWG+Kc/b1Xkl/S5WSVPefnffAY8w6D
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

This patchset adds support to Lenovo Yoga Slim 7x based on x1e80100 SoC.

Tested features:
-> Keyboard,
-> touch screen
-> Display,
-> Speakers.
-> all 3 usb ports.
-> WLAN
-> GPU
-> NVMe

TODO:
-> touchpad.
-> 4 x dmics
-> Battery level (Does not work)

Note, All the firmwares are copied from windows
(\Windows\System32\DriverStore\FileRepository\*\*.mbn/jsn/dtbs.elf)
for testing.
 

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v2:
- updated dmi product name correctly,
- added touchpad, thanks to Rob Clark
- fix speaker prefixes.
- Link to v1: https://lore.kernel.org/r/20240703-yoga-slim7x-v1-0-7aa4fd5fdece@linaro.org

---
Srinivas Kandagatla (2):
      dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x
      arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 929 +++++++++++++++++++++
 3 files changed, 931 insertions(+)
---
base-commit: 5f18d86e750408030e3980e566ff87f0319d7f34
change-id: 20240703-yoga-slim7x-35e6cbb5e13a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


