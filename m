Return-Path: <linux-kernel+bounces-563042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC8A6361B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2E016EFD0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1901AA782;
	Sun, 16 Mar 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0Hb92HM"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535EB15E5AE
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742135711; cv=none; b=rYmYrAzqS+QQXZVhaMxAn4ui2H47jvqMUadIKUXsoOfEt7wdK46EnU4LsSXstg3MIk6/4OCd3xilwOstRxBxxx1xC/GCU1ohupIlmipkqaTVszLqsbnw6KnOp2x6ir6eW1OJ8+siywqBu/wlZSx4eO7d/Dshxc/bkdNbkWbfco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742135711; c=relaxed/simple;
	bh=aiWwqXClDI29wp152Atw0mqy74j2Tu4jTQhO5oypHY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLAPx5Zi8/mHytYJzXYC0Lrb4zjotEqzsqtAZo51w2bGOnDzDl/nRzIfsy6DB4CzGOdxZ+d6gbXoqSZQopzsOaXxsuhAwjzsdOp7efiiYQ6v8c7ZUxjriKvQu/Zo8oAWavR6VfheNx4mySYm8hMjN9y8pyv61B2DK11WU8lV0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0Hb92HM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf861f936so2419525e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742135707; x=1742740507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZTnPcKiX3WQla8ra0bJdBCPKBZDqCAqRVNy0t/Nug8=;
        b=W0Hb92HMfn1MRuYZToqdPNVtUBfY+nvl8lnye9LUOwEfO+C9EMPZ6RVuk0VbSelkf6
         cgLGFDyGiSN5pyHYaek1I8fHA2yuPVk4mIfSLBIn+ar1XEVOME3YC6X/4bXOfXGAHJzv
         Wqm7Z9SOlsEUaDtp4vzdqIhKkJL/baQWBh1QY4pbj9mMEOE4tiRWFD2//Vjvgtkx7/BJ
         3qWIzr+tXWZksEl+0rlceoY4BpQuaFPqoFyhV29sLQe/xpnwtwUCSM8E1IecmeVdMSZK
         gcdnF49BQXmDoUlN5L888BG2Rkkt1n2Z3pIVritjhUDZnMY6fXpivGvWl/QGY9tQZ3pn
         FLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742135707; x=1742740507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZTnPcKiX3WQla8ra0bJdBCPKBZDqCAqRVNy0t/Nug8=;
        b=c8fufdqf6h3QFDVYlwFDMWhRvVAvfLj91RCSrsYSfYzh8cvKyqUEA3Mkcv+nX+SR1B
         kMZvJusQRAWoOdzFNY7NUWl4xT9c0Ym/xfBdTM6QYts7LkTq5qG5fgfkcJyxocFZ7aM+
         q6bwrHBZ8bbvwf5/BHpM4svAtfWXAVYWX2ImHUh0YAt7SEUVAVMuefRFVlTRGWT5D1IE
         a+7DNv7O1gvszdFtTmY0M5/15gBK7cSnESQZ7kMCDCTgZxPEWEQ14CTixJQqEa7jNfPq
         V9QSzsBfuXX5bPr1ujGy7/h4tfHbAEcgAFGxm8aw9kb6UpLv0xhiG7QmCw8Dx/9+3Uv9
         0j2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxbdzn9TWX5fAVdiZ0Vfie2fU59yOo/5uPGC0/gq0+bsx6n7le5GGK32eDHohfjShjd6blOMiiDLZ9s+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAfZg7fRx7ZKbT13uYodCYy7oBhz4wVxgVja9+XbQEaa9DMdE
	+qdXwBz+0dl+wJKTZp1WStEJPLK1v7QhhsmdD/hZT212HgT74W9NctxpffR3xBqlkbJitEqipZJ
	3
X-Gm-Gg: ASbGnctfarj3EndaytH9itzn86hRshFZ4fnWr3FFt63Ag2hnByLXyx1waOtFJoD4Gva
	hKvYO/1vIwd9FbDgDOhicC2NW2N7Gkd3qlmtKHz2/ALmDt53t7rThKYj6TFY7PiYcTp0Yd6XBwu
	iX5TrmDe5sI+GYsDf0y06vrAXKcHEhvsblTSOigmoySln+VCQClSDMwSpVz0tvc5UsardnCGZjG
	COpv7uaR2/IzPut8Wx3YgIPOAlNEtEtsAONOFU4Eu0KeNDwx5+HwLwsCn7kS/iJ/8+6j1vQUiUX
	dAzKPsj2/XZA841/LmOuPUWwpJ8U5Wg5vXEK3wcLkEcgyK2MWgKTloIIkRCrWd4XfuQl
X-Google-Smtp-Source: AGHT+IEjZUE3rI1hZ2BrgUwthxLukTEiV/0aM6N061MV+389eG1w1p0htt/ZIDPTn2KdSk5qkOG68g==
X-Received: by 2002:a05:600c:6994:b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-43d1ebfc1afmr41782705e9.0.1742135707545;
        Sun, 16 Mar 2025 07:35:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbcf00sm78451835e9.10.2025.03.16.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:35:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.15
Date: Sun, 16 Mar 2025 15:35:02 +0100
Message-ID: <20250316143503.17620-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.15

for you to fetch changes up to 90a0fbaac4a588a1116a191521c3c837c25582ee:

  memory: mtk-smi: Add ostd setting for mt8192 (2025-03-10 15:18:18 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.15

1. Minor cleanup in Nvidia Tegra20 EMC.
2. Extend support for Mediatek MT8192 to match recommended by vendor and
   improve VENC hardware behavior during stress testing.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      memory: tegra20-emc: Drop redundant platform_get_irq() error printk

Xueqi Zhang (1):
      memory: mtk-smi: Add ostd setting for mt8192

 drivers/memory/mtk-smi.c           | 33 +++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra20-emc.c |  4 +---
 2 files changed, 34 insertions(+), 3 deletions(-)

