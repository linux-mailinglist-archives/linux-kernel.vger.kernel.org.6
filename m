Return-Path: <linux-kernel+bounces-563041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C88DA63619
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F97A72E6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A711A8F97;
	Sun, 16 Mar 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4G8Ex1f"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322652E3361
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742135476; cv=none; b=GowZFdGLaM3XyV4tgaogY3wTE3W4y2Idd3zhVhr7FfrPXBe5h8nz7cN7raPjj/GoHIzmEHn9zwsBJqtLdt1T8FgHEw/Cv5kTM5cm4F7xMh7i6DRjYL7hwsT1/KVjCx5b4KxxsymhfjqXFR/5xygot880HeD10LOxvh2s7jDDeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742135476; c=relaxed/simple;
	bh=ULlCJjdLr1vKJqaHlZQyZo7s+9QYPUfaXtxEtSc7JEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHlkYWbbVVib50kToUedWO8VsNZfbz39/34/LMJzmqGSZ+uzdoJH043014qKT2aVZn4KmtIaZ/pzyGuNTTauYCtKpxNmSW3M8uppjndMR7o6YrUiMtf8NZ6qLCBBRN9T24WNu+4kYv8py+R+NJ65iq4tZpbgqi0T/OBH4mdHM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4G8Ex1f; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f54938d1bso122863f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742135472; x=1742740272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc/KJH+qtYUavPHzbi/9sG/C7pjG+2ryVkaTYFLi/Fs=;
        b=L4G8Ex1fQdQOcTZb3DJWMHWs84cUtDG7R3Hh58e6q1bp0DDRZdS0+jUv6utc5UAwPp
         76uhuzStouz0Yyp/Ql7bhEKQVZaLl8m9Afr4GucZNYfxzOjCwKdEIxO1xUdD+kTE3d9p
         RvT/IRqjRvmBCk+jUd8aAf2/Xmi613X+8gSyWf3lBCW2pgcEQpfTcOimG1lQiv++UKC+
         kYyFl0wfSeBqZmbev5xmEbI2qfChijFANKIwCP/79gsYg2SzqqOq869MWFK3zl3uhRKn
         m15WD6ZMiyG/5c2onB9xedw5nthhSQCuMNc8rVzamNHip+f0KStwzbCOlOhRI+WJW5SC
         JRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742135472; x=1742740272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc/KJH+qtYUavPHzbi/9sG/C7pjG+2ryVkaTYFLi/Fs=;
        b=UDxjJGq9qq5uhbBABsCxa2vu8tFnCWSmSkfKPoSFZfmHwr3L0EBSVsr0Qg0o2iAMaq
         ndmmYTEF72EdItImkVCviEg9F4ds8ioOCkPgMcv21tXm4oJdfhfQjxZYrRmp+zGJwJr0
         jiYFULnl3PW/8MMYBMZXex77FujL6J8ajh7hpAR6sKvte6AQYaHgBB/Gii3a4BDxrX/V
         P/+HY79KUe6htysVyIJirPHpaSKwIdcFhiRXl1ceiTotq8AY1se+tWuB+TNY1fyPKZdf
         SqV+ltCLZq/ydjNCPqn+FL7gtGkYKp/b8Exhcn+O84E0uFay4bw2BkGKGcTfMeNp6NEw
         WXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFGHGAoVwsO1aKey5ryhu6xH8wDpLQBcbVeiHEMifTzjh6IR0FhvrYjFD7MwunWtm9mXeV30aqDmQndPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxFpmhAd/3v3WELcqfSObUgRiRrgP+kKtm19wKx2JUVeZu/UcQ
	8uq9EkQXVkDQ/VjMwyT7znGGl0E6wGp8r0EnLGvWVxq367oPrMlbuMfrz3s0mu0=
X-Gm-Gg: ASbGncuXvvjBm1wIKxZoWKqS03BQw58x43+QkMJZiSE448hnHblRyHdpzOjnT+jtAi8
	67Ecf/ZFMZZ01soSkuQDm7OayKHEj46OtfDQ/DBV8RYMuP2tGuzTF/MdhIpgcuKjej3kQveuwXu
	Tqj5al8whtYEqpIO02tTuVJb6avaQBz1Hm5g2HHt/xU05bsMWMGdzFhPsgm4m26M5zaR4tbx8Ft
	r4iaO4G0JYT3sTbcQV2LonxwNQJ57rvFfRmdB8w3ZxvQlE6EqZlclpB35s+HPhRfsI5qoMymKeF
	Lt/TpAg0YRIOC8SRboC+FnChlukHHyBZ0o1GVc8AgjD0gVWQmE5NJwzMl/sXGlUDf5+j
X-Google-Smtp-Source: AGHT+IFi9JXkUWFEjeJAm1SkUmYzub/naf0VWY52i62TdEebnaMcewd6ZseRSkUbDf0UNDl+nNKnHQ==
X-Received: by 2002:a05:6000:1786:b0:391:42f:7e83 with SMTP id ffacd0b85a97d-3971f51129emr3597689f8f.13.1742135472433;
        Sun, 16 Mar 2025 07:31:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881539sm11919868f8f.46.2025.03.16.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:31:11 -0700 (PDT)
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
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.15
Date: Sun, 16 Mar 2025 15:31:07 +0100
Message-ID: <20250316143108.17045-1-krzysztof.kozlowski@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.15

for you to fetch changes up to 701d0e910955627734917c3587258aa7e73068bb:

  pinctrl: samsung: add support for eint_fltcon_offset (2025-03-11 20:37:29 +0100)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.15

1. Add pin controller drivers for newly usptreamed Samsung Exynos2200
   and Exynos7870.
2. Correct filter configuration offset of some of Google GS101 SoC pin
   banks, which later is supposed to be used during system
   suspend/resume.

----------------------------------------------------------------
Ivaylo Ivanov (3):
      dt-bindings: pinctrl: samsung: add exynos2200-wakeup-eint compatible
      dt-bindings: pinctrl: samsung: add exynos2200 compatible
      pinctrl: samsung: add exynos2200 SoC pinctrl configuration

Kaustabh Chakraborty (3):
      dt-bindings: pinctrl: samsung: add exynos7870-pinctrl compatible
      dt-bindings: pinctrl: samsung: add exynos7870-wakeup-eint compatible
      pinctrl: samsung: add support for exynos7870 pinctrl

Peter Griffin (1):
      pinctrl: samsung: add support for eint_fltcon_offset

 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |   3 +
 .../bindings/pinctrl/samsung,pinctrl.yaml          |   2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     | 405 ++++++++++++++++++---
 drivers/pinctrl/samsung/pinctrl-exynos.h           |  41 +++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   6 +
 6 files changed, 413 insertions(+), 49 deletions(-)

