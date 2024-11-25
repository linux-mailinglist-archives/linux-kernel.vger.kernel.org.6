Return-Path: <linux-kernel+bounces-420394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9E9D79EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3433428244F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06AB64A;
	Mon, 25 Nov 2024 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cppWg06r"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3C624
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500161; cv=none; b=l/T4B6Mwj8FRGvaIf0jwLGRqte38IxTZ+vq/1NlzqB84lYFGroJWtPyIZd892+prsHZWgUw6fvf/LKUZFkbssgpu0065cPiz/+nhPScx5m94iy8ssv7LWKxX0dUY1v0007vqvUx557fDM0c/yZjikPofP4EZEYWs8NOlJ1h9eLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500161; c=relaxed/simple;
	bh=P5WqOLDr1piqkEECXZYb67UMlwqAtghxbJ2tPz6UWd8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F2CIUlqETrUCBdwvr0Q3YjBoTX1vyGnLJJnO8i5Gz7m6m09X2MQzsH3b1DIPI+8WQAgMLkQGsKwVLpyD6THRCy6xzgYohKwEw7GtFdNAeR+8rkj+AniMKDYoO1nRDwWqx1BgmzCSvNFvPg5NzC6c+kFFvEuuHz63aVhy+Z28YNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cppWg06r; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-718123ec383so2049505a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732500158; x=1733104958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMwcKynH7+09/OSOjd94cHqbXzeJ+yy/TOIojBiv5Ww=;
        b=cppWg06rFFH4AuefjJczVg0LwRM1LvZ4ZMP8U3bN40PwGeH+2TawLsfMWYtlSJGuLw
         aQa6yHCEqudnVc0BuLE8vAMx4tKshKsgmAy35as0hQifnH641TFiUNoj9gYL3x7XOlt0
         9/6wvHAzHD/RAj7ImiOvp/m9t1jbGMEQ1GFlYcdizpPNMacOcZuOQOPaovrLUeiwYM0g
         uLNeF0dA9BzwLZLmsEab7AMWGMWJeY+OKOHcg1P8R+jc4LIRFY0ev2XBZ+h1Gp/8BhID
         z7Ec3vg5rcl+umBdpn2Gw7F5krjmQUPlyuUXWUemvMbikxB0F9v8h57H8fvQDRaiOD+4
         IYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732500158; x=1733104958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMwcKynH7+09/OSOjd94cHqbXzeJ+yy/TOIojBiv5Ww=;
        b=tqBqh6y8e3aC8N9lR8SqolmhhD9VuAGBvFciRVJ+xHYtl2oGsoyoUCpOFAh/jIUcnj
         pKvJKUKHwvEjs12BbxEi4He21xGc0osu6OTb2EsiVptn+tMRtvi1MPe7Pn00YBMPS7/v
         d6yPR0tVKNgLXQluQaio9RfUupZ4ppNE4YZADBMRTM4TXvtv4wCBEteykkTPqWi3mTJ5
         wD4LPxq71RE6QFQL4lEONhndYsgioNKx1FGsXq+07j/Sfnxz05c13PiUJSoGd94JvfHo
         PAruuu5lS7C4Rfuj7KQ2amCBNsZ5weKqL3dJArs6cplcfaoGw4NcSzSnkwIrZ2XyeBZ1
         AcJA==
X-Gm-Message-State: AOJu0YzAjRj6jexWzYCn6JYBkhfrmzJMb5aWmSklu+nXHNDyZBnIOgj0
	vKzt+M+v2wdQcPyFjXpeM5ExdhRdXad234qgppmv4iAoxjCOsMfVZ2CasZzGMwTXwnj5pkmOnqG
	huQEemW3SMV/0Yr2DdJQdYthJZeMdNgn4
X-Gm-Gg: ASbGnctgwR7hmt8qzWn0gobh5hpAtZUFIA+5YDc88MDzaXdfEUdNDBIpCEceZK0ZsVY
	NOC52+Imr/jWkd12R7jx5DnQIQtFLieUk
X-Google-Smtp-Source: AGHT+IEtOaD7oLcnxyggMG+Ec+gDAtY5hNLtZ1XpHdnaA/p5OzbK2Vydk1KuooGB1YAj4/Ir1JBzAbUc/V8uno4v7Cc=
X-Received: by 2002:a05:6830:6e92:b0:71d:41dd:30bd with SMTP id
 46e09a7af769-71d41dd3564mr3188949a34.20.1732500158617; Sun, 24 Nov 2024
 18:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 24 Nov 2024 20:02:27 -0600
Message-ID: <CABb+yY33qnivK-PzqpSMgmtbFid4nS8wcNvP7wED9DXrYAyLKg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623=
:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.13

for you to fetch changes up to 7f9e19f207be0c534d517d65e01417ba968cdd34:

  mailbox: pcc: Check before sending MCTP PCC response ACK (2024-11-24
13:20:40 -0600)

----------------------------------------------------------------
common: switch back from remove_new() to remove() callback
imx: fix format specifier
zynqmp: setup IPI for each child node
thead: Add th1520 driver and bindings
qcom: add SM8750 and SAR2130p compatibles
      fix expected clocks for callbacks
      use IRQF_NO_SUSPEND for cpucp
mtk-cmdq: switch to __pm_runtime_put_autosuspend()
          fix alloc size of clocks
mpfs: fix reg properties
ti-msgmgr: don't use of_match_ptr helper
           enable COMPILE_TEST build
pcc: consider the PCC_ACK_FLAG
arm_mhuv2: fix non-fatal improper reuse of variable

----------------------------------------------------------------
Adam Young (1):
      mailbox: pcc: Check before sending MCTP PCC response ACK

Andrew Davis (2):
      mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
      mailbox: ti-msgmgr: Allow building under COMPILE_TEST

Conor Dooley (2):
      dt-bindings: mailbox: mpfs: fix reg properties
      mailbox: mpfs: support new, syscon based, devicetree configuration

Dan Carpenter (1):
      mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()

Dmitry Baryshkov (1):
      dt-bindings: mailbox: qcom-ipcc: Add SAR2130P compatible

Krzysztof Kozlowski (2):
      dt-bindings: mailbox: qcom,apcs-kpss-global: correct expected
clocks for fallbacks
      dt-bindings: mailbox: qcom-ipcc: Add SM8750

Michal Wilczynski (2):
      mailbox: Introduce support for T-head TH1520 Mailbox driver
      dt-bindings: mailbox: Add thead,th1520-mailbox bindings

Sakari Ailus (1):
      mailbox: mtk-cmdq-mailbox: Switch to __pm_runtime_put_autosuspend()

Sibi Sankar (1):
      mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

Tanmay Shah (1):
      mailbox: zynqmp: setup IPI for each valid child node

Uwe Kleine-K=C3=B6nig (1):
      mailbox: Switch back to struct platform_driver::remove()

Yang Yingliang (1):
      mailbox: mtk-cmdq: fix wrong use of sizeof in cmdq_get_clocks()

zhang jiao (1):
      mailbox: imx: Modify the incorrect format specifier

 .../bindings/mailbox/microchip,mpfs-mailbox.yaml   |  13 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  13 +-
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   2 +
 .../bindings/mailbox/thead,th1520-mbox.yaml        |  89 +++
 MAINTAINERS                                        |   2 +
 drivers/mailbox/Kconfig                            |  13 +-
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhuv2.c                        |   8 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   2 +-
 drivers/mailbox/bcm-pdc-mailbox.c                  |   2 +-
 drivers/mailbox/imx-mailbox.c                      |   6 +-
 drivers/mailbox/mailbox-mpfs.c                     |  81 ++-
 drivers/mailbox/mailbox-test.c                     |   4 +-
 drivers/mailbox/mailbox-th1520.c                   | 597 +++++++++++++++++=
++++
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  14 +-
 drivers/mailbox/pcc.c                              |  61 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   2 +-
 drivers/mailbox/qcom-cpucp-mbox.c                  |   2 +-
 drivers/mailbox/qcom-ipcc.c                        |   2 +-
 drivers/mailbox/stm32-ipcc.c                       |   2 +-
 drivers/mailbox/sun6i-msgbox.c                     |   4 +-
 drivers/mailbox/tegra-hsp.c                        |   2 +-
 drivers/mailbox/ti-msgmgr.c                        |   2 +-
 drivers/mailbox/zynqmp-ipi-mailbox.c               |   6 +-
 include/acpi/pcc.h                                 |   7 +
 25 files changed, 875 insertions(+), 63 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

