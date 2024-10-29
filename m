Return-Path: <linux-kernel+bounces-386436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B29B437D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172061C21FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A88F202F6E;
	Tue, 29 Oct 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIQguSIT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFE2010F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188148; cv=none; b=Ylp9mMir4t1X4+D1Xm0BbgF8dD+HGerus3qDRQ//kWxMzDmUv/3/XpRaGb7W0g289A1i6cR3khw4OO/Yeia7SkyYgYWSkkZCtKhO6/QOL2ttHqx03J/sTKNmcGfb3sjVul9sVKGctp1GrO9Y4vT+isqO5viqhT8C/beDOP12QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188148; c=relaxed/simple;
	bh=/CAb9CWG2VL00UDttR3CC27k5GrxZSUxeuBJJdbzOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzGcLTA8XeVQxZ4LH78L1lqbU11eTB4u9nlzaT78OEBschA1bAJwqVBY5xI4beh3DSBIyPlSb26Bp+hEysaczXigkAcZIP9wArm1sfspdh7H1c6lTUp7x2tzFdGMonKDPPdZld4rO3SwT1Xas/yoxDhu6nbBOVvvu1Wc7nTN9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIQguSIT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so5647295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730188144; x=1730792944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XhfsmwUj+X8iEqSXpw7DJyfNK0UwrOSOb7rXfFCTvk=;
        b=AIQguSITWieIXw+eCqNq4R8ni2wYhxmUi/2Y7/mvwjWA2aF4yI/BFLLsdlUdcGV49K
         Fk57cdunGqXl9uVdD4hY+18/MHxJH4T4y1lvRgPp82vbSt/K057CYX0pwK6gB4ZzIgSG
         LW5/4zZ7+7RXZDy8HS1XDrTKbMmFXg7Mx5Id6UDaLZIRtUkZEefl1jUllD3q76eaLAWO
         nD8El95HFEMpBS6WNXkSCJ2JvPTJVyNS+bd4iwGHv0M37RMPayhTA9NryE1LwTmtbVqM
         0fQADlw8pdyd9jlOYFenPAy3Rw2P10ulxzaJqb4jAIMvWzZ0f0Kg3JO6XjCahHmO3qiI
         yZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188144; x=1730792944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XhfsmwUj+X8iEqSXpw7DJyfNK0UwrOSOb7rXfFCTvk=;
        b=jy0oB6DKNfe3IARwJ7hISLH3IMIH2imueVMr4dqNTWbnDZkvcYWKzd7xSNFxDMBsft
         viQ2EMx7jltiWWAjscBf7Iw8d7fw/GPALxy3XTDh6WSVhTVJSSczYEFKT+F5vlxDXulv
         HmbA+k9X2KLXLw5umLJNZKDnUzw4q6WPzr2wIGsHdFaYpsP5bQmUUS7o4K4YUXwLeE2Q
         c6oFr1Z0K+rEzMmYIjUchAvfc8CDIYbzdhkh/GWMxJJk+Ao7mMIMd9JzDVsvT3LyMZlQ
         8kRhiyLjOG5aUMlqaporaDpHDl5hxXHDxT9kLCmdX1gd4p2A04wiXkXvCkO8r83yO7uU
         QOFw==
X-Forwarded-Encrypted: i=1; AJvYcCUmydaKxzM9jOAzA9EfKf4R+SGc/iQ3vibDdbX63l3DcZD8JltqjTlD78N1x1KpeX2MVtV4JNb8reoK4g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwwVw3C49nl/KJ0OhkH8vi+rbB/btgrrdLsQfV5Lv0V/aMNQ3
	oCMFGLZF5Adrj2WQ0fB3icsGN11n4P6qeapefPgSsl2M/NrTcPjjWEYSpqNM64c=
X-Google-Smtp-Source: AGHT+IEjldluzPS+mbSRbpzoiA8QHGhxGv3xtNxXkaRT5kOdZUeZudVSGvXVTF69IiXysRbTVe04jA==
X-Received: by 2002:a05:600c:4f10:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-4319ad236dcmr39811725e9.4.1730188144508;
        Tue, 29 Oct 2024 00:49:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bdafsm11691358f8f.30.2024.10.29.00.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:49:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.13
Date: Tue, 29 Oct 2024 08:49:00 +0100
Message-ID: <20241029074901.18977-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.13

for you to fetch changes up to 6d2dbd4cec8939ad2b813b8052eb12406db528d7:

  pinctrl: samsung: Add Exynos9810 SoC specific data (2024-10-27 21:02:08 +0100)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.13

1. Add new pin controller drivers for new Samsung SoCs: Exynos8895,
   Exynos9810, Exynos990.

2. Correct the condition when applying further interrupt constraints on
   certain Samsung pin controllers.  The condition was simply not
   effective.

----------------------------------------------------------------
Igor Belwon (3):
      dt-bindings: pinctrl: samsung: Add exynos990-pinctrl compatible
      dt-bindings: pinctrl: samsung: Add exynos990-wakeup-eint compatible
      pinctrl: samsung: Add Exynos 990 SoC pinctrl configuration

Ivaylo Ivanov (3):
      dt-bindings: pinctrl: samsung: Add compatible for Exynos8895 SoC
      dt-bindings: pinctrl: samsung: add exynos8895-wakeup-eint compatible
      pinctrl: samsung: Add exynos8895 SoC pinctrl configuration

Krzysztof Kozlowski (2):
      dt-bindings: pinctrl: samsung: Fix interrupt constraint for variants with fallbacks
      dt-bindings: pinctrl: samsung: Add missing constraint for Exynos8895 interrupts

Markuss Broks (3):
      dt-bindings: pinctrl: samsung: Add compatible for Exynos9810 SoC
      dt-bindings: pinctrl: samsung: Add compatible for exynos9810-wakeup-eint
      pinctrl: samsung: Add Exynos9810 SoC specific data

 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |  23 +-
 .../bindings/pinctrl/samsung,pinctrl.yaml          |   3 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     | 431 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.h           |  10 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   6 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   3 +
 6 files changed, 468 insertions(+), 8 deletions(-)

