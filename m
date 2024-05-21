Return-Path: <linux-kernel+bounces-185086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923508CB054
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60ED1C219B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FA12FF89;
	Tue, 21 May 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdzUt2Dz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44612FB3B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301401; cv=none; b=sL0kaRBppgkDELJjIfzLAr8LNxRbyxZjDseLIpR1VqbC3UTOIbKh6cMDkAR5MXTyMXpVKG/C8TNIZCblN5aXdWWYErhb7uDL0bMA0LM56fPrnwoHnc6WgTea2lcvGx2MCyajHArOQ94VpRlKVsu6LVfYai7NH1dXFT5nbm9hpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301401; c=relaxed/simple;
	bh=71UgpGIZEFfJ+KGXozBoCU5MTohSKlbdRGH4aeJ7qog=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Gr8eeWv3uvbryaiOzTakEIn2w6q/HjgDtM3zgbtdOg92kcR2Rb93F9Yy2Kt/7YgOVwC9ML54Q97P7gHOVzmpkf6M5+GqZflXf38F0iISxXSnlJ6iG5J4FMGhPNqs/qP/Qw+p9XzKrkOK3qpa8g2MBSffKRU8JDHjpQztyiMSTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdzUt2Dz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso12167078a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716301397; x=1716906197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FSeatY39v4lNrv05Efy2Iau7owaq9W7mexnGZNIfuwo=;
        b=TdzUt2DzazdxyJ7sqo7V6zN7EsByQMaT1/8l1X2PF8NNcBsdOOReh61N+9M4L8y1OI
         lfzWkbeDU59+SggLU1mJPiQK7Z671/TTnDPZrmjaiQs6a/jBJikTHG4nMcce+PrtrGKx
         DxME+l4BrK9DXStVdGa6uZSKWxizR8C2rcQnHU9Eeg0Jo3mKDbUqdfqLfYdg4NZNLZue
         JzXqFZfN/REhCoanm7O/4S6n+rwczAcniC0tcaXjsmrG2Q2bt/gb/DrI6bCiSTQJcFN3
         R3DdJuj5nCp97p3F5vF8NRkbiet2CXcUASIM/fT/ZHONT3qHeoa5NLU/EpmwhUO5lpyK
         z3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716301397; x=1716906197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSeatY39v4lNrv05Efy2Iau7owaq9W7mexnGZNIfuwo=;
        b=nQzTbOxc1VjNawUwEgczKyhe0Ee8vbQGMWoJ15YbC6jmL4Jdpj4wGMsyHhGB/4I1CO
         Shl8+YFCvIiRT07in1VEWJTjllyd3yFJScH0C4KMpvufkN5a0CLa1yo/LP8fDQ52OrKj
         e8EGZfNADxMqedThggu+NhLWVe8cX8P4Qq5Z72lUDSTzCpREMme4Sbh63r8nsDvq86lZ
         o9yctCLiXlSNyrQhtzeOymJowy0CUQPnJOt/fZ2uHpLKmSSeKoB8AYx6Ov9MgOo2weAK
         b8VPlCTo13h1J5Dw9tS15VC6Nnk8vXtK2ragzu9DIRzsJw6Hakqv72qLX1z/JfPcelu7
         zi8w==
X-Gm-Message-State: AOJu0YwWDCW9iAL4y55P1TEhpZyOrrHtrMDddWWnwSU7h3COMQkmlpY7
	AooWN14ayiQP/M0rBXNcb4ytUN7MRjP3Fm2jPIjd96UIDU+GheDI2omUAikNi8Q8lowEql7X7DI
	biELoA+DkiOF9KlgBiwzU9dugZwAsN7YjH6k=
X-Google-Smtp-Source: AGHT+IGkKKK7/yW/tyV2dWbXhFvovat4yr6cGsPFa7TrVd3HPJJ1jP2HMXWXC+eAVNd7YLORJVq+Dk9nIeI2pmW9VxQ=
X-Received: by 2002:a17:906:40b:b0:a59:ac10:9be5 with SMTP id
 a640c23a62f3a-a5d5c825fc2mr850458666b.27.1716301397373; Tue, 21 May 2024
 07:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 21 May 2024 09:23:06 -0500
Message-ID: <CABb+yY2nxEXZkRt_Myyqh_e0CTkVemPwLUBaqt7AWvRB+94pfw@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,
The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.10

for you to fetch changes up to 10b98582bc76a65b7c9dcee82b7918d7949740de:

  dt-bindings: mailbox: qcom-ipcc: Document the SDX75 IPCC (2024-05-19
22:33:58 -0500)

----------------------------------------------------------------
omap: redo the driver from legacy to mailbox api
zynqmp: enable bufferless IPI
arm: add mhu-v3 driver
common: convert from tasklet to BH workqueue
qcom: MSM8974 APCS compatible

----------------------------------------------------------------
Allen Pais (1):
      mailbox: Convert from tasklet to BH workqueue

Andrew Davis (13):
      mailbox: omap: Remove unused omap_mbox_{enable,disable}_irq() functions
      mailbox: omap: Remove unused omap_mbox_request_channel() function
      mailbox: omap: Move omap_mbox_irq_t into driver
      mailbox: omap: Move fifo size check to point of use
      mailbox: omap: Remove unneeded header omap-mailbox.h
      mailbox: omap: Remove device class
      mailbox: omap: Use devm_pm_runtime_enable() helper
      mailbox: omap: Merge mailbox child node setup loops
      mailbox: omap: Use function local struct mbox_controller
      mailbox: omap: Use mbox_controller channel list directly
      mailbox: omap: Remove mbox_chan_to_omap_mbox()
      mailbox: omap: Reverse FIFO busy check logic
      mailbox: omap: Remove kernel FIFO message queuing

Ben Levinsky (3):
      mailbox: zynqmp: Move of_match structure closer to usage
      mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
      mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's

Cristian Marussi (2):
      dt-bindings: mailbox: arm,mhuv3: Add bindings
      mailbox: arm_mhuv3: Add driver

Jason-JH.Lin (1):
      mailbox: mtk-cmdq: Fix pm_runtime_get_sync() warning in mbox shutdown

Krzysztof Kozlowski (1):
      mailbox: mtk-cmdq-mailbox: fix module autoloading

Luca Weiss (1):
      dt-bindings: mailbox: qcom: Add MSM8974 APCS compatible

Rohit Agarwal (1):
      dt-bindings: mailbox: qcom-ipcc: Document the SDX75 IPCC

Tanmay Shah (1):
      mailbox: zynqmp: handle SGI for shared IPI

 .../devicetree/bindings/mailbox/arm,mhuv3.yaml     |  224 ++++
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |    1 +
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |    1 +
 MAINTAINERS                                        |    9 +
 drivers/mailbox/Kconfig                            |   21 +-
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/arm_mhuv3.c                        | 1103 ++++++++++++++++++++
 drivers/mailbox/bcm-pdc-mailbox.c                  |   21 +-
 drivers/mailbox/imx-mailbox.c                      |   16 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |    3 +-
 drivers/mailbox/omap-mailbox.c                     |  519 ++-------
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  412 +++++++-
 include/dt-bindings/arm/mhuv3-dt.h                 |   13 +
 include/linux/omap-mailbox.h                       |   13 -
 14 files changed, 1856 insertions(+), 502 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
 create mode 100644 drivers/mailbox/arm_mhuv3.c
 create mode 100644 include/dt-bindings/arm/mhuv3-dt.h

