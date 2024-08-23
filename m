Return-Path: <linux-kernel+bounces-298746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE395CB09
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C669D1C21735
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3319917C211;
	Fri, 23 Aug 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmts5GRU"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125A37144
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410386; cv=none; b=Wz523sW9HoHbTVsomJ+g41O36Zq2HW9lO3+N3XxvIEEIwB0tED+pZK0yb98rEfaPesqI3oNhNgaY5wZlDu20jxSEmReDhVR2UIT8kNLsaTZRfq2SZe76KTw4Um4Ji76kxYefWNfF5dFigQeeU2dpiBrzVphKRlDQ4Vdec03XWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410386; c=relaxed/simple;
	bh=biQL3DxblkB3rCUDzcXxatNSH4ag1B0YP2dqEt64H1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJQbicqyYrftyu7xb0b2HsPnTNK6xcG1810pIK5C0E8ixeCl5EfpUuDIVEobdmaZo3RQ1T5YVWH3Cv4E5Yh+AuBtA0J+vE4U8GY9L4oXeRpuGaxZ9MylKFG/7p3PmYnFv/dtubDu9/OmPab+Jz3287nqLCEgA4Zp2jxDc9u20bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmts5GRU; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f406034874so17866741fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724410383; x=1725015183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJwKU3pM+fSGw8xlV5Hp191/V1knUQHDFEo0lS32CeM=;
        b=kmts5GRUXdgIQ8+hRh6T6Ljv1bNM3QtUThYYmBauctI6FA67Vp73SXPj5hmETdsMcY
         9o0SDQcHmIyc15kF2GlcSxf4zTbSYfHF0fmk6XVJ25UoFxiqWp6/S0Uwv7wK3m3tAveg
         Vp4hOGHhy3rEwcqZONJcPz69dANhURlv5eApS6m8j1Iq9fdSOHAVqZAh9Z1ujyHtgILk
         5wk/dzXCH6jV51uU+Bu9tckkjTA0Iph6w4/t54fO1uRX74HXtSqSCYaFTZJs9hLUU8QA
         jsoV8Jp53rqQXjrSpgYedfIy1P5Mj7lUQm74k1tvTPLEym3IlThaHnN6OcXoMWG2xWZT
         86uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410383; x=1725015183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJwKU3pM+fSGw8xlV5Hp191/V1knUQHDFEo0lS32CeM=;
        b=NOt7YzdHwb7ufKQCPdran4t8zt4xbuV36aJMVnjzELiLc4SZxAU+Lx23GSX6HJeiGK
         49pkCOqc1NpAOl7NUswhOLQ9gcFGab6/YO70qUSlt/FenKYfmCZf6oe0JNmGi8rlfnSo
         bJV3h/tsr5sDxXnvNd6NSpOVMgdJ/A0utyV2ELF/FJRn4WHSyz1GHENlz2idBqh6i046
         AEcxhPDAuRBocOHaiWTsOlYqLM0sQKuJHDq1MvjN9Z26Icx3V25uAuZ9yPP/HOntzBOp
         Wp9mPS2PradEao3Rlvqx+ra8TzLmQbODgIXeBE9BLTuTEUksaqXG2cp8eIXvKGEgZctQ
         jHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgyyi5SrWCnnfpxZFfaHqv3zLM59Zt7EwsMx0ZGkFo0raFlaHBNwjKNX63fzgKhAoInC0KwkD+7w9bzlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzLDoFWvRJQ0aWuOEILgsQa1BVtmNQB636HvyrouXEOUap+Je
	2gUjB4oM7MwzpT9IJXhNE5EgPT6ENP43xnpYipOrJgMkNQsdVOg7/+5PcDOcVLyl5JrFdiE+pr9
	5
X-Google-Smtp-Source: AGHT+IEan/GnR/OKjKnkJkJvShhmZs9A9iwIWvtwinNMbLwzGGPZOx7tGcSf6waNVy1TKMCbtcWO7w==
X-Received: by 2002:a2e:4e12:0:b0:2ee:4dc6:fe28 with SMTP id 38308e7fff4ca-2f4f49423e9mr12196731fa.40.1724410382750;
        Fri, 23 Aug 2024 03:53:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4048acb0bsm4623061fa.125.2024.08.23.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:53:02 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.11-rc5
Date: Fri, 23 Aug 2024 12:53:01 +0200
Message-Id: <20240823105301.397397-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.11-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc1

for you to fetch changes up to a1e627af32ed60713941cbfc8075d44cad07f6dd:

  mmc: mmc_test: Fix NULL dereference on allocation failure (2024-08-20 13:47:36 +0200)

----------------------------------------------------------------
MMC core:
 - Fix NULL dereference for mmc_test on allocation failure

MMC host:
 - dw_mmc: Fix support for deferred probe for biu/ciu clocks
 - mtk-sd: Fix CMD8 support when fragile tuning settings

----------------------------------------------------------------
Ben Whitten (1):
      mmc: dw_mmc: allow biu and ciu clocks to defer

Dan Carpenter (1):
      mmc: mmc_test: Fix NULL dereference on allocation failure

Mengqi Zhang (1):
      mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

 drivers/mmc/core/mmc_test.c | 9 +++++----
 drivers/mmc/host/dw_mmc.c   | 8 ++++++++
 drivers/mmc/host/mtk-sd.c   | 8 ++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

