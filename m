Return-Path: <linux-kernel+bounces-553261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69265A58677
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEA13A3D56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2AF1EB5ED;
	Sun,  9 Mar 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkhWgUI3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78221F0981
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542722; cv=none; b=ZisItgLhvolA4O1YnjL1rAaHJa65BSFMOFtFeEBfKQvasOr7GYuKAKsEqgGh1/DnkKBD7WPHR4f+7Uhq53aR2J/+Q90NgWd3+RAtumJui/RSvFgIkQS/3r8nTaLc+R9K7CqM2DTEABb0mFgG8Hn2BZj9L3XpPzNl0A+esnDoAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542722; c=relaxed/simple;
	bh=qUhJTHxhYSGPM2ivbiGZV8niqI9IljfjERFihuPePoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQEgHw/gNZRjWEdrQueggRQMrBpc2dGrKO9/RAGXozWi1nicPw+dN+WCm4UOjV6w5zHfr7jzGqcG66btm9zAA86930eNYMFCZA3p1xMGHJrRBdDveiMYuu1SH6J8WbwmMSgY+4a7pAOKqznqtBB5CXK/nx53ucxf/mTzdwWF5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkhWgUI3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912387cf48so109237f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741542719; x=1742147519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jo5cZzus0FAHnZneWz5yvUV4j+MaUQTnWxm1PiFIAZI=;
        b=lkhWgUI3jwTbJKxTZIRENYWztV/B9WAOo6rSS6zyA0scpOkfMKDQAvBeUf4nU+fw3m
         9ZT2iqrmbHIpmS4QExJQgiIftbDyGTf88JtwESwyTyT3rvT92hBUOfLklK5LsJqvr8JW
         BsMpXJZbIMZ2z2FCr11R0Y54/sv4e8611nF3ElCNYalmRSWUVZ3fVVmqI3qGrVhm8xEU
         EW6Q4Gul1XVOi5LrbbAoX6k1bHwNoachAfQk7qOPv5vhDCKEoRV6ZeLKgr4T05PDl75W
         Tp0f2p6chobBh/EcUceFDSwB6QrvjxXKOaa+Euq2RPiaL/ekAL0Zx+wqKxFiLpX9N19t
         Gssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542719; x=1742147519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jo5cZzus0FAHnZneWz5yvUV4j+MaUQTnWxm1PiFIAZI=;
        b=invhkjAaqi//WfSBm+O72oTKbVDQ84VFJfDryeSnFYLY3Jx9oU8lihy1AQZz8nCvRJ
         lVPcKzIV7lW6TygOQGBA/B6jg0uRnoqlltMYPlh7xBwTveV/zk/pR89beFw9nidF5NO5
         uE0VQEUKT5x9Bni8/jtcHPzhtFFMFeqNk1fK6w/SzZdIP1sUvLOaWtKSCSgcb/BQ3J0r
         5WTTDMLfA6S44V0T8R9prIxG/Vh9YMX3ckzwT6OV3TgvS0wAbKqM0GQgfcatcJSY1/mi
         5COPh8pugufLsrXlp40pF3R9Ypux8IHvLv7So4Li0HQvebAV6BTBE/MpufjMqNOJpKXG
         krJg==
X-Forwarded-Encrypted: i=1; AJvYcCUmWF1cZW2b5fmJUq74sQGYE1hnZLLfN2E6rtUlVUw9yiW9NaRqBLgwTFqnLFw6Q4FSXk09K9wBiqcjtS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoUkxEjOjumgx2rbB9r0qpjNS3PMnkdj5rncmBR6z2UO/rBtM
	uPcKll0pbaHCodF44WOoPnnQ6JWcRIlcJSPvqpbA2yJxGP1Hf+3YSKKzZy7ZhYA=
X-Gm-Gg: ASbGncuFKMhWCgKfbpxwrxXG9mlc/hqrj/7/gR3vkBaXfrWekwgHjJLLil+uIsK0B7z
	NbPD4WiIWyCBcuSm43oVk5t4ni1kVvNyCHLgkmw5/9wJkp3yj62Nh2YU1ZYaI3hgs/dxv7kS6EG
	fJv7cYZlEaYwxj1nmvURSIAiKv3zLFrG2TCkAXHp4ZCv/LFh/m1fO0+3FdQ3QdOtsrNpBhwtGfV
	rY4Ap1MtEwx3MoWlwLX8FZOP+MB4xz1jVQCy6j/HF1+aMEfMMK+/0WeOCYz+kQV8n0VpQsGZG/Y
	m1GrCvkHqXiS2t8DdyzXNds01tB8F5v2l/QGq31OoPMKPPYz8LKjNi5fweQ=
X-Google-Smtp-Source: AGHT+IHFXC5otRZ7F4yGnhvywHvWeRyg1x0RiP0aY2UeNSAgYGd4FzPX32gmebfW67foinZiceGAog==
X-Received: by 2002:a5d:64ec:0:b0:391:2acc:aadf with SMTP id ffacd0b85a97d-3913bb4709bmr1218934f8f.6.1741542718937;
        Sun, 09 Mar 2025 10:51:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7934sm12638173f8f.12.2025.03.09.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:51:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-clk@vger.kernel.org,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: Fixes for v6.14
Date: Sun,  9 Mar 2025 18:51:53 +0100
Message-ID: <20250309175154.6701-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fixes for current RC.

Best regards,
Krzysztof


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-fixes-6.14

for you to fetch changes up to 53517a70873c7a91675f7244768aad5006cc45de:

  clk: samsung: update PLL locktime for PLL142XX used on FSD platform (2025-03-05 20:13:25 +0100)

----------------------------------------------------------------
Samsung clock controller fixes for v6.14

1. Google GS101: Fix synchronous external abort during system suspend.
   The driver access registers not available for OS, although issue
   would not be visible in earlier kernels due to missing suspend
   support.

2. Tesla FSD: Correct PLL142XX lock time.

----------------------------------------------------------------
Peter Griffin (1):
      clk: samsung: gs101: fix synchronous external abort in samsung_clk_save()

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

 drivers/clk/samsung/clk-gs101.c | 8 --------
 drivers/clk/samsung/clk-pll.c   | 7 ++++++-
 2 files changed, 6 insertions(+), 9 deletions(-)

