Return-Path: <linux-kernel+bounces-306725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712A964296
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6771F262B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2119148A;
	Thu, 29 Aug 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1vgj10"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4518F2C1;
	Thu, 29 Aug 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929523; cv=none; b=G1ELFUwQrGxUOzOyBTTri5q+61XHSKT2DYS2P/M6X9qJkCBKDI3W5sT6H1nnYtfhMGMGuGe3243C5es2mBZ1DusXOiTq0bhQ+5jYotkVjDr0TOhq8VGgbwICfqh4uDmQ9MwSjjOQzUupiUrRkKAHu2DMp4lHTCCyT+qZU0F7wY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929523; c=relaxed/simple;
	bh=ANsBIa2TdUYJmIfErVq94w5VFjOAUaSvlwr8O3efTQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZOj0NaU0kaQapNNuiH6OrgU7ujjF/TUFBj3bSVCWdlWHN61rnOQi9pZtvxyUfWYHr0keWAqyF5ykElWyq6yUxaXYEeB2cOt20z1uPtYsxgd0d/HglT73JMxK27JXsYdAIPyhfQvLr8a4442ktlkSWkMhMsfZ7rEhLT/BnGaa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL1vgj10; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71431524f33so419884b3a.1;
        Thu, 29 Aug 2024 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724929521; x=1725534321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsCX4I75Bt35ZXKA3R7bksaicVq4gEOUFqU0ER8sKQo=;
        b=HL1vgj10vF4+lPPraju8eTYEXAMQDUxLlK14dvkOOVFVJFe19+2c4ZK4IycHRbOWCF
         MjFN7EsuAJEumxeIv2tEoB7hTJ/Z4VF76RaT6CeqIeUDm1FNzQw3vKmrEP6IFN89zqoN
         iDdKBwkSxiaKm83rwQnz4A/rlUYFXLdrRC8Wrhxbo3x3LuzExzCB8cKSg1hY1sA+veqN
         gYvF7Mm900jGK4aq2gsZaJS5HXP8mOP4l4Gt9STTOcthakx0wSG/dwMlUBAOXbuzRpAG
         QcQPZdYRhSF9fbmdMjWeWGxE1G6ci/Lx8v+/76aNPHIGoFC8iStSnBc8gmaI28EJCEoC
         TwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929521; x=1725534321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsCX4I75Bt35ZXKA3R7bksaicVq4gEOUFqU0ER8sKQo=;
        b=Pim0e7z0O5Rd8ArSsE3G0Zq2Uo/7RWjQv5cCtqCOGmzPY+MQrqXeMLUfxgo3cAEEY2
         9orIgANCKiXZ0Yav4/LlBIpBwgkKOCIOIwq6dORMHBhNg0ud1efqYrQXwJp4u+iF4cle
         cgun+WbHv6HRrknei5idlXzzhlLJSKvnJa1dHYsTlhkAEY+sPL1fROOpYYjAGwG/0cEw
         6wu8bZMo4rzrcKuWPU4FZqxgAUoPkIL11o+rPeXTIDYkn6PDUPSBc4OWTjj90lyNRp52
         HvEPbZ3T19rbTQaP5LeNdaWyASU12EKApuFvcqI0SOM6+qUqh3Cm8hefx26LEDg77DrD
         rR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMbWuP35hx3xKnosfx6Xvq4gsZdDuLhTjxa+y1R55rl1yVf6rkabcoc38uo159R9Ri6Q7y6+PECbrM@vger.kernel.org, AJvYcCWj8zbT12PGiYCbeM6Tn7Zmo4B6PJRJYfZmykjAy1K9sDrHRJMExnYL971dbiiOun4Hcjn26wyqEascJrhK@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCjs/l8SBUZpuu/h74JSRGiqF/bw7ixYGCa5GLxsjYukFwwoC
	JO2PVbs6E9dtJF4LLO+GCMcAAyj+BX4QpZQm/g2avN0Hw/a0gG9h
X-Google-Smtp-Source: AGHT+IG5uHzBuuTpBUgVsDRXpGnCV/Y6SAkTlghqjk76zLB5VEdpH82AMuT/Q0uG81tPW1Uzq1lrfA==
X-Received: by 2002:a05:6a00:1806:b0:714:2069:d90e with SMTP id d2e1a72fcca58-715dfc7a4fbmr3076028b3a.26.1724929521137;
        Thu, 29 Aug 2024 04:05:21 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e5576cc7sm906671b3a.32.2024.08.29.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:05:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND 0/3] Add AIC support for A7-A11 SoCs
Date: Thu, 29 Aug 2024 19:02:14 +0800
Message-ID: <20240829110436.46052-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend to correct dt-bindings issues pointed out by Rob.

Hi,

This series is a second attempt at adding support for A7-A11 SoCs to
Linux, it is based on a previous attempt, which you can find at [1].
However, there have been quite a bit of changes.

First, the boot process has changed, now, the boot process includes
a "1337" version of checkra1n [2], a custom PongoOS binary [3], and
a modified version of m1n1 [4]. The kernel is appended to m1n1 and loaded
by it.

This attempt also supports SMP, which has uncovered some differences
in the A7-A11 AIC. Namely, although A11 supported fast IPI, it only
supported "global" fast IPIs via SYS_IMP_APL_IPI_RR_GLOBAL_EL1,
and SYS_IMP_APL_IPI_RR_LOCAL_EL1 does not exist on A11. As a result,
there are now three feature levels:

A7 - A10: No fast IPI
A11: "Global" fast IPI
M1: Global and Local fast IPI

Each feature level is strictly an extension of the previous, for example,
M1 will also work with the A7-A10 compatible. As a result, the
modifications only includes if'ing out of features, in order to make
the existing driver work on older SoCs.

The A10(X) contains P-core and E-core pairs where only one core in each
pair may be active at one time, controlled by CPU frequency. A RFC patch
will be posted to disable 32-bit executable support on A10(X), as it only
supported 16KB page size anyways. However, such a patch is not required
to run AArch64 Linux on A10. At worst, any attempt to run 32-bit
executables will result in the process crashing.

Initial device trees will be posted in a later patch series, likely when
the AIC modifications are accepted.

Asahi Linux downstream kernel note:
These patches will not work with the Asahi Linux downstream kernel,
as these earlier SoCs do not support state retention across deep WFI,
which results in the CPUs going back to RVBAR on cpuidle.

[1]: https://lore.kernel.org/asahi/20221007200022.22844-1-konrad.dybcio@somainline.org/
[2]: https://checkra.in/1337
[3]: https://github.com/asdfugil/pongoOS/tree/mini
[4]: https://github.com/asdfugil/m1n1-idevice

Nick Chan (3):
  dt-bindings: apple,aic: Document A7-A11 compatibles
  irqchip/apple-aic: Only access IPI sysregs when use_fast_ipi is true
  irqchip/apple-aic: Add a new "Global fast IPIs only" feature level

 .../interrupt-controller/apple,aic.yaml       |  8 ++-
 drivers/irqchip/irq-apple-aic.c               | 49 ++++++++++++++-----
 2 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.46.0


