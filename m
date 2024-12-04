Return-Path: <linux-kernel+bounces-431596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9255B9E3F43
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537F8284040
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02820D4F3;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6IRgIGV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A402156962;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=uO8sIVU1FUdvWtvcgj+rihoe5VTpkoTO/DdXk7WGNX8zHdy8inlW1cNksk8/RG+lyoTA4g50rRPi8b3DABuekKF2Csu4SYT5SEyGeXpO8IQjU8iA0Qt3b7AW2zgpXEGSEQGQOc9hChNy1T0V4OSNeAI5YbVyQfYKOj6SSqcH8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=V7BO1ptbAkL1Yo+zXuNam1yKuSO5DtHXBeNULjuF9dE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QfAMwwfVMHr37q6RbPSHTPbetkCF5iBHDHxcePRfpS+Uw02uVAjMjvLxQ8Ik/Hmc47O554QMjmUBYlvq13J0pRoM5atllCFFVSyzxxB5HNKxY5jW5FQcPw/qXJamr0Q+AOD0dp7CWyV/vRSX7/Jc0XVYQXhmalBKsj1KAOIF7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6IRgIGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2D48C4CEDD;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328393;
	bh=V7BO1ptbAkL1Yo+zXuNam1yKuSO5DtHXBeNULjuF9dE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=o6IRgIGVr6ozS05PdwResdAviClnTiCOtcdgroImVb2lsDLaRLLrrKzj0wH656kG8
	 Efia1gNb3Hntsgo9cTEd/6rxwQgN4POCYO6sMi39s48RmKWFw3d397xbqzzYKZCUYs
	 Xh+e+jek7jqsxOgT/hfDegRKXQ4ExogY0RGpIVkcyj1IywZDEy0WsPeuJoxFvA+YSk
	 Pf7+AqyeOk0yE7t7bCefo2mKCdYt3ihHBNxlX1yg0e6bKHWJpSyO/1z5SoiihQWZ+t
	 rldPzqBWC2jz5zDaBGQspA8QiaJdFrNnIFQElyUPz0Fb0UqNYvUNHKTLqlkXWwoZnj
	 KZ6wE2DGkInnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF0E7716D;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Subject: [PATCH v5 0/6] Add support for Blaize BLZP1600 SoC
Date: Wed, 04 Dec 2024 16:05:23 +0000
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMN9UGcC/53NQQrCMBAF0KuUWRtJahONK+8hUtI02gFNQlKDt
 vTuphWXgjib4Q/M+yNEE9BE2BcjBJMworM58FUBulP2Ygi2OUNJy4rlIc1V4WDyGjwTlNZosa8
 bp0Jbx7v3LvSEsXLHZKWV3ArIkA/mjI+l5HjKucPYu/BcOhOfrx+e/8InTijRVFJZGbFpNT+8n
 9ba3WD2k/jH5N/NaZpe1cUITykBAAA=
X-Change-ID: 20241111-blaize-blzp1600_init_board_support-1128194ca976
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=2384;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=V7BO1ptbAkL1Yo+zXuNam1yKuSO5DtHXBeNULjuF9dE=;
 b=fPh1ioEVlho7W+IqTeSP6WFdrEGCIDEG3gNT/kPqAEBd4ucS4JflSG7ZWSOK3770VwULgRTcB
 IPuH09RdjKmBgRAqSezIXNYP20hhWbv1NAhuIdWAVwuRf8UbbWYo6pL
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

Blaize, Inc. (www.blaize.com) is a SoC designer and manufacturer
with integrated programmable Graph-Streaming-Processors for AI
and ML. This series adds support for the Blaize BLZP1600 SoC.

The SoC can run as either a PCIe based accelerator in a host
system, or as a stand alone SoC running Linux on its integrated
dual core ARM Cortex A53 cluster.

The SoC includes a suite of peripherals, support for which will
be added later.

This first series is just the basics to get the upstream
kernel to boot with a UART console and ARM SCMI based
clocks and resets.

Resending V5 with tags applied and 'From' fixed.

V5 changes:
 * Add more information on patches and on files
 * Rename arch to ARCH_BLAIZE

V4 changes:
 * Add maintainer for blaize in arm64 dts
 * Fix Blaize schema & dts code style
 * Add range and reserved-memory as suggested

V3 changes:
 * Removed unnecessary dt-bindings
 * Update SoBs

V2 changes:
 * Update SoBs
 * `make dtbs_check` has no warnings
 * Fix dts names and removed dead code
 * DTS is separated from anything else

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
Nikolaos Pasaloukos (6):
      dt-bindings: Add Blaize vendor prefix
      dt-bindings: arm: blaize: Add Blaize BLZP1600 SoC
      arm64: Add Blaize BLZP1600 SoC family
      arm64: dts: Add initial support for Blaize BLZP1600 CB2
      arm64: defconfig: Enable Blaize BLZP1600 platform
      MAINTAINER: Add entry for Blaize SoC

 Documentation/devicetree/bindings/arm/blaize.yaml  |  40 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/blaize/Makefile                |   2 +
 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts |  83 +++++++++
 .../arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi |  23 +++
 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi    | 205 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 10 files changed, 371 insertions(+)
---
base-commit: 83d67c257f4d045ff477309b5617d931f9a7be66
change-id: 20241111-blaize-blzp1600_init_board_support-1128194ca976

Best regards,
-- 
Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>



