Return-Path: <linux-kernel+bounces-350435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBB990517
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698AF1F21B85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF32178EA;
	Fri,  4 Oct 2024 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZnNoSAK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88085217304
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050277; cv=none; b=ZxWcp8qkuxCqrSxCK07GDrO9YcglFJRfwDODRYX7DT8Z6WkJnrHLnzTR/as4ZD2QbVC3SLSfleVEOG+QLYMmQrLVF8xPFh8aQXSPh7pz+blU2lKfZ8W4rN2ulwWz9i/JUL6Yxj2+VAHs3dc+Jr218pGFhUJ6/O3lwb5EVqufJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050277; c=relaxed/simple;
	bh=qCx9cqjbgwWFDze9DrsEVpPlGpay0fglqREd1t3pVsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=blOeRCoUoTpRCpUmgkPMru0hmMa0p18YKjuy2A646twVyaJ4+fsxy6jW8iDE1UcvQvtAfbdPisLtednX8So7TLs6ichB29yOj3eQUW8LqI8pWZHegqCzwUaDlgBNWI+bEybTnySjxKoE4ktxHFkzFN4K9k3VBb3ODGVLdd0hX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZZnNoSAK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so22116495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728050274; x=1728655074; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMRsLYLUAVO/7Ox9FY4vIVh8TZstfxbXHfP66NWaA18=;
        b=ZZnNoSAKt/LiU6VJTLb6ifk4eiv18hshX6kbS96Tr++z0tVbsiIg8VnnICXUrxstJT
         YhDPZFnqKguMVvOdCnvD+Iu3yjtMk4EtUoldK4v7uv1ucT21RJoMYqvhZ/ZyICC9gn88
         oxDoHJKfsTRtmex1mhEYDhW860YIpS/V8l9MPohHmCCr67HadqZlo0fQshUrwq1U/x5r
         MKcZzzYg4meg4AhqOr6ydn88MVEoOJ6KktqrBkvHu7pBW6L6IvDSz6F6Tlm89CH45NJZ
         Di1YQQlephvnXbne6tV3q7Wx1VL4WHKx+hmh8a8id2AGM19GGDabKo2zdE+mgcBy9vu8
         u/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050274; x=1728655074;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMRsLYLUAVO/7Ox9FY4vIVh8TZstfxbXHfP66NWaA18=;
        b=fiscyPv1XKO64CN8dVhrfaRvQawtzdDc4aSBEFAMUAKNoKP5uDqWw3T8qS3BoPb0cA
         M+P4N2f8are+Jig1Cz3f9k+Rdq7t6jXb1NyNcF0NnKGTZSCIFfurizg9gU7EbKNc4hDJ
         nucNYJmivtQur534WBvin8T+UtYAoNc7/IgR1olEcuzdTjZTlOEm4WiBRyEbkjvxCBe5
         fcMFRmPi40asEb9PSfOgUda2fRrW5hrr9BPJytVRJYMOvRbWVRiI/zS8giYCXR8pUW2k
         HEtrjGohWPzWdf9uVmEi7gALg/zApCPq9+5vPgUryut82f83uFKhFCWpDvkdsK3r6kvS
         dWpw==
X-Forwarded-Encrypted: i=1; AJvYcCUdPeJ79aoOBw01lNqk5CNtXBD3T4L47/b/Ym1qUAgBSNk5lQSmhtdstRGVOf2w/Ac37utJzLBbz+GrrXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpy4qeSwlLEooacDeOIipailxyVsVvm7HqV11tQ6uOcQ9bczIT
	tbOEYYgtXoANXL/GH8F29QilLwVY/+RaKKoxGDhZce1F0A9ExUYPVfuaazJzJZ0=
X-Google-Smtp-Source: AGHT+IEuaqwiF/9IHPMHRsMxcHq6xKkT17+57971Ke4JLDmxJX6UPJwTvln4tbyQEiQc+0fP+vueYw==
X-Received: by 2002:a05:6000:e4e:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-37d0e8de864mr2082021f8f.41.1728050273755;
        Fri, 04 Oct 2024 06:57:53 -0700 (PDT)
Received: from [127.0.1.1] ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08215cd6sm3302550f8f.28.2024.10.04.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:57:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] usb: typec: Add new driver for Parade PS8830 Type-C
 Retimer
Date: Fri, 04 Oct 2024 16:57:36 +0300
Message-Id: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFD0/2YC/2WNywrCMBBFf6XM2sgkJjRx5X9IF83DdkCSkkiol
 P67sS5dngP33A1KyBQKXLsNcqhUKMUG4tSBm8c4BUa+MQgUEpXgbOVBI0dkS9H6gswr59xolFW
 qh7ZacnjQehTvQ+OZyivl93FQ+df+WlqYv1blDJl1TvYGLfdS3Z4Ux5zOKU8w7Pv+AUfAMRCvA
 AAA
X-Change-ID: 20240521-x1e80100-ps8830-d5ccca95b557
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=qCx9cqjbgwWFDze9DrsEVpPlGpay0fglqREd1t3pVsc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBm//RWY7JcOK3rX/lRHYCsLxPXSsC9kX/L4SlsZ
 eSkt292DR2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZv/0VgAKCRAbX0TJAJUV
 VtAzEADLXvysPhBixAXX2NUFeVoTWusoB7hoc/vh5cXjIiiOKn1oagIqskMv1HiycsxRWoJOPQn
 I68LR09xbbL9EWrQA8gHTnfgCEEjaDmoL3X2mHdprUqzdZHGPaXwfY32By3shT/9R/a0CFQTUsX
 ZDPUjb0lI/5XWFldmnAlswdVwITOthdzKFcmY3Y7hBaAEAysxRcJQv/d5RQv2JveUN3OEKaF1Wi
 Id+BeIZdzEBW5iXDxZXY8aXbbtrsiAYOHiuOJm7oxJUoLiJG1SwjBfZG66Hzr2Ohoz7ptK8ZW2L
 rWQKihSbJXIEosxEUsseyJ5Ied8BLtnq2ZommpDIwgoHm8apXVtrG/0Ebo8ZWMnSBZEgfvuYn9g
 Y6ux/hNlmDm257P5AY2dRdLG3/3fhZ1yT5vNckOaZzFWh3GhPrt+iezCoJl896QZQVWd2kg6WF2
 fhZnB3iRqF32GMjPuZntUTPTElB+ZhonhgTZewIeJ5M3ZqTN8SKrGSYR/8Z47SCSgHYAPFESmz0
 YUmrAg3SDnKr7tyQ6jbRKALOeqYyVvz1Hs4XtRcUWKEYj9Ekg9pKPFvcVez1cdiRznRp8DSzcIV
 kpRIRCZQVhnIliEUfkzPou1CLlROevRe/emw4KZuDtAu/ckf3EBiT6jBaZEvBRW3Cfk1DFTttaB
 WX6V5O6exAolRMQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Parade PS8830 is a Type-C multi-protocol retimer that is controlled
via I2C. It provides altmode and orientation handling and usually sits
between the Type-C port and the PHY.

It is currently used alongside Qualcomm Snapdragon X Elite SoCs on quite
a few laptops already.

This new driver adds support for the following 3 modes:
 - DP 4lanes (pin assignments C and E)
 - DP 2lanes + USB3 (pin assignment D)
 - USB3

This retimer is a LTTPR (Link-Training Tunable PHY Repeater) which means
it can support link training from source to itself. This means that the
DP driver needs to be aware of the repeater presence and to handle
the link training accordingly. This is currently missing from msm dp
driver, but there is already effort going on to add it. Once done,
full external DP will be working on all X1E laptops that make use of
this retimer.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Addressed all comments from Johan and Konrad.
- Reworked the handling of the vregs so it would be more cleaner.
  Dropped the usage of bulk regulators API and handled them separately.
  Also discribed all regulators according to data sheet.
- Added all delays according to data sheet.
- Fixed coldplug (on boot) orientation detection.
- Didn't pick Krzysztof's R-b tag because the bindings changed w.r.t
  supplies.
- Link to v1: https://lore.kernel.org/r/20240829-x1e80100-ps8830-v1-0-bcc4790b1d45@linaro.org

---
Abel Vesa (2):
      dt-bindings: usb: Add Parade PS8830 Type-C retimer bindings
      usb: typec: Add support for Parade PS8830 Type-C Retimer

 .../devicetree/bindings/usb/parade,ps8830.yaml     | 129 +++++++
 drivers/usb/typec/mux/Kconfig                      |  10 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/ps8830.c                     | 424 +++++++++++++++++++++
 4 files changed, 564 insertions(+)
---
base-commit: c02d24a5af66a9806922391493205a344749f2c4
change-id: 20240521-x1e80100-ps8830-d5ccca95b557

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


