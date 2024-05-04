Return-Path: <linux-kernel+bounces-168639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4678BBB20
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9908A282C30
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874421342;
	Sat,  4 May 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiCLLR1T"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39370171D2
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824952; cv=none; b=aMBr6Fi8mksEF6cZLf4rFCPJILTM0Dg3VkcziWM64djeJ1jEgWghR4dSxGbQfQ16zeb02C2qUz+NTUMeO7jXGMPP6knluYbxmM7t0lt71ihSGkHDMs/I+1jAfgl7mTeF65uC9ydfJ/uXuOZ4QxcF4YeL9htGVnJ9ZKLcBTwQXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824952; c=relaxed/simple;
	bh=PPpOQyMbS6Mzgm/54tzfCd7GGaJRpWvifByPCcJ0Roc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FX1HdyqVGyGjGId2C0ghux2Ro5HJ02xOFGV5KBMGIE8ef3XWvk9h72pDvRNoBsZkJk5bTodPiK3kdYNRfHLdk3nJ52lZ3WQXZxJ8LPIjaIAFSfieR/EalOe4F4Ccnu/53N9kwb0dpFPQAH0pfvtEdQuLNW0gMG60Jfj4Su7fWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiCLLR1T; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a5f81af4so104116966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714824948; x=1715429748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHgH5JlemKr00lARyvPKvrK2odUhHHD2XashLbtv/ww=;
        b=UiCLLR1T+hhfhbEFNzgTgl0vO0ZFwQzS9i+evLhLdsm0ivXL3XKyUSJ06RlswHEbWH
         beJNOnvTOhgLnCrFU5g3xWke5MWwSw8YH+aZYEJ8ICHXP99U23gGbAIYSsb0nr+MpqJd
         tjhPaCn6Y46nL474rYwlWvJadsVb4FT7rgNsbe0iqzYsYc4RMUJU0fXUaX/qVqnTXjjl
         18WcnnoY6FCIOQ/Mr3OyLude62d4WIZzvjx5NFo15g2usUU3Vx/ScNjED8D6aXPJKBxE
         SkIhD+ub9oN21DaLA//7QtABZhq2VaG9adJfYHi6awqbUNVvEus7inj5flwSn+aq5kDq
         BULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714824948; x=1715429748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHgH5JlemKr00lARyvPKvrK2odUhHHD2XashLbtv/ww=;
        b=LFkKx+myNNMeTAigECM3+AyyZvHEumPoeRMWQ48404TrqugoBD6WKJHRXyB3U4qz0F
         g+qjE1bZRC1rmS7oGA+yUooVAPKp2LM3mcEeYLcp5C2Yy+hPxM/KEQAmNHwE68fJM3Y5
         1BbPII/Rkn7k2uuXIUxPa/uu8mpLONDV7WwZeCvGveA4nNWIrCJsjHG0rWhYm+W7VKVN
         ooXdm6Y5p9vkhF3T2Q+tHdkjD01RxDIA2yId3WQK89Sw130ifa2Urcal3huWAgv5RyMX
         iKCE6oSMdfEfCmB9XNZAqa/fMUGJUGsOQFfKHk9wJRQXiv1pgMR7Lf0Unu6+Va8xW75Z
         Lluw==
X-Forwarded-Encrypted: i=1; AJvYcCWNEPvxM2DotAt0rIoYzqdS3Ad62DV/E+WKa0TWt6SlIx6u3kOAU0C0q0I9yr5puYzNJjR/OxBj88TMYLZo/lea3zGkE7VM0llDj5zf
X-Gm-Message-State: AOJu0YzNFuDHBauJ0cr+3ZfCEYr1uKJNTvTNjH4iBpRzsovtTF+TEArN
	T2fzb+yXqrLybhIV3fV4ntbOXwGqyyqC7lYiTfk5qu/08xzlt/bULOdVd5xmCw8=
X-Google-Smtp-Source: AGHT+IEbcI1Km5xoWoY2FdQxom4QjiT1xv6T6XAEW4MTvRymIgNcGhFAY3zqEBgmmbgizDbdNHRtKg==
X-Received: by 2002:a17:906:5617:b0:a59:a8f8:7e1 with SMTP id f23-20020a170906561700b00a59a8f807e1mr1072336ejq.58.1714824948556;
        Sat, 04 May 2024 05:15:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id uj4-20020a170907c98400b00a599f876c28sm1203407ejc.38.2024.05.04.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 05:15:47 -0700 (PDT)
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
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.10
Date: Sat,  4 May 2024 14:15:43 +0200
Message-ID: <20240504121545.8187-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.10

for you to fetch changes up to e5b3732a9654f26d21647d9e7b4fec846f6d4810:

  pinctrl: samsung: drop redundant drvdata assignment (2024-04-30 09:41:58 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.10

1. Add support for toggling bus clock (PCLK) for any pin controller
   register accesses.  This looks needed on newer Samsung chips, like
   Google GS101 and probably Exynos850.
2. Drop old, deprecated in v6.1 bindings header with register constants.
   The constants were moved to DTS headers.

----------------------------------------------------------------
André Draszik (2):
      dt-bindings: pinctrl: samsung: google,gs101-pinctrl needs a clock
      pinctrl: samsung: support a bus clock

Krzysztof Kozlowski (2):
      dt-bindings: pinctrl: samsung: drop unused header with register constants
      pinctrl: samsung: drop redundant drvdata assignment

 .../bindings/pinctrl/samsung,pinctrl.yaml          |  21 ++++
 MAINTAINERS                                        |   1 -
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 112 +++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  95 ++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   2 +
 include/dt-bindings/pinctrl/samsung.h              |  95 -----------------
 6 files changed, 226 insertions(+), 100 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/samsung.h

