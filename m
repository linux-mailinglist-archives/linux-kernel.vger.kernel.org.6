Return-Path: <linux-kernel+bounces-259609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B1939968
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F8F2827AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56413D60A;
	Tue, 23 Jul 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeUJaPJh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB413C9A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714151; cv=none; b=CsNRCGTUun4tiEx2Kc8tIGqgCjbXWGfpiHeMqQy/0ZeyzLvQ59A9WCPrcKNphtmHMGZPbrQth0wAUoUdG/fFG5cgiAV9O36+9HF/16m+lkwLG+704cfBWBcwjoJRyjyq2R5IsmSqcTfksYGXu87w4TJOjNTLofaraj6Xd/joHII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714151; c=relaxed/simple;
	bh=/yvLNCVDguAzxEjd/k/BzF83LDh4yZS7Rh7HyUfBUMo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A2BIFKGPjhRoR2ba2pEwI2u3RHCIRrXcFt5So/0OFMb9ldXs0mlNxcRT7dEB+aIpOI5XdWC2ZqLVrQNIoGeCwOJEBIPWR0tA5Y0JS0Tvz/wrhUDwDZt3oKQYSqkQLaRl7pnfUp5q+qtPcWZ5s/T8pi9Iv71ao7sOB1/z0WNb+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeUJaPJh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efa16aad9so1247937e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714147; x=1722318947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U2VEttNRiQcgESD4kfXTgZiQMgiyz5MSh6tGPGGPZWs=;
        b=EeUJaPJhsgIcnGzfPTKx0biY44fV5eeBYOfkL+Iap91X2kkt/MZMAifQaOpa/IJVnR
         lCufJRBmEmHDlTps6/YkkVtrwjVANUdsoIHfDxK9GFCgih8Ph2b3Zeyyr+XMDoj143iZ
         srrB+Brkpt+QYqMp0I0Vn6DogOdPPAFew9T4UMDMPN5daXnge0lUxFFD/hTbdJ7qpyVl
         rpFl2A1dlrcxShKVun0fl7klUqLNTv93lbNWerPlNye9HldYLmpuwmwgQY6a6mxKpoPE
         97isXdWY165e+0T6pNpatY/H2DfcP0Rb3YQ5WVckMvXjyNBnOMrmmrdF0XgKR/1mjDg/
         ojng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714147; x=1722318947;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2VEttNRiQcgESD4kfXTgZiQMgiyz5MSh6tGPGGPZWs=;
        b=tl5OdrZUMDwXNtbRdPYtFAl1GTVXI/Ms6weqwZJprZKxvtWgnNDj6W22kaiw/Qs26J
         6VCGY4w+RQdzo4For5Fp18mz/KDOXc8kgNfl/UZSmUz1w7cl/KRZjpMCqldS1N7e8Xhh
         WFwMl9z7ipBWBXYpwrMioFW8lhouk9HL7JUKyzF8FgiJ1l3rONcmGuzMGSzs+3cg32kv
         GUaOEwgvy+6L2vGl/s3eiV/9rxyw+L419Y51bxTpFtu31W1WoX5pkHal1M6h+btYCzxf
         R6a+d0NCBwfa3gtj9SzZwBmnYuMaZA3yytnIws4F+fM4ikh1w4CtFOibANbhWz2QjwxQ
         dGTw==
X-Gm-Message-State: AOJu0YyxfJJolaeP3jy7KdHzuwSPCUF0xNYmMRpRBwGVCoicv4jb+Zdq
	B1YpjCHbwyUQMhOTqN3QMSQWDsW772SIzimWBMCS3lzYlfYVs9eWwRMze61EypGP4bFn0tgyPRU
	qlVSV734c+eN1c2dCaXwPOr84fgo=
X-Google-Smtp-Source: AGHT+IFRuxLHhnSY6BlNGr6Gcw4pny2+k9BcehhVNXwK3Pb6YPy7hPfhxf+0dkyCGtrmjVBWdb69f58CQacp/+G4bHM=
X-Received: by 2002:a05:6512:128e:b0:52e:be1f:bf84 with SMTP id
 2adb3069b0e04-52efb7ea9e9mr6114753e87.53.1721714147242; Mon, 22 Jul 2024
 22:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 23 Jul 2024 00:55:35 -0500
Message-ID: <CABb+yY2DOB=RUQRm8m+5=f4ZEP1FbygenhbNGn5dEA5nVO7syQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit 256abd8e550ce977b728be79a74e1729438b4948:

  Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.11

for you to fetch changes up to a8bd68e4329f9a0ad1b878733e0f80be6a971649:

  mailbox: mtk-cmdq: Move devm_mbox_controller_register() after
devm_pm_runtime_enable() (2024-07-19 21:25:23 -0500)

----------------------------------------------------------------
broadcom: remove unused pdc_dma_map
imx: fix TXDB_V2 channel race condition
mediatek: cleanup and refactor driver
      add bindings for gce-props
omap: fix mailbox interrupt sharing
qcom: add bindings for SA8775p
      add CPUCP driver
zynqmp: make polling period configurable

----------------------------------------------------------------
Andrew Davis (1):
      mailbox: omap: Fix mailbox interrupt sharing

AngeloGioacchino Del Regno (3):
      mailbox: mtk-cmdq: Stop requiring name for GCE clock
      mailbox: mtk-cmdq: Move and partially refactor clocks probe
      mailbox: mtk-cmdq: Dynamically allocate clk_bulk_data structure

Arnd Bergmann (1):
      mailbox: qcom-cpucp: fix 64BIT dependency

Bartosz Golaszewski (1):
      dt-bindings: remoteproc: qcom,sa8775p-pas: Document the SA8775p
ADSP, CDSP and GPDSP

Ben Levinsky (1):
      mailbox: zynqmp-ipi: Make polling period configurable

Dr. David Alan Gilbert (1):
      mailbox: bcm-pdc: remove unused struct 'pdc_dma_map'

Jason-JH.Lin (2):
      dt-bindings: mailbox: Add mediatek,gce-props.yaml
      mailbox: mtk-cmdq: Move devm_mbox_controller_register() after
devm_pm_runtime_enable()

Jeff Johnson (1):
      mailbox: mtk-cmdq: add missing MODULE_DESCRIPTION() macro

Peng Fan (1):
      mailbox: imx: fix TXDB_V2 channel race condition

Sibi Sankar (2):
      dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
      mailbox: Add support for QTI CPUCP mailbox controller

 .../bindings/mailbox/mediatek,gce-props.yaml       |  52 ++++++
 .../bindings/mailbox/qcom,cpucp-mbox.yaml          |  49 ++++++
 .../bindings/remoteproc/qcom,sa8775p-pas.yaml      | 160 ++++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm-pdc-mailbox.c                  |   4 -
 drivers/mailbox/imx-mailbox.c                      |  10 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 100 +++++++----
 drivers/mailbox/omap-mailbox.c                     |   3 +-
 drivers/mailbox/qcom-cpucp-mbox.c                  | 187 +++++++++++++++++++++
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   9 +-
 12 files changed, 548 insertions(+), 43 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
 create mode 100644
Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
 create mode 100644
Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

