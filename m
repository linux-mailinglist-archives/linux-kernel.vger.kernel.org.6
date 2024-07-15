Return-Path: <linux-kernel+bounces-252346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8C9311EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CC41C22413
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E918733D;
	Mon, 15 Jul 2024 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0X4fQmM"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8D8825
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037798; cv=none; b=Sl7e7xp1h/ccJXFb46OTQP4HsFpN+y1Hl9mzniHHi2+lrB1/bbKuaTLnBaoLUeyTCv8+sOqNz2IdtGGDIIOig3PXAaqErA923q1u+ljJEQJwsiIdR/r/Wf4gVE3pYPsWqfEu4g37DmiMZ5DpnxuuUagvyKDpqSoegRlwulSzsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037798; c=relaxed/simple;
	bh=FFKfg1684QIA7PRwfOeCkgPT/Dpt9B7p3dbIFnegUNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5OzOq0Y5ZchQuBrtZGz0GDFt7zfBQZr02kL08aOntA1aGrJ8ndP1GupCdcuYdodWqnCz2HmK1xgi6s4E7SZ6WHQccm+ybOSmK2VYzCk4rEVMa0cfCRY86KagK65g7x8z7zMqnj2M0N+XXnhVrehObJw9iVfR1jDWwh/x8ApsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0X4fQmM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so56408941fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721037794; x=1721642594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJD/Ixfz4BpRjDRZ9qBCyO/QidsQI5u1FfQwVpas3a0=;
        b=m0X4fQmMKrURqiu2FuYvHMo/frlqzOwPYCrO7isWD6pZFPqzffp3U2pUcXCSSBZ3XF
         /IJzILPDieGZQOSYb5EGt4LjNzh0Q4jecTJahRNS9sGS8Qn8G2ki0MoD5HNHYhybGQZA
         6YgFju5Izy7ZXXX51yrWdHi9A8J8w21r1a38pDtqhjEX0TJyRVCMY++TBbhcYeAjmdJ+
         jdk4gHZoq0SqvYeOLCrd3UuBPo/qwToPSokgXmH6nt3cf5NeXp7v7c4bZsVw7Lhvtt42
         fZnXBnIwTazBTFsagAeFhSHVPmct/8riQKP+ZDYW9yPxFnWgTIqH28zZWFYf6hkyaVX6
         DHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721037794; x=1721642594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJD/Ixfz4BpRjDRZ9qBCyO/QidsQI5u1FfQwVpas3a0=;
        b=fm6eUmHdQFktCwXsVTKPwKokz0/MwBqsSIKFri+lcDkySVvjGc4Vq5+JQcRHyZNzXZ
         Mq5Df8EsxQHfvVa4/yK3ED5YdbBP9eDgFSmibME2x2xna2OZ1I7uTnQYwh6I60AYhQYA
         +fp4Ws0j4E30nR7dLCAsKpt3rRRK5VkgPAYFXMvva6FqjjhHhA0F1aITyOWLQtb89j3E
         +ZpxWXT+ky36dUCEdTWNBc6hrYXsMZQQ3WD/cpY7rUlzSv+vJqRSxuL5u4SEilriQeeY
         0ecvsPYjYoZfDdlZAMd/ZSBRshuYXKE7s6XAG44cJXa1dUEHMznH0T/875fMbZrlnVE9
         zmZw==
X-Forwarded-Encrypted: i=1; AJvYcCXjBuBxxanf9sQWmO7r6O1L6JM3okqhfXNgjJ1SVeJ6b3vR/spOSpU6oz56vsPH74pLfHZzxBU2BXQiqNjP/2u0I/yjUuRXgjugj0ny
X-Gm-Message-State: AOJu0YzL+NRVqqQrmsiIPUm9R3DZCDSX1VxOx4P+4qwYiHEA7yOLz4hE
	Z8G3guG/GCMPttboJPXe4GUA7qdA9xTLXG6w1Ey9kfEuqrJfuMzPovjQBOvoxRA=
X-Google-Smtp-Source: AGHT+IGIukgKLkWoP2duYj1VtBFLw7fF0D3nkSuQETO64JSPFG53i/vghm8+IM/zpQ7RTwQhVMqGNA==
X-Received: by 2002:a05:651c:1a08:b0:2ec:3e02:9737 with SMTP id 38308e7fff4ca-2eeb30b89d4mr156183081fa.2.1721037794213;
        Mon, 15 Jul 2024 03:03:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee195f380sm8080991fa.138.2024.07.15.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:03:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.11
Date: Mon, 15 Jul 2024 12:03:12 +0200
Message-Id: <20240715100312.175281-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the PR with the pmdomain updates for v6.11. Details about the highlights
are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ddab91f4b2de5c5b46e312a90107d9353087d8ea:

  pmdomain: qcom: rpmhpd: Skip retention level for Power Domains (2024-07-09 12:47:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11

for you to fetch changes up to 67ce905f5f725c0ff4675b1aea381df0d80a5f03:

  mdomain: Merge branch fixes into next (2024-07-09 13:12:41 +0200)

----------------------------------------------------------------
pmdomain core:
 - Add support for HW-managed devices

pmdomain providers:
 - amlogic: Add support for the A5 and the A4 power domains
 - arm: Enable system wakeups for the SCMI PM domain
 - qcom/clk: Add HW-mode callbacks to allow switching of GDSC mode

pmdomain consumers:
 - qcom/media/venus: Enable support for switching GDSC HW-mode on V6

----------------------------------------------------------------
Abel Vesa (1):
      PM: domains: Add the domain HW-managed mode to the summary

Christophe JAILLET (1):
      pmdomain: amlogic: Constify struct meson_secure_pwrc_domain_desc

Geert Uytterhoeven (2):
      pmdomain: core: Use genpd_is_irq_safe() helper
      pmdomain: renesas: rmobile-sysc: Use for_each_child_of_node_scoped()

Jagadeesh Kona (3):
      clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
      clk: qcom: videocc: Use HW_CTRL_TRIGGER for SM8250, SC7280 vcodec GDSC's
      venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on V6

Jeff Johnson (1):
      pmdomain: amlogic: add missing MODULE_DESCRIPTION() macros

Peng Fan (1):
      pmdomain: arm: scmi_pm_domain: set flag GENPD_FLAG_ACTIVE_WAKEUP

Ulf Hansson (3):
      pmdomain: Merge branch dt into next
      PM: domains: Allow devices attached to genpd to be managed by HW
      mdomain: Merge branch fixes into next

Xianwei Zhao (4):
      dt-bindings: power: add Amlogic A4 power domains
      pmdomain: amlogic: Add support for A4 power domains controller
      dt-bindings: power: add Amlogic A5 power domains
      pmdomain: amlogic: Add support for A5 power domains controller

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  2 +
 drivers/clk/qcom/gdsc.c                            | 41 +++++++++++
 drivers/clk/qcom/gdsc.h                            |  1 +
 drivers/clk/qcom/videocc-sc7280.c                  |  2 +-
 drivers/clk/qcom/videocc-sm8250.c                  |  4 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     | 39 ++++++-----
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  1 +
 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c       |  1 +
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 65 ++++++++++++++++--
 drivers/pmdomain/arm/scmi_pm_domain.c              |  1 +
 drivers/pmdomain/core.c                            | 80 +++++++++++++++++++++-
 drivers/pmdomain/renesas/rmobile-sysc.c            |  8 +--
 include/dt-bindings/power/amlogic,a4-pwrc.h        | 21 ++++++
 include/dt-bindings/power/amlogic,a5-pwrc.h        | 21 ++++++
 include/linux/pm_domain.h                          | 17 +++++
 15 files changed, 271 insertions(+), 33 deletions(-)
 create mode 100644 include/dt-bindings/power/amlogic,a4-pwrc.h
 create mode 100644 include/dt-bindings/power/amlogic,a5-pwrc.h

