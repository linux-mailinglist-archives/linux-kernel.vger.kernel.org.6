Return-Path: <linux-kernel+bounces-514922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF6A35D60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAE16A40D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6EE26137F;
	Fri, 14 Feb 2025 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhAdqCTr"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7282E263C65
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535506; cv=none; b=TfHnKG3f6ySghM+33ARcKX01JDexxmUNlhWQZa97mg4OZXzxkPPHrveGW5Iks7S4NGewG0v5+Dq0zTWg6MzW1MSh0Kya+p+sI97QpFEsNbbXFpPvRXJCpw3dmjiFPQTot8pOWT2DpvdzdHMI32NxgnuwZSR3+kT0dpJlJKzM5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535506; c=relaxed/simple;
	bh=7adhrVeGo6H4LUVbse/IZZXrXiXQD9ZHuQw6udBALFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K16PjDsVd1ksMPCUtqVyFRSuczEmAQNFq/k/UgrIoErA9XwyGlyr9Yr7zn/VC0kW5EioLo4ikbAu79EOtkRdVImtuIGZrwaq3I7UkoDOu6X6ZVPMZ3MKQn0DuAmIs1SBkDgPlVvt4G5Te7Q7P6xwCrTUdBdDKaUTrNJbjjm/e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhAdqCTr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308f4436cb1so30793641fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739535502; x=1740140302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrzvjH3l79+hdw58qHfR52BGxRz04Zk6OgyBxJx9CpA=;
        b=MhAdqCTresI8Ldo2NF1YLJwfP0rr36gW29O2N8ic2ZRptZhWMEUwi0YXqWuHqJ23KC
         SrLrgKlNxLq0QAxewCsKDPSpV2fmeE973IwWia4/dS0LVBz2+YTcv7hxcTIvTiISQAkK
         L60qzc8wL28gHsc29Zoq668HQ9Fw8wFFRqd5HqZ19KEUj++XwbD618rS+722WxILLTYp
         GcZgYheHtSrR5ZMQliYzoFBYJ9KkSymWMNCe4ZuxM+7Pm7VlBqsvI9AE6QaycqnQs8qN
         cp6hAbVVGjqLIOe7cr/f2Ko9K1h0wnFee9bnJV9v/TxNjPV0qvR3scOVWycozexc2UEV
         Axqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535502; x=1740140302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrzvjH3l79+hdw58qHfR52BGxRz04Zk6OgyBxJx9CpA=;
        b=j/qIPasFfdnWPdSnwuCzF7lPmRXVZkAe3xy1UUQixVsSy9DzxMzhWB7hMKvfxN/6YG
         6hWDyFi5NhmoYYcM/32ky1zOKeIa4a8A8MPotsS901XATy4BkNvqw67gAdfeb/em0gWh
         LOqmO0DEJHRvfsTicTjfF5lPP9IbBpX+HcwGCZxOKwdqh099FxmeRcY9pl+TmM/DVv5X
         ZfZnI6/MDB3kmrTnTaN0rcbNPQJrwrhlJmxjW1dIsBm5VY63GTu8Ldozeq+Vj7b+fQ4d
         LsAP1J30ETDv1OTUnsohFITwwONpyx7f/o5dAumsQF3WWjlE4VK9/8WQ5t8qWfIhChpx
         sLdA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZ0xdQtA1v1hb1SQjuwqTvn6U9qgJsb4DZGCfTYbIR/MIDVq0le+0uL2EeQ9vdj7azymfb5EvM+yJGvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydjlsV46uiBTFvMPKNAa8AB+4NNhEGqYjGaME59qPxSHUNYk9N
	H+ang7ji023T/WoQmENtEJfXvhy3XqG46qYOWq27OzpnigB5mKwHa8HidCf40Cqz7niARvZRSNQ
	e
X-Gm-Gg: ASbGnctQGOXW34PD4GJcyoKl3kbrFn1jEpddUpp4KH7Mj6TCpdLhvaZs9Cjj3+W1xCR
	EcWdmWGH0QVegIbVnN86H3X9fwqf5lxhwrQXlVNZz2HeRIqz0p7wcKMO2CYzY9k3TDpSt5XAgUS
	NlwtS7LEATSxXg+dLMxIo4Zc4pdIeydDaBe58zvzCvntC1Phm/AwGz5vPIMxEE8hD0glcwmiyHp
	2tHnyj0IoBL0zjPegZ6weanqX4+JoV9fAxMAA7F1obKlVW1EDmrR7oXXrJlfJA5lIHFsP59FDFg
	KTmwBaJiSzZQGnpLYw07ZoV1IGdsz+n5DVnTmCP/G1YPzm1wYwLa2mlMsKqV/yXbUQ==
X-Google-Smtp-Source: AGHT+IHGwPkIu7AEThobtQDnIS60RAWChZSIkpJXCQDqrg9REU22/CFOX8p/6/pVOccfoi684zy07Q==
X-Received: by 2002:a2e:7d17:0:b0:309:1f60:82e9 with SMTP id 38308e7fff4ca-3091f60867emr5618761fa.10.1739535502348;
        Fri, 14 Feb 2025 04:18:22 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092440033fsm777621fa.14.2025.02.14.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:18:21 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.14-rc3
Date: Fri, 14 Feb 2025 13:18:20 +0100
Message-ID: <20250214121820.100545-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.14-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc1

for you to fetch changes up to 3e68abf2b9cebe76c6cd4b1aca8e95cd671035a3:

  mmc: mtk-sd: Fix register settings for hs400(es) mode (2025-02-03 13:34:50 +0100)

----------------------------------------------------------------
MMC host:
 - mtk-sd: Fix register settings for hs400(es) mode
 - sdhci_am654: Revert patch for start-signal-voltage-switch

----------------------------------------------------------------
Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Josua Mayer (1):
      Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"

 drivers/mmc/host/mtk-sd.c      | 31 ++++++++++++++++++++-----------
 drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
 2 files changed, 20 insertions(+), 41 deletions(-)

