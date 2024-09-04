Return-Path: <linux-kernel+bounces-314720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36096B789
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9A1C23D53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB91CEE99;
	Wed,  4 Sep 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rD4X1bCw"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035A1CEE89
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443847; cv=none; b=jXvi6kdtlnr02BoIQPGj2hbDd/viJp+QzScVnHBrxHgMmoFw9fefN3ETEWbsVxP/9lCPK/EvafV+fuXI5Z1BH6wbOEiqBKncYj1v9Cqyd8alX88Br6V/HlGu+KslK6SCi/Y4BigGW3RVzEfhgvMXKRCeL4LeN0UoBfUiuZHENE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443847; c=relaxed/simple;
	bh=FTjiDZN9yInQz1hWZ/h7wkmO4TF9Z15WUfoej4IaTi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kzKir8+tP28LFJizOStgl8TsjMwkgtV2zMvYGRAWdC/mq+vkkQQh1+y1MJcJoCNLop7hIjQdfz8GilpZvh2UWFFgKyboPcWu5gLI+uWAnN+2AjKiKYqb2nnyrXSPcmcVUp+/yJKLXzR+f+xW6JHYx1j921v/WAuErzbC67j0Mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rD4X1bCw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a80eab3945eso611533466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725443842; x=1726048642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VG3SCtSxXoO9kJ5qHjWCI3Ghtvll31qds48f+pV4lgI=;
        b=rD4X1bCwGOBvitJHen45c4x8u46QDcFb1O+/cG8Yp7e6P3PkWs0zrLPKe8uzKZ1XBK
         DusovKHjjLPg/ZUYDiT69KunU3kICUh/VEf4iBVaoHJGXpXDjouOxB9383Dt1p3MFQIH
         f3giDMJko1rwrlOs2lt/gGTnGO2Jjv7w/Q/K0Uteb5OK8wqry1em3hleSKUUkzc1pBA9
         SqnmCEMA3aRqDfmv7HmmtklU9ad0whi9XZX6EGX1e+RsJ9p927mX5335xbIMMNZXSyEX
         Er56b33fUdVYF57JYcLmp9AkcQEOgyp+N3nQmg5JuMQl4qkVtGkNR0EG6ROFn+d88nAB
         FYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725443842; x=1726048642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VG3SCtSxXoO9kJ5qHjWCI3Ghtvll31qds48f+pV4lgI=;
        b=UM6A8KjWBxeEd8Az3v2Gl1oJVy7M37bE5zoF3tyIOkZhQ7EzkcyrkJZAFNyBAATZff
         NoYJd2QwuGgoM0gTE0LVkMFKnR71TyBcHu4NI3G0DRiwyXzJQvfCHLlndZ3e8hlqkhfY
         QhATZEeh3rzXhfNuIUrZ1PnRN9D78q0UAjDmpUHfj5IBh/AKQr4SOQWfB6yP7zGPNlKA
         LLgsyDbkM2gwcpAqidqKiuL7olR3EHM1iLmGYhGGAscrrZ8t2jSU4k5fWijWWBcSXUZT
         F67U6c3U4otZtonkJswlT8A/v6zxZ/Q9Q/e90vfMhXRR6frioeLUv9ASEzvvB8AUY0v0
         qGIg==
X-Forwarded-Encrypted: i=1; AJvYcCV9lDT7cMSy8biBN+mk71cCi8htGFNcMBW9bK3jJhjXTov0WDov1QXxBZAh0BKOjEoVPa+j/LEcbqdlAEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Wc1vLdqqYMfa7OfOPQHnsUrUJdARF3jal6CSB1dflH0WNIbg
	P5YEeLXfb+Sqy/mXqATfT0zFgs5/oEceDJZzqPsxyBAkWO26jZ0VCxmrzHZnKTk=
X-Google-Smtp-Source: AGHT+IE+2W/EhIoP1awAXccexwE4Hd7T9R6Il9R6pyNmD5WD6nEZ6n3i30rCZtmi+ObSIObIoDmtIQ==
X-Received: by 2002:a17:907:72c7:b0:a86:a30f:4aef with SMTP id a640c23a62f3a-a89a35dee4cmr1210183566b.22.1725443841806;
        Wed, 04 Sep 2024 02:57:21 -0700 (PDT)
Received: from hackbox.lan ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fefb26sm788422666b.1.2024.09.04.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:57:21 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.12
Date: Wed,  4 Sep 2024 12:57:10 +0300
Message-Id: <20240904095710.2813541-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.12

for you to fetch changes up to 32c055ef563c3a4a73a477839f591b1b170bde8e:

  clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL (2024-09-04 12:39:38 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.12

- Use clk_hw pointer instead of fw_name for acm_aud_clk[0-1]_sel clocks
  on i.MX8Q as parents in ACM provider
- Add i.MX95 NETCMIX support to the block control provider
- Fix parents for ENETx_REF_SEL clocks on i.MX6UL

----------------------------------------------------------------
Michel Alex (1):
      clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL

Shengjiu Wang (1):
      clk: imx: imx8: Use clk_hw pointer for self registered clock in clk_parent_data

Wei Fang (3):
      dt-bindings: clock: add i.MX95 NETCMIX block control
      dt-bindings: clock: add RMII clock selection
      clk: imx95: enable the clock of NETCMIX block control

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  1 +
 drivers/clk/imx/clk-imx6ul.c                       |  4 +--
 drivers/clk/imx/clk-imx8-acm.c                     | 38 +++++++++++++++++-----
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 30 +++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  3 ++
 5 files changed, 65 insertions(+), 11 deletions(-)

