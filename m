Return-Path: <linux-kernel+bounces-569843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC49A6A869
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255951888C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1F2AD16;
	Thu, 20 Mar 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aaq+pKyC"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663341DF25C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480188; cv=none; b=hUVur9Sj20QCFG5t5VkbWiP6Qs5RQ9PSIb2Ily8YxFNzy8teh+k6JQtmfOCi3tUAvLNgpiHJkQuAl4nI5sJy392T7pKJmyLHRcGvIJlcnrdf80fd/fnOfZEqhgXMmLqdA4r3pHqlqWLCRL43920jwy00iEB38cgyUzW2c1K3a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480188; c=relaxed/simple;
	bh=BG7oXm8HfnNGRZ+BgKfaO795/z90fQRMwxeOL+t6m1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQPJgcJI2l06tbPuyCbthyKVAVqz5/5+cXStPPkiZD2lOwJJhPHeh0sSCUHhsn2u82WqRBMaZa/hHJxA3Jnl07nmUQ4fCI0bkmFqpC6Iv03bCA2qed5E/Qj2eIe5bVk6BGjmqoUFZ3IolulQgsrOFZx3ksFmOqCo4AJJOBKz2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aaq+pKyC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfed67e08so9999471fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480184; x=1743084984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiuwvxdAhCBLo6Y0nk402oGwzDCK0nUCR/MeYHjI7FQ=;
        b=aaq+pKyC3GwcCj6hmyd/mndnt3vLZ0Bcew+vEPZvml/WjzGWVBi3KC3quSLEGpHFa5
         rocEjkThEM5l9YBT4DSuBaPywskSwLKsYOLqOBa/jpJZPxfhiN/54vMcRru1G795dsq6
         1RJvH2sk4jJN1WQ5UZv1m6kYoQuKZyqA1tfMyTDI+TCCpQvlBANvsWXObUbv8bXApUdP
         uMSFolZBc4ckEIJDGR68OtGJ5fBxhUn9fObdsBZ/UpjGnsNtFM62sazihVCgl/eNSN91
         uAAwhAKOt8S1JBwzcnMtf/E6Eog/nbEVEL0zOhpsI2qn7BN/poAhN43X+6ogbwPHogrO
         YQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480184; x=1743084984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiuwvxdAhCBLo6Y0nk402oGwzDCK0nUCR/MeYHjI7FQ=;
        b=Bxsf0Mjfm/+5gc892/zcDxbTVQc8Rn6tWQ3ZZrMxKt3eJ0UAo2Z+jNKyDUTaUgkfsK
         9P91jPTD4CUWm9ud9Y/XfSPVt8+ABpL4s11+vBS48B6WhVpbgqG/gVxos9Fe46x/r0mt
         oSA9UQHiNmTl+nixxG2ZZoc1VUQVDNQwiWMa2rKYDRcaIprjfer9QWEqfiHdF4sF6Alu
         kmls/aMP17n9mAbnEzqT2q6CX1DDKAmedA+377Y/yOWocn38EXGfMxmlze6JS3CHrmZX
         RZpwsAD0baXnh5uY+OpzzIT7AdEo0NlaujGghH+eZfwFoFP3Fo/QyARqlzNqcPKithEx
         hylw==
X-Forwarded-Encrypted: i=1; AJvYcCXlq4SjS22pwSrekax4WaR0XqNPjgssyF2btZ6zbHD+ROFhPOHeNW3NJOEcaLwMIByIYmmlc96VDrUDVoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0xJo5GDQ/etb0nhu+gVdoXnE7sLVKq7TnK2TfUzfvjO4nwA5
	MFoVoDcI7S2p12wA7bTYu2icDz0HEFXdq8977cISiwFOQwFC+LW3pogoFvBQyJc=
X-Gm-Gg: ASbGncu5+R3Wy1qOV0dZ8GZpaj+HL3V/rtSxCsijAc4FvGYb8rPuCLq1tJzfTGR9o4w
	7bVenZZ6XD9rZbwAE1RIi/HDso3UnM//qp8XMDB6hA9yFhKNe+85d3MGcYzEcOOj0G88fQDziqQ
	skFuPSXbctseKfsQFBeWCi1s7MlCzt/lxc0ZN7f3gOgaj/dxWuxujkEsJ44zxVJGS7fV478HSAs
	BQHk8vBgyT1G+jb4Q3H/wnoqadgq27HWAe3Q+yCwSuccV/Kxy2aUv/EtI1LZtA7jKEmisKO0VGw
	3V/FLywP60NsFcEdRhR9ZITAFs9Tzp9KtTXVYsBVC9AbQuQledDiywHDBMtlrsbGYpLmpHnW/ac
	hgawZnHYXAf3mfT+nLj0=
X-Google-Smtp-Source: AGHT+IGq6ZMnqynS/LyosQzximB2DC5hiOhKm5mcuHaUP+x5dJQDT/ew7HjON49ahwTkD2EY/GpYaQ==
X-Received: by 2002:a05:6512:693:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-54acb21a725mr2921834e87.46.1742480184315;
        Thu, 20 Mar 2025 07:16:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864e24sm2267110e87.107.2025.03.20.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:16:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.14-rc8
Date: Thu, 20 Mar 2025 15:16:21 +0100
Message-ID: <20250320141621.164515-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc4

for you to fetch changes up to 723ef0e20dbb2aa1b5406d2bb75374fc48187daa:

  mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops (2025-03-17 11:42:42 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-brcmstb: Fix CQE suspend/resume support
 - atmel-mci: Add a missing clk_disable_unprepare() in ->probe()

----------------------------------------------------------------
Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

 drivers/mmc/host/atmel-mci.c     |  4 +++-
 drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

