Return-Path: <linux-kernel+bounces-250786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DB92FCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39405283F37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B1F172BCC;
	Fri, 12 Jul 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="synOcHlc"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE98172791
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795504; cv=none; b=Mez7O97GF/ovT+CnDSp8v0k2MP+s4BfEyK5LMVL+YKSVJALxU6EZoAPv7vpQ39Y3JQP40+JubI+q8cs40czC7RVG2Iv8kLHucRqeWxZVKAwlSESSCk/UONeuWnbZ15TODQkMFUaBR/2SF7UJaMAgIiXYwcMwvqtXLLbWjagcbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795504; c=relaxed/simple;
	bh=+YtTtxGbBziQHCzvi1efpwobTUyygckgfzKma2ANla0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4Rbf3+XJNRN8vHrLL/MCwUfkBJ1Z64vRTR4w1Ms10hu5EEZG742R9OyocZTIBdg0kEmiZNY0umM2XaXUoJRD/6xq0GkOrBE0UwtjtsooWym664ZrWpcIFGp9hOdq2oP6+EXXL2SgIUUi74YgruUdcFNiH/jV10vGJdxkQmKOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=synOcHlc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea33671ffso2157544e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720795500; x=1721400300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHPNyb/tJ1VWWeymMmdH4zoCwAXbQXpyF4Qjg1xHg1Q=;
        b=synOcHlcnT58Lgj4kLkkPAwdqnEZ4+c14qb0s41H+Pw7yVE9NqGUy+KFyNhvQcL/UD
         UHPTUSulAcv262xIu6NzRmk2ypx8jYUhYuTtunWAiLoRfNn6D5mXOSyC4odSpJtMUMnn
         qCGbi+FBQJALGpa4tzUeJ3lXvmUQFMiP2sHHCgZ3lwNAbv/4ZWRaeJnynHAyighvx+/T
         0t2tlPYT/9AaLFSfyofXfilRaOnP+2t+HzQZsTDj/OuO3AGFoVQCSdaxIYRyV/DFMdof
         PSlr9UR8I01QA9cQae/Rf09iKNG2z3/8uKiByWqSjRHD/Hc4gohUjgFdSmoNRilK+plU
         yd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720795500; x=1721400300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHPNyb/tJ1VWWeymMmdH4zoCwAXbQXpyF4Qjg1xHg1Q=;
        b=PxT12B88H9wSchJn8Z508Xh6PJfLf3UFSIiErNLX65Pfnx2ZGPTfyt81LjNuEiq3GK
         /RgLDe27+PMWi2/RDsrSLEVwVNkd6kruFXfkUxeK9kr7R0dayK8TN5gSHHxtUJFvrWwa
         GB7H2Xm5pRDy+kh87UThyXnADDatBHOiYN4Bw7t72V3IRNtAxqMPCAsSFVUaN+IATUtq
         M4aMRYUsnW4wJX6wL9uqMkNIdHAPchSZ150lAY0yzPnfLcqNT5sOdLcRZbmwK/PBkREw
         bNh2bp3jXrJ3aBwpbR6w1lIMJdRmsCUGa8RYBkR5MEMNsy4szlYRjfHqibSgTAdLcTu2
         LbNA==
X-Forwarded-Encrypted: i=1; AJvYcCUXWtiHIIlcYk/Dc0qya89u6tD2XhLbEQEl4WmlY0R2PtpvFfSsTO7heGwezXbI4xeZ3+SYNHuUlW6ZFUWole2ndrXcZn6za1aaTPu0
X-Gm-Message-State: AOJu0Yzk44oExTqgf+LsdUkscs8h6hjPcjHrbM3Ow2LGcR0qE5dlEygF
	j/FCm/gvJ0uc4AygM05nqlBrDkrj/MXl1gVtN8mioxVTymyJUXpoElChIrHKk1s=
X-Google-Smtp-Source: AGHT+IGzE/OcadTjDAGe2TP8Cuo9c94sqsqcU4eLkqtdPUECgrzsl+GfWxtdin0klh12Cy8BNzpK3Q==
X-Received: by 2002:ac2:46e5:0:b0:52e:7684:a385 with SMTP id 2adb3069b0e04-52eb99d3265mr6232252e87.52.1720795499568;
        Fri, 12 Jul 2024 07:44:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb906e739sm1293862e87.252.2024.07.12.07.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:44:59 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.10-rc8
Date: Fri, 12 Jul 2024 16:44:57 +0200
Message-Id: <20240712144457.169093-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.10-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ab069ce125965a5e282f7b53b86aee76ab32975c:

  mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro() (2024-06-20 16:42:30 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4-2

for you to fetch changes up to 16198eef11c1929374381d7f6271b4bf6aa44615:

  mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length (2024-07-11 17:48:54 +0200)

----------------------------------------------------------------
MMC host:
 - davinci_mmc: Prevent transmitted data size from exceeding sgm's length
 - sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

Bastien Curutchet (1):
      mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length

 drivers/mmc/host/davinci_mmc.c |  3 +++
 drivers/mmc/host/sdhci.c       | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

