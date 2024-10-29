Return-Path: <linux-kernel+bounces-386446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BBF9B4394
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD163283321
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A92038A0;
	Tue, 29 Oct 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpbugFoy"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972DB2010F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188435; cv=none; b=a+jaSQcvxdvY0cjxgn0+6Ejc5/+TwpGpDsuNW3+xirafQ0ahFFAkRlg1Q1aGxZXNA8QUYNb1RTMCxxCREBMwj/BlB54pCowm/0OJnk0Qx/9WE3Cyc8mSHCnPd+3aLJTZ3rXrPfWI2DyfQz7TQs+gZuUriO0Pl2FBKNfr6ObZeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188435; c=relaxed/simple;
	bh=KsjPCtV8NQo2f8cWR9Xgy22vudGexF0FRJzmq90JWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJMu32JTxN9TXYhQXt+4WSsJKhmPIkLYDPEcQ+jROAh/kx6d01b0BtvR4M+QK7m1d89L2bHYeJvlGA5lvu7NAnx50gC/X6YlaKfluRSzLoH2X/kdX3+mWoxgm2pYFZ7kLKlhxngX/pIIRaeKSspkH/M6Q7uzbBMsjChzrrYX5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WpbugFoy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so5650825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730188432; x=1730793232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PWSKsonNDrTWkbxkIHIq6fERLhyZhv2JFfOwChp3PQ=;
        b=WpbugFoyaT3YuSCl8s0Xt/Bmz4JUoYBzOjsZgBEBNMBD3wIuyXa9VyQ9D9fLqLQwwA
         i+akfzIPtcC277kjlal3KcubhDVRvmP+bJu61iQYBLqnRH6+m3P9C0q6gkWovcSJ5t9x
         GvDvBsx771RzmlKTbDycKAdlcdCZMdeHv7vPlOM0JnNJoVWeQ/3q5nwaprd1gXmhm5F/
         iUXc0575scblkcxAnL6um9bDlt1Kw8Ke3P0JOQe+9HIOrMvlV1/qIi0IqLK5xE1HnzlC
         R2A5UDYqhYkMGO01JTtpocuw68wcVbZGDB14vPHSCfDlndZ/tPYQ3dPTXLIyBc6J7jKu
         EYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188432; x=1730793232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PWSKsonNDrTWkbxkIHIq6fERLhyZhv2JFfOwChp3PQ=;
        b=nuN7LSoZWA7ZoO2g9885d7Nx/cyGDPse/5mK11WhVK5lmFfaj9/8o9+0Z1W7PjZKUu
         6bsC6M82EX+4G/E54oOim7bPfPncxiqsKVbKL6oUbpUz+cyjDGAN1E0LcDXpDz6R4j1P
         Qq7ErgeasXVmjGMCMp9NjYhQloqgq8OuT66HyVwr4hS5xGUgrIcZkhKAvHz/O+1A5HW2
         zeNAV4V3AH0garKyLO36r+3BI6u+M2W6LX/JM0TtAqD6HqSdK6WH7zq+9igYvoWk+T17
         QtX/v+sBbW7LfWhv2nUP5zJU02z6BRxREwnos9b8Dj6ZLKVraj/L+DC96qyZ6lz/vpDi
         UZtw==
X-Forwarded-Encrypted: i=1; AJvYcCXMcfOxuL4Zp3nXfyDkeV9HnEdaUYAXKRRvKD0O3kF4rlaCX9ruLdm0WMK6WS8syckaHCan1FC/PPM++rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/XTTL9iDQkbCbPYCehVnhpaQNbwuOoWKtBmdj8KOLFZlC6U3
	CNyjAimjco+0OLU+G+bm08bvfy3FKQ0bIr85ozIiXoMlXPjooudoa6+qTaVHwys=
X-Google-Smtp-Source: AGHT+IEo2H0HuNGG3T1G8gRQ4j09F1Tx7ARRpFQfrGtgBnln1DVpGWZgDlCNPMYtiYTwQ6xUjK8ajQ==
X-Received: by 2002:a05:600c:3b13:b0:431:55f3:d34b with SMTP id 5b1f17b1804b1-4319aca248dmr40337185e9.3.1730188431861;
        Tue, 29 Oct 2024 00:53:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319359527asm134564545e9.16.2024.10.29.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:53:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.13
Date: Tue, 29 Oct 2024 08:53:47 +0100
Message-ID: <20241029075348.19580-1-krzysztof.kozlowski@linaro.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.13

for you to fetch changes up to 1f1d847a657523e182df87f88158b607afe7d559:

  arm64: defconfig: Update defconfig with now user-visible CONFIG_FSL_IFC (2024-10-14 20:10:47 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.13

1. Freescale IFC: Split handling of child nodes in the bindings to
   fix dtbs_check warning.
2. ARM64 defconfig: Nothing selects CONFIG_FSL_IFC anymore since
   commit 9ba0cae3cac0 ("memory: fsl_ifc: Make FSL_IFC config visible
   and selectable") and actually CONFIG_MTD_NAND_FSL_IFC depends on it
   now.  Enable CONFIG_FSL_IFC in ARM64 defconfig, so users of it won't
   lose these two drivers.

----------------------------------------------------------------
Esben Haabendal (1):
      arm64: defconfig: Update defconfig with now user-visible CONFIG_FSL_IFC

Frank Li (1):
      dt-bindings: memory-controllers: fsl,ifc: split child node differences

 .../bindings/memory-controllers/fsl/fsl,ifc.yaml   | 32 ++++++++++++++++++----
 arch/arm64/configs/defconfig                       |  1 +
 2 files changed, 28 insertions(+), 5 deletions(-)

