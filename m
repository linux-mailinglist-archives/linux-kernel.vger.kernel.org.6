Return-Path: <linux-kernel+bounces-343049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E812C989632
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E451F226CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7517BEC6;
	Sun, 29 Sep 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgEimdwD"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146C101C8
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727625801; cv=none; b=nCnqlu1FVXd0HtBXzN9nE0ymTrNRq35NyADZKPl989O+zUPVcLhmSWdbA0qG6lPDOBcLApBe2urzFSgxLuY/PucfrTUSpOhyAO+Ta3/tNe18Yp2fJAPc2XXCjoU+7AbMUX5CCJ3NHy/9H2CT1oBLYUHz1d+DcrlGW61xEWNAq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727625801; c=relaxed/simple;
	bh=LtcPiNVknBsM16c0TT1tQO40eB/cj5PvO/+nmHxfqIs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KN1uytHNLDscqvwhyYVfoIHxqCZrFqS2KMP2gSQ2hvsY88AceIXjqbUXhgnfS2EcEXNdkl2i3xf3cRKJlxoH3FmqMmlK653alPV28hDnZMc6lxaSCCAF549sovtdgoSU3oU7+NlF2hYC73VncrrO4tbI6amLunL8oQ9nFbyCROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgEimdwD; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-712422564aaso2339882a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727625799; x=1728230599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N9Nz67kM1tngGekEnToJnIfMZ99/7OQJ39829PPlax0=;
        b=BgEimdwD6SGzHVCu7VHIMfB5sGu98KqJ+pFltMaS1d28f2SWUgLCY9P4HPIQccAi2g
         Bn4EBMu8m/4BY821z0b8jr13rmfGgYjQwmfu9JYVATUTkWMamlHsxByD3awFqkTgfdUy
         7a4TQR6hES2y+6novghthuwIwOsTfaWPY9FvoQ+sOOtNwyFY5Mkoj6VgxSAoGmqvhaup
         h10jaamHXw/5Lbbe/aGHjnUIGLi3ol1yArEe3J1EHuGtdG0yXpqtVDAF5KU6n3mJZneb
         NfNWajyV/laZxKWZbtZ44j1vH5jNXWw/XaTR8PwLmRqg4Uty+IGyZveitsxDcD8ZGOXO
         0PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727625799; x=1728230599;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9Nz67kM1tngGekEnToJnIfMZ99/7OQJ39829PPlax0=;
        b=WOeKtwG2E5tl8YAjcydnluSmRbYrfH159g+fDUH4cmC+Y9pqgntawcUACppgYf+olm
         DXta/tdn6Ht6QkU02pRYQ0C5UsWTGSGXPii2ScUkrntHTHEcATLZeXJlWigNt5OADwTq
         DIQbTtv1P7kLEvA3Vra/nVKo+DcuAUV3FvphiT3F5KQ3mGMZUyQTrFLXaIM64Aa8Tj6s
         FR+46PRuuVGgZ6AtsfwUrA/qpgtUlBzRq80O8+LVzKOFW8RIXN2U16CyO5mv3E5pUfx9
         bU8yrazUyG4XZlUr1RMlpKUSqIIhgKK8cIbK9RFFq1rAigr+YDLxtgGuC0LcFDmcQnkx
         sj/g==
X-Forwarded-Encrypted: i=1; AJvYcCU3kE3cnqt7yJ1Giv9SOU6hO+RNIB0G5G2dcINF7sQAZvjaqvNCvvqQGxANF7+kJNs0tPb0zZYRIS+Ded4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LV3taAIrSfvBQ1pgsJ3fOhFG/+qLovTHXMN0PN7uucf4d/pu
	4Yzz5ioOih3PXISs10yUjlwpJSbFMBCYupFjWoVi1VZX15q2SMG9F5dz+rh8QbNdWWPIXhSO4yN
	xESpGnrdDImkbK4y+/waulQPpW95kK1TTYJA=
X-Google-Smtp-Source: AGHT+IHYeNY9dpviBeaDcx2s4c4jtZcargGTFlE4viaH/4/8jmpncwxoldPm0H2CyLOfKtmmwG+qjORR7rzNwkqQnyM=
X-Received: by 2002:a05:6870:4208:b0:260:ffc8:6d9f with SMTP id
 586e51a60fabf-28710bdc8e5mr4951518fac.19.1727625798877; Sun, 29 Sep 2024
 09:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 29 Sep 2024 11:03:07 -0500
Message-ID: <CABb+yY0_DC+usbp362+jSXF9p3y_XDcYV6MLO=kPCcnzThK8OA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.12

for you to fetch changes up to 54595f2807d203770ee50486cb23dc5763916d72:

  mailbox, remoteproc: omap2+: fix compile testing (2024-09-27 09:11:05 -0500)

----------------------------------------------------------------
mhu-v3, omap2+ : fix kconfig dependencies
imx: use devie name instead of genereic imx_mu_chan as interrupt name
qcom: enable sa8255p and qcs8300 ipc controllers
bcm2835: Fix timeout during suspend mode
mailbox: convert to use use of_property_match_string
mediatek: enable mt8188
spreadtrum: use devm_clk_get_enabled helpers
rockchip: fix device-id typo

----------------------------------------------------------------
Arnd Bergmann (1):
      mailbox, remoteproc: omap2+: fix compile testing

Fei Shao (1):
      dt-bindings: mailbox: mtk,adsp-mbox: Add compatible for MT8188

Geert Uytterhoeven (1):
      mailbox: ARM_MHU_V3 should depend on ARM64

Huan Yang (1):
      mailbox: sprd: Use devm_clk_get_enabled() helpers

Jingyi Wang (1):
      dt-bindings: mailbox: qcom-ipcc: Document QCS8300 IPCC

Liao Chen (1):
      mailbox: rockchip: fix a typo in module autoloading

Nikunj Kela (1):
      dt-bindings: mailbox: qcom-ipcc: document the support for SA8255p

Peng Fan (1):
      mailbox: imx: use device name in interrupt name

Rob Herring (Arm) (1):
      mailbox: Use of_property_match_string() instead of open-coding

Stefan Wahren (1):
      mailbox: bcm2835: Fix timeout during suspend mode

 .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml | 12 ++++++++---
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  2 ++
 drivers/mailbox/Kconfig                            |  3 ++-
 drivers/mailbox/bcm2835-mailbox.c                  |  3 ++-
 drivers/mailbox/imx-mailbox.c                      |  6 +++---
 drivers/mailbox/mailbox.c                          | 22 ++++++-------------
 drivers/mailbox/omap-mailbox.c                     |  2 +-
 drivers/mailbox/rockchip-mailbox.c                 |  2 +-
 drivers/mailbox/sprd-mailbox.c                     | 25 ++++------------------
 drivers/remoteproc/Kconfig                         |  6 ++----
 10 files changed, 32 insertions(+), 51 deletions(-)

