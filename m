Return-Path: <linux-kernel+bounces-318638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4596F124
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFDCB22234
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5F1C8FD9;
	Fri,  6 Sep 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDachOhz"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C115530C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617702; cv=none; b=U5LIIeBuvBPsixn56YoH5/gGCJpqBoBek9i8PHQYjsWkh1jCNVQ7MSXoSpHSxvAqE2/U/k+9KPiTTA/VV1lgS+qQP48xzfEo7fQm5S4sM9EfdLRl047BotL1Sqg9sexPPbIUFbGgG7vVQVGmzHWtu/FBsQuzTBZIBP6kPqtFCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617702; c=relaxed/simple;
	bh=wbk5c3ZPDtOemUDTmxUQ41pcY+yxLgziWxiOC4juKNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqEZIh20kIs3Kg/JS0Dobu/fRYlSixB10Ah5Y3PNSFOz5ATFLeb6SbD0ld03BR2P4gElcr61l8too6eNDqfFX70yJzrdpN2KRUF0j82gpO+u5RHo2aid4oPolDfOXt3gMHvFSFzi4Cju390qkKXyTnheJFcH0cyzAf+AY5q8GW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDachOhz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3153101e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725617699; x=1726222499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RZ7CTOMIGwkZYZOKOaC4ouB8JKVAiXvcgnN4UjbbG0=;
        b=rDachOhzXRv70N1CZWdBhxckavGOXBLX8l60aCAKp293euM61EnxiEFbeDNOCxby22
         Ks09THjrYT8zbT8MeTZu+s9E2LHOMk77XhesSj35rSnT7p230lRT8xWUY+b4oyO1/BpJ
         AdUG1QJpBsAaWSmz4/Kn/oPtkBeBsVWlnUfZ5B1UcX1XNO5smk0Oe38rfCLfhkqX/RXf
         Wd3webpDcrK27ZPQex6swtbbvNW3R2qiZCnai5CgHP3Ad2gAk6idW/e76YyrQuOqdV4p
         s7TPBV5MSnQPDkSBTLPDp01u9cSJZTfpQ/88OOIca7tp744l7uxqUpM91nyRr3Iod6TF
         4uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617699; x=1726222499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RZ7CTOMIGwkZYZOKOaC4ouB8JKVAiXvcgnN4UjbbG0=;
        b=j2ojcJNvKh0LKgl0AsjX0P2qPmwu734bUrKs1rCSMkJzavvCuz/7L9iKV5N6r072+i
         2Q50iJE9BO0NC6TkL+oJtOKeMypAv8jo0ak+nfycrJgd4IWHs0jEc4yBSfxwb5u1H6jx
         N/6mlXmP53zxdVoFmbeP1Di2ZqPZUioKU9KobzmCrCFky6iz8rVhnw2RZqWC2Qb3bR9Y
         mXBloZ7jHwQ+V27DwhI0pLraTp1Yz3VKvD1lNS9pkvxF1byLzMfeRajR4zka0htS2l/w
         3wxAErqYR1ZKrn1xlVXfu5l+CVzgJZztBNqRZSOm5A6jzoxzDjFkxIFLrFTb+onElHLo
         fCjw==
X-Forwarded-Encrypted: i=1; AJvYcCUtpL3X4eDmF1Mll/CHp5AcPFG8UgjSCX6QJwRtYmBDq7VqwaFLloT0eQcL5P29C5UlONOKogQxRi+7dYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkNaK/rZBLXsQ3bm3gErS7rUF1cHUDK2IGZ+JtO71HdjJfjFk
	Y9ghmuOzeVoDQW9r5ns3b6JW5hPJxvq9hnTxXdmniC/inklitmJKX33jdHOM3iqV/BKxcC/YaBl
	V
X-Google-Smtp-Source: AGHT+IHfAyHUNM1NELI3OmTm0r5vomgEimByZFF2Y77yBcBHbIeBY4L/vPo3i7/vbYSpVqnm22Pzaw==
X-Received: by 2002:a05:6512:1599:b0:536:55a9:caf0 with SMTP id 2adb3069b0e04-5365856cc8amr1250895e87.0.1725617698306;
        Fri, 06 Sep 2024 03:14:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53652bd3dc3sm391663e87.29.2024.09.06.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:14:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.11-rc7
Date: Fri,  6 Sep 2024 12:14:56 +0200
Message-Id: <20240906101456.198887-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.11-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc5

for you to fetch changes up to aea62c744a9ae2a8247c54ec42138405216414da:

  mmc: cqhci: Fix checking of CQHCI_HALT state (2024-09-03 14:20:51 +0200)

----------------------------------------------------------------
MMC core:
 - Apply SD quirks earlier during probe so they become relevant

MMC host:
 - cqhci: Fix checking of CQHCI_HALT state
 - dw_mmc: Fix IDMAC operation with pages bigger than 4K
 - sdhci-of-aspeed: Fix module autoloading

----------------------------------------------------------------
Jonathan Bell (1):
      mmc: core: apply SD quirks earlier during probe

Liao Chen (1):
      mmc: sdhci-of-aspeed: fix module autoloading

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

 drivers/mmc/core/quirks.h          | 22 +++++++++++++---------
 drivers/mmc/core/sd.c              |  4 ++++
 drivers/mmc/host/cqhci-core.c      |  2 +-
 drivers/mmc/host/dw_mmc.c          |  4 ++--
 drivers/mmc/host/sdhci-of-aspeed.c |  1 +
 5 files changed, 21 insertions(+), 12 deletions(-)

