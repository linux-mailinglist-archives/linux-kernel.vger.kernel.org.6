Return-Path: <linux-kernel+bounces-573956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C0A6DED3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED3A16BD51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A30261396;
	Mon, 24 Mar 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3VbqLn+"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8125F982
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830456; cv=none; b=cw4ykoXhVN2ClbAf0Fg21UJu6HNvcePkgorJuPVSH4b98UY0pGGkj7mh/GPKLRMoDCuBqxz6xjBuCb8492Ox4yDTqNsQXjKl3NeTpPs7WPysT4310wUPQrU0fIEaP8POnc3869CN/haS896x8QK0zH5EiO62Yd1pT+kKSJOreO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830456; c=relaxed/simple;
	bh=2i8yYb41E2nPG7x7TGqmfwjAiXJsVTQqwHYAuSlN0ag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qw/SSrqn6tXUmqkWsy5freCOGJTLttRlv8rvU4VVyeIGNHhNCGxV9CvYMLQMgYw45r4TXNXxl9Ew1FVepQYlRkao2sy4blhbWBMKEqluuTHNpJcQjUPP3X2SWqIeZ0Me5wWnqfAx3VrNwkZ+mZ2wdLbVxZHMGS+kknAuxg8HCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a3VbqLn+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so943246866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742830453; x=1743435253; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIXMyJcelbL95lk5i6cF7CMMxgNXH3YnFDanO5WuLy0=;
        b=a3VbqLn+i5vgKyrPOhLgWVhKp66c8dByN8X/3sTB2lJ29UShnKld0yBXMbAJYDh9wm
         yOoY/etwf8dOFZz4at7/UMxQAPbfOoya37luUrJWOpzC4itMMc+dXwW2tXiGP7lJX1Q2
         GN8jz0hUMmQfqb/P+LR4RBpsS8JUl46gtk9jFM27NnFDwbLWIcXR2Q0L3SG/GnmH0Gt+
         wQlw9DD7aE2nBmZQUvZPSfqVTU3M2RPqKBjghYQFjzxRDv/oSx4nqYkijLU2PdJU4aWq
         2ARdvKJv7CCWZjXOa1lufI8gHoW2OTxTGZP7lANZ2wisoNY00S2IHlkxsl5QG8sWp7lg
         7iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742830453; x=1743435253;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIXMyJcelbL95lk5i6cF7CMMxgNXH3YnFDanO5WuLy0=;
        b=doqc4teBrupLHr69DJ2hxg7tabh5P7DJRiJ/vgSVDZHFDogJSp1hkqGHdBZBbXd357
         Wp0uMZq+YWnzL1J2J+GeTqrmEnzG4hKhQRvg5W1zYfV7sXgUbCo2bkHhs8zKJvIoo7vq
         Ed345lmolEYEsjG86rMCWOPO5I/0vJxmAE92xjcq6z+tMi2gHTBuA0mHGcNc8z8tTtsF
         Mg09oJzDDKHpXE8FROlQe0sQWHgxi90xHgb73IY3jZNBTLN5yVuYydPgKEYdkYr7L9pf
         auVsA6cy6ba8tcvzPdsthQaSrm6gsr2vEe5Lw9/rKHz+MtXdOkP2OfXD+cWUrAydmjzj
         Dtzg==
X-Forwarded-Encrypted: i=1; AJvYcCUFX7lkKYLWq7fRKodBMhJrw0Jv/yERJ2MO/EW2V6aKCSix1DtO9g/WkBhuiUwmDDoizqOkbCVcU4sBRcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXiTMFTBEXO2bivZIGK1zqvKSRKHa26lYZnYvC+JpR0O2jtFm
	5Yz5D9H8gHxiRlrSHjvfDxI09GtGF29N7Y+YOaTKDdRMPlGzm6YUMJM3yiPIUqA=
X-Gm-Gg: ASbGncvjmkIIMTFB1aCkOCT4u11PpaIlvjXNctK9FytrzdgYh34IHTNVlEtPQVmL+Am
	y1o5I47NKhBpXs127ETx2llLF3rsOCHkkMk1X1nndLQMuRyk1TgRS7wHsPhPn6Bkciko1WVH7WU
	Es6Mk/++h/wlzSWHRSd97GQd9/8fDhgK9/gwidq8lrY76vzAIq4oXotjwPTo6k03GS+jCe4+LQ/
	g+zvNZa89OaFg9l5WKVE9MQkB4qRBzu176yS1Rbl5xVXV+VPZ23Pp2NyvQWi2Y8d7PrdweLKfLg
	+yrYTunRZOIJfsoz906HpEjVkPlaKrAHJBrKg2DN9MxOgbydJlJ+zO3KnkI9q2Pp5hVj2zSL6GW
	2p46N34PPYCWM20SBDRg6vd7ZKCWt
X-Google-Smtp-Source: AGHT+IEAgyYw/lVqLDZmI/94VMcCiHl4tz0Ye4f3LeTmnsdRF9wIxE3C8ACjWz621GGbasA9tr0kSw==
X-Received: by 2002:a17:907:8694:b0:ac2:cdc7:fa61 with SMTP id a640c23a62f3a-ac3f22a030amr1409182066b.25.1742830452932;
        Mon, 24 Mar 2025 08:34:12 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm690219466b.31.2025.03.24.08.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:34:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] firmware: exynos-acpm: allow use during system
 shutdown
Date: Mon, 24 Mar 2025 15:34:08 +0000
Message-Id: <20250324-acpm-atomic-v2-0-7d87746e1765@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHB74WcC/23MSwrDIBSF4a2EO67FB9bQUfdRMjDmmlxoNGiQl
 uDeazPu8D9wvgMyJsIM9+6AhIUyxdBCXjpwiw0zMppag+RScyUFs25bmd3jSo5xpYzRI9cCPbT
 HltDT+9SeQ+uF8h7T58SL+K3/nSIYZ37sezNOaPAmHi8KNsVrTDMMtdYvaPIgl6cAAAA=
X-Change-ID: 20250321-acpm-atomic-033775b051ef
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

One user of this ACPM driver is a PMIC driver that needs to communicate
with the PMIC during late system shutdown [1] and at that time we are
not allowed to sleep anymore.

This series address this by switching the code to using udelay() in the
specific case of system shutdown. This approach was inspired by I2C's
i2c_in_atomic_xfer_mode(), which has to deal with a similar corner
case.

Link: https://lore.kernel.org/all/20250323-s2mpg10-v1-29-d08943702707@linaro.org/ [1]

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- add missing ktime.h include
- switch to ktime_before() instead of !ktime_after()
- add link to user requiring this change to cover letter
- collect Tudor's Rb
- Link to v1: https://lore.kernel.org/r/20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org

---
André Draszik (2):
      firmware: exynos-acpm: use ktime APIs for timeout detection
      firmware: exynos-acpm: allow use during system shutdown

 drivers/firmware/samsung/exynos-acpm.c | 35 +++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-acpm-atomic-033775b051ef

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


