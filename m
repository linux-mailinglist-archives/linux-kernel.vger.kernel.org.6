Return-Path: <linux-kernel+bounces-237342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AC91EF77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8788F283763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001912D1E8;
	Tue,  2 Jul 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzFnNY3u"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D302E62B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903250; cv=none; b=iixNhVOlW5z5gv8piNeyG1GIuIZobgk5cSdqY0UQA33h+8IwgQhcDXO8ZwVIMTGVRU2b9VI0FxJLjKyENgONPmtSlLvlj6SzEtE/WnGpfq1NX+mSWtXCo4AW8XdtUmlE4tiTyaEIyuq3I6rOie41sAZCpcgsm9M5asJMOwY8uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903250; c=relaxed/simple;
	bh=/2KcVHnlikwpkPUIEMhuFqqNrQ8FZBr5xR5pSvhRuCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5t/+RLY489H9Yc+3zXaRMNCjpHhLelrLxNhurH7UsrUbKhIkLTZH9SXKsMUTB/lvt64asY0J3cWCCU7n1NuvandEL4HmV5D2oSmkPBWoZloPTO0p1UTid1cRv7cf3uA37fLMH6d4vGrE95H1vQwvZI8aRaWMhva/4fEHpsyiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YzFnNY3u; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so3924796e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719903246; x=1720508046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPayim47aM+LtqGl1M3szBrZKoorTqLov3sXX96ze58=;
        b=YzFnNY3u7CTeRr10PNXxS4XXCWHsu/HXEFduS6OK4f6GfcTHNGWD5YiQo4AQyUfUrW
         24a7XUX3Q7jMQz5ZdgKkmp+CqKRTNOpLo47Ws8xmw/5AyJsvaeHlugkC2H1lXuLwk6Xd
         2laUeGHzJHRNfXD7KmpSjkLTiCKoOCjvqbboKiNRr6ZXIAgb2Y+kcTgK/+QjAE2xqkdt
         LEQIe5gnbbSYCJ6LeZQa+TF65CvVlo7Rl4lX9vn1/In0S7fBRVLT+m9xd0hD8qbKNB4q
         Jp4xDkmgcjkDG6/XZ4C5x4u+SD1I0eiY2hUSYs/hBnKI7fgoTq9qvgbmuWiAWMKKTPtL
         o6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903246; x=1720508046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPayim47aM+LtqGl1M3szBrZKoorTqLov3sXX96ze58=;
        b=WeiAJHREreFuq7F++vxZ4dfLAFStxr2f7kUS8m/UwNFPyf1d300mgS11xjVsjCYbSX
         90wJfKIDrltPC8iMGkqtT6tsqCdFAM5kKcj/jI7vDxIqIW9gsqvD3n2Amh0gv1JOckqa
         yxPVbAYkR98W0i3/Zwdo5kJ16mwNOw6LNPB4kpNybv4Ubad9GObM1kBkLcrKIPVUW35Z
         PyHqSHUsIXk4IfR4eaRmWiXzscxZCWhnDVLlQiKmwFkxjuXPfua5AWCpGF4pNBm2nQ2A
         wzh2XxAGyIkZKx79QUYkNONa474aCdfJF8FpBKGtFSwxvhnKpF/Px9BFqXd02JdmL0FS
         oERQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAb+zozGO+ZG3BTu7599fSus/NUjg4oQhPqDraTTBu2YwR+vqGRAzIFVXk98dih9TIF8IgXs5pGsC8L/hb544hLl4gO1wMR8QFTUD1
X-Gm-Message-State: AOJu0Yy77yc1Q+odnnWYbkExagVNJplIKJIyfZUn8aFMZijdXLlKLBw4
	H0m4+zTdm4Cxl5Bmfehp3kSOI92xwYW4z+E3GwNSAsQAP+6Mt2hxiLI6g6dg3jw=
X-Google-Smtp-Source: AGHT+IES6oCV7lFa55TfIKn3mKOEnUfl5v56L8EsOq8L/09ycBBlDNrajlhl0366aBH2Ud/+5atJSg==
X-Received: by 2002:a05:6512:282c:b0:52c:e01f:3665 with SMTP id 2adb3069b0e04-52e8266ef2bmr6073735e87.25.1719903245463;
        Mon, 01 Jul 2024 23:54:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm181446185e9.17.2024.07.01.23.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:54:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: various cleanup for v6.11
Date: Tue,  2 Jul 2024 08:53:57 +0200
Message-ID: <20240702065359.7378-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.11

for you to fetch changes up to c0304446611536a771462f27d98db6775d222b38:

  arm64: dts: apm: Add dedicated syscon poweroff compatibles (2024-07-01 10:33:07 +0200)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.11

Few cleanups and improvements which were missed by their maintainers:
1. Spreadtrum: correct PMU nodes - split per clusters.
2. HiSilicon: add dedicated compatible to syscon node ("syscon" alone is
   not allowed).
3. APM: add dedicated compatible to syscon node (binding applied to MFD
   tree).

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      dt-bindings: soc: hisilicon: document hi3660-usb3-otg-bc
      arm64: dts: hisilicon: hi3660: add dedicated hi3660-usb3-otg-bc compatible
      arm64: dts: apm: Add dedicated syscon poweroff compatibles

Rob Herring (1):
      arm64: dts: sprd: Split PMU nodes for heterogeneous CPUs

 .../hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml    | 46 ++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-merlin.dts             |  2 +-
 arch/arm64/boot/dts/apm/apm-mustang.dts            |  2 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  2 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi               | 14 +++++--
 arch/arm64/boot/dts/sprd/ums9620.dtsi              | 14 +++++--
 6 files changed, 69 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/hisilicon/hisilicon,hi3660-usb3-otg-bc.yaml

