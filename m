Return-Path: <linux-kernel+bounces-234878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68891CBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0768F2834BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B953BB25;
	Sat, 29 Jun 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkqyJRkG"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65259381B9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719653034; cv=none; b=t3FrsuaUEzg7kW1AU5DPvnvgTdqkBixENPDZMVxGleLOVEKX7EgM6SkzV/cRTitHyyaCUp56HHuVE9dqkE5DBXh4HE81hjaQz2w0AZ9zKGJAWywNwZFCA7OHpygmlfInmvVRKjI95m5wGDgqfeGunXcF/ijw/n8pfqfGs2Bc9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719653034; c=relaxed/simple;
	bh=a8lBBR+zq9+SenzNjJUVvc8RiDEZ37nxr16SZQT231U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Jr7lxXRdeTWqfpJHVK09Hhqj6EAQ90tPnEhBVyfJlSacUuzfODZbaKJdXB/QlB2Btpb2OD41XRwuMPB6Poip6TfBELSDudqR/bU6eVXW0NTDzRPHP+3znVLiYnO3oZrQQcTnVjnQa085r19F0TimOah4+y1bm4uWk7rhkUi4BII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkqyJRkG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5854ac8168fso1593288a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719653031; x=1720257831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dutiK21L6e08iTcsoNDSH2EG6qkKH/ZpV/B61gNV7FM=;
        b=mkqyJRkGwOmFWXiYU4NmI/WKxty5fszvyBoNuvLhCyrRT4rerI3vBDnsoVJ5Nt4Kc2
         0nmETleq0ilYZdqqILn7xvWizbQrM4TKviJp23ykyhbuv+N5g17pmhkTCkUHd3VS3tc3
         TseKikmDRUuWfEDYXQMxmUI2suF4flyYVIMvUikV2QZEwVVdaC/xGnx9wDbXcU5d6DXX
         11uof4MVl4FEsTEyy81Ls32zZwGrTJ0MCp2eT3G+Mo8/ST3taQuKQ8Rt7iBsewUfITgU
         0d2da+fVvfSQncJXth7tx/+qEk44FYAlJ6uH3yNuVdIfRbHYf9CP5xoleZNsP8BjatXy
         5vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719653031; x=1720257831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dutiK21L6e08iTcsoNDSH2EG6qkKH/ZpV/B61gNV7FM=;
        b=ohOeTFKVw4e1B2966eGUPXGM9YM0cB5acSFSMndZ2Ka1BUZ2XAoyN5AJ8KveiZq7wW
         GT39vbq256/dtKfNvwUqTiRy6472gTlj4F3MoEhaWAlGb7alXkNrq68Kf61lmbItR1y7
         8Vhxz/uIhLgCD//UWJ+QWvKL7s/k45JcOc+ruXXhYVdiVmarEmFMkE9lnfGJxPBffrqc
         iNkj4PCh45flat2O1GcECH+Q5YbmSG947CdCiSbnyFukQQ2JlXTekhOJgefzHe7H2yzl
         j8UHBfhds8rnxybS6HHPbyf84RRfkW7wYnlkOPBKqYCXKMrYECw9R9gF0efQEWAx+ci8
         aJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7yiagvETpyeT6J2XBYzGWRukfMuh806/42rvub29U1oU2vMDObfr8aKo+HviZE19iMLycJ1HeFCzK+Owb7kssxmOkV3RTjxJ8nlTX
X-Gm-Message-State: AOJu0YxS7NXXNL1zFgyi7rkVlz1Qlnl8/xG2jfRriup6Dehzm0q1Dc27
	sbfGTL+vustby4QbMJoG3Dg56qBXysSbpf3xUYll2Yv2Mu97SagIgYI3TPhvs4w=
X-Google-Smtp-Source: AGHT+IFnRzvdM0vkP7UaAjE/niQLhB+sI8vKKpjEfqgqrqegYl2NxtWtJ+49LZotsm8GiBQpdCpEgw==
X-Received: by 2002:a05:6402:11c9:b0:57c:fe38:54c3 with SMTP id 4fb4d7f45d1cf-5879fa7b3c9mr442218a12.22.1719653030598;
        Sat, 29 Jun 2024 02:23:50 -0700 (PDT)
Received: from uffe-tuxpro14.valamar-dc.local ([195.29.219.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f0a3sm2059654a12.35.2024.06.29.02.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:23:50 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.10-rc6
Date: Sat, 29 Jun 2024 11:23:48 +0200
Message-Id: <20240629092348.8191-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.10-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4

for you to fetch changes up to ab069ce125965a5e282f7b53b86aee76ab32975c:

  mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro() (2024-06-20 16:42:30 +0200)

----------------------------------------------------------------
MMC host:
 - moxart-mmc: Revert "mmc: moxart-mmc: Use sg_miter for PIO"
 - sdhci: Do not invert write-protect twice
 - sdhci: Do not lock spinlock around mmc_gpio_get_ro()
 - sdhci-pci/sdhci-pci-o2micro: Return proper error codes
 - sdhci-brcmstb: Fix support for erase/trim/discard

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

Ilpo Järvinen (2):
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos
      mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return codes to errnos

Kamal Dasu (1):
      mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard

Linus Walleij (1):
      Revert "mmc: moxart-mmc: Use sg_miter for PIO"

 drivers/mmc/host/moxart-mmc.c        | 78 ++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-brcmstb.c     |  4 ++
 drivers/mmc/host/sdhci-pci-core.c    | 11 +++--
 drivers/mmc/host/sdhci-pci-o2micro.c | 41 ++++++++++---------
 drivers/mmc/host/sdhci.c             | 25 +++++++-----
 5 files changed, 90 insertions(+), 69 deletions(-)

