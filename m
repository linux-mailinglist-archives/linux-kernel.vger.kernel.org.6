Return-Path: <linux-kernel+bounces-306517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5D964005
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DC41F234D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779D18E354;
	Thu, 29 Aug 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5CvwiHV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE518DF7A;
	Thu, 29 Aug 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923632; cv=none; b=tlEnR7c+qu8pmsMk5lmCIts6H+PO/qGcY6MSZbAXXafOb01/ENU4slcqCAWsWkHWpTuC/zQXrHFmuqd2UdSyZJ/HDvjLAXsbz9zhuwfXMKXOhEBKW1iGeJSDzSunGhMG2+SYT9bKSILxOAV/T4oO8UPRpZFAF9mjXfqffX6j1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923632; c=relaxed/simple;
	bh=g7vPCp6T2KzSgyaMPE1ZnoCnxjUR5ijKx+yapczFdz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/HasBjee6wgHRaaPsWK79WF5h2oUms8KLZ+ikn6rL+ID2GH++UVS9js8VkqnLgRCsMvZNIlBKsrWoblrkQbyF/kavVVEowgaYUKGiC5unNul02ax0h5QJM0qy714VzDZ+5RUZoPc/bG40/ngEa03gMK2YDbz7pY94Y9OWrGLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5CvwiHV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-656d8b346d2so245861a12.2;
        Thu, 29 Aug 2024 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724923631; x=1725528431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvjn3LozyX7PzUcM0O+kSIxcuZqvkXVUv2cAp4pQJyY=;
        b=a5CvwiHV/+C+hNXHD2PcYCKym6BlPQTuhdSTZ/ZHfhMKxplnNNSLE0vaiQiCaw44UH
         unYZIJJivZ8hJJ/g8fQx90Sd4oBHzFChKlilFongcSbAgEPfby2VBGJpGIbAdaT1zbcv
         +Ac4VTjlFahiSQG5R5TRdXsx/SxwCjV8it2drHoNzrSxjnrKTEm+TnDu3Pga7v18BFdp
         kCOhmoLZE/g+JIGTOqWMOrDOjHPbq44/BbJtW2TC+BpSHjNpWfgMudtH/OiGhp+NYXKh
         GaMj6/8ogBg76eCTva5XdaAcAd8rcM/kGpTC+ac2yRmv7cS1G5DzgldOW/Gciq6QKhly
         1yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923631; x=1725528431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dvjn3LozyX7PzUcM0O+kSIxcuZqvkXVUv2cAp4pQJyY=;
        b=TpSzfvFq4496ckz3iv9vCkVLHVkOBoMpfaxuazA7HMaIPPPXkpjQFTL6g3E+dWtE80
         SHUoFRG+Zxkb2gDTgpQcpePdD9W4AEMsjWVebhiJh2JOkKJ2HlwSgMdlznud1FFGDStB
         z+k34GdXuf4yGdWL78+TqKP/J/EkKQug+Mfl06ts7ppNbDwKT25yuUIos7e+Qzw0tVvz
         /VaCSvG5ILVF88Ti4zW2TF8OfJRl56ZN6J4zyu0KTZJg7y1/btlVwog8ecUHqC6qIl/d
         kHIoK76mjco99HvOKZxHikJEJvW0ATxueuz10n0n9GNdVG8TzDTJuOKfEad4J6eHN2tM
         womQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/QR8usQG2pGn248z5JstiHaCnxP0LlDq2Uie+SHsOKFUfXYgAw7NtnjxGDE+kI/93PCgOcVkp06Ge5ExM@vger.kernel.org, AJvYcCXwhOWsZKX6LSqY2Nr94jOPR4LtyVNyjngFvYU5S2MgwNU50ZIoX+4WPV7qZGnFXbrx7PXJ1AbY9sX8@vger.kernel.org
X-Gm-Message-State: AOJu0YyfT2QmFxKrk3Db7tJbetdjHJYwJL7Iyxy7JQJviEwmkUFRwg2I
	O9WxIHI6CDAhF+UcRStHM3xmRv1K/IbxFEC+/9SIOVOcyWa51DdW
X-Google-Smtp-Source: AGHT+IHH9msDkUh4C+HrO5ERn2jIh+PFRRJ3FprkC7wSKj6bergnvBcBclkRVm7iRpcIrBtCX3ESng==
X-Received: by 2002:a05:6a20:c78e:b0:1c0:e49a:6900 with SMTP id adf61e73a8af0-1cce0fea52bmr2077586637.7.1724923630574;
        Thu, 29 Aug 2024 02:27:10 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20515552b6dsm7469245ad.249.2024.08.29.02.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:27:10 -0700 (PDT)
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
Subject: [PATCH 0/3] Add AIC support for A7-A11 SoCs
Date: Thu, 29 Aug 2024 17:03:10 +0800
Message-ID: <20240829092610.89731-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 .../interrupt-controller/apple,aic.yaml       | 15 ++++--
 drivers/irqchip/irq-apple-aic.c               | 49 ++++++++++++++-----
 2 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.46.0


