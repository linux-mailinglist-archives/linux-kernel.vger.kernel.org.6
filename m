Return-Path: <linux-kernel+bounces-443344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150E9EED8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F7628A4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BA02253E7;
	Thu, 12 Dec 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlQLGNzV"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136E216E12
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018401; cv=none; b=SdDzqZgOINGo7vnfC0j538MCBMSlqJaen1ja1hgo3MsIIXGLRE7KH7iQms4YlSJupnNzPRimqz4Fr8it2ZZ4NgEdt+WtT4QiVIHk9QqtziNN4Z13z9uX4RmOqgACeok3qare4QwoJx3YLli+ZyvVhb8M7XAyp2zrAijE7MpBQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018401; c=relaxed/simple;
	bh=8MwlOrPw6hnbupZRUxMztpH21m465O5pFE9DVmIdMe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=edFChAlOi+Y2RFOF3B5PIFky2Qy+Ufcz3SpZdP6Wy5TJPIE4bZP2O9EW09xkAAzJ9pSjcVx1fMi/Ds1TdWIjKeNI30CJlFlhNpUkr7FbTh+yrKSzpIB/MULSY6m8H19IAfdC9qnNmaWWttKSXhvRFqC7H98Cz+ndXmiDKj2wndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlQLGNzV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so8375355e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734018397; x=1734623197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHEuWzDtHUDlvFzFUY2tkx2xxe7A6hFHuo+SVGTgMQI=;
        b=mlQLGNzVjbAn9Qxf0lSHxcICm473CBoNaG4sc7GOI++fsDlTDjCuRpZNKbF3qSTNNW
         yAxb6szVlbaIznjjIY/OekeMFic5aexAzWXjS3RWBYtrpYBXuu7asIFfugTFUqxW6TMO
         5S9g43OBalHBNRw2OmmDp1vSk3wEwXUj3Av63Zp1IeIUb/aaE2ZowgLtb0TesHlV+Utq
         QwaG8fJnA+1DlUAkEI2LRnJC2ltqOCoqvyQ2K63e3KmxlBDI9LJDmgGq+9D65Ko+Tc/X
         K3bPnAGuTWhHgoCZZUh6P4EdH27+UukCA8je9pJvD22GN4eNKgWfgFUmAHiqK3exU0zj
         n0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018397; x=1734623197;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHEuWzDtHUDlvFzFUY2tkx2xxe7A6hFHuo+SVGTgMQI=;
        b=noXu3y6DUigxEpEV1LYU1H0uyAAyEV1mOXvf+zPXB6rYpD4w3g8FEITg9IS3UnyAer
         IvDsmQgXD3zHDiDvkaDBwcgvppdoOJIOVR/zPcwug2+dxdBNocRsDQBRHskrkk4pWtVJ
         MG041lowXo/XeDFAWsDprSlELhEBxO9cQPDEdplFTQD8V5qni2M5U9iEE9F0pQ3JxuQ9
         RZwz5MVtf0jvwekdcwqrk9db5Zu87rimJplDRSIci2g86ez5JoY7nuKz41uZLhcusjpd
         U9oJ/Ol515hd8NfKSZ5rmI4+YmiNflhuST6Q1+eF1CViIXN0BcYTSddoE4AidvXS+IjW
         fvjQ==
X-Gm-Message-State: AOJu0YzjleS8O3FjmX/K05xnRMPDIabuUsW0IAhUYDSYjFbr5rXMfnvz
	ZiwMMnju5aksXaPktlZs0lMog/Z+xwBzn6xJBRhx24afKG0LD84WaspD2hy7+J4=
X-Gm-Gg: ASbGnctMvHmGMbDGFDGUwFNlF5xaF2QWvKua6KEFVuOUWh34dj0AbqsXXEN3AB7L29p
	ZLaijX08jewIXbrmIqURfbl3rn33FfXPuQRmleE+3P45VoC6mVtYeJN26D0h/IToUAHM9RrqfM0
	ruBjjtnWxOz7feIGiCUmwVdPxsl1XUTi8gbXXWPHawkHwP/x2KwcQV7C2VnKsz6LuaKU5oXkFI5
	AMHuaSu4zB6F41b5UgsNcTzJIWhz+mJQsPBcjjySD6j6g+eJqKQW687atwDllrXN3aHLIB+4dWB
	bmzfiNeP1j6i/55qnruvgUxxpQxN5SNSGQ==
X-Google-Smtp-Source: AGHT+IG8CN2hgLpsM6m6nHOXhNUh7Kw3+z/BZiMwdjrpn026/mubHTDbMHcNXqdjvYXjEvUamvJP3w==
X-Received: by 2002:a05:600c:468d:b0:434:fff1:1ade with SMTP id 5b1f17b1804b1-43622833513mr35505275e9.13.1734018397461;
        Thu, 12 Dec 2024 07:46:37 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550518sm20273075e9.5.2024.12.12.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:46:36 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 0/3] firmware: add Exynos ACPM protocol driver
Date: Thu, 12 Dec 2024 15:46:21 +0000
Message-Id: <20241212-b4-acpm-v4-upstream-firmware-v4-0-3f18ca64f1b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE0FW2cC/x3MwQqDMAwA0F+RnBewNQz0V8RD6lKXQ7Wkzg3Ef
 1/x+C7vhCKmUmBoTjA5tOi2VtCjgfnN6yKor2rwrSfnncdAyHNOeBB+ctlNOGFUS182QXp2nbj
 Yc8sBapFNov7ufpyu6w8WLcpBbgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734018396; l=2976;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=8MwlOrPw6hnbupZRUxMztpH21m465O5pFE9DVmIdMe8=;
 b=lOqHvlJpdGZcc5EAmus+LGU4Wn0TJ6rs/yuvq+NaKvlCmKlsQf4wIXNRwtmwoAd/IJmUd219t
 HQllYWe4NZ6CuXyqX1kb0SPIwgQWoEhFX4HFIsket14aulFERqbXvKb
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Alive Clock and Power Manager (ACPM) Message Protocol is defined for
the purpose of communication between the ACPM firmware and masters
(AP, AOC, ...). ACPM firmware operates on the Active Power Management
(APM) module that handles overall power activities.

This protocol library provides the interface for all the client drivers
making use of the features offered by the APM. Add ACPM protocol support.

Changes in v4:
- rename bindings filename based on compatible
- bindings: drop nodename
- bindings: drop mboxes description
- bindings: remove initdata-base prop, and define it based on compatible
- bindings: move additionalProperties after the required block
- bindings: drop firmware node from examples
- bindings: drop unused label in examples
- bindings: rename node to power-management
- driver: switch 2 macros to inline functions for readability
- driver: add checl to avoid shift overflow on these inline functions
- driver: use ktime_to_ms(ktime_get()) to record ktime
- driver: use the default non-relaxed IO accessors
- driver: remove atomic handling
- driver: remove stray of_match_ptr()
- driver: move header in include/linux/firmware
- driver: make sure to, from are 32-bit aligned and count is a 32bit
  quantity before calling __{ioread, write}32_copy
- driver: reject IRQ channels (not supported yet_ at the top of do_xfer,
  instead of when waiting for response.

Changes in v3:
- decouple the mailbox controller driver from the ACPM protocol driver
- address Krzysztof's eview comments 
- add ACPM PMIC protocol helpers

v2:
https://lore.kernel.org/linux-arm-kernel/20241017163649.3007062-1-tudor.ambarus@linaro.org/

v1:
https://lore.kernel.org/linux-arm-kernel/20241004165301.1979527-1-tudor.ambarus@linaro.org/

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (3):
      dt-bindings: firmware: add google,gs101-acpm-ipc binding
      firmware: add Exynos ACPM protocol driver
      MAINTAINERS: add entry for the Samsung Exynos ACPM mailbox protocol

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  51 ++
 MAINTAINERS                                        |  10 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/samsung/Kconfig                   |  14 +
 drivers/firmware/samsung/Makefile                  |   4 +
 drivers/firmware/samsung/exynos-acpm-pmic.c        | 239 ++++++
 drivers/firmware/samsung/exynos-acpm-pmic.h        |  24 +
 drivers/firmware/samsung/exynos-acpm.c             | 800 +++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm.h             |  15 +
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  55 ++
 11 files changed, 1214 insertions(+)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241212-b4-acpm-v4-upstream-firmware-4633e1f9a0ab

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


