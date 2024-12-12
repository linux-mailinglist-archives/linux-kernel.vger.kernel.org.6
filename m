Return-Path: <linux-kernel+bounces-443418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3BC9EEF52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B00295435
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31D22969E;
	Thu, 12 Dec 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heclECXw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC6229679
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019252; cv=none; b=rqFDHGLqbbxW61bdAdUTMClb3L/mD5VUHuxTA3CJmdcFCH8gSXLwsG27eHfsRWZuchK4Nz5QbNYZeh7Yw/zYRVP8bPqo1Yg/nn7f1zpHqpLBg1INawOZW7gzAmz+W7uHmRNgqkeq95Kb/7Hoh0RoHrMAe0kXE141AtPnqPApxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019252; c=relaxed/simple;
	bh=gPZKjY/Cv6dqyLwE285RezILuvSeCSXXgwbDcAwcRGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i6Ivd2jceuYavexVw4vLkUJkqbS/ZC1GinCQfiRd9RmQRWTL5zxeCEWQmtvxU0gEml+jORw71kgrHEsg7yezjqdAPK8eFwGGXNZ794WbAlSkL7ZZBkEY+TFQg1SmXSrof+ttyUqf4t/jgwm0yDscgmjvtdttynhvTD8GU040Gcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=heclECXw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434e3953b65so5698545e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734019248; x=1734624048; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqueOt3m+Hz5NDiZkEdxcD3dFeoon3Sxm9uk7ivrbRM=;
        b=heclECXw4zytSEM3yQPd3fha5UPdBK0BXFPDbKsEJhZdJtOBX+ON6rMEZoNCiX6FjL
         4kzTL2xBR1Ej7OorfiMulmjulSf1ogqLCOLBFduA3SFMH6+Grc6cYeuKazi0lL132QM5
         xgAyqM4x0GdcZgfb0rnJ1ZdK4CiNo1TAPapO9Ud2qf4S8OCkckjx0BP+MpO+WtuL3LtW
         RwV3SkvVFD4U8Obeq+dQ70USrJLFYzzVvzN+G1H+rzoEBk9G01NdSWV2Kkq7AcLaNf1d
         bR2ANtAQ+pneZnuqpuSsT+3ArQq4f5nABLKQSk2MghEo9A89mmZpLTVLKTJeOMLh8E38
         JNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019248; x=1734624048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqueOt3m+Hz5NDiZkEdxcD3dFeoon3Sxm9uk7ivrbRM=;
        b=dtntvT8enQ4XJ++nrXGYyNnodVptMR+j+liQjsQdPizeFJcPhJh/qhxuQYR1+MQCML
         cS0Hs6dfboDSn4uwlwUOB2Qji81Jj5Pzc7t53xZ+zAcngWPwxUynE8ZrEb62CW45UStL
         VSOLtXJipbFqdhM24Mzhp0eLfgQT7OEOIvAv3xDo9scBz8o0zeWWzplq3WaVEEpnE2dt
         TjaESFJzpkV1N/1H8CUgvkrfN3oCmIZRD3LvTbddmKO37nQ0y2S4xcnZMNQcEpNt5hVr
         tlcwA4HAZ66HHBU43N60CYV96FMd7DEvtRwXIp0SlGqzT1cWleC/ZVxiZWEM5x1w2Qew
         NPFg==
X-Forwarded-Encrypted: i=1; AJvYcCVZigUP76G6zKEi+MpPmUNF1Vvb/HHi3i+ImOmNym3IgbmEI8YVnWFF1UWqpVPR1Du0aWBAmlTCd/6ZL5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauEj7fYIsY3t4a85Q/+0TgJASWDRr4TUQ2YMjaEcoQwUqAeVU
	GBc8IlxgHmPJaz24C4+VdDMvUSTQS7MxFonuXtXP9QC2d28oPjDJ6kWI7pbARGk=
X-Gm-Gg: ASbGncs7fVLkhksfzRYwCtYCfZxFez5D26EvXT4aIB3EJ071X70lGatpJ7M+YgTp1jV
	SjoxxeeX4tBpVUbKAUFqsi2/1O6hZ4q6c8RJ9VGXsRT+WQypg4AbUNj3GXVWzTwyLkHUjABc6Gc
	KSLcqg0zs4HQj0aaWEVa26xHLk5CgigsWBoZdPcUu1CpRA5VZ3VIgLy2FQwRGyaLmgSbuSU4k56
	ll6kVdDBUU+wRVJDDDkUwQj9gJMbQnh6ws9wJ8FFuz1Q5FTa3zpCfy1OneDz6s2uqrXbLOsFX4q
	Uj5atfHVL7nL2PjhoqPaf/W+oln5LzxMzw==
X-Google-Smtp-Source: AGHT+IEO8F14DLA6a9uq51Fn4E/i11A1F4D4K6m8q0VdStEpDipMvlbI8LBPnMinLyLtzeI1CSuDpg==
X-Received: by 2002:a05:600c:4f11:b0:434:fbda:1f44 with SMTP id 5b1f17b1804b1-4361c3976ffmr61803215e9.19.1734019248210;
        Thu, 12 Dec 2024 08:00:48 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d35sm4462941f8f.74.2024.12.12.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:00:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/4] arm64: exynos: gs101: add ACPM related nodes
Date: Thu, 12 Dec 2024 16:00:37 +0000
Message-Id: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUIW2cC/x3MMQ6DMAxA0asgz7UU3KhDr4IYnMRQD9Aopggpy
 t0bMb7h/womRcXgPVQocqrpd++gxwDxw/sqqKkbyJEfaSQMHjnmDU+Pv2xHEd4wHYa0RBde/Aw
 hMfQ6F1n0us/T3NofDngjvWkAAAA=
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734019247; l=1387;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=gPZKjY/Cv6dqyLwE285RezILuvSeCSXXgwbDcAwcRGE=;
 b=hZ8flcnYPQV3TsFaQwLja8Fw09eEAZUxRLkGCgisxH6sMxSgluJopwrXKflaZZNoFnCvdGKQi
 Kz9nhpbJs61DlRKVpDVEdcXwIY5mz7OEpQOlEU6cijK4KqS3rNlA0dw
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define SRAM, mailbox and ACPM protocol in device tree.
Enable the mailbox and ACPM protocol in defconfig.

Use a constant for the channel type until the bindings header file gets
queued. Bindings and driver changes at:
Link: https://lore.kernel.org/all/20241212-acpm-v4-upstream-mbox-v4-0-02f8de92cfaf@linaro.org/
Link: https://lore.kernel.org/all/20241212-b4-acpm-v4-upstream-firmware-v4-0-3f18ca64f1b9@linaro.org/

Changes in v2:
- update nodes based on the bindings updates
- update mailbox and power-management (mailbox client) nodes to specify
  channel type (doorbell or data) and channel ID.

v1:
Link: https://lore.kernel.org/linux-arm-kernel/20241205180200.203146-1-tudor.ambarus@linaro.org/

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (4):
      arm64: dts: exynos: gs101: add SRAM node
      arm64: dts: exynos: gs101: add AP to APM mailbox node
      arm64: dts: exynos: gs101: add ACPM protocol node
      arm64: defconfig: enable ACPM protocol and Exynos mailbox

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 39 ++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                 |  2 ++
 2 files changed, 41 insertions(+)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241212-b4-acpm-v4-upstream-dts-2fc0b6a3bbda

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


